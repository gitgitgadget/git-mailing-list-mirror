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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856FCC636CA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CFE613E0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhGOX31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhGOX3J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E303C061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o11-20020a056902110bb029055b266be219so9924892ybu.13
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eLhroixyFQJHnlO3hoUj+h+SpT11PKTG3X29biHUDPM=;
        b=eH/zCKxan4GH7iKS7xcbL5HKNZBPfbit0wwJJ/GCtg0xV52Kx4Dx/KOEEN8KU85bet
         VL+///k9yv3qahBRg39OYJzs/aM5FJm0ErFvdu/7ebWCaIRYxxFA+byrM7w9LaPWRwsh
         a/A7OVnqifOS5aWVr0CAV+G85PFY2AYUcqONeTLdznbCeiri+ykXsoXPbF0p+3iCsaW4
         PY4lcvUNRMg8rhsVUravCOAA8yBx+wTX6OJ6MrHg3pjFNpwXsdPHs0D/3qkwnLzqdsqK
         faJZkJB2hls1csqsqh/LUehoYEidTBU0SnT9y+r6Nv+yWVXZOql7XL/8q0AuYUMYW1eX
         AAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eLhroixyFQJHnlO3hoUj+h+SpT11PKTG3X29biHUDPM=;
        b=SwQWcfGjj3VAFMXRPE0angXaI9V2C9wZFGsOLsGNinEYX+iH2coEpuh531yG+lNpuA
         5pYDB9IAF7/6eI8/AF5Pow/IgEUh792B7GVzZpqNphVxNLFrcjApL3iuSjPlAJTl6EMR
         4wWk8cH0WItLbwz7fhq2wjg4Bea0PB2L9RwCUlQcY7ABouhuN2KnGbuiczL0qCH5ls0q
         0glctAYtJGSQXF40qUcgtWNdl8gJe1CVRxIDa5hl4Yaxg5lac7CaEMMm+wlkptit8doX
         k91JixHrD4tA//U4+V2xVj6ONUmHr8JJDOIja+/L6HgVPUXYXm7K4HMaRJEGyhZolLti
         R1hw==
X-Gm-Message-State: AOAM531WFtfGhZAlCJHtTUvWBUQGWrYP0A4P3kocXLnklqt3n0y0J7p8
        ZT+NWo7wsCOzO8L/nJKbZGsx9OMWhXnhcCYDL94b3xldFV/dW6F9ZY9R6f63HZjz5q0VYqd3wvv
        N5ScHEjn/W5e+DyJfBw0YscxydToY8PpGAdFrPgKKyMWcOGfvho3bQg1mioBx5QJCHTkyw6fNGA
        ==
X-Google-Smtp-Source: ABdhPJyDIi3sZO2VzKXkmbKPlMzO42iWbZ6CrPORfRxWURvS7W3n8/FZjvXOegVQw6t20v4B5pb2ms9/rrMnq6qc32s=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:aa09:: with SMTP id
 s9mr8876927ybi.165.1626391574574; Thu, 15 Jul 2021 16:26:14 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:25:57 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 3/9] hook: introduce "git hook list"
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
 builtin/hook.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 hook.c         | 18 ++++++++----------
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index d196d8498c..8340c8c9a8 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,6 +8,7 @@
 
 static const char * const builtin_hook_usage[] = {
 	N_("git hook <command> [...]"),
+	N_("git hook list <hookname>"),
 	N_("git hook run [<args>] <hook-name> [-- <hook-args>]"),
 	NULL
 };
@@ -18,6 +19,46 @@ static const char * const builtin_hook_run_usage[] = {
 	NULL
 };
 
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
+			     builtin_hook_usage, 0);
+
+	if (argc < 1) {
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_usage, list_options);
+	}
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
@@ -88,6 +129,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		usage_with_options(builtin_hook_usage, builtin_hook_options);
 
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
 	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
 	else
diff --git a/hook.c b/hook.c
index 935751fa6c..19138a8290 100644
--- a/hook.c
+++ b/hook.c
@@ -104,22 +104,20 @@ int hook_exists(const char *name)
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
2.32.0.402.g57bb445576-goog

