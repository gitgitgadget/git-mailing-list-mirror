Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317B21FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbcLAU0Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:16 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34253 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbcLAU0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:15 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so98605453pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNrGRyyUxxUuj6AUij9YAuA2ubpNzaCWNmHZAKpY8zw=;
        b=jPQ6rHLJi2+3DTOWNzEtxjMcB6WaCmRaS8jfNvwEd4FfMn+CWjMYuPGcRENKdhzTf/
         Zag8jcM6WdnFtnFoavatU+dlacR5pXzVXhDaJ1DH3w3DNJ/il4nV1Uu+tNZOzP2GSdps
         17qXP0dSubfzZrbLcZ1KcUFeyiQIBZFFPgv6N3ikv2eNnwX7wB9JhDXNrTlP3P+34pCe
         HQdyt/88obMzX/SRnxFiAF8ItlDMXvXgYoWohWX+qPrmA15Z/unjGjOxlLiZOPoqvyTE
         C036WZ66QVeAG6i3ASfm1fdHyCvo8TXdZksWJJulC2YuoSuf4Bk2D/5dat7zrsNDEaL3
         +JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNrGRyyUxxUuj6AUij9YAuA2ubpNzaCWNmHZAKpY8zw=;
        b=m1D0N/6WsHi2FhDKG+75xVgiZajZzN5ITnh+Z/IscgdmQZ2OIXbujEVgWNoaZEubsO
         YGd4DyMYIbEC4XPPSuhXJF79VkMK+OL19L0wynQgv2UMuJo5ICLByDt+WoFoU9S6/1BY
         kY96ULBA5qpCMo0QqP7AdqEOkvJMZ1B+6GjyPtnnFLdV7RKx4Fpf848tzhqFbSh7qtsD
         CSmqdUYJ6OFuqc1C5s0svlNMzNl5e+ExI3wgDwozPzrwjgvkuRyMQDSlHm+R4xRLdhvG
         pufKt6evo/C5xMYEuxh0MMVIiA2w17efcnBPoOhBmPeMIc2MAS2zYiPs7Ikq0dN6yyHA
         83tw==
X-Gm-Message-State: AKaTC020dXel/pWhKPrCd2LjqVdMFcvxGNOqXSHEaBXL8ApUz5AomXd9G/LbJ+0uicmelZu8
X-Received: by 10.98.25.205 with SMTP id 196mr41357015pfz.46.1480623974385;
        Thu, 01 Dec 2016 12:26:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:18d1:181b:bbf2:e96f])
        by smtp.gmail.com with ESMTPSA id h7sm2198551pgn.13.2016.12.01.12.26.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/5] submodule: add embed-git-dir function
Date:   Thu,  1 Dec 2016 12:25:54 -0800
Message-Id: <20161201202554.19944-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
In-Reply-To: <20161201202554.19944-1-sbeller@google.com>
References: <20161201202554.19944-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule has its git dir inside the working dir, the submodule
support for checkout that we plan to add in a later patch will fail.

Add functionality to migrate the git directory to be embedded
into the superprojects git directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt   | 14 ++++++
 builtin/submodule--helper.c       | 39 ++++++++++++++++-
 dir.c                             | 78 +++++++++++++++++++++++++++++++++
 dir.h                             |  4 ++
 git-submodule.sh                  |  7 ++-
 submodule.h                       |  1 -
 t/t7412-submodule-embedgitdirs.sh | 92 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100755 t/t7412-submodule-embedgitdirs.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d841573475..34791cfc65 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
+'git submodule' [--quiet] embedgitdirs [--] [<path>...]
 
 
 DESCRIPTION
