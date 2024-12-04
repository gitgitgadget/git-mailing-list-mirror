Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7071B87E2
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318146; cv=none; b=lbSN2D0WjbihRNxXiCqMYOaLAqTial7IOXnOMVy4DeyKuI9dylQTV05+5LaiZG1k8RvxQ1SwCEYBwhSMgOLos19oGtNnA4YRtZiRUi+9aCsi44YJW7U5SrT6DYV5kCrL5HNZ8HgGJCNrqMityd4q4muoC5V8kE5qYFgXXWWML6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318146; c=relaxed/simple;
	bh=D4lV+d2NMn6p3cgjJdk8bVhYc7wVKyOHprCV49ejq/s=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=ViDFtYZ42IrXT6DjIL0VSkIAPRxrQl+9e+xZSNIE2dvsG05SEs0E9Q29KgIeFAyHAEfVVR9y1nY5Ju69KpgIQudQqLipTHUvaCYjCxYLWujY3vApfsRPdUuLCqIExU4OPwCjwoANHzFpPW49ARbODJWPg5nVs6TZQvHz9X4IORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=W26nII5w; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="W26nII5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=CJ5FOM6mIxNe/SGSIHugUn6Qlt+EJiTCrmcRp5VVDEs=;
 b=W26nII5w1Oex/75yllJkfxCljCh40+6JLFGQ0yVQZx0XAx2nyP9zxqdfegTMIygB6RcjwX0fu1vE
   BCPsuyiwofT3dTGgBZfWTF7ZFtG025ChEnx4H7a/Kkwrkwbw7l8TQ8SDBrD1B3jEXFNktkWBHJ2r
   wMmVyZ9HwWD9sH/L/CoEsWq2iEvgUJ2GAfxE0y0GFT9RR0oPXdpVO5qsnYOtsPHHwMw9BQRfeIct
   o+wSuGrpeEdi8kORnCWd2oqKIjfc3xtaXkFTc3hjpHAe6AY99OPUrHoppLeq21Bxqm+UUOxKSLR1
   nAyPkXhslGoW5ThStsQ12RpdImpIiEIPfkdr5Q==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNZ00KQX0LMID80@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 04 Dec 2024 13:10:34 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,	Heba Waly <heba.waly@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH] advice: suggest using subcommand "git config set"
Date: Wed,  4 Dec 2024 14:08:47 +0100
Message-id: <20241204130928.1059851-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHOKH0aw5eaVKc63M4M4ao9kKIl07ANGmSQwZIyc9hesvhDWDGZAEM8m1gKwreK
 BmiWpsCH0YrIGvHNKyyVG8Ya3aFP/0HL8XaL9ctfepv4JYqOYohVxxWoR1RTzDBy
 FctlZUn8A1eW3i1i0S4Vnha/NuotHUW4XJ6XxziK4yNlWYe0ez3S3HTjLzpVq+8Q
 LMHwrP7SR/2P+1hUcQTgeI65Y+CLUASgaDiLTVHZ2yBwBaLxp2zrLSP/aawwuDHu
 3YbUdUYram19V9e4E26s+qMnDCZw9HLC3XRdhMs8facoInNRaeIfZlDgQjXtSXpq
 X3UuJD4NBB4JqC0Hf60MuobyXjSKzVa1yOGwv5tAdno6FlXiusbNeZc1BNZXFPro
 BKGCH0oQhqa+b+h98vmrFCKRxGSGYo0ixTmDYU9tN8jqSS80+Yy2X4tXrKQTFB+1
 glmgMp6AdefOk3Uob6br1e1KvzM3hX7A4dzk8NcoREE8mXEPaVyZOkI=

The advice message currently suggests using "git config advice..." to
disable advice messages, but since 00bbdde141f we have the "set"
subcommand for config. Change the disable advice message to use the
subcommand instead. Change all uses of "git config advice" in the tests
to use the subcommand.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    For the tests I just indiscriminately ran:
    sed -i "s/git config advice\./git config set advice./" t[0-9]*.sh

 advice.c                        | 2 +-
 t/t0018-advice.sh               | 2 +-
 t/t3200-branch.sh               | 2 +-
 t/t3404-rebase-interactive.sh   | 6 +++---
 t/t3501-revert-cherry-pick.sh   | 2 +-
 t/t3507-cherry-pick-conflict.sh | 6 +++---
 t/t3510-cherry-pick-sequence.sh | 2 +-
 t/t3511-cherry-pick-x.sh        | 2 +-
 t/t3602-rm-sparse-checkout.sh   | 2 +-
 t/t3700-add.sh                  | 6 +++---
 t/t3705-add-sparse-checkout.sh  | 2 +-
 t/t7002-mv-sparse-checkout.sh   | 4 ++--
 t/t7004-tag.sh                  | 2 +-
 t/t7201-co.sh                   | 4 ++--
 t/t7400-submodule-basic.sh      | 2 +-
 t/t7508-status.sh               | 2 +-
 16 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/advice.c b/advice.c
