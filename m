Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69028313524
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245855; cv=none; b=sWgRyhSu/UpaVA4r2kjYhxsHMbrEZSvEgYhhBWw2kVGipdeRDcmskm7mgSHRQzhL3s2E2ZwoIu4U4A83oXvaHauakYWVZdWWcmKT3mgS9hwQsNLgbHz8iPauGJ+pYdxayYXXsNAuda51jIrD3FevBE58KI0fSmZAoWVqQ7MCAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245855; c=relaxed/simple;
	bh=QQgPB/uGBOWYGRLo1bGi7Yx2rrewVZyr2ob9SNcvieg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYYMMorqql69ejTE5Ohb2nCBYn1OKgf/jEBWrN9w968MmrsNlFpTAU010laDyY/3ISElfWkF2SHycAwIA+t+20EeqW9bnk7IbJTQ5Ut+0SXeNFC6/wkMuGDYLLeHbQ9o25xlPpw2tCoN9z6TCjvyNnGrdNfgLBfn0s92MFFzJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0nMKFdi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0nMKFdi"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47721743fd0so28076865e9.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245852; x=1762850652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0kyJkAfnEaVgKwW4Q6fKIqrx2Vy/zvsXIhFwcmI4I8=;
        b=d0nMKFdiAKS6ESB4mbbPp+ofY2Y6UUecuVODFsc9bf5aW1oDVJEweL1rBPUKcHXnpR
         DkhuhodYPg0tgD2l9UpHnMaz/3CSbKxvt1fzd8OMBsE4b1pLJx1G009lRePTKOEuHswc
         TZ1HzGmuCasRPj349sCiGmza0H5QG+mMejXARXlqaggmBtmQ6Dgr/0DYYfW6DRRfRr1s
         Z+pMyzViyi26aMidBr65yRJhQrIBEShWxCyKtzBbW2Lz192phaj9jIGu/KuENmD05hj6
         I2RWlOE8TH6Qh3cR8WHh0+qJGYpS4gPDMOasRM/5PXXwpIJkNPqlMok5xpqDp7nfBhQr
         cd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245852; x=1762850652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0kyJkAfnEaVgKwW4Q6fKIqrx2Vy/zvsXIhFwcmI4I8=;
        b=tbxZio0H/zblazWsk1Z14qoW3RN6A15rqZIE071VmIPyC2B90hMPPXbEvJa4xbmByK
         h+BKMZI57L97ctM6d3BlR4ryp3X5Gkv29j5stct2J4D+2A0w7xdqiDhVZm5JklKQ+Qxq
         m2CC6NP6qt7uJqZqkoKj820ABjxVlDVhc72VTLrW/DW3nswRtSypK8H5dbRPYCrCI0b4
         xkarRlshY4OdOJo2uP0IgDXrx6bnEbrXXXINjxgQNzJWQ33a173XnDuZbdZ+5S97OfP7
         qbTao0UqjqtRIrkylIIbNr5wxsZjNDDjJ8fDNm1CBWipMIx/ozTf6MCMb9bNkyQYgXUd
         s0cg==
X-Gm-Message-State: AOJu0YxtysSOeMD4fk7AU8t7GQ9E7QC+SuALIpbVzuck/EOljILeL04M
	Y2JEvFELw9GQ2va/T3wmw1F3z+xqBo48vWB5tYxIiJ2OTOa+W19vepR3
X-Gm-Gg: ASbGnculyoDGNCE4mV1NsBi7lBzlFAYrVeYS37y5Q6gmK0fGbdbn5FZGLKrVi1biF9g
	uTOIlXNSe22LWBQ8rGd4srBW8J46MlIr3e4S8W/vfICUZoFqKT3ixWea/+IzAn6nUqBi2isQ0Kg
	SEAuIm2wDWh0i1h0Hafm43hQcP4tIaANVKU0AxZsFsLQHF7fvfMF5BNApltdDJZuvTFCCjrzC9c
	Jja/SRQAg6YSOwcayJXtrn+amuwehLH81c4Ds8qNgZ7OV4m+/hUKEueYJ5YyrP9UNmSQ4J+jbK5
	W9S1s98COQMALvHB4glF6qxyBH3yplgD7FT3d75crnjbL00IbAESv3Blaf/pkxJ8mwGrWDjM4c1
	Mrtfvtth9sUN8EoSEBvmzGY1ozVeRVfb6h4qvjSs+agwzuNDt6TBi4c/O4lYtFzWTSSTE9YKwzV
	UByEtDzXUSEasLHdo=
