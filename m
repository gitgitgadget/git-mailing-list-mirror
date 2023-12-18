Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B3481BD
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9LJ5rWV"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cc6c028229so12519341fa.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 04:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702901456; x=1703506256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM+n+RjRoJNFUhu7GF6KGSz6bR+ry5ZCsSyDBuHWUYg=;
        b=h9LJ5rWVDk50Vd/UruGYOC22qNpzFW/Gdj3gVeIpiBcNeM1401SKcY2P+BOE3osmcO
         WWXxDG+hYrgETOyhBFB+/VbVy9tFPFHKv/SKsegyZPFIaIOlwVGmQ5/wlIuiW3IF4uj0
         BrZepcDx0IX9FChqx9RDIIupp82OrLMoOXx29Sm56wPIlCwdCFSWW7qJmYE35jDdUdDZ
         9m4jHyBP535RJnvtuPYXl3T6ZgJXOG7hgk17ap8yHhXF2kf9bF5C533Wnph/AuHf4Jgw
         9FcuA0klo/pHoQCnb9YYxgJ/s5Lht6XdRz9ZiU7YBFqGd9lG1ysQ1H5jcnsz7gEz9A78
         Z/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901456; x=1703506256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM+n+RjRoJNFUhu7GF6KGSz6bR+ry5ZCsSyDBuHWUYg=;
        b=qOXsZWkjwy5eao5q6WfukyFC2SQ9g7p9soVGVhlzVddZloEp8Ip/+kwg7jeZf3YpqL
         1R6C6gIAPfrnKnWoHdRfa3Tl0o2qgHE2UDXe8mBpdDSYJxb9XONdiQ9vhEnUUBvNoXaf
         1kJbF2duY5DZ7sDmEoHPMB8ynMU0SSAeN679g+Ox2D/wa1R9oWwzmwi2TSx7rEMyVS8C
         KMTKlhlUVB1C5nT6DYo/xX1BN2vBpr4O9lURl5E7YrLh1KxqFXiu4KeS3M33NzZP5GpQ
         tMNGjCGZSdfypuFibt5F3mRqujQWSAjrOWuQGYslnztPkVKTy0Pce7kf/Eh+Ldu1urN2
         TlVQ==
X-Gm-Message-State: AOJu0YwL3ob/D+cWgLEFST6roblqXl1PwL4PDeWeP/fXD8D+c+9IhKTx
	9YtcWGMD/Gm1gbJYmP0P5BIomR6OiZkVuQ==
X-Google-Smtp-Source: AGHT+IFmwCgLUBzVF55wt719eYaREq2hYCdcl1ElcphDgpqNjSn6D8JwRRENdnYCrTCJSVzQUADDOg==
X-Received: by 2002:a05:651c:2043:b0:2cc:6d73:cb3e with SMTP id t3-20020a05651c204300b002cc6d73cb3emr783773ljo.11.1702901456128;
        Mon, 18 Dec 2023 04:10:56 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-39a6-bdd4-29ba-7091.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:39a6:bdd4:29ba:7091])
        by smtp.gmail.com with ESMTPSA id f21-20020a50ee95000000b00553346e2cfcsm1444971edr.55.2023.12.18.04.10.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Dec 2023 04:10:55 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: git@vger.kernel.org
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/1] revert/cherry-pick: add --show-current-patch option
Date: Mon, 18 Dec 2023 13:10:48 +0100
Message-Id: <20231218121048.68290-2-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231218121048.68290-1-mi.al.lohmann@gmail.com>
References: <20231218121048.68290-1-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This aligns the interface to the rebase one and allows for an easier way
of figuring out how to resolve conflicts if commits fail to apply
(especially when reverting/cherry-picking multiple commits at the same
time)

Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
 Documentation/git-cherry-pick.txt      |  2 +-
 Documentation/git-revert.txt           |  2 +-
 Documentation/sequencer.txt            |  5 +++++
 builtin/rebase.c                       |  7 ++----
 builtin/revert.c                       |  9 ++++++--
 contrib/completion/git-completion.bash |  2 +-
 sequencer.c                            | 24 +++++++++++++++++++++
 sequencer.h                            |  2 ++
 t/t3507-cherry-pick-conflict.sh        | 30 ++++++++++++++++++++++++++
 9 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fdcad3d200..af41903fe7 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git cherry-pick' [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
-'git cherry-pick' (--continue | --skip | --abort | --quit)
+'git cherry-pick' (--continue | --skip | --abort | --quit | --show-current-patch)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cbe0208834..5bd2ecf35a 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>...
-'git revert' (--continue | --skip | --abort | --quit)
+'git revert' (--continue | --skip | --abort | --quit | --show-current-patch)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 3bceb56474..e9394761bc 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -12,5 +12,10 @@
 	to clear the sequencer state after a failed cherry-pick or
 	revert.
 
