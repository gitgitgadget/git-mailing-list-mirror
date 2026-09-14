Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6C39280A
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789423315; cv=none; b=gp184EjLE1TXApPkRIg6hDVLJcNW1v50dn2FRC5o0sJzGYfnjUPQwRbIuh+G75pNZiThYhKpAEla1YCyOLKLh13wa/7sy85MvTL8jdsFWXxLYfilFHWa+1EyVeHhNdAMe1MPWbsaPMdpFXf1qTG6kQ97voHzm+nsl2lAqBDbatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789423315; c=relaxed/simple;
	bh=gD6+atvNYqbnxYBELACwmt+qMlAcjEycn3zsgPNTb4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjNKl9KEvOT8S5Z6gssyFxr5xXoMvuoM/EmM/e3G3jTNQYFkG+3yOhY+76wURZTKMfIy1v+w7epYd03IdczUsh7WT0qwu0tcvI69yjdDa7kYm8LsCPn1f0PKQg90qV/0whdD3kgUwPk3hOhvRU/zUvRT65ZZ/b+WfBKWYGKc9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j8ry4IPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F93TIxKx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j8ry4IPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F93TIxKx"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00AB17A0088;
	Mon, 14 Sep 2026 18:01:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 14 Sep 2026 18:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789423311; x=1789509711; bh=tNjJhDxvz8
	GUs532OghpXtz/iQSq5CWIYSeDcAtBjEY=; b=j8ry4IPMiTR6dXWCeuga19H77+
	Zajv2dVG+RkECZUkw/i/hgB5shcIECLCsOg4zSPHXYCswHcUf3WpJBzuzuykbG87
	+5Jg6DBSqCPzSJSn2ek4pVtrraSvttsBgTmuwRnTncunanvto3N1oXXzAQYdKJyb
	iMamrva5Q3A8+HbcwPSPc3JPSMsijKEzhr+zEXvo0vK5/X5xGUtTUustI8mVT+PL
	chUyo8t4vvTOnU7Nymf3Vjc6STgKCZ3SNhw30NDSO6OX0U27dW0/coPPjhjoA6ni
	yFyFFLRrSnlnC0IYoqztrbfugPOJFSWlbRu+yGWGVow1F2jIxJRVBzH8iwTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789423311; x=1789509711; bh=tNjJhDxvz8GUs532OghpXtz/iQSq5CWIYSe
	DcAtBjEY=; b=F93TIxKxslVYaRcdlmzAwFD5olYROlLOc6opDLsDMFR3vVX5Gux
	+FbAZhYr3Oc8tNT/8sJKGKm0r7/sbwtJSaZT9HSz7wZmx2Qn5Z5iX3Vq28yvlOcn
	/SA5fv/EpSlcciKDcBEeDga9/2K8Gqm1TcJ8/cyLPx6bXe7rvlLjKDCVWCBhnjZ7
	SD2JiKyVfQ/DRCGVlJFWA2Eq32aXhQnHAgrqMPIPtvjebYP2sr+htG+G1hMvfPwE
	qgWv2eqgmLWHzjW/en1ee3UNx4Kf0y7ZoJHsprz/oQgLPketPHfuNUvjNuTeJmtx
	N815mcBZTQHfYPcog8xj270k1ZD5fXMateQ==
X-ME-Sender: <xms:z26oajnwGFB0Ccmwmzi_X-4_nLLNnTR8DqggMkh_8xgU2O-Ty33sQA>
    <xme:z26oaqi_blyQHPxIjLqfcwrbWUZYA31g46uAA0WZgTGu4JJkAsLl2ySJwyxjt1n58
    8gasX8O4cSSsDxgBSxVdJTtx0Tm-nGxJSw0Xrw2lzGH60Mc1ooIgEs>
