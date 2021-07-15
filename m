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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7BC636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3677461289
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhGOX3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGOX3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E930C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s186-20020a252cc30000b029055bc7fcfebdso9928366ybs.12
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ofVpg7HsIJ3YuHNGTcSLM4Cpps2nJlQ7kSOcQt5A0M=;
        b=p2ewL5PuDbWQhYZSHe31i8rNmyR0wIiZqlsoBuOOQt/35eDYOiatiCNa7pLHe/C2Nn
         ECT+NE/pVZ96bndbMrk4e/J0aJpR1FTAV1n/i9PLIg+XrYhOIy6gNI0ZU7ZDe2Y9QQVH
         o6ve54weLLT5B3H/ivttIpV6HOw0BGFL/7NEhw6aqGyCrWawszQoqmQLnLjhapRKi6ZS
         f3FnEgl4eowvTvUc2tSIb7UsRWxHdgNPe/JLprJE254ds3GgVUF6t1dRlWVLIBJG1fgu
         ubbpCY2YIjU5ahUAW+Ijmtuq2b5mdQkumEIEYAx/3b0xSPbBf4B249/3E+hZ9zaD0UHe
         okUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ofVpg7HsIJ3YuHNGTcSLM4Cpps2nJlQ7kSOcQt5A0M=;
        b=Y9F0b/aHvq5Kgc82h4LrX7rBqe5LWVMBAT1/FIj647ddxC5ROW038HpjnJYNU9I6tC
         0sg8cbB3AhnIGKXftaXyasaoZLirPtH+FbTqA7ve7PKQ7nXaPaq/HXjPQ55sB4BPN2X2
         172I63MZ+aNn3xo/J3UmQSa4J3CN7aVm8ZhUQD2PyEc9Ub4P77wuum4z8uPnVw/eVgkg
         J/LGw3z20hxZbSjHu2bC7UTHu/6APxJ2ZUjZFJ0+thoK35emGBYa7iJ6/x60Lb9OO4Am
         Jlomv4ZmoucdzkHyrR0qGOxB3qNTYYOiamxeqa6vrvqiMkvPRIccvoRkfIL5GJ4xk9/g
         D9Ng==
X-Gm-Message-State: AOAM532xECltmFStM0iAwc3RXIhtDMIKVqu5xQCvQ/hY8dUZBdnO8pvU
        MgkKbKe29wZNVv8lqQ9pBMz1IrM1E+S3AGeJM4bPKrLuDD4eH1athbRJKUQyQtpD047RViFbufL
        Exo6rq6UWygPq8WNqFkv8FP/q7y498CLdA0/gNDzapwO3TxXnc/Qx6GdYZm5Vpn0/crFftlvA7w
        ==
X-Google-Smtp-Source: ABdhPJxse0sSJAvWSD7M8f/ZqdG0cnSDOAd/cA55o/QGm//tqfKdZWS8ljiLonETRPgkYzyVa75798/8weUBCDbIBmQ=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c708:: with SMTP id
 w8mr9416510ybe.246.1626391570361; Thu, 15 Jul 2021 16:26:10 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:25:55 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 1/9] hook: run a list of hooks instead
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prepare for multihook support, teach hook.[hc] to take a list of
hooks at run_hooks and run_found_hooks. Right now the list is always one
entry, but in the future we will allow users to supply more than one
executable for a single hook event.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/hook.c |  9 +++---
 hook.c         | 85 ++++++++++++++++++++++++++++++++++++++++----------
 hook.h         | 15 ++++++++-
 3 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 169a8dd08f..a41ff36da9 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -25,7 +25,7 @@ static int run(int argc, const char **argv, const char *prefix)
 	int rc = 0;
 	int ignore_missing = 0;
 	const char *hook_name;
-	const char *hook_path;
+	struct list_head *hooks;
 
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
@@ -58,15 +58,16 @@ static int run(int argc, const char **argv, const char *prefix)
 	 * run_found_hooks() instead...
 	 */
 	hook_name = argv[0];
