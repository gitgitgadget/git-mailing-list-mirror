From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-web--browse: Fix open HTML help pages from iTerm
Date: Wed, 23 May 2012 06:10:56 +0200
Message-ID: <1337746256-15838-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 06:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX3Tw-000839-Sv
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 06:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab2EWEr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 00:47:28 -0400
Received: from mailer.zib.de ([130.73.108.11]:41259 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab2EWEr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 00:47:27 -0400
X-Greylist: delayed 2151 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 May 2012 00:47:22 EDT
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id q4N4BLQF014462;
	Wed, 23 May 2012 06:11:26 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id q4N4BKjV029901;
	Wed, 23 May 2012 06:11:20 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198271>

iTerm is an alternative to the default terminal emulation program on Mac
OS X.  git-web--browse wasn't aware of iTerm and failed to open HTML help
pages when used in a shell session running in iTerm, reporting "No known
browser available."  Now it works as expected and opens HTML pages.

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
1.7.10.2.554.g7af14ee