X-ME-Received: <xmr:z26oajfl-4IV5DhXxVDXhxM49sbTPDQY7u2hUJ6AE2SShh1BoxIJL1_wCNlROpAfyNMjGQ1C2VgD9YwsSBI9Gld3Dsu0SC61i3R5>
X-ME-Proxy-Cause: dmFkZTEZzxiQC6NVcaPdhmWzkY/mNWoNMbl1ljZA7l330K/I9f3lyCGfNPt48B7B5JWdAa
    faJenfbQTs7iinTY0GnXwdLeVkjxxgcTtAePbcPb2+vOY/ST1HRCaD2YiVYg+wZCZcBWwW
    BEIwwc0EVvwgeE9+RnUuILnA604h4SWBNXx3lMURdFoVNc+nNwmlsqMnPExQA9t6x3t3/Y
    52VUDaN5z4xfeh1i40MKjn/sh+/G4yki7ovGMhFANPSPnuWLO4uQ6gA0g41nq34T/koE27
    Uhz9qAK5BuDBpIXFhIwKKYgM6b/l8jZVG12xEqmJtxVKLK/GdENhqGbcwnfXorxas0j2Vc
    ABWoGKuX82jNRYwko1WSEbs85LZK7oSv9mPYUNGgsB4RHJ6hP4LDOba4ipNCqzXzm57mJ5
    kJCxV/ZKxNDLSpEfI5/te4cu6VD26lQ+WbGRgs9HCKy0Z92EX1JQI0Qwcf1w3dWMfNFKyt
    TU0xD4b2tbNnZVwJwRQV8Zjtnsfb0wYDqaO7fYwYMVElWO7kBvE9oyNJG5rHAvIHhdA/Nk
    T1w3GtyVL7MvthsOP/yp8l1XV3zg1hYSh2R0+ngkj2UZQ2+1aiYupSSYX4KW/re72n2Phb
    UHm/dJKKWhOLz8yneELsdvutoKS6iDb2LN0JKEt4Vsdm45Buu3R8T8ug2BeQ
X-ME-Proxy: <xmx:z26oaihy0fnImGdFEA7Q80DMlD7dr-Z6oF6W00Ntvc45jvJOaYjcYg>
    <xmx:z26oajxaE959XqruvnRYLoZIIzdXsKf-eb_3h3eBwFZqFStt-j6CGA>
    <xmx:z26oamNyz7fD-NYl2nGGVHoPzafu7Wu8BCtKned92kTLj-B4LWlIYA>
    <xmx:z26oasUcZf9lZhUQwN_KeWjrTs8TLsC_8SKXc502sk-trQcmoejXXQ>
    <xmx:z26oagiTeZYpomLNvkI_Nh4tCNvey6yZlbjGvl_8Ex074oqxgUnuMsTZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 18:01:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>,  Jeff King <peff@peff.net>
Cc: ben.knoble@gmail.com,  git@vger.kernel.org,  gitster@pobox.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <xmqqqziv4nk7.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	14 Sep 2026 12:53:28 -0700")
References: <xmqqcxuketuz.fsf@gitster.g>
	<20260912081246.133514-1-ub4nal@mail.ru> <xmqq8q55863e.fsf@gitster.g>
	<20260914170034.GE32247@peff.net> <xmqqqziv4nk7.fsf@gitster.g>
Date: Mon, 14 Sep 2026 15:01:49 -0700
Message-ID: <xmqq33vb4hma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> Jeff King <peff@peff.net> writes:
>
>> Yeah, I was hinting that I think suggesting --global for all advice
>> would be fine. It's possible some particular advice would be better set
>> within a repo, but I kind of doubt it. And if we do find one, I think it
>> would be the exception, and then we could introduce a hint flag for that
>> one bit of advice in the other direction. :)

So to conclude the topic, we would only need this?

----- >8 -----
Subject: [PATCH v5 1/1] advice: give cut-and-pasteable advice to squelch

Advice messages that the advise_if_enabled() helper emits tell
the user how to squelch a particular piece of advice by setting a
configuration variable.  The message it gives says:

    hint: Disable this message with "git config set advice.FOO false"

However, cutting and pasting the given hint would set the
configuration variable in the per-repository configuration file
(which is the default behavior for 'git config set').  As the user
most likely sets it after seeing advice and understanding its
ramifications, the choice of squelching or continuing to see the
advice message is better controlled per-user, not per-repository.

In addition, some advice, such as advice.defaultBranchName, is
applicable only once before a new repository is created, so setting
it in the per-repository configuration file is far too late.

Add '--global' to the 'git config set' command line so that the
configuration is set for the user rather than per repository.

Initial-work-by: Vsevolod Myalitsin <ub4nal@mail.ru>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 advice.c                        | 2 +-
 t/t0018-advice.sh               | 2 +-
 t/t3200-branch.sh               | 2 +-
 t/t3404-rebase-interactive.sh   | 6 +++---
 t/t3501-revert-cherry-pick.sh   | 2 +-
 t/t3507-cherry-pick-conflict.sh | 4 ++--
 t/t3602-rm-sparse-checkout.sh   | 2 +-
 t/t3700-add.sh                  | 6 +++---
 t/t3705-add-sparse-checkout.sh  | 2 +-
 t/t7002-mv-sparse-checkout.sh   | 4 ++--
 t/t7004-tag.sh                  | 2 +-
 t/t7400-submodule-basic.sh      | 2 +-
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git c/advice.c w/advice.c
index 63bf8b0c5f..d81afc80d1 100644
--- c/advice.c
+++ w/advice.c
@@ -96,7 +96,7 @@ static struct {
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config set advice.%s false\"");
+   "Disable this message with \"git config set --global advice.%s false\"");
 
 static void vadvise(const char *advice, int display_instructions,
 		    const char *key, va_list params)
