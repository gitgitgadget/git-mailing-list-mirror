Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 03:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhLVD7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 22:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhLVD7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132EC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v11so2019627wrw.10
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMmF9fUdedGgO4FOG3wSI6SFr0fNxZC/yGyg3KgC/GE=;
        b=PMIq45x+LQ9XG2gxH4iRoieGu6hsUyJAdmUM3VjPXX7eXFex/2rn8BJA1/lP9h3SFr
         IxO0vs53RTdh7iWlk0RDkSd/1zL+gH23BNB+841mnkMCRpg69OH8d4+857fUnC49ZEad
         6v8JzdVQMWdaNjn87lCKQuliZjqu6n6mZbP0r3KNI+445vVRBkVB9BjWG3O0hQ74mC2B
         I0JbAb6BVRWTS3+7JtaWDmC8qVSLGrX+os4zlbsd8SSbBwza5ZH371CAOtSyw1VOgtsu
         yjYoPUG41imG0MUJV0IMvNarF63AEXIMIY7rdY31D8Qe5qPBRzHoqbqak1k84yOiPjJW
         sUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMmF9fUdedGgO4FOG3wSI6SFr0fNxZC/yGyg3KgC/GE=;
        b=UYKVoYUQK1EGCTU5K9JCu88HWm5zN49g1zRfqc+yjxoq6e2qI2Uzc+hTDTFnpCtkhF
         x1J9qKJCUFpcEDXJ2+dhaxPohcwWzTz3tBZePVCbPg4Pb796pxlVND6unwyR2c+CJz2O
         7mMQUn0RhLx3rLR3nNWnvee43B3WJ2t5q6ghVJR9IG+V2X/ES3qVSGqNUTuMRPByPaNP
         k0Qz9X26E/nsRUmsOA8e2+X+r8BF3+Hk4bfOKGByoe3cWbG6ubINP3TY4Yi9FRv9f5jF
         P4G4lujvSebuoPrZBIJ4V3nHCALP48cl/IL9cAbN4dfTmBNJl+ZaHalnqJF0orACksWx
         z4Ag==
X-Gm-Message-State: AOAM530O0stU1oKRayH9oy2amHTWzfRGIeZWrzFb2eAbMXF/LaJhsOev
        ukrnr0UdXTj5sLf76dXLQYBptULnwu12wg==
X-Google-Smtp-Source: ABdhPJy8RtmztE1Q6H/M9fnercyyuZ1cOduhd9xIkiebExHmGDupMcS9ygaSgGLI8/lwx/PwwN4KOA==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr727646wrn.378.1640145586958;
        Tue, 21 Dec 2021 19:59:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/17] hook: add 'run' subcommand
Date:   Wed, 22 Dec 2021 04:59:27 +0100
Message-Id: <patch-v6-01.17-ba6fd47482e-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

In order to enable hooks to be run as an external process, by a
standalone Git command, or by tools which wrap Git, provide an external
means to run all configured hook commands for a given hook event.

Most of our hooks require more complex functionality than this, but
let's start with the bare minimum required to support our simplest
hooks.

In terms of implementation the usage_with_options() and "goto usage"
pattern here mirrors that of
builtin/{commit-graph,multi-pack-index}.c.

Some of the implementation here, such as a function being named
run_hooks_opt() when it's tasked with running one hook, to using the
run_processes_parallel_tr2() API to run with jobs=1 is somewhere
between a bit odd and and an overkill for the current features of this
"hook run" command and the hook.[ch] API.

This code will eventually be able to run multiple hooks declared in
config in parallel, by starting out with these names and APIs we
reduce the later churn of renaming functions, switching from the
run_command() to run_processes_parallel_tr2() API etc.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                 |   1 +
 Documentation/git-hook.txt |  37 +++++++++++
 Documentation/githooks.txt |   4 ++
 Makefile                   |   1 +
 builtin.h                  |   1 +
 builtin/hook.c             |  80 +++++++++++++++++++++++
 command-list.txt           |   1 +
 git.c                      |   1 +
 hook.c                     | 102 +++++++++++++++++++++++++++++
 hook.h                     |  35 ++++++++++
 t/t1800-hook.sh            | 129 +++++++++++++++++++++++++++++++++++++
 11 files changed, 392 insertions(+)
 create mode 100644 Documentation/git-hook.txt
 create mode 100644 builtin/hook.c
 create mode 100755 t/t1800-hook.sh

