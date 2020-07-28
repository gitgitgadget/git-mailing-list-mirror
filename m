Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19AC433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339672070B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 22:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojzcYbOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgG1WZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgG1WZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 18:25:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A7C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:08 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f4so12934407plo.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XPJDYrzEHgkpMeXkN26sTR/pLc7HrnLfTcwEgSVPND4=;
        b=ojzcYbOzXWgt+s6n/al1k9Rl6JyLt7yeOGchnzrkjt6Fd6g5vf0xYW/Gc+lBCycQNP
         WmqDn5l8fVGZnmLtiuqOarNyWjRVbmTzumvoUJD4MnEgwmHODa0OGuFt9/rJTA6zFD46
         rLet0IuOPA3mthKmiOscwhKypz13RPpd+nVRCFnrf1Y/5yJidoRIyZwelNa7lC7ZbkJl
         sa0EH575uaJ0tTe1f1EItTEayN9FuFXVWI7yslgmJotiKCqQIHg2k/DeBSJGR6RR10Og
         2u66X0RcLfbo6YFRTP+DM/AE8yr6Mm6HMAvnuTaSMzn3I/Xi6AUaRLsYqe9ADMSlI8OP
         cLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XPJDYrzEHgkpMeXkN26sTR/pLc7HrnLfTcwEgSVPND4=;
        b=XLKUoqS2P26cSmzfQqMeeqEFjDEtU2vvclCXkGqoy16doMex2O3KYyIEZVpFF0pnCn
         iFPwE5xbEsUoFx3OokhBHthXgXMSZkTaGrdiF4RXji/FVfZwUtoOfDEtDeT4xWueY+c+
         xpCBGZeW0fTDCzxWH/l81+i/7GrSKkYFrjQd2fvYtu7CsCCsco5W8a15v+7oVivVgMnL
         kT8h3gRsfT0Q283bfZUjHvzcJLxD9kqcvDk0XgXtKM3QYa8LA/iVOaQ+gsMc7J4t/5Cq
         ghYYcw425uR3B4PFrmjTGU+TSxExLe19br+n7tVCSG9+GNwioa8oPVIcuxA9j5R2tMOC
         JN6Q==
X-Gm-Message-State: AOAM530lVU38QBioAxc6VjZd/5gIvpeBbOQdEMZVfk4pWoYYUnI19CUk
        802zdgO0/W7JmgLngpQgjbNdUFTgekIIXGpYmvo+C+nDllUEvgStJxMWr95aySfSJY/cHMV37PV
        dcph43apUtsvClo8kXkj+HMSkfORaCG89ESpV4IjvhD/53RirR3MsDTQiRg8Uh51f7bHuPHPAsw
        ==
X-Google-Smtp-Source: ABdhPJydsogVcn2x2XuSQM9G+2BxCCJoUI+waYe79OuCH+qDjS/VxGWMHceW93ivGHuEcgUNylSac7VFlzerwdyhvsA=
X-Received: by 2002:a63:ac53:: with SMTP id z19mr25718299pgn.181.1595975108058;
 Tue, 28 Jul 2020 15:25:08 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:24:52 -0700
In-Reply-To: <20200728222455.3023400-1-emilyshaffer@google.com>
Message-Id: <20200728222455.3023400-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200728222455.3023400-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v3 3/6] hook: add list command
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
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
<hookcmd-name>]" subsection; at minimum, this subsection must contain a
"hookcmd.<hookcmd-name>.command = <path-to-hook>" line.

For example:

  $ git config --list | grep ^hook
  hook.pre-commit.command=baz
  hook.pre-commit.command=~/bar.sh
  hookcmd.baz.command=~/baz/from/hookcmd.sh

  $ git hook list pre-commit
  ~/baz/from/hookcmd.sh
  ~/bar.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 37 +++++++++++++-
 Makefile                      |  1 +
 builtin/hook.c                | 55 +++++++++++++++++++--
 hook.c                        | 90 +++++++++++++++++++++++++++++++++++
 hook.h                        | 15 ++++++
 t/t1360-config-based-hooks.sh | 68 +++++++++++++++++++++++++-
 6 files changed, 259 insertions(+), 7 deletions(-)
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 2d50c414cc..e458586e96 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,12 +8,47 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook'
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
 You can list, add, and modify hooks with this command.
 
