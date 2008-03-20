From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t/t7003-filter-branch.sh: use test_must_fail rather than
 '!'
Date: Thu, 20 Mar 2008 11:54:30 -0500
Message-ID: <47E296C6.5080605@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcO3I-0005RZ-FA
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 17:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbYCTQy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 12:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754405AbYCTQy5
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 12:54:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38044 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbYCTQy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 12:54:56 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2KGsVhc015669;
	Thu, 20 Mar 2008 11:54:31 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Mar 2008 11:54:30 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 20 Mar 2008 16:54:30.0879 (UTC) FILETIME=[10F806F0:01C88AAB]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15792001
X-TM-AS-Result: : Yes--13.332000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY3My03MDAx?=
	=?us-ascii?B?NjAtMTg4MDE5LTcwMDk3MC03MDQ0MjUtNzAyNTUxLTcwMjM1OC03?=
	=?us-ascii?B?MTE3NDAtNzAzNzg4LTcwMTM4NC0xMDY0MjAtNzAzOTY5LTcwMzc0?=
	=?us-ascii?B?Ny03MTA3MzktNzA1NTU3LTcwNDQyMS03MDY3MTktNzAwOTcxLTcw?=
	=?us-ascii?B?MDM3My0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77672>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7003-filter-branch.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 553131f..6827249 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -78,7 +78,7 @@ test_expect_success 'filter subdirectory only' '
 test_expect_success 'subdirectory filter result looks okay' '
 	test 2 = $(git rev-list sub | wc -l) &&
 	git show sub:new &&
-	! git show sub:subdir
+	test_must_fail git show sub:subdir
 '
 
 test_expect_success 'setup and filter history that requires --full-history' '
@@ -100,7 +100,7 @@ test_expect_success 'subdirectory filter result looks okay' '
 	test 3 = $(git rev-list -1 --parents sub-master | wc -w) &&
 	git show sub-master^:new &&
 	git show sub-master^2:new &&
-	! git show sub:subdir
+	test_must_fail git show sub:subdir
 '
 
 test_expect_success 'use index-filter to move into a subdirectory' '
@@ -114,7 +114,7 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 
 test_expect_success 'stops when msg filter fails' '
 	old=$(git rev-parse HEAD) &&
-	! git-filter-branch -f --msg-filter false HEAD &&
+	test_must_fail git-filter-branch -f --msg-filter false HEAD &&
 	test $old = $(git rev-parse HEAD) &&
 	rm -rf .git-rewrite
 '
@@ -151,8 +151,8 @@ test_expect_success "remove a certain author's commits" '
 '
 
 test_expect_success 'barf on invalid name' '
-	! git filter-branch -f master xy-problem &&
-	! git filter-branch -f HEAD^
+	test_must_fail git filter-branch -f master xy-problem &&
+	test_must_fail git filter-branch -f HEAD^
 '
 
 test_expect_success '"map" works in commit filter' '
@@ -174,7 +174,7 @@ test_expect_success 'Name needing quotes' '
 	git add foo &&
 	git commit -m "Adding a file" &&
 	git filter-branch --tree-filter "rm -fr foo" &&
-	! git ls-files --error-unmatch "foo/$name" &&
+	test_must_fail git ls-files --error-unmatch "foo/$name" &&
 	test $(git rev-parse --verify rerere) != $(git rev-parse --verify A)
 
 '
-- 
1.5.4.4.481.g5075
