Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDB37CD5E
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326699; cv=none; b=TpFsWeE+2p3qJVeTn91qDoWHP1Iot/WBKQXOz0Zq7Z0IyJalcX+JawmssPlt4vzCdmI+4Z2I/VZ8KRoEzMdm8aD0iccb1POwtnYUyibxQB9xomGoh8u/MCgNarZc/hh5tbjet2OlfHUEPF847u+IKMr5njEQzP0SCvfLN+4Vl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326699; c=relaxed/simple;
	bh=jLV2ugOV3VAiD9sOA3cYTjoEWvjIF99oHSDwQiZm3uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTpgNiCtDf1eLjF7fHgCTVH2KHfG/Vt0qCT+qOyVdFGv/V3d0EomjlFVkaBvkloiIvMmkcXZ2li1xj/pxmElvzFFWW+3hbG/+sKroEpu9E3pUzcDABSgmtOQ75jqb2sZGJ4bDkSR0q9H6qdWQiV9gr2gUnkVxlIgSi0ywjlpg+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mklz4TWw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mklz4TWw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso7054735e9.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773326693; x=1773931493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsdHXjkjLfCkbnw6Af/1jCGKt5thRYe+n9W1Xs09nHs=;
        b=Mklz4TWwiI2qxxDTTPhiRsuTHs6N9IT7Q10Volzqb6oGvzcNyPq0mT3xASItBf9x3+
         Gl3niCBCVj6XD6I7Tg4LqOz4r1Hs/5ap/OdNO4N2VQaoptH8imDEm+7Gml68ZM4z7eBa
         eOFXvXv6asdwU0RUywz3BcqAzudDQDi5fxhQFrBhXYtCwn+gxllP++PmgCTHVAsDdXb5
         nRVYRNfMObni5AGMCZZ4Ve1N4A77uyeEQYUNrZkyaleCz1GauAz2utNJtXg07ddPH22w
         EARnR82mmdmOStpYMHsgdzC4Z3umVs17LM6ydjsnDgKrK64iqqNluTLk4B3qVdxqKglw
         KavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773326693; x=1773931493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AsdHXjkjLfCkbnw6Af/1jCGKt5thRYe+n9W1Xs09nHs=;
        b=s5NiqsJqpPY338JQ6ydzbYZvF3r1lKOuO44TlPgXOoGE3YLhjC/VQZZFHuXrMcx1hS
         x+rIWHUhJvx1FGhdMtAe1HsWLQ+ntNnoPfPh1rlzDeBOL8O7ARGnvX1rQtRmHu1xXTcS
         kFohd6ICDWSglG4O8ev0nRQGU2UNvqi2aM3VShnx6SfuFv9OzhSFdjKRRCRmZDaQZ2+O
         6grhV+ni/cYHzgBn/p+9q6mUgcDVGZmJpAr4gMexMU4KNgvUQgVkAMGSxtuMTH/7w753
         WHPefZZ7CNA6F7CPy83HcSeghOYPTIBsfxpgsIRuDr1wwJUXZhM6w1UoOIe7FrQIPScK
         ipWg==
X-Gm-Message-State: AOJu0Yzd5zTa5L4tcr3IQoK/X17oazhVdXyhLAy7LWUUlRaqsaFL6Ffm
	guUDj9w6v5/yfQ8Qid2yFEpQ/gDFXq33AatfZi4SABhCmVDIcYPg7BQqSseL/Q==
X-Gm-Gg: ATEYQzw+GllO9mRRDv/PrlxEAFy3QOq7HB99d2czOmixkq6N7O6tCo/nZ05VoEB4X4U
	8OLCfr0jgmpJ8/GvcJaTyfnh+oLXvzuJDIQX62N/10da/PzgbT2N3beqwb4Pl/tFlWax+dUijMe
	n4htNEOKtXAzK6DX9PtF39XLNeLLGf0feho1fwy8zHAZBotnqktFvnmCaSXxZrSYJz+4m4dt+dw
	FpHbaZdr5R3H0qfRXm5vb1qlLOJr73S0ZBViQF1NEIStEfb0M0Oow05HWp+1WFHFwfUCQ7wVGHu
	46TdEdFSqL2DKj9kTHRMEYQ2Qmcf9JRoXPel/yzXYNDAmk/D4oTfPRusujuPpv8JJtVoTv8T5vd
	ELvAmrJVGLCTnUD0IjwAa1RBLcTuacBDlNokltmC2YcDy1jlKaX+dAoM9ouXAgXsyGUQ1OuWte3
	4y/Zd9p9KonzW2yAc=
X-Received: by 2002:a05:600c:1f87:b0:485:42ba:fc8 with SMTP id 5b1f17b1804b1-4854b0a547cmr113965335e9.4.1773326693035;
        Thu, 12 Mar 2026 07:44:53 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm130688015e9.0.2026.03.12.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:44:52 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	peff@peff.net,
	gitster@pobox.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH v3 2/2] run-command: wean auto_maintenance() functions off the_repository
Date: Thu, 12 Mar 2026 17:44:37 +0300
Message-ID: <20260312144437.626392-3-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312144437.626392-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
 <20260312144437.626392-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The prepare_auto_maintenance() relies on the_repository to read
configurations. Since run_auto_maintenance() calls
prepare_auto_maintenance(), it also implicitly depends the_repository.

Add 'struct repository *' as a parameter to both functions and update
all callers to pass the_repository.

