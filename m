Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E534B430
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920551; cv=none; b=hgWtdD4ep1eSUn9tWb/tNBS1F7I6WXnGVD2Nk6yQFg+o5ANJfml93X54UUk+K271UvU2nnvU8OSBxXRaZDekcLxJPyK7DUt9Cb+45N5Tg/PzjuolGJRoCmQBzHU1zQVGpnrP+8BwLF7TXvJnQV9/gUZpIlv9E5ZLHA5IQgyA1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920551; c=relaxed/simple;
	bh=KbjakZnhRzhCDHWfQdwM1wUPyERyJmBuiDf4SHSI7k0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKt7U4LmOZ0x+e83rEgIOovsL6dsqlGa8XG/rgTZJtn3jWmZVLs/IMGuWvXZ/hq51E0WYqgiDmmM4xPdt3KuoA6WVKeDIN3XbjY8nQTkSl0+tIRDzP+5iqHQVBkDNJx/O1ROghTfR+GJjhlThEdz+Ez4RTplu+ohLinptdDHMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWOZTbOI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWOZTbOI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so18713545e9.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920547; x=1762525347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xNX3+eNNxRYrS6dUUfpblq2jID3KSKzJIZtKgJwt94=;
        b=gWOZTbOISeu3O240e4CZ5S7U7wCcLnVsbmNtVS5Ba8/v6ILL5W6SLAcwYsSV9lx+cv
         ub0C98vzLJUyX/PyStLkASEQKrgYju5ggBqErosjYc7c0tNnA7pIDAXd6C1Hufi4neHm
         L5qpRn+AgLxHDHd5uel5c6AKi/VxTL6jHIOr7K+E2Spm0kIr8rKpVPGjvfpY9inxLdfh
         ChERw+uDgjeAhmIL6p+0rQkWPYtP93ev9eSB9FQ2axoSOXx8k4E13jNXBJFXnuwpydlH
         cdI9aX5+sBXtb7LfWuLWaBcg6f64m01yM0ILPqwx4lVPdE4RBnAZ3umoknYZkngpnCM4
         5Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920547; x=1762525347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xNX3+eNNxRYrS6dUUfpblq2jID3KSKzJIZtKgJwt94=;
        b=K8BXdhPHjjJRBTHWUnHjaXphe16+OMMZ5lI3HLjXotDvp9i38A5clgA3WCr2w3dn4C
         t8qnpWwdMqscTkCDoGjSBi5oy4RK0WvkvctqK5J4ecETUziRxs7MMsG95Z+ZYBFhjl6s
         5jNLpRC6hZVb3VVHTHP8y6zzZBL4X1qPsQvQC+hNxQGMYaYDkfMBgL0Jpxxqjs7CA++d
         FgkR7Hz+H0yBHJpmmoGJg/v9FcHl4juzYZZRxc/TpQwECHZHWLVt8+5lS6UmiF/K9rEy
         7OBTTWq78ukCGo3RrZSKXWlkUDjNfVuh0eHNT4ztqVB5GovF68hnpAoXNnxRdtD1AonU
         N5IA==
X-Gm-Message-State: AOJu0YynYWphLm2zZM+oAYszte3H8ksoVedGfAIt3y0WEnkgy4uTXPdr
	hyvp81Na2YHVbgV8PnOUjJxCBxRmo1ooUae52ye14lH+8zY1krJKEVbV10bMIGvv
