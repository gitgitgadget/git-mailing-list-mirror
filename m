From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t7606: Avoid using head as a file name
Date: Mon, 23 Aug 2010 16:15:47 -0400
Message-ID: <1282594547-78944-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 23 22:16:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OndR1-0003y4-GD
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab0HWUPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 16:15:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43492 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab0HWUPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 16:15:51 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3F1961FFC43C; Mon, 23 Aug 2010 20:15:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 1D8381FFC43A;
	Mon, 23 Aug 2010 20:15:42 +0000 (UTC)
X-Mailer: git-send-email 1.7.2.2.399.g628fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154250>

A file named 'head' gets confused with the HEAD ref on
case-insensitive file systems.  Replace '>head' with '>head.new' to
match the '>head.old' files they are compared to.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t7606-merge-custom.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 13c2193..8e8c4d7 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -46,7 +46,7 @@ test_expect_success 'merge c2 with a custom strategy' '
 	git rev-parse c2^{tree} >tree.expected &&
 	git merge -s theirs c2 &&
 
-	git rev-parse HEAD >head &&
+	git rev-parse HEAD >head.new &&
 	git rev-parse HEAD^1 >first-parent &&
 	git rev-parse HEAD^2 >second-parent &&
 	git rev-parse HEAD^{tree} >tree &&
@@ -55,7 +55,7 @@ test_expect_success 'merge c2 with a custom strategy' '
 	git diff --exit-code c2 HEAD &&
 	git diff --exit-code c2 &&
 
-	! test_cmp head.old head &&
+	! test_cmp head.old head.new &&
 	test_cmp head.old first-parent &&
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
@@ -72,7 +72,7 @@ test_expect_success 'trivial merge with custom strategy' '
 	git rev-parse c3^{tree} >tree.expected &&
 	git merge -s theirs c3 &&
 
-	git rev-parse HEAD >head &&
+	git rev-parse HEAD >head.new &&
 	git rev-parse HEAD^1 >first-parent &&
 	git rev-parse HEAD^2 >second-parent &&
 	git rev-parse HEAD^{tree} >tree &&
@@ -81,7 +81,7 @@ test_expect_success 'trivial merge with custom strategy' '
 	git diff --exit-code c3 HEAD &&
 	git diff --exit-code c3 &&
 
-	! test_cmp head.old head &&
+	! test_cmp head.old head.new &&
 	test_cmp head.old first-parent &&
 	test_cmp second-parent.expected second-parent &&
 	test_cmp tree.expected tree &&
-- 
1.7.2.2.399.g628fd