diff --git c/t/t0018-advice.sh w/t/t0018-advice.sh
index f68e08d0b1..8f05b5ae6c 100755
--- c/t/t0018-advice.sh
+++ w/t/t0018-advice.sh
@@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'advice should be printed when config variable is unset' '
 	cat >expect <<-\EOF &&
 	hint: This is a piece of advice
-	hint: Disable this message with "git config set advice.nestedTag false"
+	hint: Disable this message with "git config set --global advice.nestedTag false"
 	EOF
 	test-tool advise "This is a piece of advice" 2>actual &&
 	test_cmp expect actual
diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index cdb6c6a634..0d7d9d3957 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -1751,7 +1751,7 @@ test_expect_success 'errors if given a bad branch name' '
 	cat <<-EOF >expect &&
 	fatal: ${SQ}foo..bar${SQ} is not a valid branch name
 	hint: See ${SQ}git help check-ref-format${SQ}
-	hint: Disable this message with "git config set advice.refSyntax false"
+	hint: Disable this message with "git config set --global advice.refSyntax false"
 	EOF
 	test_must_fail git branch foo..bar >actual 2>&1 &&
 	test_cmp expect actual
diff --git c/t/t3404-rebase-interactive.sh w/t/t3404-rebase-interactive.sh
index 8c63682b7f..7dc6328502 100755
--- c/t/t3404-rebase-interactive.sh
+++ w/t/t3404-rebase-interactive.sh
@@ -2461,20 +2461,20 @@ test_expect_success 'non-merge commands reject merge commits' '
 	error: ${SQ}pick${SQ} does not accept merge commits
 	hint: ${SQ}pick${SQ} does not take a merge commit. If you wanted to
 	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit.
-	hint: Disable this message with "git config set advice.rebaseTodoError false"
+	hint: Disable this message with "git config set --global advice.rebaseTodoError false"
 	error: invalid line 1: pick $oid
 	error: ${SQ}reword${SQ} does not accept merge commits
 	hint: ${SQ}reword${SQ} does not take a merge commit. If you wanted to
 	hint: replay the merge and reword the commit message, use
 	hint: ${SQ}merge -c${SQ} on the commit
-	hint: Disable this message with "git config set advice.rebaseTodoError false"
+	hint: Disable this message with "git config set --global advice.rebaseTodoError false"
 	error: invalid line 2: reword $oid
 	error: ${SQ}edit${SQ} does not accept merge commits
 	hint: ${SQ}edit${SQ} does not take a merge commit. If you wanted to
 	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit, and then
 	hint: ${SQ}break${SQ} to give the control back to you so that you can
 	hint: do ${SQ}git commit --amend && git rebase --continue${SQ}.
-	hint: Disable this message with "git config set advice.rebaseTodoError false"
+	hint: Disable this message with "git config set --global advice.rebaseTodoError false"
 	error: invalid line 3: edit $oid
 	error: cannot squash merge commit into another commit
 	error: invalid line 4: fixup $oid
diff --git c/t/t3501-revert-cherry-pick.sh w/t/t3501-revert-cherry-pick.sh
index 939e7a16a6..2abbf071ce 100755
--- c/t/t3501-revert-cherry-pick.sh
+++ w/t/t3501-revert-cherry-pick.sh
@@ -177,7 +177,7 @@ test_expect_success 'advice from failed revert' '
 	hint: You can instead skip this commit with "git revert --skip".
 	hint: To abort and get back to the state before "git revert",
 	hint: run "git revert --abort".
-	hint: Disable this message with "git config set advice.mergeConflict false"
+	hint: Disable this message with "git config set --global advice.mergeConflict false"
 	EOF
 	test_commit --append --no-tag "double-add dream" dream dream &&
 	test_must_fail git revert HEAD^ 2>actual &&
diff --git c/t/t3507-cherry-pick-conflict.sh w/t/t3507-cherry-pick-conflict.sh
index c767e4ad3d..5be94493c1 100755
--- c/t/t3507-cherry-pick-conflict.sh
+++ w/t/t3507-cherry-pick-conflict.sh
@@ -60,7 +60,7 @@ test_expect_success 'advice from failed cherry-pick' '
 	hint: You can instead skip this commit with "git cherry-pick --skip".
 	hint: To abort and get back to the state before "git cherry-pick",
 	hint: run "git cherry-pick --abort".
