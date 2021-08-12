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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA586C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E79260FC3
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 00:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhHLAnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 20:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhHLAnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 20:43:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F6C061798
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j9-20020a2581490000b02905897d81c63fso4470555ybm.8
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 17:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bygr08Nm2GfaI75f8pkYp/y6cMQhW2DyUpgNXwhCLtk=;
        b=Xd0UXcF6oXHlrJlAhn5JaZMziyZEex0O0Xu2Rg7SPiBT2dvaG6Cdsc1k6DiYeaFYpK
         G+Hg7iSdFeiDylpK9+kRaShECWVzebNRa0uZ4sSAVwnEHSyFlZvzWT4qjaV6ZPKQAPpl
         ZO9GlqxwmPOPLgLNI7QR9fsOZgXUqFBihRLxNyvRsCaGtKkIyC8qPtPB/nm5OtnzvdSl
         2LqjYT/gpaL5o4B2s7PUTnfIXSQZtHSq4sBTJEkoX1Nn10JodVo7wwujz3x2YoQ2xRr1
         rmhxyqWzuohf8Y9Zirhn+MhpcFt7UojieDKdOQESPf3kpbsDwXTSlM21E/uoi180wmUI
         KYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bygr08Nm2GfaI75f8pkYp/y6cMQhW2DyUpgNXwhCLtk=;
        b=RcfGJ+udzngmEzk0PFfSBQFLsqrnyznldUpbpnA5iah4aNqTKdUOuhvxjtkJVqF8Pg
         fr1zWy15S26OBhvFoDwOxhkXLrye5Hz0oWN6WRukuwnLQ2iwxX9m9FgKXkb1oE6bIlFO
         AI4frDZGDsiSdCcm61lu1vNwblDtT+yGG7uTe+A8QJx+fNkPB6o2QkvFF+GhTFAh94A1
         mY+YIgz/kRzxasYavhWYan0DeRfzvuBHidYIFjACNtobu6P2Msg92twRswy+C0+QQqr2
         vyj43tUUA59HOr4po0zXGQrdQ0tg1Rq5NekIk8hTP8CzP6dN8Dr6zW3RFet6F/pGvDFA
         pNWg==
X-Gm-Message-State: AOAM531LTnI5ELwK10LOzttbod+rK3i8YahpgIQJ+YNMvHyJAsWOpcoM
        r8LG06+V/3xTj/lT7pCu+/VI8M6qMupqTPxrmtzbJ4OgonGM3euoQe/5B9xwJxh0aDLnUK840gJ
        d6/uL8v28kGSGZXfHxJYZNdw2J16xpRT5aFLIEMubE3TqLtKC6mXep9VijZ/vlkzBYENYoOx+Rg
        ==
X-Google-Smtp-Source: ABdhPJxxTv5XV9V/G5n3S2qrRnZQ5xQ9b8vlFG9MZAJ//nXd/K3xYYGVe4WXI3mhPfbXNbHsoR5fiK5vo2slnxDjkac=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
 (user=emilyshaffer job=sendgmr) by 2002:a25:dacc:: with SMTP id
 n195mr933096ybf.283.1628729002862; Wed, 11 Aug 2021 17:43:22 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:42:57 -0700
In-Reply-To: <20210812004258.74318-1-emilyshaffer@google.com>
Message-Id: <20210812004258.74318-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210812004258.74318-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v2 5/6] hook: include hooks from the config
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
 Documentation/config/hook.txt |   5 +
 Documentation/git-hook.txt    |  23 ++++-
 builtin/hook.c                |   5 +-
 hook.c                        | 166 +++++++++++++++++++++++++++++-----
 hook.h                        |   7 +-
 t/t1800-hook.sh               | 141 ++++++++++++++++++++++++++++-
 6 files changed, 318 insertions(+), 29 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 96d3d6572c..a97b980cca 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -1,3 +1,8 @@
