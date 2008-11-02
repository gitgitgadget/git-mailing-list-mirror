From: david.syzdek@acsalaska.net
Subject: [PATCH] Make Pthread link flags configurable
Date: Sun,  2 Nov 2008 14:43:20 -0900
Message-ID: <1225669400-79505-1-git-send-email-david.syzdek@acsalaska.net>
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 00:44:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwmcW-0006MR-Mg
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 00:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbYKBXnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 18:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYKBXnX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 18:43:23 -0500
Received: from hermes.acsalaska.net ([209.112.173.230]:51941 "EHLO
	hermes.acsalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbYKBXnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 18:43:22 -0500
Received: from localhost.localdomain (209-193-51-248.static.acsalaska.net [209.193.51.248])
	by hermes.acsalaska.net (8.14.1/8.14.1) with ESMTP id mA2NhKcb012987;
	Sun, 2 Nov 2008 14:43:20 -0900 (AKST)
	(envelope-from david.syzdek@acsalaska.net)
X-Mailer: git-send-email 1.6.0.2.GIT
X-ACS-Spam-Status: no
X-ACS-Spam-Score: 1.3 (x)
X-ACS-Spam-Tests: HELO_LH_LD,ACS_BOGUS_LOCALHOST
X-ACS-Scanned-By: MD 2.63; SA 3.2.3; spamdefang 1.122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99889>

From: David M. Syzdek <david.syzdek@acsalaska.net>

FreeBSD 4.x systems use the linker flags `-pthread' instead of the
linker flags `-lpthread' when linking against the pthread library.

Signed-off-by: David M. Syzdek <david.syzdek@acsalaska.net>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 489774d..6737cb0 100644
--- a/Makefile
+++ b/Makefile
@@ -229,6 +229,7 @@ INSTALL = install
 RPMBUILD = rpmbuild
 TCL_PATH = tclsh
 TCLTK_PATH = wish
+PTHREAD_LIBS = -lpthread
 
 export TCL_PATH TCLTK_PATH
 
@@ -691,6 +692,7 @@ ifeq ($(uname_S),FreeBSD)
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
+		PTHREAD_LIBS = -pthread
 		NO_UINTMAX_T = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
@@ -1017,7 +1019,7 @@ endif
 
 ifdef THREADED_DELTA_SEARCH
 	BASIC_CFLAGS += -DTHREADED_DELTA_SEARCH
-	EXTLIBS += -lpthread
+	EXTLIBS += $(PTHREAD_LIBS)
 	LIB_OBJS += thread-utils.o
 endif
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
-- 
1.6.0.2.GIT
