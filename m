Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521CBC53210
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjADVzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbjADVyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:54:51 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152941EAEC
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:54:50 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o21-20020a17090aac1500b00226349b1e06so9810916pjq.4
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BNqSfQOU3Hx8scQJxkrLIOVgoTWnsofjmodcNJQEKw=;
        b=enuydBnchezqfZNg+wjYabfVRM+pHK/2zMwJvbgRrBsczp/yqJ1dBjXNMFdA599kM+
         RF6z/CR6hgyXvI/sobfKDelkP3aat1AEKLkcAdH1PLibTy5l39EwKhvIuyJSzyCoUK3+
         6Cak2+SYnpLMZ7YN0WmN+0okUpdDO5kzkxCgbWnRtTu2Wmx0EC2Q1oI9n7lIemc7Jtck
         rOfvBUkLnX/tNqKjJ/guKXnp3+pKKgfuJ03hh1nNKJKT+bFoTMLYYkJUGUvvTv+vdScL
         Tsz4jGPf6lN93lgjK1JfVb+eHJU2CbjYvN8NVdCfIR3DjsobTfTBEBoq8soKG7WNYRVn
         W7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BNqSfQOU3Hx8scQJxkrLIOVgoTWnsofjmodcNJQEKw=;
        b=L2lXE6h3y5oJOE+LwoTuZ2lcuCQ/dBMy91cfdMK7HPfGYSPcF5GBXts7TEufzHLuhB
         loCu3qcffP8P5IjUagfmYmixsEmb55ubrRKCj81KVGXdr7whjBsX+E7GDn8Y8l5v+Avn
         MAX4q3U4NHReXxmF8HHwezIfUqhQrt0EHbwccWeNvAzb4pB4+rfPbMRgpuZey8xC3HZ8
         a/Udb0YSQ74EG5vogk2fnCLEXURhb2yB8cS0EH4D6xrQVE3LLKS+AUUWPRqshGWNO5Iy
         /Ur5GckUYzgHEGQs4MfxccvP0euEsv+eTcBHa50bYfXxFen9H5Bk1uYjI5HXHvqkddL1
         ZQkQ==
X-Gm-Message-State: AFqh2koBv0YfLfU/swG8A0FfBdkkljUwTkV+TubCoRhqCwXdTfZVQhny
        mMn36xdICTkPJqgnvZbhlfO36ajZ0ljfz63Tp4ZAqELL7AKvoXXiHOistebfPDGwnHDGGjU0ef2
        0eRwQOxvlZGDEyCCN5e/BbcjvLyPFXE/SsacpppS6iLlQFwxVWhvR8l70DPewjj+zXw==
X-Google-Smtp-Source: AMrXdXvrj1Rnv4iv6HZt29HrpXcC1ABw4U+glGq32bdbzxpvDs3fq5wq3Yq4Ug+tciasHG72DySXSn4t+slWOxw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:4483:b0:57f:bdba:6d25 with SMTP
 id cu3-20020a056a00448300b0057fbdba6d25mr2821619pfb.48.1672869289313; Wed, 04
 Jan 2023 13:54:49 -0800 (PST)
Date:   Wed,  4 Jan 2023 21:54:14 +0000
In-Reply-To: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104215415.1083526-6-calvinwan@google.com>
Subject: [PATCH v5 5/6] diff-lib: parallelize run_diff_files for submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the iteration of the index entries in run_diff_files, whenever
a submodule is found and needs its status checked, a subprocess is
spawned for it. Instead of spawning the subprocess immediately and
waiting for its completion to continue, hold onto all submodules and
relevant information in a list. Then use that list to create tasks for
run_processes_parallel. Subprocess output is duplicated and passed to
status_pipe_output which stores it to be parsed on completion of the
subprocess.

Add config option submodule.diffJobs to set the maximum number
of parallel jobs. The option defaults to 1 if unset. If set to 0, the
number of jobs is set to online_cpus().

Since run_diff_files is called from many different commands, I chose
to grab the config option in the function rather than adding variables
to every git command and then figuring out how to pass them all in.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/config/submodule.txt |  12 +++
 diff-lib.c                         |  84 +++++++++++++--
 submodule.c                        | 168 +++++++++++++++++++++++++++++
 submodule.h                        |   9 ++
 t/t4027-diff-submodule.sh          |  19 ++++
 t/t7506-status-submodule.sh        |  19 ++++
 6 files changed, 304 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 6490527b45..3209eb8117 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -93,6 +93,18 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.diffJobs::
