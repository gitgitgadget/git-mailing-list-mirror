From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH 3/7] autoconf: remove some redundant shell indirections
Date: Thu, 19 Jul 2012 00:34:58 +0200
Message-ID: <4392b87d8e6c73cfa06459a24b1721b8a8e13a81.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 00:35:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrcqL-0005Ub-BV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab2GRWf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:35:28 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39922 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab2GRWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:35:25 -0400
Received: by wgbfm10 with SMTP id fm10so4488425wgb.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=ndX5bkctNKWdRo4eL5g84iRW/6NLR7aw4LS6CZs/m7c=;
        b=03o1pIBiLgBimM3NhIswkkgEmrSE6bAiUi13SiM0JrAQA7SjnOE8etc1Vo/KYZOg4P
         ggjm0ohrNlngUXbO0gAZtoNkOfaYHoGvtDtCDZoSCSwGCRAzDA428GTUQiVBUKfzmWF+
         LQfI+mhW3MPlf/tfBfBknhCMp1O4+Gs2c5OMtoyMXe8tAtQ+d88Sw0a+XdtXaMu7qamx
         ylto07ltzUwWCeo7kKm0IXlLmISbQkn6BPLBPSacZnEkm+LnpK7tzS5NgjVEOCXU59AY
         LyUUD8U4RuEWCFg1i8p8xQZTr2B0/prUMtnMYDpNnHjiY7+JAKosZLWa/zzIvbMZ12nl
         ZPcQ==
Received: by 10.216.226.78 with SMTP id a56mr587285weq.133.1342650924200;
        Wed, 18 Jul 2012 15:35:24 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id el6sm35011908wib.8.2012.07.18.15.35.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jul 2012 15:35:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342649928.git.stefano.lattarini@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201701>

They are merely useless now, but would get in the way of future changes.

No semantic change is intended.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 789926f..9472f6b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,13 +29,12 @@ AC_DEFUN([GIT_ARG_SET_PATH],
 # --without-PROGRAM is used.
 AC_DEFUN([GIT_CONF_APPEND_PATH],
     [m4_pushdef([GIT_UC_PROGRAM], m4_toupper([$1]))dnl
-    PROGRAM=GIT_UC_PROGRAM
     if test "$withval" = "no"; then
 	if test -n "$2"; then
 		GIT_UC_PROGRAM[]_PATH=$withval
-		AC_MSG_NOTICE([Disabling use of ${PROGRAM}])
-		GIT_CONF_SUBST([NO_${PROGRAM}], [YesPlease])
-		GIT_CONF_SUBST([${PROGRAM}_PATH], [])
+		AC_MSG_NOTICE([Disabling use of GIT_UC_PROGRAM])
+		GIT_CONF_SUBST([NO_]GIT_UC_PROGRAM, [YesPlease])
+		GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [])
 	else
 		AC_MSG_ERROR([You cannot use git without $1])
 	fi
@@ -45,7 +44,7 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	else
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
-		GIT_CONF_SUBST([${PROGRAM}_PATH], [$withval])
+		GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [$withval])
 	fi
     fi
     m4_popdef([GIT_UC_PROGRAM])])
@@ -58,7 +57,6 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 # * Unset NO_PACKAGE for --with-PACKAGE without ARG
 AC_DEFUN([GIT_PARSE_WITH],
     [m4_pushdef([GIT_UC_PACKAGE], m4_toupper([$1]))dnl
-    PACKAGE=GIT_UC_PACKAGE
     if test "$withval" = "no"; then
 	NO_[]GIT_UC_PACKAGE=YesPlease
     elif test "$withval" = "yes"; then
@@ -67,7 +65,7 @@ AC_DEFUN([GIT_PARSE_WITH],
 	NO_[]GIT_UC_PACKAGE=
 	GIT_UC_PACKAGE[]DIR=$withval
 	AC_MSG_NOTICE([Setting GIT_UC_PACKAGE[]DIR to $withval])
-	GIT_CONF_SUBST([${PACKAGE}DIR], [$withval])
+	GIT_CONF_SUBST(GIT_UC_PACKAGE[DIR], [$withval])
     fi
     m4_popdef([GIT_UC_PACKAGE])])
 
-- 
1.7.10.2.1067.g553d16e
