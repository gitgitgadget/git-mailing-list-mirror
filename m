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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA1C4320A
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8C610CE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhHSDfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhHSDfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE5C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:34:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w19-20020ac87e930000b029025a2609eb04so2014141qtj.17
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8BbJ6Qb2PqmNaSkvqwYErTCq3vQRssY7Pja9+YSzrXQ=;
        b=RhgLck4VFDWTPXo5CPe6xo/+mFG6J0h6oQ0Y0tf68OONhU8+scxnsFnh1qxmqmfJIl
         63I6CxbFIsNk3BLgChA4eSKCMEe65B1+ceTHJnh+wMVCssFFDLozdO5ek5tah5ZMGM40
         NJr8v+G7z384hTp5OwHH7kNGIOBOyTa8+TH/5zKXUhR9NB711OMUM1hP+cqnmF6WTk+0
         jjOaxEKvRx7klZrUlIO8xGBWfiIcdD+vNDQDjpvXsehNHtQ1+Whz3xEzf0FDF75Jr/ZT
         oACgZQV2Iirq/ZDwGggIZv6NnBKdeXT4Mda1GaVl+MK8FDeaiMWM6MsTxtg8Wu4mnTbR
         Zeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8BbJ6Qb2PqmNaSkvqwYErTCq3vQRssY7Pja9+YSzrXQ=;
        b=p/HDcetSO3Mkg/xPQd7l195v/JNrxmp+ZcTE+P9fCvP/qms6GZWMQmx7fVITf42LE7
         /6Og22InAOJOB0j3khuN79+xl6tepv1mC1TspZlyEKN3J+oqesD+TbJP031hDd0mV3el
         EpzucnvCXr84g46/WRKLSHugx3pOBLasn7mXqIDjuEfF2sVebR8iTbl1Ywh6JQqMQvVN
         d82agE4kPBy56lDcWpBgCaz9i2gGNhedkq3Y27HdIjjlWxXAcnDhVv9mkmd6IOcOvskU
         jF69HsFMlpmQ5b7Ll1kVxPceMfCmotHgxJFw1als8R9mDeGP7IoKxr1H4/w3RCl+5k0f
         6fUQ==
X-Gm-Message-State: AOAM531b0rWmhlInrU8fO9A81U7612+tHk45icIX9U5jaMyfdP4bmKG2
        MxAaSQWi6dzE4Gjp2UhP8/tgdic5YxdN0G3WW+PQ0JCWj2iqL/5hqkBgrJHIBCPT2NiOoOLdt3x
        q0po2nGpK9SBXDg4XEQfC2OXx9Sw6c6VZjBdfa18otTVpZa1ODcdcNDP1dv1HfwWpB/fdgKguvg
        ==
X-Google-Smtp-Source: ABdhPJz9FUSFAnGh5vZM2SgD0+G2hxdkYbL7sfIOLmX2ui0M2RMAcOsu0G4bqJ8/gD6p1EXDZxcQ5ooT+nzh5UE/3EI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:d04:: with SMTP id
 4mr5108826qvh.36.1629344096527; Wed, 18 Aug 2021 20:34:56 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:45 -0700
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 1/6] hook: run a list of hooks instead
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
 builtin/hook.c |  14 ++++---
 hook.c         | 104 +++++++++++++++++++++++++++++++++++--------------
 hook.h         |  16 +++++++-
 3 files changed, 96 insertions(+), 38 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 27dce6a2f0..e18357ba1f 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -25,7 +25,8 @@ static int run(int argc, const char **argv, const char *prefix)
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ignore_missing = 0;
 	const char *hook_name;
