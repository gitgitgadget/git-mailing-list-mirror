Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F0C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiCHAQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbiCHAQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:16:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECF637BD0
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:15:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b5-20020a170902e94500b0014f6d0a417bso8177115pll.6
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jdlkzcDy/BOWVzF7Lzw9PSPrcBj2v9g/3uNMHlG2bRk=;
        b=UUA/Z6Ue4ZI1YMO2IICD1koh02tdDqq9V8NVYTqLgsYv895VWiciXA4rcUaPgJ+dKr
         JyKCGBnml/yyFEpa986pIIklDlKzvsUQHRZYOvDDJMa0bCew2CeeBQhQ3KsrsZNvD5Qf
         1ybotL44GohOrz7NEMK11urXO1f6vfo+oTwUWD3dHTEKyUGMZ3utlo9cGpVkD580k2SL
         bLOYg0dhPVl2T3fk6+v9AE3dYxj/XuCS9US+MHLKeFgLrOCC7WthxEExMZs+spZkZ3oT
         +rPQWOhfMC/5PAuLYg7VjsJ1CTRGXsPgchOdSS7EXrLrtpmelbOnHpLvPUWfCSDt4Xps
         CCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jdlkzcDy/BOWVzF7Lzw9PSPrcBj2v9g/3uNMHlG2bRk=;
        b=7v/YfIiS7sFrxiv3Yxehdt/xZTyHlZZiGFJJ6RcqSM1vWLRqK/MgGKypCIHXyI7PQ5
         LVV/jH9NhUVX71XvyyVieDEBdltPBd/vy3qyyGiz5TzRd2UW7vUSV503G7XL6KlGc9Pq
         1DFvR36mFoeegzCS0Gfy6c0u7skGfXJcGG5CJQxRdlDfmh9iT3girrrqcftoiZCp4PHx
         7CklemBd1MjFX4UjMx0jqyeegF6gahcM75JBojek5KAvyiY641u9E3zm0JnrXLbRggKt
         vSzJAyUPiWcV44ExV1haNfVtT08e0cDTkXqpPEPsmbDU+SeFW0QqrvWRNsXn9XgRBdOm
         8dcQ==
X-Gm-Message-State: AOAM531VwiuAumABo038rngFKdFs8LuEwRX6bYTNC5SoUzENi2ffJ4rh
        hrBMV9tGsQg94LBEkOPScn1D02kOaP8cz/Y3Yu82zVSrTczWjVvncooOV7eEsD+lZx+C35EjJnM
        NJtgETZqLC9U3bOJEJDW1+/Qi03UPZqBIyFoFVSS7fDOKX7qjvaRH2WId3HJbbjA=
X-Google-Smtp-Source: ABdhPJxZDuW/DoC96AgD0RfmjouqptwRVVuQEJvOZdf9/Cq2deB16uHwtfmeJGgvPq9GISesBrElp0dXOyEVhw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ecd0:b0:151:ed65:d6a2 with SMTP
 id a16-20020a170902ecd000b00151ed65d6a2mr6682404plh.148.1646698510146; Mon,
 07 Mar 2022 16:15:10 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:32 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git fetch --recurse-submodules" only considers populated
submodules (i.e. submodules that can be found by iterating the index),
which makes "git fetch" behave differently based on which commit is
checked out. As a result, even if the user has initialized all submodules
correctly, they may not fetch the necessary submodule commits, and
commands like "git checkout --recurse-submodules" might fail.

Teach "git fetch" to fetch cloned, changed submodules regardless of
whether they are populated. This is in addition to the current behavior
of fetching populated submodules (which is always attempted regardless
of what was fetched in the superproject, or even if nothing was fetched
in the superproject).