index 6b879d805c..f7a5130c2c 100644
--- a/advice.c
+++ b/advice.c
@@ -93,7 +93,7 @@ static struct {
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config advice.%s false\"");
+   "Disable this message with \"git config set advice.%s false\"");
 
 static void vadvise(const char *advice, int display_instructions,
 		    const char *key, va_list params)
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index 9a3db02fde..f68e08d0b1 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'advice should be printed when config variable is unset' '
 	cat >expect <<-\EOF &&
 	hint: This is a piece of advice
-	hint: Disable this message with "git config advice.nestedTag false"
+	hint: Disable this message with "git config set advice.nestedTag false"
 	EOF
 	test-tool advise "This is a piece of advice" 2>actual &&
 	test_cmp expect actual
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 2295db3dcb..a3a21c54cf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1696,7 +1696,7 @@ test_expect_success 'errors if given a bad branch name' '
 	cat <<-\EOF >expect &&
 	fatal: '\''foo..bar'\'' is not a valid branch name
 	hint: See `man git check-ref-format`
-	hint: Disable this message with "git config advice.refSyntax false"
+	hint: Disable this message with "git config set advice.refSyntax false"
 	EOF
 	test_must_fail git branch foo..bar >actual 2>&1 &&
 	test_cmp expect actual
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b11f04eb33..ecfc02062c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2258,20 +2258,20 @@ test_expect_success 'non-merge commands reject merge commits' '
 	error: ${SQ}pick${SQ} does not accept merge commits
 	hint: ${SQ}pick${SQ} does not take a merge commit. If you wanted to
 	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit.
-	hint: Disable this message with "git config advice.rebaseTodoError false"
+	hint: Disable this message with "git config set advice.rebaseTodoError false"
 	error: invalid line 1: pick $oid
 	error: ${SQ}reword${SQ} does not accept merge commits
 	hint: ${SQ}reword${SQ} does not take a merge commit. If you wanted to
 	hint: replay the merge and reword the commit message, use
 	hint: ${SQ}merge -c${SQ} on the commit
-	hint: Disable this message with "git config advice.rebaseTodoError false"
+	hint: Disable this message with "git config set advice.rebaseTodoError false"
 	error: invalid line 2: reword $oid
 	error: ${SQ}edit${SQ} does not accept merge commits
 	hint: ${SQ}edit${SQ} does not take a merge commit. If you wanted to
 	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit, and then
 	hint: ${SQ}break${SQ} to give the control back to you so that you can
 	hint: do ${SQ}git commit --amend && git rebase --continue${SQ}.
-	hint: Disable this message with "git config advice.rebaseTodoError false"
+	hint: Disable this message with "git config set advice.rebaseTodoError false"
 	error: invalid line 3: edit $oid
 	error: cannot squash merge commit into another commit
 	error: invalid line 4: fixup $oid
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 17a9937962..78b03d769d 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -177,7 +177,7 @@ test_expect_success 'advice from failed revert' '
 	hint: You can instead skip this commit with "git revert --skip".
 	hint: To abort and get back to the state before "git revert",
 	hint: run "git revert --abort".
-	hint: Disable this message with "git config advice.mergeConflict false"
+	hint: Disable this message with "git config set advice.mergeConflict false"
 	EOF
 	test_commit --append --no-tag "double-add dream" dream dream &&
 	test_must_fail git revert HEAD^ 2>actual &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index f3947b400a..44596cb1e8 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -34,7 +34,7 @@ test_expect_success setup '
 	git commit --allow-empty --allow-empty-message &&
 	git tag empty &&
 	git checkout main &&
-	git config advice.detachedhead false
+	git config set advice.detachedhead false
 
 '
 
@@ -60,7 +60,7 @@ test_expect_success 'advice from failed cherry-pick' '
 	hint: You can instead skip this commit with "git cherry-pick --skip".
 	hint: To abort and get back to the state before "git cherry-pick",
 	hint: run "git cherry-pick --abort".