@@ -245,6 +246,19 @@ sync::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
+embedgitdirs::
+	Move the git directory of submodules into its superprojects
+	`$GIT_DIR/modules` path and then connect the git directory and
+	its working directory by setting the `core.worktree` and adding
+	a .git file pointing to the git directory interned into the
+	superproject.
++
+A repository that was cloned independently and later added as a submodule or
+old setups have the submodules git directory inside the submodule instead of
+embedded into the superprojects git directory.
++
+This command is recursive by default.
+
 OPTIONS
 -------
 -q::
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 806e29ce4e..f2df166d15 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,42 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static int embed_git_dir(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	unsigned flags = RELOCATE_GITDIR_RECURSE_SUBMODULES;
+
+	struct option embed_gitdir_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_BIT(0, "--recursive", &flags, N_("recurse into submodules"),
+			RELOCATE_GITDIR_RECURSE_SUBMODULES),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper embed-git-dir [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
+			     git_submodule_helper_usage, 0);
+
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	for (i = 0; i < list.nr; i++)
+		relocate_gitdir(prefix, list.entries[i]->name, flags);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1093,7 +1129,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, 0},
-	{"remote-branch", resolve_remote_submodule_branch, 0}
+	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/dir.c b/dir.c
index bfa8c8a9a5..7b3abc1340 100644
--- a/dir.c
+++ b/dir.c
@@ -15,6 +15,9 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
+#include "submodule-config.h"
+#include "run-command.h"
+#include "worktree.h"
 
 struct path_simplify {
 	int len;
@@ -2748,3 +2751,78 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/*
+ * Migrate the given submodule (and all its submodules recursively) from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void relocate_gitdir(const char *prefix, const char *path, unsigned flags)
+{
+	char *old_git_dir;
+	const char *new_git_dir;
+	const struct submodule *sub;
+	struct worktree **worktrees;
+	int i;
+
+	worktrees = get_submodule_worktrees(path);
+	for (i = 0; worktrees[i]; i++)
+		;
+	if (i > 1)
+		die(_("relocate_gitdir for submodule with more than one worktree not supported"));
+
+	old_git_dir = xstrfmt("%s/.git", path);
+	if (read_gitfile(old_git_dir))
+		/* If it is an actual gitfile, it doesn't need migration. */
+		goto out;
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub)
+		die(_("Could not lookup name for submodule '%s'"),
+		      path);
+
+	new_git_dir = git_path("modules/%s", sub->name);
+	if (safe_create_leading_directories_const(new_git_dir) < 0)
+		die(_("could not create directory '%s'"), new_git_dir);
+
+	if (!prefix)
+		prefix = get_super_prefix();
+	printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
+		prefix ? prefix : "", path,
+		real_path(old_git_dir), new_git_dir);
+
+	if (rename(old_git_dir, new_git_dir) < 0)
+		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+
+	connect_work_tree_and_git_dir(path, new_git_dir);
+
+out:
+	if (flags & RELOCATE_GITDIR_RECURSE_SUBMODULES) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (flags & ~RELOCATE_GITDIR_RECURSE_SUBMODULES)
+			die("BUG: we don't know how to pass the flags down?");
+
+		if (get_super_prefix())
+			strbuf_addstr(&sb, get_super_prefix());
+		strbuf_addstr(&sb, path);
+		strbuf_addch(&sb, '/');
+
+		cp.dir = path;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
+					    "submodule--helper",
+					   "embed-git-dirs", NULL);
+		prepare_submodule_repo_env(&cp.env_array);
+		if (run_command(&cp))
+			die(_("Could not migrate git directory in submodule '%s'"),
+			    path);
+
+		strbuf_release(&sb);
+	}
+
+	free(old_git_dir);
+}
diff --git a/dir.h b/dir.h
index 97c83bb383..0b5e99b21d 100644
--- a/dir.h
+++ b/dir.h
@@ -335,4 +335,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+
+#define RELOCATE_GITDIR_RECURSE_SUBMODULES (1<<0)
+extern void relocate_gitdir(const char *prefix, const char *path, unsigned flags);
+
 #endif
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a135d6..b7e124f340 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1131,6 +1131,11 @@ cmd_sync()
 	done
 }
 
+cmd_embedgitdirs()
+{
+	git submodule--helper embed-git-dirs --prefix "$wt_prefix" "$@"
+}
+
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -1140,7 +1145,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync)
+	add | foreach | init | deinit | update | status | summary | sync | embedgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/submodule.h b/submodule.h
index d9e197a948..1e42222cff 100644
--- a/submodule.h
+++ b/submodule.h
@@ -74,5 +74,4 @@ int parallel_submodules(void);
  * retaining any config in the environment.
  */
 void prepare_submodule_repo_env(struct argv_array *out);
-
 #endif
diff --git a/t/t7412-submodule-embedgitdirs.sh b/t/t7412-submodule-embedgitdirs.sh
new file mode 100755
index 0000000000..e3443b88cd
--- /dev/null
+++ b/t/t7412-submodule-embedgitdirs.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='Test submodule embedgitdirs
+
+This test verifies that `git submodue embedgitdirs` moves a submodules git
+directory into the superproject.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a real submodule' '
+	git init sub1 &&
+	test_commit -C sub1 first &&
+	git submodule add ./sub1 &&
+	test_tick &&
+	git commit -m superproject
+'
+
+test_expect_success 'embed the git dir' '
+	>expect.1 &&
+	>expect.2 &&
+	>actual.1 &&
+	>actual.2 &&
+	git status >expect.1 &&
+	git -C sub1 rev-parse HEAD >expect.2 &&
+	git submodule embedgitdirs &&
+	git fsck &&
+	test -f sub1/.git &&
+	test -d .git/modules/sub1 &&
+	git status >actual.1 &&
+	git -C sub1 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup nested submodule' '
+	git init sub1/nested &&
+	test_commit -C sub1/nested first_nested &&
+	git -C sub1 submodule add ./nested &&
+	test_tick &&
+	git -C sub1 commit -m "add nested" &&
+	git add sub1 &&
+	git commit -m "sub1 to include nested submodule"
+'
+
+test_expect_success 'embed the git dir in a nested submodule' '
+	git status >expect.1 &&
+	git -C sub1/nested rev-parse HEAD >expect.2 &&
+	git submodule embedgitdirs &&
+	test -f sub1/nested/.git &&
+	test -d .git/modules/sub1/modules/nested &&
+	git status >actual.1 &&
+	git -C sub1/nested rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup a gitlink with missing .gitmodules entry' '
+	git init sub2 &&
+	test_commit -C sub2 first &&
+	git add sub2 &&
+	git commit -m superproject
+'
+
+test_expect_success 'embedding the git dir fails for incomplete submodules' '
+	git status >expect.1 &&
+	git -C sub2 rev-parse HEAD >expect.2 &&
+	test_must_fail git submodule embedgitdirs &&
+	git -C sub2 fsck &&
+	test -d sub2/.git &&
+	git status >actual &&
+	git -C sub2 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup a submodule with multiple worktrees' '
+	# first create another unembedded git dir in a new submodule
+	git init sub3 &&
+	test_commit -C sub3 first &&
+	git submodule add ./sub3 &&
+	test_tick &&
+	git commit -m "add another submodule" &&
+	git -C sub3 worktree add ../sub3_second_work_tree
+'
+
+test_expect_success 'embed a submodule with multiple worktrees' '
+	test_must_fail git submodule embedgitdirs sub3 2>error &&
+	test_i18ngrep "not supported" error
+'
+
+test_done
-- 
2.10.2.613.g22f2156

