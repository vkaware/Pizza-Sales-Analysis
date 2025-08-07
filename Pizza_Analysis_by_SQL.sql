-- 1. Total Revenue:

SELECT 
    SUM(total_price) AS Total_Revenue
FROM
    pizza_sales;
    

-- 2. Average Order Value

SELECT 
    SUM(total_price) / COUNT(DISTINCT (order_id)) AS Avg_Order_Value
FROM
    pizza_sales;
    

-- 3. Total Pizzas Sold

SELECT 
    SUM(quantity) AS Total_Pizza_Sold
FROM
    pizza_sales;
    

-- 4. Total Orders

SELECT 
    COUNT(DISTINCT(order_id)) AS Total_Orders
FROM
    pizza_sales;
    

-- 5. Average Pizzas Per Order

SELECT 
    SUM(quantity) / COUNT(DISTINCT (order_id)) AS Avg_Pizza_Per_Order
FROM
    pizza_sales;
    

-- B. Daily Trend for Total Orders

SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_Date,
    COUNT(DISTINCT order_id) AS Order_Count
FROM
    pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));


-- C. Monthly Trend for Orders

SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Order_Date,
    COUNT(DISTINCT order_id) AS Order_Count
FROM
    pizza_sales
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));


-- D. % of Sales by Pizza Category

SELECT 
    pizza_category,
    SUM(total_price) * 100 / (SELECT 
            SUM(total_price)
        FROM
            pizza_sales) AS Percentage_of_Sales
FROM
    pizza_sales
GROUP BY pizza_category;


-- E. % of Sales by Pizza Size

SELECT 
    pizza_category,
    SUM(total_price) AS Total_Sales,
    SUM(total_price) * 100 / (SELECT 
            SUM(total_price)
        FROM
            pizza_sales) AS Percentage_of_Sales
FROM
    pizza_sales
WHERE
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_category;


-- F. Total Pizzas Sold by Pizza Category

SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(SUM(total_price) * 100 / (SELECT 
                    SUM(total_price)
                FROM
                    pizza_sales
                WHERE
                    QUARTER(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1),
            2) AS Percentage_of_Sales
FROM
    pizza_sales
WHERE
    QUARTER(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
GROUP BY pizza_size;


-- G. Top 5 Pizzas by Revenue

SELECT 
    pizza_name, SUM(total_price) AS Total_Revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;


-- H. Bottom 5 Pizzas by Revenue

SELECT 
    pizza_name, ROUND(SUM(total_price),2) AS Total_Revenue
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;


-- I. Top 5 Pizzas by Quantity

SELECT 
    pizza_name, SUM(quantity) AS Total_Quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;


-- J. Bottom 5 Pizzas by Quantity

SELECT 
    pizza_name, SUM(quantity) AS Total_Quantity
FROM
    pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
LIMIT 5;


