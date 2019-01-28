Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6F2211B5
	for <e@80x24.org>; Mon, 28 Jan 2019 13:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfA1N37 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 08:29:59 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46430 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfA1N36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 08:29:58 -0500
Received: by mail-lj1-f172.google.com with SMTP id v15-v6so14178445ljh.13
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UF0p3tqzOEPpvyffgWF2w859fvOZOP0QTUIKZdNj7Ec=;
        b=I46nOKoq8o83wihz4Qh/tjw1pzvtkjIzCqeONsoEcgRoUJBQfeDS/yl01dG8GA7toO
         6f4EcNyIPgNVWqh3mBLTkJ1eYXIeX+v29lEOb8bL3FjO+Q/941mwt+YPq7dTYEvqIZJU
         7wJz9sCtIdKziqSS1LAULXfSaCkh7FDzVMM+R3wHP9ejtXktCjtMQCw9rcqdEm9Xj95B
         v4Z8uQ7aW53x1oKSJuj9jfdIPij4ry20bNXXo2Gwaf7UlFRFc15TJp/Qp5gUE3jgjqHj
         estC8rfBKu49PMona9c/IwFgMUwnPiXj8cZcQycTt4KtyAoQQYr5Qkchi8xGaG9iLnwW
         +Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UF0p3tqzOEPpvyffgWF2w859fvOZOP0QTUIKZdNj7Ec=;
        b=dLUv3vbLIU15Xtt+eMpc3fyAOJUPRL1NKMOMX51XMEgZdOGisjxMy2irLR0fN96WZv
         5iIDy21ZBM7oZkYpyuTiJ33LL+oEKKm28LK0kyYI7BY3joPFEUY0kuhzbgWGkbOi83bk
         an/epQrbkiqXCEkLKeBRTrEWwRU2PIKoxWzP82fCkvi/5M0keOFommgmMi13qATodZyj
         +fMEihCSco3vE3bdbE6SOldQ7BeeBaKwzeL635YhwvR3WPpc9py8xW+WvekgIcu854cw
         sgzrJXPqRMAG9L9xwRWB4HEH2hkA5SpkMQbJD0mmWXQvbrWgV4Jx4nb77fZ3xocfT71O
         ovdA==
X-Gm-Message-State: AJcUukfCi1kY5U0sMtoLNlk83HD0x+6h3PPsmFK1oxfFQ3iQ//TxYM9o
        TyN56kCXeD/sQyoTo55IRHJfNuOaAiz7bA==
X-Google-Smtp-Source: ALg8bN5UZSTgvj6dI6q+6y1MXXcqxdIXtRLzGtSbrcYC2N07IYu4YZpRleRawTUfqKbZlEvzL89Omg==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr16851017ljj.108.1548682195104;
        Mon, 28 Jan 2019 05:29:55 -0800 (PST)
Received: from orav.themis.milrem.lan (134-103-235-80.sta.estpak.ee. [80.235.103.134])
        by smtp.gmail.com with ESMTPSA id r203sm2839887lff.13.2019.01.28.05.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 05:29:54 -0800 (PST)
From:   Arti Zirk <arti.zirk@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org, peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        gitster@pobox.com, sandals@crustytoothpaste.net,
        Arti Zirk <arti.zirk@gmail.com>
Subject: [PATCH v2] git-instaweb: Add Python builtin http.server support
Date:   Mon, 28 Jan 2019 15:24:59 +0200
Message-Id: <20190128132458.31401-1-arti.zirk@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124161331.25945-1-arti.zirk@gmail.com>
References: <20190124161331.25945-1-arti.zirk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch it is possible to launch git-instaweb by using
Python http.server CGI handler via `-d python` option.

git-instaweb generates a small wrapper around the http.server
(in GIT_DIR/gitweb/) that address a limitation of the CGI handler
where CGI scripts have to be in a cgi-bin subdirectory and
directory index can't be easily changed. To keep the implementation
small, gitweb is running on url `/cgi-bin/gitweb.cgi` and an automatic
redirection is done when opening `/`.

The generated wrapper is compatible with both Python 2 and 3.

Python is by default installed on most modern Linux distributions
which enables running `git instaweb -d python` without needing
anything else.

Signed-off-by: Arti Zirk <arti.zirk@gmail.com>
---

Changes v1..v2:
 - Add compatibily for Python 2, tested with 2.7, 3.4, 3.5, 3.6, 3.7


