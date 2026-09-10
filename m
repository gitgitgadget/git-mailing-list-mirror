Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97053A892
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060073; cv=none; b=YZ4EyBRWO3i1WAhwnQQDr3Jk0KF/Z/d8sqP/Pnbq6/0txeYAPmk4Tfb9/BGERuISzTrcusn57bKnL4OtqMQBX42jntrFVquMQpT65GsU5c5siGZlac+53+NSovaVg3jF5eo091tMxeoOVLojwrH8rI6kydPmUoWq0GPhCwwp++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060073; c=relaxed/simple;
	bh=0oT7tR+flEJEKnLAYRmluJWCWs8q/C6uYIxt+dAHRPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OcuxA45SWbVQ5N98EumWPls2ZtaHj5ZmrHW8anSP4NPMVHm7/sW7eL4cQwveZ7hK3VVuliGN3Zdb8BXCnUmOHFcnVNiy0INwDkd+AJ3mEoeighkpkZQmeodw3rFjsSWicoQhItOjSiay2kFWwXSzU7VXUXzFQxwXlW0YRf36y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu/newj8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu/newj8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18E31C2BCFA;
	Thu, 10 Sep 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789060072;
	bh=0oT7tR+flEJEKnLAYRmluJWCWs8q/C6uYIxt+dAHRPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eu/newj85VtHNMhVmZIaieHJhJadD3ddr3goeU+7kmus5XiA/jd62NrveiNiEbyX1
	 t0LqPWtvcKg3dbs5WHfmZ81JDmMa3n5YoZuTH/mjZcfILsd1+ib9ADX9nIujDJwvHb
	 Vm0UlSBNsTUMwH/xsdVwuqR+cklRQzX4fFY77zOCfzMBkWQPpm1jZz7TcJwEPabr60
	 Z5Qs4+K/7Mq8PNaRb3hqJB8dwtMgPyOYLcTB4KJFKMtPV3ZYM56/+IQS5P0gIW2iL9
	 c2Ij/RmErXbzEwwtQrFFz+gKlq3jJEzlSy0NtHK48aatdd5sr4tm6/I7renL10ONSd
	 WL5+tDkh7aWwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF7CC79F9F;
	Thu, 10 Sep 2026 17:07:51 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Thu, 10 Sep 2026 13:07:33 -0400
Subject: [PATCH v2 1/3] Update t4001 to use modern syntax.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-modernize-t4001-v2-1-ac53e9f5d717@fastmail.com>
References: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
In-Reply-To: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12209;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=IIanJ25avh15rK5tPCWGfnq94nfdTAmzsnCQ+DUk3dM=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWPX5apymkm6gU87ijkq371tezB/qvv4s0OenpfWB6z
 7m5Tteed5SyMIhxMciKKbL8/yfQ+IrlgYRf0LtPMHNYmUCGMHBxCsBE+gsZGY4Vf3lrZ/fWKMFq
 RuW6ZI3pqi8vvpt0dNUuxcDXgZ6R2zUZ/sfPOHVsn9DDGAbbRa3pubd2vc950bV3y/4IqytLJV4
 bRHECAA==
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/t4001-diff-rename.sh   | 97 +++++++++++++++++++++---------------------------
 t/t4009-diff-rename-4.sh | 54 +++++++++++++--------------
 2 files changed, 70 insertions(+), 81 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index ad474100af..c27bd9d781 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -8,7 +8,7 @@ test_description='Test rename detection in diff engine.'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
-test_expect_success 'setup' '
+initial_setup () {
 	cat >path0 <<-\EOF &&
 	Line 1
 	Line 2
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 	Line 14
 	Line 15
 	EOF
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	diff --git a/path0 b/path1
 	rename from path0
 	rename to path1
@@ -42,7 +42,7 @@ test_expect_success 'setup' '
 	 Line 13
 	 Line 14
 	EOF
-	cat >no-rename <<-\EOF
+	cat >expect-no-rename <<-\EOF
 	diff --git a/path0 b/path0
 	deleted file mode 100644
 	index fdbec44..0000000
@@ -86,47 +86,36 @@ test_expect_success 'setup' '
 	+Line 14
 	+Line 15
 	EOF
-'
-
-test_expect_success \
-    'update-index --add a file.' \
-    'git update-index --add path0'
-
-test_expect_success \
-    'write that tree.' \
-    'tree=$(git write-tree) && echo $tree'
-
-sed -e 's/line/Line/' <path0 >path1
-rm -f path0
-test_expect_success \
-    'renamed and edited the file.' \
-    'git update-index --add --remove path0 path1'
+    update-index --add a file.
+    git update-index --add path0
+}
 
