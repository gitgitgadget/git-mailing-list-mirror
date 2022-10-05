Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD3FC4332F
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJEPBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJEPAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AB12AB7
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay36so10956353wmb.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=xacm+hNwUPMQO0QWzB5cPQcJssNZjFDSNmhJ0sAVZPk=;
        b=n0mPl4UmGbL+q0p+ZXNig5mUged3rnlESCdouj7t0JDjbQd/xGlViMNHbBVGYguFnL
         hIgJRZ7zqlI60yO+vQ+wpfBF/HEVCtaIX3U14wJCkQ0Z284ujKAoLdV08D/z/8ZwLKs3
         9TQlOWUzhK20eIBw/HIIVloM6/ZGPED7/WdVoTXR/R6VnHEUBEX6pqQs3ZW3eVRgn8qR
         BGAVtYy/xoQTmMs+R7wJryJKnaQFJGeh+dBxugFncDEjbOmNshcQZPO7MBx0/UZ9fZmg
         FedaA4LeN1uMKp9+CaASWPH3VwfKeC5g9e0jJnDgwmQ4YkCoOod9VVp//n+jIC6b2LZ5
         9VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xacm+hNwUPMQO0QWzB5cPQcJssNZjFDSNmhJ0sAVZPk=;
        b=ZTO4Jf7hPnbofTuw9d2UUxRF6i74JDIRq6D5tKFzSkcwtkdLbLWMWHex1yIpfKixR2
         2Rj6+bePCeEDmKjr614uIKIgEnLhBlKZRMqFsPFJL/R73oerou56TpbYaSW1hjzWyn2l
         Ccqn7H0wuTEMQ4XUuZtWAVp5g3SOjKqf6TS7QbZn+XGLNPllS/818J8+7Q+TLhtxEBZG
         kOso1mUrtwbEsI+953F69gf7wuegMumVTRMc/arpOfS0Up7PkoMBOcFs5Z4nLD6H31kU
         jsxH9EfjzRcZvA7s9EpYp1pQ3B34sO+qPEXvIygrxs5cVtQyj2R38+j8NIv94nWDsHB3
         0L/Q==
X-Gm-Message-State: ACrzQf0SlvmP8UO0xk5iOtGjuUCNLvkLFR7uGqIU410XwiNyxOerC8/9
        HZUTRJ5oFUK/dGZGwQQq6ocEd49WReA=
X-Google-Smtp-Source: AMsMyM6FjkBlxIN88/gjXToQmW+XAqTuzLaUK7gx+qoAfEneGxo4CTBENG4m7tIhXdcwmWH63HNIZw==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:cd with SMTP id 11-20020a05600c020b00b003b486ff00cdmr3627895wmi.35.1664981966715;
        Wed, 05 Oct 2022 07:59:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5-20020a05600c2d0500b003b56be51313sm2002371wmf.44.2022.10.05.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:26 -0700 (PDT)
Message-Id: <f7a90700e0e79b3ae6fbc5cf32723da04e907347.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:14 +0000
Subject: [PATCH v2 07/10] evolve: implement the git change command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
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

Signed-off-by: Stefan Xenos <sxenos@google.com>
Signed-off-by: Chris Poucet <poucet@google.com>
---
 .gitignore       |   1 +
 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/change.c | 253 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 ref-filter.c     |   2 +-
 ref-filter.h     |   4 +
 7 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 builtin/change.c

diff --git a/.gitignore b/.gitignore
index b3dcafcb331..a57fd8d8897 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,6 +28,7 @@
 /git-bugreport
 /git-bundle
 /git-cat-file
+/git-change
 /git-check-attr
 /git-check-ignore
 /git-check-mailmap
diff --git a/Makefile b/Makefile
index 68082ef94c7..82f68f13d9f 100644
--- a/Makefile
+++ b/Makefile
@@ -1142,6 +1142,7 @@ BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
+BUILTIN_OBJS += builtin/change.o
 BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-mailmap.o
