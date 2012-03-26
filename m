From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 3/3] configure: be more idiomatic
Date: Mon, 26 Mar 2012 18:42:26 +0200
Message-ID: <4f748fad9d486ead05836e339414b5b5901ef61d.1332779755.git.stefano.lattarini@gmail.com>
References: <cover.1331333479.git.stefano.lattarini@gmail.com>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 18:43:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCD0b-00016W-PH
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab2CZQms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 12:42:48 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45699 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932938Ab2CZQmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:42:46 -0400
Received: by mail-ey0-f174.google.com with SMTP id q12so1592623eaa.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Q95F1izsmtIrvbDOQI1W2PyjLBEesbxt73xtGIDBR1k=;
        b=H7A4uYYC8LoTYI6OL+HE9oaPQiH242ye1Y5FRCDBofUgHX6HzIIMTY9p1riHGbwK3l
         C94muRcYcZiYKZEnMiOUipR81EwVjk4r8BQD64zvWTX0z5OMlvNMahn0ZVhbEO9yFmKz
         pvBk8uTHw7QUfZtabZcMnKWBHSkxZAS2hm0V9OQp04U6LXgEM5i3MRO0GZrSgTXMjNRp
         PFBcuRIQ3eEii5TELqzCZ/Ixvqt9sxlLsituc/B9YLhEBvSPTQjFUXkLdVYo5MfKdj0M
         wskZmDW5fib+ehdYJZ4O/wfo6ceiE3oQiiJdflrgfSL1M+N0s0KJhxdMN3QTUwyjDrvk
         oCkg==
Received: by 10.14.187.4 with SMTP id x4mr3118437eem.14.1332780164955;
        Mon, 26 Mar 2012 09:42:44 -0700 (PDT)
Received: from localhost.localdomain (host210-95-dynamic.0-87-r.retail.telecomitalia.it. [87.0.95.210])
        by mx.google.com with ESMTPS id p57sm60152731eei.8.2012.03.26.09.42.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 09:42:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <cover.1331333479.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1332779754.git.stefano.lattarini@gmail.com>
References: <cover.1332779754.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193929>

Lots of code in Git's configure.ac doesn't follow the typical formatting,
idioms and best practices for Autoconf input files.  Improve the situation.

There are probably many more similar improvements to be done, but trying
to clump all of them in a single change would make it unreviewable, so we
content ourselves with a partial improvement.

This change is just cosmetic, and should cause no semantic change.

The most relevant of the changes introduced by this patch are:

 - Do not add trailing '\' characters for line continuation where they
   are not truly needed.

 - In several (but not all) macro calls, properly quote the arguments.

 - Few cosmetic changes in spacing and comments.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac |  176 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 87 insertions(+), 89 deletions(-)

diff --git a/configure.ac b/configure.ac
index e888601..e125550 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,54 +1,55 @@
 #                                               -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
 
-## Definitions of macros
+## Definitions of private macros.
+
 # GIT_CONF_APPEND_LINE(LINE)
 # --------------------------
 # Append LINE to file ${config_append}
 AC_DEFUN([GIT_CONF_APPEND_LINE],
-[echo "$1" >> "${config_append}"])# GIT_CONF_APPEND_LINE
-#
+         [echo "$1" >> "${config_append}"])
+
 # GIT_ARG_SET_PATH(PROGRAM)
 # -------------------------
 # Provide --with-PROGRAM=PATH option to set PATH to PROGRAM
 # Optional second argument allows setting NO_PROGRAM=YesPlease if
 # --without-PROGRAM version used.
 AC_DEFUN([GIT_ARG_SET_PATH],
-[AC_ARG_WITH([$1],
- [AS_HELP_STRING([--with-$1=PATH],
-                 [provide PATH to $1])],
- [GIT_CONF_APPEND_PATH($1,$2)],[])
-])# GIT_ARG_SET_PATH
-#
+    [AC_ARG_WITH([$1],
+        [AS_HELP_STRING([--with-$1=PATH],
+                        [provide PATH to $1])],
+        [GIT_CONF_APPEND_PATH([$1], [$2])],
+        [])])
+
 # GIT_CONF_APPEND_PATH(PROGRAM)
