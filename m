From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 03/11] t3010: modernize style
Date: Sat,  1 Jun 2013 11:34:22 +0200
Message-ID: <38a0a3fdeda9087894935052e5a72c1761274221.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiDN-0002Bb-1X
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036Ab3FAJfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:35:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:7475 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756281Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C0B63A7EB4
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1494419F5E2
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226117>

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