-test_expect_success \
-    'git diff-index -p -M after rename and editing.' \
-    'git diff-index -p -M $tree >current'
-
-
-test_expect_success \
-    'validate the output.' \
-    'compare_diff_patch current expected'
+test_expect_success 'Diff shows path0 renamed to path1 with edit.' '
+	initial_setup &&
+	tree=$(git write-tree) &&
+	sed -e "s/line/Line/" <path0 >path1 &&
+	rm -f path0 &&
+	git update-index --add --remove path0 path1 &&
+	git diff-index -p -M $tree >actual &&
+	compare_diff_patch actual expect
+'
 
-test_expect_success 'test diff.renames=true' '
-	git -c diff.renames=true diff --cached $tree >current &&
-	compare_diff_patch current expected
+test_expect_success 'With diff.renames=true, patch includes rename of path0 to path1' '
+	git -c diff.renames=true diff --cached $tree >actual &&
+	compare_diff_patch actual expect
 '
 
-test_expect_success 'test diff.renames=false' '
-	git -c diff.renames=false diff --cached $tree >current &&
-	compare_diff_patch current no-rename
+test_expect_success 'With diff.renames=false, patch does not include rename' '
+	git -c diff.renames=false diff --cached $tree >actual &&
+	compare_diff_patch actual expect-no-rename
 '
 
-test_expect_success 'test diff.renames unset' '
-	git diff --cached $tree >current &&
-	compare_diff_patch current expected
+test_expect_success 'With no setting for diff.renames, patch includes rename' '
+	git diff --cached $tree >actual &&
+	compare_diff_patch actual expect
 '
 
-test_expect_success 'favour same basenames over different ones' '
+test_expect_success 'Diff rename favours same basenames over different ones' '
 	cp path1 another-path &&
 	git add another-path &&
 	git commit -m 1 &&
@@ -137,25 +126,25 @@ test_expect_success 'favour same basenames over different ones' '
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'test diff.renames=true for git status' '
+test_expect_success 'With diff.renames=true, git status includes rename' '
 	git -c diff.renames=true status >out &&
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'test diff.renames=false for git status' '
+test_expect_success 'With diff.renames=false, git status shows delete/add' '
 	git -c diff.renames=false status >out &&
 	test_grep ! "renamed: .*path1 -> subdir/path1" out &&
 	test_grep "new file: .*subdir/path1" out &&
 	test_grep "deleted: .*[^/]path1" out
 '
 
-test_expect_success 'favour same basenames even with minor differences' '
+test_expect_success 'rename logic favours same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status >out &&
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'two files with same basename and same content' '
+test_expect_success 'Favors common path segments for files with the same basename and content' '
 	git reset --hard &&
 	mkdir -p dir/A dir/B &&
 	cp path1 dir/A/file &&
@@ -167,7 +156,7 @@ test_expect_success 'two files with same basename and same content' '
 	test_grep "renamed: .*dir/A/file -> other-dir/A/file" out
 '
 
-test_expect_success 'setup for many rename source candidates' '
+test_expect_success 'rename with many candidates' '
 	git reset --hard &&
 	for i in 0 1 2 3 4 5 6 7 8 9;
 	do
@@ -177,14 +166,14 @@ test_expect_success 'setup for many rename source candidates' '
 		done
 	done &&
 	git add "path??" &&
-	test_tick &&
+	test_tick  &&
 	git commit -m "hundred" &&
 	(cat path1 && echo new) >new-path &&
 	echo old >>path1 &&
 	git add new-path path1 &&
 	git diff -l 4 -C -C --cached --name-status >actual 2>actual.err &&
 	sed -e "s/^\([CM]\)[0-9]*	/\1	/" actual >actual.munged &&
-	cat >expect <<-EOF &&
+	cat >expect <<-\EOF &&
 	C	path1	new-path
 	M	path1
 	EOF
@@ -192,7 +181,7 @@ test_expect_success 'setup for many rename source candidates' '
 	test_grep warning actual.err
 '
 
-test_expect_success 'rename pretty print with nothing in common' '
+test_expect_success 'rename pretty prints paths with nothing in common' '
 	mkdir -p a/b/ &&
 	: >a/b/c &&
 	git add a/b/c &&
@@ -206,7 +195,7 @@ test_expect_success 'rename pretty print with nothing in common' '
 	test_grep " a/b/c => c/b/a " output
 '
 
-test_expect_success 'rename pretty print with common prefix' '
+test_expect_success 'rename pretty prints paths with common prefix' '
 	mkdir -p c/d &&
 	git mv c/b/a c/d/e &&
 	git commit -m "c/b/a -> c/d/e" &&
@@ -216,7 +205,7 @@ test_expect_success 'rename pretty print with common prefix' '
 	test_grep " c/{b/a => d/e} " output
 '
 
