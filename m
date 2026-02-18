Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBE4CB5B
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381926; cv=none; b=D1ScSnYqPsonyr6HKsCi3e34c5bVTDs7VN1qC6HArJRD6UTtLMCEKjbhKavyb/7V/bCRyDgrAx07XJCcsX6wRT2KOl0AJ5nddNioYSpFJL+0Uy7z8WQHfWT9W0Mris0rTpBn8fRcCFc7Hx/5QTc74tWbVcxQqxRIHEPnYOVZM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381926; c=relaxed/simple;
	bh=yd9a/sdH/+PJx1o+hxU6w4fTBXdBKTQ0zPwaER1Pyj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/NcsOuzVQxcawIEjO2LyD1FeNGYvBLaIw+vGfXTLgb7aIgWrw01fKvW6Ckues5AsG5AnlV1QZocEbD/TBg+0W2yN9aSE71UPfrblk8YOhgdkhiSSs6LbSBTbUPzNtbcdCJEdmpmU0S8tZykUGHBe6dZfDnF6aU30pFcqWXu1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=ArhuRWUx; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="ArhuRWUx"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXM4-00GV6Y-BM; Wed, 18 Feb 2026 03:31:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=4uQCPiVPK88vi/zgsvHbud3wgFUB8sUKD+3QWQdklQk=; b=ArhuRWUxgaSz+kFzGm+kjK74qw
	qoM5WEG3GAgZht51n6LbD4fvUjm7RdW6HT7NWx0t2zAhYj5Oq9IXYAmka1WItVe12+MC1cBYbyyOg
	BSCnnGAOuKgZKkydASGgCbxDLMQZUIpz9eSha1sqyo+mNaOv2acfT6KMGvADsgrVTh878oj6Be4BS
	Tf9B3arRUqlWjL2RKrydx/kT0lry7WkbcLYDbAV46JQMY2KdzQdeOe2m2BYmHMVABQMzowzBzVAaM
	F67c+EQaM0YZYDsG2qtA7Jmjl9ra1OG6XEEWrUeA9n5dL5rnctTI2K9shgvRGLYgK+V7ZWKJjZO6l
	Z0vmooTQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXM4-00047d-1p; Wed, 18 Feb 2026 03:31:56 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vsXLy-005i9g-UF; Wed, 18 Feb 2026 03:31:51 +0100
From: Colin Stagner <ask+git@howdoi.land>
Date: Tue, 17 Feb 2026 20:31:32 -0600
Subject: [PATCH v2 3/3] contrib/subtree: process out-of-prefix subtrees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260217-cs-subtree-remove-optimization-v2-3-4299e71a30c6@howdoi.land>
References: <20260217-cs-subtree-remove-optimization-v2-0-4299e71a30c6@howdoi.land>
In-Reply-To: <20260217-cs-subtree-remove-optimization-v2-0-4299e71a30c6@howdoi.land>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Zach FettersMoore <zach.fetters@apollographql.com>, 
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub, 
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

`should_ignore_subtree_split_commit` detects subtrees which are
outside of the current path --prefix and ignores them. This can
speed up splits of repositories that have many subtrees.

Since its inception [1], every iteration of this logic [2], [3]
incorrectly excludes commits. This alters the split history. The
split history and its commit hashes are API contract, so this is
not permissible.

While a commit from a different subtree may look like it doesn't
contribute anything to a split, sometimes it does. Merge commits
are a particular hot spot. For these, the pruning logic in
`copy_or_skip` performs:

1. a check for "treesame" parents
2. two different common ancestry checks

These checks operate on the **split history**, not the input
history. The split history omits commits that do not affect the
--prefix. This can significantly alter the ancestry of a merge.
In order to determine if `copy_or_skip` will skip a merge, it
is likely necessary to compute all the split history... which
is what `should_ignore_subtree_split_commit` tries to avoid.

To make this logic API-preserving, we could gate it behind a
new CLI argument. The present implementation is actually a
speed penalty in many cases, however, so this is not done here.

Remove the `should_ignore_subtree_split_commit` logic. This
fixes the regression reported in [4].

[1]: 98ba49ccc2 (subtree: fix split processing with multiple subtrees present, 2023-12-01)

[2]: 83f9dad7d6 (contrib/subtree: fix split with squashed subtrees, 2025-09-09)

[3]: 28a7e27cff (contrib/subtree: detect rewritten subtree commits, 2026-01-09)

[4]: <20251230170719.845029-1-george@mail.dietrich.pub>

Reported-by: George <george@mail.dietrich.pub>
Reported-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/git-subtree.sh     | 50 +---------------------------
 contrib/subtree/t/t7900-subtree.sh | 68 +++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..ba9fb2ee5d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -785,42 +785,6 @@ ensure_valid_ref_format () {
 		die "fatal: '$1' does not look like a ref"
 }
 