X-Google-Smtp-Source: AGHT+IFKJu4i0QkFZ31WDGFoLGUcLn3f0MY820oY3ulL+U0OU/lTfFHR85Pq19txsDgSIZM2I/CDyg==
X-Received: by 2002:a05:600c:6303:b0:46e:4be1:a423 with SMTP id 5b1f17b1804b1-477307b7e7amr121910455e9.1.1762245851450;
        Tue, 04 Nov 2025 00:44:11 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:b03:96aa:b9b4:f746:b8e9:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm193379035e9.13.2025.11.04.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:44:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 04 Nov 2025 09:44:00 +0100
Subject: [PATCH v2 5/5] maintenance: add 'is-needed' subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-5-303462a9e4ed@gmail.com>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14580;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=QQgPB/uGBOWYGRLo1bGi7Yx2rrewVZyr2ob9SNcvieg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkJvNXx7+r+MZw0gfRXG9DiqM4XsoGm/90FP
 Oa4tPX+B9SAIYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCbzVAAoJED7VnySO
 Rox/Y4YL/A2H5wHMxlnVW57e1jh0YB/koHVTjMUQZPQrIVomWNURy63wf7ZXJI5RaBHJWAtW4dQ
 d85sq1caCPnCmixM8slQOcyUT6W5qCBgbxkAPzdCImV8tYA0zLMra66lT4koaNW5cLjnhgiOiMb
 ciZUdFyVeKgJTnSC7t5Iiz9ru8d+hpD7YjfGtNUXIgMCoPcgnMk75kNch+v5GHVFd6WknM8h9uD
 baO2sV94wIPHzTGHlCIu3EU0LP8QnQERhO0rTUYieYGTQzgRDAl3O2acCsTklXpfCa+kuqk/Tlx
 EOXsrpoV0m5rlfLu5SK4KtXsFAlpwGvqAhUrGkrYXCLN1CYs112VeQyW8LJf5OLzcsqLov8t9pM
 HEgGdsPjUgbdMjL/3n8NsshbShf8+kMxQg8hqjo1fGFxyyspSC8abTrxFze/fLaETT0PKhVUdgP
 /wygKbasDM7mP5qrvrOdmi8w85pAHA4e4MajV5r6Cdc6cycGHNCnOXzZ6rrv7yfEPEoXuMpVVl7
 Rg=
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
 Documentation/git-maintenance.adoc | 13 +++++++++
 builtin/gc.c                       | 55 +++++++++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh             | 54 ++++++++++++++++++++++++++-----------
 3 files changed, 105 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 540b5cf68b..37939510d4 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -12,6 +12,7 @@ SYNOPSIS
 'git maintenance' run [<options>]
 'git maintenance' start [--scheduler=<scheduler>]
 'git maintenance' (stop|register|unregister) [<options>]
+'git maintenance' is-needed [<options>]
 
 
 DESCRIPTION
@@ -84,6 +85,16 @@ The `unregister` subcommand will report an error if the current repository
 is not already registered. Use the `--force` option to return success even
 when the current repository is not registered.
 
+is-needed::
+    Check whether maintenance needs to be run without actually running it.
+    Exits with a 0 status code if maintenance needs to be run, 1 otherwise.
+    Ideally used with the '--auto' flag.
++
+If one or more `--task` options	are specified, then those tasks are checked
+in that order. Otherwise, the tasks are determined by which
+`maintenance.<task>.enabled` config options are true. By default, only
+`maintenance.gc.enabled` is true.
+
 TASKS
 -----
 
@@ -183,6 +194,8 @@ OPTIONS
 	in the `gc.auto` config setting, or when the number of pack-files
 	exceeds the `gc.autoPackLimit` config setting. Not compatible with
 	the `--schedule` option.
+	When combined with the `is-needed` subcommand, check if the required
+	thresholds are met without actually running maintenance.
 
 --schedule::
 	When combined with the `run` subcommand, run maintenance tasks
diff --git a/builtin/gc.c b/builtin/gc.c
index c3e7a84ec2..e5ba2a2e72 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -3253,7 +3253,59 @@ static int maintenance_stop(int argc, const char **argv, const char *prefix,
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
+	if (argc)
+		usage_with_options(builtin_maintenance_is_needed_usage, options);
+
+	gc_config(&cfg);
+	initialize_task_config(&opts, &selected_tasks);
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
@@ -3270,6 +3322,7 @@ int cmd_maintenance(int argc,
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

