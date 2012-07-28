From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] t7810-*.sh: Remove redundant test
Date: Sat, 28 Jul 2012 19:50:49 +0100
Message-ID: <50143489.1030606@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvC9O-0004QO-6I
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 20:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab2G1SyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 14:54:03 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:48659 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753009Ab2G1SyB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 14:54:01 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 8E67CA0C080;
	Sat, 28 Jul 2012 19:54:00 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id E3319A0C07F;	Sat, 28 Jul 2012 19:53:59 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 28 Jul 2012 19:53:59 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202453>


Since commit bbc09c22 ("grep: rip out support for external grep",
12-01-2010), test number 60 ("grep -C1 hunk mark between files") is
essentially the same as test number 59.

Test 59 was intended to verify the behaviour of git-grep resulting
from multiple invocations of an external grep. As part of the test,
it creates and adds 1024 files to the index, which is now wasted
effort.

Remove test 59, since it is now redundant.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t7810-grep.sh | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 24e9b19..523d041 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -399,17 +399,6 @@ test_expect_success 'grep -q, silently report matches' '
 	test_cmp empty actual
 '
 
-# Create 1024 file names that sort between "y" and "z" to make sure
-# the two files are handled by different calls to an external grep.
-# This depends on MAXARGS in builtin-grep.c being 1024 or less.
-c32="0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v"
-test_expect_success 'grep -C1, hunk mark between files' '
-	for a in $c32; do for b in $c32; do : >y-$a$b; done; done &&
-	git add y-?? &&
-	git grep -C1 "^[yz]" >actual &&
-	test_cmp expected actual
-'
-
 test_expect_success 'grep -C1 hunk mark between files' '
 	git grep -C1 "^[yz]" >actual &&
 	test_cmp expected actual
-- 
1.7.11.2