A submodule may be encountered multiple times (via the list of
populated submodules or via the list of changed submodules). When this
happens, "git fetch" only reads the 'populated copy' and ignores the
'changed copy'. Amend the verify_fetch_result() test helper so that we
can assert on which 'copy' is being read.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/fetch-options.txt |  26 ++--
 Documentation/git-fetch.txt     |  10 +-
 builtin/fetch.c                 |  14 +-
 submodule.c                     | 178 +++++++++++++++++++--
 submodule.h                     |  12 +-
 t/t5526-fetch-submodules.sh     | 268 +++++++++++++++++++++++++++++++-
 6 files changed, 462 insertions(+), 46 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index f903683189..6cdd9d43c5 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -186,15 +186,23 @@ endif::git-pull[]
 ifndef::git-pull[]
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-	populated submodules should be fetched too. It can be used as a
-	boolean option to completely disable recursion when set to 'no' or to
-	unconditionally recurse into all populated submodules when set to
-	'yes', which is the default when this option is used without any
-	value. Use 'on-demand' to only recurse into a populated submodule
-	when the superproject retrieves a commit that updates the submodule's
-	reference to a commit that isn't already in the local submodule
-	clone. By default, 'on-demand' is used, unless
-	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
+	submodules should be fetched too. When recursing through submodules,
+	`git fetch` always attempts to fetch "changed" submodules, that is, a
+	submodule that has commits that are referenced by a newly fetched
+	superproject commit but are missing in the local submodule clone. A
+	changed submodule can be fetched as long as it is present locally e.g.
+	in `$GIT_DIR/modules/` (see linkgit:gitsubmodules[7]); if the upstream
+	adds a new submodule, that submodule cannot be fetched until it is
+	cloned e.g. by `git submodule update`.
++
+When set to 'on-demand', only changed submodules are fetched. When set
+to 'yes', all populated submodules are fetched and submodules that are
+both unpopulated and changed are fetched. When set to 'no', submodules
+are never fetched.
++
+When unspecified, this uses the value of `fetch.recurseSubmodules` if it
+is set (see linkgit:git-config[1]), defaulting to 'on-demand' if unset.
+When this option is used without any value, it defaults to 'yes'.
 endif::git-pull[]
 
 -j::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 550c16ca61..e9d364669a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -287,12 +287,10 @@ include::transfer-data-leaks.txt[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
-out submodules right now. When e.g. upstream added a new submodule in the
-just fetched commits of the superproject the submodule itself cannot be
-fetched, making it impossible to check out that submodule later without
-having to do a fetch again. This is expected to be fixed in a future Git
-version.
+Using --recurse-submodules can only fetch new commits in submodules that are
+present locally e.g. in `$GIT_DIR/modules/`. If the upstream adds a new
+submodule, that submodule cannot be fetched until it is cloned e.g. by `git
+submodule update`. This is expected to be fixed in a future Git version.
 
 SEE ALSO
 --------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95832ba1df..97a89763c8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2178,13 +2178,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			max_children = fetch_parallel_config;
 
 		add_options_to_argv(&options);
-		result = fetch_populated_submodules(the_repository,
-						    &options,
-						    submodule_prefix,
-						    recurse_submodules,
-						    recurse_submodules_default,
-						    verbosity < 0,
-						    max_children);
+		result = fetch_submodules(the_repository,
+					  &options,
+					  submodule_prefix,
+					  recurse_submodules,
+					  recurse_submodules_default,
+					  verbosity < 0,
+					  max_children);
 		strvec_clear(&options);
 	}
 
diff --git a/submodule.c b/submodule.c
index b36ef26752..1f5f39ce18 100644
--- a/submodule.c
+++ b/submodule.c
@@ -808,9 +808,25 @@ static const char *default_name_or_path(const char *path_or_name)
 
 /*
  * Holds relevant information for a changed submodule. Used as the .util
- * member of the changed submodule string_list_item.
+ * member of the changed submodule name string_list_item.
+ *
+ * (super_oid, path) allows the submodule config to be read from _some_
+ * .gitmodules file. We store this information the first time we find a
+ * superproject commit that points to the submodule, but this is
+ * arbitrary - we can choose any (super_oid, path) that matches the
+ * submodule's name.
  */
 struct changed_submodule_data {
+	/*
+	 * The first superproject commit in the rev walk that points to
+	 * the submodule.
+	 */
+	const struct object_id *super_oid;
+	/*
+	 * Path to the submodule in the superproject commit referenced
+	 * by 'super_oid'.
+	 */
+	char *path;
 	/* The submodule commits that have changed in the rev walk. */
 	struct oid_array new_commits;
 };
