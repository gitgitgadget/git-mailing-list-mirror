From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2 3/7] autoconf: remove some redundant shell indirections
Date: Thu, 19 Jul 2012 09:49:58 +0200
Message-ID: <edc192e0d37b96c3c7727bd19e4cd3979b579574.1342683786.git.stefano.lattarini@gmail.com>
References: <7vy5mgvb6f.fsf@alter.siamese.dyndns.org>
 <cover.1342683786.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 09:50:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrlVF-0006oN-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 09:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab2GSHuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 03:50:24 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55322 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab2GSHuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 03:50:20 -0400
Received: by bkwj10 with SMTP id j10so2137760bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Td+sKY/+vBevQ0bh4gyFZZP5+9wFPoQDNECrAFY4nuw=;
        b=J3z5Pnfkm9ACanYZoX7Y2QenIRGhf/n7xuYS8kikiIwyDzKcfujxC/BWo8bfCXL9Kh
         ygwYK3u3spbENTIKyy4oakGB9WV/M5mbz1GgNxkJYwO233DnqefXlTSBdkuqmdWmz9VN
         R7l8/Pi5/5/r+Q3RqpFhFuUK15FLsVaGVx30YgAsN3VPPaZ5H+fq80p1mdhWLrx6G/Pc
         /zxhcCbPdsWz/cFQt4ZxfKwE6iZeExx30M75Ci2iM8Fu/4Y4VIdX6lljwRM1mITpv/5l
         S5B8KFQbFqG75aa7Js43YayHf1eCmx6L49Gse/nYqmZR2IvMIEzck9TTq+RYRId9ZOuK
         FCJQ==
Received: by 10.204.148.86 with SMTP id o22mr290621bkv.59.1342684219283;
        Thu, 19 Jul 2012 00:50:19 -0700 (PDT)
Received: from localhost.localdomain (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id c18sm430224bkv.8.2012.07.19.00.50.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 00:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.1067.g553d16e
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
In-Reply-To: <cover.1342683786.git.stefano.lattarini@gmail.com>
References: <cover.1342683786.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201722>

They are merely useless now, but would get in the way of future changes.

No semantic change is intended.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 configure.ac | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 02b9a49..200776f 100644
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
+		GIT_CONF_SUBST(GIT_UC_PROGRAM[]_PATH, [])
 	else
 		AC_MSG_ERROR([You cannot use git without $1])
 	fi
@@ -45,7 +44,7 @@ AC_DEFUN([GIT_CONF_APPEND_PATH],
 	else
 		GIT_UC_PROGRAM[]_PATH=$withval
 		AC_MSG_NOTICE([Setting GIT_UC_PROGRAM[]_PATH to $withval])
-		GIT_CONF_SUBST([${PROGRAM}_PATH], [$withval])
+		GIT_CONF_SUBST(GIT_UC_PROGRAM[]_PATH, [$withval])
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
