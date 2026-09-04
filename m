Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5C46D2D8
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537095; cv=none; b=ZdmuR3xoV/oVoQ1Z5H6U05nHiYDbYoLsr9ufl5TDjrumVqomxk10oU76gdYI6xHcREV/BmC8Pk6pccIZf49wFIE1NdiRlCd9KRVdoJNC7ygBOs1u+QWsJD1bamo3DPSgJWGW6XEpIjzRMaYTODEaWmZI1MvlbojmeT5dXZVff54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537095; c=relaxed/simple;
	bh=JfDHAycImdgIJgQCuJPAh+J8inK4Fzirt9q9/iUoX7c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=He9VPNPDMSyExQ1zNyN0UnZI1FuobbOKetq0hi6FmzWgtMn5Rt6eAY8k85LQ0NUAoyVG6fjYeC9TxfMuDbfL3oZ4WdUpAvOcxsG0XVIFHX3jOjVj4G8i/dGySr5GS4k+RJIBETJsHM1dxNMpZr0DOBxyrVmRZ9wErS2jDW4neAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TumFjXAv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TumFjXAv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso1011067a12.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537093; x=1789141893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ido8IOEBt/Npht4OiYtC3rLbCQnzfS1hKo4s0IMr98Q=;
        b=TumFjXAvP6K9XQn6/3M3bdCw6tzuPgBrQnDjJzu4RGjCyEpSgUtIkmB8rDcCNdxLME
         LxSrfIh5QoJNepzSc8us0UZG5+vD8tXoyfRRMbHwV/YaMTjz93rR3IyMHPzNnWd06wuq
         YuKFIdoAvxFI4PNJ8mH1VZdvIP1qc7CJYUkeHYCxqlOCHTJM8CG4xTrxrVru5/cqLHp+
         PBPa/maPxC/hLU42aRCSpks6K4NehDxVSiuMZUSnVH7YhoXHtjobft45je6sPJ4wNCLb
         A/NwSe4Cn10oLQX0rJYtJlSgFgMNwU8QZBsdr/nnrsdnIvodwMBse5cvnwht7bnYcFT4
         JTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537093; x=1789141893;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ido8IOEBt/Npht4OiYtC3rLbCQnzfS1hKo4s0IMr98Q=;
        b=E5gRqYqs7c0amS6UefWqJDj7kTnP8BZEGEf7OSRE0hTg3an7BURwMfLjhUpitYQ+7r
         KxtBcITgA94bRiG8UMvx7koSGaawaI4pjVPKdsabQx/VzDjhxEyGAvZz6B3th6a4pS1R
         9Z69L5ayZjZEX95FRo1TO37enqKF5J1FL3hwjQhRm8mmNfi9uwsOI0pZ8ZuKWCjWRLmP
         oFphr+Kuun7EdBLtdC86BEDhqp8/5ecW5TI/zOtcMN7Z0Fw0JzAiRdJah108bgvTfiWJ
         i3SwO3cbOkVqV5mVI1gooGnVyvUzAYfJfNnyulxoLOOVEGEX3IbChybJUF4dVJb8+ziU
         JI2w==
X-Gm-Message-State: AFuF++lQymWcS/UrkfhpwQpTjpuTsbjcZ8Ldnjl6ldOhQH2z5lAGXYi1
	pPdYjhig1mCms9i8Bcfc6+7yAXQu2ZAMzoHIWOHfvG3ug7xUs9PQ7ZQDSF2L11wG
X-Gm-Gg: AYBFou1GvztmcJXbexa9IwzW7XWsXNkQpMST7K0r+izVJYh4O3pTd4dd39WDcUo4D/4
	kgQ4v8/QerhzNaXm3MpZJ1IhIba6KpbJOSJUD4FKJvpKvH20XZUKm1/EZaBpwnSvS/k4QYpQeDU
	1+Jx+Pb5sVb46jPj4oAohqcymAqjHgO1FSi/9JZV1NOq5C4w06HMDvJPyYmSLtfcmoFVAQrTKCb
	K3LWV9powuneS7mxX/1JfOSzemKLUBqFFVC3c68HfAvcwUOXYgQKSeWfJQ7F8lQ11973XjcgKYU
	6+RQdeKUgkSycfN5pjHxumDkuvh0QIbPbiDUDSSap6XKU1hkCCCjVwgGoGMEstEh/R2NVGerNho
	MGnUqn3WZF19K4FD6guswlhK0/CFHgl2srub1hv8MTMwLy0jne+7XLuNZCqJD2+eiObZQcx7J2D
	p1ACncXDK8MX8ZdnlZGaZiwT3gfz4kGvqJ0HPeqCk/FmqiycICYcLqW1Jit1mfiXo=
X-Received: by 2002:a17:90b:510c:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39b262e27a9mr12642622a91.24.1788537092948;
        Fri, 04 Sep 2026 08:51:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm11363886eec.16.2026.09.04.08.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:51:32 -0700 (PDT)
Message-Id: <9a6fc0427a8bc7e7abcc0518214b1dafc2efaa6a.1788537086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 15:51:26 +0000
Subject: [PATCH v2 3/3] sequencer: keep auto maintenance out of the commands a
 sequence spawns
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The "git commit" and "git merge" the sequencer spawns, and the git
commands an exec runs, each start "git maintenance run --auto
--detach", which then works in the background against the sequence
itself. A "rerere gc" started by the commit of one "git rebase
--continue" holds MERGE_RR.lock when the next pick needs it, and a
repack deletes packs the sequencer still has open, which 65cda10d5b
(sequencer: release the ODB before spawning git commit, 2026-08-12)
had to work around.

