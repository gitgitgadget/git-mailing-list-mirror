From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 2/7] autoconf: GIT_CONF_APPEND_LINE -> GIT_CONF_SUBST
Date: Thu, 19 Jul 2012 09:49:57 +0200
Message-ID: <c3181a04d19136962968efd59a3e5b1b70535474.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlVF-0006oN-9j
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab2GSHuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44410 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab2GSHuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:17 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2137707bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=NEefLv08OuEbnslUMrbVZ4ETkj1kX1OhEYIWOMKtj2Y=;
        b=uNoNRhmuhz76QKnrswXMoXu3zc1QrKB9lVhZfCa5elyRWF/12jhn6eYW3IAI22PzGr
         UCSEJPMJk1QLphzXctKJE/lijC0SNH9SKVohofnmU8dCIpz903FyRUy1OwQiE4cWKQy2
         iFmHc92OwRE//vKExZzhqgd04cNGuNDcUywRdSVoTh+EEF8tZYR8TzDmEyF345OvDTA+
         CU534EVvXVFrR/+i647xl+s8JYY29FrT08vo2GV5ezHdLxKv7nhj8126yDT9laboMlmm
         h8l9eqxrnsdOOFUIv2h8BUQyPETWqbGnEZ54jnj2W+IY18Kr341s9vg8dV2HDrI/Mxx5
         ZEjg==
Received: by 10.204.145.90 with SMTP id c26mr291954bkv.34.1342684217175;
        Thu, 19 Jul 2012 00:50:17 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <cover.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201719>

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
index 5f63269..02b9a49 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,8 +3,8 @@
 
 ## Definitions of private macros.
 
-# GIT_CONF_APPEND_LINE(VAL, VAR)
-# ------------------------------
+# GIT_CONF_SUBST(VAL, VAR)
+# ------------------------
 # Append the line "VAR=VAL" to file ${config_append}
 AC_DEFUN([GIT_CONF_APPEND_LINE],
          [echo "$1=$2" >> "${config_append}"])
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
