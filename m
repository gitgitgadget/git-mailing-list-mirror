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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCA0C432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9E86044F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhHSDfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbhHSDfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:37 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA34C06179A
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:01 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6-20020ad448660000b02903500bf28866so3624337qvy.23
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nGUuP5ePDBgJW4EyGrxuJF6GJyeiI/jzzY2/gZmO2XY=;
        b=kgfnShVtu9qJh1cCXnTWOhuNh3xIslyMDtP9rzs4O+EKjdMaSsFjk/AE7eWHUoJaCS
         zLqNKYEDxq5dmCC9j8mX/4q/XJQkmlCyYHazrYkrnwBqYEnJMf73ft+idkE/YKafg32D
         YHan3m6zZYFM+yGgtXEcmcjqswrM8XkaCt42jdjWtWzUW1JFRXcHFLypHO3J3piVpDsw
         Tb48w5UY9rxGUQNa9P2V1NwpzfPXUninp1eK4E21bFNu+4qg9qdsXZcKzJ/gvNDPp9dj
         PHmw8/K/MFCjHGiYYZ+QS4uIwiBPEHymfkQk4KBIzTUfWFNAZdoSQmNzcAD2fekGYjHL
         xScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nGUuP5ePDBgJW4EyGrxuJF6GJyeiI/jzzY2/gZmO2XY=;
        b=ajuNhhF6YMawTBOdqwX0lVEEpn5gu3QbfgAzseTs/31UTs5/S4hkIV0Bew/uoxVSbW
         0Wr59lV8Ld1cbFanI7AHNhGLlPgVIMu3M/hqFQOm2fayPJJC1Ylk92m5q0fZMYdTClFu
         DmrZJf5GTzltm/14RsaYz2fXYWltep8pzGxmYNL0qK/5C0QHzSPGGYyvFBEofYNM76tg
         UIPEHD9bUHrCYFWa5Q6lV5cIohOSx3K365iAHVRAZhm3VFWUdUBjx+jqVrkG7db9MK8h
         erhvkcdAJu5jBf1yTh7wcEIENSyGHkxPRFu67zP5qtiyrLi71khpQ0L0mhpmI3T1PrI3
         7//A==
X-Gm-Message-State: AOAM5325CQhg7BtOZRdlztS47D9TUANI6W+pZr952r1hQ/S/p0n3vB+9
        N1A7gL2o1iV25lxO00UhrchhM5zojAltskUtoeUkV7cgsT3AP1Oef9lU+HMHM/q5Z2ezt5uGEdU
        wmsajwRdwE272A1jCSz8PDeWW2jNEaDNzKvAwl2TRSaxtG7Y6Kw6tgW5NdRgAw1eWpiDYJfXbpg
        ==
X-Google-Smtp-Source: ABdhPJwct/bvXRcjrSJ0WLLW4UiRIaUwO6w7iqEQRbOeT7dPE3pbcWSgKrTlUrHkDJAdq8I1/rNBPMtaBvTdnTgAsyg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:3b1:: with SMTP id
 m17mr12679002qvy.60.1629344100919; Wed, 18 Aug 2021 20:35:00 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:47 -0700
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 3/6] hook: introduce "git hook list"
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
 Documentation/git-hook.txt |  5 +++++
 builtin/hook.c             | 46 ++++++++++++++++++++++++++++++++++++++
 hook.c                     |  3 +--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 8bf82b5dd4..701ada9fc0 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git hook' run [--to-stdin=<path>] [--ignore-missing] [(-j|--jobs) <n>]
 	<hook-name> [-- <hook-args>]
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
@@ -30,6 +31,10 @@ optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
 arguments (if any) differ by hook name, see linkgit:githooks[5] for
 what those are.
 
+list::
+	Print a list of hooks which will be run on `<hook-name>` event. If no
+	hooks are configured for that event, print nothing and return 1.
+
 OPTIONS
 -------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 4dd3617876..d21f303eca 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,8 +8,11 @@
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+#define BUILTIN_HOOK_LIST_USAGE \
+	N_("git hook list <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
+	BUILTIN_HOOK_LIST_USAGE,
 	BUILTIN_HOOK_RUN_USAGE,
 	NULL
 };
@@ -19,6 +22,47 @@ static const char * const builtin_hook_run_usage[] = {
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
+	if (list_empty(head))
+		return 1;
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
@@ -88,6 +132,8 @@ int cmd_hook(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		goto usage;
 
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
 	if (!strcmp(argv[0], "run"))
 		return run(argc, argv, prefix);
 
diff --git a/hook.c b/hook.c
index b8420353fa..b1ea372e15 100644
--- a/hook.c
+++ b/hook.c
@@ -96,6 +96,7 @@ struct list_head *list_hooks(const char *hookname)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
 
+
 	INIT_LIST_HEAD(hook_head);
 
 	if (!hookname)
@@ -103,8 +104,6 @@ struct list_head *list_hooks(const char *hookname)
 
 	if (have_git_dir()) {
 		const char *hook_path = find_hook(hookname);
-
-		/* Add the hook from the hookdir */
 		if (hook_path) {
 			struct hook *to_add = xmalloc(sizeof(*to_add));
 			to_add->hook_path = hook_path;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

