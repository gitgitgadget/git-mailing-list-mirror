Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E06C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C5D6121E
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhKDXwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhKDXwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:52:31 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE852C061203
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:49:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id r11-20020a170902be0b00b0013f4f30d71cso4190942pls.21
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fV5D4pQFLfA71bOd38Q0C8+XTC5euEmmysSKNSx4C+w=;
        b=SjGkhcYzTeCtFzl87fGnMWOkwcPbVgabGW5DU1pdmQ/3XC5NEYd346IByw8oqCzW5N
         nHA/fkL8vCkeTzQqdwH30+Cte3fo+Iw83p6WTjvR9v5lzEnq8wHnDBwi4LtHD9XI0jiu
         TCbNo4auHEqyWxlxAwg8pSJ4v2dAIHsmeWiNiT5FretTssM3Ib07poypI2ZsMtG09QZh
         FoWTfDdJ0YBBVLJYbJVdef5aSFfe0twWWX0ARIor9/4s4C9gyc8RbR4Ex44IHHV1YW/N
         eRdySwi1J4s7ElWKbJl2Jn7d4cjMpyKvoeFQU83rPSDqPh7Fwbe5qGrzU+CjHM/C6Xdc
         GWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fV5D4pQFLfA71bOd38Q0C8+XTC5euEmmysSKNSx4C+w=;
        b=aYAZaDP9JpLgQ/c93T5H1C17cETUv7Hz3wqO5DlZRwMRz+szYAGEsdBCPYHh6E4MNE
         wDluu8y62YKGCI7BaWOUCZot1VdYmWg/1GKwRVNqey28SYzDDRlcQWleVHJ7hvagdWsv
         UDsWUFTI7nfmcnupkPIuufJyf4oFF3JlsXPOiAmh1pnisaenBPhGmKYb79gdKDPPgrJx
         73TLUxlG8RvfPdRXDObfltndqWJy1/NV17lNv84L3NXcBrhcvOl7L0CWB8LKw7qUVD9r
         F5NGzD2/OOYSWZ/xeYdhpqojCM+3+z+y3tv1LWOvTPkShLZ2O0+Q5QQmTHFlLY/dzZmU
         1UYA==
X-Gm-Message-State: AOAM5336E+Qy3d2gde2fZou6g9lyV9AIJDD1je3ZQYx4/CEEdMs8IUnA
        hCnig7XoHXs9rLZYHQBAG6y5GWtJeZFAv1WqI11QGy9DdErdu0rL4wBgGPSJtGlkWI3sLHo42Zp
        4a3Wyf6NDP1epSoUXws4DFlvNpz/xr9LVFZ4OlTGIy/vKIJIH+2/Usi3j9GjZogDSLq7DejyBDQ
        ==
X-Google-Smtp-Source: ABdhPJzCpBc0LTgez+CQKO/igJXiyJ8tWh7+yTUgO0gI9gS0F8zY12536Q78QVg6GCVn2t1hbvJHTiWlGiZqER9itiA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:c3:: with SMTP id
 v3mr79647pjd.0.1636069791761; Thu, 04 Nov 2021 16:49:51 -0700 (PDT)
Date:   Thu,  4 Nov 2021 16:49:41 -0700
In-Reply-To: <20211104234942.3473650-1-emilyshaffer@google.com>
Message-Id: <20211104234942.3473650-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211104234942.3473650-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 3/4] submodule: record superproject gitdir during absorbgitdirs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Already during 'git submodule add' we record a pointer to the
superproject's gitdir. However, this doesn't help brand-new
submodules created with 'git init' and later absorbed with 'git
submodule absorbgitdirs'. Let's start adding that pointer during 'git
submodule absorbgitdirs' too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 submodule.c                        |  9 ++++++
 t/t7412-submodule-absorbgitdirs.sh | 50 ++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index c689070524..2e54dcf1a2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2097,6 +2097,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2127,6 +2128,14 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
+	/* cache pointer to superproject's gitdir */
+	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
+	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_common_dir()),
+					     real_new_git_dir, &sb));
+
+	strbuf_release(&config_path);
+	strbuf_release(&sb);
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..b6f229043d 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -30,7 +30,17 @@ test_expect_success 'absorb the git dir' '
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	# make sure the submodule cached the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
+	superproject_gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub1 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
@@ -61,7 +71,16 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	sub1_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
+	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
+		>expect &&
+	git -C sub1/nested config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 're-setup nested submodule' '
@@ -130,4 +149,31 @@ test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
 	test_i18ngrep "not supported" error
 '
 
+test_expect_success 'absorbgitdirs works when called from a superproject worktree' '
+	# set up a worktree of the superproject
+	git worktree add wt &&
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub4 &&
+	test_commit -C sub4 first &&
+	git submodule add ./sub4 &&
+	test_tick &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub4 &&
+
+	# make sure the submodule cached the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub4 rev-parse --path-format=absolute --git-common-dir)" &&
+	superproject_gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub4 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.34.0.rc0.344.g81b53c2807-goog

