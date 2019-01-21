Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01321F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAUWcj (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:32:39 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50475 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfAUWcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:32:39 -0500
Received: by mail-qk1-f201.google.com with SMTP id x125so20165315qka.17
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QsBi1EbqBEhLSMwlcOMFqp+b+QJCQQLfD7+dRIa5TjI=;
        b=ZuvdTcUL3kJEmH+OY398NZX5wXwoD48SjAORNBdXYgMfa4LmrEItgfOX0bMNAj5XRg
         3YA8OL5q8/yZAaZhw8s0HVHLWKbs7BEOl/T31Mg370BIIzpyPMG6sXMpbo8jJ3zxYd48
         1UAPARhGGo/+3i4yrKye4rul5UFpF5q/4cNGRF1YUbf4+o8xfpTXxnpPCmhQ1VVR6vXu
         S7g+21X3I6y7lPqtTXIRUA2W8Xd1zfTjSf2ZsBooeTxPMR+xPUt8ink6dgdWeh6nSIV+
         Rm5Y5/xQMO5fWWWjmybOUk9SZ3ageMXaPoERtxhqFs9my+DlNW1NYSfHHqJcw8Td0m7z
         RJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QsBi1EbqBEhLSMwlcOMFqp+b+QJCQQLfD7+dRIa5TjI=;
        b=oBQK007agtNqzCig5AETQCVgz0RKD8Ki2kl3NDJ0spca6ge6zFuDzyI1SiSTz41bpL
         hmei1umqtquCkEytCL0Nb2O1yw9vK8ipYblKc9/XVV1kXBmDKB/YiYtJPlUohhIS4JnO
         hB80ugMuhYjmsI62pIVaIe7AJ4Mk6m7eE0lGV+61P7ZAgbBxa5taU7RcTLjomYTmpzsR
         1XWpWc73IsC1Mb0GNgxzUk2pp9g7aDJhV2pSolinTKxC4GIk9Psiwijh0n53TWcSiQ/6
         0NiXRLj24zEpCZBk0dQhT49X/R5OCHrHB4xIyvreUaSkS3CAOuWlpXA9X1CCFULAhv2U
         ZKMw==
X-Gm-Message-State: AJcUukdd3N8SsB1L2E1yS3zxupepYPQa2/Z3D5uG0/+heqgxv31WwsRb
        Rvsbhq3qimxH/yyyxO8IVpDdvVxQ0ehwMypnij83rQ4eoK5JzdyjPSrk54KfBNnoXMy+eBGxl7I
        Nt2o9YfjcxNbUuyVRu/rIfiz672MGf4EBWO/t6dJ5lRZNkvl10SvHMK0DJA==
X-Google-Smtp-Source: ALg8bN7JsQ8vwQ+qvKs74eoUZjn6MEzNeE1nlmOBep9xOLpVEmoMG2BZgPqN6UOBxlJUkbvBem5w38JeI9U=
X-Received: by 2002:ac8:17e6:: with SMTP id r35mr20891100qtk.45.1548109957725;
 Mon, 21 Jan 2019 14:32:37 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:32:15 -0800
In-Reply-To: <20190121223216.66659-1-sxenos@google.com>
Message-Id: <20190121223216.66659-7-sxenos@google.com>
Mime-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH 7/8] evolve: Implement the git change update command
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

Implement the git change update command, which
are sufficient for constructing change graphs.

For example, to create a new change (a stable name) that refers to HEAD:

git change update -c HEAD

To record a rebase or amend in the change graph:

git change update -c <new_commit> -r <old_commit>

To record a cherry-pick in the change graph:

git change update -c <new_commit> -o <original_commit>
---
 .gitignore       |   1 +
 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/change.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 5 files changed, 179 insertions(+)
 create mode 100644 builtin/change.c

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..8a084ac38b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@
 /git-branch
 /git-bundle
 /git-cat-file
+/git-change
 /git-check-attr
 /git-check-ignore
 /git-check-mailmap
diff --git a/Makefile b/Makefile
index a6be1780c5..d6fab30eca 100644
--- a/Makefile
+++ b/Makefile
@@ -1035,6 +1035,7 @@ BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
+BUILTIN_OBJS += builtin/change.o
 BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-mailmap.o
