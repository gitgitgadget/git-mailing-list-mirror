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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E612C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02F8613DA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhGOX33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhGOX3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:17 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ECEC061766
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:22 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so5025381qkf.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KLpyPwtcgHUj2eR1HHgJggCvuoorFa+Vxzr+i5GK83w=;
        b=n7vP4D41zEpadhs9CSNs6uDob/3AaAG23Gk1fhBUTZbT0WDx2F8STQ2+IjZQJ56G/2
         nhoQgKuZMh0jpnB9IULYPjygk5AdG50nvj+QNAxgjybX74I4jfJ5nc0+jAj/j3mw9RCL
         GhkWEzEZy/rUX/fyBn7HJ2r2Hr28GBIlzQx8TsuLCXpJLIylXfaOUu158JWZrPqwklwJ
         OeHTS02aAsXfiPSrELOGuXhdXRQHcaEXJbQE1pZSdXnhrjv4jKbwHBJkUBysO0ZDLiNM
         ufka/Yod+n6CM/dawn5LriRJYJZHA5r7r7gdrtrZGCQdXrXJ3XD1NjTdC6G+PPaTHnw9
         S+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KLpyPwtcgHUj2eR1HHgJggCvuoorFa+Vxzr+i5GK83w=;
        b=OKn9i9MyLteUys8FEtbZDUabBR5/3ZNMAdaKXwxqTAZeEcrDeS7FhakvZDyD/Bp/ZP
         VBjIPu230Eu1J6Gz6P6wE9Ip3t30EWS5hc3QFtF9qxWPOJAJUO8SGT63WGL2PZXaXdWJ
         uVqPub/1lw9S3TXnrFtNQhU5BnXwzz4HnRgoKznjYBL44oyx2lzzHR9ViwQOylPDT1KM
         MlkJ7JaDvc03JIzco1ceEYTl+HQMUeUwdFgehd5PpiIVzjHduT/XhIZYQyXpjishcwy/
         YZmNTbkIJ6ITFF7NSC6ViO1T63RY9S5dJzUm91Mk1s0RFOt0gKyRQoCdGdQMRk04XaeA
         zf7g==
X-Gm-Message-State: AOAM531eYz4B77XVNkD9BuBtZo5FVOZ314NKPfy8Gm5Q2KAowtKodzf2
        nTluO8HMGHCpNZumorUeQBim7ptRjM/xbzBmrXI0QSQ3BuIjYH11uwex+a0LYlt/nLLnwo2+MJ9
        k1+Y3xR3w842K6jSTagJsQwVzMTEbpqV195XFOFUfvrzvKXKWBwGijApVErS5Gh8+klmETvh4Kg
        ==
X-Google-Smtp-Source: ABdhPJzTDpZIAxhPEGnnnFLgzzCGNLKtadWNrtugZoD0z5FiZ6rRtBaOh7AhfCyGztqYeHFWd9eoEYQGj3adgbu7TYE=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:ad4:5bec:: with SMTP id
 k12mr7057371qvc.5.1626391581355; Thu, 15 Jul 2021 16:26:21 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:26:00 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-7-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 6/9] hook: include hooks from the config
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
multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
run in config order.

For example:

  $ git config --list | grep ^hook
  hook.pre-commit.command=~/bar.sh

  $ git hook run
  # Runs ~/bar.sh
  # Runs .git/hooks/pre-commit

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/hook.txt |   5 ++
 Documentation/git-hook.txt    |  16 +++-
 builtin/hook.c                |   2 +-
 hook.c                        | 109 ++++++++++++++++++++---
 hook.h                        |   2 +-
 t/t1360-config-based-hooks.sh | 159 ++++++++++++++++++++++++++++++++++
 6 files changed, 278 insertions(+), 15 deletions(-)
 create mode 100755 t/t1360-config-based-hooks.sh

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
index 8bf82b5dd4..8e2ab724e8 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -18,12 +18,24 @@ This command is an interface to git hooks (see linkgit:githooks[5]).
 Currently it only provides a convenience wrapper for running hooks for
 use by git itself. In the future it might gain other functionality.
 
