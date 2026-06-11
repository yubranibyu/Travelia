-- ==========================================
-- TRAVELIA DATABASE SCHEMA
-- ==========================================

DROP TABLE IF EXISTS favorites CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS bookings CASCADE;
DROP TABLE IF EXISTS properties CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ==========================================
-- USERS
-- ==========================================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) DEFAULT 'guest',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- CATEGORIES
-- ==========================================

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    image_url TEXT
);

-- ==========================================
-- PROPERTIES
-- ==========================================

CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    country VARCHAR(100),
    price_per_night NUMERIC(10,2),
    guests INTEGER,
    bedrooms INTEGER,
    bathrooms INTEGER,
    image_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- BOOKINGS
-- ==========================================

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    total_price NUMERIC(10,2),
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- REVIEWS
-- ==========================================

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- FAVORITES
-- ==========================================

CREATE TABLE favorites (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    property_id INTEGER REFERENCES properties(id) ON DELETE CASCADE
);

-- ==========================================
-- SEED DATA
-- ==========================================

-- USERS

INSERT INTO users (
    full_name,
    email,
    password_hash,
    role
)
VALUES
(
    'Admin User',
    'admin@travelia.com',
    'hashedpassword',
    'admin'
),
(
    'John Smith',
    'john@example.com',
    'hashedpassword',
    'guest'
),
(
    'Maria Silva',
    'maria@example.com',
    'hashedpassword',
    'host'
),
(
    'Carlos Oliveira',
    'carlos@example.com',
    'hashedpassword',
    'host'
);

-- CATEGORIES

INSERT INTO categories (
    name,
    image_url
)
VALUES
(
    'Beach',
    '/images/categories/beach.jpg'
),
(
    'Mountain',
    '/images/categories/mountain.jpg'
),
(
    'City',
    '/images/categories/city.jpg'
),
(
    'Countryside',
    '/images/categories/countryside.jpg'
),
(
    'Luxury',
    '/images/categories/luxury.jpg'
),
(
    'Cabin',
    '/images/categories/cabin.jpg'
);

-- PROPERTIES

INSERT INTO properties (
    owner_id,
    category_id,
    title,
    description,
    location,
    country,
    price_per_night,
    guests,
    bedrooms,
    bathrooms,
    image_url
)
VALUES
(
    3,
    1,
    'Ocean Paradise Villa',
    'Luxury villa with private beach access.',
    'Rio de Janeiro',
    'Brazil',
    350.00,
    8,
    4,
    3,
    '/images/properties/beach-villa.jpg'
),
(
    4,
    2,
    'Mountain Escape Cabin',
    'Peaceful cabin surrounded by nature.',
    'Gramado',
    'Brazil',
    180.00,
    4,
    2,
    1,
    '/images/properties/cabin.jpg'
),
(
    3,
    3,
    'Modern Downtown Apartment',
    'Apartment located in the city center.',
    'São Paulo',
    'Brazil',
    120.00,
    2,
    1,
    1,
    '/images/properties/apartment.jpg'
),
(
    4,
    5,
    'Luxury Penthouse',
    'Premium penthouse with skyline views.',
    'Curitiba',
    'Brazil',
    450.00,
    6,
    3,
    2,
    '/images/properties/penthouse.jpg'
),
(
    3,
    6,
    'Forest Retreat',
    'Cabin hidden in the woods.',
    'Canela',
    'Brazil',
    160.00,
    4,
    2,
    1,
    '/images/properties/forest-cabin.jpg'
);

-- BOOKINGS

INSERT INTO bookings (
    user_id,
    property_id,
    check_in,
    check_out,
    total_price,
    status
)
VALUES
(
    2,
    1,
    '2026-07-10',
    '2026-07-15',
    1750.00,
    'confirmed'
),
(
    2,
    3,
    '2026-08-05',
    '2026-08-10',
    600.00,
    'pending'
);

-- REVIEWS

INSERT INTO reviews (
    user_id,
    property_id,
    rating,
    comment
)
VALUES
(
    2,
    1,
    5,
    'Amazing place and excellent service.'
),
(
    2,
    3,
    4,
    'Great location and clean apartment.'
);

-- FAVORITES

INSERT INTO favorites (
    user_id,
    property_id
)
VALUES
(
    2,
    1
),
(
    2,
    4
),
(
    2,
    5
);

-- ==========================================
-- VERIFICATION QUERIES
-- ==========================================

SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM properties;
SELECT * FROM bookings;
SELECT * FROM reviews;
SELECT * FROM favorites;