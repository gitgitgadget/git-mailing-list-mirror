Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B921B4121
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891384; cv=none; b=K1LM/vAGhX1fbiIBhw7wxP4yx0QugIFcLOj1kvT9AhvmJDOxcDu0INoElLP/o3B0K1NbW0GuivFpj70NKtK0oh9V5L7LM05t+w+6v/kQf70zMvNE0xqvybDrbP14QNAwwyf60ghScxZfX2oqqsZGqu2jITwdvaU0fyt16eP4zT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891384; c=relaxed/simple;
	bh=eQDaywMryGD9qoI4LN3ZRAKFSR8vgNwdXzv8+VfaNqM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fnkCyn3+8Pplt/eFbtkE7qoQaZht+uAOSe68aNuYXyU+gx14ultLZKb/ZbrJmMQmcdxogEOrxSCyQ/khQDD9zgF0Ww0aLbsiNTCccO3JOFIvsrS6vUnPJyqFxgx6PwpHGuOgLfvbjCXJKzguytEPkB7Mx4jbeKy1HKG2sxHOIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu8lbI9g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu8lbI9g"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1829293f8f.0
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891380; x=1744496180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biLnA53hH5y77Z990FWwV2p7yC57RTDCCo9D8LlxrLk=;
        b=Iu8lbI9gTR7xBCs3vPlLfDzQo6gVMfZwSm8DEV1rYsn9VSHBrRaPO72RruMSUDY2NT
         dA985GkqsydwxD+kR0Y2dvHBLr9ZRmE4qJ7EVjJmq3j2cO2ZgBBUGBNQ86yMO2uImmRL
         qmAOElNhv/gBOU2g1dKDYqcFoZMaNdDizRL29Y4QQ4tOUQ5z+q+ML6NasadCx8zn7Hos
         RzjTxp96ZPtliG6p85a1efd7JNRNB1bSDAoEijnyHTzC3uVSb1L+TNd33J/qJGgZpnVj
         IlxX3OI2Al+V6Nxw4zAov3d/V60D7cEb4WtDII+70sYmWUkXW73AmcY7ajYms2sKmhlt
         Tw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891380; x=1744496180;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biLnA53hH5y77Z990FWwV2p7yC57RTDCCo9D8LlxrLk=;
        b=AEOqZyilglQG7hG7nWXDGwvIRFHdQwgf08SJVrp7UNCNRuvsBhiRMvIK7GmzFGDOU1
         cc6Z9XpaIzeF5EAbzsDCRpkOSkbdfM8RfZfTBYct4wJkic6G3lhMXAZC6FbE76MuUQsx
         RX5iv4dN8Dsa1y3XaPpUcyYyS7K03R427KCMBUWeyIhKEuZlsKpuat43I37Tj4Vw20Mh
         Oro/0F1dRA5MN4ITXKn2vHMblvlhIpJUY4jy/s75Zpyo+i+ikO4V5FiE/vYCqmuB5QPg
         3MNlqnprssyMzhtNkOgjtyNFjj1X6X/YVtXewVbc5LKTiVK16S+yWySl/spGSrTpQB2O
         BXFQ==
X-Gm-Message-State: AOJu0YzjeihZt6KrPXR8bEVKd0HYZXz88DZP7uf56jDq+2RXd1Gz5rzD
	y9LS845IxggUQs6Le6G0PlY3+VEXmD4yWZz5mI8WSVuyypyTUXVCcVWPxQ==
X-Gm-Gg: ASbGnctfsKpNg4r3cqa9pp1YVr7Yv393jqnrpudsxc3OyIlI7qfx0Rz55YFPgp8IdPv
	FWFsA9W5eXrmt9x/DAAX1R/b+oTtvY+mfTsgw3SauZitgYyiDWTfmtm9ko8qn0n28kvYw68y1Ic
	nCz/ilZYi5IV8ogGZS0clhf2lubkjvjwVOQX5HWt0Zat3e9KgOEhhU0DUaogolBUom9Oedkn+0e
	JTooK7BwJWl/6UNd2rfwLClFDXl72S9q53bgVH5Pa0WSHacVDmtgzRhFtS6mFY/gP6FxfBu6AFm
	epQmTsKCy3pOCdWbvRXQ1URf/n5EiPPCtjtyA0d0+qIxnw==
X-Google-Smtp-Source: AGHT+IEcnZXHNBoz/7DNl5HX6xjkh1cMQ56Lq8Kmwzh4BiIHR2kcW7DDfWH27SnsxHj5aUaF2yaj1Q==
X-Received: by 2002:a05:6000:400f:b0:391:4674:b10f with SMTP id ffacd0b85a97d-39cba9332fdmr6705344f8f.36.1743891379562;
        Sat, 05 Apr 2025 15:16:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301acec9sm7825429f8f.40.2025.04.05.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:19 -0700 (PDT)
Message-Id: <b093d74968b146987fd7ea2373c3879d69fdf448.1743891375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:08 +0000
Subject: [PATCH v2 2/8] builtin/merge-recursive: switch to using
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

