From: mduft@gentoo.org
Subject: [PATCH] Update the Interix default build configuration.
Date: Wed, 15 Jun 2011 13:34:18 +0200
Message-ID: <1308137658-5509-1-git-send-email-mduft@gentoo.org>
References: <20110615094842.GA16411@elie>
Cc: gitster@pobox.com, Markus Duft <mduft@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 13:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWoJw-0000VK-AN
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 13:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab1FOLbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 07:31:35 -0400
Received: from smtp.salomon.at ([193.186.16.13]:65365 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755054Ab1FOLbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 07:31:34 -0400
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p5FBVOJR000496;
	Wed, 15 Jun 2011 13:31:24 +0200 (METDST)
Received: from s01en22 ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 15 Jun 2011 13:31:22 +0200
Received: by s01en22 (sSMTP sendmail emulation); Wed, 15 Jun 2011 13:34:20 +0200
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <20110615094842.GA16411@elie>
X-OriginalArrivalTime: 15 Jun 2011 11:31:22.0872 (UTC) FILETIME=[C1156F80:01CC2B4F]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175826>

Currently, on Interix, libsuacomp is required for building, see [1].
Since suacomp provides poll() and inttypes.h for all interix versions,
the NO_*=YesPleas are removed.

Interix versions 3 and 5 miss struct sockaddr_storage, so make git
avoid using it.

Same for FNMATCH_CASEFOLD, which does not exist for Interix 3 and 5.

[1] http://news.gmane.org/find-root.php?message_id=%3c4DDF4440.4040405%40gentoo.org%3e

Signed-off-by: Markus Duft <mduft@gentoo.org>
---
 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e40ac0c..2939e8d 100644
--- a/Makefile
+++ b/Makefile
@@ -1124,8 +1124,6 @@ endif
 	X = .exe
 endif
 ifeq ($(uname_S),Interix)
-	NO_SYS_POLL_H = YesPlease
-	NO_INTTYPES_H = YesPlease
 	NO_INITGROUPS = YesPlease
 	NO_IPV6 = YesPlease
 	NO_MEMMEM = YesPlease
@@ -1136,10 +1134,14 @@ ifeq ($(uname_S),Interix)
 	ifeq ($(uname_R),3.5)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_FNMATCH_CASEFOLD = YesPlease
 	endif
 	ifeq ($(uname_R),5.2)
 		NO_INET_NTOP = YesPlease
 		NO_INET_PTON = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_FNMATCH_CASEFOLD = YesPlease
 	endif
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
-- 
1.7.3.4
