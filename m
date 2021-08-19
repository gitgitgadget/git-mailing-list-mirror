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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884BBC4320A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E6561075
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhHSUKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhHSUKr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:10:47 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C277C0613D9
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:09 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id s4-20020ad44b24000000b0035c77ac6861so5352174qvw.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GtDJwGeOmkpjVKgwAk3YCpxAa9e5dXZn18GHFSpKqAg=;
        b=KIWolS83jTMd6hgyvso/gEwkisVCHrUPn5AZtfwZAL/DMptRxWjSkNavJuI+IaMvFL
         PV0jNOhtIzlV5NmN/Oqk/zSI4r1iQa8QrGtwPTsGgbrBYLDK2wqWwGAHF7x6g5TwRhxS
         kEpsfVTw7wm+OfzJqJ5uamhk55akMAs5ExfwsHD79wGdPZ7Qv/XR+Zig3N2asxZWIMoU
         JPVNQLGXzpcXZgB8rL5CulC3jpyKDmOxPOW18Ru7nO9Woj5ewnYZogP2A9ODiemE8E4v
         ZFz4bwX7KMayluw7ntxHyU1TKLxzqOmJs9gzf818NVIhgCuqF/aBTR0YhAGeMRtVufoY
         W0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GtDJwGeOmkpjVKgwAk3YCpxAa9e5dXZn18GHFSpKqAg=;
        b=WOFfAKz/iVleNrqFZdzBQT7mPeh/JVCp79Na+3C2E2BnjPFGZx442MR4y6fF9REVFd
         K8kqAVHHvAMd/2jd+bekwHU8ShETVpE3PkmSZqluYqKjWnBbhm5g/0IPMEDJQbSLXFdo
         EioRXmCw1mCsnjvc9DX3PjRLiNSySxPr4O/pc8UNlpYOhncZdfseBCFzGdLUQpCDqu7k
         nzlx+sjt5G2h6SsT3AS+fDsf9syb4mjmQAoE2WvxWuUODO3TlT0jF8wzqFN0U3mliPBQ
         M0y+OeYlbafk168xAKUh0YjMWwHbB6w21xFzeBbQs7Xdnb+vH7BQLiQmqB5tLeJALr8T
         osZw==
X-Gm-Message-State: AOAM531/0kdLTMWwRgwbdFy6xPcIM5TGOd6aSb1UKVXliLstxgRN3twd
        1LfR7vzO+nJFug5pIV7e2ZM+DoapuS1CU+adzQgMg/EOFl/HXepAykejIW+nm5eRpt3t4IOQIpn
        3G3e0u4eGSnW5wwt62RHtx0d2NoY0wXs9QL+1Aat32JgEiV/phQwmgITbHCihhDC71VSlmgYzEQ
        ==
X-Google-Smtp-Source: ABdhPJz84xyIT1vvrPEQBEbks/8t3bDFznBWDhImayVC1drOtsjQSDFe24GolifQBp/O/x7Pd+LmzRSslofCNAKAgBw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:fca2:: with SMTP id
 h2mr7124008qvq.5.1629403808409; Thu, 19 Aug 2021 13:10:08 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:09:52 -0700
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com>
Message-Id: <20210819200953.2105230-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819200953.2105230-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 3/4] submodule: record superproject gitdir during absorbgitdirs
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
2.33.0.rc2.250.ged5fa647cd-goog