+--show-current-patch::
+	Show the current patch when a revert or cherry-pick is
+	stopped because of conflicts. This is the equivalent of
+	`git show REVERT_HEAD` or `git show CHERRY_PICK_HEAD`.
+
 --abort::
 	Cancel the operation and return to the pre-sequence state.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9f8192e0a5..8ad3cf3e90 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -360,12 +360,9 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 		ret = edit_todo_file(flags);
 		break;
 	case ACTION_SHOW_CURRENT_PATCH: {
-		struct child_process cmd = CHILD_PROCESS_INIT;
-
-		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
-		ret = run_command(&cmd);
+		struct replay_opts replay_opts = get_replay_opts(opts);
 
+		ret = sequencer_show_current_patch(the_repository, &replay_opts);
 		break;
 	}
 	default:
diff --git a/builtin/revert.c b/builtin/revert.c
index e6f9a1ad26..cbcd9fdc23 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -24,14 +24,14 @@
 
 static const char * const revert_usage[] = {
 	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
-	N_("git revert (--continue | --skip | --abort | --quit)"),
+	N_("git revert (--continue | --skip | --abort | --quit | --show-current-patch)"),
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
 	N_("git cherry-pick [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff]\n"
 	   "                [-S[<keyid>]] <commit>..."),
-	N_("git cherry-pick (--continue | --skip | --abort | --quit)"),
+	N_("git cherry-pick (--continue | --skip | --abort | --quit | --show-current-patch)"),
 	NULL
 };
 
@@ -93,6 +93,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
 		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit and continue"), 's'),
+		OPT_CMDMODE(0, "show-current-patch", &cmd, N_("show the patch file being reverted or cherry-picked"), 'p'),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
@@ -154,6 +155,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 			this_operation = "--continue";
 		else if (cmd == 's')
 			this_operation = "--skip";
+		else if (cmd == 'p')
+			this_operation = "--show-current-patch";
 		else {
 			assert(cmd == 'a');
 			this_operation = "--abort";
@@ -224,6 +227,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		return sequencer_rollback(the_repository, opts);
 	if (cmd == 's')
 		return sequencer_skip(the_repository, opts);
+	if (cmd == 'p')
+		return sequencer_show_current_patch(the_repository, opts);
 	return sequencer_pick_revisions(the_repository, opts);
 }
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13a39ebd2e..b740b7d48c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1618,7 +1618,7 @@ _git_checkout ()
 	esac
 }
 
-__git_sequencer_inprogress_options="--continue --quit --abort --skip"
+__git_sequencer_inprogress_options="--continue --quit --abort --skip --show-current-patch"
 
 __git_cherry_pick_inprogress_options=$__git_sequencer_inprogress_options
 
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..3f6f9ad75c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3417,6 +3417,30 @@ int sequencer_skip(struct repository *r, struct replay_opts *opts)
 	return -1;
 }
 
+int sequencer_show_current_patch(struct repository *r, struct replay_opts *opts)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	cmd.git_cmd = 1;
+	switch (opts->action) {
+	case REPLAY_REVERT:
+		if (!refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
+			die(_("No revert in progress?"));
+		strvec_pushl(&cmd.args, "show", "REVERT_HEAD", "--", NULL);
+		break;
+	case REPLAY_PICK:
+		if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD"))
+			die(_("No cherry-pick in progress?"));
+		strvec_pushl(&cmd.args, "show", "CHERRY_PICK_HEAD", "--", NULL);
+		break;
+	case REPLAY_INTERACTIVE_REBASE:
+		if (!refs_ref_exists(get_main_ref_store(r), "REBASE_HEAD"))
+			die(_("No rebase in progress?"));
+		strvec_pushl(&cmd.args, "show", "REBASE_HEAD", "--", NULL);
+		break;
+	}
+	return run_command(&cmd);
+}
+
 static int save_todo(struct todo_list *todo_list, struct replay_opts *opts,
 		     int reschedule)
 {
diff --git a/sequencer.h b/sequencer.h
index 913a0f652d..e20cb8bc56 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -162,6 +162,8 @@ int sequencer_pick_revisions(struct repository *repo,
 			     struct replay_opts *opts);
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
+int sequencer_show_current_patch(struct repository *repo,
+				 struct replay_opts *opts);
 int sequencer_skip(struct repository *repo, struct replay_opts *opts);
 void replay_opts_release(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index c88d597b12..4f50d287a6 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -566,6 +566,36 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
 	test_grep ! "Changes not staged for commit:" actual
 '
 
+test_expect_success 'cherry-pick --show-current-patch fails if no cherry-pick in progress' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --show-current-patch
+'
+
+test_expect_success 'cherry-pick --show-current-patch describes patch that failed to apply' '
+	test_when_finished "git cherry-pick --abort || :" &&
+	pristine_detach initial &&
+	git show picked >expected &&
+
+	test_must_fail git cherry-pick picked &&
+
+	git cherry-pick --show-current-patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'revert --show-current-patch fails if no revert in progress' '
+	pristine_detach initial &&
+	test_must_fail git revert --show-current-patch
+'
+
+test_expect_success 'revert --show-current-patch describes patch that failed to apply' '
+	test_when_finished "git revert --abort || :" &&
+	pristine_detach initial &&
+	git show picked >expected &&
+	test_must_fail git revert picked &&
+	git revert --show-current-patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'cherry-pick --continue remembers --keep-redundant-commits' '
 	test_when_finished "git cherry-pick --abort || :" &&
 	pristine_detach initial &&
-- 
2.43.0.77.gff6ea8bb74