The loose objects a sequence creates wait for the run at its end that
the previous commit added. Whether a sequence can be long enough to
suffer from them before that remains to be seen. Pass
maintenance.auto=false and gc.auto=0 to the spawned commands through
GIT_CONFIG_PARAMETERS, which the shell of an exec command hands on to
whatever it runs, appended after the user's own -c settings so that
ours win, and built once per run. A command the user runs while the
sequence is stopped, like "git commit --amend" at an edit, is not the
sequencer's to control and still runs maintenance.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 sequencer.c                     | 39 ++++++++++++++++++++++++++++++---
 t/t3418-rebase-continue.sh      | 18 +++++++++++++++
 t/t3510-cherry-pick-sequence.sh | 17 ++++++++++++++
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 67e1c38762..5df07750a7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,6 +234,11 @@ struct replay_ctx {
 	 * Whether message contains a commit message.
 	 */
 	unsigned have_message :1;
+	/*
+	 * The GIT_CONFIG_PARAMETERS value that keeps auto maintenance out
+	 * of the commands we spawn, built on first use.
+	 */
+	struct strbuf config_parameters;
 };
 
 struct replay_ctx* replay_ctx_new(void)
@@ -242,6 +247,7 @@ struct replay_ctx* replay_ctx_new(void)
 
 	strbuf_init(&ctx->current_fixups, 0);
 	strbuf_init(&ctx->message, 0);
+	strbuf_init(&ctx->config_parameters, 0);
 
 	return ctx;
 }
@@ -407,6 +413,7 @@ static void replay_ctx_release(struct replay_ctx *ctx)
 {
 	strbuf_release(&ctx->current_fixups);
 	strbuf_release(&ctx->message);
+	strbuf_release(&ctx->config_parameters);
 }
 
 void replay_opts_release(struct replay_opts *opts)
@@ -1107,6 +1114,27 @@ static int run_command_silent_on_success(struct child_process *cmd)
 	return rc;
 }
 
+/*
+ * A sequence runs auto maintenance once it is done, not from every command
+ * it spawns along the way: their background "rerere gc" or repack would
+ * race the sequencer for locks and files it still holds.
+ */
+static void disable_auto_maintenance(struct replay_opts *opts,
+				     struct child_process *cmd)
+{
+	struct strbuf *params = &opts->ctx->config_parameters;
+
+	if (!params->len) {
+		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
+
+		if (old && *old)
+			strbuf_addstr(params, old);
+		git_config_append_parameter(params, "maintenance.auto", "false");
+		git_config_append_parameter(params, "gc.auto", "0");
+	}
+	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, params->buf);
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -1148,6 +1176,7 @@ static int run_git_commit(const char *defmsg,
 			     author_date_from_env(&cmd.env));
 	if (opts->ignore_date)
 		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+	disable_auto_maintenance(opts, &cmd);
 
 	strvec_push(&cmd.args, "commit");
 
@@ -3924,16 +3953,18 @@ static int error_failed_squash(struct repository *r,
 	return error_with_patch(r, commit, subject, subject_len, opts, 1, 1);
 }
 
-static int do_exec(struct repository *r, const char *command_line, int quiet)
+static int do_exec(struct repository *r, const char *command_line,
+		   struct replay_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int dirty, status;
 
-	if (!quiet)
+	if (!opts->quiet)
 		fprintf(stderr, _("Executing: %s\n"), command_line);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
 	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
+	disable_auto_maintenance(opts, &cmd);
 	status = run_command(&cmd);
 
 	/* force re-reading of the cache */
@@ -4342,6 +4373,7 @@ static int do_merge(struct repository *r,
 				     author_date_from_env(&cmd.env));
 		if (opts->ignore_date)
 			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+		disable_auto_maintenance(opts, &cmd);
 
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "merge");
@@ -5158,7 +5190,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg, opts->quiet);
+			res = do_exec(r, arg, opts);
 			*end_of_arg = saved;
 
 			if (res) {
@@ -5335,6 +5367,7 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 		return error(_("no cherry-pick or revert in progress"));
 
 	cmd.git_cmd = 1;
+	disable_auto_maintenance(opts, &cmd);
 	strvec_push(&cmd.args, "commit");
 
 	/*
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2c34cf8a01..cf6d20ce79 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -403,4 +403,22 @@ test_expect_success 'rebase runs auto maintenance at its end' '
 	test_subcommand_flex git maintenance run --auto <finish.txt
 '
 
+test_expect_success 'rebase spawns no auto maintenance before its end' '
+	git checkout -b two-conflicts topic &&
+	test_commit F2-again F2 222 &&
+	test_must_fail git rebase -x "git commit --allow-empty -m exec" main &&
+	echo resolved >F2 &&
+	git add F2 &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git rebase --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
+	echo resolved >F2 &&
+	git add F2 &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
+	test_subcommand_flex git maintenance run --auto <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 304981ccd6..57a77d91bd 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -731,4 +731,21 @@ test_expect_success 'cherry-pick runs auto maintenance once it is done' '
 	test_line_count = 1 maintenance
 '
 
+test_expect_success 'cherry-pick spawns no auto maintenance before it is done' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git cherry-pick --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
+	echo d >foo &&
+	git add foo &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --continue &&
+	test_subcommand_flex git commit <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
 test_done
-- 
gitgitgadget