-	hook_path = find_hook(hook_name);
-	if (!hook_path) {
+	hooks = hook_list(hook_name);
+	if (list_empty(hooks)) {
 		/* ... act like run_hooks() under --ignore-missing */
 		if (ignore_missing)
 			return 0;
 		error("cannot find a hook named %s", hook_name);
 		return 1;
 	}
-	rc = run_found_hooks(hook_name, hook_path, &opt);
+
+	rc = run_found_hooks(hook_name, hooks, &opt);
 
 	run_hooks_opt_clear(&opt);
 
diff --git a/hook.c b/hook.c
index 31e822bf51..c1dac6982f 100644
--- a/hook.c
+++ b/hook.c
@@ -4,6 +4,28 @@
 #include "hook-list.h"
 #include "config.h"
 
+static void free_hook(struct hook *ptr)
+{
+	if (ptr) {
+		free(ptr->feed_pipe_cb_data);
+	}
+	free(ptr);
+}
+
+static void remove_hook(struct list_head *to_remove)
+{
+	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
+	list_del(to_remove);
+	free_hook(hook_to_remove);
+}
+
+void clear_hook_list(struct list_head *head)
+{
+	struct list_head *pos, *tmp;
+	list_for_each_safe(pos, tmp, head)
+		remove_hook(pos);
+}
+
 static int known_hook(const char *name)
 {
 	const char **p;
@@ -71,6 +93,30 @@ int hook_exists(const char *name)
 	return !!find_hook(name);
 }
 
+struct list_head* hook_list(const char* hookname)
+{
+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+
+	INIT_LIST_HEAD(hook_head);
+
+	if (!hookname)
+		return NULL;
+
+	if (have_git_dir()) {
+		const char *hook_path = find_hook(hookname);
+
+		/* Add the hook from the hookdir */
+		if (hook_path) {
+			struct hook *to_add = xmalloc(sizeof(*to_add));
+			to_add->hook_path = hook_path;
+			to_add->feed_pipe_cb_data = NULL;
+			list_add_tail(&to_add->list, hook_head);
+		}
+	}
+
+	return hook_head;
+}
+
 void run_hooks_opt_clear(struct run_hooks_opt *o)
 {
 	strvec_clear(&o->env);
@@ -108,6 +154,8 @@ static int pick_next_hook(struct child_process *cp,
 	struct hook_cb_data *hook_cb = pp_cb;
 	struct hook *run_me = hook_cb->run_me;
 
+	if (!run_me)
+		return 0;
 
 	/* reopen the file for stdin; run_command closes it. */
 	if (hook_cb->options->path_to_stdin) {
@@ -126,7 +174,10 @@ static int pick_next_hook(struct child_process *cp,
 	cp->dir = hook_cb->options->dir;
 
 	/* add command */
-	strvec_push(&cp->args, run_me->hook_path);
+	if (hook_cb->options->absolute_path)
+		strvec_push(&cp->args, absolute_path(run_me->hook_path));
+	else
+		strvec_push(&cp->args, run_me->hook_path);
 
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -137,6 +188,13 @@ static int pick_next_hook(struct child_process *cp,
 	/* Provide context for errors if necessary */
 	*pp_task_cb = run_me;
 
+	/* Get the next entry ready */
+	if (hook_cb->run_me->list.next == hook_cb->head)
+		hook_cb->run_me = NULL;
+	else
+		hook_cb->run_me = list_entry(hook_cb->run_me->list.next,
+					     struct hook, list);
+
 	return 1;
 }
 
@@ -170,24 +228,17 @@ static int notify_hook_finished(int result,
 	return 1;
 }
 
-int run_found_hooks(const char *hook_name, const char *hook_path,
+int run_found_hooks(const char *hook_name, struct list_head *hooks,
 		    struct run_hooks_opt *options)
 {
-	struct strbuf abs_path = STRBUF_INIT;
-	struct hook my_hook = {
-		.hook_path = hook_path,
-	};
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
 		.options = options,
 		.invoked_hook = options->invoked_hook,
 	};
-	if (options->absolute_path) {
-		strbuf_add_absolute_path(&abs_path, hook_path);
-		my_hook.hook_path = abs_path.buf;
-	}
-	cb_data.run_me = &my_hook;
+
+	cb_data.run_me = list_first_entry(hooks, struct hook, list);
 
 	if (options->jobs != 1)
 		BUG("we do not handle %d or any other != 1 job number yet", options->jobs);
@@ -201,15 +252,13 @@ int run_found_hooks(const char *hook_name, const char *hook_path,
 				   &cb_data,
 				   "hook",
 				   hook_name);
-	if (options->absolute_path)
-		strbuf_release(&abs_path);
 
 	return cb_data.rc;
 }
 
 int run_hooks(const char *hook_name, struct run_hooks_opt *options)
 {
-	const char *hook_path;
+	struct list_head *hooks;
 	int ret;
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
@@ -217,15 +266,17 @@ int run_hooks(const char *hook_name, struct run_hooks_opt *options)
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("choose only one method to populate stdin");
 
-	hook_path = find_hook(hook_name);
+	hooks = hook_list(hook_name);
 
 	/*
 	 * If you need to act on a missing hook, use run_found_hooks()
 	 * instead
 	 */
-	if (!hook_path)
+	if (list_empty(hooks))
 		return 0;
 
-	ret = run_found_hooks(hook_name, hook_path, options);
+	ret = run_found_hooks(hook_name, hooks, options);
+
+	clear_hook_list(hooks);
 	return ret;
 }
diff --git a/hook.h b/hook.h
index 9d9171672d..b97237931b 100644
--- a/hook.h
+++ b/hook.h
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
+#include "list.h"
 
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
@@ -17,6 +18,7 @@ const char *find_hook(const char *name);
 int hook_exists(const char *hookname);
 
 struct hook {
+	struct list_head list;
 	/* The path to the hook */
 	const char *hook_path;
 
@@ -27,6 +29,12 @@ struct hook {
 	void *feed_pipe_cb_data;
 };
 
+/*
+ * Provides a linked list of 'struct hook' detailing commands which should run
+ * in response to the 'hookname' event, in execution order.
+ */
+struct list_head* hook_list(const char *hookname);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -103,6 +111,7 @@ struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
 	const char *hook_name;
+	struct list_head *head;
 	struct hook *run_me;
 	struct run_hooks_opt *options;
 	int *invoked_hook;
@@ -120,6 +129,10 @@ int run_hooks(const char *hook_name, struct run_hooks_opt *options);
  * Takes an already resolved hook and runs it. Internally the simpler
  * run_hooks() will call this.
  */
-int run_found_hooks(const char *hookname, const char *hook_path,
+int run_found_hooks(const char *hookname, struct list_head *hooks,
 		    struct run_hooks_opt *options);
+
+/* Empties the list at 'head', calling 'free_hook()' on each entry */
+void clear_hook_list(struct list_head *head);
+
 #endif
-- 
2.32.0.402.g57bb445576-goog

