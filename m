From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t5701: "wc -l" may add whitespace
Date: Wed, 29 Aug 2007 17:52:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291752050.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 18:53:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQQmk-0002bZ-V4
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 18:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXH2Qwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 12:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbXH2Qwt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 12:52:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:35619 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751575AbXH2Qwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 12:52:49 -0400
Received: (qmail invoked by alias); 29 Aug 2007 16:52:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 29 Aug 2007 18:52:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18q72EYCiMqY0nPfu+LZ2jgrjGlAec7VzSoiBH2jn
	imDLy1tMffrYCB
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56965>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Found in msysGit... MSys' wc seems to suffer the same defect that 
	OSX' wc has...

 t/t5701-clone-local.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index d2f55eb..7e7019f 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -54,8 +54,7 @@ test_expect_success 'With -no-hardlinks, local will make a copy' '
 	cd "$D" &&
 	git clone --bare --no-hardlinks x w &&
 	cd w &&
-	linked=$(find objects -type f ! -links 1 | wc -l) &&
-	test "$linked" = 0
+	test $(find objects -type f ! -links 1 | wc -l) = 0
 '
 
 test_expect_success 'Even without -l, local will make a hardlink' '
@@ -63,8 +62,7 @@ test_expect_success 'Even without -l, local will make a hardlink' '
 	rm -fr w &&
 	git clone -l --bare x w &&
 	cd w &&
-	copied=$(find objects -type f -links 1 | wc -l) &&
-	test "$copied" = 0
+	test $(find objects -type f -links 1 | wc -l) = 0
 '
 
 test_done
-- 
1.5.3.rc7.2.g2d7f
