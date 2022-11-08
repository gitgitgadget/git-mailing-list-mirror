Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE486C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiKHSmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiKHSm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:42:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A05F86E
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:42:25 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l63-20020a639142000000b0046f5bbb7372so8314727pge.23
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2t4oC9JaydK5pH9v+DX5+suSIU5L79UtLx8XGatGfU=;
        b=qFx7/uqUEcS+DRaLxHSx0S7ZLSS6Cu+chhSKKkTbUFJE87ycacRampAhv2vvHpV88T
         MTvmvIO9E1L/IjHoE4mXG7kL+cbj9vMMIulpdZa84gWSVMH/i699rCKOOFu/NorCVJ2M
         sXC+wG0/J7B9rVF7eUbYcppepfx05bMdMqUK+RQczgbaFMJ7Dc5JncGKiKv80pda0T3E
         UD5GFEcB3425e7RVFJ/kfvEnGMP8Qrpc3FrUhu8HShnMaMZWtVDGJpONUxHmjUGyNCq7
         2eeD09R9APqqJAnUIegevTL9aXVe+thxW9c/uIpP4Xebxks2z61dpc7WH1aJoq6RtKxM
         Erxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2t4oC9JaydK5pH9v+DX5+suSIU5L79UtLx8XGatGfU=;
        b=z6boYxa4HoUqYdeF/HbDj58mDn9p4ik+1tsloEj1ABp8WuP+MwX4a+Ri/PMq8P+w/I
         leY/hIPL7fnG3em1y/ia/TpHIyrr+sPI+uR6PkR/fXKBsMMXKRbzzPVaTwuDWwmAt6s5
         /r2sz/Ekf+3kDTgIWjIUsj+/kYH/ivyCt/ja0/XEHAv/S+yjQc+ssHENCmWN6zUOpbOP
         QEDB9rFb/lE6LRpsm2bNXsg/LXEKomdSEsTvv8wl7BAcAuuPI0/wNNaIs8wDgTK5MhRK
         skgWwhS6+Vt4QmNJ85OChNrZ7Z07AwQ4i83MMbt+wSLmzEJt8lpahMGs/Vbn6Ddzi6el
         cfpg==
X-Gm-Message-State: ACrzQf2h0LBg3GJhp2dlwX/bzpDCwkmcIDsKmA0qYZ+5zCH5tHkG0X14
        R4640bhCKiGswJZy2OttauO4owRdWU32VqwaYXbXkVP5DjohfU6Xj8vG4R6HvSF+MafRetlMJbY
        Cv8NMrgmjDfn7eiEu94m+V1LbH2px3ThELKkFxOzBT6XKFfK0C3kQfjDIqvHr4e46dQ==
X-Google-Smtp-Source: AMsMyM59rO7BZfzmFDHZpe+0o4mhN4PS8msnwBIislUd3NdWXXS31PtZGRd/bfq9R1/vMfoyrxi9qHogozpYnvQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2489:b0:56d:2d20:d01e with SMTP
 id c9-20020a056a00248900b0056d2d20d01emr54909897pfv.65.1667932945264; Tue, 08
 Nov 2022 10:42:25 -0800 (PST)
Date:   Tue,  8 Nov 2022 18:42:00 +0000
In-Reply-To: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108184200.2813458-6-calvinwan@google.com>
Subject: [PATCH v4 5/5] diff-lib: parallelize run_diff_files for submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
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
 diff-lib.c                         |  80 +++++++++++++--
 submodule.c                        | 154 +++++++++++++++++++++++++++++
 submodule.h                        |   9 ++
 t/t4027-diff-submodule.sh          |  19 ++++
 t/t7506-status-submodule.sh        |  19 ++++
 6 files changed, 287 insertions(+), 6 deletions(-)

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
index f5257c0c71..30a3d9a2b5 100644
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
@@ -248,8 +265,25 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
@@ -268,6 +302,40 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
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
@@ -315,7 +383,7 @@ static int get_stat_data(const struct index_state *istate,
 			return -1;
 		}
 		changed = match_stat_with_submodule(diffopt, ce, &st,
-						    0, dirty_submodule);
+						    0, dirty_submodule, NULL, NULL);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
 			oid = null_oid();
diff --git a/submodule.c b/submodule.c
index fd3385620c..763a05d523 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1363,6 +1363,18 @@ int submodule_touches_in_range(struct repository *r,
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
 struct submodule_parallel_fetch {
 	/*
 	 * The index of the last index entry processed by
@@ -1445,6 +1457,12 @@ struct fetch_task {
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
 
+struct status_task {
+	const char *path;
+	unsigned dirty_submodule;
+	int ignore_untracked;
+};
+
 /**
  * When a submodule is not defined in .gitmodules, we cannot access it
  * via the regular submodule-config. Create a fake submodule, which we can
@@ -1956,6 +1974,142 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
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
+		struct status_task tmp = {
+			.path = ce->name,
+			.dirty_submodule = util->dirty_submodule,
+			.ignore_untracked = util->ignore_untracked,
+		};
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
+		memcpy(task, &tmp, sizeof(*task));
+		sps->index_count++;
+		return task;
+	}
+	return NULL;
+}
+
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
+			        void *cb, void *task_cb)
+{
+	struct submodule_parallel_status *sps = cb;
+
+	sps->result = 1;
+	return 0;
+}
+
+static void status_duplicate_output(struct strbuf *process_out,
+				    struct strbuf *out,
+				    void *cb, void *task_cb)
+{
+	struct status_task *task = task_cb;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	string_list_split(&list, process_out->buf, '\n', -1);
+
+	for_each_string_list_item(item, &list) {
+		if (parse_status_porcelain(item->string,
+				   strlen(item->string),
+				   &task->dirty_submodule,
+				   task->ignore_untracked))
+			break;
+	}
+	string_list_clear(&list, 0);
+	strbuf_reset(out);
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
+	struct submodule_parallel_status sps = {
+                .r = r,
+                .submodule_names = submodules,
+        };
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
2.38.1.431.g37b22c650d-goog

