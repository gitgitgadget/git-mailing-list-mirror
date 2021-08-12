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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B25C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3896B60FC3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhHLAnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 20:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhHLAnn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 20:43:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3197C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a62-20020a254d410000b0290592f360b0ccso4428774ybb.14
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1zwxAfztIy14JhjmSWzdl9jruSn/79HMVHXTDHt2S34=;
        b=B5g4c54d67rbkRimssqFdmu136+2n0PGryvLJYlM9u48UjtKTTxuxFRDKAahzo2JRk
         /E/JOr+3YXNzR3xQIDwgO+6a/yY4NHrZhZeKYRjDUDuR6z6P3b3PD/wUVq5gUJJaFI9b
         4+LvECYeWWRsxqsX+QUNHzVhnLYgK9Pofu2hLZ2cmKBguW6RqIsLfGdZQdBfGXEtXyAO
         gSfGyloqxD3gb2hRx3NeXZx2+hrGrjfdeiTtSI4g3PTnKZ0UMQhqst9gEEHoRmBBEmaR
         BPv4+tgEZ6Bi0hs+tgDRSkBxCVlI1JEr4Pv4P6Zzm2uxNA/lljT7/tJBiTAlzGmTdlJA
         bK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1zwxAfztIy14JhjmSWzdl9jruSn/79HMVHXTDHt2S34=;
        b=OEc5xV01bPy2B8I0iP0CXVYvwv5pb+5jM8Zd47tNLuIXrO5HzGCA2+C0agg7Bgg6W2
         f0rvDNhLFTVvbi4X+8qhuZBUnHnOc3hGmZ0H6BPNOKHASw4QxwghkOHlmaDtZTQlIjcM
         NlGfwNhc7EHRhv4JcY5CaGHVtIrkR7rxK29tWTm/P5EDJjjnVMxnCbXl7aO0NajCeBxi
         8n9ip5+btVsNUd0rAHiAyEcwxMYDhkMiWAl6wOCS84IoBExWbx3GEkTxHL1CprpCD3uY
         b5soLQ6ejDqgSiFTb+0+fRMoKIAa7ubcdhBpEzf4H0/44IfB5jL6elFhArFP+4ugi9q0
         V11g==
X-Gm-Message-State: AOAM530gQ55spcLiVt69iehdMUA7hJqeyuGjLom/1EMEDVXC62clEctw
        ioQkN8WYEkmDE+9JylStWp8pJvVLo3zkW4iY/+7/Cvk43g4eQvbnMgGzUgXguAvAgSRTTjQo2LI
        nBhs3hYAUTVXUv5FgwyKj7sdTMMd9JbxDuK7APBRLjjKLUhkqe9d/s7k2psHX67o/oUHpSjWyUQ
        ==
X-Google-Smtp-Source: ABdhPJz3nMMaxNuU3sFJC/Mxjm/UuzostAEuRWMvpw2IMVebN1hLE9PjY0F5mqX1Rf+rPWkcmDC0JhM3qmBk2HLjTpg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ba93:: with SMTP id
 s19mr998928ybg.265.1628728998056; Wed, 11 Aug 2021 17:43:18 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:42:55 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com>
Message-Id: <20210812004258.74318-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210812004258.74318-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 3/6] hook: introduce "git hook list"
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If more than one hook will be run, it may be useful to see a list of
which hooks should be run. At very least, it will be useful for us to
test the semantics of multihooks ourselves.

For now, only list the hooks which will run in the order they will run
in; later, it might be useful to include more information like where the
hooks were configured and whether or not they will run.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/hook.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hook.c         | 18 ++++++++----------
 2 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 12c9126032..c36b05376c 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,8 +8,11 @@
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+#define BUILTIN_HOOK_LIST_USAGE \
+	N_("git hook list <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
+	BUILTIN_HOOK_LIST_USAGE,
 	BUILTIN_HOOK_RUN_USAGE,
 	NULL
 };
@@ -19,6 +22,50 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
+static const char *const builtin_hook_list_usage[] = {
+	BUILTIN_HOOK_LIST_USAGE,
+	NULL
+};
+
+static int list(int argc, const char **argv, const char *prefix)
+{
+	struct list_head *head, *pos;
+	const char *hookname = NULL;
+	struct strbuf hookdir_annotation = STRBUF_INIT;
+
+	struct option list_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, list_options,
+			     builtin_hook_list_usage, 0);
+
+	if (argc < 1)
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_list_usage, list_options);
+
+	hookname = argv[0];
+
+	head = hook_list(hookname);
+
+	if (list_empty(head)) {
+		printf(_("no commands configured for hook '%s'\n"),
+		       hookname);
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		struct hook *item = list_entry(pos, struct hook, list);
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s\n", item->hook_path);
+	}
+
+	clear_hook_list(head);
+	strbuf_release(&hookdir_annotation);
+
+	return 0;
+}
 static int run(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -88,6 +135,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		goto usage;
 
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
 	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
 
diff --git a/hook.c b/hook.c
index 37f682c6d8..2714b63473 100644
--- a/hook.c
+++ b/hook.c
@@ -96,22 +96,20 @@ int hook_exists(const char *name)
 struct list_head* hook_list(const char* hookname)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+	const char *hook_path = find_hook(hookname);
+
 
 	INIT_LIST_HEAD(hook_head);
 
 	if (!hookname)
 		return NULL;
 
-	if (have_git_dir()) {
-		const char *hook_path = find_hook(hookname);
-
-		/* Add the hook from the hookdir */
-		if (hook_path) {
-			struct hook *to_add = xmalloc(sizeof(*to_add));
-			to_add->hook_path = hook_path;
-			to_add->feed_pipe_cb_data = NULL;
-			list_add_tail(&to_add->list, hook_head);
-		}
+	/* Add the hook from the hookdir */
+	if (hook_path) {
+		struct hook *to_add = xmalloc(sizeof(*to_add));
+		to_add->hook_path = hook_path;
+		to_add->feed_pipe_cb_data = NULL;
+		list_add_tail(&to_add->list, hook_head);
 	}
 
 	return hook_head;
-- 
2.32.0.605.g8dce9f2422-goog

