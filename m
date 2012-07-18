From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 2/7] autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
Date: Thu, 19 Jul 2012 00:34:57 +0200
Message-ID: <5c4e73c3bed1a7c9135a6229d8d66aa2c61e319a.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrcqK-0005Ub-5G
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab2GRWfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59123 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab2GRWfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:24 -0400
Received: by weyx8 with SMTP id x8so1272200wey.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=tt1yH3h8lyhULh3VtXA9TwBv5rH7bLzCefuSIkaVlrw=;
        b=cvJNnYImPzK8VXO0pOGlNTchaCghNUfvCqB8GJ7emtPNufNNPsPIc006iUHBKOoKW+
         3yvqFqgdKi2ab/KpYpqy+IqWoj1yH/EH+4FP5E9tH2Ga6SP3D3T9FnEKZj5OQIP2N5Dd
         qJ1t6TwK9uf9TYz8QMeriJO9QWrVDkZSwhqSetKb7x5F0tCQ/TsOGpgCV+7kFERDaCsi
         O7uvMcqgHCJ8t0yhKX5Anyq6NnOJkLBZXHE+OFhtcY2Z3X7IAgXkiLNWRSnaApG/0tCh
         Fpg7vc7oYIYF/c+9lhCHzD5IWAHdAyUTtwFiLA1TWNPlWWa8papHdlenGh6HOgfZY2Rc
         7aRQ==
Received: by 10.216.101.68 with SMTP id a46mr560051weg.120.1342650922287;
        Wed, 18 Jul 2012 15:35:22 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201700>

The new name fits better with the macro signature, and underlines the
similarities with the autoconf-provided macro AC_SUBST (which will be
made even more pronounced in planned future commits).

Once again, no semantic change is intended, and indeed no change to the
generated configure script is expected.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 14c7960..789926f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,10 +3,10 @@
 
 ## Definitions of private macros.
 
-# GIT_CONF_APPEND_LINE(LINE)
+# GIT_CONF_SUBST(LINE)
 # --------------------------
 # Append LINE to file ${config_append}
-AC_DEFUN([GIT_CONF_APPEND_LINE],
+AC_DEFUN([GIT_CONF_SUBST],
          [echo "$1=$2" >> "${config_append}"])
 
 # GIT_ARG_SET_PATH(PROGRAM)
@@ -34,8 +34,8 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	if test -n "$2"; then
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Disabling use of ${PROGRAM}])
-		GIT_CONF_APPEND_LINE([NO_${PROGRAM}], [YesPlease])
-		GIT_CONF_APPEND_LINE([${PROGRAM}_PATH], [])
+		GIT_CONF_SUBST([NO_${PROGRAM}], [YesPlease])
+		GIT_CONF_SUBST([${PROGRAM}_PATH], [])
 	else
 		AC_MSG_ERROR([You cannot use git without $1])
 	fi
@@ -45,7 +45,7 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	else
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
-		GIT_CONF_APPEND_LINE([${PROGRAM}_PATH], [$withval])
+		GIT_CONF_SUBST([${PROGRAM}_PATH], [$withval])
 	fi
     fi
     m4_popdef([GIT_UC_PROGRAM])])
@@ -67,7 +67,7 @@ AC_DEFUN([GIT_PARSE_WITH],
 	NO_[]GIT_UC_PACKAGE=
 	GIT_UC_PACKAGE[]DIR=$withval
 	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
-	GIT_CONF_APPEND_LINE([${PACKAGE}DIR], [$withval])
+	GIT_CONF_SUBST([${PACKAGE}DIR], [$withval])
     fi
     m4_popdef([GIT_UC_PACKAGE])])
 
@@ -87,7 +87,7 @@ AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
 		     [a value for $1 ($2).  Maybe you do...?])
   fi
   AC_MSG_NOTICE([Setting $2 to $withval])
-  GIT_CONF_APPEND_LINE([$2], [$withval])
+  GIT_CONF_SUBST([$2], [$withval])
  fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
 
 #
@@ -150,7 +150,7 @@ AC_ARG_WITH([sane-tool-path],
   else
     AC_MSG_NOTICE([Setting SANE_TOOL_PATH to '$withval'])
   fi
-  GIT_CONF_APPEND_LINE([SANE_TOOL_PATH], [$withval])],
+  GIT_CONF_SUBST([SANE_TOOL_PATH], [$withval])],
   [# If the "--with-sane-tool-path" option was not given, don't touch
    # SANE_TOOL_PATH here, but let defaults in Makefile take care of it.
    # This should minimize spurious differences in the behaviour of the
@@ -169,7 +169,7 @@ AC_ARG_WITH([lib],
   else
 	lib=$withval
 	AC_MSG_NOTICE([Setting lib to '$lib'])
-	GIT_CONF_APPEND_LINE([lib], [$withval])
+	GIT_CONF_SUBST([lib], [$withval])
   fi])
 
 if test -z "$lib"; then
@@ -205,7 +205,7 @@ AC_ARG_ENABLE([jsmin],
 [
   JSMIN=$enableval;
   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
-  GIT_CONF_APPEND_LINE([JSMIN], [$enableval]);
+  GIT_CONF_SUBST([JSMIN], [$enableval]);
 ])
 
 # Define option to enable CSS minification
@@ -215,7 +215,7 @@ AC_ARG_ENABLE([cssmin],
 [
   CSSMIN=$enableval;
   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
-  GIT_CONF_APPEND_LINE([CSSMIN], [$enableval]);
+  GIT_CONF_SUBST([CSSMIN], [$enableval]);
 ])
 
 ## Site configuration (override autodetection)
@@ -256,7 +256,7 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 	USE_LIBPCRE=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval])
-	GIT_CONF_APPEND_LINE([LIBPCREDIR], [$withval])
+	GIT_CONF_SUBST([LIBPCREDIR], [$withval])
     fi)
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
-- 
1.7.10.2.1067.g553d16e
