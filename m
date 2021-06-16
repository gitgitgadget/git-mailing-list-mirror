Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F645C48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3955B61153
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhFPAr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhFPAr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:47:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DBEC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id eb2-20020ad44e420000b029025a58adfc6bso832880qvb.9
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UHH7lt3Mp23ZWUnF+lHu8bmsruUoRPJCsYStn0pWHOo=;
        b=NwmdsDDowA3o28EzNyTp/F0yGtvHTQQvIuwxmfikd9RQgRj4mzs0qk1mt8neC7geH1
         tplmMvqabFluE/7F2lkh6cyRfRTOI9BwqiDYX5wvxyR7lPRgwUBloz4W1vUO16wjWPtt
         gfyaWtRs3dugX5RHrO+2eSkt54UWL4rDfVeh2v2JC9BTvfVKG/hgzAX2qTA4Y5ddIPxk
         30AtJkgTqlHPcJsu1HBe2habQ6jmzx3lmceuBy59tUjk2xOJaJzBegoiNyZkyxG1bg1R
         lORPwpftnTvnpJWdfLhq83rbjiKp/gkNrthf3T8II6mLdFck6Y0dEqZkX+8xXJKuLbcX
         4ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UHH7lt3Mp23ZWUnF+lHu8bmsruUoRPJCsYStn0pWHOo=;
        b=dRVXQmPSufvsrqBb7mepldS7n+ghHwU1fCsmt+cqhznnYuD1lNN4ISc8UpCW5mP1UF
         1/ry09q/yt/rkKi9nMCtEULpV74jjqHsToWDmdvuu+VmDmeIKh5LXLdxCFDerS+Cai23
         AyrzISEu/dYNnP52ngXknkP7QxAYHELh9tDo6v6CGlxQgfF8VymexJaP7Hxx9dZm7oIZ
         f2lBnVFCBAd/IZXk1XkxUwCfhSoip92MZx31I5ZysFcUnSl4XtaZp+lq8DumX6Hk7id2
         bfhw2BJ0GbhrqrGz2OREegVMB/VyNY6MpngfmpPKltrQULi470OM/YIlUJhqA+FYZ2KH
         2sAw==
X-Gm-Message-State: AOAM530U5qruKirX1+Uh7x0GIfnvw5wMEZkPilmXTbBDbpW3KgTLBxrj
        ea0C2CjirUxj75W1YoVfbXKt/umGIVc2PjZ02Dyi78YE2TH4boxExu5CUVrx3x4F1qHejS3SgwR
        5b0zyADETjZSUuxPxpZU7nl4RF6ZTPYBP4WPNiQ5SSQ1FYpVVqZtchSzG88MuoMOWf4UBLw8VqQ
        ==
X-Google-Smtp-Source: ABdhPJwpZI2AwhRC/PEQvQoqX62QiyG3JovcJNzgsIVjn8xMevgEpTJPfo5dHhBi+kcvgLp6kMlMUDQIvWyTOs84O50=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:c3d1:: with SMTP id
 p17mr8044970qvi.44.1623804321541; Tue, 15 Jun 2021 17:45:21 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:45:07 -0700
In-Reply-To: <20210616004508.87186-1-emilyshaffer@google.com>
Message-Id: <20210616004508.87186-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 3/4] submodule: cache superproject gitdir during absorbgitdirs
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
 t/t7412-submodule-absorbgitdirs.sh |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0b1d9c1dde..4b314bf09c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2065,6 +2065,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	char *new_git_dir;
 	const struct submodule *sub;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2096,6 +2097,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
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
index 1cfa150768..e2d78e01df 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -30,7 +30,14 @@ test_expect_success 'absorb the git dir' '
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	# make sure the submodule cached the superproject gitdir correctly
+	test-tool path-utils real_path . >expect &&
+	test-tool path-utils real_path \
+		"$(git -C sub1 config submodule.superprojectGitDir)" >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
-- 
2.32.0.272.g935e593368-goog