+This command parses the default configuration files for sections like `hook
+"<hook name>"`. `hook` is used to describe the commands which will be run during
+a particular hook event; commands are run in the order Git encounters them
+during the configuration parse (see linkgit:git-config[1]).
+
+In general, when instructions suggest adding a script to
+`.git/hooks/<something>`, you can specify it in the config instead by running
+`git config --add hook.<something>.command <path-to-script>` - this way you can
+share the script between multiple repos. That is, `cp ~/my-script.sh
+~/project/.git/hooks/pre-commit` would become `git config --add
+hook.pre-commit.command ~/my-script.sh`.
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
index b08f9c9c4f..c54b0a4d13 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -51,7 +51,7 @@ static int list(int argc, const char **argv, const char *prefix)
 		struct hook *item = list_entry(pos, struct hook, list);
 		item = list_entry(pos, struct hook, list);
 		if (item)
-			printf("%s\n", item->hook_path);
+			printf("%s\n", item->command);
 	}
 
 	clear_hook_list(head);
diff --git a/hook.c b/hook.c
index e1cf035022..ed90edcad7 100644
--- a/hook.c
+++ b/hook.c
@@ -12,6 +12,51 @@ static void free_hook(struct hook *ptr)
 	free(ptr);
 }
 
+/*
+ * Walks the linked list at 'head' to check if any hook running 'command'
+ * already exists. Returns a pointer to that hook if so, otherwise returns NULL.
+ */
+static struct hook * find_hook_by_command(struct list_head *head, const char *command)
+{
+	struct list_head *pos = NULL, *tmp = NULL;
+	struct hook *found = NULL;
+
+	list_for_each_safe(pos, tmp, head) {
+		struct hook *it = list_entry(pos, struct hook, list);
+		if (!strcmp(it->command, command)) {
+		    list_del(pos);
+		    found = it;
+		    break;
+		}
+	}
+	return found;
+}
+
+/*
+ * Adds a hook if it's not already in the list, or moves it to the tail of the
+ * list if it was already there.
+ * Returns a handle to the hook in case more modification is needed. Do not free
+ * the returned handle.
+ */
+static struct hook * append_or_move_hook(struct list_head *head, const char *command)
+{
+	/* check if the hook is already in the list */
+	struct hook *to_add = find_hook_by_command(head, command);
+
+	if (!to_add) {
+		/* adding a new hook, not moving an old one */
+		to_add = xmalloc(sizeof(*to_add));
+		to_add->command = command;
+		to_add->feed_pipe_cb_data = NULL;
+		/* This gets overwritten in hook_list() for hookdir hooks. */
+		to_add->from_hookdir = 0;
+	}
+
+	list_add_tail(&to_add->list, head);
+
+	return to_add;
+}
+
 static void remove_hook(struct list_head *to_remove)
 {
 	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
@@ -116,30 +161,69 @@ struct hook_config_cb
 	struct list_head *list;
 };
 
+/*
+ * Callback for git_config which adds configured hooks to a hook list.
+ * Hooks can be configured by specifying hook.<name>.command, for example,
+ * hook.pre-commit.command = echo "pre-commit hook!"
+ */
+static int hook_config_lookup(const char *key, const char *value, void *cb_data)
+{
+	struct hook_config_cb *data = cb_data;
+	const char *hook_key = data->hook_key->buf;
+	struct list_head *head = data->list;
+
+	if (!strcmp(key, hook_key)) {
+		const char *command = value;
+		struct strbuf hookcmd_name = STRBUF_INIT;
+
+
+		if (!command) {
+			strbuf_release(&hookcmd_name);
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+		}
+
+		/* TODO: implement skipping hooks */
+
+		/* TODO: immplement hook aliases */
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+		append_or_move_hook(head, command);
+
+		strbuf_release(&hookcmd_name);
+	}
+
+	return 0;
+}
+
 struct list_head* hook_list(const char* hookname, int allow_unknown)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
 	const char *hook_path;
-
+	struct strbuf hook_key = STRBUF_INIT;
+	struct hook_config_cb cb_data = { &hook_key, hook_head };
 
 	INIT_LIST_HEAD(hook_head);
 
 	if (!hookname)
 		return NULL;
 