-# ------------------------------
+# -----------------------------
 # Parse --with-PROGRAM=PATH option to set PROGRAM_PATH=PATH
 # Used by GIT_ARG_SET_PATH(PROGRAM)
 # Optional second argument allows setting NO_PROGRAM=YesPlease if
 # --without-PROGRAM is used.
 AC_DEFUN([GIT_CONF_APPEND_PATH],
-[m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
-PROGRAM=GIT_UC_PROGRAM; \
-if test "$withval" = "no"; then \
-	if test -n "$2"; then \
-		GIT_UC_PROGRAM[]_PATH=$withval; \
-		AC_MSG_NOTICE([Disabling use of ${PROGRAM}]); \
-		GIT_CONF_APPEND_LINE(NO_${PROGRAM}=YesPlease); \
-		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=); \
-	else \
-		AC_MSG_ERROR([You cannot use git without $1]); \
-	fi; \
-else \
-	if test "$withval" = "yes"; then \
-		AC_MSG_WARN([You should provide path for --with-$1=PATH]); \
-	else \
-		GIT_UC_PROGRAM[]_PATH=$withval; \
-		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval]); \
-		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval); \
-	fi; \
-fi; \
-m4_popdef([GIT_UC_PROGRAM])]) # GIT_CONF_APPEND_PATH
-#
+    [m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
+    PROGRAM=GIT_UC_PROGRAM
+    if test "$withval" = "no"; then
+	if test -n "$2"; then
+		GIT_UC_PROGRAM[]_PATH=$withval
+		AC_MSG_NOTICE([Disabling use of ${PROGRAM}])
+		GIT_CONF_APPEND_LINE(NO_${PROGRAM}=YesPlease)
+		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=)
+	else
+		AC_MSG_ERROR([You cannot use git without $1])
+	fi
+    else
+	if test "$withval" = "yes"; then
+		AC_MSG_WARN([You should provide path for --with-$1=PATH])
+	else
+		GIT_UC_PROGRAM[]_PATH=$withval
+		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
+		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval)
+	fi
+    fi
+    m4_popdef([GIT_UC_PROGRAM])])
+
 # GIT_PARSE_WITH(PACKAGE)
 # -----------------------
 # For use in AC_ARG_WITH action-if-found, for packages default ON.
@@ -56,22 +57,22 @@ m4_popdef([GIT_UC_PROGRAM])]) # GIT_CONF_APPEND_PATH
 # * Set PACKAGEDIR=PATH for --with-PACKAGE=PATH
 # * Unset NO_PACKAGE for --with-PACKAGE without ARG
 AC_DEFUN([GIT_PARSE_WITH],
-[m4_pushdef([GIT_UC_PACKAGE], m4_toupper([$1]))dnl
-PACKAGE=GIT_UC_PACKAGE; \
-if test "$withval" = "no"; then \
-	NO_[]GIT_UC_PACKAGE=YesPlease; \
-elif test "$withval" = "yes"; then \
-	NO_[]GIT_UC_PACKAGE=; \
-else \
-	NO_[]GIT_UC_PACKAGE=; \
-	GIT_UC_PACKAGE[]DIR=$withval; \
-	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval]); \
-	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval); \
-fi \
-m4_popdef([GIT_UC_PACKAGE])]) # GIT_PARSE_WITH
-#
+    [m4_pushdef([GIT_UC_PACKAGE], m4_toupper([$1]))dnl
+    PACKAGE=GIT_UC_PACKAGE
+    if test "$withval" = "no"; then
+	NO_[]GIT_UC_PACKAGE=YesPlease
+    elif test "$withval" = "yes"; then
+	NO_[]GIT_UC_PACKAGE=
+    else
+	NO_[]GIT_UC_PACKAGE=
+	GIT_UC_PACKAGE[]DIR=$withval
+	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
+	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval)
+    fi
+    m4_popdef([GIT_UC_PACKAGE])])
+
 # GIT_PARSE_WITH_SET_MAKE_VAR(WITHNAME, VAR, HELP_TEXT)
-# ---------------------
+# -----------------------------------------------------
 # Set VAR to the value specied by --with-WITHNAME.
 # No verification of arguments is performed, but warnings are issued
 # if either 'yes' or 'no' is specified.
