Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72017200113
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039336; cv=none; b=Lu9CZRFJ+8YmlMC3sZ9mxQLpjDMvpDeptLNC1tQBLYPWjxWrQgiKiLwxFPhzqp550Ns1CbSA9PwTd81bKOxRFngqWOztfuJvA2J2vO44Gt05rId1blfg9agq7G9x6N375FAm2LrWo+NMU3I/UYqaMpdd/31Pk+bLVVvPcKvHOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039336; c=relaxed/simple;
	bh=1IgNBYKX8J2eFFCIm8nNOFX/tqNPdhkI1iwOjyk5PuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ1YcZXBsPDxanZRD427WtXzSWrr4Xq2G0cQgZfsBKLnNjMW46ioAo1l2lrbsfxukEZH4EMkc6AdfZy/6MHO1cGiZsEG7MrhEO136HvAfGauaU6LwrQ6BKFyBTsOq3MrWYX/B8f8TpJ+lzX5K75+ZC0XfsOn/eDZVGVnDB8ifBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=P1f2GD6t; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="P1f2GD6t"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1uuMBs-002NZE-D3; Fri, 05 Sep 2025 04:28:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=NP5sH8p3UP96/p5WG7tWzuB/VE9YLVcfEVYMeUYCkQc=; b=P1f2GD6tIiGbvuTk7+xJBzcdQy
	VvpSBDHqneJu81giWQnNfHp+A9FVZ8eR6EVbPE1Pmu9IfzHFgU0himmaPWl5T1WmsQVkj6PYJzPj3
	K60Bsl8hfLUxAJPqqYiIpYivzMbwh2I0oyMq2o3um0P5idRBb7i3FClC1F+IPlt1nWZveFXkiHc3+
	vnMUuuvSP0OjGrX4kfc1x/YBJTJiQuM9sHiCGwVPRr5vwsc5T75H5CX3b21iPJ0oTXdOXsruvQvq9
	dEhQl+W7HfXFsVXYfFDoFQbItowDyeiTSFMMIleDawPV+nMqtV0ct5yRJ9I/XvpNOLmGPINbLln4+
	9dOb6PHA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1uuMBr-0004Rf-Jj; Fri, 05 Sep 2025 04:28:39 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uuMBa-001x2u-2q; Fri, 05 Sep 2025 04:28:22 +0200
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	Phillip Wood <phillip.wood123@gmail.com>
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Patrik Weiskircher <patrik@pspdfkit.com>,
	Colin Stagner <ask+git@howdoi.land>
Subject: [PATCH v2] contrib/subtree: fix split with squashed subtrees
Date: Thu,  4 Sep 2025 21:27:28 -0500
Message-ID: <20250905022728.940664-1-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250824191048.1938340-1-ask+git@howdoi.land>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

98ba49ccc2 (subtree: fix split processing with multiple subtrees
present, 2023-12-01) increases the performance of

    git subtree split --prefix=subA

by ignoring subtree merges which are outside of `subA/`. It also
introduces a regression. Subtree merges that should be retained
are incorrectly ignored if they:

1. are nested under `subA/`; and
2. are merged with `--squash`.

For example, a subtree merged like:

    git subtree merge --squash --prefix=subA/subB "$rev"
    #                 ^^^^^^^^          ^^^^

is erroneously ignored during a split of `subA`. This causes
missing tree files and different commit hashes starting in
git v2.44.0-rc0.

The method:

    should_ignore_subtree_split_commit REV

should test only a single commit REV, but the combination of

    git log -1 --grep=...

actually searches all *parent* commits until a `--grep` match is
discovered.

Rewrite this method to test only one REV at a time. Extract commit
information with a single `git` call as opposed to three. The
`test` conditions for rejecting a commit remain unchanged.

Unit tests now cover nested subtrees.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---

