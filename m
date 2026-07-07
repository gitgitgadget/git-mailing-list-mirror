Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A33DC4A9
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438380; cv=none; b=UUTEOaFlG6ETmJVRNAWLQfWK+ZSC3lJdmZmnCi+GybUW0FVCDgaJlHTWAAt2ywXuY3Ogmwodi/DMibKmejdCTLaVkdWxLvqerWfVL+7yekoaWl2mDDgBD25+PfLAX2AmlI8CxZ55HWWiHZvba+cPhImC/LbOt6Si/FZf80W3jdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438380; c=relaxed/simple;
	bh=XkMav3VSKM28/WXHPOTaOtVNJnLGl2Tj0snCgZWv3t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwED1KqWTI8ynREfPcc4BcUxKpOgP7gtY7lTOO1diBS4117I3iRyQ+2rlc9OvbG8rTneFRHF+QzDebSq/+bEv9I622INCCwPIqG6skvRCS8dOBad6g5BBSy+xNPzv1ESZSMPFn9one6ZVjft7xugV+Lfb8C7KjfrLaiJcriv0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ADQNayfD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAGOlVrB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ADQNayfD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAGOlVrB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EE412EC023A
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:32:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 11:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438377;
	 x=1783524777; bh=f2a7SfM1om710tyj+ZbQyBkirg3bhGVFGNmHue9nvfU=; b=
	ADQNayfDwTCu1mZaAQly+qGuBQzIoOv6q0cgtHCZCUcxYr0u3nUp+FO0eDh8qWeS
	Go6A2KtN5ZVGb76Qaz1gaLgFvc4Q2OcI7emkATTZFoHp6g/FDjR7iaIyZEDYU0Sp
	MKN+CP+UdcR/kDqlJvH3zEoYB+hcEvy4djcIH7/Y+/u1Q32AmAYoyw+OkxHlSDYh
	fl9O+ljvb+yvCxbCQTlmJEBuHfl1qBjVWhoYPfQ8ChN6n29Mjq5XhP4iZwfBCxAA
	7VNpWX/GlOn3swt1rLGJCGcdns/c60DI2wRTqXv2U/s3asvFZicB3z3z9C732qAa
	7cJUnUY4M7eBOGA9D/MFfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438377; x=
	1783524777; bh=f2a7SfM1om710tyj+ZbQyBkirg3bhGVFGNmHue9nvfU=; b=b
	AGOlVrB7IwAn9HDRXkEvaTo5TmXhi2zCP6vskdU5IxAjxVIaV9XcF9gJaelHcKt9
	FjNKnrQCpHX/HIKKwaWEZD48fWQ3PKSavLBlMFS/edUOLx93JQRClfki2K6eTi2H
	3sUIsZ5zXV8qlZnUUFyEKLWTyEfmQPCP+TlbiPttYG7hIibJnP3UCi7Cz6Tbamt8
	nysm1IbTmLDiPSDoUgvexC3cz7y1YyFVc/U5jU66j+wBOUuSXnrhSiafIrci2jDN
	oZnzeCCHjC/IhYaJkes+qYUtAiVzZd7bp0gL6DBiPx8lf6Hqwdmibd0yXfu/Kq6d
	W8NiVtZ/3byRHUSM814rw==
X-ME-Sender: <xms:KRxNajpsa7PkHf5Joh-U-tn7yt-_OdsXm9xGVibXqn4zKCThFxWpdQ>
    <xme:KRxNaklFEaBAVIB0mBXFGXzAZ1kXUTw0L-pdxs1Ix9VHNvBv9HUESNZsmvU7aCXgr
    c3W9nT-qtaoguENnD5KwqyLMhAiVVqQpPjGZPcCrX5b1wRCh5edJg>
X-ME-Received: <xmr:KRxNal2BCFWQXfK2Ose0DHUbcSY1Pw7hGHqpDitNC6hGK6tMG5_CkaXCmX-n7hpG5GTD7-VGSf5jemTttiphyOoRIkzBNDyu94faPXrr1A>
X-ME-Proxy-Cause: dmFkZTGEoi+Tpvw7xBqV+9HXZ+gBWGM8uDnCAREa0BslwPRMZ1YWZua98i4Yjcw2NhwOdu
    HHCjXms3MlR3BjWo48tuW9wiTahJHFiK1emB6WDt1vI/AZYkgMdDfSiITIESq8Ms3tsygi
    AHVzqNG+Wm64c0RJ2rNRyvjKn4Cgt9VU//CoNPZK4y2LNDVCntjjZoOEaZZHE34hhhSNrD
    ErTFHRo80eMTo2N8FpWv1/6t5Zimfe1uDeOUZP6fi72heLQTiBQOPC+wYDgsSlaUKC19rU
    OcnAVWWvZqJsQNFktkfNKAn9PpXihA5z3wMz7jdEcRx+Ckcjiw0h+ejRuF6EDgkZTtatVB
    ioteCUhkaQWkXoOf2b/n1qa14puDccNQzCq7mw0mdY9EZNLqwahTVbpEJ+7DJRM5zJpJvP
    CN62n2KVo7ahJpTsnZgOg3d4tIco1fZA+CjEk7Fo53uVTbPkw0q18iI6tp0mJtD/LvVYW8
    ja6o2PvXyTHGng3sqm9y07inapjWaHoWy+Hw68L6ULxDPX+IZebc3eNwNXiqOx/2BRrAl5
    cBaMG7ekssjbGfjPLMi/jwXKRU3TV58id9yNTxT+5GJmuiNhe38SdiWPizSatTxhtDfdc3
    AixNpte4xNeU6JQsrptdHdi1A/cPoA5T2FggKBugOGToaweIbHF4uoY/HL9A
X-ME-Proxy: <xmx:KRxNasAjCinbK_-GWVBktbZEM10-6D2OjU1n694WtS9b81Gi-KvT1w>
    <xmx:KRxNaiyulKtR2febMZboPnGm8OEDUqduz0t0qZzJH3dl2fBdgL4hUw>
    <xmx:KRxNaqmdBB0xIIEAKLO96yg6UY9dZu97Y1B27jG0LZgCi1G_579FIQ>
    <xmx:KRxNanEAaHW2btz55Gh2YyUGOiOxfsZcTA-hA0O-gUmomWw8jg_olw>
    <xmx:KRxNajLjzhSgYipp5rt2cqcdMjCAjBhpfGUh9gHwV4fChbMwMnmKnqp5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:32:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 044c221c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:32:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:33 +0200
Subject: [PATCH 01/11] odb: run "pre-auto-gc" hook for all maintenance
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-1-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
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
 t/t7900-maintenance.sh | 121 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 9 deletions(-)

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
index d7f82e1bec..1212b306b6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -740,6 +740,127 @@ test_expect_success 'geometric repacking honors configured split factor' '
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
+		test_subcommand git reflog expire --all <trace2.txt &&
+		test_subcommand_flex git repack <trace2.txt &&
+		test_subcommand git rerere gc <trace2.txt &&
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
+		test_subcommand_flex ! git trace2 &&
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
2.55.0.141.g00534a21ce.dirty

