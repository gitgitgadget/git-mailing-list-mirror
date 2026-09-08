Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4D50EC1A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863295; cv=none; b=hJQ9sbcFA1WD8mZP5rSEnWL4AljO5cRWMxZ441/FNIj/DzP1BD+FAaV4/jnfSbyMOnWyQGz2PY27ytL/2BNi5efKs4kQgJAs5KxS3n31TCYQh73GFWGwn/aLzyENRl1Z+I2teVPsnSrzi1Qss1XOvwCvNKz6P+x6VryXzjW51Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863295; c=relaxed/simple;
	bh=Lt7bjZSp2Zy6u9nczULI4Yx9FBTMf2VMOKSHXeilQZY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q/2fqv7kngpbjjflwPq3d/bqcy3JM6VTe5N4k2EOGyfQ2C/l6kFN+6caDUWjnIC3KVf4E9v3JtdMN9981TutSsot3FjaSRZtnCxm32oE0NCHH6EQeSI1mK56yXSCyGBnMDZVfzJBiBSVRukXUd8xIp5/0V/Gi2N8q1hJjKd1ezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHxvV9v3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHxvV9v3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d6efd73032so44581375ad.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863293; x=1789468093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X42OH9FHhbBRUwoJ5p/98CSDOFHn8v9u6GwVkhNxGhQ=;
        b=VHxvV9v3nMfuQxEmLOTXuItVcRLSn7Qge9lCpBBHD8ztlk/9uQJiXu9/Al/JR2mcHu
         1r+PgJDG7MZJYPJcxaZTk6KcapnND0XDsDFdYwAIrY7DJsJK8ruvvgdpEEG9ojAj3YBh
         QeW9ZMWhQGbpXmE8ktqrNA3/NeK+eSuu4xJmSCw/sNdFq+Ccq28dbHjtqA9+NJsH4GbW
         PfYQJM+3GuwkMwHrZ+QpapmV3pJf+gXngxPrrCDDC+M4c+yNbY27n6nWjbE/mJWRXBKc
         pDvwufbRLdM3SGzX57m+MRdR+88ARlOStaqOO1bedEoPnBvTZ8pM6QnZu7t4NLiSN2Go
         0zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863293; x=1789468093;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X42OH9FHhbBRUwoJ5p/98CSDOFHn8v9u6GwVkhNxGhQ=;
        b=maMl+zdKxO0HOMhcKLlOZF04MwtxfmZ7vKZmYLJkVNNobHXZAAGhpf5fGz7NlNMZ/d
         1F0wGhk/wyiqVOU/U7GNByFZ5Ayn/4rAHofZN87vavakrmeBnYMsb7hSp5Bhy4brQ4Nl
         ZzRbuEQ8MIvuInzT73iTdKATkuG0DLkrwPWspCq42H5DzskdgrJm7U80CzoP72C4fgcU
         BkcNR/lFIBuDRtN0zU8OoLUiM8NT/jO5euJHtOfGPuRu+WktWtEu2jiy1vwFrvjP2fPf
         U+s2pz1eGd2UgHPpzNyew8AkgyWaNaYPOYCamsKhsJ6OUSeneWgYqR07JjmCqRTx7MqD
         QfXA==
X-Gm-Message-State: AFuF++nb24OF4JrFTZ4ID6V0/40aqzonTZPHkcZW5NlCG+EuC38KOXVE
	p1xMGS6mWPSXsx3JkIzvMAby+c7elu0985bn3JAXvPleYBp40crTxp89nFrl0g==
X-Gm-Gg: AYBFou394g13SBm6n08k+3+ups+v3bowkrJD0/tLiDCWl8ZXqi+SemSf3QRGu8Uy/qo
	OdndALTZRfD1V+P+qKpStBPVeYGtAkpv7UkTSPirmbZnNQI36pR6ZDRiBBoT8ps7PRAuS4pDwdB
	4KjOolAsdLFWcQtb5ZPI0Uk8+0N9ZWx9qQ9d4m8eWxagvyjhXm47iiehRQVU7lEDbB8ppMTEv9G
	1ACdmjBEZbAJ58rVkKLTtpSQl+uTK6TMvWnKBG5xrJ9O49r3nmv47SKMg6Gs/DwL9Q+lux6U0d2
	dIFbDGUENqKuwWX8i9i8cT1NQTPlbA/4WuvskVgjSMfhvHSljlTAaE6EeSTE2OJf6dz0lcFwpka
	VPGsBbB/lFV5ETfcJGlZZQQUm8Y8GEqnVHETeQ4m5YG0DDyGX9qvS6UHQwHkqyzFXnbn6zhTEQU
	iArLPVMXHAETG58NVD455vsa2iD570fDGKHfgzLo7/Z9baq3n+81LaSgLJYBki4GgDLs0SQReN
X-Received: by 2002:a17:90b:518c:b0:38f:cfe2:fd3a with SMTP id 98e67ed59e1d1-39b0865357bmr36412318a91.15.1788863293437;
        Tue, 08 Sep 2026 03:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm13885350c88.9.2026.09.08.03.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:28:12 -0700 (PDT)
Message-Id: <7a353df3d9d4b422b7df435a9f83c5b27d907ae4.1788863286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 10:28:06 +0000
Subject: [PATCH v3 3/3] sequencer: disable auto maintenance in spawned
 commands
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The "git commit" and "git merge" the sequencer spawns run "git
maintenance run --auto --detach" as they finish, and so does any
such command an exec runs. That maintenance then works in the
background while the sequencer goes on with the sequence, and the
two get in each other's way. With rerere enabled, the maintenance
started by the "git commit" of a "git rebase --continue" runs
"rerere gc", which can still hold MERGE_RR.lock when the next pick
conflicts. The rebase then dies with "Unable to create
'.../MERGE_RR.lock': File exists" instead of stopping for the user
to resolve the conflict. And a repack can delete a pack the
sequencer still has open, which 65cda10d5b (sequencer: release the
ODB before spawning git commit, 2026-08-12) works around.

