Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74B45628F
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087487; cv=none; b=P/z6o2qGLRUuTMYezbCHPZliEv+1oe4rABUmX/2BQGWm0qpctanhu0fYXFVDqBov1hp+Z3oJVd73inrkIETeFzk2ZhKDFMJaNh4e7L0V4Nm0ere35qQV9PBLS9d9/wRqcoSLwFjmh9n//uMo+Z+Vlo69jnii0FpBhu2Okk8s118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087487; c=relaxed/simple;
	bh=bbJxzS9LlIXzv2E83lSa9YmA3dBhbf4KZ6us2w4ciUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw5J401XPH9al//8BZO5LiNw1z2udtJU6r/buN1L3KEKpcNLi/X8GHrsUf84gRJrJyEn6sjuUhOL8qL9cNOTrLZFoGuf4kcF3bCYBux6ZnbP9yzu0pZ2STxhnj0leyr8Ldk6WYrkzrg6oG/JX/AhEQhVWN8nlLd4tQupiVgd+Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BA6IGJNR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G+U/8c3W; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BA6IGJNR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+U/8c3W"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 8EF7913003C8;
	Tue, 22 Sep 2026 10:31:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 10:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790087484; x=
	1790091084; bh=cIj3yxS+KA1oNO9IYP4rlELfgu2GapM4R2xs7HyVCFQ=; b=B
	A6IGJNR5/Q/9ESebZ5ZmYMtkFMPxj8oGNmHuognLwUtq5OC5m0tZWZRD8k5NlTq7
	AcByAD7Eywa1ckiPP0KUZurpgit+dIb4uRaZvwTCdMCn838jhsCjKyhcYwna3EQV
	jyE+EhGL+R5Vf8yN82ZV0YYchjF/nHJ0EvI1wlKGOMOAnA0kG8zqpAYoWrnNPSQ+
	4nt9K5NgeDArfSGPxCcyREUR1oVEWANoDEutqlV8+7c33yPhWbqT5HJVDk4XI4nf
	zIPu+gohsI75okmBzfpx61oN2HghaZ+7B3+mR/4amtdCzwDc2b4aKaUQNefpMQXU
	XJ3YbrsmPlP7rqrskKC6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790087484; x=1790091084; bh=c
	Ij3yxS+KA1oNO9IYP4rlELfgu2GapM4R2xs7HyVCFQ=; b=G+U/8c3WOqfEglQfE
	FYKRWNVdK+H9WRwxtUiEUoauAzKid4DzzCU6L1jKReDH6crOZ3noTBz0hyXcClw5
	p6Jwzi7ip9ojKQOJiA7MZL3YHrbXNUghP6vfbbAsskLFs/V056UZ3AkiQSsRnrKD
	H8QFi9mJDVEwkt9+syQleKkVUHigViCutwu6VZkzb1BIds4QalBGDNiSzrYJTrWh
	uvgZ68rzmzEergk090YHOeA4AaM88t7vPZAMkVFXevKO2ntHIS4pf87KeLdUVf98
	fTO8trBbaMFDDNh7L+tWsNj/jV2xtcQ4sZD/FcM+3KXbrY+j72ny9RS+B5bHRNKk
	DKsbw==
X-ME-Sender: <xms:PJGyamZLS9N4HTF-3dI779wmqHEurTFO-9oNbOPbnM2_w_yRNu6LPQ>
    <xme:PJGyavZdaGtDlfc3FkYWvtDD5nxJYENri8Y2CZSlec_hMX4TizT0Dely9dAPxGy9f
    1mP6YfLDOMhgwaSW4Dv8gfq6UenFJMgAVfEC3-4QYi1j_N2Mr8zw0ExAg>
