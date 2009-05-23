From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/5] MinGW: the path separator to split GITPERLLIB is ';' on Win32
Date: Sat, 23 May 2009 10:04:48 +0200
Message-ID: <1243065891-13270-3-git-send-email-prohaska@zib.de>
References: <1243065891-13270-1-git-send-email-prohaska@zib.de>
 <1243065891-13270-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 10:30:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7mck-0005CC-LB
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 10:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbZEWIaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 04:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZEWIaI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 04:30:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:34254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbZEWIaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 04:30:03 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 May 2009 04:29:52 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4N84wwP001293;
	Sat, 23 May 2009 10:05:03 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4N84pOL028553;
	Sat, 23 May 2009 10:04:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243065891-13270-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119764>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 26d180c..7166760 100644
--- a/Makefile
+++ b/Makefile
@@ -225,6 +225,7 @@ ETC_GITCONFIG = etc/gitconfig
 endif
 lib = lib
 # DESTDIR=
+pathsep = :
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
@@ -813,6 +814,7 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
+	pathsep = ;
 	NO_PREAD = YesPlease
 	NO_OPENSSL = YesPlease
 	NO_CURL = YesPlease
@@ -1268,7 +1270,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-	    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
+	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
 	    -e '	H' \
 	    -e '	x' \
 	    -e '}' \
-- 
1.6.3.1.54.g99dd