diff --git a/builtin.h b/builtin.h
index 6538932e99..d2d39d9da8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -137,6 +137,7 @@ extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
+extern int cmd_change(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
diff --git a/builtin/change.c b/builtin/change.c
new file mode 100644
index 0000000000..ff7eb3b113
--- /dev/null
+++ b/builtin/change.c
@@ -0,0 +1,175 @@
+#include "builtin.h"
+#include "ref-filter.h"
+#include "parse-options.h"
+#include "metacommit.h"
+#include "config.h"
+
+static const char * const builtin_change_usage[] = {
+	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
+	NULL
+};
+
+static const char * const builtin_update_usage[] = {
+	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
+	NULL
+};
+
+struct update_state {
+	int options;
+	const char* change;
+	const char* content;
+	struct string_list replace;
+	struct string_list origin;
+};
+
+static void init_update_state(struct update_state *state)
+{
+	memset(state, 0, sizeof(*state));
+	state->content = "HEAD";
+	string_list_init(&state->replace, 0);
+	string_list_init(&state->origin, 0);
+}
+
+static void clear_update_state(struct update_state *state)
+{
+	string_list_clear(&state->replace, 0);
+	string_list_clear(&state->origin, 0);
+}
+
+static int update_option_parse_replace(const struct option *opt,
+							const char *arg, int unset)
+{
+	struct update_state *state = opt->value;
+	string_list_append(&state->replace, arg);
+	return 0;
+}
+
+static int update_option_parse_origin(const struct option *opt,
+							const char *arg, int unset)
+{
+	struct update_state *state = opt->value;
+	string_list_append(&state->origin, arg);
+	return 0;
+}
+
+static int resolve_commit(const char *committish, struct object_id *result)
+{
+	struct commit *commit;
+	if (get_oid_committish(committish, result))
+		die(_("Failed to resolve '%s' as a valid revision."), committish);
+	commit = lookup_commit_reference(the_repository, result);
+	if (!commit)
+		die(_("Could not parse object '%s'."), committish);
+	oidcpy(result, &commit->object.oid);
+	return 0;
+}
+
+static void resolve_commit_list(const struct string_list *commitsish_list,
+	struct oid_array* result)
+{
+	int i;
+	for (i = 0; i < commitsish_list->nr; i++) {
+		struct string_list_item *item = &commitsish_list->items[i];
+		struct object_id next;
+		resolve_commit(item->string, &next);
+		oid_array_append(result, &next);
+	}
+}
+
+/*
+ * Given the command-line options for the update command, fills in a
+ * metacommit_data with the corresponding changes.
+ */
+static void get_metacommit_from_command_line(
+	const struct update_state* commands, struct metacommit_data *result)
+{
+	resolve_commit(commands->content, &(result->content));
+	resolve_commit_list(&(commands->replace), &(result->replace));
+	resolve_commit_list(&(commands->origin), &(result->origin));
+}
+
+static int perform_update(
+	struct repository *repo,
+	const struct update_state *state,
+	struct strbuf *err)
+{
+	struct metacommit_data metacommit;
+	int ret;
+
+	init_metacommit_data(&metacommit);
+
+	get_metacommit_from_command_line(state, &metacommit);
+
+	ret = record_metacommit(repo, &metacommit, state->change, state->options, err);
+
+	clear_metacommit_data(&metacommit);
+
+	return ret;
+}
+
+static int change_update(int argc, const char **argv, const char* prefix)
+{
+	int result;
+	int force = 0;
+	int newchange = 0;
+	struct strbuf err = STRBUF_INIT;
+	struct update_state state;
+	struct option options[] = {
+		{ OPTION_CALLBACK, 'r', "replace", &state, N_("commit"),
+			N_("marks the given commit as being obsolete"),
+			0, update_option_parse_replace },
+		{ OPTION_CALLBACK, 'o', "origin", &state, N_("commit"),
+			N_("marks the given commit as being the origin of this commit"),
+			0, update_option_parse_origin },
+		OPT_BOOL('F', "force", &force,
+			N_("overwrite an existing change of the same name")),
+		OPT_STRING('c', "content", &state.content, N_("commit"),
+				 N_("identifies the new content commit for the change")),
+		OPT_STRING('g', "change", &state.change, N_("commit"),
+				 N_("name of the change to update")),
+		OPT_BOOL('n', "new", &newchange,
+			N_("create a new change - do not append to any existing change")),
+		OPT_END()
+	};
+
+	init_update_state(&state);
+
+	argc = parse_options(argc, argv, prefix, options, builtin_update_usage, 0);
+
+	if (force) state.options |= UPDATE_OPTION_FORCE;
+	if (newchange) state.options |= UPDATE_OPTION_NOAPPEND;
+
+	result = perform_update(the_repository, &state, &err);
+
+	if (result < 0) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+	}
+
+	clear_update_state(&state);
+
+	return result;
+}
+
+int cmd_change(int argc, const char **argv, const char *prefix)
+{
+	// No options permitted before subcommand currently
+	struct option options[] = {
+		OPT_END()
+	};
+	int result = 1;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_change_usage,
+		PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc < 1)
+		usage_with_options(builtin_change_usage, options);
+	else if (!strcmp(argv[0], "update"))
+		result = change_update(argc, argv, prefix);
+	else {
+		error(_("Unknown subcommand: %s"), argv[0]);
+		usage_with_options(builtin_change_usage, options);
+	}
+
+	return result ? 1 : 0;
+}
diff --git a/git.c b/git.c
index 0ce0e13f0f..f59f887238 100644
--- a/git.c
+++ b/git.c
@@ -453,6 +453,7 @@ static struct cmd_struct commands[] = {
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
+	{ "change", cmd_change, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-- 
2.20.1.321.g9e740568ce-goog

