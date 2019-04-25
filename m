Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EA61F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfDYJq3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44644 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id y12so8248917plk.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3X0B7Jnk+vha5qO1WYsOT3DDham5UbLoEzmVqe4Tuog=;
        b=neCzFvuBWdtkegvjvBZgTtlpm8bKuSudblm9doOj/Ux7ZELL8pghP0ZbDbgDibi+MG
         RKE4DoSPjJYB7zwTt+ujpbHr3b/u2+IhkFFZ0LC0Hfkxr5ZAZ1SgxIE9Lv+kZssTu7hn
         //3fr7UaZF2A5jf/2Cl+OpIYSLlCSjIXWCC79YBoFq0JTr6/DihFRjsHp1Qsm4dtwTmi
         msF88uFTqw+dtK79pag5Fn7bvPgLs0+l2MzXeGNva0Qfp2yWAGrCHe6fs/Q1SNk7ZZzb
         QZhKzKGWhcm+5Wnsft8IRtq3fwYOKoY0V0lHPRqFXYofzw/X7EXcnnsvnVHt8aCKI923
         dT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3X0B7Jnk+vha5qO1WYsOT3DDham5UbLoEzmVqe4Tuog=;
        b=QeSWiatbF7GYPy4q67+IbL5DGsXuseDRENz2kpNS33eqbYkF+k5wwKIGaGYy2T+W/Z
         9tZhCh6Hhkw+t3k1xR6kH+QySf7fL6D7P/g9yAnbtYZIfGMz77LPRDLdrzpSnHam3OIl
         Fvrz/ZaoHHapV+nM8LfRTiCBha39eINEJVOdIUzjbtHL0pbrf22p4HTrmmRfmhDCgph7
         /MWs0aJuDG6odWUhoqlTDIVFfqmFnOF/ZvUqkkrri0FwiV94eDjaG/P8nh3ZERdliIIy
         L8KFSVHAj2VuI9n7DWS1rcYZrrQP1Fcck8/rM8gZoF5NxKaC9VyAHNX193Q80Avdq46n
         dVfA==
X-Gm-Message-State: APjAAAWHWPAUZWwsbVn8M+zpWXC0hMO0l1+rOEVkh9UwJpAllx5brbFo
        3ZvJi8xXH6w7bqV9742EFSo=
X-Google-Smtp-Source: APXvYqyfy3JC3enbVa0iwKZZVPDfYQggPITaakik4fpnV44xFcBulFroquTDeU6qJu3dyT9XIcY58g==
X-Received: by 2002:a17:902:54c:: with SMTP id 70mr38597192plf.210.1556185588676;
        Thu, 25 Apr 2019 02:46:28 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id y8sm27700716pgk.20.2019.04.25.02.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 04/16] restore: disable overlay mode by default
Date:   Thu, 25 Apr 2019 16:45:48 +0700
Message-Id: <20190425094600.15673-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overlay mode is considered confusing when the command is about
restoring files on worktree. Disable it by default. The user can still
turn it on, or use 'git checkout' which still has overlay mode on by
default.

While at it, make the check in checkout_branch() stricter. Neither
--overlay or --no-overlay should be accepted in branch switching mode.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 77db5236f0..9c5abe170e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1274,9 +1274,9 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("'%s' cannot be used with switching branches"),
 		    "--patch");
 
-	if (!opts->overlay_mode)
+	if (opts->overlay_mode != -1)
 		die(_("'%s' cannot be used with switching branches"),
-		    "--no-overlay");
+		    "--[no]-overlay");
 
 	if (opts->writeout_stage)
 		die(_("'%s' cannot be used with switching branches"),
@@ -1399,7 +1399,6 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_BOOL(0, "overlay", &opts->overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
@@ -1419,7 +1418,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
-	opts->overlay_mode = -1;
 
 	git_config(git_checkout_config, opts);
 
@@ -1593,6 +1591,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
 		OPT_END()
 	};
 	int ret;
@@ -1607,6 +1606,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.can_switch_when_in_progress = 1;
 	opts.orphan_from_empty_tree = 0;
 	opts.empty_pathspec_ok = 1;
+	opts.overlay_mode = -1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1645,6 +1645,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.implicit_detach = 0;
 	opts.can_switch_when_in_progress = 0;
 	opts.orphan_from_empty_tree = 1;
+	opts.overlay_mode = -1;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
@@ -1663,6 +1664,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	struct option restore_options[] = {
 		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
 			   N_("where the checkout from")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
 		OPT_END()
 	};
 	int ret;
@@ -1671,6 +1673,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	opts.accept_ref = 0;
 	opts.accept_pathspec = 1;
 	opts.empty_pathspec_ok = 0;
+	opts.overlay_mode = 0;
 
 	options = parse_options_dup(restore_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.854.ge34a79f761

