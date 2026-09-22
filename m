Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE173C3F44
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108559; cv=none; b=RlZ8WjCFuv+mZaK7tDgUdBbqMQr3kX+rkNbS9fIRl0+KEYYZ7cl1QuYSau/A83FCSEQ95FQpcK/Bp8TeH8ovNKQXW7Z3k8v/UHFyX+jiUQjCoLe2h8H+k9f7JXq2RwHIwxcJxPnVyzMce7R8qMr1wd/qznA0JIGSDi1sIvXm2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108559; c=relaxed/simple;
	bh=GufLPfo7IOSLB1Zw3ie3pxvaanRB7wrYVrw/hIHIKA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqbm+WdUeJqpYZIVkjQh5XLnTjHKBlmFTzDpC2O8v4jS6djqjEtvDow9Q862BO3J0fICle/hpV+m18mhyZD3A24c1nxy0isaLuBzawRfP/gFPR/MAiSrUEsAjMXuBg10St3kw07yJc4NU+KUOhG+11/I59Yhz6nnjU4OcQ1o4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KM8GxTtd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyjBFOYM; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KM8GxTtd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyjBFOYM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 833C413000E0;
	Tue, 22 Sep 2026 16:21:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 22 Sep 2026 16:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790108516; x=
	1790112116; bh=TmYeCJdQ1jnnyqSJvARL7dPZJrG/vdGmdZ7g89nOxvw=; b=K
	M8GxTtd6ljNP1Fd1dqjOa2rae4NN625l905vcRDAe14IIOou4At5snT4a3otO1W9
	vCBFqyw25XHzCu21nuR1TqcMCjr1EyLFaGy4JzIb3399T+fmuUxMCL378UyRQ1gi
	/o9Ch5X32xjLL8TF9fJTghpwybQhXjgNV+rXLLqxvzdQMKyJmZTvzNSy5uB3dJCY
	yUxVXKmMyrj83tE7S8XFNXYnFBPh3i8a01xLdnGxFfrtAkysGXGMkbWCzJATrWeX
	GeO+8V8auRCuBF9qLEIQBMBYDmoGqF3MDaHX+z+IKqlK4V6eRSpyo2yb/lZXlMch
	gEBZHCAjNQlebPbx/Ooiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790108516; x=1790112116; bh=T
	mYeCJdQ1jnnyqSJvARL7dPZJrG/vdGmdZ7g89nOxvw=; b=HyjBFOYM2+dUBaDln
	XkZgfInXhf4aWeP7YgAW9TPb63J5RPrqSjHncMJIcp2Cpd6Vo11Ae5jpRrUA/f81
	nU2bqzYwFPJDuqDXsqmNhI8Srx50z1K1JS7lw071b8cZZBpyh5HzKOARKcWwXi99
	fAJkOTdUjmKlBSgW9x+zESYnhQheTHA/m6aanQtPThrDPwtZb99eWZ2tAF60yIPt
	dsaMGDu92bofccGkFzrEfU38A5eTn0JlkDPd9jd1S7a0QpXwb9sxJHlIC4pSCDJK
	a0PZWsQxpJkGXDXOvQsd34H2JHSB54lFfFDb/eXD2hop1+zljRwiqb9qWyoW8jWY
	fJmQQ==
X-ME-Sender: <xms:ZOOyakQCCJo9VCDqjkwFHVHQv4HowGNh4ZDEiXJVSkojdbLuV4PueQ>
    <xme:ZOOyanyuta77IJEK7807csDbI6xy-iAb-OhVwmB9jjjljuXWAAYMaAHN2dzTEl8pS
    XYGKIImu9l4vzjRPyu3bbllkm2Miiib6TG9GZz5BmF90t87YDmZsaIs>
X-ME-Received: <xmr:ZOOyaveotzTpRXzcZY2RZBIXvKoLYQ17_BM_uDi4MV108WksuPm2PmJVX4rDMFUpKp0PyJju1-Ki0isIXs9K8eCFz5WtpqqCg2oPdkNurcRqWQ>
X-ME-Proxy-Cause: dmFkZTGCYogreECxIvFvsaYuJwFw9zKXvYK/3LuFDw1I6XScytqA3DmIYi28PuUsLEdtBi
    DkuyipRnWjlzPZ5XdPDeK4dLAIz/MHdOVl/S7PUdtAa9+u9ElbebxHhsmqa5ir+bcMnOrG
    MTYZ0MpAsdVc2p4ShIvC5H6Vm6trk/af9xTcLbMvIgaHZQEyn7c6zL79tYTTpzL4W//0Wa
    0ykV/A4EwZvgPXX80OVtok5Lm15DK7Ay6gGv4KUWxANL0/0uj/ASF4+DO7CaNBziVaFL1Y
    QEqkD/oe2jWozyA54GCEgYdUIKePAvSGu5VfOyaagqjSRvQ/Me6amtB5o4d0pMLchUe0ix
    AaaIid5JEK5xf6D0TC4SNdcPG5mglox5y4eh7rfRtG3s6/gigLHtc2W0CqS0tszdJbkXOJ
    /S+Dhz4Vu9us0NNoJGkKMlINaNAKqykmYghwhjiP3lzATX0e+pFxFOaBZkZL+CIkgCK17O
    Y9Xz0dfxp9NJ/otZPpEwj5uLl60tgzIuRZZrwFka7Ruf8Yac+tStXYi5EoeBHdM0SCffrL
    zvg9/jwQepiw/P5O4PTbuTXY+3zfqW/M0ObZhEsTHxfp4qK1bdwZNeJLuJNj4+hnFfwiA+
    D4g+MUoEpBNwNw3az9Wf12dGmyqVyywLNO6NG6/va9ZCVv3fEVZMSOUC7rTA
X-ME-Proxy: <xmx:ZOOyajIkj5Fni117S9kXLhPokpH3ftpT7orL55Q6jyg8RYnHccS6jQ>
    <xmx:ZOOyagHTVTifQ54EhM1uAevjInwEGdUPHiXu57RB2ufekE-eKIKmFA>
    <xmx:ZOOyatqooRiSVR-ppH5MYoooMKllBjYMycjycUxUkn_QNUIXaLFY9Q>
    <xmx:ZOOyapRzFUsUHGFlpSoCtXHb2eB8g6bLw0guD7X-EAqB2EEgfnGoKQ>
    <xmx:ZOOyanMy72qJRUSDNBlQLZLwa6h7ADTz4m9T9RnJmOQvXo88k4gWQ4aE>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 16:21:55 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v6 1/3] t4001: modernize
Date: Tue, 22 Sep 2026 16:21:50 -0400
Message-ID: <20260922202152.842793-2-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922202152.842793-1-markchucarroll@fastmail.com>
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
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
 t/t4001-diff-rename.sh | 89 ++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 51 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index ad474100af..1a2474af10 100755
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
@@ -184,7 +171,7 @@ test_expect_success 'setup for many rename source candidates' '
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
+test_expect_success 'file similarity handles missing trailing newline.' '
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
-- 
2.53.0

