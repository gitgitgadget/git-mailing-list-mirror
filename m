Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2241211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeK3JGP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeK3JGO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so3129965ljd.12
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y02z1xIb8PRvbx6ZfVKDskuPihFlkP+eUcXqnKvHf0Q=;
        b=BzLYJN+Jfh+bNeJUT4quR3dxaRXJ9SzlSmp8XqDhCJ8RyC14KGf1TBIkT3wkNJ4AeZ
         fGl1tVMDxo9i9TdBmx/7BPAuSkQFw8Xgnw1UlKIBtjL/ykDZldMLDdKr8dVRgDpmeKq9
         fEZSW3injaMx1Jbo9tTcgCLe9QhpqC53GWpCnuZOjElT6FgxiOHzftnniVJdrbKIg/TW
         NPut4CkgZ8EHXVXvV8ovh+feqznPFyNrsAjjaxQTb8oH5M7tA41LVoRj0nfuQYvEBXk5
         Q0xExjCJCPrkp1DTc2cGFA/W7EJIlq6Rr3d4yY2qjPJc/Naq0lmVMCwgarUXJ309s17K
         6cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y02z1xIb8PRvbx6ZfVKDskuPihFlkP+eUcXqnKvHf0Q=;
        b=QBzd5aQKu3HABuK0+5ivAVDegFgWkZRLqCGu9xRB9viDgnoRi+VnP4natX08hZXQ16
         P7pL5QDGm595NZREZkvX2IJ8lW/RZLW0CPR6k4Y6/4P3ROIdF+rIo3UrEKjF6SU2tgLd
         f5SjHPfRXauhYfwBfLDoYW9lvXZCZiimbXRcAHsp1/q38p8a00vItN+JbHTv47bFxiVH
         zh9dU8zlglAatJUzpCbItFjJ/K6u5VmNfkrRLH/4zs3Y5S/sh5ok/mfbrKhyaJ90VVb/
         aOIvCc5geCFtW5YcC8AObFw1GbPL2qaavi1GAP4FiTXz/tSzw6CDnbTW9Nlb7sxZxTpi
         1fig==
X-Gm-Message-State: AA+aEWYFwEn5zuZIwNimQSyeBBB+9nIIOj0KUsm6RjT3oaBHvkN8AgBM
        Yi57+5WO9EN/eYViLZCHFpg=
X-Google-Smtp-Source: AFSGD/UhUsQ3XF1wlL66UWcNMj8Cog/TLzsbHgSoLZtEuHLzwm4lCGl5xxj4304MBq25OPY6VyNSjA==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr2274629lja.44.1543528757978;
        Thu, 29 Nov 2018 13:59:17 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:17 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 05/14] checkout: move 'confict_style' and 'dwim_..' to checkout_opts
Date:   Thu, 29 Nov 2018 22:58:40 +0100
Message-Id: <20181129215850.7278-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
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
 builtin/checkout.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1b19328d0a..2423fdbf94 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,8 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int dwim_new_local_branch;
+
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -55,6 +57,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+	char *conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -1239,8 +1242,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts real_opts;
 	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
-	char *conflict_style = NULL;
-	int dwim_new_local_branch = 1;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
@@ -1265,12 +1266,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
+		OPT_HIDDEN_BOOL(0, "guess", &opts->dwim_new_local_branch,
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
@@ -1286,6 +1287,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
+	opts->dwim_new_local_branch = 1;
 
 	git_config(git_checkout_config, opts);
 
@@ -1301,9 +1303,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			opts->show_progress = isatty(2);
 	}
 
-	if (conflict_style) {
+	if (opts->conflict_style) {
 		opts->merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
 
 	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
@@ -1350,7 +1352,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
-			dwim_new_local_branch &&
+			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-- 
2.20.0.rc1.380.g3eb999425c.dirty