+This command parses the default configuration files for sections "hook" and
+"hookcmd". "hook" is used to describe the commands which will be run during a
+particular hook event; commands are run in config order. "hookcmd" is used to
+describe attributes of a specific command. If additional attributes don't need
+to be specified, a command to run can be specified directly in the "hook"
+section; if a "hookcmd" by that name isn't found, Git will attempt to run the
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
+COMMANDS
+--------
+
+list <hook-name>::
+
+List the hooks which have been configured for <hook-name>. Hooks appear
+in the order they should be run, and note the config scope where the relevant
+`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index e13e58e23f..50e7c911d1 100644
--- a/Makefile
+++ b/Makefile
@@ -891,6 +891,7 @@ LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += interdiff.o
 LIB_OBJS += json-writer.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..a0759a4c26 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,21 +1,68 @@
 #include "cache.h"
 
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
+	struct hook *item;
+	struct strbuf hookname = STRBUF_INIT;
+
+	struct option list_options[] = {
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+	argc = parse_options(argc, argv, prefix, list_options,
 			     builtin_hook_usage, 0);
 
+	if (argc < 1) {
+		usage_msg_opt("a hookname must be provided to operate on.",
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
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s:\t%s\n",
+			       config_scope_name(item->origin),
+			       item->command.buf);
+	}
+
+	clear_hook_list();
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
index 0000000000..9dfc1a885e
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,90 @@
+#include "cache.h"
+
+#include "hook.h"
+#include "config.h"
+
+static LIST_HEAD(hook_head);
+
+void free_hook(struct hook *ptr)
+{
+	if (ptr) {
+		strbuf_release(&ptr->command);
+		free(ptr);
+	}
+}
+
+static void emplace_hook(struct list_head *pos, const char *command)
+{
+	struct hook *to_add = malloc(sizeof(struct hook));
+	to_add->origin = current_config_scope();
+	strbuf_init(&to_add->command, 0);
+	strbuf_addstr(&to_add->command, command);
+
+	list_add_tail(&to_add->list, pos);
+}
+
+static void remove_hook(struct list_head *to_remove)
+{
+	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
+	list_del(to_remove);
+	free_hook(hook_to_remove);
+}
+
+void clear_hook_list(void)
+{
+	struct list_head *pos, *tmp;
+	list_for_each_safe(pos, tmp, &hook_head)
+		remove_hook(pos);
+}
+
+static int hook_config_lookup(const char *key, const char *value, void *hook_key_cb)
+{
+	const char *hook_key = hook_key_cb;
+
+	if (!strcmp(key, hook_key)) {
+		const char *command = value;
+		struct strbuf hookcmd_name = STRBUF_INIT;
+		struct list_head *pos = NULL, *tmp = NULL;
+
+		/* Check if a hookcmd with that name exists. */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+		git_config_get_value(hookcmd_name.buf, &command);
+
+		if (!command)
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+
+		list_for_each_safe(pos, tmp, &hook_head) {
+			struct hook *hook = list_entry(pos, struct hook, list);
+			/*
+			 * The list of hooks to run can be reordered by being redeclared
+			 * in the config. Options about hook ordering should be checked
+			 * here.
+			 */
+			if (0 == strcmp(hook->command.buf, command))
+				remove_hook(pos);
+		}
+		emplace_hook(pos, command);
+	}
+
+	return 0;
+}
+
+struct list_head* hook_list(const struct strbuf* hookname)
+{
+	struct strbuf hook_key = STRBUF_INIT;
+
+	if (!hookname)
+		return NULL;
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
+
+	git_config(hook_config_lookup, (void*)hook_key.buf);
+
+	return &hook_head;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..aaf6511cff
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,15 @@
+#include "config.h"
+#include "list.h"
+#include "strbuf.h"
+
+struct hook
+{
+	struct list_head list;
+	enum config_scope origin;
+	struct strbuf command;
+};
+
+struct list_head* hook_list(const struct strbuf *hookname);
+
+void free_hook(struct hook *ptr);
+void clear_hook_list(void);
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 34b0df5216..46d1ed354a 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -4,8 +4,72 @@ test_description='config-managed multihooks, including git-hook command'
 
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
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global:	$ROOT/path/def
+	local:	$ROOT/path/ghi
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
+	global:	$ROOT/path/def
+	local:	$ROOT/path/ghi
+	local:	$ROOT/path/abc
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
+	local:	$ROOT/path/ghi
+	local:	$ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

