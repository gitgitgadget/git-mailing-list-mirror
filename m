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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE76C4321A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B247964FCC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCKCMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhCKCLs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:48 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D20C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:48 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id r32so7280734qtd.16
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P0a9kFDCbvmkpbEruyPjdiAtGPBAH5p8rlp9ObW9PVM=;
        b=uyS57M2JB5CB/sTVCded4xP6+HmQWBeIzyUdTgf7Dxd6co6A4p4pHKN/K9crrmmJvF
         bv8FcynbeoiidaLoCmU5u21W/3r15Q6o2LXRS/xARGIiMrxNllZ4t0a7GB1aeehVpAOF
         LTCiFwCaTMmboKNGn0W9oWqrtGQpnd4QhC/JApInsxSMv5wxdrIlcTh7u4jrUDQ4T3bp
         aZka+TkCUCGw34/25J+QXfrnz5FNCPk4lTIUTZ4KrBLgLRo2VVC+Q0ycm8gEsZ+3uIjY
         vMdXRbxiVsIrBRTA2Gtjnrr/OrhJ8C+F7GMLeaqE/+lnCZSsdrt8TEbA48e0CAdYh8Uh
         4Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P0a9kFDCbvmkpbEruyPjdiAtGPBAH5p8rlp9ObW9PVM=;
        b=fe2M7N6gnZlypQbcP1Ru+IbHYAMF27Ht+zJ2RmyYTPEIrN3AClFGwm2ArYO+gnguMO
         g3V2b+ptDzCWl/tGCjKwiSfSUdP8KXTJ5YAJ+zSUktMZa5LB3cgTjYu9dhcV3K1B4q2g
         ZP3E1dO3mtAN+YIDxv8B8txke9glAm6xpUTdi57E2BAY7+5AYw5PTJQ4LsnRMnipM9Nx
         NEHT6NgYUoE1iUHZLNQNSxJ34/S/sZekjlluNiTPF6g1Xcq2Sp0qxzGJH/Mcb0PkrYTc
         PObXPiWUtdC+wIzGBfJ7EaoiFXknz3RAOsg00qVG4JtMbd+aOpBoFjntUQl44ZBoJG25
         kngA==
X-Gm-Message-State: AOAM530MfMgqvHxK0e1me2A/OCT84XFVxYNG1E7Kt4jbedFH/vpiLZl6
        9Hg7P+Xx03rmWaRA6/FfUVib/KgoEx5APaL7lRsfCm9mq1FO/4b/1r4q1iwSZmgZ6LQ4+511tl7
        pL7SWj/BaTkYaFTVsEXTI/kDk4xMdQvDM6xOO646+fNfeYqIG8gt1w+Uhou/04HIcjDwyUBxLeg
        ==
X-Google-Smtp-Source: ABdhPJwRiewWchP5Y0an98SMemhLWTH1uQcD8QEU/cSnjPQVUI3lIWNPAtsynHDs0FU76o+Jy6N6xwQgy609YLWaEtg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:f6d:: with SMTP id
 iy13mr5995788qvb.24.1615428707877; Wed, 10 Mar 2021 18:11:47 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:32 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-33-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 32/37] post-update: use hook.h library
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using run_hooks() instead of run_hook_le(), 'post-update' hooks can
be specified in the config as well as the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  3 +++
 builtin/receive-pack.c     | 27 ++++++++-------------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index c16353be2d..fe5381b95b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -508,6 +508,9 @@ Both standard output and standard error output are forwarded to
 `git send-pack` on the other end, so you can simply `echo` messages
 for the user.
 
+Hooks run during 'post-update' will be run in parallel, unless hook.jobs is
+configured to 1.
+
 reference-transaction
 ~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e448956a32..955efbdf6d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1688,33 +1688,22 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
-
-	hook = find_hook("post-update");
-	if (!hook)
-		return;
+	struct run_hooks_opt opt;
+	run_hooks_opt_init_async(&opt);
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		if (!proc.args.nr)
-			strvec_push(&proc.args, hook);
-		strvec_push(&proc.args, cmd->ref_name);
+		strvec_push(&opt.args, cmd->ref_name);
 	}
-	if (!proc.args.nr)
+	if (!opt.args.nr)
 		return;
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "post-update";
+	if (use_sideband)
+		opt.consume_sideband = hook_output_to_sideband;
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
-	}
+	run_hooks("post-update", &opt);
+	run_hooks_opt_clear(&opt);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.31.0.rc2.261.g7f71774620-goog