diff --git a/builtin.h b/builtin.h
index 8901a34d6bf..c10f20c972c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -122,6 +122,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
 int cmd_bundle(int argc, const char **argv, const char *prefix);
 int cmd_cat_file(int argc, const char **argv, const char *prefix);
+int cmd_change(int argc, const char **argv, const char *prefix);
 int cmd_checkout(int argc, const char **argv, const char *prefix);
 int cmd_checkout__worker(int argc, const char **argv, const char *prefix);
 int cmd_checkout_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/change.c b/builtin/change.c
new file mode 100644
index 00000000000..e4e8e15b768
--- /dev/null
+++ b/builtin/change.c
@@ -0,0 +1,253 @@
+#include "builtin.h"
+#include "ref-filter.h"
+#include "parse-options.h"
+#include "metacommit.h"
+#include "config.h"
+
+static const char * const builtin_change_usage[] = {
+	N_("git change list [<pattern>...]"),
+	N_("git change update [--force] [--replace <treeish>...] "
+	   "[--origin <treeish>...] [--content <newtreeish>]"),
+	NULL
+};
+
+static const char * const builtin_list_usage[] = {
+	N_("git change list [<pattern>...]"),
+	NULL
+};
+
+static const char * const builtin_update_usage[] = {
+	N_("git change update [--force] [--replace <treeish>...] "
+	"[--origin <treeish>...] [--content <newtreeish>]"),
+	NULL
+};
+
+static int change_list(int argc, const char **argv, const char* prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct ref_filter filter = { 0 };
+	struct ref_sorting *sorting;
+	struct string_list sorting_options = STRING_LIST_INIT_DUP;
+	struct ref_format format = REF_FORMAT_INIT;
+	struct ref_array array = { 0 };
+	size_t i;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
+
+	setup_ref_filter_porcelain_msg();
+
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = argv;
+
+	filter_refs(&array, &filter, FILTER_REFS_CHANGES);
+
+	/* TODO: This causes a crash. It sets one of the atom_value handlers to
+	 * something invalid, which causes a crash later when we call
+	 * show_ref_array_item. Figure out why this happens and put back the sorting.
+	 *
+	 * sorting = ref_sorting_options(&sorting_options);
+	 * ref_array_sort(sorting, &array); */
+
+	if (!format.format)
+		format.format = "%(refname:lstrip=1)";
+
+	if (verify_ref_format(&format))
+		die(_("unable to parse format string"));
+
+	sorting = ref_sorting_options(&sorting_options);
+	ref_array_sort(sorting, &array);
+
+
+	for (i = 0; i < array.nr; i++) {
+		struct strbuf output = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+		if (format_ref_array_item(array.items[i], &format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+
+		strbuf_release(&err);
+		strbuf_release(&output);
+	}
+
+	ref_array_clear(&array);
+	ref_sorting_release(sorting);
+
+	return 0;
+}
+
+struct update_state {
+	int options;
+	const char* change;
+	const char* content;
+	struct string_list replace;
+	struct string_list origin;
+};
+
+#define UPDATE_STATE_INIT { \
+	.content = "HEAD", \
+	.replace = STRING_LIST_INIT_NODUP, \
+	.origin = STRING_LIST_INIT_NODUP \
+}
+
+static void clear_update_state(struct update_state *state)
+{
+	string_list_clear(&state->replace, 0);
+	string_list_clear(&state->origin, 0);
+}
+
+static int update_option_parse_replace(const struct option *opt,
+				       const char *arg, int unset)
+{
+	struct update_state *state = opt->value;
+	string_list_append(&state->replace, arg);
+	return 0;
+}
+
+static int update_option_parse_origin(const struct option *opt,
+				      const char *arg, int unset)
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
+		die(_("failed to resolve '%s' as a valid revision."), committish);
+	commit = lookup_commit_reference(the_repository, result);
+	if (!commit)
+		die(_("could not parse object '%s'."), committish);
+	oidcpy(result, &commit->object.oid);
+	return 0;
+}
+
+static void resolve_commit_list(const struct string_list *commitsish_list,
+	struct oid_array* result)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, commitsish_list) {
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
+	struct metacommit_data metacommit = METACOMMIT_DATA_INIT;
+	struct string_list changes = STRING_LIST_INIT_DUP;
+	int ret;
+	struct string_list_item *item;
+
+	get_metacommit_from_command_line(state, &metacommit);
+
+	ret = record_metacommit(
+		repo,
+		&metacommit,
+		state->change,
+		state->options,
+		err,
+		&changes);
+
+	for_each_string_list_item(item, &changes) {
+
+		const char* name = lstrip_ref_components(item->string, 1);
+		if (!name)
+			die(_("failed to remove `refs/` from %s"), item->string);
+
+		if (item->util)
+			fprintf(stdout, _("Updated change %s"), name);
+		else
+			fprintf(stdout, _("Created change %s"), name);
+		putchar('\n');
+	}
+
+	string_list_clear(&changes, 0);
+	clear_metacommit_data(&metacommit);
+
+	return ret;
+}
+
+static int change_update(int argc, const char **argv, const char* prefix)
+{
+	int result;
+	struct strbuf err = STRBUF_INIT;
+	struct update_state state = UPDATE_STATE_INIT;
+	struct option options[] = {
+		{ OPTION_CALLBACK, 'r', "replace", &state, N_("commit"),
+			N_("marks the given commit as being obsolete"),
+			0, update_option_parse_replace },
+		{ OPTION_CALLBACK, 'o', "origin", &state, N_("commit"),
+			N_("marks the given commit as being the origin of this commit"),
+			0, update_option_parse_origin },
+
+		OPT_STRING('c', "content", &state.content, N_("commit"),
+				 N_("identifies the new content commit for the change")),
+		OPT_STRING('g', "change", &state.change, N_("commit"),
+				 N_("name of the change to update")),
+		OPT_SET_INT_F('n', "new", &state.options,
+			      N_("create a new change - do not append to any existing change"),
+			      UPDATE_OPTION_NOAPPEND, 0),
+		OPT_SET_INT_F('F', "force", &state.options,
+			      N_("overwrite an existing change of the same name"),
+			      UPDATE_OPTION_FORCE, 0),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, builtin_update_usage, 0);
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
+	parse_opt_subcommand_fn *fn = NULL;
+	/* No options permitted before subcommand currently */
+	struct option options[] = {
+		OPT_SUBCOMMAND("list", &fn, change_list),
+		OPT_SUBCOMMAND("update", &fn, change_update),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, builtin_change_usage,
+		PARSE_OPT_SUBCOMMAND_OPTIONAL);
+
+	if (!fn) {
+		if (argc) {
+			error(_("unknown subcommand: `%s'"), argv[0]);
+			usage_with_options(builtin_change_usage, options);
+		}
+		fn = change_list;
+	}
+
+	return !!fn(argc, argv, prefix);
+}
diff --git a/git.c b/git.c
index da411c53822..837b1abc53b 100644
--- a/git.c
+++ b/git.c
@@ -498,6 +498,7 @@ static struct cmd_struct commands[] = {
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
+	{ "change", cmd_change, RUN_SETUP},
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
diff --git a/ref-filter.c b/ref-filter.c
index 6a1789c623f..2d7a919d547 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1557,7 +1557,7 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *lstrip_ref_components(const char *refname, int len)
+const char *lstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
 	const char *start = xstrdup(refname);
diff --git a/ref-filter.h b/ref-filter.h
index db3ee44e4dc..193700694ad 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -145,4 +145,8 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
 				      const struct object_id *oid);
 
+/* Strips `len` prefix components from the refname. */
+const char *lstrip_ref_components(const char *refname, int len);
+
+
 #endif /*  REF_FILTER_H  */
-- 
gitgitgadget