+	Specifies how many submodules are diffed at the same time. A
+	positive integer allows up to that number of submodules diffed
+	in parallel. A value of 0 will give some reasonable default.
+	If unset, it defaults to 1. The diff operation is used by many
+	other git commands such as add, merge, diff, status, stash and
+	more. Note that the expensive part of the diff operation is
+	reading the index from cache or memory. Therefore multiple jobs
+	may be detrimental to performance if your hardware does not
+	support parallel reads or if the number of jobs greatly exceeds
+	the amount of supported reads.
+
 submodule.alternateLocation::
 	Specifies how the submodules obtain alternates when submodules are
 	cloned. Possible values are `no`, `superproject`.
diff --git a/diff-lib.c b/diff-lib.c
index 64583fded0..f51ea07f36 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "fsmonitor.h"
 #include "commit-reach.h"
+#include "config.h"
 
 /*
  * diff-files
@@ -65,18 +66,23 @@ static int check_removed(const struct index_state *istate, const struct cache_en
  * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
  * option is set, the caller does not only want to know if a submodule is
  * modified at all but wants to know all the conditions that are met (new
- * commits, untracked content and/or modified content).
+ * commits, untracked content and/or modified content). If
+ * defer_submodule_status bit is set, dirty_submodule will be left to the
+ * caller to set. defer_submodule_status can also be set to 0 in this
+ * function if there is no need to check if the submodule is modified.
  */
 static int match_stat_with_submodule(struct diff_options *diffopt,
 				     const struct cache_entry *ce,
 				     struct stat *st, unsigned ce_option,
-				     unsigned *dirty_submodule)
+				     unsigned *dirty_submodule, int *defer_submodule_status,
+				     unsigned *ignore_untracked)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
 	struct diff_flags orig_flags;
+	int defer = 0;
 
 	if (!S_ISGITLINK(ce->ce_mode))
-		return changed;
+		goto ret;
 
 	orig_flags = diffopt->flags;
 	if (!diffopt->flags.override_submodule_config)
@@ -86,11 +92,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 		goto cleanup;
 	}
 	if (!diffopt->flags.ignore_dirty_submodules &&
-	    (!changed || diffopt->flags.dirty_submodules))
-		*dirty_submodule = is_submodule_modified(ce->name,
+	    (!changed || diffopt->flags.dirty_submodules)) {
+		if (defer_submodule_status && *defer_submodule_status) {
+			defer = 1;
+			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
+		} else {
+			*dirty_submodule = is_submodule_modified(ce->name,
 					 diffopt->flags.ignore_untracked_in_submodules);
+		}
+	}
 cleanup:
 	diffopt->flags = orig_flags;
+ret:
+	if (defer_submodule_status)
+		*defer_submodule_status = defer;
 	return changed;
 }
 
@@ -102,6 +117,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
+	struct string_list submodules = STRING_LIST_INIT_NODUP;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -226,6 +242,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			newmode = ce->ce_mode;
 		} else {
 			struct stat st;
+			unsigned ignore_untracked = 0;
+			int defer_submodule_status = !!revs->repo;
 
 			changed = check_removed(istate, ce, &st);
 			if (changed) {
@@ -247,8 +265,26 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
-							    ce_option, &dirty_submodule);
+							    ce_option, &dirty_submodule,
+							    &defer_submodule_status,
+							    &ignore_untracked);
 			newmode = ce_mode_from_stat(ce, st.st_mode);
+			if (defer_submodule_status) {
+				struct submodule_status_util tmp = {
+					.changed = changed,
+					.dirty_submodule = 0,
+					.ignore_untracked = ignore_untracked,
+					.newmode = newmode,
+					.ce = ce,
+					.path = ce->name,
+				};
+				struct string_list_item *item;
+
+				item = string_list_append(&submodules, ce->name);
+				item->util = xmalloc(sizeof(tmp));
+				memcpy(item->util, &tmp, sizeof(tmp));
+				continue;
+			}
 		}
 
 		if (!changed && !dirty_submodule) {
@@ -267,6 +303,40 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			    ce->name, 0, dirty_submodule);
 
 	}
