Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66261C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476D761130
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJNUgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbhJNUgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:36:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F5C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a252256000000b005b67a878f56so2028236ybi.17
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s4sEv+6xVXcWi7T5s6s6soiQrcCHXeCvHZIVwXF0ccc=;
        b=mJjcZ6yxGL1gYQfqiCnIq/xQIYzittARA4GIws6h6cDrsBrZRnWsXjTbbbe3QJaXoR
         B540L8CraJI/kv23BHRrmKEqz8LpJRPNUIIjAg/8yD68sfe9fuBuE/JX5xN2pM5v8w2v
         D/3U1LquEz5RYuNI7EEjRGlQV0UlSHPkiR1DT6xP/6x2Nr38R3z7RShJTAAWo3iwIlmz
         3v/44nGrIDy+F9/fK3CvGSbz2UG5vEpPMTEv5xSMNG+vtt3QDD33l/cR4W7rKIizfXLJ
         JsL7EjpCOrfvCMvIzYNmteV/H/b6sE9wT6p+BCWCToQ5LL18/BJFmtEwA0CNiCWiFPq9
         VGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4sEv+6xVXcWi7T5s6s6soiQrcCHXeCvHZIVwXF0ccc=;
        b=JrSMp0xZl2ZKEm/cj+HYSyLdBvevdx33BxylTAEyq/S8HE1XZgKTyhlBONNjR7Xa6t
         uQ5Ame6aRkww5sZrziwzWJJWxmvK4gO2SFZzGtrfWHSt2XLPnB1+NR/IRnlq5o6vI/pd
         1c4LKWKknjFLnAzYijVwzReRObDP318R1VF/Nc/bOWAbcxmM4NTbFGYfKH3vWpPPpEmX
         4AMj/Z1yvQS+qwebV8d72fmFb1Xp4PvnY5Ykshi+d0I89sfP9YWVNtjRWVEAKb5qfu5l
         S3DL74otf5Hiiu2oKzb5Ac47FsaTiVNB/HsRn2Zqflq8gP1MFPjKkOOsrmeo/ckAhB1A
         zN1A==
X-Gm-Message-State: AOAM531/m1Yj08iK3OljNK6NTjzKdV7pSr4nXZj+ucFZfNgWLwJVnL38
        yRmirTZKUOfp3NC6PJFI5krbM8YUdEp5q/+14RQWDC8BNekJktxbT1HN1IuVGPMZpeugGscFjV3
        bAzqqq5KKxyBV66Et/95RB0DhJ8FJJX3l+OhbbuualNCtfKt1AlgdJ/ptQLhTw8ZWJnC6g1WddQ
        ==
X-Google-Smtp-Source: ABdhPJyE1cGEXpqgws+flNGJXB7gmPGZ/cOK+PR8Nko5kXwVBG+yCsmaHZEm2xVtRmlmhZiuU7NGh1f1BZ/4sTHZL6M=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d3cd:: with SMTP id
 e196mr7854518ybf.274.1634243679066; Thu, 14 Oct 2021 13:34:39 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:34:15 -0700
In-Reply-To: <20211014203416.2802639-1-emilyshaffer@google.com>
Message-Id: <20211014203416.2802639-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211014203416.2802639-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 3/4] submodule: record superproject gitdir during absorbgitdirs
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
submodule absorbgitdir'. Let's start adding that pointer during 'git
submodule absorbgitdir' too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 submodule.c                        | 10 ++++++++++
 t/t7412-submodule-absorbgitdirs.sh | 23 +++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 96487517f9..571b68b66d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2084,6 +2084,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2114,6 +2115,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
+	/* cache pointer to superproject's gitdir */
+	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
+	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
+	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_dir()),
+					     real_new_git_dir, &sb));
+
+	strbuf_release(&config_path);
+	strbuf_release(&sb);
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..9ee5ccd660 100755
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
+	submodule_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
+	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
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
+	sub1_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
+	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --absolute-git-dir)" &&
+
+	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
+		>expect &&
+	git -C sub1/nested config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 're-setup nested submodule' '
-- 
2.33.0.1079.g6e70778dc9-goog

