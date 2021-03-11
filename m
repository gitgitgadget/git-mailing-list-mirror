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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DBBC4332D
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B53464FCE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCKCLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhCKCLI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:08 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110DAC061761
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:57 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id c1so14346916qke.8
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/v6QJ8Vi69yDpIyUgrQx1IJrINit+yIQWtxF4KHWiV8=;
        b=VW5VbBXtkHR6llRiHEtNpNgIv/D8/ySP6uOLUIarV2z2DBBrpQxpfnvW1dUWKCWTyh
         Wvz91ejbweVz3IKkwcYJCWOUHsrcICsPoM9CLJOdeFmK0x7c6iB51ol2CTdtBmj9DQLz
         Gidv7ihOQ8Ns7PYUR5giUFTjjGUKqDY2oP9VR2MeAnrhDlvQf5bm/DIwEh+mx7CupoOp
         WJlN9usOzH9qqc+HDeYLEuGIiqYE36YaWkGyvV3w++LT/NKtgb8ZrygAA4E5HBiss3Da
         V5upVWZ9TnukCIPMZzuDDpasXBmo37BKpL2mcdw8uT2gigT+exWjl88L1T0UAXGY2rsq
         icmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/v6QJ8Vi69yDpIyUgrQx1IJrINit+yIQWtxF4KHWiV8=;
        b=l8J18/PX/IYrqHlP/t1goncSiRW0rheBXuY0odyN2DLS2R1JNaxmOyah4P7WVPTt5M
         wiuGFxKQ0tJCIfHbpUr6c/2ile2E7QeZNt37DoygkgY7Rcz/AW/Dv7Wc8xJif0LX1LHI
         cW1fjfHzwxu6HWp/5XSHIGwtGJUdX1DqM8zsED4GstC9bPCsGpwdlSuy7vvZvnO9dRAH
         aSRyEq/+mQFrXsJ9pkZo9m3xcWauYQdPYIKKoJBCBtAgTgaLmWKsgqH6kzB+YFrClsgi
         HBG5Td/H8ZZtEtkyGTHS2v9WFpkzkeCVSGUqXH3oKjutFfGR24dg6htRoB1XewJ1MP5n
         gjyA==
X-Gm-Message-State: AOAM531scFM6+olCVtDPUCgXtKxwv43exxDZs5Nwc7ShJeX7H4GIjw9w
        1oYHmaNedJ1t4JflN9XOfXgISwCk42RsYWqz3jhEb0jl5GjboJUMa532JWH0tMBGxNMCws1ibua
        0Aq+soriO8wYdwSNyPu6IGUkl3EmhbUVUBWittEvpSnMz3A01eexe+NZAwsrMYdGikVHWgEXohw
        ==
X-Google-Smtp-Source: ABdhPJw5VHWaXF6poOm4YJ8lszCDFfvq3e2s5LTNysDN8m3ZTAygMHsLdI1s/kd/3uMmc0PuxcQx9OTtimDoyeGIEJk=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:bd82:: with SMTP id
 n2mr5766918qvg.62.1615428656205; Wed, 10 Mar 2021 18:10:56 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:03 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 03/37] hook: add list command
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git hook list <hookname>', which checks the known configs in
order to create an ordered list of hooks to run on a given hook event.

Multiple commands can be specified for a given hook by providing
multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
run in config order. If more properties need to be set on a given hook
in the future, commands can also be specified by providing
"hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
<hookcmd-name>]" subsection; this subsection should contain a
"hookcmd.<hookcmd-name>.command = <path-to-hook>" line.

For example:

  $ git config --list | grep ^hook
  hook.pre-commit.command=baz
  hook.pre-commit.command=~/bar.sh
  hookcmd.baz.command=~/baz/from/hookcmd.sh

  $ git hook list pre-commit
  global: ~/baz/from/hookcmd.sh
  local: ~/bar.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v7, fixed some nits from Jonathan Tan, one of which revealed a bug in
    how I was adding hooks to the list.

 Documentation/config/hook.txt |   9 +++
 Documentation/git-hook.txt    |  59 ++++++++++++++++-
 Makefile                      |   1 +
 builtin/hook.c                |  56 ++++++++++++++--
 hook.c                        | 120 ++++++++++++++++++++++++++++++++++
 hook.h                        |  25 +++++++
 t/t1360-config-based-hooks.sh |  81 ++++++++++++++++++++++-
 7 files changed, 341 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
