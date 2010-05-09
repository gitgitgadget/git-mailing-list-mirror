From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [Patch 001/GSoC] Move static files into subdir
Date: Sun, 9 May 2010 19:26:30 +0530
Message-ID: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 09 15:56:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB6zm-0005iL-Hs
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 15:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0EIN4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 09:56:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39176 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab0EIN4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 09:56:31 -0400
Received: by gwj19 with SMTP id 19so1479823gwj.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=+6rAhDcQNUP3E9Jlah681STfqvgIVN97nXmSn7rQLxM=;
        b=OaYcMNJIG08TTkCQorIBFS+osKrJXwRf74UbYT9BDLG7dcYB07Y+0JL3YwofuVTFdz
         L4Krmds6hcutT4C7u9YJYaLi0voNBn9VRq7dkkJ3ekNocKn2diFda+JJBX7u20NPP1zy
         5B3uQisrSqpE5kCWBV+PLpl4oHMdG5FeFkLms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pjDWoXGd+PyhQMmr/taX6EGItfQ3eQtdOB80IjjWwrR0WOW/kUaRAbAI9Dh2gn3/Y1
         JMtRjkCGIMDXwIdeHmO9P/wYzTJxcKiw4zlV8MYhZAQI2VzTvwm5xkA5aUy989vv0gRO
         iLpce1y4xSQ6MEZbaccmxAXOuJajEPgbHy++U=
Received: by 10.90.19.23 with SMTP id 23mr1376776ags.8.1273413390086; Sun, 09 
	May 2010 06:56:30 -0700 (PDT)
Received: by 10.90.63.14 with HTTP; Sun, 9 May 2010 06:56:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146724>

Hi,

It's been a while I mail to this list since I got GSoC. But I have
been in contact with Christian and Petr (mentors) everyday. As I am
having my vacation, I decided to statrt the project earlier itself.
Here's is my first patch in the process of my GSoC.

One of my project goals is to split gitweb. This patch initiates the splitting.

PATCH:

>From e25db0b62b481e029354ad33af8f0615a8353633 Mon Sep 17 00:00:00 2001
From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Date: Wed, 5 May 2010 21:44:57 -0700
Subject: [PATCH] Gitweb: Move all static files into a seperate directory

This commit creates a new subdirectory called 'static' in gitweb
which will contain all the static files required by gitweb.cgi
while executing. By doing so, the gitweb source will be more
readable and maintainable.

Also changed INSTALL, README, Makefile and test files
according to this change.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/INSTALL                      |   20 ++++++++++----------
 gitweb/Makefile                     |   20 ++++++++++----------
 gitweb/README                       |    8 ++++----
 gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
 gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
 gitweb/{ => static}/gitweb.css      |    0
 gitweb/{ => static}/gitweb.js       |    0
 t/gitweb-lib.sh                     |    6 +++---
 8 files changed, 27 insertions(+), 27 deletions(-)
 rename gitweb/{ => static}/git-favicon.png (100%)
 rename gitweb/{ => static}/git-logo.png (100%)
 rename gitweb/{ => static}/gitweb.css (100%)
 rename gitweb/{ => static}/gitweb.js (100%)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index cbdc136..60c25ff 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -7,7 +7,8 @@ gitweb.css, git-logo.png and git-favicon.png) to their
destination.
 For example if git was (or is) installed with /usr prefix, you can do

 	$ make prefix=/usr gitweb             ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
+	# cp gitweb/gitweb.cgi /var/www/cgi-bin/   ;# as root
+	# cp -r gitweb/static /var/www/cgi-bin/    ;# as root

 Alternatively you can use autoconf generated ./configure script to
 set up path to git binaries (via config.mak.autogen), so you can write
@@ -16,7 +17,8 @@ instead
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
 	$ make gitweb                        ;# as yourself
