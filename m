Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9433360EE1
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921944; cv=none; b=tKS7l/wmYh50GJHlKP07lpaORom17tcVdkcvp+qsN7xDbixTcmzfkEg23GZeNtSvHJM9/tf8N8pltkyB8EcV4dJQATTt2FIxSb5lC6JCwUDrq81KMp3/1r0/eB9eatNRpHFx7vW2VGvaaK8G0uURWmjL6fNDfqQcPQZWfGC1DYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921944; c=relaxed/simple;
	bh=hddN5GZHJXZ6rAsTfNDvu87MEmydgN0WNZCU5oUoN40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUAclFMyxmE37QYCaK0XMbHEvyabo4skO6Z7RAy4aXuKvlpDBTqI/BvVwvzBKSvaqb1UGs0mV5X5H89FzzNk9HRDRMBEI0dDvzkGIXThmhur67CP6SGaUyjPPIoCW3tIkRf9VYy/2SvX4K6+uCZPIcPYd9lMmyjIO9UTx1yUwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S4c2DqAt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psSB/zOv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S4c2DqAt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psSB/zOv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 807C7EC012C;
	Mon, 13 Jul 2026 01:52:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 01:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921940;
	 x=1784008340; bh=p+3BRVrISqt6EkOODQtW1y/QScrlTUDdm8TfuA5xy/A=; b=
	S4c2DqAtwYcCAtQTpq2toAwg6pFSMI/HzTu4akfEEg91zUcCJJB/70QFYtE2Zytl
	iuFrebEmBahEoNxlMaYgrtWgBuyMRkXm897z2a4vreY6Lv5v0lCBwfxdSpGbHWzU
	pmwX+iDp90fH8KUHAxF+UDROJZ1sza0JsVaNQIPMAn13YkHnYiaX8vDtXZCkCcFC
	PCax2rzayqgS+ADf28NsMtqYpc4UDM4ouCsXfEkxgRf1DPZ8AeUiu68rEBPd1E3K
	ipmT7hBCDe55fBJoJsglV30CNJJ1HAUajbAxdemXDO9GIorZeek78qbyEeNNNvSO
	1OdkhqHMScyIrhhevtNGOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921940; x=
	1784008340; bh=p+3BRVrISqt6EkOODQtW1y/QScrlTUDdm8TfuA5xy/A=; b=p
	sSB/zOvs8+9F4Yr56wtQaL+1qQVx2vfXaU9iB+0oW5keby9S1mwqY6XRafAj/Nyh
	WlrlmPDlbJXEkXHtn8fUYqkT53tkpXoLOAX/QLlbMGgVPYhquAy9e7YS9k3sL1Rj
	6vP9jmR7ZFOZITJBYdb/EA4BM3l14MPUbmInUJsoAs+umibmFQmVMWQyGlBmTqq2
	t9jbq/Nc8596NWeSDfGzdYekO/AdQc/5kDlXuGoPFRarXoSKqSEYMMK+DcG33PwQ
	eOeHoc5BTxj8NpHcekRhh7S4dqQMwPevSqgePmuq5jFs22n6nLXWrDfoaFJW9B+e
	BE2dMhvmWAGA/IPhdhXfg==
X-ME-Sender: <xms:FH1UaqzO-AMIj9INTSaQX0zgL_i2hbQ8GPg_KdV__xeFUAUx0tGiJg>
    <xme:FH1UasQmwsGDzEVW0De0MbRtCZ_S7vHz_AoxUsNKzUfXE4oFHfG0zdEfSkIhTQsGP
    PkAYgmba_gKrO9M19hMIotKVg6wuO8YxCLT6sF4RJ9xvg1bHkasUQ>
X-ME-Received: <xmr:FH1Uap-Pd9fDrroMh8iUZEXZlLzrawaAC2YkCP9N6215hij72vY5S4Q-6tCNtXnGLDVEsz5Dc8OyBML9WtwtEhvOwGlNDAJiA1OtOvW_>
X-ME-Proxy-Cause: dmFkZTGsVUmWXQDG+bBoYjm+5uOAQQFrErZ2XBnLRb+P29htSMPhC+zed3MX4KboQFFpqT
    9VSjdgBmGkWNav3ncyNHbOZex2kceBlEhwK+QfS+7ogQ/T4cLsWC5tAwnLsB0NTAR//zoY
    yIUCiW/GqemfZGxE6eBZY57nWbpzHelRueh9+htdEGaObSzH3mT0rTQ0Nb8plAdeNqCno3
    cXSrXW6rFKVVHaxE+YWdZpO3mHmv5jRnHN53MPfdhyYrUtHqUubwXt1/LvmJlmVMow3EWV
    VRZrTfmejIwF+ASeCxFerLkJOIcvK+5hsbY9E73/pW1OzZs1iqIso6b4Mwx/2bbcOA87Mo
    waCCxAr898ktWiGMLumQ3LxEEiV3yQkilJ13oLyXtFO+Mo6NXkGYDyXxwh/jxEEsURhrkx
    futpy63gjdvlZfb0fFXR1VRn7TG9OU8egjh0hZo6TbrdCKMD1KvuffGCVzLpovG9CvecVY
    V9nHaOEyta0xY//Xv6uovqY9yno9Mxksa8UPvHHEiJcRZq1RjUYb6ETlHc5RiSk9aoLjL0
    ZbPgqJC7541JOtjnXi0R6auD7qGMPpgc2gCdQ2Ili5JULrwDH4N302dkA7DW/T6PhRzoQ2
    daHCQuQwOw7taBZTY1ITxRKnhQVYrXrGAdHhuq9upxKvw5K0vKQN5ih8AZBA