X-Gm-Gg: ASbGncuUShldTo7gBXb8Y0uxR5Su39ji/kQ6fjJ5I0UBq0by8r/Bm1VW4cmWehienQD
	1PFIxKXsX2+C2v5lJWJb91orH4nvzR7eqlTI4vi6T2aaUP2F/2e7hoS7hw6QVQAh1sochA/65R5
	ruxC7JGfcXvMCzoOmcV4AtpfQKtKV07qs9tD+kPka1eioo3Im2NZ8YW9E8CTKYCuIxFF1coXNao
	XB2GVCNz7QF06dPK43wl0f+iYipqREEY8/g9/X9eNvB2lBDHSLEC0Rq6rtxknbno98Db24Xpe8u
	fHa9BGOAxVlpmCBV/2O6z4ymsnrUYshtBPdcF4LpHtV9R8wncOmB683RgXUyeZ3/nC3661P+Hhb
	7fo9kpkj1TCoL5ckqNOzoSeLw+oM8o/mFm42hMsKFe3atRBH6NvTdtD9uEhbaj0H3tTkhXdY1Lj
	+aCRsYW8PmxyzgJQ==
X-Google-Smtp-Source: AGHT+IEE4tZmmSMOpLSZvApxSPhuxinP7i0ZSF3Cl1P1IWoTFohZvV0Hdbhw2+L8deo2KWi7a6Httw==
X-Received: by 2002:a05:600c:3f14:b0:477:e09:f0f with SMTP id 5b1f17b1804b1-477307d763dmr39072335e9.8.1761920547123;
        Fri, 31 Oct 2025 07:22:27 -0700 (PDT)
