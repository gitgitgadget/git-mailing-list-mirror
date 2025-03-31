Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAE21421E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436288; cv=none; b=LoPnoWtsNV/z06m4tyoXeh/w0IneFxYs1DUXVIjR2KlI09ndyw5Bc0njGMzz1XsS3dYiSEikTpAH4auIautX3oSZnmEjC2ZLrl1jzI2M4pFrOghh01TlUxNrY/FQgN22Oh2wPiignNiMJwQxXh8IRhSqR3zEKcousimuJ6EC+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436288; c=relaxed/simple;
	bh=knBvZnh172AyEmSyqxO7MRyFl0NjWwelzrkC2f3vQBw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GfB/yu7AdSg0Oh1Rhtpv1NY7Dvl0PNjU5rjktJeXqUtvRXeAG0AO3/gghxUWSgj/aAzPcr7zw0rreydcn4Dg9+XnQBQC3yfggZd5Gm/K1CWUyhhEDQ3ZVjniigFpg9wI3sqhGmLyeFUvm6PiaexLS6/yVjQMkfehXlVUgmlzrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0WwvQjn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0WwvQjn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso1843347f8f.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436284; x=1744041084; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fmm4x/rKS4iyzdMdeizQ+TMj6LfaxWpWTVqOAceK68=;
        b=G0WwvQjnRuQcrYjgeM9z8TfRNFGzqHPTIyYCXeEHY8WAkoDM3aawymXqvC8GvG4V+1
         aC31tSESd2gcebUnXGSJH1xc4zcoqhuBhe0gyeF+NEFvreLJLP94mX1eyAmaKSImqSVH
         VbTSiOrW4K/LSg0WKII7x3EW4uXJVvvjuL6E/LljuR9PeIqfkgSo7kKBJ4AN28GyFdW6
         4lMLKTJ+TjgAH+NqriK/6cunE3o5va6VK6gPqkQz/hKsmnEvTWEU7pUfLDFG74paBPQL
         pmSASVqPN3wLewxm6FGzpErDm8x+TFzjQKKNTnALpJPslXJ50w1aIFp4obChJkz6EiaT
         zwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436284; x=1744041084;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fmm4x/rKS4iyzdMdeizQ+TMj6LfaxWpWTVqOAceK68=;
        b=P+7TW3L9RmkF7wtmOqD5QCt/+RWjQwli2n1rn7wQZHWAPz6yGjPGy5+X37AufD+iRO
         AeNwzc8TGPZv3v4b7Rlfl7pDP8XlXa6mUxp+PUtdxz20WPO/oKkEgR4y+Xy6qytRH3VD
         qp4gMB8WJUh3RoJt80gYYfgGTBCnhnpsfRbbY5SpRt5x1C31f/g3ZYdZqJOOqs9EY2i5
         mD5Y1RQ5llUGiojjDU+XbCH2N3+7F4MBOyHJHBoiJac+zB5B7nr5RHLFkdX2fTX/gibX
         TPcYVvJdx1LELEqTasE6ysrqbcwMh6TO0a/rrEtwTglbiOVN3Fgr7XctKZuTBX8WHt5D
         H2ng==
X-Gm-Message-State: AOJu0YxCog6rfdfJknzW2Z0ERIi6V4mrdWrCMzgQTjO2H8qfFqnCgxJv
	O+mdiOA87km9iwO5UNKiF0YKCvqWF1Wz8ENvDxK16Je6hluocsKcFbobJw==
X-Gm-Gg: ASbGncunzApQikSe9AZGbDoRLSdSPy3WKkTwS5OGw87/5qUE7VfIpBm3AlAEpaR20T0
	Lz9Lq8kpRVc6wiTbYdZfJcRfgl5f8P9pNLDbcqmyZWjtPwDjgDn2abdvCZoA2uqGwda7bXp2dCm
	BjpZjKbVrPDaO3X8jWix4ssyCUarQZNRrj/UxsOZocoG9dz0uIOjMHY1keLT3bDf5N+qdUJBPWl
	3qolLT01IMF4Jip8ygaf056uLeddhSfzyG/r3YAqcQ28QjkrQTkl76cm+CvgsbNSje3OlQLBKIS
	xUUBi1FpximMu1hjsoSKN8FpdrhKocIdJMy8wfpZZHAp+Q==
X-Google-Smtp-Source: AGHT+IFYhG+UcP+oY+KUOQYRYBNvUa+2AVWARNFMgGBx/LwJPgYcZsJg9OgA6TtkRJ5IrFCqhZLOPw==
X-Received: by 2002:a05:6000:2512:b0:39c:1f04:bb4a with SMTP id ffacd0b85a97d-39c1f04bbc7mr1802669f8f.10.1743436283529;
        Mon, 31 Mar 2025 08:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6a63esm169772105e9.11.2025.03.31.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:22 -0700 (PDT)
Message-Id: <44be41da6c5ebc0cb20e4465e01ee2748310d436.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:13 +0000
Subject: [PATCH 2/8] builtin/merge-recursive: switch to using
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
Cc: Elijah Newren <newren@gmail.com>,
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

* t6436: This test is built entirely around rename/delete conflicts,
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

