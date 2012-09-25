From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-web--browse: Fix open HTML help pages from iTerm
Date: Tue, 25 Sep 2012 20:16:43 +0200
Message-ID: <1348597003-28403-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 20:53:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGaGB-0000Ib-EV
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 20:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab2IYSxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 14:53:21 -0400
Received: from mailer.zib.de ([130.73.108.11]:37860 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab2IYSxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 14:53:20 -0400
X-Greylist: delayed 2139 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2012 14:53:16 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id q8PIHTB9022428;
	Tue, 25 Sep 2012 20:17:34 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id q8PIHSPF014894;
	Tue, 25 Sep 2012 20:17:28 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206372>

iTerm is an alternative to the default terminal emulation program on Mac
OS X.  git-web--browse wasn't aware of iTerm and failed to open HTML
help pages when used in a shell session running in iTerm, reporting "No
known browser available."  Now it works as expected.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-web--browse.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1e82726..95ecf65 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -120,7 +120,8 @@ if test -z "$browser" ; then
 	fi
 	# SECURITYSESSIONID indicates an OS X GUI login session
 	if test -n "$SECURITYSESSIONID" \
-		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
+		-o "$TERM_PROGRAM" = "Apple_Terminal" \
+		-o "$TERM_PROGRAM" = "iTerm.app" ; then
 		browser_candidates="open $browser_candidates"
 	fi
 	# /bin/start indicates MinGW
-- 
1.7.12.1.403.g14e83b4