-	hint: Disable this message with "git config set advice.mergeConflict false"
+	hint: Disable this message with "git config set --global advice.mergeConflict false"
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
@@ -75,7 +75,7 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: Disable this message with \"git config set advice.mergeConflict false\"
+	hint: Disable this message with \"git config set --global advice.mergeConflict false\"
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
diff --git c/t/t3602-rm-sparse-checkout.sh w/t/t3602-rm-sparse-checkout.sh
index 252df28bbf..bccb31a5a1 100755
--- c/t/t3602-rm-sparse-checkout.sh
+++ w/t/t3602-rm-sparse-checkout.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup' "
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
-	hint: Disable this message with \"git config set advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set --global advice.updateSparsePath false\"
 	EOF
 
 	echo b | cat sparse_error_header - >sparse_entry_b_error &&
diff --git c/t/t3700-add.sh w/t/t3700-add.sh
index 2947bf9a6b..59e48482a2 100755
--- c/t/t3700-add.sh
+++ w/t/t3700-add.sh
@@ -31,7 +31,7 @@ test_expect_success 'Test with no pathspecs' '
 	cat >expect <<-EOF &&
 	Nothing specified, nothing added.
 	hint: Maybe you wanted to say ${SQ}git add .${SQ}?
-	hint: Disable this message with "git config set advice.addEmptyPathspec false"
+	hint: Disable this message with "git config set --global advice.addEmptyPathspec false"
 	EOF
 	git add 2>actual &&
 	test_cmp expect actual
@@ -386,7 +386,7 @@ test_expect_success '"git add" a embedded repository' '
 		hint: 	git rm --cached inner1
 		hint:
 		hint: See "git help submodule" for more information.
-		hint: Disable this message with "git config set advice.addEmbeddedRepo false"
+		hint: Disable this message with "git config set --global advice.addEmbeddedRepo false"
 		warning: adding embedded git repository: inner2
 		EOF
 		test_cmp expect actual
@@ -425,7 +425,7 @@ cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
 hint: Use -f if you really want to add them.
-hint: Disable this message with "git config set advice.addIgnoredFile false"
+hint: Disable this message with "git config set --global advice.addIgnoredFile false"
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
diff --git c/t/t3705-add-sparse-checkout.sh w/t/t3705-add-sparse-checkout.sh
index 975f9218b0..2e97e3c003 100755
--- c/t/t3705-add-sparse-checkout.sh
+++ w/t/t3705-add-sparse-checkout.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup' "
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
-	hint: Disable this message with \"git config set advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set --global advice.updateSparsePath false\"
 	EOF
 
 	echo sparse_entry | cat sparse_error_header - >sparse_entry_error &&
diff --git c/t/t7002-mv-sparse-checkout.sh w/t/t7002-mv-sparse-checkout.sh
index 9c0e82ba31..666317fdf9 100755
--- c/t/t7002-mv-sparse-checkout.sh
+++ w/t/t7002-mv-sparse-checkout.sh
@@ -32,7 +32,7 @@ test_expect_success 'setup' "
 	hint: If you intend to update such entries, try one of the following:
 	hint: * Use the --sparse option.
 	hint: * Disable or modify the sparsity rules.
-	hint: Disable this message with \"git config set advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set --global advice.updateSparsePath false\"
 	EOF
 
 	cat >dirty_error_header <<-EOF &&
@@ -45,7 +45,7 @@ test_expect_success 'setup' "
 	hint: To correct the sparsity of these paths, do the following:
 	hint: * Use \"git add --sparse <paths>\" to update the index
 	hint: * Use \"git sparse-checkout reapply\" to apply the sparsity rules
-	hint: Disable this message with \"git config set advice.updateSparsePath false\"
+	hint: Disable this message with \"git config set --global advice.updateSparsePath false\"
 	EOF
 "
 
diff --git c/t/t7004-tag.sh w/t/t7004-tag.sh
index 8c795d7218..49cdb6fdb0 100755
--- c/t/t7004-tag.sh
+++ w/t/t7004-tag.sh
@@ -1887,7 +1887,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint:
 	hint: 	git tag -f nested annotated-v4.0^{}
-	hint: Disable this message with "git config set advice.nestedTag false"
+	hint: Disable this message with "git config set --global advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_cmp expect actual
diff --git c/t/t7400-submodule-basic.sh w/t/t7400-submodule-basic.sh
index eefdecb0bd..36ff5b9546 100755
--- c/t/t7400-submodule-basic.sh
+++ w/t/t7400-submodule-basic.sh
@@ -231,7 +231,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		The following paths are ignored by one of your .gitignore files:
 		submod
 		hint: Use -f if you really want to add them.
-		hint: Disable this message with "git config set advice.addIgnoredFile false"
+		hint: Disable this message with "git config set --global advice.addIgnoredFile false"
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
