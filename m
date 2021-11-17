Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0825C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D866128E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKQBAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhKQBAI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:00:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37589C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso1199737ybm.22
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XlwPBwXJVVPEQqpM3hOUg8HbBOJ4cEXjwakSA6/E4Ms=;
        b=TqeHAASC0K3F54amrPWb6HqIkPC+WytGg8VAB+H5vJJ6t3CY8Z8oYEKqCWWs99i/0H
         W0wTw9YNzvIBMGGKpci4MD39W7NARY4tm2zxOsa9UqxKIbT4sNPE2AxLAPKcGKHqViFw
         AvSi30q9gGB9kx0o5/9mLm74O3Z1o9CaqV/jDtcjrSUqnn+LkwBZ3j3qDfjCT2leGhgR
         K2MFTliaBYKtpJzXhDQ6T4pxdbjGQlgQrKrqn3gmwy/GPNeMTy7KT2NVWvwoa8hiJgZS
         GwUIrJN8XDNgIP3s8w58QvpVwMUBhUR8AXGiNTP4eQzzAXBysGVDIa+VQVF7GY8SFhgT
         88SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XlwPBwXJVVPEQqpM3hOUg8HbBOJ4cEXjwakSA6/E4Ms=;
        b=0eneL/Nl+V8WqV4YmABEAQfrC3+IotB78dPII7+76zN8HO4hU+mimuyvJek4/Dnf7F
         UgfEdle0jFEYpYOr6VR0f8pdNCzOjJk4J7OpifiHEDJW3NE8S0ObxJNgXEVhDhNdEak9
         +XT4xJeQhpq2ckqkAohmdw4mS8MkaFnqFkRk1Zejvuts3LERCMaW1WOTx0A0NAUUjf1S
         ztIpKCBg3uQOBF4o4D+KLxRry5x3rHbN62cPm/MPxIwLDw6VpoQQoaob4Nir7CMSh8+B
         ZAe8FH3xNEmqrkGV03J9s+F4nNytuVmx+7A/k+ePqLZ7VoX0EYLjfZOwkE2wZ9zwTNkg
         6Myg==
X-Gm-Message-State: AOAM532sv9FrSU9vWbIzlVDbdqmMkc3NdgJhgpnSWnJ4t0o1OciHfDeL
        0QA7ksRvB48cjcIBgHhJvN0GbFX91D9Is2+duzcnI0lhaiOV1+kvXszd3KGjz+ZEw9q9X0sxALe
        27nK3/o+R2zD6q2VGf7dL52z6CCYM4jO4F6L9uf0RH0AtzEyFtQCjF7K/We9+WZWw4bhL9Xs61g
        ==
X-Google-Smtp-Source: ABdhPJzuT5XH4ixYAs2/t8PyGCTgjeSI/YaPGgrUi3aaBRdcPjXY2xxgKebY1fvHoDAc5Dnnov0bT5HnU9oIUl8PCHk=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:205d:7edd:a3da:3608])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:4d3:: with SMTP id
 v19mr12708150ybs.500.1637110630411; Tue, 16 Nov 2021 16:57:10 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:56:58 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20211117005701.371808-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v6 2/5] introduce submodule.superprojectGitDir record
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules a reference to their superproject's gitdir. This allows
us to A) know that we're running from a submodule, and B) have a
shortcut to the superproject's vitals, for example, configs.

By using a relative path instead of an absolute path, we can move the
superproject directory around on the filesystem without breaking the
submodule's pointer. And by using the path from gitdir to gitdir, we can
move the submodule within the superproject's tree structure without
breaking the submodule's pointer, too. Finally, by pointing at the
superproject's worktree gitdir (if it exists), we ensure that we can
tell which worktree contains our submodule.

Since this hint value is only introduced during new submodule creation
via `git submodule add`, though, there is more work to do to allow the
record to be created at other times.

Once this new config is reliably in place, we can use it to know
definitively that we are working in a submodule, and to know which
superproject we are a submodule of. This allows us to do some
value-added behavior, like letting "git status" print additional info
about the submodule's status in relation to its superproject, or like
letting the superproject and submodule share an additional config file
separate from either one's local config.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/submodule.txt | 12 +++++++++++
 builtin/submodule--helper.c        | 11 ++++++++++
 t/t7400-submodule-basic.sh         | 32 ++++++++++++++++++++----------
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index ee454f8126..61d975745e 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -91,3 +91,15 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.superprojectGitDir::
+	The relative path from the submodule's gitdir to its superproject's
+	gitdir. When Git is run in a repository, it usually makes no
+	difference whether this repository is standalone or a submodule, but if
+	this configuration variable is present, additional behavior may be
+	possible, such as "git status" printing additional information about
+	this submodule's status with respect to its superproject. This config
+	should only be present in projects which are submodules, but is not
+	guaranteed to be present in every submodule, so only optional
+	value-added behavior should be linked to it. It is set automatically
+	during submodule creation.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e630f0c730..24f0ef2a78 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1838,6 +1838,17 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
 
+	/*
+	 * Set the path from submodule's new gitdir to superproject's gitdir.
+	 * The latter may be a worktree gitdir. However, it is not possible for
+	 * the submodule to have a worktree-specific gitdir or config at clone
+	 * time, because "extensions.worktreeConfig" is only valid when set in
+	 * the local gitconfig, which the brand new submodule does not have yet.
+	 */
+	git_config_set_in_file(p, "submodule.superprojectGitDir",
+			       relative_path(absolute_path(get_git_dir()),
+					     sm_gitdir, &sb));
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d69a5c0032..3d146491df 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -109,12 +109,24 @@ submodurl=$(pwd -P)
 
 inspect() {
 	sub_dir=$1 &&
+	super_dir=$2 &&
 
 	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
 	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
 	git -C "$sub_dir" update-index --refresh &&
 	git -C "$sub_dir" diff-files --exit-code &&
+
+	# Ensure that submodule.superprojectGitDir contains the path from the
+	# submodule's gitdir to the superproject's gitdir.
+
+	super_abs_gitdir=$(git -C "$super_dir" rev-parse --absolute-git-dir) &&
+	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --absolute-git-dir) &&
+
+	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" = \
+	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
+						"$sub_abs_gitdir")" ] &&
+
 	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
@@ -138,7 +150,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -240,7 +252,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -256,7 +268,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -272,7 +284,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -288,7 +300,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -304,7 +316,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -320,7 +332,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -351,7 +363,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -492,7 +504,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -551,7 +563,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.34.0.rc1.387.gb447b232ab-goog

