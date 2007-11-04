From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] t3502: Disambiguate between file and rev by adding --
Date: Sun, 4 Nov 2007 10:31:26 -0500
Message-ID: <20071104153126.GA61398@173.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 16:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IohRw-0000uW-0C
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 16:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXKDPb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 10:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbXKDPb3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 10:31:29 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:50456 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbXKDPb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 10:31:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 9F7441FFC12F
	for <git@vger.kernel.org>; Sun,  4 Nov 2007 15:31:27 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63417>

This test failed because git-diff didn't know if it was asking for the
file "a" or the branch "a".  Adding "--" at the end of the ambiguous
commands allows the test to finish properly.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 t/t3502-cherry-pick-merge.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 3274c61..7c92e26 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -36,7 +36,7 @@ test_expect_success 'cherry-pick a non-merge with -m should fail' '
 	git reset --hard &&
 	git checkout a^0 &&
 	! git cherry-pick -m 1 b &&
-	git diff --exit-code a
+	git diff --exit-code a --
 
 '
 
@@ -45,7 +45,7 @@ test_expect_success 'cherry pick a merge without -m should fail' '
 	git reset --hard &&
 	git checkout a^0 &&
 	! git cherry-pick c &&
-	git diff --exit-code a
+	git diff --exit-code a --
 
 '
 
@@ -98,7 +98,7 @@ test_expect_success 'revert a merge (1)' '
 	git reset --hard &&
 	git checkout c^0 &&
 	git revert -m 1 c &&
-	git diff --exit-code a
+	git diff --exit-code a --
 
 '
 
@@ -107,7 +107,7 @@ test_expect_success 'revert a merge (2)' '
 	git reset --hard &&
 	git checkout c^0 &&
 	git revert -m 2 c &&
-	git diff --exit-code b
+	git diff --exit-code b --
 
 '
 
-- 
1.5.3.5.530.gcd7a