X-ME-Proxy: <xmx:FH1UarpJX5kEd2SiD0ZnHIKm2g7yNul78QV50xHHM78oAZTxTnNC5g>
    <xmx:FH1Uaun9DRczOlUNvtwbjmfmOMsvGcwpb3h61ajW496O02W4SPCMhw>
    <xmx:FH1UaqJdeCFrvSrpaIJq4h2F-DI5AWziyPWGW7Y05zx9VIKLAf4Fjw>
    <xmx:FH1UarwcTA1Gk-6FTyAs36pkEx2mxKY7C6DWsl5jn-PKC4RDkp4GqQ>
    <xmx:FH1UauKiFiReTzK_Zo_YrXlBCrv113IS5XZR-Hb0cuDVghLvGcMdyyl4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c9cad17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:05 +0200
Subject: [PATCH v2 02/12] odb: run "pre-auto-gc" hook for all maintenance
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-2-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "pre-auto-gc" hook is supposed to run before auto-maintenance
starts. The intent of this is to give users the ability to intercept
running maintenance in case there's for example an event that is not
supposed to run in parallel with repository maintenance.

This hook runs via `need_to_gc()`, which is invoked via two paths:

  - It is called directly by git-gc(1).

  - It is called indirectly by git-maintenance(1) via the "gc" task.

While the former makes sense, the latter is somewhat off. While the hook
is indeed strongly tied to gc'ing a repository, the original intent of
the hook is rather to inhibit any kind of automated garbage collection.
That noticeably also includes all the other maintenance tasks that our
new infrastructure may run, but those aren't getting intercepted at all.
The move towards our new maintenance strategy has thus somewhat neutered
the effectiveness of the hook.

Fix this issue by running the hook before the first auto-maintenance
task that would run as determined by the tasks's auto condition. Note
that this requires us to lift the call to `run_hooks()` out of
`needs_to_gc()`, as the hook would otherwise potentially run multiple
times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  35 ++++++++++----
 t/t7900-maintenance.sh | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d32af422af..77d0a5c948 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -709,8 +709,6 @@ static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
 	else
 		return 0;
 
-	if (run_hooks(the_repository, "pre-auto-gc"))
-		return 0;
 	return 1;
 }
 
@@ -933,7 +931,8 @@ int cmd_gc(int argc,
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc(&cfg, &repack_args)) {
+		if (!need_to_gc(&cfg, &repack_args) ||
+		    run_hooks(the_repository, "pre-auto-gc")) {
 			ret = 0;
 			goto out;
 		}
@@ -1755,11 +1754,18 @@ enum task_phase {
 	TASK_PHASE_BACKGROUND,
 };
 
+enum auto_gc_hook_result {
+	AUTO_GC_HOOK_UNDECIDED = 0,
+	AUTO_GC_HOOK_RUN = 1,
+	AUTO_GC_HOOK_SKIP = 2,
+};
+
 static int maybe_run_task(const struct maintenance_task *task,
 			  struct repository *repo,
 			  struct maintenance_run_opts *opts,
 			  struct gc_config *cfg,
-			  enum task_phase phase)
+			  enum task_phase phase,
+			  enum auto_gc_hook_result *auto_gc_hook_result)
 {
 	int foreground = (phase == TASK_PHASE_FOREGROUND);
 	maintenance_task_fn fn = foreground ? task->foreground : task->background;
@@ -1768,9 +1774,19 @@ static int maybe_run_task(const struct maintenance_task *task,
 
 	if (!fn)
 		return 0;
-	if (opts->auto_flag &&
-	    (!task->auto_condition || !task->auto_condition(cfg)))
-		return 0;
+	if (opts->auto_flag) {
+		if (*auto_gc_hook_result == AUTO_GC_HOOK_SKIP)
+			return 0;
+
+		if (!task->auto_condition || !task->auto_condition(cfg))
+			return 0;
+
+		if (*auto_gc_hook_result == AUTO_GC_HOOK_UNDECIDED)
+			*auto_gc_hook_result = run_hooks(repo, "pre-auto-gc") ?
+				AUTO_GC_HOOK_SKIP : AUTO_GC_HOOK_RUN;
+		if (*auto_gc_hook_result == AUTO_GC_HOOK_SKIP)
+			return 0;
+	}
 
 	trace2_region_enter(region, task->name, repo);
 	if (fn(opts, cfg)) {
@@ -1789,6 +1805,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	struct lock_file lk;
 	struct repository *r = the_repository;
 	char *lock_path = xstrfmt("%s/maintenance", r->objects->sources->path);
+	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
 
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
 		/*
@@ -1808,7 +1825,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 
 	for (size_t i = 0; i < opts->tasks_nr; i++)
 		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
-				   TASK_PHASE_FOREGROUND))
+				   TASK_PHASE_FOREGROUND, &auto_gc_hook_result))
 			result = 1;
 
 	/* Failure to daemonize is ok, we'll continue in foreground. */
@@ -1820,7 +1837,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 
 	for (size_t i = 0; i < opts->tasks_nr; i++)
 		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
-				   TASK_PHASE_BACKGROUND))
+				   TASK_PHASE_BACKGROUND, &auto_gc_hook_result))
 			result = 1;
 
 	rollback_lock_file(&lk);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 129829f1f4..2d52e7918a 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -758,6 +758,132 @@ test_expect_success 'geometric repacking honors configured split factor' '
 	)
 '
 