X-ME-Received: <xmr:PJGyaun766Zu5HDak9QrDzV7gTDpEVJNfT6n6QRj5DSdpwac9KSbpxpLGBEbsWcdnamNQJPT9-OcutczOeFeIrxO7FNzseS-ffSGYAlZEzJB2w>
X-ME-Proxy-Cause: dmFkZTGP46YC6q8ZS3oonxOjMTC8HCqj8daYDtrYqYmUEi+Bj7yDT49A11ucpAmi6NOwbE
    bYPMC/PK7ijGEx3KCLyNJV4ENog/lKljYFCb7OmPy/6Ib0hckN1c0hOW408V2srDVEV37R
    Wt0YOEqKR33HGn05ImrYjn2QJMTRlOtLICsR3jUVxfmA8isF4S8XeLrFnAvx+VV+e20GAQ
    jLnaAe1yTYI09FIuCk2734LLj1Ad6e/2dKFMb/MjXw3+q8iVXlvQyU5vcXVWgdQKgLIHUO
    xRCZEyn025iW7UlArYlUbnLpmBhthU8vvgiTwjzZiBB5En9g0LphA/i07BhhLkbsPEIKo/
    SupLP5tOd+Qj6Iz6L9psWLhImIkGH4V6o9fwro/3lJ/fC4HbgMl94cFuckDv/5X9KCG+y5
    yIGpYTTquWqChAydx6HPewFvxwk8puY64xm/JREA699DgeGfM3gt331SDL3vRV2gPPizVJ
    PX7/xT0dpeBnA+ihWovhQLrFBlzG6cdUH93GOb38OXuWhkmK9q+jrIB5Xbvk4W/3Elx+ks
    G9ohrU2FJDLiyIwTaolH9mZljaTK6JmZSiyxbNjfOYzDRUOcGFl1JwhpojMEg6doNgDnKK
    X8eZJZTddYIpyGUPEIrIsUf8synv2h1D+9qAaZzYRvRodBOiDA74WDULKSHA
X-ME-Proxy: <xmx:PJGyajzhc4cDuTNKaKA9Ak1MMMQapVfOyYZVc8ilp2GDg6dTe83_Uw>
    <xmx:PJGyakNMyV2VVyORsOAvDKafvNn2TbuNIv2odII3Wp7sJbvG5iXbog>
    <xmx:PJGyavSVlc7A60v73TL0nczoajrM_CS4PGZ-gsqKi53ctNA0vNCNSQ>
    <xmx:PJGyaqbD7gocAzdd5zgdguChAujOvL9hMuJMpdT25D250-vkYXQ3Iw>
    <xmx:PJGyak0zSPZ1yk94gRBRGRqgHlY9WxHIPgA97rmxaPcpqKdUL3XbVaCC>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 10:31:23 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 1/3] t4001: modernize
Date: Tue, 22 Sep 2026 10:31:17 -0400
Message-ID: <20260922143119.3313620-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922143119.3313620-1-markchucarroll@fastmail.com>
References: <20260922143119.3313620-1-markchucarroll@fastmail.com>
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

* run everything inside of a test_expect_success block.
* write title line on the same line as test_expect_success,
  end that line with a single quote that opens the body of the test,
  and end the test with a single quote that closes the body.
* write expected output of a test to a file named "expect",
  and actual output to a file named "actual".
* write here-docs using "<<-" syntax, so that they're indented
  uniformly with the rest of the test.
* make test names more clearly reflect the functionality that
  they test.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4001-diff-rename.sh   | 91 +++++++++++++++++-----------------------
 t/t4009-diff-rename-4.sh | 54 ++++++++++++------------
 2 files changed, 66 insertions(+), 79 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index ad474100af..158cc66cec 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
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
+	cat >expect-no-rename <<-\EOF &&
 	diff --git a/path0 b/path0
 	deleted file mode 100644
 	index fdbec44..0000000
@@ -86,47 +86,34 @@ test_expect_success 'setup' '
 	+Line 14
 	+Line 15
 	EOF
+	git update-index --add path0
 '
 
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
-
-test_expect_success \
-    'git diff-index -p -M after rename and editing.' \
-    'git diff-index -p -M $tree >current'
-
-
-test_expect_success \
-    'validate the output.' \
-    'compare_diff_patch current expected'
+test_expect_success 'diff shows path0 renamed to path1 with edit' '
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
+test_expect_success 'with diff.renames=true, patch includes rename of path0 to path1' '
+	git -c diff.renames=true diff --cached $tree >actual &&
+	compare_diff_patch actual expect
 '
 
-test_expect_success 'test diff.renames=false' '
-	git -c diff.renames=false diff --cached $tree >current &&
-	compare_diff_patch current no-rename
+test_expect_success 'with diff.renames=false, patch does not include rename' '
+	git -c diff.renames=false diff --cached $tree >actual &&
+	compare_diff_patch actual expect-no-rename
 '
 
-test_expect_success 'test diff.renames unset' '
-	git diff --cached $tree >current &&
-	compare_diff_patch current expected
+test_expect_success 'with no setting for diff.renames, patch includes rename' '
+	git diff --cached $tree >actual &&
+	compare_diff_patch actual expect
 '
 
