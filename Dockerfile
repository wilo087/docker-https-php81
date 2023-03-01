FROM alpine:3.17.2
WORKDIR /var/www/localhost/htdocs

RUN apk update; \
  apk add --no-cache apache2 \
  php-apache2 \
  apache2-proxy \
  apache2-ssl \
  apache2-utils \
  curl \
  unzip \
  gcc \
  musl-dev \
  libnsl \
  libaio \
  autoconf \
  make \
  tzdata

# Install php dependecies
RUN apk add php \
php-gd \ 
php-mysqli \
php-zlib \
php-curl \
php-pear \
php-openssl \
php-pdo_mysql \
php-mysqli \
# php-mcrypt \
php-session \
php-simplexml \
php-json \
php-xmlreader \
php-imap \
php-mbstring \
php-phar \
php-intl \
php-opcache
# php-dev \
# php-apcu \
# php-xmlwriter


# Add my own php config.
RUN ln -sf /var/www/localhost/htdocs/env/config/php.ini /etc/php81/conf.d/
RUN ln -sf /var/www/localhost/htdocs/env/config/apache.conf /etc/apache2/conf.d/

RUN rm -rf /tmp/*.zip /var/cache/apk/* /tmp/oracle-sdk
RUN apk del unzip make curl

RUN echo "Mutex posixsem" >> /etc/apache2/apache2.conf

EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
