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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CFBC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6DD6044F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 03:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhHSDfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhHSDfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 23:35:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31191C061796
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o3-20020a2541030000b0290557cf3415f8so5311417yba.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 20:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yyCYb+cdeHW1Namj+5zsdiZ1CGz8jQzWaUSEaZe1y2A=;
        b=Ep39IN9p7ZiFx5uKMXsYzhtbxUMO3xKxbW1kmlyHO7FXq8Cp7parU4OQ7nU+vr9QUC
         V1cGVVLKp+qqtagxWEEsaYln+JhDyUmRJY2vpUgfx6GpTQZTnblTzvXIZcLkK+tJouqJ
         TNCztbV/IvMqgWqmCOyx7OAKz4IFPm1QMX+KQLRPXse7MaBRU/0nAovDKf1vs6X+HyTz
         NHQZYNZQOJkrkgY2FH/u+Y+JA5Q+f/j++Rk6rg4j2x4GQa13llQWQQ0vZuEDYJOjL7s8
         DYY3kNKJXwXl063exPFMk5QIzQXA3B26E6vlObSz80IphErXMbOIAkadzVBKAR/8TRf6
         HkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yyCYb+cdeHW1Namj+5zsdiZ1CGz8jQzWaUSEaZe1y2A=;
        b=cgkmooQ91Y/o6fKpS4CrO81Sn6GB2meA1wxzWVkAk9UbN+BeCvzfl2U6Y0hMwPDbEM
         dT1h2w20YojLLCVXcYp8XSnCzBf9GF/L+gAXVkMwx5UNmAO8fLiu/JtugrxPt5U0SoXa
         T+SIpWebD+3WW16U4QStc4RDcg6iK6IRqefXyIdhkGPku/t9gVx6kBFgFy+wQxxUwK6e
         UhI4YyPzKf7hwpjqq76HM4ijvRuBUYDR6QKzwtYkUYxRc9aidKNUpUrv4gfaWORAa2Hs
         EDNfWs+WcYdEAxv4Go3VVkyoX+7DcwMLOTnR/G1LZC8cLXRS7e4qrmUKMgpipxrX/L1D
         bDbg==
X-Gm-Message-State: AOAM533DlqTh5WczIYAnPZAXgXcWdfDuWn0hCGtArS76uW+jCpA3UN4s
        /FZa3MXeWYTGSrNny9tVUBSBFlrOR/TZYP/eTb/7BGjeIYpTs990UIg/ad9lFth3KK8/PpCi+UY
        fT30sV7OcS29CipFpr1D52horfuVx8wMfV6ZWS2EFqTjhmCkV7/vAnwDZcz0MN3nIBHV9asfDUA
        ==
X-Google-Smtp-Source: ABdhPJzJ59RI+qqbakaG9UaE8ej8jIvpd7KUD6amJdTsM2STcyYVDxn1byjHeKdNUdSalZ78VIQ7WkDY8KerDCOLH50=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:4c07:: with SMTP id
 z7mr16844611yba.350.1629344105234; Wed, 18 Aug 2021 20:35:05 -0700 (PDT)
Date:   Wed, 18 Aug 2021 20:34:49 -0700
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
Message-Id: <20210819033450.3382652-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819033450.3382652-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 5/6] hook: include hooks from the config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the hook.[hc] library to parse configs to populare the list of
hooks to run for a given event.

Multiple commands can be specified for a given hook by providing
multiple "hook.<friendly-name>.command = <path-to-hook>" and
"hook.<friendly-name>.event = <hook-event>" lines. Hooks will be run in
config order of the "hook.<name>.event" lines.

For example:

  $ git config --list | grep ^hook
  hook.bar.command=~/bar.sh
  hook.bar.event=pre-commit

  $ git hook run
  # Runs ~/bar.sh
  # Runs .git/hooks/pre-commit

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/hook.txt |  18 ++++
 Documentation/git-hook.txt    |  57 ++++++++++++-
 builtin/hook.c                |   3 +-
 hook.c                        | 153 ++++++++++++++++++++++++++++++----
 hook.h                        |   7 +-
 t/t1800-hook.sh               | 141 ++++++++++++++++++++++++++++++-
 6 files changed, 357 insertions(+), 22 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 96d3d6572c..c394756328 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -1,3 +1,21 @@
