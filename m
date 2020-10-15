Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19B1C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C81522243
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPNEfQ6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgJOJ0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgJOJ0X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 05:26:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4BAC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 02:26:22 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d3so2753702wma.4
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RcrUlzDOfx8Lrr9nrpcEkNWoHG2uZEK5NsQMzdw0vm0=;
        b=TPNEfQ6W92drGpN8POA0Y67VLAm8HxiBsURVcpCWxwRcbxgl9WbzYb+VfB23BVibrs
         qTycdIgpYm+feIp8BlOAEKwS48sQ/PITo8r13OmxlWbp0gZluYSyAwZIbbLcJh/rbPMz
         1LQo9m7kEPCQQVdz2ucLgsO5RIySqwE6xAMvp2USFiQva9gqsQwLoF5vJYwi8e1Rub1E
         +WFQBGaxVsoCPynqYF2UG/RlP0OTrrzr8r5K7iVFocZPfxUwC8Q01qdHxFzENXc6fZc0
         RhF7v/eriH3imdFz23p+TX5HjJgzG1jq2fJlfHw7WTfJC6J/53FJGdS5e8laHqTtRduw
         mAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RcrUlzDOfx8Lrr9nrpcEkNWoHG2uZEK5NsQMzdw0vm0=;
        b=ZZeWEeD+3/8K1VCwiXS39KEOnc96k8pRWgNQkL3quTgI0n6CAViV9UZyQQvJWHM3od
         XAN3UAhX/TyBNzdH82gQ58lm9ltEAQDdnXlSzdo4HQJaBPcVrq+FAmXMOYgMj5yWuRCp
         gt59PvuZjcEWGZ0B5V5tfJMqAQ76UtuoOniYAOFPdxWoUxT/UIY4i7sO6HYJ48Vwy2nM
         hrbua+Zt0uvlBpOXWoDRsLnRKEc2P6u+uycKUpN0vrdMUvydLYvAYxaZY4VHSA/YJn8/
         lPmKzMQmklCUqVnW2Lb/AVw54e8K/ZGIqUPi3VNy2j8Zt+yonoZx2/7dJncG2fc9SNvs
         GnEg==
X-Gm-Message-State: AOAM532fcnj1uxkYvtRK5a3bgZX7zNN3JP7Ga8kQwXyNKCorAR+icoQJ
        NzMAZeTp9Jq0vLU3ifeECDtlhh+YOLE=
X-Google-Smtp-Source: ABdhPJwh7et8xjSoDoYtN5AUzAxN6dO+hZr35+Zd9zIe05NYrpOz9/8bPtHON1ZGfarmSbcjcSq/Ag==
X-Received: by 2002:a1c:e2d5:: with SMTP id z204mr2965421wmg.96.1602753980898;
        Thu, 15 Oct 2020 02:26:20 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id u8sm3465864wrn.62.2020.10.15.02.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 02:26:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: [PATCH] fixup! diff: do not show submodule with untracked files as
 "-dirty"
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Sangeeta NB <sangunb09@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        phillip.wood@dunelm.org.uk, kaartic.sivaraam@gmail.com
Cc:     git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com>
 <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
Message-ID: <2d51c999-61cc-d490-46c9-0fac19aff066@gmail.com>
Date:   Thu, 15 Oct 2020 10:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify checking if we've already set the flags for ignoring submodules
---
 builtin/checkout.c |  1 -
 diff.c             | 12 +++++-------
 diff.h             |  7 +------
 submodule.c        |  5 ++---
 wt-status.c        |  3 ---
 5 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 428201380e..0951f8fee5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1095,7 +1095,6 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.ignoresubmodules")) {
 		struct checkout_opts *opts = cb;
-		diff_ignore_submodule_config =1;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
diff --git a/diff.c b/diff.c
index 6c9d28d363..93bbb57f88 100644
--- a/diff.c
+++ b/diff.c
@@ -51,7 +51,6 @@ static int diff_no_prefix;
 static int diff_relative;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
-int diff_ignore_submodule_config = 0;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
 static unsigned ws_error_highlight_default = WSEH_NEW;
@@ -403,10 +402,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.orderfile"))
 		return git_config_pathname(&diff_order_file_cfg, var, value);
 
-	if (!strcmp(var, "diff.ignoresubmodules")) {
-		diff_ignore_submodule_config =1;
+	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
-	}
 
 	if (!strcmp(var, "diff.submodule")) {
 		if (parse_submodule_params(&default_diff_options, value))
@@ -4598,8 +4595,10 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
-	if(!diff_ignore_submodule_config)
-		handle_ignore_submodules_arg(options, "untracked");
+
+	if(!options->flags.ignore_submodule_set)
+		options->flags.ignore_untracked_in_submodules = 1;
+
 	prep_parse_options(options);
 }
 
@@ -5142,7 +5141,6 @@ static int diff_opt_ignore_submodules(const struct option *opt,
 	if (!arg)
 		arg = "all";
 	options->flags.override_submodule_config = 1;
-	diff_ignore_submodule_config =1;
 	handle_ignore_submodules_arg(options, arg);
 	return 0;
 }
diff --git a/diff.h b/diff.h
index 9bfce084d8..2f5612ff7d 100644
--- a/diff.h
+++ b/diff.h
@@ -180,6 +180,7 @@ struct diff_flags {
 	unsigned ignore_untracked_in_submodules;
 	unsigned ignore_dirty_submodules;
 	unsigned override_submodule_config;
+	unsigned ignore_submodule_set;
 	unsigned dirstat_by_line;
 	unsigned funccontext;
 	unsigned default_follow_renames;
@@ -556,12 +557,6 @@ int diff_queue_is_empty(void);
 void diff_flush(struct diff_options*);
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 
-/* 
- * This is for keeping a track whether ignoreSubmodules
- * is  present in user defined config or not.
- */
-extern int diff_ignore_submodule_config;
-
 /* diff-raw status letters */
 #define DIFF_STATUS_ADDED		'A'
 #define DIFF_STATUS_COPIED		'C'
diff --git a/submodule.c b/submodule.c
index a526c96ce2..8f6227c993 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,10 +198,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 			ignore = submodule->ignore;
 		free(key);
 
-		if (ignore){
-			diff_ignore_submodule_config =1;
+		if (ignore)
 			handle_ignore_submodules_arg(diffopt, ignore);
-		}
 		else if (is_gitmodules_unmerged(the_repository->index))
 			diffopt->flags.ignore_submodules = 1;
 	}
@@ -422,6 +420,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
+	diffopt->flags.ignore_submodule_set = 1;
 	diffopt->flags.ignore_submodules = 0;
 	diffopt->flags.ignore_untracked_in_submodules = 0;
 	diffopt->flags.ignore_dirty_submodules = 0;
diff --git a/wt-status.c b/wt-status.c
index 791af9321a..7074bbdd53 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -605,7 +605,6 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 		rev.diffopt.flags.ignore_untracked_in_submodules = 1;
 	if (s->ignore_submodule_arg) {
 		rev.diffopt.flags.override_submodule_config = 1;
-		diff_ignore_submodule_config =1;
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	}
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
@@ -630,7 +629,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 	if (s->ignore_submodule_arg) {
-		diff_ignore_submodule_config =1;
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	} else {
 		/*
@@ -641,7 +639,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 		 * shown any submodules she manually added (and which are
 		 * staged to be committed), which would be really confusing.
 		 */
-		diff_ignore_submodule_config =1;
 		handle_ignore_submodules_arg(&rev.diffopt, "dirty");
 	}
 
-- 
2.25.1.551.gd3318bf0d3.dirty