diff --git a/.gitignore b/.gitignore
index 054249b20a8..f817c509ec0 100644
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
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
new file mode 100644
index 00000000000..e39b1b5d069
--- /dev/null
+++ b/Documentation/git-hook.txt
@@ -0,0 +1,37 @@
+git-hook(1)
+===========
+
+NAME
+----
+git-hook - Run git hooks
+
+SYNOPSIS
+--------
+[verse]
+'git hook' run <hook-name> [-- <hook-args>]
+
+DESCRIPTION
+-----------
+
+A command interface to running git hooks (see linkgit:githooks[5]),
+for use by other scripted git commands.
+
+SUBCOMMANDS
+-----------
+
+run::
+	Run the `<hook-name>` hook. See linkgit:githooks[5] for
+	supported hook names.
++
+
+Any positional arguments to the hook should be passed after a
+mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
+linkgit:githooks[5] for arguments hooks might expect (if any).
+
+SEE ALSO
+--------
+linkgit:githooks[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff941..a16e62bc8c8 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -698,6 +698,10 @@ and "0" meaning they were not.
 Only one parameter should be set to "1" when the hook runs.  The hook
 running passing "1", "1" should not be possible.
 
+SEE ALSO
+--------
+linkgit:git-hook[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 75ed168adbc..9a3cbc8c414 100644
--- a/Makefile
+++ b/Makefile
@@ -1109,6 +1109,7 @@ BUILTIN_OBJS += builtin/get-tar-commit-id.o
 BUILTIN_OBJS += builtin/grep.o
 BUILTIN_OBJS += builtin/hash-object.o
 BUILTIN_OBJS += builtin/help.o
+BUILTIN_OBJS += builtin/hook.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
diff --git a/builtin.h b/builtin.h
index 8a58743ed63..83379f3832c 100644
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
index 00000000000..9b67ff50cef
--- /dev/null
+++ b/builtin/hook.c
@@ -0,0 +1,80 @@
+#include "cache.h"
+#include "builtin.h"
+#include "config.h"
+#include "hook.h"
+#include "parse-options.h"
+#include "strbuf.h"
+#include "strvec.h"
+
+#define BUILTIN_HOOK_RUN_USAGE \
+	N_("git hook run <hook-name> [-- <hook-args>]")
+
+static const char * const builtin_hook_usage[] = {
+	BUILTIN_HOOK_RUN_USAGE,
+	NULL
+};
+
+static const char * const builtin_hook_run_usage[] = {
+	BUILTIN_HOOK_RUN_USAGE,
+	NULL
+};
+
+static int run(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	const char *hook_name;
+	struct option run_options[] = {
+		OPT_END(),
+	};
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, run_options,
+			     builtin_hook_run_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (!argc)
+		goto usage;
+
+	/*
+	 * Having a -- for "run" when providing <hook-args> is
+	 * mandatory.
+	 */
+	if (argc > 1 && strcmp(argv[1], "--") &&
+	    strcmp(argv[1], "--end-of-options"))
+		goto usage;
+
+	/* Add our arguments, start after -- */
+	for (i = 2 ; i < argc; i++)
+		strvec_push(&opt.args, argv[i]);
+
+	/* Need to take into account core.hooksPath */
+	git_config(git_default_config, NULL);
+
+	hook_name = argv[0];
+	opt.error_if_missing = 1;
+	ret = run_hooks_opt(hook_name, &opt);
+	if (ret < 0) /* error() return */
+		ret = 1;
+	return ret;
+usage:
+	usage_with_options(builtin_hook_run_usage, run_options);
+}
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL, builtin_hook_options,
+			     builtin_hook_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc)
+		goto usage;
+
+	if (!strcmp(argv[0], "run"))
+		return run(argc, argv, prefix);
+
+usage:
+	usage_with_options(builtin_hook_usage, builtin_hook_options);
+}
diff --git a/command-list.txt b/command-list.txt
index 675c28f0bd0..9bd6f3c48f4 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -103,6 +103,7 @@ git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          complete
+git-hook                                purehelpers
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
diff --git a/git.c b/git.c
index 7edafd8ecff..7030f1180b3 100644
--- a/git.c
+++ b/git.c
@@ -541,6 +541,7 @@ static struct cmd_struct commands[] = {
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
+	{ "hook", cmd_hook, RUN_SETUP },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
diff --git a/hook.c b/hook.c
index 55e1145a4b7..a0917cf877c 100644
--- a/hook.c
+++ b/hook.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "hook.h"
 #include "run-command.h"
+#include "config.h"
 
 const char *find_hook(const char *name)
 {
@@ -40,3 +41,104 @@ int hook_exists(const char *name)
 {
 	return !!find_hook(name);
 }
+
+static int pick_next_hook(struct child_process *cp,
+			  struct strbuf *out,
+			  void *pp_cb,
+			  void **pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	const char *hook_path = hook_cb->hook_path;
+
+	if (!hook_path)
+		return 0;
+
+	cp->no_stdin = 1;
+	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
+	cp->stdout_to_stderr = 1;
+	cp->trace2_hook_name = hook_cb->hook_name;
+
+	strvec_push(&cp->args, hook_path);
+	strvec_pushv(&cp->args, hook_cb->options->args.v);
+
+	/* Provide context for errors if necessary */
+	*pp_task_cb = (char *)hook_path;
+
+	/*
+	 * This pick_next_hook() will be called again, we're only
+	 * running one hook, so indicate that no more work will be
+	 * done.
+	 */
+	hook_cb->hook_path = NULL;
+
+	return 1;
+}
+
+static int notify_start_failure(struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cp)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	const char *hook_path = pp_task_cp;
+
+	hook_cb->rc |= 1;
+
+	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
+		    hook_path);
+
+	return 1;
+}
+
+static int notify_hook_finished(int result,
+				struct strbuf *out,
+				void *pp_cb,
+				void *pp_task_cb)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+
+	hook_cb->rc |= result;
+
+	return 0;
+}
+
+static void run_hooks_opt_clear(struct run_hooks_opt *options)
+{
+	strvec_clear(&options->env);
+	strvec_clear(&options->args);
+}
+
+int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
+{
+	struct hook_cb_data cb_data = {
+		.rc = 0,
+		.hook_name = hook_name,
+		.options = options,
+	};
+	const char *const hook_path = find_hook(hook_name);
+	int jobs = 1;
+	int ret = 0;
+
+	if (!options)
+		BUG("a struct run_hooks_opt must be provided to run_hooks");
+
+	if (!hook_path && !options->error_if_missing)
+		goto cleanup;
+
+	if (!hook_path) {
+		ret = error("cannot find a hook named %s", hook_name);
+		goto cleanup;
+	}
+
+	cb_data.hook_path = hook_path;
+	run_processes_parallel_tr2(jobs,
+				   pick_next_hook,
+				   notify_start_failure,
+				   notify_hook_finished,
+				   &cb_data,
+				   "hook",
+				   hook_name);
+	ret = cb_data.rc;
+cleanup:
+	run_hooks_opt_clear(options);
+	return ret;
+}
diff --git a/hook.h b/hook.h
index 6aa36fc7ff9..782385cc235 100644
--- a/hook.h
+++ b/hook.h
@@ -1,5 +1,31 @@
 #ifndef HOOK_H
 #define HOOK_H