Pass maintenance.auto=false to these commands through
GIT_CONFIG_PARAMETERS, as "git -c" would. We build the value once
from the one we inherited and append our setting after the user's
own -c settings so that it wins. The environment also reaches
everything the command spawns in turn, so a git command run from an
exec is covered as well. The sequencer also spawns "git stash", "git
reset" and "git notes", which never run auto maintenance.

With the previous commit, rebase, cherry-pick and revert run auto
maintenance once when they are done, so a sequence now runs it
exactly once, at the end. A sequence that stops for conflicts used
to run it at every resolution and now piles up its loose objects
until the end, as a sequence without conflicts always has.

A command the user runs while the sequence is stopped, like "git
commit --amend" at an edit, still runs auto maintenance. The
sequencer does not spawn it and has no say in it.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 sequencer.c                     | 38 ++++++++++++++++++++++++++++++---
 t/t3418-rebase-continue.sh      | 11 +++++++---
 t/t3510-cherry-pick-sequence.sh | 14 +++++++++---
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..e99ef09f02 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,6 +234,11 @@ struct replay_ctx {
 	 * Whether message contains a commit message.
 	 */
 	unsigned have_message :1;
+	/*
+	 * GIT_CONFIG_PARAMETERS for the commands we spawn, with auto
+	 * maintenance turned off. Built on first use.
+	 */
+	char *config_parameters;
 };
 
 struct replay_ctx* replay_ctx_new(void)
@@ -407,6 +412,7 @@ static void replay_ctx_release(struct replay_ctx *ctx)
 {
 	strbuf_release(&ctx->current_fixups);
 	strbuf_release(&ctx->message);
+	free(ctx->config_parameters);
 }
 
 void replay_opts_release(struct replay_opts *opts)
@@ -1107,6 +1113,27 @@ static int run_command_silent_on_success(struct child_process *cmd)
 	return rc;
 }
 
+/*
+ * Don't let the commands we spawn run auto maintenance. It would race
+ * us for MERGE_RR.lock or delete packs we still have open. Our caller
+ * runs it once the sequence is done.
+ */
+static void disable_auto_maintenance(struct replay_opts *opts,
+				     struct child_process *cmd)
+{
+	if (!opts->ctx->config_parameters) {
+		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
+		struct strbuf buf = STRBUF_INIT;
+
+		if (old && *old)
+			strbuf_addstr(&buf, old);
+		git_config_append_parameter(&buf, "maintenance.auto", "false");
+		opts->ctx->config_parameters = strbuf_detach(&buf, NULL);
+	}
+	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT,
+		     opts->ctx->config_parameters);
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -1148,6 +1175,7 @@ static int run_git_commit(const char *defmsg,
 			     author_date_from_env(&cmd.env));
 	if (opts->ignore_date)
 		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+	disable_auto_maintenance(opts, &cmd);
 
 	strvec_push(&cmd.args, "commit");
 
@@ -3924,16 +3952,18 @@ static int error_failed_squash(struct repository *r,
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
@@ -4342,6 +4372,7 @@ static int do_merge(struct repository *r,
 				     author_date_from_env(&cmd.env));
 		if (opts->ignore_date)
 			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+		disable_auto_maintenance(opts, &cmd);
 
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "merge");
@@ -5158,7 +5189,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg, opts->quiet);
+			res = do_exec(r, arg, opts);
 			*end_of_arg = saved;
 
 			if (res) {
@@ -5329,6 +5360,7 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 		return error(_("no cherry-pick or revert in progress"));
 
 	cmd.git_cmd = 1;
+	disable_auto_maintenance(opts, &cmd);
 	strvec_push(&cmd.args, "commit");
 
 	/*
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 025787b5f2..16def261b0 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -398,13 +398,18 @@ test_orig_head --merge
 test_expect_success 'rebase runs auto maintenance once it is done' '
 	git checkout -b auto-maintenance topic &&
 	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
-		git rebase -x false main &&
+		git rebase -x "git commit --allow-empty -m exec && false" main &&
 	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
 	echo resolved >F2 &&
 	git add F2 &&
-	test_must_fail git rebase --continue &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git rebase --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
-	test_subcommand_flex git maintenance run --auto <end.txt
+	test_subcommand_flex git maintenance run --auto <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
 '
 
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 2bea55c3b6..1e3fa1803c 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -723,8 +723,11 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 
 test_expect_success 'cherry-pick runs auto maintenance once it is done' '
 	pristine_detach base &&
-	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
+	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick --edit picked &&
+	test_subcommand_flex git commit <single.txt &&
 	test_subcommand_flex git maintenance run --auto <single.txt &&
+	grep "\"child_start\".*\"maintenance\"" single.txt >maintenance &&
+	test_line_count = 1 maintenance &&
 	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
 		git cherry-pick anotherpick yetanotherpick &&
 	test_subcommand_flex git maintenance run --auto <sequence.txt &&
@@ -739,9 +742,14 @@ test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence i
 	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
 	echo resolved >foo &&
 	git add foo &&
-	test_must_fail git cherry-pick --continue &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git cherry-pick --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
-	test_subcommand_flex git maintenance run --auto <end.txt
+	test_subcommand_flex git maintenance run --auto <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
 '
 
 test_done
-- 
gitgitgadget