@@ -818,6 +834,7 @@ struct changed_submodule_data {
 static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
 {
 	oid_array_clear(&cs_data->new_commits);
+	free(cs_data->path);
 }
 
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
@@ -862,9 +879,14 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 			continue;
 
 		item = string_list_insert(changed, name);
-		if (!item->util)
+		if (item->util)
+			cs_data = item->util;
+		else {
 			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
-		cs_data = item->util;
+			cs_data = item->util;
+			cs_data->super_oid = commit_oid;
+			cs_data->path = xstrdup(p->two->path);
+		}
 		oid_array_append(&cs_data->new_commits, &p->two->oid);
 	}
 }
@@ -1253,14 +1275,36 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
+/*
+ * Returns 1 if there is at least one submodule gitdir in
+ * $GIT_DIR/modules and 0 otherwise. This follows
+ * submodule_name_to_gitdir(), which looks for submodules in
+ * $GIT_DIR/modules, not $GIT_COMMON_DIR.
+ *
+ * A submodule can be moved to $GIT_DIR/modules manually by running "git
+ * submodule absorbgitdirs", or it may be initialized there by "git
+ * submodule update".
+ */
+static int repo_has_absorbed_submodules(struct repository *r)
+{
+	int ret;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_repo_git_path(&buf, r, "modules/");
+	ret = file_exists(buf.buf) && !is_empty_dir(buf.buf);
+	strbuf_release(&buf);
+	return ret;
+}
+
 static void calculate_changed_submodule_paths(struct repository *r,
 		struct string_list *changed_submodule_names)
 {
 	struct strvec argv = STRVEC_INIT;
 	struct string_list_item *name;
 
-	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(r, NULL, NULL))
+	/* No need to check if no submodules would be fetched */
+	if (!submodule_from_path(r, NULL, NULL) &&
+	    !repo_has_absorbed_submodules(r))
 		return;
 
 	strvec_push(&argv, "--"); /* argv[0] program name */
