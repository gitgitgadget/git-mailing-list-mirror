Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5601F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfA3JtI (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3JtH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so39955pgp.6
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9/Kpl+61rd31y0vY+VgLy2XCFr4qeOVICy0P2P9Q64=;
        b=tyBxJ/G041i+w1ykRWIKhoVZwpEkCBwiOlpyjTDkuE05MoGnA8hEqk7/mQKxT1XvWT
         qxHqqN03FC4vzr3yG1++DBe217AlD5l8mFo7zNVEwLtNLHRuYinb+65iAV8lwRnDhSGI
         pSzSNkbF+sXoOJgUbyEm7S0SCNZ+LL6Q3LmCK7hFz7Z+mVVnG02TygHBxrqRKbt+FbUg
         pkyP2oCRLGqJMMHvT53ZUB1wPPNKBilfd52dubo5SzfnTbVgN7sy5fF/xcAJLx7NEkis
         VQ4ywmYZ1f2nwQvSBozTzlwFsZprwOdOBQCF4WNNxNc2mKWW0KYTqTu/3kOybTyXMb8W
         bvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9/Kpl+61rd31y0vY+VgLy2XCFr4qeOVICy0P2P9Q64=;
        b=qakhuvrcfTZ1NS11pN64IXnTnex4Y1pL7be/sFY+TLWT6Swb//mkKAZN0d1uuYHXO8
         lJwgqYSrXVjsuRNU+HQBpyYsoit4x6NbdKxrKU1puVz012YC5SN1NxLw36N7nzReNbhU
         2M1xVVmt64W9irG20uv9eWjloaFiVik99vGjuYOruUjblWvEriR+K23lqtx1jw0XD2EB
         O1qEdSTkMJ9BJq2KMFt6JjEXlBB6zuef7A9+V7Xxf2Pfq/z5TIUo4C8c2Wzagw5oOqeS
         nlX3glrHoIu5hjbj6mCjgXnowsHWRb2gNXBughVu+zWABqyGpxiwhiiInKn53jDiFwpI
         hDmA==
X-Gm-Message-State: AJcUukdnqZ5yoeTGadQiyRy+VqrSoK4CCmAFHeypAUhipQmt6uaMvodq
        ENrpQHl5s7GOJP6naNkmY83A8Yr1
X-Google-Smtp-Source: ALg8bN6NwAWE0mI5a+WdIX1aj5X2Hz+os3gsuDzBJDoDotWDCtluTDusgHKYDPm8VXICoH75evCqXw==
X-Received: by 2002:a62:1484:: with SMTP id 126mr29461337pfu.257.1548841746620;
        Wed, 30 Jan 2019 01:49:06 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m9sm5774705pgd.32.2019.01.30.01.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/19] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
Date:   Wed, 30 Jan 2019 16:48:18 +0700
Message-Id: <20190130094831.10420-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These local variables are referenced by struct option[]. This struct
will soon be broken down, moved away and we can't rely on local
variables anymore. Move these two to struct checkout_opts in
preparation for that.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 66f99e788d..5914dd3619 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -46,6 +46,8 @@ struct checkout_opts {
 	int show_progress;
 	int count_checkout_paths;
 	int overlay_mode;
+	int no_dwim_new_local_branch;
+
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -57,6 +59,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+	char *conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -1329,8 +1332,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts real_opts;
 	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
-	char *conflict_style = NULL;
-	int dwim_new_local_branch, no_dwim_new_local_branch = 0;
+	int dwim_new_local_branch;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
@@ -1355,12 +1357,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_BOOL(0, "no-guess", &no_dwim_new_local_branch,
+		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
 			 N_("do not second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
@@ -1378,6 +1380,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts->prefix = prefix;
 	opts->show_progress = -1;
 	opts->overlay_mode = -1;
+	opts->no_dwim_new_local_branch = 0;
 
 	git_config(git_checkout_config, opts);
 
@@ -1386,7 +1389,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	dwim_new_local_branch = !no_dwim_new_local_branch;
+	dwim_new_local_branch = !opts->no_dwim_new_local_branch;
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
@@ -1394,9 +1397,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts->show_progress = isatty(2);
 	}
 
-	if (conflict_style) {
+	if (opts->conflict_style) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
-- 
2.20.1.682.gd5861c6d90