Received: from [127.0.0.2] ([213.61.187.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2eae9csm570435e9.1.2025.10.31.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 31 Oct 2025 15:22:25 +0100
Subject: [PATCH 5/5] maintenance: add 'is-needed' subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-5-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14360;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=KbjakZnhRzhCDHWfQdwM1wUPyERyJmBuiDf4SHSI7k0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkExh6QEgvUEP22yqJNjcDCxqb2PB6aWnzyF
 3VW26riuk9IqIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpBMYeAAoJED7VnySO
 Rox/oXwMAI1wku4gHgvyK3FDZ1IA/BJLFPVGO2rMeC8cYrG7324IPnnEuz89eddjpa2BKTOK5cP
 OT4Uh8jekxfS6gCPFkmnywvjdqSoMsSmEjna34W+uerkm67MfFLXEOlCVweXhy7trvJoubQylj3
 Hls1f1+MlPWh2kXoK36NkhL+4O3Nqvc7FjJ3nXoKkAaN3NWMXbyLP1UVf5mttFzSsWzBF1SPvjH
 hB59K6zAUnvo54pmK2O3h2nEvJp/CuWtEzCWlJIg4LP5sKM9iSYnHkUcCU8bzPnIVXixNhrbgqM
 pyUzuvGRf3bSE7YAbUxNu7+WECcuiK2pxyEJn9fPtKRf/fN0la4omTZh8pZfImRqy7DkgBl4G6s
 lGQ5WIIGml8jVS9jrU/kMKCZyY28+gqkfKWqMgnePZVgp5SWlk0SvH1VNJyXOaaP5x0u8c7HA0q
 QIp6DtrITYPIbA5GyB+dbOIZbCUd+F/XTVhvKHxTsbEsfQFUA2ufSAlqFNYUglYomY4HfPCf+r7
 zc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-maintenance(1)' command provides tooling to run maintenance
tasks over Git repositories. The 'run' subcommand, as the name suggests,
runs the maintenance tasks. When used with the '--auto' flag, it uses
heuristics to determine if the required thresholds are met for running
said maintenance tasks.

There is however a lack of insight into these heuristics. Meaning, the
checks are linked to the execution.

Add a new 'is-needed' subcommand to 'git-maintenance(1)' which allows
users to simply check if it is needed to run maintenance without
performing it.

This subcommand can check if it is needed to run maintenance without
actually running it. Ideally it should be used with the '--auto' flag,
which would allow users to check if the thresholds required are met. The
subcommand also supports the '--task' flag which can be used to check
specific maintenance tasks.

While adding the respective tests in 't/t7900-maintenance.sh', remove a
duplicate of the test: 'worktree-prune task with --auto honors
maintenance.worktree-prune.auto'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-maintenance.adoc |  8 ++++++
 builtin/gc.c                       | 56 +++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh             | 54 +++++++++++++++++++++++++-----------
 3 files changed, 101 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 540b5cf68b..edcc88f4d0 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git maintenance' run [<options>]
 'git maintenance' start [--scheduler=<scheduler>]
 'git maintenance' (stop|register|unregister) [<options>]
+'git maintenance' is-needed [<options>]
 
 
 DESCRIPTION
@@ -84,6 +85,11 @@ The `unregister` subcommand will report an error if the current repository
 is not already registered. Use the `--force` option to return success even
 when the current repository is not registered.
 
+is-needed::
+    Check whether maintenance needs to be run without actually running it.
+    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
+    Can be used along with `--task`. Ideally should be used with '--auto'.
+
 TASKS
 -----
 
@@ -183,6 +189,8 @@ OPTIONS
 	in the `gc.auto` config setting, or when the number of pack-files
 	exceeds the `gc.autoPackLimit` config setting. Not compatible with
 	the `--schedule` option.
+	When combined with the `is-needed` subcommand, check if the required
+	thresholds are met without actually running maintenance.
 
 --schedule::
 	When combined with the `run` subcommand, run maintenance tasks
diff --git a/builtin/gc.c b/builtin/gc.c
index 72177305ff..4d20487ed6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -3253,7 +3253,60 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
 	return update_background_schedule(NULL, 0);
 }
 
-static const char * const builtin_maintenance_usage[] = {
+static const char *const builtin_maintenance_is_needed_usage[] = {
+	"git maintenance is-needed [--task=<task>] [--schedule]",
+	NULL
+};
+
+static int maintenance_is_needed(int argc, const char **argv, const char *prefix,
+				 struct repository *repo UNUSED)
+{
+	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
+	struct string_list selected_tasks = STRING_LIST_INIT_DUP;
+	struct gc_config cfg = GC_CONFIG_INIT;
+	struct option options[] = {
+		OPT_BOOL(0, "auto", &opts.auto_flag,
+			 N_("run tasks based on the state of the repository")),
+		OPT_CALLBACK_F(0, "task", &selected_tasks, N_("task"),
+			       N_("check a specific task"),
+			       PARSE_OPT_NONEG, task_option_parse),
+		OPT_END()
+	};
+	bool is_needed = false;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_is_needed_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	gc_config(&cfg);
+	initialize_task_config(&opts, &selected_tasks);
+
+	if (argc)
+		usage_with_options(builtin_maintenance_is_needed_usage, options);
+
+	if (opts.auto_flag) {
+		for (size_t i = 0; i < opts.tasks_nr; i++) {
+			if (tasks[opts.tasks[i]].auto_condition &&
+			    tasks[opts.tasks[i]].auto_condition(&cfg)) {
+				is_needed = true;
+				break;
+			}
+		}
+	} else {
+		/* When not using --auto, we should always require maintenance. */
+		is_needed = true;
+	}
+
+	string_list_clear(&selected_tasks, 0);
+	maintenance_run_opts_release(&opts);
+	gc_config_release(&cfg);
+
+	if (is_needed)
+		return 0;
+	return 1;
+}
+
+static const char *const builtin_maintenance_usage[] = {
 	N_("git maintenance <subcommand> [<options>]"),
 	NULL,
 };
@@ -3270,6 +3323,7 @@ int cmd_maintenance(int argc,
 		OPT_SUBCOMMAND("stop", &fn, maintenance_stop),
 		OPT_SUBCOMMAND("register", &fn, maintenance_register),
 		OPT_SUBCOMMAND("unregister", &fn, maintenance_unregister),
+		OPT_SUBCOMMAND("is-needed", &fn, maintenance_is_needed),
 		OPT_END(),
 	};
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ddd273d8dc..a17e2091c2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -49,7 +49,9 @@ test_expect_success 'run [--auto|--quiet]' '
 		git maintenance run --auto 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-quiet.txt" \
 		git maintenance run --no-quiet 2>/dev/null &&
+	git maintenance is-needed &&
 	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-no-auto.txt &&
+	! git maintenance is-needed --auto &&
 	test_subcommand ! git gc --auto --quiet --no-detach --skip-foreground-tasks <run-auto.txt &&
 	test_subcommand git gc --no-quiet --no-detach --skip-foreground-tasks <run-no-quiet.txt
 '
@@ -180,6 +182,11 @@ test_expect_success 'commit-graph auto condition' '
 
 	test_commit first &&
 
+	! git -c maintenance.commit-graph.auto=0 \
+		maintenance is-needed --auto --task=commit-graph &&
+	git -c maintenance.commit-graph.auto=1 \
+		maintenance is-needed --auto --task=commit-graph &&
+
 	GIT_TRACE2_EVENT="$(pwd)/cg-zero-means-no.txt" \
 		git -c maintenance.commit-graph.auto=0 $COMMAND &&
 	GIT_TRACE2_EVENT="$(pwd)/cg-one-satisfied.txt" \
@@ -290,16 +297,23 @@ test_expect_success 'maintenance.loose-objects.auto' '
 		git -c maintenance.loose-objects.auto=1 maintenance \
 		run --auto --task=loose-objects 2>/dev/null &&
 	test_subcommand ! git prune-packed --quiet <trace-lo1.txt &&
+
 	printf data-A | git hash-object -t blob --stdin -w &&
+	! git -c maintenance.loose-objects.auto=2 \
+		maintenance is-needed --auto --task=loose-objects &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-loA" \
 		git -c maintenance.loose-objects.auto=2 \
 		maintenance run --auto --task=loose-objects 2>/dev/null &&
 	test_subcommand ! git prune-packed --quiet <trace-loA &&
+
 	printf data-B | git hash-object -t blob --stdin -w &&
+	git -c maintenance.loose-objects.auto=2 \
+		maintenance is-needed --auto --task=loose-objects &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-loB" \
 		git -c maintenance.loose-objects.auto=2 \
 		maintenance run --auto --task=loose-objects 2>/dev/null &&
 	test_subcommand git prune-packed --quiet <trace-loB &&
+
 	GIT_TRACE2_EVENT="$(pwd)/trace-loC" \
 		git -c maintenance.loose-objects.auto=2 \
 		maintenance run --auto --task=loose-objects 2>/dev/null &&
@@ -421,10 +435,13 @@ run_incremental_repack_and_verify () {
 	test_commit A &&
 	git repack -adk &&
 	git multi-pack-index write &&
+	! git -c maintenance.incremental-repack.auto=1 \
+		maintenance is-needed --auto --task=incremental-repack &&
 	GIT_TRACE2_EVENT="$(pwd)/midx-init.txt" git \
 		-c maintenance.incremental-repack.auto=1 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <midx-init.txt &&
+
 	test_commit B &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
@@ -434,11 +451,14 @@ run_incremental_repack_and_verify () {
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
 	test_subcommand ! git multi-pack-index write --no-progress <trace-A &&
+
 	test_commit C &&
 	git pack-objects --revs .git/objects/pack/pack <<-\EOF &&
 	HEAD
 	^HEAD~1
 	EOF
+	git -c maintenance.incremental-repack.auto=2 \
+		maintenance is-needed --auto --task=incremental-repack &&
 	GIT_TRACE2_EVENT=$(pwd)/trace-B git \
 		-c maintenance.incremental-repack.auto=2 \
 		maintenance run --auto --task=incremental-repack 2>/dev/null &&
@@ -485,9 +505,15 @@ test_expect_success 'reflog-expire task --auto only packs when exceeding limits'
 	git reflog expire --all --expire=now &&
 	test_commit reflog-one &&
 	test_commit reflog-two &&
+
+	! git -c maintenance.reflog-expire.auto=3 \
+		maintenance is-needed --auto --task=reflog-expire &&
 	GIT_TRACE2_EVENT="$(pwd)/reflog-expire-auto.txt" \
 		git -c maintenance.reflog-expire.auto=3 maintenance run --auto --task=reflog-expire &&
 	test_subcommand ! git reflog expire --all <reflog-expire-auto.txt &&
+
+	git -c maintenance.reflog-expire.auto=2 \
+		maintenance is-needed --auto --task=reflog-expire &&
 	GIT_TRACE2_EVENT="$(pwd)/reflog-expire-auto.txt" \
 		git -c maintenance.reflog-expire.auto=2 maintenance run --auto --task=reflog-expire &&
 	test_subcommand git reflog expire --all <reflog-expire-auto.txt
@@ -514,6 +540,7 @@ test_expect_success 'worktree-prune task --auto only prunes with prunable worktr
 	test_expect_worktree_prune ! git maintenance run --auto --task=worktree-prune &&
 	mkdir .git/worktrees &&
 	: >.git/worktrees/abc &&
+	git maintenance is-needed --auto --task=worktree-prune &&
 	test_expect_worktree_prune git maintenance run --auto --task=worktree-prune
 '
 
@@ -530,22 +557,7 @@ test_expect_success 'worktree-prune task with --auto honors maintenance.worktree
 	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
 	# A positive value should require at least this many prunable worktrees.
 	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
-	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
-'
-
-test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
-	# A negative value should always prune.
-	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
-
-	mkdir .git/worktrees &&
-	: >.git/worktrees/first &&
-	: >.git/worktrees/second &&
-	: >.git/worktrees/third &&
-
-	# Zero should never prune.
-	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
-	# A positive value should require at least this many prunable worktrees.
-	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
+	git -c maintenance.worktree-prune.auto=3 maintenance is-needed --auto --task=worktree-prune &&
 	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
 '
 
@@ -554,11 +566,13 @@ test_expect_success 'worktree-prune task honors gc.worktreePruneExpire' '
 	rm -rf worktree &&
 
 	rm -f worktree-prune.txt &&
+	! git -c gc.worktreePruneExpire=1.week.ago maintenance is-needed --auto --task=worktree-prune &&
 	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=1.week.ago maintenance run --auto --task=worktree-prune &&
 	test_subcommand ! git worktree prune --expire 1.week.ago <worktree-prune.txt &&
 	test_path_is_dir .git/worktrees/worktree &&
 
 	rm -f worktree-prune.txt &&
+	git -c gc.worktreePruneExpire=now maintenance is-needed --auto --task=worktree-prune &&
 	GIT_TRACE2_EVENT="$(pwd)/worktree-prune.txt" git -c gc.worktreePruneExpire=now maintenance run --auto --task=worktree-prune &&
 	test_subcommand git worktree prune --expire now <worktree-prune.txt &&
 	test_path_is_missing .git/worktrees/worktree
@@ -583,10 +597,13 @@ test_expect_success 'rerere-gc task without --auto always collects garbage' '
 
 test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
 	test_when_finished "rm -rf .git/rr-cache" &&
+	! git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
 	mkdir .git/rr-cache &&
+	! git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
 	: >.git/rr-cache/entry &&
+	git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
 '
 
@@ -594,17 +611,22 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_when_finished "rm -rf .git/rr-cache" &&
 
 	# A negative value should always prune.
+	git -c maintenance.rerere-gc.auto=-1 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
 
 	# A positive value prunes when there is at least one entry.
+	! git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
 	mkdir .git/rr-cache &&
+	! git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
 	: >.git/rr-cache/entry-1 &&
+	git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
 
 	# Zero should never prune.
 	: >.git/rr-cache/entry-1 &&
+	! git -c maintenance.rerere-gc.auto=0 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 

-- 
2.51.0