+#include "strvec.h"
+
+struct run_hooks_opt
+{
+	/* Environment vars to be set for each hook */
+	struct strvec env;
+
+	/* Args to be passed to each hook */
+	struct strvec args;
+
+	/* Emit an error if the hook is missing */
+	unsigned int error_if_missing:1;
+};
+
+#define RUN_HOOKS_OPT_INIT { \
+	.env = STRVEC_INIT, \
+	.args = STRVEC_INIT, \
+}
+
+struct hook_cb_data {
+	/* rc reflects the cumulative failure state */
+	int rc;
+	const char *hook_name;
+	const char *hook_path;
+	struct run_hooks_opt *options;
+};
 
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
@@ -13,4 +39,13 @@ const char *find_hook(const char *name);
  */
 int hook_exists(const char *hookname);
 
+/**
+ * Takes a `hook_name`, resolves it to a path with find_hook(), and
+ * runs the hook for you with the options specified in "struct
+ * run_hooks opt". Will free memory associated with the "struct run_hooks_opt".
+ *
+ * Returns the status code of the run hook, or a negative value on
+ * error().
+ */
+int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options);
 #endif
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
new file mode 100755
index 00000000000..3aea1b105f0
--- /dev/null
+++ b/t/t1800-hook.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='git-hook command'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'git hook usage' '
+	test_expect_code 129 git hook &&
+	test_expect_code 129 git hook run &&
+	test_expect_code 129 git hook run -h &&
+	test_expect_code 129 git hook run --unknown 2>err &&
+	grep "unknown option" err
+'
+
+test_expect_success 'git hook run: nonexistent hook' '
+	cat >stderr.expect <<-\EOF &&
+	error: cannot find a hook named test-hook
+	EOF
+	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual
+'
+
+test_expect_success 'git hook run: basic' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
+	cat >expect <<-\EOF &&
+	Test hook
+	EOF
+	git hook run test-hook 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git hook run: stdout and stderr both write to our stderr' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo >&1 Will end up on stderr
+	echo >&2 Will end up on stderr
+	EOF
+
+	cat >stderr.expect <<-\EOF &&
+	Will end up on stderr
+	Will end up on stderr
+	EOF
+	git hook run test-hook >stdout.actual 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual &&
+	test_must_be_empty stdout.actual
+'
+
+test_expect_success 'git hook run: exit codes are passed along' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 1
+	EOF
+
+	test_expect_code 1 git hook run test-hook &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 2
+	EOF
+
+	test_expect_code 2 git hook run test-hook &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 128
+	EOF
+
+	test_expect_code 128 git hook run test-hook &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	exit 129
+	EOF
+
+	test_expect_code 129 git hook run test-hook
+'
+
+test_expect_success 'git hook run arg u ments without -- is not allowed' '
+	test_expect_code 129 git hook run test-hook arg u ments
+'
+
+test_expect_success 'git hook run -- pass arguments' '
+	write_script .git/hooks/test-hook <<-\EOF &&
+	echo $1
+	echo $2
+	EOF
+
+	cat >expect <<-EOF &&
+	arg
+	u ments
+	EOF
+
+	git hook run test-hook -- arg "u ments" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git hook run -- out-of-repo runs excluded' '
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo Test hook
+	EOF
+
+	nongit test_must_fail git hook run test-hook
+'
+
+test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
+	mkdir my-hooks &&
+	write_script my-hooks/test-hook <<-\EOF &&
+	echo Hook ran $1 >>actual
+	EOF
+
+	cat >expect <<-\EOF &&
+	Test hook
+	Hook ran one
+	Hook ran two
+	Hook ran three
+	Hook ran four
+	EOF
+
+	# Test various ways of specifying the path. See also
+	# t1350-config-hooks-path.sh
+	>actual &&
+	git hook run test-hook -- ignored 2>>actual &&
+	git -c core.hooksPath=my-hooks hook run test-hook -- one 2>>actual &&
+	git -c core.hooksPath=my-hooks/ hook run test-hook -- two 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks" hook run test-hook -- three 2>>actual &&
+	git -c core.hooksPath="$PWD/my-hooks/" hook run test-hook -- four 2>>actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.34.1.1146.gb52885e7c44

