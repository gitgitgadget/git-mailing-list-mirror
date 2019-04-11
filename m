Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C6620248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDKNNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44337 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfDKNNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so3492809pgj.11
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHX8XhUZeIWFmEQSnrgknaT9Z/F3YF4e356NkkghEKE=;
        b=ShlZ9NrPf9XXpkeEk5FW4JUsBbqw2K3lDOTSGO/QUO51Pe0X3HOqSCFkAn2DUX/G5M
         y5BiweXoEUDrf2RIrUHoEHKFEaGt0QnR5BomPnaU9SoP69EnkQOvxKF74SFR8cjp7XJO
         +tDAND/Id/H2kBQhth3rgXrS25kAq6nFZRcAVGo1FUPQie6E6u7yDHLF/35pLrwbxVbX
         RYCaNPjatL1bRcOmls768je97fkdUntdJ3XYdOyvEJExQ3PQSzURT4wliJrJtQ7PIZ4c
         NznelFX1l2OUFpvdQv6NUlkXhJjbm2pU8ZiHkZKM0aj1ZnmERO70g7IGzBFXGvUsu1Wt
         /kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHX8XhUZeIWFmEQSnrgknaT9Z/F3YF4e356NkkghEKE=;
        b=AjXjy6sUpDg9RwNZpuvsrNnAFiYLt8JVZJwRA7ogUdZ6VVSNjopsf9cSR95fiW9cwE
         wPYoahNR+fTCYmle82T6el8d9roUiI8sNgkUFUSSjApqnEoK6gHaczl/L9+MkmXvRDkU
         WmSkp37iww6T76C7M0JrOKsWJwQ7X6fv0CmBWXAtDp/VuulUHnEAgjMs5rEO7UXYKcSF
         HtS4V+ndAxy8723+f+ko1F9dcD6Q8OeN4UL/EKyJlewmmUhQZvy61/+TO28yPMCFEhe5
         aw5dujNlDzHxMufZuCFvKuwkDUBSu3JgbwSOQLQHdOKUmNKxVN+1pyXk18STKb30B1ME
         Aisg==
X-Gm-Message-State: APjAAAUE4vjwsU/0SPB9eSvMEoZrViTVvOkP9abIprcgtD6aThL1w0Qz
        NmVdvE3yG2bf5f4FDxNoGQY=
X-Google-Smtp-Source: APXvYqw3dRRwmOmNvWN9QASvphWIkp9lvdXrbJeQeSkQ7z4i5qE9JWqrbcwAOgGkU9e+m6WdyN8Ehg==
X-Received: by 2002:a05:6a00:c1:: with SMTP id e1mr43538639pfj.143.1554988379910;
        Thu, 11 Apr 2019 06:12:59 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id k65sm84836770pfb.68.2019.04.11.06.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:12:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:12:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 04/16] restore: disable overlay mode by default
Date:   Thu, 11 Apr 2019 20:12:06 +0700
Message-Id: <20190411131218.19195-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