+	if (submodules.nr > 0) {
+		int parallel_jobs;
+		if (git_config_get_int("submodule.diffjobs", &parallel_jobs))
+			parallel_jobs = 1;
+		else if (!parallel_jobs)
+			parallel_jobs = online_cpus();
+		else if (parallel_jobs < 0)
+			die(_("submodule.diffjobs cannot be negative"));
+
+		if (get_submodules_status(&submodules, parallel_jobs))
+			die(_("submodule status failed"));
+		for (size_t i = 0; i < submodules.nr; i++) {
+			struct submodule_status_util *util = submodules.items[i].util;
+			struct cache_entry *ce = util->ce;
+			unsigned int oldmode;
+			const struct object_id *old_oid, *new_oid;
+
+			if (!util->changed && !util->dirty_submodule) {
+				ce_mark_uptodate(ce);
+				mark_fsmonitor_valid(istate, ce);
+				if (!revs->diffopt.flags.find_copies_harder)
+					continue;
+			}
+			oldmode = ce->ce_mode;
+			old_oid = &ce->oid;
+			new_oid = util->changed ? null_oid() : &ce->oid;
+			diff_change(&revs->diffopt, oldmode, util->newmode,
+				    old_oid, new_oid,
+				    !is_null_oid(old_oid),
+				    !is_null_oid(new_oid),
+				    ce->name, 0, util->dirty_submodule);
+		}
+	}
+	string_list_clear(&submodules, 1);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	trace_performance_since(start, "diff-files");
@@ -314,7 +384,7 @@ static int get_stat_data(const struct index_state *istate,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, NULL, NULL);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = null_oid();
diff --git a/submodule.c b/submodule.c
index 768d4b4cd7..a0ca646d9b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1369,6 +1369,17 @@ int submodule_touches_in_range(struct repository *r,
 	return ret;
 }
 
