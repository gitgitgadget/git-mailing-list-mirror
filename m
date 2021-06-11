Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C692C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EDF61374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFKW54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:57:56 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36660 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhFKW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 18:57:54 -0400
Received: by mail-qk1-f202.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so739459qkf.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LOPYuWoJG1GmLXx5cVSAjfxC6H+fFWbsSGMiDMrsKN0=;
        b=Zp+dNTFP+gTBLsL4e8+e4U49W02ASOVzN4U9Xku2K+ywWNqzDxPf0HnRKY6GT7xaWZ
         P6ZcA3hjy6HGyoM9ajbBwDEfCFPg8G0AAgnegvGCsDyeFOqjuoAqMHiq7GznszPwgEHL
         5CKWXuOqJQnv8B5g4WWUCGyrJ5/m1aAo0unXm+SrldaKNFosQElMvuCmmL2WLPPb4H3b
         GVYeq3WdVe/kp1dfZq+4ibaC1Y9auCWHIdNa+5O2f9tEv8IwVahfaFyIu1QxnIukNl5+
         SdhTWH7zacfTtNxUzSM/zbKqNKQ+fuKtNaDyjWHDKc8BJj6EUih6erDLwvP6k3h2ARyn
         PXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LOPYuWoJG1GmLXx5cVSAjfxC6H+fFWbsSGMiDMrsKN0=;
        b=mn0UvkFlMCrR5HmKls3fD099ByFVm8mW5HBC2jUCbbfqNKkm0wHgYZ/6/t3uKRGtme
         VZftSLVgPI7VVPzvyG/yGv96BgMah9dR4WBpiD3nvhQaf2Nuf9aLSQr6QWLuJq928Psb
         PEJZcg6MB4SHEbYxev3qzL4FSubXW5OIhPjr/5s0K9YW6FjUjK8mnZ8ysFI05nd3mJ/G
         RNG9cgyDo4Z0r+WyAqqnglKlTnl4VVQ0NnDOeKZ7f7ppo5a1zlxV4u9BWiPv1i5cmKMR
         vamdzgnSt8FnhIAcudKbyJ6dZHgY9X4Di3pVA1C4wnim9DCf98Rafvbeh0wA9FFeoXUH
         6ehw==
X-Gm-Message-State: AOAM532LYCR0cBqBhrAKJ11OlskSLHDKGkleUgEpQUJgKqog/DNqCpvt
        IaQvS2huL/9WelQGXi7fSrZFL4ojZuyng0oCeT22fn39dw6NfyvbmtdNFCItOuc0RbnRyySUO2y
        OQgfrvACObL7uc31ngmMkjeRyZ1jfzSH/ndyUwCjY8QOYgzgq4D8rGyhvgwHP1o4Mtf3K2OA/zA
        ==
X-Google-Smtp-Source: ABdhPJxuWpB83nxS4qi5af2VwBCDum+boKycm3wnNoBVeQgKGx0Kr4kVOodsvCWKPea+oh/MOzJ5aPmSjGMU98Jvj1Q=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c894:862c:2364:ff78])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:4241:: with SMTP id
 l1mr7326118qvq.2.1623452081474; Fri, 11 Jun 2021 15:54:41 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:54:27 -0700
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com>
Message-Id: <20210611225428.1208973-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210611225428.1208973-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 3/4] submodule: cache superproject gitdir during absorbgitdirs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Already during 'git submodule add' we cache a pointer to the
superproject's gitdir. However, this doesn't help brand-new
submodules created with 'git init' and later absorbed with 'git
submodule absorbgitdir'. Let's start adding that pointer during 'git
submodule absorbgitdir' too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 submodule.c                        | 10 ++++++++++
 t/t7412-submodule-absorbgitdirs.sh |  1 +
 2 files changed, 11 insertions(+)

diff --git a/submodule.c b/submodule.c
index 9767ba9893..09dfc4ee38 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2064,6 +2064,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	char *new_git_dir;
 	const struct submodule *sub;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2095,6 +2096,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
+	/* cache pointer to superproject's gitdir */
+	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
+	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
+	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
+			       relative_path(get_super_prefix_or_empty(),
+					     path, &sb));
+
+	strbuf_release(&config_path);
+	strbuf_release(&sb);
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..70fc282937 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -29,6 +29,7 @@ test_expect_success 'absorb the git dir' '
 	test -d .git/modules/sub1 &&
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
+	test . -ef "$(git -C sub1 config submodule.superprojectGitDir)" &&
 	test_cmp expect.1 actual.1 &&
 	test_cmp expect.2 actual.2
 '
-- 
2.32.0.272.g935e593368-goog

