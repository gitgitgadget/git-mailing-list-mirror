Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB695C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiIWS4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiIWSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD18B1F4
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bq9so1326155wrb.4
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=F6GAX5eSktkNuwYWW73B6JM7dgfEDD6Xwiw7XxhHayM=;
        b=V67Pnk66mt4UKfhOwyJDLsAzTIo/ADLIQa1g3FvuPXO69G6LzjyK7VzvCck+b4Wej4
         jqpLWYHJEgMzoK7KS6OenyTKM7pFHYRD4rpqYEG+e5+QoyFykHjMy6TQL/e1Jqxhalqs
         7yPOFEIU7tW5j+7U32fJm/cfzt1kn+nf7LV74KA8LWrnk6TEMDqnAa2YhPR1903LAQFo
         LUsOvG//SBNY2OfV6aTBA+4D4KDjB2Orcp+wNBaCHu+pEB2kSkh5ToDqEIMw94/v4doo
         VRqD7IW568DrmvxvmqsEijCSntrxNkzwNo12wq9Q28IRFntsWQNWxNaKVT/M3PuUorX3
         USqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F6GAX5eSktkNuwYWW73B6JM7dgfEDD6Xwiw7XxhHayM=;
        b=sulpcDFP+cAr8FkpqEtfLSwBTw2cKPxYGbHXh+aVqhzTTnYm9aZ7kQRp1NIxs9agLQ
         VWJf7o3dlne1UeiMOTn5EbWeJ2cpLnf0iBHnNaxTnnMJj0ye+RdAXenqrnBiv7Mrrguy
         4sL0LXNwPBASIsEr9ZCqXcMgbZRPDiPhGXub1npItTcupdGrDn4pcoo/NjlOKCnmNqpj
         DDs9gkAeEMOEVutYlJCjY0h1XutI554csEYDyuW0tTNBaVPsy2MlVJnCTvE8fxrStQiQ
         EcCjMyXAJ/cBSVeVIykFY7XVKw/QCsOGE2OEdyzXF9YBO3YX0EWarE1i/0guk/JW4Onp
         9YAA==
X-Gm-Message-State: ACrzQf1rBu/zTECNwhZqEdqHGs8PlX1ycuUCm1MH/+oF/HXyTBq8/1k0
        VmYmkHaxA+RE8K0ja6qljuLmi/NIPB0=
X-Google-Smtp-Source: AMsMyM6Wxbw6Aboc5X14NWHc9Fr6bxD+MiOtGLKovDwhk5U6qtuDJdYZBf8pfZ7q3msB9bUX89xBaQ==
X-Received: by 2002:adf:db44:0:b0:22a:56eb:927f with SMTP id f4-20020adfdb44000000b0022a56eb927fmr6253545wrj.627.1663959331863;
        Fri, 23 Sep 2022 11:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003b4ac05a8a4sm4000046wmo.27.2022.09.23.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:31 -0700 (PDT)
Message-Id: <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Stefan Xenos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:21 +0000
Subject: [PATCH 07/10] evolve: implement the git change command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
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
 builtin/change.c | 199 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 ref-filter.c     |   2 +-
 ref-filter.h     |   4 +
 7 files changed, 208 insertions(+), 1 deletion(-)
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
index 00000000000..b0e29e87ec9
--- /dev/null
+++ b/builtin/change.c
@@ -0,0 +1,199 @@
+#include "builtin.h"
+#include "ref-filter.h"
+#include "parse-options.h"
+#include "metacommit.h"
+#include "change-table.h"
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
+	string_list_init_nodup(&state->replace);
+	string_list_init_nodup(&state->origin);
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
+	struct change_table chtable;
+	struct string_list changes;
+	int ret;
+	int i;
+
+	change_table_init(&chtable);
+	change_table_add_all_visible(&chtable, repo);
+	string_list_init_dup(&changes);
+
+	init_metacommit_data(&metacommit);
+
+	get_metacommit_from_command_line(state, &metacommit);
+
+	ret = record_metacommit_withresult(repo, &chtable, &metacommit,
+		state->change, state->options, err, &changes);
+
+	for (i = 0; i < changes.nr; i++) {
+		struct string_list_item *it = &changes.items[i];
+
+		const char* name = lstrip_ref_components(it->string, 1);
+		if (!name)
+			die(_("Failed to remove `refs/` from %s"), it->string);
+
+		if (it->util)
+			fprintf(stdout, N_("Updated change %s\n"), name);
+		else
+			fprintf(stdout, N_("Created change %s\n"), name);
+	}
+
+	string_list_clear(&changes, 0);
+	change_table_clear(&chtable);
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
+	/* No options permitted before subcommand currently */
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
index 064fbef8e50..7a7737e9552 100644
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

