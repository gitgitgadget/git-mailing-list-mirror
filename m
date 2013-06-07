From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 02/10] t3010: modernize style
Date: Fri,  7 Jun 2013 22:53:26 +0200
Message-ID: <8d271c08f2d49aca17e7bec6d841ac72af7b15b1.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fK-0006mZ-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017Ab3FGUxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:53:39 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:33327 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754898Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 051B713004E;
	Fri,  7 Jun 2013 22:53:35 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9211719F5E8;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
In-Reply-To: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370636706.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226706>

In particular:

- move test preparations inside test_expect_success

- place test description on the test_expect_success line

- indent with a tab

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3010-ls-files-killed-modified.sh | 123 ++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 62 deletions(-)

diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 95671c2..2d0ff2d 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -37,71 +37,70 @@ modified without reporting path9 and path10.
 '
 . ./test-lib.sh
 
-date >path0
-if test_have_prereq SYMLINKS
-then
-	ln -s xyzzy path1
-else
-	date > path1
-fi
-mkdir path2 path3
-date >path2/file2
-date >path3/file3
-: >path7
-date >path8
-: >path9
-date >path10
-test_expect_success \
-    'git update-index --add to add various paths.' \
-    "git update-index --add -- path0 path1 path?/file? path7 path8 path9 path10"
-
-rm -fr path? ;# leave path10 alone
-date >path2
-if test_have_prereq SYMLINKS
-then
-	ln -s frotz path3
-	ln -s nitfol path5
-else
-	date > path3
-	date > path5
-fi
-mkdir path0 path1 path6
-date >path0/file0
-date >path1/file1
-date >path6/file6
-date >path7
-: >path8
-: >path9
-touch path10
+test_expect_success 'git update-index --add to add various paths.' '
+	date >path0 &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s xyzzy path1
+	else
+		date > path1
+	fi &&
+	mkdir path2 path3 &&
+	date >path2/file2 &&
+	date >path3/file3 &&
+	: >path7 &&
+	date >path8 &&
+	: >path9 &&
+	date >path10 &&
+	git update-index --add -- path0 path1 path?/file? path7 path8 path9 path10 &&
+	rm -fr path?	# leave path10 alone
+'
 
-test_expect_success \
-    'git ls-files -k to show killed files.' \
-    'git ls-files -k >.output'
-cat >.expected <<EOF
-path0/file0
-path1/file1
-path2
-path3
-EOF
+test_expect_success 'git ls-files -k to show killed files.' '
+	date >path2 &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s frotz path3 &&
+		ln -s nitfol path5
+	else
+		date >path3 &&
+		date >path5
+	fi &&
+	mkdir path0 path1 path6 &&
+	date >path0/file0 &&
+	date >path1/file1 &&
+	date >path6/file6 &&
+	date >path7 &&
+	: >path8 &&
+	: >path9 &&
+	touch path10 &&
+	git ls-files -k >.output
+'
 
-test_expect_success \
-    'validate git ls-files -k output.' \
-    'test_cmp .expected .output'
+test_expect_success 'validate git ls-files -k output.' '
+	cat >.expected <<-\EOF &&
+	path0/file0
+	path1/file1
+	path2
+	path3
+	EOF
+	test_cmp .expected .output
+'
 
-test_expect_success \
-    'git ls-files -m to show modified files.' \
-    'git ls-files -m >.output'
-cat >.expected <<EOF
-path0
-path1
-path2/file2
-path3/file3
-path7
-path8
-EOF
+test_expect_success 'git ls-files -m to show modified files.' '
+	git ls-files -m >.output
+'
 
-test_expect_success \
-    'validate git ls-files -m output.' \
-    'test_cmp .expected .output'
+test_expect_success 'validate git ls-files -m output.' '
+	cat >.expected <<-\EOF &&
+	path0
+	path1
+	path2/file2
+	path3/file3
+	path7
+	path8
+	EOF
+	test_cmp .expected .output
+'
 
 test_done
-- 
1.8.3.rc1.32.g8b61cbb
