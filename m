From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Test "git log --diff-filter"
Date: Sat,  5 Jan 2008 23:20:22 +0100
Message-ID: <1199571622-12953-1-git-send-email-jnareb@gmail.com>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org>
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 23:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBHOI-0004vK-S0
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 23:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbYAEWUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 17:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbYAEWUe
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 17:20:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:41350 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYAEWU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 17:20:28 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2955667ugc.16
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Vq1WE+RB9xuno2uwjgI3NGezredyW/gfZuqIXm8TZjM=;
        b=LMnx1ICzY0UBk11A9JtGDRRHLKN+/q3DugJdWIBlF6ctx+DbLzSJjqj0Y2QKQQhgXGNFt5os+zX3p6uD8xjj6nycVh2RHODJ8KN2Hk8Nv9WCvcZELJNE5zqFA+r9kCxDQf8l/m/lTgidFRQ2xWAiOfVuA4SwQTQbPygKdZT2Pqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r4+5PVLbZ2M96CUHFMeoSWBEcCzal8Kqwr0I8rMKfZKyQhko69cRL5kRdISWEqSgcP/lo23G+OAAQ/IGkYWRRu5S5tO8B6unS6CrbPXSw6BsR6oClRxk7n2MEg3cuxGYRthWuvd5B0ROvPJPeE0mvZwgyy7I4eD17CrwGqIJV2o=
Received: by 10.67.26.7 with SMTP id d7mr2497963ugj.23.1199571626153;
        Sat, 05 Jan 2008 14:20:26 -0800 (PST)
Received: from roke.D-201 ( [83.8.190.130])
        by mx.google.com with ESMTPS id p34sm18828044ugc.46.2008.01.05.14.20.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 14:20:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m05MKOdL012970;
	Sat, 5 Jan 2008 23:20:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m05MKNnb012969;
	Sat, 5 Jan 2008 23:20:23 +0100
X-Mailer: git-send-email 1.5.3.7
In-Reply-To: <1198580807-18802-1-git-send-email-arjen@yaph.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69687>

Add test to check "git log --diff-filter" works correctly with and
without diff generation by git-log; the main purpose of this test is
to check if "git log --diff-filter" filters revisions correctly.

This is a companion test to commit 0faf2da7e5ee5c2f472d8a7afaf8616101f34e80
(Fix "git log --diff-filter" bug) by Arjen Laarhoven.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio C Hamano wrote:

> Thanks.  Some tests?

So there it is...


First, either I don't understand what referred to commit was supposed
to fix, or my test is wrong, or the patch doesn't fix the bug.

Second, I have a few questions about the test itself. I'm not that
sure about it's name: t/README tells us to use 4 as a first digit of
test number for testing diff commands, and 8 for commands concerning
forensics. "git log --diff-filter" is a forensics concerning diff
output. Second digit is for command itself: 0 is used for diff, 2 for
log, so perhaps the test should be named t/t4203-log-diff-filter.sh

The style of writing test is not very consistent across git test
suite. I think that the 'setup' step style is all right, and only
perhas the style of those two-liner tests could be changed.

I use "git diff --exit-code expected current" instead of "diff" or
"cmp" utilities; should all (new) test use this... well of course
except ones testing diff output itself?

 t/t4025-diff-filter.sh |  240 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 240 insertions(+), 0 deletions(-)
 create mode 100755 t/t4025-diff-filter.sh

