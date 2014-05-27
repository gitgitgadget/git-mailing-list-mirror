From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 03/10] t9903: move test name prefix to a separate variable
Date: Tue, 27 May 2014 03:40:53 -0400
Message-ID: <1401176460-31564-4-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
 <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:41:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC10-0003Yz-Im
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbaE0Hlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:35 -0400
Received: from smtp.bbn.com ([128.33.0.80]:19605 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbaE0Hlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:31 -0400
Received: from socket.bbn.com ([192.1.120.102]:50700)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC0o-000PH0-13; Tue, 27 May 2014 03:41:30 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id AAD8C4037C
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250149>

This is a step toward reusing the same test cases after disabling PS1
parameter expansion.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/t9903-bash-prompt.sh | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index c691869..d29dd2b 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -463,7 +463,9 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - branch name' '
+	pfx="prompt - bash color pc mode"
+
+	test_expect_success "$pfx - branch name" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
 		(
 			GIT_PS1_SHOWCOLORHINTS=y &&
@@ -473,7 +475,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - detached head' '
+	test_expect_success "$pfx - detached head" '
 		printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
 		git checkout b1^ &&
 		test_when_finished "git checkout master" &&
@@ -485,7 +487,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
+	test_expect_success "$pfx - dirty status indicator - dirty worktree" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmaster" >expected &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
@@ -498,7 +500,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
+	test_expect_success "$pfx - dirty status indicator - dirty index" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
@@ -512,7 +514,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
+	test_expect_success "$pfx - dirty status indicator - dirty index and worktree" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
 		echo "dirty index" >file &&
 		test_when_finished "git reset --hard" &&
@@ -527,7 +529,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
+	test_expect_success "$pfx - dirty status indicator - before root commit" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmaster" >expected &&
 		(
 			GIT_PS1_SHOWDIRTYSTATE=y &&
@@ -539,7 +541,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - inside .git directory' '
+	test_expect_success "$pfx - inside .git directory" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
 		echo "dirty" >file &&
 		test_when_finished "git reset --hard" &&
@@ -553,7 +555,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - stash status indicator' '
+	test_expect_success "$pfx - stash status indicator" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmaster" >expected &&
 		echo 2 >file &&
 		git stash &&
@@ -567,7 +569,7 @@ run_pcmode_tests () {
 		test_cmp expected "$actual"
 	'
 
-	test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
+	test_expect_success "$pfx - untracked files status indicator" '
 		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmaster" >expected &&
 		(
 			GIT_PS1_SHOWUNTRACKEDFILES=y &&
-- 
1.9.3