-	hint: Disable this message with "git config advice.mergeConflict false"
+	hint: Disable this message with "git config set advice.mergeConflict false"
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -75,7 +75,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: Disable this message with \"git config advice.mergeConflict false\"
+	hint: Disable this message with \"git config set advice.mergeConflict false\"
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7eb52b12ed..66ff9db270 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -25,7 +25,7 @@ pristine_detach () {
 }
 
 test_expect_success setup '
-	git config advice.detachedhead false &&
+	git config set advice.detachedhead false &&
 	echo unrelated >unrelated &&
 	git add unrelated &&
 	test_commit initial foo a &&
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 84a587daf3..98ef13f0a3 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -51,7 +51,7 @@ trailing empty lines
 "
 
 test_expect_success setup '
-	git config advice.detachedhead false &&
+	git config set advice.detachedhead false &&
 	echo unrelated >unrelated &&
 	git add unrelated &&
 	test_commit initial foo a &&
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 08580fd3dc..02c7acd617 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup' "
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
-	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set advice.updateSparsePath false\"
 	EOF
 
 	echo b | cat sparse_error_header - >sparse_entry_b_error &&
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4c543a1a7e..df580a5806 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -31,7 +31,7 @@ test_expect_success 'Test with no pathspecs' '
 	cat >expect <<-EOF &&
 	Nothing specified, nothing added.
 	hint: Maybe you wanted to say ${SQ}git add .${SQ}?
-	hint: Disable this message with "git config advice.addEmptyPathspec false"
+	hint: Disable this message with "git config set advice.addEmptyPathspec false"
 	EOF
 	git add 2>actual &&
 	test_cmp expect actual
@@ -375,7 +375,7 @@ test_expect_success '"git add" a embedded repository' '
 		hint: 	git rm --cached inner1
 		hint:
 		hint: See "git help submodule" for more information.
-		hint: Disable this message with "git config advice.addEmbeddedRepo false"
+		hint: Disable this message with "git config set advice.addEmbeddedRepo false"
 		warning: adding embedded git repository: inner2
 		EOF
 		test_cmp expect actual
@@ -413,7 +413,7 @@ cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
 hint: Use -f if you really want to add them.
-hint: Disable this message with "git config advice.addIgnoredFile false"
+hint: Disable this message with "git config set advice.addIgnoredFile false"
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2bade9e804..53a4782267 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup' "
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
-	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set advice.updateSparsePath false\"
 	EOF
 
 	echo sparse_entry | cat sparse_error_header - >sparse_entry_error &&
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 26582ae4e5..4d3f221224 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup' "
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
-	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set advice.updateSparsePath false\"
 	EOF
 
 	cat >dirty_error_header <<-EOF &&
@@ -45,7 +45,7 @@ test_expect_success 'setup' "
 	hint: To correct the sparsity of these paths, do the following:
 	hint: * Use \"git add --sparse <paths>\" to update the index
 	hint: * Use \"git sparse-checkout reapply\" to apply the sparsity rules
-	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set advice.updateSparsePath false\"
 	EOF
 "
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b1316e62f4..7cd5e16dc8 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1850,7 +1850,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint:
 	hint: 	git tag -f nested annotated-v4.0^{}
-	hint: Disable this message with "git config advice.nestedTag false"
+	hint: Disable this message with "git config set advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_cmp expect actual
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 793da6e64e..9bcf7c0b40 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -224,7 +224,7 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 '
 
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
-	git config advice.detachedHead false &&
+	git config set advice.detachedHead false &&
 	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer &&
 	git clean -f &&
@@ -244,7 +244,7 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 '
 
 test_expect_success 'checkout to detach HEAD' '
-	git config advice.detachedHead true &&
+	git config set advice.detachedHead true &&
 	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer &&
 	git clean -f &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 981488885f..d6a501d453 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -212,7 +212,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		The following paths are ignored by one of your .gitignore files:
 		submod
 		hint: Use -f if you really want to add them.
-		hint: Disable this message with "git config advice.addIgnoredFile false"
+		hint: Disable this message with "git config set advice.addIgnoredFile false"
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index f9a5c98f3f..b2070d4e39 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1699,7 +1699,7 @@ test_expect_success 'setup slow status advice' '
 		EOF
 		git add .gitignore &&
 		git commit -m "Add .gitignore" &&
-		git config advice.statusuoption true
+		git config set advice.statusuoption true
 	)
 '
 
-- 
2.47.1.398.g18e7475ebe