-	const char *hook_path;
+	struct list_head *hooks;
+
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
@@ -58,15 +59,16 @@ static int run(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	hook_name = argv[0];
-	if (ignore_missing)
-		return run_hooks_oneshot(hook_name, &opt);
-	hook_path = find_hook(hook_name);
-	if (!hook_path) {
+	hooks = list_hooks(hook_name);
+	if (list_empty(hooks)) {
+		/* ... act like run_hooks_oneshot() under --ignore-missing */
+		if (ignore_missing)
+			return 0;
 		error("cannot find a hook named %s", hook_name);
 		return 1;
 	}
 
-	ret = run_hooks(hook_name, hook_path, &opt);
+	ret = run_hooks(hook_name, hooks, &opt);
 	run_hooks_opt_clear(&opt);
 	return ret;
 usage:
diff --git a/hook.c b/hook.c
index ee20b2e365..333cfd633a 100644
--- a/hook.c
+++ b/hook.c
@@ -4,6 +4,27 @@
 #include "hook-list.h"
 #include "config.h"
 
+static void free_hook(struct hook *ptr)
+{
+	if (ptr)
+		free(ptr->feed_pipe_cb_data);
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
@@ -68,7 +89,31 @@ const char *find_hook(const char *name)
 
 int hook_exists(const char *name)
 {
-	return !!find_hook(name);
+	return !list_empty(list_hooks(name));
+}
+
+struct list_head *list_hooks(const char *hookname)
+{
+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+
+	INIT_LIST_HEAD(hook_head);
+
+	if (!hookname)
+		BUG("null hookname was provided to hook_list()!");
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
 }
 
 void run_hooks_opt_clear(struct run_hooks_opt *o)
@@ -128,7 +173,10 @@ static int pick_next_hook(struct child_process *cp,
 	cp->dir = hook_cb->options->dir;
 
 	/* add command */
-	strvec_push(&cp->args, run_me->hook_path);
+	if (hook_cb->options->absolute_path)
+		strvec_push(&cp->args, absolute_path(run_me->hook_path));
+	else
+		strvec_push(&cp->args, run_me->hook_path);
 
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -139,12 +187,12 @@ static int pick_next_hook(struct child_process *cp,
 	/* Provide context for errors if necessary */
 	*pp_task_cb = run_me;
 
-	/*
-	 * This pick_next_hook() will be called again, we're only
-	 * running one hook, so indicate that no more work will be
-	 * done.
-	 */
-	hook_cb->run_me = NULL;
+	/* Get the next entry ready */
+	if (hook_cb->run_me->list.next == hook_cb->head)
+		hook_cb->run_me = NULL;
+	else
+		hook_cb->run_me = list_entry(hook_cb->run_me->list.next,
+					     struct hook, list);
 
 	return 1;
 }
@@ -179,13 +227,9 @@ static int notify_hook_finished(int result,
 	return 0;
 }
 
-int run_hooks(const char *hook_name, const char *hook_path,
-	      struct run_hooks_opt *options)
+int run_hooks(const char *hook_name, struct list_head *hooks,
+		    struct run_hooks_opt *options)
 {
-	struct strbuf abs_path = STRBUF_INIT;
-	struct hook my_hook = {
-		.hook_path = hook_path,
-	};
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
@@ -197,11 +241,9 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
-	if (options->absolute_path) {
-		strbuf_add_absolute_path(&abs_path, hook_path);
-		my_hook.hook_path = abs_path.buf;
-	}
-	cb_data.run_me = &my_hook;
+
+	cb_data.head = hooks;
+	cb_data.run_me = list_first_entry(hooks, struct hook, list);
 
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
@@ -213,18 +255,15 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   "hook",
 				   hook_name);
 
-
-	if (options->absolute_path)
-		strbuf_release(&abs_path);
-	free(my_hook.feed_pipe_cb_data);
+	clear_hook_list(hooks);
 
 	return cb_data.rc;
 }
 
 int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 {
-	const char *hook_path;
-	int ret;
+	struct list_head *hooks;
+	int ret = 0;
 	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
 
 	if (!options)
@@ -233,14 +272,19 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("choose only one method to populate stdin");
 
-	hook_path = find_hook(hook_name);
-	if (!hook_path) {
-		ret = 0;
+	hooks = list_hooks(hook_name);
+
+	/*
+	 * If you need to act on a missing hook, use run_found_hooks()
+	 * instead
+	 */
+	if (list_empty(hooks))
 		goto cleanup;
-	}
 
-	ret = run_hooks(hook_name, hook_path, options);
+	ret = run_hooks(hook_name, hooks, options);
+
 cleanup:
 	run_hooks_opt_clear(options);
+	clear_hook_list(hooks);
 	return ret;
 }
diff --git a/hook.h b/hook.h
index 58dfbf474c..12b56616bb 100644
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
+struct list_head *list_hooks(const char *hookname);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -97,6 +105,7 @@ struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
 	const char *hook_name;
+	struct list_head *head;
 	struct hook *run_me;
 	struct run_hooks_opt *options;
 	int *invoked_hook;
@@ -110,8 +119,8 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
  *
  * See run_hooks_oneshot() for the simpler one-shot API.
  */
-int run_hooks(const char *hookname, const char *hook_path,
-	      struct run_hooks_opt *options);
+int run_hooks(const char *hookname, struct list_head *hooks,
+		    struct run_hooks_opt *options);
 
 /**
  * Calls find_hook() on your "hook_name" and runs the hooks (if any)
@@ -123,4 +132,7 @@ int run_hooks(const char *hookname, const char *hook_path,
  */
 int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
 
+/* Empties the list at 'head', calling 'free_hook()' on each entry */
+void clear_hook_list(struct list_head *head);
+
 #endif
-- 
2.33.0.rc2.250.ged5fa647cd-goog