-test_expect_success 'favour same basenames over different ones' '
+test_expect_success 'diff rename favours same basenames over different ones' '
 	cp path1 another-path &&
 	git add another-path &&
 	git commit -m 1 &&
@@ -137,25 +124,25 @@ test_expect_success 'favour same basenames over different ones' '
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'test diff.renames=true for git status' '
+test_expect_success 'with diff.renames=true, git status includes rename' '
 	git -c diff.renames=true status >out &&
 	test_grep "renamed: .*path1 -> subdir/path1" out
 '
 
-test_expect_success 'test diff.renames=false for git status' '
+test_expect_success 'with diff.renames=false, git status shows delete/add' '
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
+test_expect_success 'rename logic favors common path segments for files with the same basename and content' '
 	git reset --hard &&
 	mkdir -p dir/A dir/B &&
 	cp path1 dir/A/file &&
@@ -167,7 +154,7 @@ test_expect_success 'two files with same basename and same content' '
 	test_grep "renamed: .*dir/A/file -> other-dir/A/file" out
 '
 
-test_expect_success 'setup for many rename source candidates' '
+test_expect_success 'rename with many candidates' '
 	git reset --hard &&
 	for i in 0 1 2 3 4 5 6 7 8 9;
 	do
@@ -177,14 +164,14 @@ test_expect_success 'setup for many rename source candidates' '
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
@@ -192,7 +179,7 @@ test_expect_success 'setup for many rename source candidates' '
 	test_grep warning actual.err
 '
 
-test_expect_success 'rename pretty print with nothing in common' '
+test_expect_success 'pretty-print paths with nothing in common after rename' '
 	mkdir -p a/b/ &&
 	: >a/b/c &&
 	git add a/b/c &&
@@ -206,7 +193,7 @@ test_expect_success 'rename pretty print with nothing in common' '
 	test_grep " a/b/c => c/b/a " output
 '
 
-test_expect_success 'rename pretty print with common prefix' '
+test_expect_success 'pretty print paths with common prefix after rename' '
 	mkdir -p c/d &&
 	git mv c/b/a c/d/e &&
 	git commit -m "c/b/a -> c/d/e" &&
@@ -216,7 +203,7 @@ test_expect_success 'rename pretty print with common prefix' '
 	test_grep " c/{b/a => d/e} " output
 '
 
-test_expect_success 'rename pretty print with common suffix' '
+test_expect_success 'pretty prints paths with common suffix after rename' '
 	mkdir d &&
 	git mv c/d/e d/e &&
 	git commit -m "c/d/e -> d/e" &&
@@ -226,7 +213,7 @@ test_expect_success 'rename pretty print with common suffix' '
 	test_grep " {c/d => d}/e " output
 '
 
-test_expect_success 'rename pretty print with common prefix and suffix' '
+test_expect_success 'pretty prints paths with common prefix and suffix after rename' '
 	mkdir d/f &&
 	git mv d/e d/f/e &&
 	git commit -m "d/e -> d/f/e" &&
@@ -236,7 +223,7 @@ test_expect_success 'rename pretty print with common prefix and suffix' '
 	test_grep " d/{ => f}/e " output
 '
 
-test_expect_success 'rename pretty print common prefix and suffix overlap' '
+test_expect_success 'pretty prints paths with common prefix and suffix overlap after rename' '
 	mkdir d/f/f &&
 	git mv d/f/e d/f/f/e &&
 	git commit -m "d/f/e d/f/f/e" &&
@@ -261,7 +248,7 @@ test_expect_success 'diff-tree -l0 defaults to a big rename limit, not zero' '
 	test_grep "myotherfile.*myfile" actual
 '
 
-test_expect_success 'basename similarity vs best similarity' '
+test_expect_success 'rename prefers basename similarity over best similarity' '
 	mkdir subdir &&
 	test_write_lines line1 line2 line3 line4 line5 \
 			 line6 line7 line8 line9 line10 >subdir/file.txt &&
@@ -278,14 +265,14 @@ test_expect_success 'basename similarity vs best similarity' '
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
+test_expect_success 'file similarity handles missing trailing newline' '
 	{
 		test_write_lines a 0 1 2 3 4 5 6 7 8 9 &&
 		printf "git ignores final up to 63 characters if not newline terminated"
@@ -303,10 +290,10 @@ test_expect_success 'last line matters too' '
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