+hook.<command>.command::
+	A command to execute during the <command> hook event. This can be an
+	executable on your device, a oneliner for your shell, or the name of a
+	hookcmd. See linkgit:git-hook[1].
+
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to the number of processors on
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 11a8b87c60..c610ed9583 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -26,12 +26,31 @@ Git is unlikely to use for a native hook later on. For example, Git is much less
 likely to create a `mytool-validate-commit` hook than it is to create a
 `validate-commit` hook.
 
+This command parses the default configuration files for pairs of configs like
+so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --c
+
+Conmmands are run in the order Git encounters their associated
+`hook.<name>.event` configs during the configuration parse (see
+linkgit:git-config[1]).
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
index 3aa65dd791..ea49dc4ef6 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -49,7 +49,7 @@ static int list(int argc, const char **argv, const char *prefix)
 	head = hook_list(hookname, 1);
 
 	if (list_empty(head)) {
-		printf(_("no commands configured for hook '%s'\n"),
+		printf(_("no hooks configured for event '%s'\n"),
 		       hookname);
 		return 0;
 	}
@@ -58,7 +58,8 @@ static int list(int argc, const char **argv, const char *prefix)
 		struct hook *item = list_entry(pos, struct hook, list);
 		item = list_entry(pos, struct hook, list);
 		if (item)
-			printf("%s\n", item->hook_path);
+			printf("%s\n", item->name ? item->name
+						  : _("hook from hookdir"));
 	}
 
 	clear_hook_list(head);
diff --git a/hook.c b/hook.c
index e5acd02a50..51ada266bc 100644
--- a/hook.c
+++ b/hook.c
@@ -12,6 +12,50 @@ static void free_hook(struct hook *ptr)
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
@@ -99,38 +143,80 @@ const char *find_hook_gently(const char *name)
 
 int hook_exists(const char *name)
 {
-	return !!find_hook(name);
+	return !list_empty(hook_list(name, 0));
 }
 
 struct hook_config_cb
 {
-	struct strbuf *hook_key;
+	const char *hook_event;
 	struct list_head *list;
 };
 
-struct list_head* hook_list(const char* hookname, int allow_unknown)
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
+struct list_head* hook_list(const char *hookname, int allow_unknown)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
-	const char *hook_path;
+	struct hook_config_cb cb_data = {
+		.hook_event = hookname,
+		.list = hook_head,
+	};
 
+	if (!allow_unknown && !known_hook(hookname))
+		die(_("Don't recognize hook event '%s'. "
+		      "Is it documented in 'githooks.txt'?"),
+		      hookname);
 
 	INIT_LIST_HEAD(hook_head);
 
 	if (!hookname)
 		return NULL;
 
-	if (allow_unknown)
-		hook_path = find_hook_gently(hookname);
-	else
-		hook_path = find_hook(hookname);
+	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
+	git_config(hook_config_lookup, &cb_data);
 
-	/* Add the hook from the hookdir */
-	if (hook_path) {
-		struct hook *to_add = xmalloc(sizeof(*to_add));
-		to_add->hook_path = hook_path;
-		to_add->feed_pipe_cb_data = NULL;
-		list_add_tail(&to_add->list, hook_head);
-	}
+	/* Add the hook from the hookdir. The placeholder makes it easier to
+	 * allocate work in pick_next_hook. */
+	if (find_hook_gently(hookname))
+		append_or_move_hook(hook_head, NULL);
 
 	return hook_head;
 }
@@ -191,11 +277,43 @@ static int pick_next_hook(struct child_process *cp,
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
@@ -225,8 +343,11 @@ static int notify_start_failure(struct strbuf *out,
 
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
@@ -320,7 +441,8 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 		BUG("choose only one method to populate stdin");
 
 	/*
-	 * 'git hooks run <hookname>' uses run_found_hooks, so we don't need to
+	 * 'git hooks run <hookname>' uses run_found_hooks, and we want to make
+	 * sure internal callers are using known hooks, so we don't need to
 	 * allow unknown hooknames here.
 	 */
 	hooks = hook_list(hook_name, 0);
diff --git a/hook.h b/hook.h
index ffa96c6e4d..a6263864b9 100644
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
2.32.0.605.g8dce9f2422-goog