@@ -80,33 +81,32 @@ m4_popdef([GIT_UC_PACKAGE])]) # GIT_PARSE_WITH
 AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
 [AC_ARG_WITH([$1],
  [AS_HELP_STRING([--with-$1=VALUE], $3)],
- if test -n "$withval"; then \
-  if test "$withval" = "yes" -o "$withval" = "no"; then \
+ if test -n "$withval"; then
+  if test "$withval" = "yes" -o "$withval" = "no"; then
     AC_MSG_WARN([You likely do not want either 'yes' or 'no' as]
-		     [a value for $1 ($2).  Maybe you do...?]); \
-  fi; \
-  \
-  AC_MSG_NOTICE([Setting $2 to $withval]); \
-  GIT_CONF_APPEND_LINE($2=$withval); \
+		     [a value for $1 ($2).  Maybe you do...?])
+  fi
+  AC_MSG_NOTICE([Setting $2 to $withval])
+  GIT_CONF_APPEND_LINE($2=$withval)
  fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
 
-dnl
-dnl GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
-dnl -----------------------------------------
-dnl Similar to AC_CHECK_FUNC, but on systems that do not generate
-dnl warnings for missing prototypes (e.g. FreeBSD when compiling without
-dnl -Wall), it does not work.  By looking for function definition in
-dnl libraries, this problem can be worked around.
+#
+# GIT_CHECK_FUNC(FUNCTION, IFTRUE, IFFALSE)
+# -----------------------------------------
+# Similar to AC_CHECK_FUNC, but on systems that do not generate
+# warnings for missing prototypes (e.g. FreeBSD when compiling without
+# -Wall), it does not work.  By looking for function definition in
+# libraries, this problem can be worked around.
 AC_DEFUN([GIT_CHECK_FUNC],[AC_CHECK_FUNC([$1],[
   AC_SEARCH_LIBS([$1],,
   [$2],[$3])
 ],[$3])])
 
-dnl
-dnl GIT_STASH_FLAGS(BASEPATH_VAR)
-dnl -----------------------------
-dnl Allow for easy stashing of LDFLAGS and CPPFLAGS before running
-dnl tests that may want to take user settings into account.
+#
+# GIT_STASH_FLAGS(BASEPATH_VAR)
+# -----------------------------
+# Allow for easy stashing of LDFLAGS and CPPFLAGS before running
+# tests that may want to take user settings into account.
 AC_DEFUN([GIT_STASH_FLAGS],[
 if test -n "$1"; then
    old_CPPFLAGS="$CPPFLAGS"
@@ -164,14 +164,13 @@ AC_ARG_WITH([sane-tool-path],
 AC_ARG_WITH([lib],
  [AS_HELP_STRING([--with-lib=ARG],
                  [ARG specifies alternative name for lib directory])],
- [if test "$withval" = "no" || test "$withval" = "yes"; then \
-	AC_MSG_WARN([You should provide name for --with-lib=ARG]); \
-else \
-	lib=$withval; \
-	AC_MSG_NOTICE([Setting lib to '$lib']); \
-	GIT_CONF_APPEND_LINE(lib=$withval); \
-fi; \
-],[])
+ [if test "$withval" = "no" || test "$withval" = "yes"; then
+	AC_MSG_WARN([You should provide name for --with-lib=ARG])
+  else
+	lib=$withval
+	AC_MSG_NOTICE([Setting lib to '$lib'])
+	GIT_CONF_APPEND_LINE(lib=$withval)
+  fi])
 
 if test -z "$lib"; then
    AC_MSG_NOTICE([Setting lib to 'lib' (the default)])
@@ -237,9 +236,9 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # /foo/bar/include and /foo/bar/lib directories.
 AC_ARG_WITH(openssl,
 AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
-AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),\
-GIT_PARSE_WITH(openssl))
-#
+AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),
+GIT_PARSE_WITH([openssl]))
+
 # Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
 # able to use Perl-compatible regular expressions.
 #
@@ -249,17 +248,16 @@ GIT_PARSE_WITH(openssl))
 AC_ARG_WITH(libpcre,
 AS_HELP_STRING([--with-libpcre],[support Perl-compatible regexes (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
-if test "$withval" = "no"; then \
-	USE_LIBPCRE=; \
-elif test "$withval" = "yes"; then \
-	USE_LIBPCRE=YesPlease; \
-else
-	USE_LIBPCRE=YesPlease; \
-	LIBPCREDIR=$withval; \
-	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval]); \
-	GIT_CONF_APPEND_LINE(LIBPCREDIR=$withval); \
-fi \
-)
+    if test "$withval" = "no"; then
+	USE_LIBPCRE=
+    elif test "$withval" = "yes"; then
+	USE_LIBPCRE=YesPlease
+    else
+	USE_LIBPCRE=YesPlease
+	LIBPCREDIR=$withval
+	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval])
+	GIT_CONF_APPEND_LINE(LIBPCREDIR=$withval)
+    fi)
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
@@ -367,7 +365,7 @@ AC_ARG_WITH(tcltk,
 AS_HELP_STRING([--with-tcltk],[use Tcl/Tk GUI (default is YES)])
 AS_HELP_STRING([],[ARG is the full path to the Tcl/Tk interpreter.])
 AS_HELP_STRING([],[Bare --with-tcltk will make the GUI part only if])
-AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),\
+AS_HELP_STRING([],[Tcl/Tk interpreter will be found in a system.]),
 GIT_PARSE_WITH(tcltk))
 #
 
-- 
1.7.9
