Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712CC22D7AE
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127331; cv=none; b=S0ET83+hfc1uVSOGqyuiUoTgeQBpoU7YbgRNL4TbRXACFHLrFftSrdmG1wa9nNA9ogMZv9k+WzKVXVbM7VAUJnwtmdvCohif+ChTn3IYlti39HuWmiuYWRNz1EJ+T7qy9SQUvffItAVEUcZB9F9A1yUwqUHK3ObVsaXFWE5FT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127331; c=relaxed/simple;
	bh=eQDaywMryGD9qoI4LN3ZRAKFSR8vgNwdXzv8+VfaNqM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nh8d0gMKUxpa+zOaK3ValIvMItV0OgF2oPFU5X+u5ltj3pOYOxuyrmNXSP99yaU8jIKejf/16lA2CwHs/IfvtDsBOrDxVgwLMFDF1zui7stpGbYQ2zCmqLd7+NPw17LLTGYxM3vn85RV20QIsl6TgJ0VcL0U4NryVdAMABIkNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai2Q7VRr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai2Q7VRr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4664199f8f.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127327; x=1744732127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biLnA53hH5y77Z990FWwV2p7yC57RTDCCo9D8LlxrLk=;
        b=Ai2Q7VRrT+r2mv/ztf+QOsRcTZ5JW2d3M7FnQ5frXW0udOo5vhAnj8DsW/hsKGnh5m
         TiUvia6wqYLptQD+xnFXErjtaiZSsF95gC9hdVe4TE9BsISIePPq2gvk37TUq6at3ckJ
         lCG22UcV7Qwd13kPx5XYq+9mNj7z5sJsCRpJn0aqWQ2STGL6NoI5Tugq6ilOf/wSbRF4
         qVQPwN5PpT1ykf1ZUSYxbyqGDufYfeADPSRuG9jqkElvQtDD80/R7Yk6NQVCzAlPwJ0Y
         9xMtlp+/mf4TVLKOrc1nO2fW6OaTnqlRn05jcGwmcOTuVrNRwd39A8htYQAHEi+nwXV9
         +zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127327; x=1744732127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biLnA53hH5y77Z990FWwV2p7yC57RTDCCo9D8LlxrLk=;
        b=EldOAFf9ObASlyMAU/9cz01Re0NlGGtA6GLtXs+tO9z8vjA+mKFT27Cvh6HDewCl6f
         8hvHP3Q8yg/YxA6B90/ZDhdpvY6RBkTkeb3peqw796MA6Q4lc2TG+t6Cdwt0lMu8vrM7
         JX1m7Qw5BlyGew/Jz2+Jxk82bq8danZT1BnAneLZi+Wq0bd/KXSNniLvQPIjZ7dUxQxu
         0J6nqSo+DUrANS8d0kGXXLAk0XbxgeWDm3RP6Z2AteywXHMueXrw/z83QPRLYm3Md2EC
         sKqSUkydXcXQl7NuvM7mrdSTspASohUAfoasmauYWL3fU8uyVZgRABqXb82TrMiHWp0L
         OvwA==
X-Gm-Message-State: AOJu0YyPuYCnlHdziLDMELSGajGLu5VDa4fdhSF6g9emgUUoRDdWreaW
	qfcetOWPenGyslfqq+2TJZH2ni/E71qIETIRxW6TFN5Pv/OBsc3fym642A==
X-Gm-Gg: ASbGncuKmLDwyXLlDHbfmy3SgYEmyay2hpMV85HGQ/B4uIhpTBYu2ME45qQd2l6/hsK
	qKAk0B/iRYzZ5L+8g8+yUHWYwtPO9WwHXdZYDMjBVaO9sX5tkikEqZPYznIimgvBB4Sxw8ByX8F
	XElktdVsTGWYiQSjjPcX701sDYmDn47Ps93rCVloNZ3VuRT3YP8UkjzoMIbrmsZKJKMYOs7zpTz
	fAK1nis2NRko6mcTRDymqCGhFz4lPuGVtjGB7BZR+3hKEC2Il1FvXI0t6tMVceBMzXTM1SJmUxa
	LxP3qmfvPLpHgtEzJGb8Rv/Hy42aRqDfL1vAk70FxN7Yzw==