-# Usage: should_ignore_subtree_split_commit REV
-#
-# Check if REV is a commit from another subtree and should be
-# ignored from processing for splits
-should_ignore_subtree_split_commit () {
-	assert test $# = 1
-
-	git show \
-		--no-patch \
-		--no-show-signature \
-		--format='%(trailers:key=git-subtree-dir,key=git-subtree-mainline)' \
-		"$1" |
-	(
-	have_mainline=
-	subtree_dir=
-
-	while read -r trailer val
-	do
-		case "$trailer" in
-		git-subtree-dir:)
-			subtree_dir="${val%/}" ;;
-		git-subtree-mainline:)
-			have_mainline=y ;;
-		esac
-	done
-
-	if test -n "${subtree_dir}" &&
-		test -z "${have_mainline}" &&
-		test "${subtree_dir}" != "$arg_prefix"
-	then
-		return 0
-	fi
-	return 1
-	)
-}
-
 # Usage: process_split_commit REV PARENTS
 process_split_commit () {
 	assert test $# = 2
@@ -1006,19 +970,7 @@ cmd_split () {
 	eval "$grl" |
 	while read rev parents
 	do
-		if should_ignore_subtree_split_commit "$rev"
-		then
-			continue
-		fi
-		parsedparents=''
-		for parent in $parents
-		do
-			if ! should_ignore_subtree_split_commit "$parent"
-			then
-				parsedparents="$parsedparents$parent "
-			fi
-		done
-		process_split_commit "$rev" "$parsedparents"
+		process_split_commit "$rev" "$parents"
 	done || exit $?
 
 	latest_new=$(cache_get latest_new) || exit $?
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index dad8dea63a..05a774ad47 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -428,8 +428,7 @@ test_expect_success 'split sub dir/ with --rejoin' '
 # 	- Perform 'split' on subtree B
 # 	- Create new commits with changes to subtree A and B
 # 	- Perform split on subtree A
-# 	- Check that the commits in subtree B are not processed
-#			as part of the subtree A split
+# 	- Check for expected history
 test_expect_success 'split with multiple subtrees' '
 	subtree_test_create_repo "$test_count" &&
 	subtree_test_create_repo "$test_count/subA" &&
@@ -458,8 +457,8 @@ test_expect_success 'split with multiple subtrees' '
 		--squash --rejoin -m "Sub A Split 2" -b a2 &&
 	test "$(git -C "$test_count" rev-list --count main..a2)" -eq 2 &&
 	test "$(git -C "$test_count" rev-list --count a1..a2)" -eq 1 &&
-	test "$(git -C "$test_count" subtree split --prefix=subBDir \
-		--squash --rejoin -d -m "Sub B Split 1" -b b2 2>&1 | grep -w "\[1\]")" = "" &&
+	git -C "$test_count" subtree split --prefix=subBDir \
+		--squash --rejoin -d -m "Sub B Split 1" -b b2 &&
 	test "$(git -C "$test_count" rev-list --count main..b2)" -eq 2 &&
 	test "$(git -C "$test_count" rev-list --count b1..b2)" -eq 1
 '
@@ -507,6 +506,67 @@ do
 	'
 done
 
+# Usually,
+#
+#    git subtree merge -P subA --squash f00...
+#
+# makes two commits, in this order:
+#
+# 1. Squashed 'subA/' content from commit f00...
+# 2. Merge commit (1) as 'subA'
+#
+# Commit 1 updates the subtree but does *not* rewrite paths.
+# Commit 2 rewrites all trees to start with `subA/`
+#
+# Commit 1 either has no parents or depends only on other
+# "Squashed 'subA/' content" commits.
+#
+# For merge without --squash, subtree produces just one commit:
+# a merge commit with git-subtree trailers.
+#
+# In either case, if the user rebases these commits, they will
+# still have the git-subtree-* trailers… but will NOT have
+# the layout described above.
+#
+# Test that subsequent `git subtree split` are not confused by this.
+test_expect_success 'split with rebased subtree commit' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+		test_commit file0 &&
+		test_create_subtree_add \
+			. mksubtree subA file1 --squash &&
+		test_path_is_file subA/file1.t &&
+		mkdir subB &&
+		test_commit subB/bfile &&
+		git commit --amend -F - <<'EOF' &&
+Squashed '\''subB/'\'' content from commit '\''badf00da911bbe895347b4b236f5461d55dc9877'\''
+
+Simulate a cherry-picked or rebased subtree commit.
+
+git-subtree-dir: subB
+git-subtree-split: badf00da911bbe895347b4b236f5461d55dc9877
+EOF
+		test_commit subA/file2 &&
+		test_commit subB/bfile2 &&
+		git commit --amend -F - <<'EOF' &&
+Split '\''subB/'\'' into commit '\''badf00da911bbe895347b4b236f5461d55dc9877'\''
+
+Simulate a cherry-picked or rebased subtree commit.
+
+git-subtree-dir: subB
+git-subtree-mainline: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+git-subtree-split: badf00da911bbe895347b4b236f5461d55dc9877
+EOF
+		git subtree split --prefix=subA --branch=bsplit &&
+		git checkout bsplit &&
+		test_path_is_file file1.t &&
+		test_path_is_file file2.t &&
+		test "$(last_commit_subject)" = "subA/file2" &&
+		test "$(git rev-list --count bsplit)" -eq 2
+	)
+'
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&

-- 
2.43.0

