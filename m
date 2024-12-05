Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D9217F24
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401384; cv=none; b=VRlIWePHrfnO/+hnmwVZB45eMsuw4+p0vXeRKND9ANFYOnobI4FojZjKtMtrZcPAaTCA3alwnOTkTxzfEpw3LF0qRd0l2/VHiH9yEvzN2Ut/Mpn3Lf2Hj7n5yBFN5s2JtpNkRRXPZ0RBnWwhVNIu1VD24Ug5vjQDaFBnXSmVnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401384; c=relaxed/simple;
	bh=YJCQ16h0tGKnog4+UNPIANu3TVqw1ifyqWlpdohOUb4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=MeWQmijYkntnC14fzaA26b2pA9j+fKqoCVidwHym2If+peZ9BpU/9nFGpNJdwGogge13L8gYKDE25b33EcTy2ktnOTKqGUq/l6zJ/YZEbMbIhPORSDEBxXeWfdsyQFcCQgHdHQlWq5igsh4UUsx1iNBVaaBMRfqG+8/9pPt/9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=pU4CHOMo; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="pU4CHOMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=XDIBMrztTWQDostbKHkk0EMUvMy8XCbXKUiLtMnYU3A=;
 b=pU4CHOMoz/ZGMLeQiqYwwli3KA7YOXuxriJus/8p7WSJO4DnG3j2BedvQAXN3Ngrm5aB4wSkvFXQ
   c1QU/w5DdRqp89fCXtQRG1obUnMRRWevdBWhfFCo2kpDYg1gGO6p5bUGUd/MUO/60PrUNWPWVqgv
   GRcw3FMFMYRJdNXWsr5nMp0Xj+l7cMb/+M/kQ0k/6qSEd0sE9OV4lq7YTNSlwvMSIQPOQmqNHf0y
   R7lMQQV9K2zcmEY8IcScyU3iOSWAgCqQTKWpumVAvDuLeLkafwHnUzhs/t6IbdWsxFc73YjPe+bH
   uJLLwvwUSgWfnxxEsNWtYu2XFY9IeIkfbyX0Sg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO0009IIT259R80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 12:22:53 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,	Heba Waly <heba.waly@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2] advice: suggest using subcommand "git config set"
Date: Thu,  5 Dec 2024 13:21:58 +0100
Message-id: <20241205122225.1184215-1-bence@ferdinandy.com>
In-reply-to: <Z1FkrsQ5tkz1pFUz@pks.im>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAENN+S17iDo31gGP2o4L5QYxGeW6jLCO1pcqz30tJPD2E33i5qJmdOLoVGP/6me
 98CqK5VGhvXNvs0AHQMpLG0GfZNNnk5rMrsIEzkLIkb5PkxfNVtKWPvFGqRcrW3P
 xZuUHbUsuqB+a+St4vWKrDjImrKVMfoULQ71k2a3J+16SqPt5rKd2bTP/xB81Ri8
 8JrEqq8nYKx30UtRHQyzBG8iTTjrCCkw//ghKrFk2p0DWNjqAWLyz+VhcNv+g+JX
 gx5BxSUtH9oInR8hzRZeDMpUzuOFMzDR22S2T+HWMGrzafwN2w9bymlT+QSLvT9e
 g5LKlUnH8t/m+6ratMfN8+l6vGj6xVVme2ID/WDtO0oaEm3elPb2ndxpYmwtphKV
 C8AjSWBiTq5TxVAFQu4RffsHYYn4q+HBKFwNgLUyAL1C2xEcf7MNzkSRXt7U9LGb
 +dLL5cnI7uaoxCPLQ4EmcwFsHkoEoKDkjE0GVj0lrwOSa9T+xP/8iqY=

The advice message currently suggests using "git config advice..." to
disable advice messages, but since

00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06)

we have the "set" subcommand for config. Since using the subcommand is
more in-line with the modern interface, any advice should be promoting
its usage. Change the disable advice message to use the subcommand
instead. Change all uses of "git config advice" in the tests to use the
subcommand.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    For the tests I just indiscriminately ran:
    sed -i "s/git config advice\./git config set advice./" t[0-9]*.sh
    
    v2: - fixed 3 hardcoded "git config advice" type messages
        - made the motiviation more explicit

 advice.c                        | 2 +-
 commit.c                        | 2 +-
 hook.c                          | 2 +-
 object-name.c                   | 2 +-
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
 19 files changed, 27 insertions(+), 27 deletions(-)

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
diff --git a/commit.c b/commit.c
index cc03a93036..35ab9bead5 100644
--- a/commit.c
+++ b/commit.c
@@ -276,7 +276,7 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 			 "to convert the grafts into replace refs.\n"
 			 "\n"
 			 "Turn this message off by running\n"
-			 "\"git config advice.graftFileDeprecated false\""));
+			 "\"git config set advice.graftFileDeprecated false\""));
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(&buf);
diff --git a/hook.c b/hook.c
index a9320cb0ce..9ddbdee06d 100644
--- a/hook.c
+++ b/hook.c
@@ -39,7 +39,7 @@ const char *find_hook(struct repository *r, const char *name)
 				advise(_("The '%s' hook was ignored because "
 					 "it's not set as executable.\n"
 					 "You can disable this warning with "
-					 "`git config advice.ignoredHook false`."),
+					 "`git config set advice.ignoredHook false`."),
 				       path.buf);
 			}
 		}
diff --git a/object-name.c b/object-name.c
index c892fbe80a..0fa9008b76 100644
--- a/object-name.c
+++ b/object-name.c
@@ -952,7 +952,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	"\n"
 	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 	"examine these refs and maybe delete them. Turn this message off by\n"
-	"running \"git config advice.objectNameWarning false\"");
+	"running \"git config set advice.objectNameWarning false\"");
 	struct object_id tmp_oid;
 	char *real_ref = NULL;
 	int refs_found = 0;
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