X-Google-Smtp-Source: AGHT+IEppi60VGrCI4oxap/iwVaE1HVccmolKz2DnGP/w11o9B14y7eN071y6da28eW8Ra0s/ZN7kw==
X-Received: by 2002:adf:9c92:0:b0:39d:724f:a8ae with SMTP id ffacd0b85a97d-39d724fabc5mr8492294f8f.33.1744127327138;
        Tue, 08 Apr 2025 08:48:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a79bfsm15663581f8f.36.2025.04.08.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:46 -0700 (PDT)
Message-Id: <b093d74968b146987fd7ea2373c3879d69fdf448.1744127322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
	<pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:36 +0000
Subject: [PATCH v3 2/8] builtin/merge-recursive: switch to using
 merge_ort_generic()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Switch from merge-recursive to merge-ort.  Adjust the following
testcases due to the switch:

* t6430: most of the test differences here were due to improved D/F
  conflict handling explained in more detail in ef527787089c (merge
  tests: expect improved directory/file conflict handling in ort,
  2020-10-26).  These changes weren't made to this test back in that
  commit simply because I had been looking at `git merge` rather than
  `git merge-recursive`.  The final test in this testsuite, though, was
  expunged because it was looking for specific output, and the calls to
  output_commit_title() were discarded from merge_ort_internal() in its
  adaptation from merge_recursive_internal(); see 8119214f4e70
  (merge-ort: implement merge_incore_recursive(), 2020-12-16).

* t6434: This test is built entirely around rename/delete conflicts,
  which had a suboptimal handling under merge-recursive.  As explained
  in more detail in commits 1f3c9ba707 ("t6425: be more flexible with
  rename/delete conflict messages", 2020-08-10) and 727c75b23f ("t6404,
  t6423: expect improved rename/delete handling in ort backend",
  2020-10-26), rename/delete conflicts should each have two entries in
  the index rather than just one.  Adjust the expectations for all the
  tests in this testcase to see the two entries per rename/delete
  conflict.

