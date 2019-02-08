Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169EA1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfBHJE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:04:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38931 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so1380157pfa.6
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9/Kpl+61rd31y0vY+VgLy2XCFr4qeOVICy0P2P9Q64=;
        b=tVtabV4W0x0tdCcjVvnc3w8dlxutXdwcbDgZcLB7D+OkJVkKtRsLJPBsk0ax4D5fUr
         CAzQsly3wZdpuVrPzFYSH+qz9+FgI3HYuOjy3yezGY8c3McVkCWttIndOiPAlDSDmmNh
         17AdZsX9Z5dvQ/MJCRigW7IEg6vInEXSPL9C/p9ZJPNNpvoF9nyUTQaolwJkxOpcdX5e
         p1aALv8cXvvoVP1PyS232kUUJs3XlvQvpUd+LT9DwGjaW/fpMMl5hdrbHpIABHqBH42t
         3p4JHbO16cVCRSF4E14G7qtXPah8zxgUtERdjzgOFUa5P/3jywGYImr2CmvyUR94hUx2
         Mefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9/Kpl+61rd31y0vY+VgLy2XCFr4qeOVICy0P2P9Q64=;
        b=BtLkv9igjPPe+/d03IAJOscyBfqezdC5pEujIMl/v93yUhivyPog3QSxOxhV1vQVKI
         Us/WEjaTyLZvZuqEEDOXBvBCEm+vRN9W6lA/+wUFQUGYZxDEBI1NwmwfMyrFt+KLUEHY
         BK53sVY3c0CA16UvtuHFoNB2mZR/EK/9+Y4+39drhtKYe8vSUnn5r9f2e3IQblAlj/5M
         iOoQpq43HhKFdeuS6/0IMsbrv90jZD0R/XIF56dfIz5j/M3zBw/VWWYQLQvOcoVltShv
         iNMsjekBLYhY5gCA1noi5t9C8k5UUxwtn2Vcg5zAyEgC9yGfu6398XmSONoxZBd2Q3rx
         UE9A==
X-Gm-Message-State: AHQUAuaTnCBy/KvMYZZZiystmEmNwsrdu5N3+mCf5DGpAdLZFiGVhz+N
        UKjx7jUz2BUbfd06MjmDZDY=
X-Google-Smtp-Source: AHgI3Iaia9sZ291O6kJ6gJp7vOzYeJ3rU5l0KrWeN60EwpmR3Q4BgfbaOcfYNXpHeJ5812kN+HsZmg==
X-Received: by 2002:a63:cf4b:: with SMTP id b11mr19679103pgj.405.1549616696800;
        Fri, 08 Feb 2019 01:04:56 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y21sm91181pfi.150.2019.02.08.01.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:04:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/19] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
Date:   Fri,  8 Feb 2019 16:03:48 +0700
Message-Id: <20190208090401.14793-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
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