-test_expect_success 'rename pretty print with common suffix' '
+test_expect_success 'rename pretty prints paths with common suffix' '
 	mkdir d &&
 	git mv c/d/e d/e &&
 	git commit -m "c/d/e -> d/e" &&
@@ -226,7 +215,7 @@ test_expect_success 'rename pretty print with common suffix' '
 	test_grep " {c/d => d}/e " output
 '
 
-test_expect_success 'rename pretty print with common prefix and suffix' '
+test_expect_success 'rename pretty prints paths with common prefix and suffix' '
 	mkdir d/f &&
 	git mv d/e d/f/e &&
 	git commit -m "d/e -> d/f/e" &&
@@ -236,7 +225,7 @@ test_expect_success 'rename pretty print with common prefix and suffix' '
 	test_grep " d/{ => f}/e " output
 '
 
-test_expect_success 'rename pretty print common prefix and suffix overlap' '
+test_expect_success 'rename pretty prints paths with common prefix and suffix overlap' '
 	mkdir d/f/f &&
 	git mv d/f/e d/f/f/e &&
 	git commit -m "d/f/e d/f/f/e" &&
@@ -261,7 +250,7 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 	test_grep "myotherfile.*myfile" actual
 '
 
-test_expect_success 'basename similarity vs best similarity' '
+test_expect_success 'rename prefers basename similarity over best similarity' '
 	mkdir subdir &&
 	test_write_lines line1 line2 line3 line4 line5 \
 			 line6 line7 line8 line9 line10 >subdir/file.txt &&
@@ -278,14 +267,14 @@ test_expect_success 'basename similarity vs best similarity' '
 	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
 	# subdir/file.txt is 88% similar to file.md, 78% similar to file.txt,
 	# but since same basenames are checked first...
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	A	file.md
 	R078	subdir/file.txt	file.txt
 	EOF
-	test_cmp expected actual
+	test_cmp expect actual
 '
 
-test_expect_success 'last line matters too' '
+test_expect_success 'file similarity handles missing trailing newline.' '
 	{
 		test_write_lines a 0 1 2 3 4 5 6 7 8 9 &&
 		printf "git ignores final up to 63 characters if not newline terminated"
@@ -303,10 +292,10 @@ test_expect_success 'last line matters too' '
 	git commit -a -m "rename no-final-lf -> still-absent-final-lf" &&
 	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
 	sed -e "s/^R[0-9]*	/R	/" actual >actual.munged &&
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	R	no-final-lf	still-absent-final-lf
 	EOF
-	test_cmp expected actual.munged
+	test_cmp expect actual.munged
 '
 
 test_done
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 59e71e3acd..198de5d039 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,23 +10,23 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'COPYING_test_data >COPYING &&
-     echo frotz >rezrov &&
+test_expect_success  'prepare reference tree' '
+    COPYING_test_data >COPYING &&
+    echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     orig=$(git hash-object COPYING) &&
     tree=$(git write-tree) &&
-    echo $tree'
+    echo $tree
+'
 
-test_expect_success \
-    'prepare work tree' \
-    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+test_expect_success 'prepare work tree' '
+    sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+    sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
     rm -f COPYING &&
     c1=$(git hash-object COPYING.1) &&
     c2=$(git hash-object COPYING.2) &&
-    git update-index --add --remove COPYING COPYING.?'
+    git update-index --add --remove COPYING COPYING.?
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
@@ -44,16 +44,16 @@ COPYING
 COPYING.2
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#1)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#1)' '
+    compare_diff_raw_z current expected
+'
 
 ################################################################
 
-test_expect_success \
-    'prepare work tree again' \
-    'mv COPYING.2 COPYING &&
-     git update-index --add --remove COPYING COPYING.1 COPYING.2'
+test_expect_success 'prepare work tree again' '
+    mv COPYING.2 COPYING &&
+    git update-index --add --remove COPYING COPYING.1 COPYING.2
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
@@ -69,9 +69,9 @@ COPYING
 COPYING.1
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#2)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#2)' '
+    compare_diff_raw_z current expected
+'
 
 ################################################################
 
@@ -80,10 +80,10 @@ test_expect_success \
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success \
-    'prepare work tree once again' \
-    'COPYING_test_data >COPYING &&
-     git update-index --add --remove COPYING COPYING.1'
+test_expect_success 'prepare work tree once again' '
+    COPYING_test_data >COPYING &&
+    git update-index --add --remove COPYING COPYING.1
+'
 
 git diff-index -z -C --find-copies-harder $tree >current
 cat >expected <<EOF
@@ -92,8 +92,8 @@ COPYING
 COPYING.1
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#3)' \
-    'compare_diff_raw_z current expected'
+test_expect_success 'validate output from rename/copy detection (#3)' '
+    compare_diff_raw_z current expected
+'
 
 test_done

-- 
2.53.0


