From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 1/7] autoconf: GIT_CONF_APPEND_LINE: change signature
Date: Thu, 19 Jul 2012 00:34:56 +0200
Message-ID: <eb5c979d7334a2fb8f0bd1d6bedf7c21b811cbb3.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:35:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srcq6-00056I-7t
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328Ab2GRWfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:22 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63398 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab2GRWfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:20 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1790594wgb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=JlfLgiP7sq0TscTOASmUu76bsbugPcHnuN5CPKmrcgc=;
        b=HwgE+oxm/WkR56tiPeQm5NWn08V11henestqhCnPl69XivFgjL+LgHY/WYR494VuVs
         C3SMAB4cNXQUPkVpeUKGJZreUU9yuH7ALHl8xb82eHh5f7TgZ5NnTWVPI8pIfLJ1VMla
         eSg2X+1R8nHivrlI7Ggeu8mo2QnfYtsgjDiMilc22rB5UnPbyZZ2CnBOkb9xa7oYDoAP
         vtzBNAcnUDuhk45WEQsp7omOXKQZl2AyGfpSH0FEsmcgWFAuQ5h1Qo0MX0dS1UFO5tSf
         z2Ke9CuKWAR9KX08HSV0gHf7eBpK9n8vCuozUmrkhDPNc5ygep5OTM4k1ItbA28nwrD5
         z0Mw==
Received: by 10.216.136.230 with SMTP id w80mr1538955wei.199.1342650919984;
        Wed, 18 Jul 2012 15:35:19 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201697>

From:

   GIT_CONF_APPEND_LINE([VAR=VAL])

to:

   GIT_CONF_APPEND_LINE([VAR], [VAL])

This is only a preparatory change in view of future refactorings.
No semantic change is intended.  In fact, the generated configure
file doesn't change at all.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4e9012f..14c7960 100644
--- a/configure.ac
+++ b/configure.ac
@@ -7,7 +7,7 @@
 # --------------------------
 # Append LINE to file ${config_append}
 AC_DEFUN([GIT_CONF_APPEND_LINE],
-         [echo "$1" >> "${config_append}"])
+         [echo "$1=$2" >> "${config_append}"])
 
 # GIT_ARG_SET_PATH(PROGRAM)
 # -------------------------
@@ -34,8 +34,8 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	if test -n "$2"; then
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Disabling use of ${PROGRAM}])
-		GIT_CONF_APPEND_LINE(NO_${PROGRAM}=YesPlease)
-		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=)
+		GIT_CONF_APPEND_LINE([NO_${PROGRAM}], [YesPlease])
+		GIT_CONF_APPEND_LINE([${PROGRAM}_PATH], [])
 	else
 		AC_MSG_ERROR([You cannot use git without $1])
 	fi
@@ -45,7 +45,7 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	else
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
-		GIT_CONF_APPEND_LINE(${PROGRAM}_PATH=$withval)
+		GIT_CONF_APPEND_LINE([${PROGRAM}_PATH], [$withval])
 	fi
     fi
     m4_popdef([GIT_UC_PROGRAM])])
@@ -67,7 +67,7 @@ AC_DEFUN([GIT_PARSE_WITH],
 	NO_[]GIT_UC_PACKAGE=
 	GIT_UC_PACKAGE[]DIR=$withval
 	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
-	GIT_CONF_APPEND_LINE(${PACKAGE}DIR=$withval)
+	GIT_CONF_APPEND_LINE([${PACKAGE}DIR], [$withval])
     fi
     m4_popdef([GIT_UC_PACKAGE])])
 
@@ -87,7 +87,7 @@ AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
 		     [a value for $1 ($2).  Maybe you do...?])
   fi
   AC_MSG_NOTICE([Setting $2 to $withval])
-  GIT_CONF_APPEND_LINE($2=$withval)
+  GIT_CONF_APPEND_LINE([$2], [$withval])
  fi)])# GIT_PARSE_WITH_SET_MAKE_VAR
 
 #
@@ -150,7 +150,7 @@ AC_ARG_WITH([sane-tool-path],
   else
     AC_MSG_NOTICE([Setting SANE_TOOL_PATH to '$withval'])
   fi
-  GIT_CONF_APPEND_LINE([SANE_TOOL_PATH=$withval])],
+  GIT_CONF_APPEND_LINE([SANE_TOOL_PATH], [$withval])],
   [# If the "--with-sane-tool-path" option was not given, don't touch
    # SANE_TOOL_PATH here, but let defaults in Makefile take care of it.
    # This should minimize spurious differences in the behaviour of the
@@ -169,7 +169,7 @@ AC_ARG_WITH([lib],
   else
 	lib=$withval
 	AC_MSG_NOTICE([Setting lib to '$lib'])
-	GIT_CONF_APPEND_LINE(lib=$withval)
+	GIT_CONF_APPEND_LINE([lib], [$withval])
   fi])
 
 if test -z "$lib"; then
@@ -205,7 +205,7 @@ AC_ARG_ENABLE([jsmin],
 [
   JSMIN=$enableval;
   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
-  GIT_CONF_APPEND_LINE(JSMIN=$enableval);
+  GIT_CONF_APPEND_LINE([JSMIN], [$enableval]);
 ])
 
 # Define option to enable CSS minification
@@ -215,7 +215,7 @@ AC_ARG_ENABLE([cssmin],
 [
   CSSMIN=$enableval;
   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
-  GIT_CONF_APPEND_LINE(CSSMIN=$enableval);
+  GIT_CONF_APPEND_LINE([CSSMIN], [$enableval]);
 ])
 
 ## Site configuration (override autodetection)
@@ -256,7 +256,7 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 	USE_LIBPCRE=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $withval])
-	GIT_CONF_APPEND_LINE(LIBPCREDIR=$withval)
+	GIT_CONF_APPEND_LINE([LIBPCREDIR], [$withval])
     fi)
 #
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
-- 
1.7.10.2.1067.g553d16e