+hook.<name>.command::
+	A command to execute whenever `hook.<name>` is invoked. `<name>` should
+	be a unique "friendly" name which you can use to identify this hook
+	command. (You can specify when to invoke this command with
+	`hook.<name>.event`.) The value can be an executable on your device or a
+	oneliner for your shell. If more than one value is specified for the
+	same `<name>`, the last value parsed will be the only command executed.
+	See linkgit:git-hook[1].
+
+hook.<name>.event::
+	The hook events which should invoke `hook.<name>`. `<name>` should be a
+	unique "friendly" name which you can use to identify this hook. The
+	value should be the name of a hook event, like "pre-commit" or "update".
+	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
+	On the specified event, the associated `hook.<name>.command` will be
+	executed. More than one event can be specified if you wish for
+	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
+
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to the number of processors on
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index d1db084e4f..9c6cbdc2eb 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -27,12 +27,65 @@ Git is unlikely to use for a native hook later on. For example, Git is much less
 likely to create a `mytool-validate-commit` hook than it is to create a
 `validate-commit` hook.
 
+This command parses the default configuration files for pairs of configs like
+so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --c
+
+In this example, `[hook "linter"]` represents one script - `~/bin/linter --c` -
+which can be shared by many repos, and even by many hook events, if appropriate.
+
+Commands are run in the order Git encounters their associated
+`hook.<name>.event` configs during the configuration parse (see
+linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
+added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
+to determine which command to run.
+
+So if you wanted your linter to run when you commit as well as when you push,
+you would configure it like so:
+
+  [hook "linter"]
+    event = pre-commit
+    event = pre-push
+    command = ~/bin/linter --c
+
+With this config, `~/bin/linter --c` would be run by Git before a commit is
+generated (during `pre-commit`) as well as before a push is performed (during
+`pre-push`).
+
+And if you wanted to run your linter as well as a secret-leak detector during
+only the "pre-commit" hook event, you would configure it instead like so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --c
+  [hook "no-leaks"]
+    event = pre-commit
+    command = ~/bin/leak-detector
+
+With this config, before a commit is generated (during `pre-commit`), Git would
+first start `~/bin/linter --c` and second start `~/bin/leak-detector`. It would
+evaluate the output of each when deciding whether to proceed with the commit.
+
+For a full list of hook events which you can set your `hook.<name>.event` to,
+and how hooks are invoked during those events, see linkgit:githooks[5].
+
+In general, when instructions suggest adding a script to
+`.git/hooks/<hook-event>`, you can specify it in the config instead by running
+`git config --add hook.<some-name>.command <path-to-script> && git config --add
+hook.<some-name>.event <hook-event>` - this way you can share the script between
+multiple repos. That is, `cp ~/my-script.sh ~/project/.git/hooks/pre-commit`
+would become `git config --add hook.my-script.command ~/my-script.sh && git
+config --add hook.my-script.event pre-commit`.
+
 SUBCOMMANDS
 -----------
 
 run::
-	Run the `<hook-name>` hook. See linkgit:githooks[5] for
-	the hook names we support.
+	Runs hooks configured for `<hook-name>`, in the order they are
+	discovered during the config parse.
 +
 Any positional arguments to the hook should be passed after an
 optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
diff --git a/builtin/hook.c b/builtin/hook.c
index 80397d39f5..50233366a8 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -55,7 +55,8 @@ static int list(int argc, const char **argv, const char *prefix)
 		struct hook *item = list_entry(pos, struct hook, list);
 		item = list_entry(pos, struct hook, list);
 		if (item)
-			printf("%s\n", item->hook_path);
+			printf("%s\n", item->name ? item->name
+						  : _("hook from hookdir"));
 	}
 
 	clear_hook_list(head);
diff --git a/hook.c b/hook.c
index ab1e86ddcf..581d87cbbd 100644
--- a/hook.c
+++ b/hook.c
@@ -11,6 +11,50 @@ static void free_hook(struct hook *ptr)
 	free(ptr);
 }
 
