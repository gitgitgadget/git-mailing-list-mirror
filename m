Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A74E324A
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674888; cv=none; b=NciNgoiRsAlsLOrcrX4frcxPxDPerozLFtcTVQAPDCCik5y/oG4hUky2nO/z6D4AisvKEID/56Rs1cbnnF1bcmd+eJAR7t5nozwTKbwqJYcYJVGDSfYvqDnhbFEsYhILmkG9qtqYvboQ+Vx6FMicBSBHwjODne+7DPUNX9Y5k0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674888; c=relaxed/simple;
	bh=iiOE8f/uG//C4Fu4aIJ1TVsz8BJ4chgcFos6JkkYV6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/AJe+xMBGllxlLGKnsm6R4qWacz6iEVJqbY+LKepv43Dy2X1M5UDVr6WR1+EAfWSToTtV8F88Gh7aJ+Dg+mbm8LoWZZAOyS+09ix5afmsRo1CZ1Y29xpYLEKgjDo/pXKnBVZJl3PYi8KR+MjDBaX7o1t3MBHsdujhBl/dCnBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cAUYz77t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzSSjtsI; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cAUYz77t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzSSjtsI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id D145413801ED;
	Thu, 17 Sep 2026 15:54:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 17 Sep 2026 15:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1789674884; x=
	1789678484; bh=JtHXXurOPA6y9ApZGRE6DVV+0zI4mK6pCQTJkQ5Pk0M=; b=c
	AUYz77tgY5o5p84FOBbOTHRZJeuXTHeM6mDedjCcC6LVs0aIbU8CuurFd9Wb7yNW
	bzCY0W6X6fzC8hlqz24zhRxO/xhvlnbjrBAgq914xR9HCFRHuBC0QaldvaaNr4Du
	Z4/1yem2833jnF1G/Q42jvIlsFAUI55i/0QSoPV5368PSJrf6noyZD6wN2FwQ/OC
	JxVMJDOncBLp8X1bUPBRl+yP3ZKDhOd/17BfY5k1csIdnokON2kKymmQC1r5WlTE
	mvjL4YMzYPPXfJbc1DDj89llsb9/cyr/12Djq8TJJuB+jrlkrnmnvQ75WgbqwGsO
	IdedTs8bRX3RUnKts9mJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789674884; x=1789678484; bh=J
	tHXXurOPA6y9ApZGRE6DVV+0zI4mK6pCQTJkQ5Pk0M=; b=dzSSjtsI9W41K5uWa
	7xQKP5oaaCISgMwCrkHuMROGi1JpCVQLc0mnN9wfVrF8vbeUU3tF/PnNKI1qQ0+f
	vrfHPmMY7uaHgcWLH7j4YkAVzNRRWTDPkPDyLpM2ws1rFht0gbfhRwttQf1L+jt+
	FMIRT05p2TXR5m+ZTQW9cTbeW181LR1lDnh7JCXIiHADBTDw5E4tuZC8OSLk2i/5
	BEYLwC4rUFXCX/FdZ8xHPNjYM2IuMpBVIUs9lQa+MigA0J5khP3ht5CMrgfy2Vy8
	arrSeaBSgAkL5YHS1miIgxrSOdrucYXm16Uw17JzECkUMv6svlzJqDyGM69ihlX7
	k9+lA==
X-ME-Sender: <xms:hEWsagsuTVoz_FzFhEAwcemF1DUssDh0sV8PZhgA40KcCoTqACNw_Q>
    <xme:hEWsajcc8p5KFm1BCn5dRTNGlXgkU4R1YptV12RpZl0QxEzzF8EMjvZqyt2gEFtCd
    ed5pHxqxrhXBDdfPr4_5j-FQOfL7LAHIbKRqApgR2LHZfN0BmW2DRFuNA>
X-ME-Received: <xmr:hEWsapZjbBvVggtAlRzXF8kzeHWtWfhvP24oZI3GxOrSZtWdkEA0-rZZTL9rbmOX8YAwfvWAY8AnjR8IQ_OCxXRBhleclX49133wKlE6QV7guQ>
X-ME-Proxy-Cause: dmFkZTFd5n3QdA6V/1Qo+bttjxkXarVLag2WIyBugSx2ET6iok0cG48E4NJogkx1Fmgdip
    S6pllqJ0q3lPE/Mrm86OjM8LsHMstLXle5G3cB3wikwlf4++mkRO4z7/yGGb8vhtFIScpf
    52i6whuu1Z5uBKxoLUMUsfjwfWPa/3ieIU1WnkNwQnPe3a/xUrrIU3sG8EbwHsl8FHrx31
    7ABHMGfS+OmyS58TXOwVIOHAW5FqKmH8KDwPRnRlA7ESi97ufzwqP5vUs9duGLdP7VUh2M
    q+uQSZqZeiNQkpjeNSla1JJZkhWyNATPZTGnQE8TimAykwkS8cRJ9GsI9EJuZT6mxsFLCn
    q9wBi4eFG/pp8AGknqEAr1ObRQPM086dfS1mCK4w0ngpKfzYTJpF+lpNagqB2f1u6u9bMR
    2ZNJBlTaSpZi5sKN7ff3P4Lp+OKOXmFRopoQ33i+KK69feiB1S5vLft09lwLtFrZevK+fa
    PvMzMYrJzW6mlLz5lxXjw4UhDK5GHzAyPJeIJDKz8D/8gm5tFMd0CZWhyWMpnd4cmzSeGL
    FEXhXBVMOor1QGP93t3Igjslm6XKPkX+IrlwsEXQb0U8oeXd4UGmGtRgJjWbQvVCVzUBf+
    coXyVZdSEG7RFMOHF/0rU+5vIlZ49WMCVsEprwzVnMtvpbGf2PYE2j2WNbQg
X-ME-Proxy: <xmx:hEWsauVzwRhNEWG4YnCMNfeaqIT2QulsOQMTtb1GucovvTAOVL51sg>
    <xmx:hEWsajiUYK_60qi9UneapRPxQmfLDhuH3pZQsZTAK9tgJ5rLgk8oMw>
    <xmx:hEWsakVXgULbGALHp1CFBIlqw3zDJXhG_uYQTv5n66tssVXe_KBjnA>
    <xmx:hEWsaiPZqqoaZ3id6yEkwgOUMamloj2NFkZF4G9EojfB1mogvnMpeQ>
    <xmx:hEWsav7rqU6Goi_2yqSjL5mFWKdkpnUqHxR5zWazVg5DkkGkNRZb9zyi>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 15:54:44 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 1/3] Update t/t4001-diff-rename.sh to modern style.
Date: Thu, 17 Sep 2026 15:54:34 -0400
Message-ID: <20260917195436.1102981-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917195436.1102981-1-markchucarroll@fastmail.com>
References: <20260917195436.1102981-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old tests were written in a different style than modern
ones; for better readability and test error messages,
update t4001 to the modern style.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4001-diff-rename.sh   | 97 ++++++++++++++++++----------------------
 t/t4009-diff-rename-4.sh | 54 +++++++++++-----------
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

