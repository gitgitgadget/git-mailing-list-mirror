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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A6C47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622CE613CA
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhE0AKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhE0AKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:39 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A04FC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:06 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id z2-20020a3765020000b02903a5f51b1c74so2094516qkb.7
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XRTBZT1WjPz6Hih0Jb6m3QfLt0YoXU8k1EGrJ0ZUBSw=;
        b=LcLWjnD7ylPU+fxto5OQenZEZbH+VLDiIwm6MKYJTTT+Mbeq27AXayc7lyZSrsLwhB
         5C3PAoNhLXJLGxXKCy9zN0t6mBdEWLPUS2YyliIrVWG1+JR7TciXoxZZnVBaBS8YrmYu
         SmL4/3TVHSK5vjIKlhva5/OrWHM0LFIu+y+T4Tqo0uqtj26SPIaDSKoGGNgI5BryzVdE
         fyjV1VRlI8LhG66YOS5xjgpq4qUZ0b7rrlVJiD+AwvRmwJ1iOCGpUuhp9+yeq6psAHhx
         nGmp7/UkEajK5mWzmx0Rno+gInDRn9HgvzMgLC6zbSujJOgoOz291MV31iMnicO+gNJn
         NOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XRTBZT1WjPz6Hih0Jb6m3QfLt0YoXU8k1EGrJ0ZUBSw=;
        b=jWyUCe06jwHw2gR2auBS5ROrNhY2/XDc9g6PJNcCE7Rs21a0CAkvUDGESbzV6+P5ZT
         L/cfe7aLnZEuBTY5dd60au8eTI604eJYkMKi/IAYtWzwtzngjETRnzhI1i/5VQxz8LXR
         ph1kQCCxtsF+UmofkAoSLoY2Ho/+LXTjl2/gGvudnVYYmVoGXihVZAVZoa11TM1BuDp/
         TIg7PCdGjIwXGQ3Dokg+SnfgW+gbXRUjYiQhkvIsxywFUDf7bu11oa1EyANK+/53ItzE
         BLCWoYGe8FLon9L7/9qFrfp0VuIdp3LR0Z1KaCgMbhBV0dBW81vsy4HAU/vHugk3D6bp
         sudA==
X-Gm-Message-State: AOAM532tgb2f7IcfJ34EN3etbub4NJZJzn+6YLZz6qYQArlIm62fiQ6j
        QWuXh72LOEkX0ZRQgd2UraLE4YPeXPJHGNytvvtbO/lNilKdll9LhKFUR15biOh1dSPRbVqUXhy
        3gfMBKIMXlZlNmxnnfXUq7b2ejb1+zQb0vLTmO5hwY6OBAdx6iNdS9MVYPbaHLnMCljdCKMNijQ
        ==
X-Google-Smtp-Source: ABdhPJz7xYtC93lj5pWVL8m1qYi2W6h6PDl3ZP2ukO4V4TeCCnipNwGSKB2Gk8hAijCtaC9uuaZhhsU+xW3uc6B7aaY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:d87:: with SMTP id
 e7mr515781qve.53.1622074145397; Wed, 26 May 2021 17:09:05 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:21 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 02/37] hook: introduce git-hook subcommand
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new subcommand, git-hook, which will be used to ease config-based
hook management. This command will handle parsing configs to compose a
list of hooks to run for a given event, as well as adding or modifying
hook configs in an interactive fashion.

Start with 'git hook list <hookname>', which checks the known configs in
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
    Since v4, mainly changed to RUN_SETUP_GENTLY so that 'git hook list' can
    be executed outside of a repo.

 .gitignore                    |   1 +
 Documentation/config/hook.txt |   9 +++
 Documentation/git-hook.txt    |  73 +++++++++++++++++++++
 Makefile                      |   2 +
 builtin.h                     |   1 +
 builtin/hook.c                |  65 ++++++++++++++++++
 command-list.txt              |   1 +
 git.c                         |   1 +
 hook.c                        | 120 ++++++++++++++++++++++++++++++++++
 hook.h                        |  25 +++++++
 t/t1360-config-based-hooks.sh |  88 +++++++++++++++++++++++++
 11 files changed, 386 insertions(+)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100644 hook.c
 create mode 100644 hook.h
 create mode 100755 t/t1360-config-based-hooks.sh

diff --git a/.gitignore b/.gitignore
index 311841f9be..de39dc9961 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@
 /git-grep
 /git-hash-object
 /git-help
+/git-hook
 /git-http-backend
 /git-http-fetch
 /git-http-push
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
new file mode 100644
index 0000000000..f19875ed68
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,73 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - Manage configured hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook' list <hook-name>
+
+DESCRIPTION
+-----------
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
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index c3565fc0f8..a6b71a0fbe 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,7 @@ LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
@@ -1101,6 +1102,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 16ecd5586f..91740c1514 100644
--- a/builtin.h
+++ b/builtin.h
@@ -164,6 +164,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 int cmd_grep(int argc, const char **argv, const char *prefix);
 int cmd_hash_object(int argc, const char **argv, const char *prefix);
 int cmd_help(int argc, const char **argv, const char *prefix);
+int cmd_hook(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
diff --git a/builtin/hook.c b/builtin/hook.c
new file mode 100644
index 0000000000..79e150437e
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,65 @@
+#include "cache.h"
+#include "builtin.h"
+#include "config.h"
+#include "hook.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static const char * const builtin_hook_usage[] = {
+	N_("git hook list <hookname>"),
+	NULL
+};
+
+static int list(int argc, const char **argv, const char *prefix)
+{
+	struct list_head *head, *pos;
+	const char *hookname = NULL;
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
+		if (item)
+			printf("%s: %s\n",
+			       config_scope_name(item->origin),
+			       item->command.buf);
+	}
+
+	clear_hook_list(head);
+
+	return 0;
+}
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
diff --git a/command-list.txt b/command-list.txt
index a289f09ed6..9ccd8e5aeb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-hook                                mainporcelain
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index 18bed9a996..39988ee3b0 100644
--- a/git.c
+++ b/git.c
@@ -538,6 +538,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
new file mode 100644
index 0000000000..d3e28aa73a
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
+struct list_head* hook_list(const char* hookname)
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
+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
+
+	git_config(hook_config_lookup, &cb_data);
+
+	strbuf_release(&hook_key);
+	return hook_head;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..042cab8446
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
+struct list_head* hook_list(const char *hookname);
+
+/* Free memory associated with a 'struct hook' */
+void free_hook(struct hook *ptr);
+/* Empties the list at 'head', calling 'free_hook()' on each entry */
+void clear_hook_list(struct list_head *head);
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
new file mode 100755
index 0000000000..6e4a3e763f
--- /dev/null
+++ b/t/t1360-config-based-hooks.sh
@@ -0,0 +1,88 @@
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
+'
+
+test_done
-- 
2.31.1.818.g46aad6cb9e-goog

