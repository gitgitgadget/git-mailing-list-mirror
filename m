Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155E9C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378776AbhLCHFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378750AbhLCHFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F0C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so3594853wrw.10
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jWYQkM/mf0sUzCzXN/riq8peoiKS9S4BFGnyZA/mznw=;
        b=mgqTrKtptSe1xFaVL85ay413QhU4viVH8Nc1ZzXm7+UUk1b1jZKpVEaJNliC1Sx9c3
         fbtGyZrexIojJCif4ISa8lyzFYVd+qdoTo2svNLApzaczjjPyzx6TXJ4gby+gv+/fMmd
         5YBQguHkJRmCHRUyVyKYV4FSIUNzMcrKbn9IsTFVgVzHY7x5jmbxZgYFiT12Lmt/1jxx
         bWWSYv7AlbWNVp6CftiYXA5lwZ6UUrZNoHOtFld06sLPDWMo2YUFxgQgIovmHFUb9WAs
         8N9k/n7VKcrWoWCm9ILkhuLjNoSDJq1AMA2qk/+6BG7ZRpQ62piLFezLzlCjdqM6NrpY
         KwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jWYQkM/mf0sUzCzXN/riq8peoiKS9S4BFGnyZA/mznw=;
        b=zIvjvEnYLBlFIjeUTSa9dU93Ul1vqequS0ERqoGadXsoSjvyd+VnhmaW478BCKZSvc
         rWgvfMMJHFJ+nBetFxLgY0FNBXU2SXLc9rTpBlYHu5QegFQJDVd/rXVVMoRPKPNbVB04
         LTHxsaawZnqsjFixX3fnENSGfGd2dWPEAQglIihzXkpMf6S3RMCCfATORaATOHO7sEeG
         vdDHsKG7p110iwC/WgEyRza0MaWxcyBhaCB//Yy7ADNJml9wIRMfGL6SKMMzGP1TPkK6
         DmjtRDkCv5CCvLc6JYY6O3meD/xhJl4Xq72vbBYDLugxt8mWMMtQ+ISbOSn6c7Q40qMY
         o5vA==
X-Gm-Message-State: AOAM531kR5eHEV0NX/jkAR8nD8cAX0smiSz3CXqaANI8FKeE5W0dscA8
        MFxhMvpaR7NPVFejda3w0jkG8MI2i4g=
X-Google-Smtp-Source: ABdhPJwK2i5Ec/G91d1UCjeoip5qJDdg2QQg+qNrpRgPGW62dGaoeLUgcvQfIwyX95WTjyHAUmjQGg==
X-Received: by 2002:a5d:4a0a:: with SMTP id m10mr19311208wrq.221.1638514912956;
        Thu, 02 Dec 2021 23:01:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j40sm1763194wms.16.2021.12.02.23.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:52 -0800 (PST)
Message-Id: <476eb77aff6fbea926eaec55c9b4febb74282ab4.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:40 +0000
Subject: [PATCH 01/10] i18n: refactor "foo and bar are mutually exclusive"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use static strings for constant parts of the sentences.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/checkout.c          | 2 +-
 builtin/diff-tree.c         | 2 +-
 builtin/fetch.c             | 2 +-
 builtin/init-db.c           | 2 +-
 builtin/log.c               | 4 ++--
 builtin/submodule--helper.c | 4 ++--
 builtin/worktree.c          | 2 +-
 range-diff.c                | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..4bd8a57f190 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1621,7 +1621,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				cb_option, toupper(cb_option));
 
 	if (opts->overlay_mode == 1 && opts->patch_mode)
-		die(_("-p and --overlay are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "-p", "--overlay");
 
 	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
 		if (opts->checkout_index < 0)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index f33d30d57bf..08d5477486a 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -152,7 +152,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_stdin && merge_base)
-		die(_("--stdin and --merge-base are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "--stdin", "--merge-base");
 	if (merge_base && opt->pending.nr != 2)
 		die(_("--merge-base only works with two commits"));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff1..bec3cc7535e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2012,7 +2012,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (deepen_relative < 0)
 			die(_("Negative depth in --deepen is not supported"));
 		if (depth)
-			die(_("--deepen and --depth are mutually exclusive"));
+			die(_("%s and %s are mutually exclusive"), "--deepen", "--depth");
 		depth = xstrfmt("%d", deepen_relative);
 	}
 	if (unshallow) {
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2167796ff2a..1439e05c93d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -557,7 +557,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && is_bare_repository_cfg == 1)
-		die(_("--separate-git-dir and --bare are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "--separate-git-dir", "--bare");
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..a2005e3c778 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1928,9 +1928,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		numbered = 0;
 
 	if (numbered && keep_subject)
-		die(_("-n and -k are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "-n", "-k");
 	if (keep_subject && subject_prefix)
-		die(_("--subject-prefix/--rfc and -k are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "--subject-prefix/--rfc", "-k");
 	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e630f0c730e..beedd873894 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1313,7 +1313,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 
 	if (files) {
 		if (cached)
-			die(_("--cached and --files are mutually exclusive"));
+			die(_("%s and %s are mutually exclusive"), "--cached", "--files");
 		diff_cmd = DIFF_FILES;
 	}
 
@@ -2971,7 +2971,7 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		die(_("--branch or --default required"));
 
 	if (opt_branch && opt_default)
-		die(_("--branch and --default are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "--branch", "--default");
 
 	if (argc != 1 || !(path = argv[0]))
 		usage_with_options(usage, options);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d22ece93e1a..9287c455594 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -700,7 +700,7 @@ static int list(int ac, const char **av, const char *prefix)
 	if (ac)
 		usage_with_options(worktree_usage, options);
 	else if (verbose && porcelain)
-		die(_("--verbose and --porcelain are mutually exclusive"));
+		die(_("%s and %s are mutually exclusive"), "--verbose", "--porcelain");
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
diff --git a/range-diff.c b/range-diff.c
index cac89a2f4f2..bd954988e0f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -556,7 +556,7 @@ int show_range_diff(const char *range1, const char *range2,
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
-		res = error(_("--left-only and --right-only are mutually exclusive"));
+		res = error(_("%s and %s are mutually exclusive"), "--left-only", "--right-only");
 
 	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
-- 
gitgitgadget