diff --git a/t/t4025-diff-filter.sh b/t/t4025-diff-filter.sh
new file mode 100755
index 0000000..3113786
--- /dev/null
+++ b/t/t4025-diff-filter.sh
@@ -0,0 +1,240 @@
+#!/bin/sh
+
+test_description='git log --diff-filter option
+
+Test --diff-filter option with git-log with and without diff output,
+checking both diff output filtering and revision list filtering.
+'
+
+. ./test-lib.sh
+. ../diff-lib.sh ;# test-lib chdir's into trash
+
+# ----------------------------------------------------------------------
+
+test_expect_success setup '
+
+	rm -f foo &&
+	cat ../../COPYING >foo &&
+	git add foo &&
+	git commit -a -m "1st commit: A" &&
+
+	cp foo bar &&
+	git add bar &&
+	git commit -a -m "2nd commit: C" &&
+
+	git rm foo &&
+	git commit -a -m "3rd commit: D" &&
+
+	echo "First added line" >> bar &&
+	git commit -a -m "4th commit: M" &&
+
+	git mv bar foo &&
+	git commit -a -m "5th commit: R" &&
+
+	rm -f foo &&
+	cat ../../Makefile >foo &&
+	git commit -a -m "6th commit: B" &&
+
+	rm -f bar &&
+	echo "bar" > bar &&
+	git add bar &&
+	echo "Second added line" >> foo &&
+	git commit -a -m "7th commit: AM"
+
+	rm -f bar &&
+	ln -s foo bar &&
+	git commit -a -m "8th commit: T"
+
+'
+
+# ----------------------------------------------------------------------
+
+cat >expected <<\EOF
+7th commit: AM
+:000000 100644 0000000000000000000000000000000000000000 5716ca5987cbf97d6bb54920bea6adde242d87e6 A	bar
+
+1st commit: A
+:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	foo
+EOF
+
+test_expect_success 'git log --raw --diff-filter=A' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=A >current &&
+	compare_diff_raw expected current
+'
+
+
+cat >expected <<\EOF
+3rd commit: D
+:100644 000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0000000000000000000000000000000000000000 D	foo
+EOF
+
+test_expect_success 'git log --raw --diff-filter=D' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=D >current &&
+	compare_diff_raw expected current
+'
+
+
+cat >expected <<\EOF
+7th commit: AM
+:100644 100644 21c80e6bf73163b9770cba5331cd48172fa6d43e a892bacce2a80efc14eef1c316e827575a96e5c9 M	foo
+
+4th commit: M
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 915b225a6c9984e645a8061e05002f8cbd2ce46c M	bar
+EOF
+
+test_expect_success 'git log --raw --diff-filter=M' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=M >current &&
+	compare_diff_raw expected current
+'
+
+
+cat >expected <<\EOF
+5th commit: R
+:100644 100644 915b225a6c9984e645a8061e05002f8cbd2ce46c 915b225a6c9984e645a8061e05002f8cbd2ce46c R100	bar	foo
+EOF
+
+test_expect_success 'git log --raw --diff-filter=R' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=R >current &&
+	compare_diff_raw expected current
+'
+
+
+cat >expected <<\EOF
+2nd commit: C
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 C100	foo	bar
+EOF
+
+test_expect_success 'git log --raw --diff-filter=C' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=C >current &&
+	compare_diff_raw expected current
+'
+
+
+cat >expected <<\EOF
+6th commit: B
+:100644 100644 915b225a6c9984e645a8061e05002f8cbd2ce46c 21c80e6bf73163b9770cba5331cd48172fa6d43e M098	foo
+EOF
+
+test_expect_success 'git log --raw --diff-filter=B' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=B >current &&
+	compare_diff_raw expected current
+'
+
+
+cat >expected <<\EOF
+8th commit: T
+:100644 120000 5716ca5987cbf97d6bb54920bea6adde242d87e6 19102815663d23f8b75a47e7a01965dcdc96468c T	bar
+EOF
+
+test_expect_success 'git log --raw --diff-filter=T' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=T >current &&
+	compare_diff_raw expected current
+'
+
+cat >expected <<\EOF
+7th commit: AM
+:000000 100644 0000000000000000000000000000000000000000 5716ca5987cbf97d6bb54920bea6adde242d87e6 A	bar
+:100644 100644 21c80e6bf73163b9770cba5331cd48172fa6d43e a892bacce2a80efc14eef1c316e827575a96e5c9 M	foo
+
+1st commit: A
+:000000 100644 0000000000000000000000000000000000000000 6ff87c4664981e4397625791c8ea3bbb5f2279a3 A	foo
+EOF
+
+test_expect_success 'git log --raw --diff-filter=A*' '
+	git log --raw --no-abbrev --pretty=format:%s -B -C -C --diff-filter=A* >current &&
+	compare_diff_raw expected current
+'
+
+# ----------------------------------------------------------------------
+
+cat >expected <<\EOF
+8th commit: T
+7th commit: AM
+6th commit: B
+5th commit: R
+4th commit: M
+3rd commit: D
+2nd commit: C
+1st commit: A
+EOF
+
+test_expect_success 'git log (no filter)' '
+	git log --pretty=format:%s -B -C -C >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+7th commit: AM
+1st commit: A
+EOF
+
+test_expect_success 'git log --diff-filter=A' '
+	git log --pretty=format:%s -B -C -C --diff-filter=A >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+3rd commit: D
+EOF
+
+test_expect_success 'git log --diff-filter=D' '
+	git log --pretty=format:%s -B -C -C --diff-filter=D >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+7th commit: AM
+4th commit: M
+EOF
+
+test_expect_success 'git log --diff-filter=M' '
+	git log --pretty=format:%s -B -C -C --diff-filter=M >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+5th commit: R
+EOF
+
+test_expect_success 'git log --diff-filter=R' '
+	git log --pretty=format:%s -B -C -C --diff-filter=R >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+2nd commit: C
+EOF
+
+test_expect_success 'git log --diff-filter=C' '
+	git log --pretty=format:%s -B -C -C --diff-filter=C >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+6th commit: B
+EOF
+
+test_expect_success 'git log --diff-filter=B' '
+	git log --pretty=format:%s -B -C -C --diff-filter=A >current &&
+	git diff --exit-code expected current
+'
+
+
+cat >expected <<\EOF
+8th commit: T
+EOF
+
+test_expect_success 'git log --diff-filter=T' '
+	git log --pretty=format:%s -B -C -C --diff-filter=T >current &&
+	git diff --exit-code expected current
+'
+
+# ----------------------------------------------------------------------
+
+test_done
-- 
1.5.3.7
