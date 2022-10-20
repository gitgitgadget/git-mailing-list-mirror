Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CDC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJTX0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJTX0E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:26:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6391285FC
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:59 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p29-20020a056a0026dd00b00562f01c165cso402069pfw.20
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jbwnq2kpTZFUte7SmCsp2VL4OUUaUxEPqKHBUJAZ7Ww=;
        b=AOgO6J3oWz0yo1zrTOXp92QPeEyAg3eCyivnbowpx4MZtGiPjka5Ehye8M8mO/7c1b
         VindLPv/E7xhAVf6TLD4kDHnulwrysjgcwnISffBxhvGDAkmdZn40293FnDQocNs3vL9
         lTXTIhBi59Ne88PyQGw9pmn1TdoUIzCSCZZ7EW+gYlDD8MQSE/U0Jbc9AYF7mV0pI1v2
         bSSf9eur5SAlaWVGkPYXcGGfV+oX3tK9td1s5pVIWug8HZia4mrp+VjHuSP7/HAM7lsJ
         xo4D3jQSm5ieeBCFwn/1vIf82swksa1ixRi5ZxPhIYmJU8IOKPX2rJEFY5dinC90c+ak
         bO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jbwnq2kpTZFUte7SmCsp2VL4OUUaUxEPqKHBUJAZ7Ww=;
        b=3zCxko1esuAuEx/5jG1i0ffRjpV6lp5lX3SOx8Fv8UlcZqVADZ6VLeJvXeL8plTP9B
         ZvEKkdSBPlW8fHe/wT5V2mNfeWYVa12vS78B21EmrIABibveYX22Uzq2BMveYA5InJ0o
         XMK/UyfZzORvUByj6IT1zH9nfnd4cx3GamtCtWkipDsr18vRk+tW287Ij0fmlrT7betJ
         axcmYD2C9nsYCRG0FMSe7hwebgmsJAAM0J3M2mMuaEP5+5QuyD8C070cGDYHS5aNLtrz
         DqleUbcn7Ix3UKD3BOOrNP6USogghJAXYWH/PhZLz01qn6f1aIcexu0GNntk0Qyf/iGt
         +COQ==
X-Gm-Message-State: ACrzQf0VTx7HP5XFja6Gjfj9AW/VVYaIj6sPbOtBMrjWeGP0NXGCYuUZ
        oqLhJ7he63BDvPJ6Mf+/sAmMnfg/B9jnEeyOy9l0zEi4NsTPuF3IdYuCeNHZUv7jvdKxwlCYEe4
        1X6b6cUyYix+tueDzWl9sf9AMP0XDZUsG4HnvC9lGiiCnvtlgFqNRFONenEICANaHCQ==
X-Google-Smtp-Source: AMsMyM70jcsKZHlctdtzEnO1gc7N2fIe9En5tIJCXGMWF0WNVOQKtSIyLtsb5WzIAJ6B8dNutBcdmJcODYpgrjw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:ec81:b0:185:3cea:6326 with SMTP
 id x1-20020a170902ec8100b001853cea6326mr16460195plg.24.1666308358231; Thu, 20
 Oct 2022 16:25:58 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:32 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-7-calvinwan@google.com>
Subject: [PATCH v3 6/6] diff-lib: parallelize run_diff_files for submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the iteration of the index entries in run_diff_files, whenever
a submodule is found and needs its status checked, a subprocess is
spawned for it. Instead of spawning the subprocess immediately and
waiting for its completion to continue, hold onto all submodules and
relevant information in a list. Then use that list to create tasks for
run_processes_parallel. Subprocess output is piped to
status_pipe_output which parses it. 

Add config option submodule.diffJobs to set the maximum number
of parallel jobs. The option defaults to 1 if unset. If set to 0, the
number of jobs is set to online_cpus().

Since run_diff_files is called from many different commands, I chose
to grab the config option in the function rather than adding variables
to every git command and then figuring out how to pass them all in.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/config/submodule.txt |  12 +++
 diff-lib.c                         |  79 +++++++++++++--
 submodule.c                        | 157 +++++++++++++++++++++++++++++
 submodule.h                        |   9 ++
 t/t4027-diff-submodule.sh          |  19 ++++
 t/t7506-status-submodule.sh        |  19 ++++
 6 files changed, 289 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index 6490527b45..1144a5ad74 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -93,6 +93,18 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.diffJobs::
+	Specifies how many submodules are diffed at the same time. A
+	positive integer allows up to that number of submodules diffed
+	in parallel. A value of 0 will give the number of logical cores.
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
index f5257c0c71..0f30b4e478 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -14,6 +14,7 @@
 #include "dir.h"
 #include "fsmonitor.h"
 #include "commit-reach.h"