+/*
+ * Walks the linked list at 'head' to check if any hook named 'name'
+ * already exists. Returns a pointer to that hook if so, otherwise returns NULL.
+ */
+static struct hook *find_hook_by_name(struct list_head *head,
+					 const char *name)
+{
+	struct list_head *pos = NULL, *tmp = NULL;
+	struct hook *found = NULL;
+
+	list_for_each_safe(pos, tmp, head) {
+		struct hook *it = list_entry(pos, struct hook, list);
+		if (!strcmp(it->name, name)) {
+			list_del(pos);
+			found = it;
+			break;
+		}
+	}
+	return found;
+}
+
+/*
+ * Adds a hook if it's not already in the list, or moves it to the tail of the
+ * list if it was already there. name == NULL indicates it's from the hookdir;
+ * just append it in this case.
+ */
+static void append_or_move_hook(struct list_head *head, const char *name)
+{
+	struct hook *to_add = NULL;
+
+	/* if it's not from hookdir, check if the hook is already in the list */
+	if (name)
+		to_add = find_hook_by_name(head, name);
+
+	if (!to_add) {
+		/* adding a new hook, not moving an old one */
+		to_add = xmalloc(sizeof(*to_add));
+		to_add->name = name;
+		to_add->feed_pipe_cb_data = NULL;
+	}
+
+	list_add_tail(&to_add->list, head);
+}
+
 static void remove_hook(struct list_head *to_remove)
 {
 	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
@@ -103,10 +147,50 @@ int hook_exists(const char *name)
 
 struct hook_config_cb
 {
-	struct strbuf *hook_key;
+	const char *hook_event;
 	struct list_head *list;
 };
 
+/*
+ * Callback for git_config which adds configured hooks to a hook list.  Hooks
+ * can be configured by specifying both hook.<friend-name>.command = <path> and
+ * hook.<friendly-name>.event = <hook-event>.
+ */
+static int hook_config_lookup(const char *key, const char *value, void *cb_data)
+{
+	struct hook_config_cb *data = cb_data;
+	const char *subsection, *parsed_key;
+	size_t subsection_len = 0;
+	struct strbuf subsection_cpy = STRBUF_INIT;
+
+	/*
+	 * Don't bother doing the expensive parse if there's no
+	 * chance that the config matches 'hook.myhook.event = hook_event'.
+	 */
+	if (!value || strcmp(value, data->hook_event))
+		return 0;
+
+	/* Looking for "hook.friendlyname.event = hook_event" */
+	if (parse_config_key(key,
+			    "hook",
+			    &subsection,
+			    &subsection_len,
+			    &parsed_key) ||
+	    strcmp(parsed_key, "event"))
+		return 0;
+
+	/*
+	 * 'subsection' is a pointer to the internals of 'key', which we don't
+	 * own the memory for. Copy it away to the hook list.
+	 */
+	strbuf_add(&subsection_cpy, subsection, subsection_len);
+
+	append_or_move_hook(data->list, strbuf_detach(&subsection_cpy, NULL));
+
+
+	return 0;
+}
+
 struct list_head *list_hooks(const char *hookname)
 {
 	if (!known_hook(hookname))
@@ -119,21 +203,23 @@ struct list_head *list_hooks(const char *hookname)
 struct list_head *list_hooks_gently(const char *hookname)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+	struct hook_config_cb cb_data = {
+		.hook_event = hookname,
+		.list = hook_head,
+	};
 
 	INIT_LIST_HEAD(hook_head);
 
 	if (!hookname)
 		BUG("null hookname was provided to hook_list()!");
 
-	if (have_git_dir()) {
-		const char *hook_path = find_hook_gently(hookname);
-		if (hook_path) {
-			struct hook *to_add = xmalloc(sizeof(*to_add));
-			to_add->hook_path = hook_path;
-			to_add->feed_pipe_cb_data = NULL;
-			list_add_tail(&to_add->list, hook_head);
-		}
-	}
+	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
+	git_config(hook_config_lookup, &cb_data);
+
+	/* Add the hook from the hookdir. The placeholder makes it easier to
+	 * allocate work in pick_next_hook. */
+	if (find_hook_gently(hookname))
+		append_or_move_hook(hook_head, NULL);
 
 	return hook_head;
 }
@@ -194,11 +280,43 @@ static int pick_next_hook(struct child_process *cp,
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
+	/* to enable oneliners, let config-specified hooks run in shell.
+	 * config-specified hooks have a name. */
+	cp->use_shell = !!run_me->name;
+
 	/* add command */
-	if (hook_cb->options->absolute_path)
-		strvec_push(&cp->args, absolute_path(run_me->hook_path));
-	else
-		strvec_push(&cp->args, run_me->hook_path);
+	if (run_me->name) {
+		/* ...from config */
+		struct strbuf cmd_key = STRBUF_INIT;
+		char *command = NULL;
+
+		strbuf_addf(&cmd_key, "hook.%s.command", run_me->name);
+		if (git_config_get_string(cmd_key.buf, &command)) {
+			/* TODO test me! */
+			die(_("'hook.%s.command' must be configured "
+			      "or 'hook.%s.event' must be removed; aborting.\n"),
+			    run_me->name, run_me->name);
+		}
+
+		strvec_push(&cp->args, command);
+	} else {
+		/* ...from hookdir. */
+		const char *hook_path = NULL;
+		/*
+		 *
+		 * At this point we are already running, so don't validate
+		 * whether the hook name is known or not.
+		 */
+		hook_path = find_hook_gently(hook_cb->hook_name);
+		if (!hook_path)
+			BUG("hookdir hook in hook list but no hookdir hook present in filesystem");
+
+		if (hook_cb->options->absolute_path)
+			hook_path = absolute_path(hook_path);
+
+		strvec_push(&cp->args, hook_path);
+	}
+
 
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -228,8 +346,11 @@ static int notify_start_failure(struct strbuf *out,
 
 	hook_cb->rc |= 1;
 
-	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    attempted->hook_path);
+	if (attempted->name)
+		strbuf_addf(out, _("Couldn't start hook '%s'\n"),
+		    attempted->name);
+	else
+		strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
 
 	return 1;
 }
diff --git a/hook.h b/hook.h
index 6b7b2d14d2..621bd2cde1 100644
--- a/hook.h
+++ b/hook.h
@@ -27,8 +27,11 @@ int hook_exists(const char *hookname);
 
 struct hook {
 	struct list_head list;
-	/* The path to the hook */
-	const char *hook_path;
+	/*
+	 * The friendly name of the hook. NULL indicates the hook is from the
+	 * hookdir.
+	 */
+	const char *name;
 
 	/*
 	 * Use this to keep state for your feed_pipe_fn if you are using
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 217db848b3..ef2432f53a 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1,13 +1,29 @@
 #!/bin/bash
 
-test_description='git-hook command'
+test_description='git-hook command and config-managed multihooks'
 
 . ./test-lib.sh
 
+setup_hooks () {
+	test_config hook.ghi.event pre-commit --add
+	test_config hook.ghi.command "/path/ghi" --add
+	test_config_global hook.def.event pre-commit --add
+	test_config_global hook.def.command "/path/def" --add
+}
+
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
 	test_expect_code 129 git hook run &&
 	test_expect_code 129 git hook run -h &&
+	test_expect_code 129 git hook list -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
 	grep "unknown option" err
 '
@@ -153,4 +169,127 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	def
+	ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate event declarations' '
+	setup_hooks &&
+
+	# 'def' is usually configured globally; move it to the end by
+	# configuring it locally.
+	test_config hook.def.event "pre-commit" --add &&
+
+	cat >expected <<-EOF &&
+	ghi
+	def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-EOF &&
+	hook from hookdir
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions execute oneliners' '
+	test_config hook.oneliner.event "pre-commit" &&
+	test_config hook.oneliner.command "echo \"Hello World\"" &&
+
+	echo "Hello World" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions resolve paths' '
+	write_script sample-hook.sh <<-EOF &&
+	echo \"Sample Hook\"
+	EOF
+
+	test_when_finished "rm sample-hook.sh" &&
+
+	test_config hook.sample-hook.event pre-commit &&
+	test_config hook.sample-hook.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	echo \"Sample Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hookdir hook included in git hook run' '
+	setup_hookdir &&
+
+	echo \"Legacy Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'stdin to multiple hooks' '
+	test_config hook.stdin-a.event "test-hook" --add &&
+	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" --add &&
+	test_config hook.stdin-b.event "test-hook" --add &&
+	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" --add &&
+
+	cat >input <<-EOF &&
+	1
+	2
+	3
+	EOF
+
+	cat >expected <<-EOF &&
+	a1
+	a2
+	a3
+	b1
+	b2
+	b3
+	EOF
+
+	git hook run --to-stdin=input test-hook 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'multiple hooks in series' '
+	test_config hook.series-1.event "test-hook" &&
+	test_config hook.series-1.command "echo 1" --add &&
+	test_config hook.series-2.event "test-hook" &&
+	test_config hook.series-2.command "echo 2" --add &&
+	mkdir .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo 3
+	EOF
+
+	cat >expected <<-EOF &&
+	1
+	2
+	3
+	EOF
+
+	git hook run -j1 test-hook 2>actual &&
+	test_cmp expected actual &&
+
+	rm -rf .git/hooks
+'
 test_done
-- 
2.33.0.rc2.250.ged5fa647cd-goog

