Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A13C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiBXKJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBXKJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:42 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72D28A11F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:11 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id m15-20020a63580f000000b00370dc6cafe9so933563pgb.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4p4Tyls6g4Qu2sOGu6JLVBxQfSl2NsUML3/gJqhP/t4=;
        b=JmpTgJYZwz7kDv8Ok5pSO1QTQCvQVlP28D48UxZ6xRnxHqVyh1l3vxnZdVctMgBm/q
         jrKPcZ6Gct5UY3pAez+/+Q7WRGg1WCwvx4L9ZW6EqChK7m8o12Lt3f/0cz46npEgSAUj
         GBgW4PBgsTsUDmLUdIwDrgRnGI+Ryl3ray71Z7ZBiqbzIfZV4WAVC6q8klhKTVAQNYn5
         NHy/faQ5o1VfvJFJpTPlqkhjHPupUeASNxfJQ2y26o6+q5O4A4h88HTzLJ+f+7fDoSTv
         Z/qFDF17uSPvOPpne87XPBaBXIzQzdNZ+MZMpPrFAiItRraoN21PuxO+GCPjPz8HtxEb
         /DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4p4Tyls6g4Qu2sOGu6JLVBxQfSl2NsUML3/gJqhP/t4=;
        b=yYSghVZ2PyMzAYF9tnHTy3KSrQvIiEs9YVxRfGT2CcbkeGqvWr2N7xmC1snWIGjsOw
         S1ghDbnHWWhMNolrBl3iuZQfbQFoETjYSYDGv41ZR6vtHdL3XqTrEV9CnbB3TETB4b73
         5FZs7T3PruGYPWAVRzpzrhDmHbdkf0fqHdawafTYNFyB/NjtlIVWr6r01llPJgwYz5Dy
         gy824/ypoLYWNrvrGJtH+kQQSJqkdpio4XjHrXhNB1FZjDdWYtuuUKwsa4tsF/of6W5h
         aOM1y1CAhXJcG+kYedsxdG+D3E8BrQsIk9ktgRtG92ATXwb4oX5yu+2L7lQOAW597PpF
         cIbA==
X-Gm-Message-State: AOAM533ZIl5SHbdf3cmZFn/nyXyK+99FjAgdRGRiiozIdR+sAxPxS94i
        z9CpDQRFao5PWgL7tW/pVnmrovdWs9j8dHlLtLLAmNe7qOkWo3BAS7Ns+OuaIzVSZcP9yb104g/
        FRmNk/4/ioEU+wat2CXuNYttpHt268o3sZ7An0D0OEJarnmpnqSIOJGFMsXXrIuI=
X-Google-Smtp-Source: ABdhPJylDakc8zhaAUGtFSK3g9hwD7N1OSdcO/2z+pGSv5EvtVJxUeGvaprF0XGWCul5rzeH863hTiw+eBLhlw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:b398:b0:1bc:3ab0:cea7 with SMTP
 id e24-20020a17090ab39800b001bc3ab0cea7mr2029888pjr.222.1645697350915; Thu,
 24 Feb 2022 02:09:10 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:41 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
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
In the process of writing the new tests [1], I noticed some failures of
the form:

  # rm the submodule's working tree directory.
  $ git rm submodule
  [...]

  # Do a fetch that requires running a child process from the submodule.
  $ git fetch --recurse-submodules same-name-1 
  [...]

  # Fatal error tells us that we cannot chdir to the deleted working
    tree.
  fatal: cannot chdir to '../../../submodule': No such file or directory

This happens because submodules set/unset a value for core.worktree when
they are checked out/"un-checked out" (see submodule_move_head() and
connect_work_tree_and_git_dir()), but "git rm" doesn't know that
core.worktree should be updated.