-	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
+	# cp gitweb/gitweb.cgi /var/www/cgi-bin/   ;# as root
+	# cp -r gitweb/static /var/www/cgi-bin/    ;# as root

 The above example assumes that your web server is configured to run
 [executable] files in /var/www/cgi-bin/ as server scripts (as CGI
@@ -79,17 +81,15 @@ Build example
   we want to display are under /home/local/scm, you can do

 	make GITWEB_PROJECTROOT="/home/local/scm" \
-	     GITWEB_JS="/gitweb/gitweb.js" \
-	     GITWEB_CSS="/gitweb/gitweb.css" \
-	     GITWEB_LOGO="/gitweb/git-logo.png" \
-	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
+	     GITWEB_JS="/gitweb/static/gitweb.js" \
+	     GITWEB_CSS="/gitweb/static/gitweb.css" \
+	     GITWEB_LOGO="/gitweb/static/git-logo.png" \
+	     GITWEB_FAVICON="/gitweb/static/git-favicon.png" \
 	     bindir=/usr/local/bin \
 	     gitweb

-	cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
-	       ~/git/gitweb/git-{favicon,logo}.png \
-	     /var/www/cgi-bin/gitweb/
-
+	cp -fv gitweb/gitweb.cgi /var/www/cgi-bin/gitweb/
+	cp -r gitweb/static /var/www/cgi-bin/gitweb/

 Gitweb config file
 ------------------
diff --git a/gitweb/Makefile b/gitweb/Makefile
index f2e1d92..c0d5da3 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -26,10 +26,10 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
-GITWEB_CSS = gitweb.css
-GITWEB_LOGO = git-logo.png
-GITWEB_FAVICON = git-favicon.png
-GITWEB_JS = gitweb.js
+GITWEB_CSS = static/gitweb.css
+GITWEB_LOGO = static/git-logo.png
+GITWEB_FAVICON = static/git-favicon.png
+GITWEB_JS = static/gitweb.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =

@@ -81,16 +81,16 @@ endif
 all:: gitweb.cgi

 ifdef JSMIN
-GITWEB_JS = gitweb.min.js
-all:: gitweb.min.js
-gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
+GITWEB_JS = static/gitweb.min.js
+all:: static/gitweb.min.js
+static/gitweb.min.js: static/gitweb.js GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif

 ifdef CSSMIN
-GITWEB_CSS = gitweb.min.css
-all:: gitweb.min.css
-gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
+GITWEB_CSS = static/gitweb.min.css
+all:: static/gitweb.min.css
+static/gitweb.min.css: static/gitweb.css GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(CSSMIN) <$ >$@
 endif

diff --git a/gitweb/README b/gitweb/README
index 71742b3..eeac204 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -80,23 +80,23 @@ You can specify the following configuration
variables when building GIT:
    Points to the location where you put gitweb.css on your web server
    (or to be more generic, the URI of gitweb stylesheet).  Relative to the
    base URI of gitweb.  Note that you can setup multiple stylesheets from
-   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
+   the gitweb config file.  [Default: static/gitweb.css (or
gitweb.min.css if the
    CSSMIN variable is defined / CSS minifier is used)]
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server
    (or to be more generic URI of logo, 72x27 size, displayed in top right
    corner of each gitweb page, and used as logo for Atom feed).  Relative
-   to base URI of gitweb.  [Default: git-logo.png]
+   to base URI of gitweb.  [Default: static/git-logo.png]
  * GITWEB_FAVICON
    Points to the location where you put git-favicon.png on your web server
    (or to be more generic URI of favicon, assumed to be image/png type;
    web browsers that support favicons (website icons) may display them
    in the browser's URL bar and next to site name in bookmarks).  Relative
-   to base URI of gitweb.  [Default: git-favicon.png]
+   to base URI of gitweb.  [Default: static/git-favicon.png]
  * GITWEB_JS
    Points to the localtion where you put gitweb.js on your web server
    (or to be more generic URI of JavaScript code used by gitweb).
-   Relative to base URI of gitweb.  [Default: gitweb.js (or gitweb.min.js
+   Relative to base URI of gitweb.  [Default: static/gitweb.js (or
gitweb.min.js
    if JSMIN build variable is defined / JavaScript minifier is used)]
  * GITWEB_CONFIG
    This Perl file will be loaded using 'do' and can be used to override any
diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
similarity index 100%
rename from gitweb/gitweb.css
rename to gitweb/static/gitweb.css
diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
similarity index 100%
rename from gitweb/gitweb.js
rename to gitweb/static/gitweb.js
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 5a734b1..b70b891 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -19,9 +19,9 @@ our \$site_name = '[localhost]';
 our \$site_header = '';
 our \$site_footer = '';
 our \$home_text = 'indextext.html';
-our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/gitweb.css');
-our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/git-logo.png';
-our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/git-favicon.png';
+our @stylesheets = ('file:///$TEST_DIRECTORY/../gitweb/static/gitweb.css');
+our \$logo = 'file:///$TEST_DIRECTORY/../gitweb/static/git-logo.png';
+our \$favicon = 'file:///$TEST_DIRECTORY/../gitweb/static/git-favicon.png';
 our \$projects_list = '';
 our \$export_ok = '';
 our \$strict_export = '';
-- 
1.7.0.4