@@ -1333,7 +1377,16 @@ int submodule_touches_in_range(struct repository *r,
 }
 
 struct submodule_parallel_fetch {
-	int count;
+	/*
+	 * The index of the last index entry processed by
+	 * get_fetch_task_from_index().
+	 */
+	int index_count;
+	/*
+	 * The index of the last string_list entry processed by
+	 * get_fetch_task_from_changed().
+	 */
+	int changed_count;
 	struct strvec args;
 	struct repository *r;
 	const char *prefix;
@@ -1342,7 +1395,16 @@ struct submodule_parallel_fetch {
 	int quiet;
 	int result;
 
+	/*
+	 * Names of submodules that have new commits. Generated by
+	 * walking the newly fetched superproject commits.
+	 */
 	struct string_list changed_submodule_names;
+	/*
+	 * Names of submodules that have already been processed. Lets us
+	 * avoid fetching the same submodule more than once.
+	 */
+	struct string_list seen_submodule_names;
 
 	/* Pending fetches by OIDs */
 	struct fetch_task **oid_fetch_tasks;
@@ -1353,6 +1415,7 @@ struct submodule_parallel_fetch {
 #define SPF_INIT { \
 	.args = STRVEC_INIT, \
 	.changed_submodule_names = STRING_LIST_INIT_DUP, \
+	.seen_submodule_names = STRING_LIST_INIT_DUP, \
 	.submodules_with_errors = STRBUF_INIT, \
 }
 
@@ -1390,6 +1453,7 @@ struct fetch_task {
 	const struct submodule *sub;
 	unsigned free_sub : 1; /* Do we need to free the submodule? */
 	const char *default_argv; /* The default fetch mode. */
+	struct strvec git_args; /* Args for the child git process. */
 
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
@@ -1425,6 +1489,8 @@ static void fetch_task_release(struct fetch_task *p)
 	if (p->repo)
 		repo_clear(p->repo);
 	FREE_AND_NULL(p->repo);
+
+	strvec_clear(&p->git_args);
 }
 
 static struct repository *get_submodule_repo_for(struct repository *r,
@@ -1463,6 +1529,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 		task->free_sub = 1;
 	}
 
+	if (string_list_lookup(&spf->seen_submodule_names, task->sub->name))
+		goto cleanup;
+
 	switch (get_fetch_recurse_config(task->sub, spf))
 	{
 	default:
@@ -1493,10 +1562,12 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 }
 
 static struct fetch_task *
-get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
+get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
+			  struct strbuf *err)
 {
-	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		const struct cache_entry *ce = spf->r->index->cache[spf->count];
+	for (; spf->index_count < spf->r->index->cache_nr; spf->index_count++) {
+		const struct cache_entry *ce =
+			spf->r->index->cache[spf->index_count];
 		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1511,7 +1582,7 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 
-			spf->count++;
+			spf->index_count++;
 			return task;
 		} else {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
@@ -1539,11 +1610,83 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 	return NULL;
 }
 
+static struct fetch_task *
+get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
+			    struct strbuf *err)
+{
+	for (; spf->changed_count < spf->changed_submodule_names.nr;
+	     spf->changed_count++) {
+		struct string_list_item item =
+			spf->changed_submodule_names.items[spf->changed_count];
+		struct changed_submodule_data *cs_data = item.util;
+		struct fetch_task *task;
+
+		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,cs_data->path))
+			continue;
+
+		task = fetch_task_create(spf, cs_data->path,
+					 cs_data->super_oid);
+		if (!task)
+			continue;
+
+		if (!task->repo) {
+			strbuf_addf(err, _("Could not access submodule '%s' at commit %s\n"),
+				    cs_data->path,
+				    find_unique_abbrev(cs_data->super_oid, DEFAULT_ABBREV));
+
+			fetch_task_release(task);
+			free(task);
+			continue;
+		}
+
+		if (!spf->quiet)
+			strbuf_addf(err,
+				    _("Fetching submodule %s%s at commit %s\n"),
+				    spf->prefix, task->sub->path,
+				    find_unique_abbrev(cs_data->super_oid,
+						       DEFAULT_ABBREV));
+
+		spf->changed_count++;
+		/*
+		 * NEEDSWORK: Submodules set/unset a value for
+		 * core.worktree when they are populated/unpopulated by
+		 * "git checkout" (and similar commands, see
+		 * submodule_move_head() and
+		 * connect_work_tree_and_git_dir()), but if the
+		 * submodule is unpopulated in another way (e.g. "git
+		 * rm", "rm -r"), core.worktree will still be set even
+		 * though the directory doesn't exist, and the child
+		 * process will crash while trying to chdir into the
+		 * nonexistent directory.
+		 *
+		 * In this case, we know that the submodule has no
+		 * working tree, so we can work around this by
+		 * setting "--work-tree=." (--bare does not work because
+		 * worktree settings take precedence over bare-ness).
+		 * However, this is not necessarily true in other cases,
+		 * so a generalized solution is still necessary.
+		 *
+		 * Possible solutions:
+		 * - teach "git [add|rm]" to unset core.worktree and
+		 *   discourage users from removing submodules without
+		 *   using a Git command.
+		 * - teach submodule child processes to ignore stale
+		 *   core.worktree values.
+		 */
+		strvec_push(&task->git_args, "--work-tree=.");
+		return task;
+	}
+	return NULL;
+}
+
 static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 			      void *data, void **task_cb)
 {
 	struct submodule_parallel_fetch *spf = data;
-	struct fetch_task *task = get_fetch_task(spf, err);
+	struct fetch_task *task =
+		get_fetch_task_from_index(spf, err);
+	if (!task)
+		task = get_fetch_task_from_changed(spf, err);
 
 	if (task) {
 		struct strbuf submodule_prefix = STRBUF_INIT;
@@ -1553,6 +1696,8 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 		cp->git_cmd = 1;
 		strvec_init(&cp->args);
+		if (task->git_args.nr)
+			strvec_pushv(&cp->args, task->git_args.v);
 		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, task->default_argv);
 		strvec_push(&cp->args, "--submodule-prefix");
@@ -1564,6 +1709,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		*task_cb = task;
 
 		strbuf_release(&submodule_prefix);
+		string_list_insert(&spf->seen_submodule_names, task->sub->name);
 		return 1;
 	}
 
