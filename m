Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D7C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD926613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhE0AMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhE0ALr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2C7C06138D
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so3684578ybp.0
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zWVIvcSXtcuQD0eNgBPbl/bnb52CcZ1/tXzriKUku1c=;
        b=YjFZepef4Z0F3pL/Tzx/VHtZI4kWtRMijl7LdHKUg+Xi+NBwE9ToO3z17TRF/luw1d
         z5J8GrFPdohanVPt6L3bmIQeNkMOCKyYtoCnKs+utIQcBJwlcwJdu58/4jObb0IH/2nk
         wOEot143Bnk4BHpZhfVZpMES458o3H5I+06eZs9eBiO99rEhuWT3XuXrQg39tvBKqyte
         /Gmi9y5uu+8+ailfPTBIuqUO4dFBRw1cY1j+x36N3WgOXDi28EAcGVbIFjh/sPcBU4pr
         fjZIZ49yZX+xg4g7AFt96w19DC/EI7MJBlCvb7k0UZxV5luFBHiMQFGGlTYee+z4ndpS
         hRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zWVIvcSXtcuQD0eNgBPbl/bnb52CcZ1/tXzriKUku1c=;
        b=UXsnVwiEBUqUKGw3aI/1l+5tOvbe4FxM/ZBZgigjpIgmYA3hoN+dv5ye7MzCHi/HF9
         tKfO/Uo1XHTs9WFp5BoWDvCG6LjalmmA34RwgCz7ypFrQDiC69XSEKCxA1gw3YyzDUW4
         NF9e3jSz/gugQYRcKyR21ZwL2YE+BoogdlBpiea+P6zyIsTPe2sOwgyKWYx8eXltaWyJ
         zNru3rC/SdeR6+vZ6J59TT4atzorzWRHTR8N/liKbbL0JQ6Um+/wZzPeZkWL77D8VOLB
         6+Cyodi7w+04n74AG+CinxopGCx2Kq8OAdWJ7REcwZqz+yM6wR2wEwIQR2WFVOxSfVWZ
         ynVg==
X-Gm-Message-State: AOAM533oz9Ho7YFIydJcF5JfSs8pQSXzWlpAQvQjhjAaGofE44KXWZuz
        Fh2jyaLame4nAOKkfPl8VgUszsW4Guo2Pqune6HgGOnK57/lKgEm+zV/suCdS/bG2rVirGged6E
        Q9ZuODhaLIo6t5GvHf3NuX7Uv//bKv6xRV1R6G5mYfF+M8ah3me35rE3ynu9/Uwm2wqhHb8k7JA
        ==
X-Google-Smtp-Source: ABdhPJzkxaLu0AJpZWFFTC6fsdwn/+fDmVhQNFWSfPhtvV+Aq0NOtO8lCwiHXd0YO1dn9PX7me/LSYVN8BUaLCrRvz4=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:bb85:: with SMTP id
 y5mr926680ybg.391.1622074200823; Wed, 26 May 2021 17:10:00 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:50 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-32-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 31/37] post-update: use hook.h library
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
 builtin/receive-pack.c     | 26 ++++++++------------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b6b13afb36..281970f910 100644
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
index 5ecc97d8ab..4236c0b268 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1688,33 +1688,23 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
+	struct run_hooks_opt opt;
 
-	hook = find_hook("post-update");
-	if (!hook)
-		return;
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
2.31.1.818.g46aad6cb9e-goog

