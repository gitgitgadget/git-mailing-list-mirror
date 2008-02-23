From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] t4014: Replace sed's non-standard 'Q' by standard 'q'
Date: Sat, 23 Feb 2008 09:41:56 +0100
Message-ID: <12037561161987-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 09:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSpyY-0000jI-9h
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 09:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbYBWIml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 03:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbYBWIml
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 03:42:41 -0500
Received: from mailer.zib.de ([130.73.108.11]:62009 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbYBWImk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 03:42:40 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1N8gDYA008455;
	Sat, 23 Feb 2008 09:42:14 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1N8fvnL010583;
	Sat, 23 Feb 2008 09:42:13 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74805>

This commit should be applied on top of db/cover-letter.

-- >8 --

This commit avoids sed's 'Q' operator.  The Open Group's sed
man page [1] does not mention 'Q'.  sed on Mac OS X 10.4
does not accept Q.  'q' is sufficient for our purpose.

[1] http://opengroup.org/onlinepubs/007908799/xcu/sed.html

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t4014-format-patch.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a39e786..16aa99d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -95,7 +95,7 @@ test_expect_success 'extra headers' '
 	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>
 " &&
 	git format-patch --stdout master..side > patch2 &&
-	sed -e "/^$/Q" patch2 > hdrs2 &&
+	sed -e "/^$/q" patch2 > hdrs2 &&
 	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs2 &&
 	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs2
 	
@@ -106,7 +106,7 @@ test_expect_success 'extra headers without newlines' '
 	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S. E. Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side >patch3 &&
-	sed -e "/^$/Q" patch3 > hdrs3 &&
+	sed -e "/^$/q" patch3 > hdrs3 &&
 	grep "^To: R. E. Cipient <rcipient@example.com>$" hdrs3 &&
 	grep "^Cc: S. E. Cipient <scipient@example.com>$" hdrs3
 	
@@ -117,7 +117,7 @@ test_expect_success 'extra headers with multiple To:s' '
 	git config --replace-all format.headers "To: R. E. Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S. E. Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side > patch4 &&
-	sed -e "/^$/Q" patch4 > hdrs4 &&
+	sed -e "/^$/q" patch4 > hdrs4 &&
 	grep "^To: R. E. Cipient <rcipient@example.com>,$" hdrs4 &&
 	grep "^ *S. E. Cipient <scipient@example.com>$" hdrs4
 '
@@ -125,7 +125,7 @@ test_expect_success 'extra headers with multiple To:s' '
 test_expect_success 'additional command line cc' '
 
 	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/Q" >patch5 &&
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/q" >patch5 &&
 	grep "^Cc: R. E. Cipient <rcipient@example.com>,$" patch5 &&
 	grep "^ *S. E. Cipient <scipient@example.com>$" patch5
 '
-- 
1.5.4.2.199.gb454ad