@@ -1678,11 +1824,11 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	return 0;
 }
 
-int fetch_populated_submodules(struct repository *r,
-			       const struct strvec *options,
-			       const char *prefix, int command_line_option,
-			       int default_option,
-			       int quiet, int max_parallel_jobs)
+int fetch_submodules(struct repository *r,
+		     const struct strvec *options,
+		     const char *prefix, int command_line_option,
+		     int default_option,
+		     int quiet, int max_parallel_jobs)
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
diff --git a/submodule.h b/submodule.h
index 784ceffc0e..61bebde319 100644
--- a/submodule.h
+++ b/submodule.h
@@ -88,12 +88,12 @@ int should_update_submodules(void);
  */
 const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 void check_for_new_submodule_commits(struct object_id *oid);
-int fetch_populated_submodules(struct repository *r,
-			       const struct strvec *options,
-			       const char *prefix,
-			       int command_line_option,
-			       int default_option,
-			       int quiet, int max_parallel_jobs);
+int fetch_submodules(struct repository *r,
+		     const struct strvec *options,
+		     const char *prefix,
+		     int command_line_option,
+		     int default_option,
+		     int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index aa6bb9867c..43dada8544 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -12,17 +12,29 @@ pwd=$(pwd)
 
 write_expected_sub () {
 	NEW_HEAD=$1 &&
+	SUPER_HEAD=$2 &&
 	cat >"$pwd/expect.err.sub" <<-EOF
-	Fetching submodule submodule
+	Fetching submodule submodule${SUPER_HEAD:+ at commit $SUPER_HEAD}
 	From $pwd/submodule
 	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
 	EOF
 }
 
+write_expected_sub2 () {
+	NEW_HEAD=$1 &&
+	SUPER_HEAD=$2 &&
+	cat >"$pwd/expect.err.sub2" <<-EOF
+	Fetching submodule submodule2${SUPER_HEAD:+ at commit $SUPER_HEAD}
+	From $pwd/submodule2
+	   OLD_HEAD..$NEW_HEAD  sub2       -> origin/sub2
+	EOF
+}
+
 write_expected_deep () {
 	NEW_HEAD=$1 &&
+	SUB_HEAD=$2 &&
 	cat >"$pwd/expect.err.deep" <<-EOF
-	Fetching submodule submodule/subdir/deepsubmodule
+	Fetching submodule submodule/subdir/deepsubmodule${SUB_HEAD:+ at commit $SUB_HEAD}
 	From $pwd/deepsubmodule
 	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
 	EOF
@@ -106,6 +118,10 @@ verify_fetch_result () {
 	then
 		cat expect.err.deep >>expect.err.combined
 	fi &&
+	if test -f expect.err.sub2
+	then
+		cat expect.err.sub2 >>expect.err.combined
+	fi &&
 	sed -e 's/[0-9a-f][0-9a-f]*\.\./OLD_HEAD\.\./' "$ACTUAL_ERR" >actual.err.cmp &&
 	test_cmp expect.err.combined actual.err.cmp
 }
@@ -419,6 +435,147 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	verify_fetch_result actual.err
 '
 
+# These tests verify that we can fetch submodules that aren't in the
+# index.
+#
+# First, test the simple case where the index is empty and we only fetch
+# submodules that are not in the index.
+test_expect_success 'setup downstream branch without submodules' '
+	(
+		cd downstream &&
+		git checkout --recurse-submodules -b no-submodules &&
+		git rm .gitmodules &&
+		git rm submodule &&
+		git commit -m "no submodules" &&
+		git checkout --recurse-submodules super
+	)
+'
+
+test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
+	add_submodule_commits &&
+	add_superproject_commits &&
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err
+	) &&
+	super_head=$(git rev-parse --short HEAD) &&
+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
+	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
+
+	# assert that these are fetched from commits, not the index
+	write_expected_sub $sub_head $super_head &&
+	write_expected_deep $deep_head $sub_head &&
+
+	test_must_be_empty actual.out &&
+	verify_fetch_result actual.err
+'
+
+test_expect_success "'--recurse-submodules' should fetch submodule commits if the submodule is changed but the index has no submodules" '
+	add_submodule_commits &&
+	add_superproject_commits &&
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	super_head=$(git rev-parse --short HEAD) &&
+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
+	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
+
+	# assert that these are fetched from commits, not the index
+	write_expected_sub $sub_head $super_head &&
+	write_expected_deep $deep_head $sub_head &&
+
+	test_must_be_empty actual.out &&
+	verify_fetch_result actual.err
+'
+
+test_expect_success "'--recurse-submodules' should ignore changed, inactive submodules" '
+	add_submodule_commits &&
+	add_superproject_commits &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git -c submodule.submodule.active=false fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	super_head=$(git rev-parse --short HEAD) &&
+	write_expected_super $super_head &&
+	# Neither should be fetched because the submodule is inactive
+	rm expect.err.sub &&
+	rm expect.err.deep &&
+	verify_fetch_result actual.err
+'
+
+# Now that we know we can fetch submodules that are not in the index,
+# test that we can fetch index and non-index submodules in the same
+# operation.
+test_expect_success 'setup downstream branch with other submodule' '
+	mkdir submodule2 &&
+	(
+		cd submodule2 &&
+		git init &&
+		echo sub2content >sub2file &&
+		git add sub2file &&
+		git commit -a -m new &&
+		git branch -M sub2
+	) &&
+	git checkout -b super-sub2-only &&
+	git submodule add "$pwd/submodule2" submodule2 &&
+	git commit -m "add sub2" &&
+	git checkout super &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin &&
+		git checkout super-sub2-only &&
+		# Explicitly run "git submodule update" because sub2 is new
+		# and has not been cloned.
+		git submodule update --init &&
+		git checkout --recurse-submodules super
+	)
+'
+
+test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
+	test_when_finished "rm expect.err.sub2" &&
+	# Create new commit in origin/super
+	add_submodule_commits &&
+	add_superproject_commits &&
+
+	# Create new commit in origin/super-sub2-only
+	git checkout super-sub2-only &&
+	(
+		cd submodule2 &&
+		test_commit --no-tag foo
+	) &&
+	git add submodule2 &&
+	git commit -m "new submodule2" &&
+
+	git checkout super &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	sub2_head=$(git -C submodule2 rev-parse --short HEAD) &&
+	super_head=$(git rev-parse --short super) &&
+	super_sub2_only_head=$(git rev-parse --short super-sub2-only) &&
+	write_expected_sub2 $sub2_head $super_sub2_only_head &&
+
+	# write_expected_super cannot handle >1 branch. Since this is a
+	# one-off, construct expect.err.super manually.
+	cat >"$pwd/expect.err.super" <<-EOF &&
+	From $pwd/.
+	   OLD_HEAD..$super_head  super           -> origin/super
+	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
+	EOF
+	verify_fetch_result actual.err
+'
+
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_submodule_commits &&
 	echo a >> file &&
