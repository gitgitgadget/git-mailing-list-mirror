From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH 2/2] Improve portability: Avoid SS constant as it is already defined
Date: Wed, 27 Aug 2008 19:39:03 +0200
Message-ID: <1219858743-4476-3-git-send-email-sn_@gmx.net>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net>
 <1219858743-4476-2-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 19:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYP0D-0007ze-7q
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbYH0RjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYH0RjK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:39:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:49412 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751641AbYH0RjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:39:07 -0400
Received: (qmail invoked by alias); 27 Aug 2008 17:39:04 -0000
Received: from p57AEDFED.dip.t-dialin.net (EHLO localhost.localdomain) [87.174.223.237]
  by mail.gmx.net (mp038) with SMTP; 27 Aug 2008 19:39:04 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX19gguQNd/RgTnQLCPNqPgr6f+PF7GrfsH88mv3RmL
	Q5AfgcDJlG6cdl
X-Mailer: git-send-email 1.6.0.174.gd789c
In-Reply-To: <1219858743-4476-2-git-send-email-sn_@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93907>

From: David Soria Parra <dsp@php.net>

Constants that have the names of CPU registers are already defined
in OpenSolaris's sys/regset.h. This causes a warning as we try to
(re)define SS in ctype.c. So we just use another name.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 ctype.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ctype.c b/ctype.c
index ee06eb7..6ed2ba2 100644
--- a/ctype.c
+++ b/ctype.c
@@ -5,14 +5,14 @@
  */
 #include "cache.h"
 
-#define SS GIT_SPACE
+#define SP GIT_SPACE
 #define AA GIT_ALPHA
 #define DD GIT_DIGIT
 
 unsigned char sane_ctype[256] = {
-	 0,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0-15 */
+	 0,  0,  0,  0,  0,  0,  0,  0,  0, SP, SP,  0,  0, SP,  0,  0,		/* 0-15 */
 	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 16-15 */
-	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 32-15 */
+	SP,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 32-15 */
 	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0,  0,		/* 48-15 */
 	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 64-15 */
 	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 80-15 */
-- 
1.6.0.174.gd789c
