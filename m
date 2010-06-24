From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t4027, t4041: Use printf instead of echo -n
Date: Thu, 24 Jun 2010 13:46:18 -0400
Message-ID: <1277401578-20984-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 19:53:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqcS-0000O2-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab0FXRxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 13:53:39 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43309 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab0FXRxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:53:38 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2010 13:53:38 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 61DE31FFC05B; Thu, 24 Jun 2010 17:46:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id A02E51FFC057;
	Thu, 24 Jun 2010 17:46:16 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.703.g42c01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149614>

BSD's echo doesn't recognize the -n option, so use printf instead

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/t4027-diff-submodule.sh        |   10 +++++-----
 t/t4041-diff-submodule-option.sh |   14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 559b41e..ea362d3 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -105,13 +105,13 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules HEAD >actual2 &&
-	echo -n "" | test_cmp - actual2 &&
+	printf "" | test_cmp - actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual3.body &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	echo -n "" | test_cmp - actual4
+	printf "" | test_cmp - actual4
 '
 test_done
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
@@ -139,11 +139,11 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
-	echo -n "" | test_cmp - actual2 &&
+	printf "" | test_cmp - actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
-	echo -n "" | test_cmp - actual3 &&
+	printf "" | test_cmp - actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	echo -n "" | test_cmp - actual4
+	printf "" | test_cmp - actual4
 '
 
 test_expect_success 'git diff (empty submodule dir)' '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f44b906..7600ed1 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -207,17 +207,17 @@ EOF
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' "
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'submodule contains untracked content (dirty ignored)' "
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'submodule contains untracked and modifed content' "
@@ -240,13 +240,13 @@ EOF
 test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'submodule contains modifed content' "
@@ -295,7 +295,7 @@ EOF
 
 test_expect_success 'modified submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'modified submodule contains untracked and modifed content' "
@@ -331,7 +331,7 @@ EOF
 test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "
 
 test_expect_success 'modified submodule contains modifed content' "
-- 
1.7.1.703.g42c01