* t6424: merge-recursive had a special check-if-toplevel-trees-match
  check that it ran at the beginning on both the merge-base and the
  other side being merged in.  In such a case, it exited early and
  printed an "Already up to date." message.  merge-ort got rid of
  this, and instead checks the merge base tree matching the other
  side throughout the tree instead of just at the toplevel, allowing
  it to avoid recursing into various subtrees.  As part of that, it
  got rid of the specialty toplevel message.  That message hasn't
  been missed for years from `git merge`, so I don't think it is
  necessary to keep it just for `git merge-recursive`, especially
  since the latter is rarely used.  (git itself only references it
  in the testsuite, whereas it used to power one of the three
  rebase backends that existed once upon a time.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-recursive.c                 |  4 +--
 t/t6424-merge-unrelated-index-changes.sh  |  4 ++-
 t/t6430-merge-recursive.sh                | 43 +++++------------------
 t/t6434-merge-recursive-rename-options.sh | 16 +++++----
 4 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index abfc060e28a..03b5100cfae 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -3,7 +3,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "hash.h"
-#include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "object-name.h"
 
 static const char builtin_merge_recursive_usage[] =
@@ -89,7 +89,7 @@ int cmd_merge_recursive(int argc,
 	if (o.verbosity >= 3)
 		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
 
-	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
+	failed = merge_ort_generic(&o, &h1, &h2, bases_count, bases, &result);
 
 	free(better1);
 	free(better2);
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 7677c5f08d0..084bfe7e6ce 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -176,9 +176,11 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	# Make index match B
 	git diff C B -- | git apply --cached &&
 	test_when_finished "git clean -fd" &&  # Do not leave untracked around
+	git write-tree >index-before &&
 	# Merge B & F, with B as "head"
 	git merge-recursive A -- B F > out &&
-	test_grep "Already up to date" out
+	git write-tree >index-after &&
+	test_cmp index-before index-after
 '
 
 test_expect_success 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index ca15e6dd6da..c539a68fd07 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -373,9 +373,9 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a" &&
-		echo "100644 $o1 2	a" &&
 		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 1	a~$c1" &&
+		echo "100644 $o1 2	a~$c1" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
@@ -397,9 +397,9 @@ test_expect_success 'merge-recursive d/f conflict result the other way' '
 
 	git ls-files -s >actual &&
 	(
-		echo "100644 $o0 1	a" &&
-		echo "100644 $o1 3	a" &&
 		echo "100644 $o4 0	a/c" &&
+		echo "100644 $o0 1	a~$c1" &&
+		echo "100644 $o1 3	a~$c1" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
 		echo "100644 $o1 0	d/e"
@@ -424,9 +424,9 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o1 0	a" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
-		echo "100644 $o6 3	d" &&
 		echo "100644 $o0 1	d/e" &&
-		echo "100644 $o1 2	d/e"
+		echo "100644 $o1 2	d/e" &&
+		echo "100644 $o6 3	d~$c6"
 	) >expected &&
 	test_cmp expected actual
 
@@ -448,9 +448,9 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o1 0	a" &&
 		echo "100644 $o0 0	b" &&
 		echo "100644 $o0 0	c" &&
-		echo "100644 $o6 2	d" &&
 		echo "100644 $o0 1	d/e" &&
-		echo "100644 $o1 3	d/e"
+		echo "100644 $o1 3	d/e" &&
+		echo "100644 $o6 2	d~$c6"
 	) >expected &&
 	test_cmp expected actual
 
@@ -696,33 +696,6 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 	git merge other
 '
 
-test_expect_success 'merge-recursive remembers the names of all base trees' '
-	git reset --hard HEAD &&
-
-	# make the index match $c1 so that merge-recursive below does not
-	# fail early
-	git diff --binary HEAD $c1 -- | git apply --cached &&
-
-	# more trees than static slots used by oid_to_hex()
-	for commit in $c0 $c2 $c4 $c5 $c6 $c7
-	do
-		git rev-parse "$commit^{tree}" || return 1
-	done >trees &&
-
-	# ignore the return code; it only fails because the input is weird...
-	test_must_fail git -c merge.verbosity=5 merge-recursive $(cat trees) -- $c1 $c3 >out &&
-
-	# ...but make sure it fails in the expected way
-	test_grep CONFLICT.*rename/rename out &&
-
-	# merge-recursive prints in reverse order, but we do not care
-	sort <trees >expect &&
-	sed -n "s/^virtual //p" out | sort >actual &&
-	test_cmp expect actual &&
-
-	git clean -fd
-'
-
 test_expect_success 'merge-recursive internal merge resolves to the sameness' '
 	git reset --hard HEAD &&
 
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index 6e913c30a13..5a6f74839cb 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -34,7 +34,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 get_expected_stages () {
 	git checkout rename -- $1-new &&
 	git ls-files --stage $1-new >expected-stages-undetected-$1 &&
-	sed "s/ 0	/ 2	/" <expected-stages-undetected-$1 \
+	git ls-tree HEAD^ $1-old >tmp &&
+	git ls-tree HEAD  $1-new >>tmp &&
+	cat tmp | awk '{print $1 " " $3 " " NR "\t" '$1'"-new"}' \
 		>expected-stages-detected-$1 &&
 	git read-tree -u --reset HEAD
 }
@@ -51,11 +53,11 @@ rename_undetected () {
 
 check_common () {
 	git ls-files --stage >stages-actual &&
-	test_line_count = 4 stages-actual
+	test_line_count = $1 stages-actual
 }
 
 check_threshold_0 () {
-	check_common &&
+	check_common 8 &&
 	rename_detected 0 &&
 	rename_detected 1 &&
 	rename_detected 2 &&
@@ -63,7 +65,7 @@ check_threshold_0 () {
 }
 
 check_threshold_1 () {
-	check_common &&
+	check_common 7 &&
 	rename_undetected 0 &&
 	rename_detected 1 &&
 	rename_detected 2 &&
@@ -71,7 +73,7 @@ check_threshold_1 () {
 }
 
 check_threshold_2 () {
-	check_common &&
+	check_common 6 &&
 	rename_undetected 0 &&
 	rename_undetected 1 &&
 	rename_detected 2 &&
@@ -79,7 +81,7 @@ check_threshold_2 () {
 }
 
 check_exact_renames () {
-	check_common &&
+	check_common 5 &&
 	rename_undetected 0 &&
 	rename_undetected 1 &&
 	rename_undetected 2 &&
@@ -87,7 +89,7 @@ check_exact_renames () {
 }
 
 check_no_renames () {
-	check_common &&
+	check_common 4 &&
 	rename_undetected 0 &&
 	rename_undetected 1 &&
 	rename_undetected 2 &&
-- 
gitgitgadget