I've worked around this by passing "--work-tree=." to the child process
[2], but this feels like a hack, especially because this bug should
affect all child processes in a "git rm"-ed submodule (this probably
includes the "git branch" processes in gc/branch-recurse-submodules, but
I haven't confirmed it yet). Some more comprehensive solutions that
could be future work are:

- Teach "git [add|rm]" to unset core.worktree (the reverse operation,
  "git restore", should already do the correct thing). This won't detect
  submodules removed with "rm -r" though.
- Teach submodule child processes to ignore stale core.worktree values.
- Do more things in-core instead of using child processes (avoiding the
  failing chdir() call).

I'm not sure what future work we should pursue, or even if the
"--work-tree=." workaround is even good, so I'd appreciate feedback
here.

[1] There is a similar, preexisting test that also removes the
submodules. However, that test isn't affected because it invokes "git
checkout" after doing "git rm".
[2] Since the submodule has a git dir but no working tree, I also tried
working around the bug by passing "--bare". However, this doesn't work
because work tree settings override "bare-ness" settings, as described
by t/t1510-repo-setup.sh.

 Documentation/fetch-options.txt |  26 ++--
 Documentation/git-fetch.txt     |  10 +-
 builtin/fetch.c                 |  14 +-
 submodule.c                     | 125 +++++++++++++--
 submodule.h                     |  12 +-
 t/t5526-fetch-submodules.sh     | 260 +++++++++++++++++++++++++++++++-
 6 files changed, 404 insertions(+), 43 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874..38dad13683 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -185,15 +185,23 @@ endif::git-pull[]
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
index f7abbc31ff..faaf89f637 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2122,13 +2122,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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
index 03af223aba..d60f877b1f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -811,6 +811,16 @@ static const char *default_name_or_path(const char *path_or_name)
  * member of the changed submodule string_list_item.
  */
 struct changed_submodule_data {
+	/*
+	 * The first superproject commit in the rev walk that points to the
+	 * submodule.
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
@@ -818,6 +828,7 @@ struct changed_submodule_data {
 static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
 {
 	oid_array_clear(&cs_data->new_commits);
+	free(cs_data->path);
 }
 
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
@@ -865,6 +876,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!item->util)
 			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
 		cs_data = item->util;
+		cs_data->super_oid = commit_oid;
+		cs_data->path = xstrdup(p->two->path);
 		oid_array_append(&cs_data->new_commits, &p->two->oid);
 	}
 }
@@ -1253,14 +1266,33 @@ void check_for_new_submodule_commits(struct object_id *oid)
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
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_repo_git_path(&buf, r, "modules/");
+	return file_exists(buf.buf) && !is_empty_dir(buf.buf);
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
@@ -1333,7 +1365,8 @@ int submodule_touches_in_range(struct repository *r,
 }
 
 struct submodule_parallel_fetch {
-	int count;
+	int index_count;
+	int changed_count;
 	struct strvec args;
 	struct repository *r;
 	const char *prefix;
@@ -1343,6 +1376,7 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct string_list seen_submodule_names;
 
 	/* Pending fetches by OIDs */
 	struct fetch_task **oid_fetch_tasks;
@@ -1353,6 +1387,7 @@ struct submodule_parallel_fetch {
 #define SPF_INIT { \
 	.args = STRVEC_INIT, \
 	.changed_submodule_names = STRING_LIST_INIT_DUP, \
+	.seen_submodule_names = STRING_LIST_INIT_DUP, \
 	.submodules_with_errors = STRBUF_INIT, \
 }
 
@@ -1390,6 +1425,7 @@ struct fetch_task {
 	const struct submodule *sub;
 	unsigned free_sub : 1; /* Do we need to free the submodule? */
 	const char *default_argv;
+	struct strvec git_args;
 
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
@@ -1425,6 +1461,8 @@ static void fetch_task_release(struct fetch_task *p)
 	if (p->repo)
 		repo_clear(p->repo);
 	FREE_AND_NULL(p->repo);
+
+	strvec_clear(&p->git_args);
 }
 
 static struct repository *get_submodule_repo_for(struct repository *r,
@@ -1463,6 +1501,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 		task->free_sub = 1;
 	}
 
+	if (string_list_lookup(&spf->seen_submodule_names, task->sub->name))
+		goto cleanup;
+
 	switch (get_fetch_recurse_config(task->sub, spf))
 	{
 	default:
@@ -1493,10 +1534,12 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
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
@@ -1511,7 +1554,7 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 
-			spf->count++;
+			spf->index_count++;
 			return task;
 		} else {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
@@ -1539,11 +1582,64 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
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
+		 * NEEDSWORK: A submodule unpopulated by "git rm" will
+		 * have core.worktree set, but the actual core.worktree
+		 * directory won't exist, causing the child process to
+		 * fail. Forcibly set --work-tree until we get smarter
+		 * handling for core.worktree in unpopulated submodules.
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
@@ -1553,6 +1649,8 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 		cp->git_cmd = 1;
 		strvec_init(&cp->args);
+		if (task->git_args.nr)
+			strvec_pushv(&cp->args, task->git_args.v);
 		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, task->default_argv);
 		strvec_push(&cp->args, "--submodule-prefix");
@@ -1564,6 +1662,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		*task_cb = task;
 
 		strbuf_release(&submodule_prefix);
+		string_list_insert(&spf->seen_submodule_names, task->sub->name);
 		return 1;
 	}
 
@@ -1678,11 +1777,11 @@ static int fetch_finish(int retvalue, struct strbuf *err,
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
index ee4dd5a4a9..639290d30d 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -15,8 +15,9 @@ pwd=$(pwd)
 
 check_sub() {
 	NEW_HEAD=$1 &&
+	SUPER_HEAD=$2 &&
 	cat <<-EOF >$pwd/expect.err.sub
-	Fetching submodule submodule
+	Fetching submodule submodule${SUPER_HEAD:+ at commit $SUPER_HEAD}
 	From $pwd/submodule
 	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
 	EOF
@@ -24,8 +25,9 @@ check_sub() {
 
 check_deep() {
 	NEW_HEAD=$1 &&
+	SUB_HEAD=$2 &&
 	cat <<-EOF >$pwd/expect.err.deep
-	Fetching submodule submodule/subdir/deepsubmodule
+	Fetching submodule submodule/subdir/deepsubmodule${SUB_HEAD:+ at commit $SUB_HEAD}
 	From $pwd/deepsubmodule
 	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
 	EOF
@@ -418,6 +420,155 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	verify_fetch_result actual.err
 '
 
+# Test that we can fetch submodules in other branches by running fetch
+# in a commit that has no submodules.
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
+	check_sub $sub_head $super_head &&
+	check_deep $deep_head $sub_head &&
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
+	check_sub $sub_head $super_head &&
+	check_deep $deep_head $sub_head &&
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
+	check_super $super_head &&
+	# Neither should be fetched because the submodule is inactive
+	rm expect.err.sub &&
+	rm expect.err.deep &&
+	verify_fetch_result actual.err
+'
+
+# In downstream, init "submodule2", but do not check it out while
+# fetching. This lets us assert that unpopulated submodules can be
+# fetched.
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
+	deep_head=$(git -C submodule/subdir/deepsubmodule rev-parse --short HEAD) &&
+	sub_head=$(git -C submodule rev-parse --short HEAD) &&
+	sub2_head=$(git -C submodule2 rev-parse --short HEAD) &&
+	super_head=$(git rev-parse --short HEAD) &&
+	super_sub2_only_head=$(git rev-parse --short super-sub2-only) &&
+
+	# Use test_cmp manually because verify_fetch_result does not
+	# consider submodule2. All the repos should be fetched, but only
+	# submodule2 should be read from a commit
+	cat <<-EOF > expect.err.combined &&
+	From $pwd/.
+	   OLD_HEAD..$super_head  super           -> origin/super
+	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
+	Fetching submodule submodule
+	From $pwd/submodule
+	   OLD_HEAD..$sub_head  sub        -> origin/sub
+	Fetching submodule submodule/subdir/deepsubmodule
+	From $pwd/deepsubmodule
+	   OLD_HEAD..$deep_head  deep       -> origin/deep
+	Fetching submodule submodule2 at commit $super_sub2_only_head
+	From $pwd/submodule2
+	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
+	EOF
+	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
+	test_cmp expect.err.combined actual.err.cmp
+'
+
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_submodule_commits &&
 	echo a >> file &&
@@ -860,4 +1011,109 @@ test_expect_success 'recursive fetch after deinit a submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup repo with upstreams that share a submodule name' '
+	mkdir same-name-1 &&
+	(
+		cd same-name-1 &&
+		git init &&
+		test_commit --no-tag a
+	) &&
+	git clone same-name-1 same-name-2 &&
+	# same-name-1 and same-name-2 both add a submodule with the
+	# name "submodule"
+	(
+		cd same-name-1 &&
+		mkdir submodule &&
+		git -C submodule init &&
+		test_commit -C submodule --no-tag a1 &&
+		git submodule add "$pwd/same-name-1/submodule" &&
+		git add submodule &&
+		git commit -m "super-a1"
+	) &&
+	(
+		cd same-name-2 &&
+		mkdir submodule &&
+		git -C submodule init &&
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
+	test_when_finished "git -C same-name-downstream checkout master" &&
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
+		git checkout same-name-2/master &&
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
+		git checkout master &&
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
+		# rm"-ed directory, overwrite the invalid value.
+		git --work-tree=. cat-file -e $head1 &&
+		test_must_fail git --work-tree=. cat-file -e $head2
+	)
+'
+
 test_done
-- 
2.33.GIT