With no global repository dependencies left in this file, remove the
USE_THE_REPOSITORY_VARIABLE macro.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 builtin/am.c           |  2 +-
 builtin/commit.c       |  2 +-
 builtin/fetch.c        |  2 +-
 builtin/merge.c        |  2 +-
 builtin/rebase.c       |  4 +++-
 builtin/receive-pack.c |  2 +-
 run-command.c          | 16 ++++++++--------
 run-command.h          |  7 +++++--
 8 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e0c767e223..9d0b51c651 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1937,7 +1937,7 @@ static void am_run(struct am_state *state, int resume)
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
-		run_auto_maintenance(state->quiet);
+		run_auto_maintenance(the_repository, state->quiet);
 	}
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 844bdcc728..7b23c1f883 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1958,7 +1958,7 @@ int cmd_commit(int argc,
 	git_test_write_commit_graph_or_die(the_repository->objects->sources);
 
 	repo_rerere(the_repository, 0);
-	run_auto_maintenance(quiet);
+	run_auto_maintenance(the_repository, quiet);
 	run_commit_hook(use_editor, repo_get_index_file(the_repository),
 			NULL, "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8a36cf67b5..4795b2a13c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2873,7 +2873,7 @@ int cmd_fetch(int argc,
 			if (opt_val != 0)
 				git_config_push_parameter("maintenance.incremental-repack.auto=-1");
 		}
-		run_auto_maintenance(verbosity < 0);
+		run_auto_maintenance(the_repository, verbosity < 0);
 	}
 
  cleanup:
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e456a381c..2cbce56f8d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -506,7 +506,7 @@ static void finish(struct commit *head_commit,
 			 * We ignore errors in 'gc --auto', since the
 			 * user should see them.
 			 */
-			run_auto_maintenance(verbosity < 0);
+			run_auto_maintenance(the_repository, verbosity < 0);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c487e10907..8c1316db38 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -562,7 +562,9 @@ static int finish_rebase(struct rebase_options *opts)
 	 * We ignore errors in 'git maintenance run --auto', since the
 	 * user should see them.
 	 */
-	run_auto_maintenance(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
+	run_auto_maintenance(the_repository,
+			!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
+
 	if (opts->type == REBASE_MERGE) {
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d6225df890..e34edff406 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2727,7 +2727,7 @@ int cmd_receive_pack(int argc,
 		if (auto_gc) {
 			struct child_process proc = CHILD_PROCESS_INIT;
 
-			if (prepare_auto_maintenance(1, &proc)) {
+			if (prepare_auto_maintenance(the_repository, 1, &proc)) {
 				proc.no_stdin = 1;
 				proc.stdout_to_stderr = 1;
 				proc.err = use_sideband ? -1 : 0;
diff --git a/run-command.c b/run-command.c
index ed5e8be976..38f4c699f8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -1937,11 +1936,12 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
 
-int prepare_auto_maintenance(int quiet, struct child_process *maint)
+int prepare_auto_maintenance(struct repository *r, int quiet,
+			     struct child_process *maint)
 {
 	int enabled, auto_detach;
 
-	if (!repo_config_get_bool(the_repository, "maintenance.auto", &enabled) &&
+	if (!repo_config_get_bool(r, "maintenance.auto", &enabled) &&
 	    !enabled)
 		return 0;
 
@@ -1950,12 +1950,12 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
 	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
 	 * retain behaviour from when we used to run git-gc(1) here.
 	 */
-	if (repo_config_get_bool(the_repository, "maintenance.autodetach", &auto_detach) &&
-	    repo_config_get_bool(the_repository, "gc.autodetach", &auto_detach))
+	if (repo_config_get_bool(r, "maintenance.autodetach", &auto_detach) &&
+	    repo_config_get_bool(r, "gc.autodetach", &auto_detach))
 		auto_detach = git_env_bool("GIT_TEST_MAINT_AUTO_DETACH", true);
 
 	maint->git_cmd = 1;
-	maint->odb_to_close = the_repository->objects;
+	maint->odb_to_close = r->objects;
 	strvec_pushl(&maint->args, "maintenance", "run", "--auto", NULL);
 	strvec_push(&maint->args, quiet ? "--quiet" : "--no-quiet");
 	strvec_push(&maint->args, auto_detach ? "--detach" : "--no-detach");
@@ -1963,10 +1963,10 @@ int prepare_auto_maintenance(int quiet, struct child_process *maint)
 	return 1;
 }
 
-int run_auto_maintenance(int quiet)
+int run_auto_maintenance(struct repository *r, int quiet)
 {
 	struct child_process maint = CHILD_PROCESS_INIT;
-	if (!prepare_auto_maintenance(quiet, &maint))
+	if (!prepare_auto_maintenance(r, quiet, &maint))
 		return 0;
 	return run_command(&maint);
 }
diff --git a/run-command.h b/run-command.h
index af4c9da279..ad25740fe6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -5,6 +5,8 @@
 
 #include "strvec.h"
 
+struct repository;
+
 /**
  * The run-command API offers a versatile tool to run sub-processes with
  * redirected input and output as well as with a modified environment
@@ -227,12 +229,13 @@ int run_command(struct child_process *);
  * process has been prepared and is ready to run, or 0 in case auto-maintenance
  * should be skipped.
  */
-int prepare_auto_maintenance(int quiet, struct child_process *maint);
+int prepare_auto_maintenance(struct repository *r, int quiet,
+			     struct child_process *maint);
 
 /*
  * Trigger an auto-gc
  */
-int run_auto_maintenance(int quiet);
+int run_auto_maintenance(struct repository *r, int quiet);
 
 /**
  * Execute the given command, sending "in" to its stdin, and capturing its
-- 
2.53.0

