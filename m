From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 7/7] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
Date: Sun, 17 Aug 2008 14:44:43 +0200
Message-ID: <1218977083-14526-8-git-send-email-prohaska@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
 <1218977083-14526-2-git-send-email-prohaska@zib.de>
 <1218977083-14526-3-git-send-email-prohaska@zib.de>
 <1218977083-14526-4-git-send-email-prohaska@zib.de>
 <1218977083-14526-5-git-send-email-prohaska@zib.de>
 <1218977083-14526-6-git-send-email-prohaska@zib.de>
 <1218977083-14526-7-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhel-0001rR-6Z
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbYHQMpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755402AbYHQMpp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:52306 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbYHQMpo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCjZRC022276;
	Sun, 17 Aug 2008 14:45:40 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbU002872;
	Sun, 17 Aug 2008 14:44:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1218977083-14526-7-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92606>

The RUNTIME_PREFIX mechanism allows us to use the default (absolute) paths
on Windows too.  Defining RUNTIME_PREFIX explicitly requests for
translation of paths during runtime, depending on the path to the
executable.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8341558..8d57557 100644
--- a/Makefile
+++ b/Makefile
@@ -748,6 +748,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
+	RUNTIME_PREFIX = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
@@ -755,9 +756,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
-	gitexecdir = ../libexec/git-core
-	template_dir = ../share/git-core/templates/
-	ETC_GITCONFIG = ../etc/gitconfig
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
-- 
1.6.0.rc3.22.g053fd