+#include "config.h"
 
 /*
  * diff-files
@@ -65,15 +66,20 @@ static int check_removed(const struct index_state *istate, const struct cache_en
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
 		goto ret;
@@ -86,12 +92,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
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
 ret:
+	if (defer_submodule_status)
+		*defer_submodule_status = defer;
 	return changed;
 }
 
@@ -103,6 +117,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	uint64_t start = getnanotime();
 	struct index_state *istate = revs->diffopt.repo->index;
+	struct string_list submodules = STRING_LIST_INIT_NODUP;
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
@@ -227,6 +242,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			newmode = ce->ce_mode;
 		} else {
 			struct stat st;
+			unsigned ignore_untracked = 0;
+			int defer_submodule_status = !!revs->repo;
 
 			changed = check_removed(istate, ce, &st);
 			if (changed) {
@@ -248,8 +265,24 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
+					.ce = ce
+				};
+				struct string_list_item *item;
+				item = string_list_append(&submodules, ce->name);
+				item->util = xmalloc(sizeof(tmp));
+				memcpy(item->util, &tmp, sizeof(tmp));
+				continue;
+			}
 		}
 
 		if (!changed && !dirty_submodule) {
@@ -268,6 +301,40 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
+		if (get_submodules_status(revs->repo, &submodules, parallel_jobs))
+			BUG("submodule status failed");
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
@@ -315,7 +382,7 @@ static int get_stat_data(const struct index_state *istate,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, NULL, NULL);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = null_oid();
diff --git a/submodule.c b/submodule.c
index 289be0fb93..9aa1723a3b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1363,6 +1363,20 @@ int submodule_touches_in_range(struct repository *r,
 	return ret;
 }
 
+struct submodule_parallel_status {
+	size_t index_count;
+	int result;
+
+	struct string_list *submodule_names;
+	struct repository *r;
+
+	/* Pending statuses by OIDs */
+	struct status_task **oid_status_tasks;
+	int oid_status_tasks_nr, oid_status_tasks_alloc;
+};
+
+#define SPS_INIT { 0 }
+
 struct submodule_parallel_fetch {
 	/*
 	 * The index of the last index entry processed by
@@ -1445,6 +1459,13 @@ struct fetch_task {
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
 
+struct status_task {
+	struct repository *repo;
+	const char *path;
+	unsigned dirty_submodule;
+	int ignore_untracked;
+};
+
 /**
  * When a submodule is not defined in .gitmodules, we cannot access it
  * via the regular submodule-config. Create a fake submodule, which we can
@@ -1956,6 +1977,142 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	return dirty_submodule;
 }
 
+static struct status_task *
+get_status_task_from_index(struct submodule_parallel_status *sps,
+			   struct strbuf *err)
+{
+	for (; sps->index_count < sps->submodule_names->nr; sps->index_count++) {
+		struct submodule_status_util *util = sps->submodule_names->items[sps->index_count].util;
+		const struct cache_entry *ce = util->ce;
+		struct status_task *task;
+		struct strbuf buf = STRBUF_INIT;
+		const char *git_dir;
+
+		strbuf_addf(&buf, "%s/.git", ce->name);
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
+		memset(task, 0, sizeof(*task));
+		task->path = ce->name;
+		task->dirty_submodule = util->dirty_submodule;
+		task->ignore_untracked = util->ignore_untracked;
+		sps->index_count++;
+		return task;
+	}
+	return NULL;
+}
+
+
+static int get_next_submodule_status(struct child_process *cp,
+				     struct strbuf *err,
+				     void *data, void **task_cb)
+{
+	struct submodule_parallel_status *sps = data;
+	struct status_task *task = get_status_task_from_index(sps, err);
+
+	if (!task) {
+		return 0;
+	}
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
+	cp->no_stdin = 1;
+	cp->dir = task->path;
+	*task_cb = task;
+	return 1;
+}
+
+static int status_start_failure(struct strbuf *err,
+			        void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+
+	sps->result = 1;
+	return 0;
+}
+
+static void status_pipe_output(struct strbuf *process_out,
+			       void *cb, void *task_cb)
+{
+	struct status_task *task = task_cb;
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	string_list_split(&list, process_out->buf, '\n', -1);
+
+	for (size_t i = 0; i < list.nr; i++) {
+		if (parse_status_porcelain(list.items[i].string,
+				   strlen(list.items[i].string),
+				   &task->dirty_submodule, task->ignore_untracked))
+			break;
+	}
+	string_list_clear(&list, 0);
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
+	util->dirty_submodule = task->dirty_submodule;
+	free(task);
+
+	return 0;
+}
+
+int get_submodules_status(struct repository *r,
+			  struct string_list *submodules,
+			  int max_parallel_jobs)
+{
+	struct submodule_parallel_status sps = SPS_INIT;
+	const struct run_process_parallel_opts opts = {
+		.tr2_category = "submodule",
+		.tr2_label = "parallel/status",
+
+		.processes = max_parallel_jobs,
+		.hide_output = 1,
+
+		.get_next_task = get_next_submodule_status,
+		.start_failure = status_start_failure,
+		.pipe_output = status_pipe_output,
+		.task_finished = status_finish,
+		.data = &sps,
+	};
+
+	sps.r = r;
+
+	if (repo_read_index(r) < 0)
+		die(_("index file corrupt"));
+
+	sps.submodule_names = submodules;
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
index 6a9fec6de1..cbb7231a5d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,6 +41,12 @@ struct submodule_update_strategy {
 	.type = SM_UPDATE_UNSPECIFIED, \
 }
 
+struct submodule_status_util {
+	int changed, ignore_untracked;
+	unsigned dirty_submodule, newmode;
+	struct cache_entry *ce;
+};
+
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
 int is_staging_gitmodules_ok(struct index_state *istate);
@@ -94,6 +100,9 @@ int fetch_submodules(struct repository *r,
 		     int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs);
+int get_submodules_status(struct repository *r,
+			  struct string_list *submodules,
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
index f5426a8e58..dfdfb58bfc 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -410,4 +410,23 @@ test_expect_success 'status with added file in nested submodule (short)' '
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
2.38.0.135.g90850a2211-goog