+struct submodule_parallel_status {
+	size_t index_count;
+	int result;
+
+	struct string_list *submodule_names;
+
+	/* Pending statuses by OIDs */
+	struct status_task **oid_status_tasks;
+	int oid_status_tasks_nr, oid_status_tasks_alloc;
+};
+
 struct submodule_parallel_fetch {
 	/*
 	 * The index of the last index entry processed by
@@ -1451,6 +1462,12 @@ struct fetch_task {
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
 
+struct status_task {
+	const char *path;
+	struct strbuf out;
+	int ignore_untracked;
+};
+
 /**
  * When a submodule is not defined in .gitmodules, we cannot access it
  * via the regular submodule-config. Create a fake submodule, which we can
@@ -1909,6 +1926,25 @@ static int parse_status_porcelain(char *str, size_t len,
 	return 0;
 }
 
+static void parse_status_porcelain_strbuf(struct strbuf *buf,
+				   unsigned *dirty_submodule,
+				   int ignore_untracked)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	string_list_split(&list, buf->buf, '\n', -1);
+
+	for_each_string_list_item(item, &list) {
+		if (parse_status_porcelain(item->string,
+					   strlen(item->string),
+					   dirty_submodule,
+					   ignore_untracked))
+			break;
+	}
+	string_list_clear(&list, 0);
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1962,6 +1998,138 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	return dirty_submodule;
 }
 
+static struct status_task *
+get_status_task_from_index(struct submodule_parallel_status *sps,
+			   struct strbuf *err)
+{
+	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
+		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
+		struct status_task *task;
+		struct strbuf buf = STRBUF_INIT;
+		const char *git_dir;
+
+		strbuf_addf(&buf, "%s/.git", util->path);
+		git_dir = read_gitfile(buf.buf);
+		if (!git_dir)
+			git_dir = buf.buf;
+		if (!is_git_directory(git_dir)) {
+			if (is_directory(git_dir))
+				die(_("'%s' not recognized as a git repository"), git_dir);
+			strbuf_release(&buf);
+			/* The submodule is not checked out, so it is not modified */
+			util->dirty_submodule = 0;
+			continue;
+		}
+		strbuf_release(&buf);
+
+		task = xmalloc(sizeof(*task));
+		task->path = util->path;
+		task->ignore_untracked = util->ignore_untracked;
+		strbuf_init(&task->out, 0);
+		sps->index_count++;
+		return task;
+	}
+	return NULL;
+}
+
+static int get_next_submodule_status(struct child_process *cp,
+				     struct strbuf *err, void *data,
+				     void **task_cb)
+{
+	struct submodule_parallel_status *sps = data;
+	struct status_task *task = get_status_task_from_index(sps, err);
+
+	if (!task)
+		return 0;
+
+	child_process_init(cp);
+	prepare_submodule_repo_env_in_gitdir(&cp->env);
+
+	strvec_init(&cp->args);
+	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
+	if (task->ignore_untracked)
+		strvec_push(&cp->args, "-uno");
+
+	prepare_submodule_repo_env(&cp->env);
+	cp->git_cmd = 1;
+	cp->dir = task->path;
+	*task_cb = task;
+	return 1;
+}
+
+static int status_start_failure(struct strbuf *err,
+				void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+	struct status_task *task = task_cb;
+
+	sps->result = 1;
+	strbuf_addf(err,
+	    _("could not run 'git status --porcelain=2' in submodule %s"),
+	    task->path);
+	return 0;
+}
+
+static void status_duplicate_output(struct strbuf *out,
+				    size_t offset,
+				    void *cb, void *task_cb)
+{
+	struct status_task *task = task_cb;
+
+	strbuf_add(&task->out, out->buf + offset, out->len - offset);
+	strbuf_setlen(out, offset);
+}
+
+static int status_finish(int retvalue, struct strbuf *err,
+			 void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+	struct status_task *task = task_cb;
+	struct string_list_item *it =
+		string_list_lookup(sps->submodule_names, task->path);
+	struct submodule_status_util *util = it->util;
+
+	if (retvalue) {
+		sps->result = 1;
+		strbuf_addf(err,
+		    _("'git status --porcelain=2' failed in submodule %s"),
+		    task->path);
+	}
+
+	parse_status_porcelain_strbuf(&task->out,
+			      &util->dirty_submodule,
+			      util->ignore_untracked);
+
+	free(task);
+
+	return 0;
+}
+
+int get_submodules_status(struct string_list *submodules,
+			  int max_parallel_jobs)
+{
+	struct submodule_parallel_status sps = {
+		.submodule_names = submodules,
+	};
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/status",
+
+		.processes = max_parallel_jobs,
+
+		.get_next_task = get_next_submodule_status,
+		.start_failure = status_start_failure,
+		.duplicate_output = status_duplicate_output,
+		.task_finished = status_finish,
+		.data = &sps,
+	};
+
+	string_list_sort(sps.submodule_names);
+	run_processes_parallel(&opts);
+
+	return sps.result;
+}
+
 int submodule_uses_gitfile(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
diff --git a/submodule.h b/submodule.h
index b52a4ff1e7..08d278a414 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,13 @@ struct submodule_update_strategy {
 	.type = SM_UPDATE_UNSPECIFIED, \
 }
 
+struct submodule_status_util {
+	int changed, ignore_untracked;
+	unsigned dirty_submodule, newmode;
+	struct cache_entry *ce;
+	const char *path;
+};
+
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
@@ -94,6 +101,8 @@ int fetch_submodules(struct repository *r,
 		     int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs);
+int get_submodules_status(struct string_list *submodules,
+			  int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 40164ae07d..e08ee315a7 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -34,6 +34,25 @@ test_expect_success setup '
 	subtip=$3 subprev=$2
 '
 
+test_expect_success 'diff in superproject with submodules respects parallel settings' '
+	test_when_finished "rm -f trace.out" &&
+	(
+		GIT_TRACE=$(pwd)/trace.out git diff &&
+		grep "1 tasks" trace.out &&
+		>trace.out &&
+
+		git config submodule.diffJobs 8 &&
+		GIT_TRACE=$(pwd)/trace.out git diff &&
+		grep "8 tasks" trace.out &&
+		>trace.out &&
+
+		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 diff &&
+		grep "preparing to run up to [0-9]* tasks" trace.out &&
+		! grep "up to 0 tasks" trace.out &&
+		>trace.out
+	)
+'
+
 test_expect_success 'git diff --raw HEAD' '
 	hexsz=$(test_oid hexsz) &&
 	git diff --raw --abbrev=$hexsz HEAD >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d050091345..52a82b703f 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -412,4 +412,23 @@ test_expect_success 'status with added file in nested submodule (short)' '
 	EOF
 '
 
+test_expect_success 'status in superproject with submodules respects parallel settings' '
+	test_when_finished "rm -f trace.out" &&
+	(
+		GIT_TRACE=$(pwd)/trace.out git status &&
+		grep "1 tasks" trace.out &&
+		>trace.out &&
+
+		git config submodule.diffJobs 8 &&
+		GIT_TRACE=$(pwd)/trace.out git status &&
+		grep "8 tasks" trace.out &&
+		>trace.out &&
+
+		GIT_TRACE=$(pwd)/trace.out git -c submodule.diffJobs=0 status &&
+		grep "preparing to run up to [0-9]* tasks" trace.out &&
+		! grep "up to 0 tasks" trace.out &&
+		>trace.out
+	)
+'
+
 test_done
-- 
2.39.0.314.g84b9a713c41-goog

