Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FFD211B5
	for <e@80x24.org>; Thu, 24 Jan 2019 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfAXQNt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 11:13:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46354 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXQNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 11:13:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id f5so4685569lfc.13
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 08:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gVcWJWjoI34X7d5YGIFF2yOYkLRzYAdMm5uUbmaIr7A=;
        b=fR8CkmZiTVheUiYtnqkF+Vi9LwrjeOgB8DbgQYpGNJ/8M/HZNdRDppYfCYqnSrxN6F
         ZvjV6ks8fj+Awm/DPF3+u5ti58WaJiQprkO/jORgud31vS3bJ9hNNymRwuGJD9JcaQIc
         Q6nPYF7bvIYNa2L9L/sr0+ceNeRDNBD6XHoZtv/QmkX2/RPWFdrnF7nkItuV0LXEkkII
         QhVNizQaa28AvPxALKsSEYHPkw8EvUdEZgSiUv8SJeeXKaPRLtEqyuaCTCU7e+fHKLuL
         TnJVFpQWzDD5WOIdZQ7UXiAF8B9I5NTlYj+oA4n/oKthWdUCWovRfX88xZem6p4kqswm
         h90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gVcWJWjoI34X7d5YGIFF2yOYkLRzYAdMm5uUbmaIr7A=;
        b=oTLiP4oxfFrvs0WB+n0AI5o7NeF5wgJieqVZmE5xlLhe0dSX6Sh2LzafCmCvgMNj3J
         BJxlmtcJZgyz7u+Ku1eow3+jveGVJ11Ar2n726uDWjdbnJrPLHm0vY2PlUYlhdKlEGsb
         wnDg/KLExcNVI0SLRHuKSUAaPThwZY0ESUNwZ0DklO/zeUvyEmCMgnGWnQ/Tg4IYSXSY
         JWQBUhaOrzFMv5wZF1/dw8pNUMnXVvF5zyGf/wYjfVulSzJ/gu+Jtg0uzIj4fkWFJ9FE
         k23j/jCmmnB1G7HzcPCLwd9ItEMlOuM7l6kj4it5gScVOvIS0j6tbQ93y1PhVsEcq1M/
         gdcA==
X-Gm-Message-State: AJcUukfFYaStWT9x05ovR/ew9a5irSitbQKo722eHHGiHKkSBsOgZGVL
        Q6tBga7goJnercIK0zmGLnbEetFwTXK1Qw==
X-Google-Smtp-Source: ALg8bN6LDteUwyWeyLJBon6QUnP0v89DSxKkrCBfjxgmDnky3ScaBywSjL0PlQ94+40I4V5vRkdiBQ==
X-Received: by 2002:a19:1bd2:: with SMTP id b201mr5683521lfb.136.1548346425734;
        Thu, 24 Jan 2019 08:13:45 -0800 (PST)
Received: from orav.themis.milrem.lan (134-103-235-80.sta.estpak.ee. [80.235.103.134])
        by smtp.gmail.com with ESMTPSA id y11-v6sm1048896ljc.85.2019.01.24.08.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 08:13:45 -0800 (PST)
From:   Arti Zirk <arti.zirk@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org, peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        wil@nohakostudios.net, Arti Zirk <arti.zirk@gmail.com>
Subject: [PATCH v1] git-instaweb: Add Python builtin http.server support
Date:   Thu, 24 Jan 2019 18:13:31 +0200
Message-Id: <20190124161331.25945-1-arti.zirk@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch it is possible to launch git-instaweb by using
Python 3 http.server CGI handler via `-d python` option.

git-instaweb generates a small wrapper around the http.server
(in GIT_DIR/gitweb/) that address a limitation of the CGI handler
where CGI scripts have to be in a cgi-bin subdirectory and
directory index can't be easily changed. To keep the implementation
small, gitweb is running on url `/cgi-bin/gitweb.cgi` and an automatic
redirection is done when opening `/`.

Python 3 is by default installed on most modern Linux distributions
which enables running `git instaweb -d python` without needing
anything else.

Signed-off-by: Arti Zirk <arti.zirk@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/artizirk/git/commit/a40d28ca58
    Checkout: git fetch https://github.com/artizirk/git instaweb-python-v1 && git checkout a40d28ca58

 Documentation/git-instaweb.txt |   3 +-
 git-instaweb.sh                | 114 ++++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

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
index eec264e630..c8f9f03447 100755
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
@@ -595,6 +602,108 @@ EOF
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
+	# generate a standalone 'python3 http.server' script in $fqgitdir/gitweb
+	# This asumes that python3 is in user's $PATH
+	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
+#!/usr/bin/env python3
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
+from http.server import CGIHTTPRequestHandler, test
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
+		super().do_HEAD()
+
+	def do_GET(self):
+		if self.path == "/":
+			self.send_response(303, "See Other")
+			self.send_header("Location", "/cgi-bin/gitweb.cgi")
+			self.end_headers()
+			return
+		self.redirect_path()
+		super().do_GET()
+
+	def do_POST(self):
+		self.redirect_path()
+		super().do_POST()
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
+			result = super().is_cgi()
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
+test(HandlerClass=GitWebRequestHandler, port=$port, bind=bind)
+EOF
+
+	chmod a+x "$fqgitdir/gitweb/gitweb.py"
+}
+
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
 #!@@PERL@@
@@ -623,6 +732,9 @@ configure_httpd() {
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

