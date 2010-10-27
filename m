From: mduft@s01en22.salomon.at
Subject: [PATCH 2/2] add configure checks for previously created feature flags
Date: Wed, 27 Oct 2010 10:39:53 +0200
Message-ID: <1288168793-11159-3-git-send-email-markus.duft@salomon.at>
References: <1288168793-11159-1-git-send-email-markus.duft@salomon.at>
Cc: Markus Duft <mduft@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 10:41:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB1Zp-0006u8-Ax
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 10:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0J0IlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 04:41:24 -0400
Received: from smtp.salomon.at ([193.186.16.13]:54059 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754699Ab0J0IlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 04:41:23 -0400
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id o9R8fGhB021088;
	Wed, 27 Oct 2010 10:41:17 +0200 (METDST)
Received: from s01en22 ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 27 Oct 2010 10:41:16 +0200
Received: by s01en22 (sSMTP sendmail emulation); Wed, 27 Oct 2010 10:40:04 +0200
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1288168793-11159-1-git-send-email-markus.duft@salomon.at>
X-OriginalArrivalTime: 27 Oct 2010 08:41:16.0138 (UTC) FILETIME=[B7F92CA0:01CB75B2]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160029>

From: Markus Duft <mduft@gentoo.org>

 *) add check for sys/poll.h. define NO_SYS_POLL_H otherwise.
 *) add check for inttypes.h, define NO_INTTYPES_H otherwise.
 *) add check for initgroups(), define NO_INITGROUPS otherwise.

Signed-off-by: Markus Duft <mduft@gentoo.org>
---
 configure.ac |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index cc55b6d..c5bc9a0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -617,6 +617,18 @@ AC_CHECK_HEADER([sys/select.h],
 [NO_SYS_SELECT_H=UnfortunatelyYes])
 AC_SUBST(NO_SYS_SELECT_H)
 #
+# Define NO_SYS_POLL_H if you don't have sys/poll.h
+AC_CHECK_HEADER([sys/poll.h],
+[NO_SYS_POLL_H=],
+[NO_SYS_POLL_H=UnfortunatelyYes])
+AC_SUBST(NO_SYS_POLL_H)
+#
+# Define NO_INTTYPES_H if you don't have inttypes.h
+AC_CHECK_HEADER([inttypes.h],
+[NO_INTTYPES_H=],
+[NO_INTTYPES_H=UnfortunatelyYes])
+AC_SUBST(NO_INTTYPES_H)
+#
 # Define OLD_ICONV if your library has an old iconv(), where the second
 # (input buffer pointer) parameter is declared with type (const char **).
 AC_DEFUN([OLDICONVTEST_SRC], [[
@@ -868,6 +880,12 @@ GIT_CHECK_FUNC(mkstemps,
 [NO_MKSTEMPS=YesPlease])
 AC_SUBST(NO_MKSTEMPS)
 #
+# Define NO_INITGROUPS if you don't have initgroups in the C library.
+GIT_CHECK_FUNC(initgroups,
+[NO_INITGROUPS=],
+[NO_INITGROUPS=YesPlease])
+AC_SUBST(NO_INITGROUPS)
+#
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
-- 
1.7.2.2