new file mode 100644
index 0000000000..71449ecbc7
--- /dev/null
+++ b/Documentation/config/hook.txt
@@ -0,0 +1,9 @@
+hook.<command>.command::
+	A command to execute during the <command> hook event. This can be an
+	executable on your device, a oneliner for your shell, or the name of a
+	hookcmd. See linkgit:git-hook[1].
+
+hookcmd.<name>.command::
+	A command to execute during a hook for which <name> has been specified
+	as a command. This can be an executable on your device or a oneliner for
+	your shell. See linkgit:git-hook[1].
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 9eeab0009d..f19875ed68 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,12 +8,65 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook'
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
-A placeholder command. Later, you will be able to list, add, and modify hooks
-with this command.
+You can list configured hooks with this command. Later, you will be able to run,
+add, and modify hooks with this command.
+
+This command parses the default configuration files for sections `hook` and
+`hookcmd`. `hook` is used to describe the commands which will be run during a
+particular hook event; commands are run in the order Git encounters them during
+the configuration parse (see linkgit:git-config[1]). `hookcmd` is used to
+describe attributes of a specific command. If additional attributes don't need
+to be specified, a command to run can be specified directly in the `hook`
+section; if a `hookcmd` by that name isn't found, Git will attempt to run the
+provided value directly. For example:
+
+Global config
+----
+  [hook "post-commit"]
+    command = "linter"
+    command = "~/typocheck.sh"
+
+  [hookcmd "linter"]
+    command = "/bin/linter --c"
+----
+
+Local config
+----
+  [hook "prepare-commit-msg"]
+    command = "linter"
+  [hook "post-commit"]
+    command = "python ~/run-test-suite.py"
+----
+
+With these configs, you'd then see:
+
+----
+$ git hook list "post-commit"
+global: /bin/linter --c
+global: ~/typocheck.sh
+local: python ~/run-test-suite.py
+
+$ git hook list "prepare-commit-msg"
+local: /bin/linter --c
+----
+
+COMMANDS
+--------
+
+list `<hook-name>`::
+
+List the hooks which have been configured for `<hook-name>`. Hooks appear
+in the order they should be run, and print the config scope where the relevant
+`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
+This output is human-readable and the format is subject to change over time.
+
+CONFIGURATION
+-------------
+include::config/hook.txt[]
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 8e904a1ab5..3fa51597d8 100644
--- a/Makefile
+++ b/Makefile
@@ -891,6 +891,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..bb64cd77ca 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,21 +1,67 @@
 #include "cache.h"
-
 #include "builtin.h"
+#include "config.h"
+#include "hook.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 static const char * const builtin_hook_usage[] = {
-	N_("git hook"),
+	N_("git hook list <hookname>"),
 	NULL
 };
 
-int cmd_hook(int argc, const char **argv, const char *prefix)
+static int list(int argc, const char **argv, const char *prefix)
 {
-	struct option builtin_hook_options[] = {
+	struct list_head *head, *pos;
+	struct strbuf hookname = STRBUF_INIT;
+
+	struct option list_options[] = {
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+	argc = parse_options(argc, argv, prefix, list_options,
 			     builtin_hook_usage, 0);
 
+	if (argc < 1) {
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_usage, list_options);
+	}
+
+	strbuf_addstr(&hookname, argv[0]);
+
+	head = hook_list(&hookname);
+
+	if (list_empty(head)) {
+		printf(_("no commands configured for hook '%s'\n"),
+		       hookname.buf);
+		strbuf_release(&hookname);
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		struct hook *item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s: %s\n",
+			       config_scope_name(item->origin),
+			       item->command.buf);
+	}
+
+	clear_hook_list(head);
+	strbuf_release(&hookname);
+
 	return 0;
 }
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+	if (argc < 2)
+		usage_with_options(builtin_hook_usage, builtin_hook_options);
+
+	if (!strcmp(argv[1], "list"))
+		return list(argc - 1, argv + 1, prefix);
+
+	usage_with_options(builtin_hook_usage, builtin_hook_options);
+}
diff --git a/hook.c b/hook.c
new file mode 100644
index 0000000000..fede40e925
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,120 @@
+#include "cache.h"
+
+#include "hook.h"
+#include "config.h"
+
+void free_hook(struct hook *ptr)
+{
+	if (ptr) {
+		strbuf_release(&ptr->command);
+		free(ptr);
+	}
+}
+
+static void append_or_move_hook(struct list_head *head, const char *command)
+{
+	struct list_head *pos = NULL, *tmp = NULL;
+	struct hook *to_add = NULL;
+
+	/*
+	 * remove the prior entry with this command; we'll replace it at the
+	 * end.
+	 */
+	list_for_each_safe(pos, tmp, head) {
+		struct hook *it = list_entry(pos, struct hook, list);
+		if (!strcmp(it->command.buf, command)) {
+		    list_del(pos);
+		    /* we'll simply move the hook to the end */
+		    to_add = it;
+		    break;
+		}
+	}
+
+	if (!to_add) {
+		/* adding a new hook, not moving an old one */
+		to_add = xmalloc(sizeof(*to_add));
+		strbuf_init(&to_add->command, 0);
+		strbuf_addstr(&to_add->command, command);
+	}
+
+	/* re-set the scope so we show where an override was specified */
+	to_add->origin = current_config_scope();
+
+	list_add_tail(&to_add->list, head);
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
+struct hook_config_cb
+{
+	struct strbuf *hookname;
+	struct list_head *list;
+};
+
+static int hook_config_lookup(const char *key, const char *value, void *cb_data)
+{
+	struct hook_config_cb *data = cb_data;
+	const char *hook_key = data->hookname->buf;
+	struct list_head *head = data->list;
+
+	if (!strcmp(key, hook_key)) {
+		const char *command = value;
+		struct strbuf hookcmd_name = STRBUF_INIT;
+
+		/*
+		 * Check if a hookcmd with that name exists. If it doesn't,
+		 * 'git_config_get_value()' is documented not to touch &command,
+		 * so we don't need to do anything.
+		 */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+		git_config_get_value(hookcmd_name.buf, &command);
+
+		if (!command) {
+			strbuf_release(&hookcmd_name);
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+		}
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+
+		append_or_move_hook(head, command);
+
+		strbuf_release(&hookcmd_name);
+	}
+
+	return 0;
+}
+
+struct list_head* hook_list(const struct strbuf* hookname)
+{
+	struct strbuf hook_key = STRBUF_INIT;
+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+	struct hook_config_cb cb_data = { &hook_key, hook_head };
+
+	INIT_LIST_HEAD(hook_head);
+
+	if (!hookname)
+		return NULL;
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
+
+	git_config(hook_config_lookup, &cb_data);
+
+	strbuf_release(&hook_key);
+	return hook_head;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..e48dfc6d27
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,25 @@
+#include "config.h"
+#include "list.h"
+#include "strbuf.h"
+
+struct hook {
+	struct list_head list;
+	/*
+	 * Config file which holds the hook.*.command definition.
+	 * (This has nothing to do with the hookcmd.<name>.* configs.)
+	 */
+	enum config_scope origin;
+	/* The literal command to run. */
+	struct strbuf command;
+};
+
+/*
+ * Provides a linked list of 'struct hook' detailing commands which should run
+ * in response to the 'hookname' event, in execution order.
+ */
+struct list_head* hook_list(const struct strbuf *hookname);
+
+/* Free memory associated with a 'struct hook' */
+void free_hook(struct hook *ptr);
+/* Empties the list at 'head', calling 'free_hook()' on each entry */
+void clear_hook_list(struct list_head *head);
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 34b0df5216..6e4a3e763f 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -4,8 +4,85 @@ test_description='config-managed multihooks, including git-hook command'
 
 . ./test-lib.sh
 
-test_expect_success 'git hook command does not crash' '
-	git hook
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
+setup_hookcmd () {
+	test_config hook.pre-commit.command "abc" --add
+	test_config_global hookcmd.abc.command "/path/abc" --add
+}
+
+test_expect_success 'git hook rejects commands without a mode' '
+	test_must_fail git hook pre-commit
+'
+
+
+test_expect_success 'git hook rejects commands without a hookname' '
+	test_must_fail git hook list
+'
+
+test_expect_success 'git hook runs outside of a repo' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	EOF
+
+	nongit git config --list --global &&
+
+	nongit git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	local: $ROOT/path/ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list dereferences a hookcmd' '
+	setup_hooks &&
+	setup_hookcmd &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	local: $ROOT/path/ghi
+	local: $ROOT/path/abc
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
+	local: $ROOT/path/ghi
+	local: $ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.31.0.rc2.261.g7f71774620-goog

