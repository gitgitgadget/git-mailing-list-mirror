From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] t/t7811-grep-open.sh: remove broken/redundant creation of fake "less" script
Date: Mon, 21 Jun 2010 12:37:15 -0500
Message-ID: <__CrpvAIIX9lgHHkBLHB9XDHAxBXxWdeEjxUzFD8IDsCriIMGC3nkCjyvNdGPppHV_Yf_CyEmg8@cipher.nrlssc.navy.mil>
References: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 21 19:40:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkyg-0000Co-Aq
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932965Ab0FURkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 13:40:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60816 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932958Ab0FURkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 13:40:03 -0400
Received: by mail.nrlssc.navy.mil id o5LHbfkt008627; Mon, 21 Jun 2010 12:37:41 -0500
In-Reply-To: <__CrpvAIIX9lgHHkBLHB9fuuN7Rspzl7LFSDSwXwVCT6rYs_YOUHNMf7JZQbKaPHRl6AjsJ9dx8@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 21 Jun 2010 17:37:40.0379 (UTC) FILETIME=[72669EB0:01CB1168]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149427>

From: Brandon Casey <drafnel@gmail.com>

The fake "less" script was already created in a previous test titled
'setup: fake "less"', so it is redundant.  Additionally, it is broken since
the redirection of 'cat' is to a file named 'less', but the chmod operates
on the file named by the $less variable which may not contain the value
'less'.

So, just remove this code, and rely on the creation of the fake "less"
script performed earlier within the test script.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7811-grep-open.sh |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 2e5c701..c110441 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -109,11 +109,6 @@ test_expect_success 'git grep -O jumps to line in less' '
 
 test_expect_success 'modified file' '
 	rm -f actual &&
-	cat >less <<-\EOF &&
-	#!/bin/sh
-	printf "%s\n" "$@" >actual
-	EOF
-	chmod +x $less &&
 	cat >expect <<-\EOF &&
 	+/*enum grep_pat_token
 	grep.h
-- 
1.6.6.2