Notes:
    This bugfix patch is intended for maint-2.44 and up.
    
    v2 rewrites `should_ignore_subtree_split_commit()` completely. In
    addition to the review comments, v2 also:
    
    * adds `--no-show-signature` to align with
      8841b5222c (subtree: fix add and pull for GPG-signed commits,
      2018-02-23)
    
    * removes use of `local` from `should_ignore_subtree_split_commit`.
      `local` is not part of POSIX sh. Other uses of `local` remain in
      untouched code.
    
    * unit tests are unchanged since v1.

 contrib/subtree/git-subtree.sh     | 36 +++++++++++----
 contrib/subtree/t/t7900-subtree.sh | 70 ++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 5dab3f506c..c3cd60d341 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -783,24 +783,44 @@ ensure_clean () {
 # Usage: ensure_valid_ref_format REF
 ensure_valid_ref_format () {
 	assert test $# = 1
 	git check-ref-format "refs/heads/$1" ||
 		die "fatal: '$1' does not look like a ref"
 }
 
-# Usage: check if a commit from another subtree should be
+# Usage: should_ignore_subtree_split_commit REV
+#
+# Check if REV is a commit from another subtree and should be
 # ignored from processing for splits
 should_ignore_subtree_split_commit () {
 	assert test $# = 1
-	local rev="$1"
+
+	git show \
+		--no-patch \
+		--no-show-signature \
+		--format='%(trailers:key=git-subtree-dir,key=git-subtree-mainline)' \
+		"$1" |
+	(
+	have_mainline=
+	subtree_dir=
+
+	while read -r trailer val
+	do
+		case "$trailer" in
+		(git-subtree-dir:)
+			subtree_dir="${val%/}" ;;
+		(git-subtree-mainline:)
+			have_mainline=y ;;
+		esac
+	done
+
-	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
+	if test -n "${subtree_dir:-}" &&
+		test -z "${have_mainline:-}" &&
+		test "${subtree_dir}" != "$arg_prefix"
 	then
-		if test -z "$(git log -1 --grep="git-subtree-mainline:" $rev)" &&
-			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $rev)"
-		then
-			return 0
-		fi
+		return 0
 	fi
 	return 1
+	)
 }
 
 # Usage: process_split_commit REV PARENTS
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ca4df5be83..8bd45e7be7 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -67,6 +67,34 @@ test_create_pre2_32_repo () {
 	git -C "$1-clone" replace HEAD^2 $new_commit
 }
 
+# test_create_subtree_add REPO ORPHAN PREFIX FILENAME ...
+#
+# Create a simple subtree on a new branch named ORPHAN in REPO.
+# The subtree is then merged into the current branch of REPO,
+# under PREFIX. The generated subtree has has one commit
+# with subject and tag FILENAME with a single file "FILENAME.t"
+#
+# When this method returns:
+# - the current branch of REPO will have file PREFIX/FILENAME.t
+# - REPO will have a branch named ORPHAN with subtree history
+#
+# additional arguments are forwarded to "subtree add"
+test_create_subtree_add () {
+	(
+		cd "$1" &&
+		orphan="$2" &&
+		prefix="$3" &&
+		filename="$4" &&
+		shift 4 &&
+		last="$(git branch --show-current)" &&
+		git checkout --orphan "$orphan" &&
+		git rm -rf . &&
+		test_commit "$filename" &&
+		git checkout "$last" &&
+		git subtree add --prefix="$prefix" "$@" "$orphan"
+	)
+}
+
 test_expect_success 'shows short help text for -h' '
 	test_expect_code 129 git subtree -h >out 2>err &&
 	test_must_be_empty err &&
@@ -425,6 +453,48 @@ test_expect_success 'split with multiple subtrees' '
 		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
 '
 
+# When subtree split-ing a directory that has other subtree
+# *merges* underneath it, the split must include those subtrees.
+# This test creates a nested subtree, `subA/subB`, and tests
+# that the tree is correct after a subtree split of `subA/`.
+# The test covers:
+# - An initial `subtree add`; and
+# - A follow-up `subtree merge`
+# both with and without `--squashed`.
+for is_squashed in '' 'y';
+do
+	test_expect_success "split keeps nested ${is_squashed:+--squash }subtrees that are part of the split" '
+		subtree_test_create_repo "$test_count" &&
+		(
+			cd "$test_count" &&
+			mkdir subA &&
+			test_commit subA/file1 &&
+			git branch -m main &&
+			test_create_subtree_add \
+				. mksubtree subA/subB file2 ${is_squashed:+--squash} &&
+			test -e subA/file1.t &&
+			test -e subA/subB/file2.t &&
+			git subtree split --prefix=subA --branch=bsplit &&
+			git checkout bsplit &&
+			test -e file1.t &&
+			test -e subB/file2.t &&
+			git checkout mksubtree &&
+			git branch -D bsplit &&
+			test_commit file3 &&
+			git checkout main &&
+			git subtree merge \
+				${is_squashed:+--squash} \
+				--prefix=subA/subB mksubtree &&
+			test -e subA/subB/file3.t &&
+			git subtree split --prefix=subA --branch=bsplit &&
+			git checkout bsplit &&
+			test -e file1.t &&
+			test -e subB/file2.t &&
+			test -e subB/file3.t
+		)
+	'
+done
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&

base-commit: 09669c729af92144fde84e97d358759b5b42b555
-- 
2.43.0