+	/* Add the hooks from the config, e.g. hook.pre-commit.command */
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+	git_config(hook_config_lookup, &cb_data);
+
+
 	if (allow_unknown)
 		hook_path = find_hook_gently(hookname);
 	else
 		hook_path = find_hook(hookname);
 
 	/* Add the hook from the hookdir */
-	if (hook_path) {
-		struct hook *to_add = xmalloc(sizeof(*to_add));
-		to_add->hook_path = hook_path;
-		to_add->feed_pipe_cb_data = NULL;
-		to_add->from_hookdir = 1;
-		list_add_tail(&to_add->list, hook_head);
-	}
+	if (hook_path)
+		append_or_move_hook(hook_head, hook_path)->from_hookdir = 1;
 
 	return hook_head;
 }
@@ -220,11 +304,14 @@ static int pick_next_hook(struct child_process *cp,
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
+	/* to enable oneliners, let config-specified hooks run in shell */
+	cp->use_shell = !run_me->from_hookdir;
+
 	/* add command */
 	if (run_me->from_hookdir && hook_cb->options->absolute_path)
-		strvec_push(&cp->args, absolute_path(run_me->hook_path));
+		strvec_push(&cp->args, absolute_path(run_me->command));
 	else
-		strvec_push(&cp->args, run_me->hook_path);
+		strvec_push(&cp->args, run_me->command);
 
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -255,7 +342,7 @@ static int notify_start_failure(struct strbuf *out,
 	hook_cb->rc |= 1;
 
 	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    attempted->hook_path);
+		    attempted->command);
 
 	return 1;
 }
diff --git a/hook.h b/hook.h
index 2559232880..e8cd6b7c67 100644
--- a/hook.h
+++ b/hook.h
@@ -28,7 +28,7 @@ int hook_exists(const char *hookname);
 struct hook {
 	struct list_head list;
 	/* The path to the hook */
-	const char *hook_path;
+	const char *command;
 
 	unsigned from_hookdir : 1;
 
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
new file mode 100755
index 0000000000..12fca516ec
--- /dev/null
+++ b/t/t1360-config-based-hooks.sh
@@ -0,0 +1,159 @@
+#!/bin/bash
+
+test_description='config-managed multihooks, including git-hook command'
+
+. ./test-lib.sh
+
+ROOT=
+if test_have_prereq MINGW
+then
+	# In Git for Windows, Unix-like paths work only in shell scripts;
+	# `git.exe`, however, will prefix them with the pseudo root directory
+	# (of the Unix shell). Let's accommodate for that.
+	ROOT="$(cd / && pwd)"
+fi
+
+setup_hooks () {
+	test_config hook.pre-commit.command "/path/ghi" --add
+	test_config_global hook.pre-commit.command "/path/def" --add
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
+test_expect_success 'git hook rejects commands without a mode' '
+	test_must_fail git hook pre-commit
+'
+
+test_expect_success 'git hook rejects commands without a hookname' '
+	test_must_fail git hook list
+'
+
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	$ROOT/path/def
+	$ROOT/path/ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate commands' '
+	setup_hooks &&
+
+	test_config hook.pre-commit.command "/path/def" --add &&
+
+	cat >expected <<-EOF &&
+	$ROOT/path/ghi
+	$ROOT/path/def
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
+	.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'inline hook definitions execute oneliners' '
+	test_config hook.pre-commit.command "echo \"Hello World\"" &&
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
+	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	echo \"Sample Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook run can pass args' '
+	write_script sample-hook.sh <<-\EOF &&
+	echo $1
+	echo $2
+	EOF
+
+	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	cat >expected <<-EOF &&
+	arg1
+	arg2
+	EOF
+
+	git hook run pre-commit -- arg1 arg2 2>actual &&
+
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
+test_expect_success 'out-of-repo runs excluded' '
+	setup_hooks &&
+
+	nongit test_must_fail git hook run pre-commit
+'
+
+test_expect_success 'stdin to multiple hooks' '
+	git config --add hook.test.command "xargs -P1 -I% echo a%" &&
+	git config --add hook.test.command "xargs -P1 -I% echo b%" &&
+	test_when_finished "test_unconfig hook.test.command" &&
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
+	git hook run --to-stdin=input test 2>actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.32.0.402.g57bb445576-goog