Notes:
    Base Ref: master
    Web-Diff: https://github.com/artizirk/git/commit/fe30635765
    Checkout: git fetch https://github.com/artizirk/git instaweb-python-v2 && git checkout fe30635765

    ### Interdiff (v1..v2):

    diff --git a/git-instaweb.sh b/git-instaweb.sh
    index c8f9f03447..7c55229773 100755
    --- a/git-instaweb.sh
    +++ b/git-instaweb.sh
    @@ -614,10 +614,11 @@ python_conf() {
     	ln -sf "$root/gitweb.cgi" "$fqgitdir/gitweb/$httpd_only/cgi-bin/gitweb.cgi"
     	ln -sf "$root/static" "$fqgitdir/gitweb/$httpd_only/"

    -	# generate a standalone 'python3 http.server' script in $fqgitdir/gitweb
    -	# This asumes that python3 is in user's $PATH
    +	# generate a standalone 'python http.server' script in $fqgitdir/gitweb
    +	# This asumes that python is in user's $PATH
    +	# This script is Python 2 and 3 compatible
     	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
    -#!/usr/bin/env python3
    +#!/usr/bin/env python
     import os
     import sys

    @@ -639,7 +640,14 @@ os.dup2(errorlogfile.fileno(), _orig_stderr_fd)
     sys.stderr = errorlogfile

     from functools import partial
    -from http.server import CGIHTTPRequestHandler, test
    +
    +if sys.version_info < (3, 0):  # Python 2
    +	from CGIHTTPServer import CGIHTTPRequestHandler
    +	from BaseHTTPServer import HTTPServer as ServerClass
    +else:  # Python 3
    +	from http.server import CGIHTTPRequestHandler
    +	from http.server import HTTPServer as ServerClass
    +

     # Those environment variables will be passed to the cgi script
     os.environ.update({
    @@ -660,7 +668,7 @@ class GitWebRequestHandler(CGIHTTPRequestHandler):

     	def do_HEAD(self):
     		self.redirect_path()
    -		super().do_HEAD()
    +		CGIHTTPRequestHandler.do_HEAD(self)

     	def do_GET(self):
     		if self.path == "/":
    @@ -669,11 +677,11 @@ class GitWebRequestHandler(CGIHTTPRequestHandler):
     			self.end_headers()
     			return
     		self.redirect_path()
    -		super().do_GET()
    +		CGIHTTPRequestHandler.do_GET(self)

     	def do_POST(self):
     		self.redirect_path()
    -		super().do_POST()
    +		CGIHTTPRequestHandler.do_POST(self)

     	# rewrite path of every request that is not gitweb.cgi to out of cgi-bin
     	def redirect_path(self):
    @@ -685,7 +693,7 @@ class GitWebRequestHandler(CGIHTTPRequestHandler):
     	def is_cgi(self):
     		result = False
     		if self.path.startswith('/cgi-bin/gitweb.cgi'):
    -			result = super().is_cgi()
    +			result = CGIHTTPRequestHandler.is_cgi(self)
     		return result

    @@ -698,7 +706,12 @@ if "$local" == "true":
     # as this was added to SimpleHTTPRequestHandler in Python 3.7
     os.chdir("$fqgitdir/gitweb/$httpd_only/")

    -test(HandlerClass=GitWebRequestHandler, port=$port, bind=bind)
    +GitWebRequestHandler.protocol_version = "HTTP/1.0"
    +httpd = ServerClass((bind, $port), GitWebRequestHandler)
    +
    +sa = httpd.socket.getsockname()
    +print("Serving HTTP on", sa[0], "port", sa[1], "...")
    +httpd.serve_forever()
     EOF

     	chmod a+x "$fqgitdir/gitweb/gitweb.py"

    ### Patches

 Documentation/git-instaweb.txt |   3 +-
 git-instaweb.sh                | 127 ++++++++++++++++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index e8ecdbf927..a54fe4401b 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -29,7 +29,8 @@ OPTIONS
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
-	Currently apache2, lighttpd, mongoose, plackup and webrick are supported.
+	Currently apache2, lighttpd, mongoose, plackup, python and
+	webrick are supported.
 	(Default: lighttpd)

 -m::
diff --git a/git-instaweb.sh b/git-instaweb.sh
index eec264e630..7c55229773 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -67,6 +67,13 @@ resolve_full_httpd () {
 		httpd_only="${httpd%% *}" # cut on first space
 		return
 		;;
+	*python*)
+		# server is started by running via generated gitweb.py in
+		# $fqgitdir/gitweb
+		full_httpd="$fqgitdir/gitweb/gitweb.py"
+		httpd_only="${httpd%% *}" # cut on first space
+		return
+		;;
 	esac

 	httpd_only="$(echo $httpd | cut -f1 -d' ')"
@@ -110,7 +117,7 @@ start_httpd () {

 	# don't quote $full_httpd, there can be arguments to it (-f)
 	case "$httpd" in
-	*mongoose*|*plackup*)
+	*mongoose*|*plackup*|*python*)
 		#These servers don't have a daemon mode so we'll have to fork it
 		$full_httpd "$conf" &
 		#Save the pid before doing anything else (we'll print it later)
@@ -595,6 +602,121 @@ EOF
 	rm -f "$conf"
 }

+python_conf() {
+	# Python's builtin http.server and its CGI support is very limited.
+	# CGI handler is capable of running CGI script only from inside a directory.
+	# Trying to set cgi_directories=["/"] will add double slash to SCRIPT_NAME
+	# and that in turn breaks gitweb's relative link generation.
+
+	# create a simple web root where $fqgitdir/gitweb/$httpd_only is our root
+	mkdir -p "$fqgitdir/gitweb/$httpd_only/cgi-bin"
+	# Python http.server follows the symlinks
+	ln -sf "$root/gitweb.cgi" "$fqgitdir/gitweb/$httpd_only/cgi-bin/gitweb.cgi"
+	ln -sf "$root/static" "$fqgitdir/gitweb/$httpd_only/"
+
+	# generate a standalone 'python http.server' script in $fqgitdir/gitweb
+	# This asumes that python is in user's $PATH
+	# This script is Python 2 and 3 compatible
+	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
+#!/usr/bin/env python
+import os
+import sys
+
+# Open log file in line buffering mode
+accesslogfile = open("$fqgitdir/gitweb/access.log", 'a', buffering=1)
+errorlogfile = open("$fqgitdir/gitweb/error.log", 'a', buffering=1)
+
+# and replace our stdout and stderr with log files
+# also do a lowlevel duplicate of the logfile file descriptors so that
+# our CGI child process writes any stderr warning also to the log file
+_orig_stdout_fd = sys.stdout.fileno()
+sys.stdout.close()
+os.dup2(accesslogfile.fileno(), _orig_stdout_fd)
+sys.stdout = accesslogfile
+
+_orig_stderr_fd = sys.stderr.fileno()
+sys.stderr.close()
+os.dup2(errorlogfile.fileno(), _orig_stderr_fd)
+sys.stderr = errorlogfile
+
+from functools import partial
+
+if sys.version_info < (3, 0):  # Python 2
+	from CGIHTTPServer import CGIHTTPRequestHandler
+	from BaseHTTPServer import HTTPServer as ServerClass
+else:  # Python 3
+	from http.server import CGIHTTPRequestHandler
+	from http.server import HTTPServer as ServerClass
+
+
+# Those environment variables will be passed to the cgi script
+os.environ.update({
+	"GIT_EXEC_PATH": "$GIT_EXEC_PATH",
+	"GIT_DIR": "$GIT_DIR",
+	"GITWEB_CONFIG": "$GITWEB_CONFIG"
+})
+
+
+class GitWebRequestHandler(CGIHTTPRequestHandler):
+
+	def log_message(self, format, *args):
+		# Write access logs to stdout
+		sys.stdout.write("%s - - [%s] %s\n" %
+				(self.address_string(),
+				self.log_date_time_string(),
+				format%args))
+
+	def do_HEAD(self):
+		self.redirect_path()
+		CGIHTTPRequestHandler.do_HEAD(self)
+
+	def do_GET(self):
+		if self.path == "/":
+			self.send_response(303, "See Other")
+			self.send_header("Location", "/cgi-bin/gitweb.cgi")
+			self.end_headers()
+			return
+		self.redirect_path()
+		CGIHTTPRequestHandler.do_GET(self)
+
+	def do_POST(self):
+		self.redirect_path()
+		CGIHTTPRequestHandler.do_POST(self)
+
+	# rewrite path of every request that is not gitweb.cgi to out of cgi-bin
+	def redirect_path(self):
+		if not self.path.startswith("/cgi-bin/gitweb.cgi"):
+			self.path = self.path.replace("/cgi-bin/", "/")
+
+	# gitweb.cgi is the only thing that is ever going to be run here.
+	# Ignore everything else
+	def is_cgi(self):
+		result = False
+		if self.path.startswith('/cgi-bin/gitweb.cgi'):
+			result = CGIHTTPRequestHandler.is_cgi(self)
+		return result
+
+
+bind = "127.0.0.1"
+if "$local" == "true":
+	bind = "0.0.0.0"
+
+# Set our http root directory
+# This is a work around for a missing directory argument in older Python versions
+# as this was added to SimpleHTTPRequestHandler in Python 3.7
+os.chdir("$fqgitdir/gitweb/$httpd_only/")
+
+GitWebRequestHandler.protocol_version = "HTTP/1.0"
+httpd = ServerClass((bind, $port), GitWebRequestHandler)
+
+sa = httpd.socket.getsockname()
+print("Serving HTTP on", sa[0], "port", sa[1], "...")
+httpd.serve_forever()
+EOF
+
+	chmod a+x "$fqgitdir/gitweb/gitweb.py"
+}
+
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
 #!@@PERL@@
@@ -623,6 +745,9 @@ configure_httpd() {
 	*plackup*)
 		plackup_conf
 		;;
+	*python*)
+		python_conf
+		;;
 	*)
 		echo "Unknown httpd specified: $httpd"
 		exit 1

base-commit: 16a465bc018d09e9d7bbbdc5f40a7fb99c21f8ef
--
2.20.1
