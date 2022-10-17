Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3653C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiJQNSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJQNR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689961D71
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l32so8629665wms.2
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3Omp7XenVN67hPeqLMKSf3k2o/8oFmfRIUuQR1BZGY=;
        b=aOMhPNVnh/I+4Ao9Wc4woJa2GBf7whNj4WRw+QnT/6QIbX+1TDe/yO3CaMjp1xuXed
         EqmtGVU9rTZp8aRvf8LFBRgSt2sosMvuUxTAeDDg/zLuXJHHW4OCwMeh/MPSIq4bgSEk
         N8B2K6xBmTxupRYcCBhe8GosA52ZCCUOawRKZRsZrFRWHkjoEjWwAmpZygBeBs6G7HlI
         ErzxGFuLO84nvYhSn0DqNP4h4nNHShRbK68WNvFtnPJWfnp2ope6WB1oy41LZ0odZiaA
         WpJ5y+Udt9Gqcpo3L/YdAdyMrwcS2H5en/KMRo4FkplT6W2aUWS6pv7opW9Jyd9UIHY/
         FjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3Omp7XenVN67hPeqLMKSf3k2o/8oFmfRIUuQR1BZGY=;
        b=2s6z8LOnna0Ce3HWKPAEpH8m+Vyn1k8IrgfhrX7k54bZiF3VJw1HkcyU7bMb9oAD1O
         wiChN86Mgyw8S9nhVHnBoK3bzIeD1DMHps11lypHuL8Xp+9fR1V9oxG3xsJ+L2TytK8m
         FjTTF8ABIrm9UfWvrqhM3f3yZU8Kto7Ztyld6oNZm8dV4de0I20EWm4Iwp+4w/XIw39J
         j5Y8KhI0ve+TSoSZE+mG1ctIOGxotSafib2KhDKfTJbd0KyKtvtJmJ7dzHSzOYhiUtPC
         DpCIbpZnvx1PrBY0gPeX1B8Q0k2jUTL9Q+oAcjD3gABlZ9gWhy6JSpV5YkeJL1SZpr2Q
         jC3w==
X-Gm-Message-State: ACrzQf0rw8wchHVAgk0zR7+Xqa4qFHt2jcHfosYY89CaZgb/hqiALo74
        +HTeMSlPC96qEq5qC+RE5t/VesHdjjM=
X-Google-Smtp-Source: AMsMyM5vGxasnbaBD922oxm1UC3Fh+OelHAqreIGux7VrdPxTITw1zYLpZMoiDVgb8Vqnde+Lmomxg==
X-Received: by 2002:a05:600c:219a:b0:3c6:f259:7e30 with SMTP id e26-20020a05600c219a00b003c6f2597e30mr6524966wme.111.1666012673450;
        Mon, 17 Oct 2022 06:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b00232251d71c7sm8346266wrt.68.2022.10.17.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:52 -0700 (PDT)
Message-Id: <367e44c6928a5f1f9dc31b2068cba1c91229c9eb.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:44 +0000
Subject: [PATCH v4 7/8] rebase --keep-base: imply --reapply-cherry-picks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As --keep-base does not rebase the branch it is confusing if it
removes commits that have been cherry-picked to the upstream branch.
As --reapply-cherry-picks is not supported by the "apply" backend this
commit ensures that cherry-picks are reapplied by forcing the upstream
commit to match the onto commit unless --no-reapply-cherry-picks is
given.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt     | 26 ++++++++++++++++----------
 builtin/rebase.c                 | 16 +++++++++++++++-
 t/t3416-rebase-onto-threedots.sh | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 080658c8710..ee6cdd56949 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -218,12 +218,14 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	merge base of `<upstream>` and `<branch>`. Running
 	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
+	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
 upstream branch may advance and it may not be the best idea to keep
-rebasing on top of the upstream but to keep the base commit as-is.
+rebasing on top of the upstream but to keep the base commit as-is. As
+the base commit is unchanged this option implies `--reapply-cherry-picks`
+to avoid losing commits.
 +
 Although both this option and `--fork-point` find the merge base between
 `<upstream>` and `<branch>`, this option uses the merge base as the _starting
@@ -278,7 +280,8 @@ See also INCOMPATIBLE OPTIONS below.
 Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
 by `git log --cherry-mark ...`) are detected and dropped as a
-preliminary step (unless `--reapply-cherry-picks` is passed).
+preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
+passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -311,13 +314,16 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream changes, the behavior towards them is controlled by
 	the `--empty` flag.)
 +
-By default (or if `--no-reapply-cherry-picks` is given), these commits
-will be automatically dropped.  Because this necessitates reading all
-upstream commits, this can be expensive in repos with a large number
-of upstream commits that need to be read.  When using the 'merge'
-backend, warnings will be issued for each dropped commit (unless
-`--quiet` is given). Advice will also be issued unless
-`advice.skippedCherryPicks` is set to false (see linkgit:git-config[1]).
+
+In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
+given), these commits will be automatically dropped.  Because this
+necessitates reading all upstream commits, this can be expensive in
+repositories with a large number of upstream commits that need to be
+read. When using the 'merge' backend, warnings will be issued for each
+dropped commit (unless `--quiet` is given). Advice will also be issued
+unless `advice.skippedCherryPicks` is set to false (see
+linkgit:git-config[1]).
+
 +
 `--reapply-cherry-picks` allows rebase to forgo reading all upstream
 commits, potentially improving performance.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 90ae8fd8de7..d718b7fe888 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1180,6 +1180,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
+	options.reapply_cherry_picks = -1;
 	options.allow_empty_message = 1;
 	git_config(rebase_config, &options);
 	/* options.gpg_sign_opt will be either "-S" or NULL */
@@ -1239,6 +1240,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.root)
 			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
 	}
+	/*
+	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
+	 * commits when using this option.
+	 */
+	if (options.reapply_cherry_picks < 0)
+		options.reapply_cherry_picks = keep_base;
 
 	if (options.root && options.fork_point > 0)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
@@ -1415,7 +1422,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	if (options.reapply_cherry_picks)
+	/*
+	 * --keep-base implements --reapply-cherry-picks by altering upstream so
+	 * it works with both backends.
+	 */
+	if (options.reapply_cherry_picks && !keep_base)
 		imply_merge(&options, "--reapply-cherry-picks");
 
 	if (gpg_sign)
@@ -1681,6 +1692,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		fill_branch_base(&options, &branch_base);
 	}
 
+	if (keep_base && options.reapply_cherry_picks)
+		options.upstream = options.onto;
+
 	if (options.fork_point > 0)
 		options.restrict_revision =
 			get_fork_point(options.upstream_name, options.orig_head);
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 01eb9513d6c..ea501f2b42b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -199,6 +199,27 @@ test_expect_success 'rebase --keep-base requires a single merge base' '
 	grep "need exactly one merge base with branch" err
 '
 
+test_expect_success 'rebase --keep-base keeps cherry picks' '
+	git checkout -f -B main E &&
+	git cherry-pick F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base HEAD G
+	) &&
+	test_cmp_rev HEAD G
+'
+
+test_expect_success 'rebase --keep-base --no-reapply-cherry-picks' '
+	git checkout -f -B main E &&
+	git cherry-pick F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --keep-base \
+					--no-reapply-cherry-picks HEAD G
+	) &&
+	test_cmp_rev HEAD^ C
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