+test_expect_success 'pre-auto-gc hook runs exactly once' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		write_script .git/hooks/pre-auto-gc <<-\EOF &&
+		echo hook >>hook.log
+		EOF
+
+		# Satisfy the auto condition for multiple tasks, both in the
+		# foreground and in the background phase.
+		git config set maintenance.reflog-expire.auto -1 &&
+		git config set maintenance.geometric-repack.auto -1 &&
+		git config set maintenance.rerere-gc.auto -1 &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git maintenance run --auto 2>/dev/null &&
+
+		# The successful hook does not inhibit any of the tasks...
+		test_maintenance_tasks trace2.txt <<-\EOF &&
+		reflog-expire foreground
+		geometric-repack
+		rerere-gc
+		EOF
+		# ... but it must only have been executed a single time.
+		test_line_count = 1 hook.log
+	)
+'
+
+test_expect_success 'pre-auto-gc hook can inhibit geometric strategy' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		write_script .git/hooks/pre-auto-gc <<-\EOF &&
+		echo hook >>hook.log
+		exit 1
+		EOF
+
+		git config set maintenance.reflog-expire.auto -1 &&
+		git config set maintenance.geometric-repack.auto -1 &&
+		git config set maintenance.rerere-gc.auto -1 &&
+
+		# Maintenance would be required...
+		git maintenance is-needed --auto &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git maintenance run --auto 2>/dev/null &&
+
+		# ... but the failing hook inhibits all tasks. The hook itself
+		# is expected to be the only child process being spawned, and
+		# it must only run a single time.
+		test_grep "child_start.*pre-auto-gc" trace2.txt &&
+		test_maintenance_tasks trace2.txt <<-\EOF &&
+		EOF
+		test_line_count = 1 hook.log
+	)
+'
+
+test_expect_success 'pre-auto-gc hook can inhibit gc strategy' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		write_script .git/hooks/pre-auto-gc <<-\EOF &&
+		echo hook >>hook.log
+		exit 1
+		EOF
+
+		git config set maintenance.strategy gc &&
+		git config set maintenance.auto false &&
+		git config set gc.auto 3 &&
+
+		test_oid_init &&
+
+		# We need to create two objects whose hashes start with 17
+		# since this is what the gc task counts.
+		test_commit "$(test_oid blob17_1)" &&
+		test_commit "$(test_oid blob17_2)" &&
+
+		# Maintenance would be required...
+		git maintenance is-needed --auto &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git maintenance run --auto 2>/dev/null &&
+
+		# ... but the failing hook inhibits all tasks. The hook itself
+		# is expected to be the only child process being spawned, and
+		# it must only run a single time.
+		test_grep "child_start.*pre-auto-gc" trace2.txt &&
+		test_maintenance_tasks trace2.txt <<-\EOF &&
+		EOF
+		test_subcommand_flex ! git trace2 &&
+		test_line_count = 1 hook.log
+	)
+'
+
+test_expect_success 'pre-auto-gc hook does not run when no maintenance is needed' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		write_script .git/hooks/pre-auto-gc <<-\EOF &&
+		echo hook >>hook.log
+		EOF
+		test_must_fail git maintenance is-needed --auto &&
+		git maintenance run --auto 2>/dev/null &&
+		test_path_is_missing hook.log
+	)
+'
+
+test_expect_success 'pre-auto-gc hook does not run without --auto' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_hook -C repo pre-auto-gc <<-\EOF &&
+	echo hook >>hook.log
+	EOF
+	(
+		cd repo &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+			git maintenance run 2>/dev/null &&
+		test_grep "\[\"git\",\"repack\"," trace2.txt &&
+		test_path_is_missing hook.log
+	)
+'
+
 test_expect_success 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do

-- 
2.55.0.313.g8d093f411d.dirty