@@ -861,4 +1018,111 @@ test_expect_success 'recursive fetch after deinit a submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup repo with upstreams that share a submodule name' '
+	mkdir same-name-1 &&
+	(
+		cd same-name-1 &&
+		git init -b main &&
+		test_commit --no-tag a
+	) &&
+	git clone same-name-1 same-name-2 &&
+	# same-name-1 and same-name-2 both add a submodule with the
+	# name "submodule"
+	(
+		cd same-name-1 &&
+		mkdir submodule &&
+		git -C submodule init -b main &&
+		test_commit -C submodule --no-tag a1 &&
+		git submodule add "$pwd/same-name-1/submodule" &&
+		git add submodule &&
+		git commit -m "super-a1"
+	) &&
+	(
+		cd same-name-2 &&
+		mkdir submodule &&
+		git -C submodule init -b main &&
+		test_commit -C submodule --no-tag a2 &&
+		git submodule add "$pwd/same-name-2/submodule" &&
+		git add submodule &&
+		git commit -m "super-a2"
+	) &&
+	git clone same-name-1 -o same-name-1 same-name-downstream &&
+	(
+		cd same-name-downstream &&
+		git remote add same-name-2 ../same-name-2 &&
+		git fetch --all &&
+		# init downstream with same-name-1
+		git submodule update --init
+	)
+'
+
+test_expect_success 'fetch --recurse-submodules updates name-conflicted, populated submodule' '
+	test_when_finished "git -C same-name-downstream checkout main" &&
+	(
+		cd same-name-1 &&
+		test_commit -C submodule --no-tag b1 &&
+		git add submodule &&
+		git commit -m "super-b1"
+	) &&
+	(
+		cd same-name-2 &&
+		test_commit -C submodule --no-tag b2 &&
+		git add submodule &&
+		git commit -m "super-b2"
+	) &&
+	(
+		cd same-name-downstream &&
+		# even though the .gitmodules is correct, we cannot
+		# fetch from same-name-2
+		git checkout same-name-2/main &&
+		git fetch --recurse-submodules same-name-1 &&
+		test_must_fail git fetch --recurse-submodules same-name-2
+	) &&
+	super_head1=$(git -C same-name-1 rev-parse HEAD) &&
+	git -C same-name-downstream cat-file -e $super_head1 &&
+
+	super_head2=$(git -C same-name-2 rev-parse HEAD) &&
+	git -C same-name-downstream cat-file -e $super_head2 &&
+
+	sub_head1=$(git -C same-name-1/submodule rev-parse HEAD) &&
+	git -C same-name-downstream/submodule cat-file -e $sub_head1 &&
+
+	sub_head2=$(git -C same-name-2/submodule rev-parse HEAD) &&
+	test_must_fail git -C same-name-downstream/submodule cat-file -e $sub_head2
+'
+
+test_expect_success 'fetch --recurse-submodules updates name-conflicted, unpopulated submodule' '
+	(
+		cd same-name-1 &&
+		test_commit -C submodule --no-tag c1 &&
+		git add submodule &&
+		git commit -m "super-c1"
+	) &&
+	(
+		cd same-name-2 &&
+		test_commit -C submodule --no-tag c2 &&
+		git add submodule &&
+		git commit -m "super-c2"
+	) &&
+	(
+		cd same-name-downstream &&
+		git checkout main &&
+		git rm .gitmodules &&
+		git rm submodule &&
+		git commit -m "no submodules" &&
+		git fetch --recurse-submodules same-name-1
+	) &&
+	head1=$(git -C same-name-1/submodule rev-parse HEAD) &&
+	head2=$(git -C same-name-2/submodule rev-parse HEAD) &&
+	(
+		cd same-name-downstream/.git/modules/submodule &&
+		# The submodule has core.worktree pointing to the "git
+		# rm"-ed directory, overwrite the invalid value. See
+		# comment in get_fetch_task_from_changed() for more
+		# information.
+		git --work-tree=. cat-file -e $head1 &&
+		test_must_fail git --work-tree=. cat-file -e $head2
+	)
+'
+
 test_done
-- 
2.33.GIT

