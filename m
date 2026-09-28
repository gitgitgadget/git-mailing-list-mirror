Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3134B8287
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596709; cv=none; b=EbI7O159El4DYnOQRUswCQ5ZIf5fnyA3eAXK7wxUYNQy4iMsNyh7Nlbl8iNIjhN7YLC7SRqm2AaP5BpUF1yfP+9wGLsQTq6oXqX/S9HI0bpWrnm2WOZdPijeVb+B1T/zLnVJhIDVD3ndmhKXnvqooeJWMi6rVodJ5ZlQXL+SnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596709; c=relaxed/simple;
	bh=EVnA8gFaeEr8oyVrF8t5I1XE9HObQrM/0Uj+7OPLCgc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dKutgsPb+0aEVTxikzXR3RE3Ea3H4NXAph013gSj4XzkWf/EAPnLrbkoRdOQGJGhRXCucLwF+voKf6KLVHbbj9//4xpJSfYZnsQYOUxf942PjBdTCGuu5+r/rkUqTke4AXeiA7FF2GUZeSRD6ES5hYPtxMOqDBk0uiBDpBcP1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP8HyKcF; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP8HyKcF"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso4570303eec.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596707; x=1791201507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=42kqQ6JWAfqjQ6V7n2xIvVrrUj16K9w0sXRYrbtznrk=;
        b=QP8HyKcFTdISLL18d/Yox+FugmiFq86PMqpa3rdehtQRcfFo2z1KSIbS/nurc9nGPa
         PTSemVscvLJv33SahjB4sQ35geTLpVyHi7tm8LTrRIG9veVrlMCkusM+ldGwwmpJsbpb
         pigk7edzw3bxtIVWAqtldgiwluybr3NRL6Eack2rrz3/9yX5wejYd1pUVgwlxclsPoCG
         GpFVu53nZWBzHom+9qohHFWITqtsv9sJZ2Mr5RRSEIDFFQV4meEkKhjItKd9Rdt+Vh84
         dYHokivWm2wLOdGPpKVt0r9ojaUd4BjgKcH9OS48QUXtl1buLZJ3VY/lTcB/uO0NOk0Z
         Bb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596707; x=1791201507;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42kqQ6JWAfqjQ6V7n2xIvVrrUj16K9w0sXRYrbtznrk=;
        b=uxpWWQJOYch/SQAkr1fit8NBwInQp7wY4v/KV/MEBy7z9wbVUzUfy+2azcjBQRFePy
         cQF3fJJR7tuAY+JQNJhcWStf2zf4AtHOwDIoFDYY+oUfRC0rx1gD8M1xEwcFttgYpHO8
         BpXRLAd9+4gjvByOisL3c0MmK7gJS8cYhee0bAF/IkTKX5UwAw0Td6lApKQqsA1l5fmY
         Yr7NSfIX1e6WIAhRI4t9M6KlVqENFGI4Rw7pRFDd4AHYt50B+ibIM+/is3dZiucI3lcv
         8P2oFxVBau8A1669Ws8Db6dc6MYNiCFVmdtqekg24WDIrWm4OmBXRI1sQ3UjlN9CO7Vl
         f9Cg==
X-Gm-Message-State: AFuF++n/sIDUjmt82F0xxrqySYGEkKYBiZi/umnEtOClhjwkARmSWD13
	MZE/A1JUCJwEWJWSAFtL+L2qH8s+fkOB79rfDs/IfoESr2/qIbLD1znb+hN6KA==
X-Gm-Gg: AYBFou0qhbmF00N47b4BtvwHr61k23XN0ATaYzf0vn7cVFnwJVKFDLyTx38AYzjLr7A
	DWBISq0iQk0gBuN6YX6L2pKeTYbXVKM2njp2ps2SFRtbgAbFkPWdfKcjED0ZzjVu1Xd7Ez7JIsR
	y4rgDm6tXxieUeQjdJaONpK61X0KcL+RCR8ImXcU4NJCly1/4Ej3qpM0h3fqA/b8QAQcfV3ft/O
	xZhneX3FboBh1ahgA3oXYM7xjroO8ApLHMlkwj+E5TxxUCtH2uDuwM8eSXq/vYRC6BEJR+KAUfS
	eiaASEb4DOxqA3cXMP4mUAgJVMfUweBtpDnd/HcUsMJiRMNxn4X4tH1xWJ9+aed8L1+HIJghUlQ
	qetK7zbNHhzEzdYHG7/Hq6fxjNImgbwXYLQ4NqTdu9gY5t7G3cBBGXPeIcy05TsjAO5E0R3+gi5
	8t0ktHgRezqXEkv69+K4hjkdehq3yDGot3oBfANYMU+bDYsEDQB8fkCq1iOZ94t7/a/4bPJT7lk
	Q==
X-Received: by 2002:a05:701b:4558:20b0:148:4522:560c with SMTP id a92af1059eb24-148452256a6mr6664011c88.11.1790596706666;
        Mon, 28 Sep 2026 04:58:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.88])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14a7c03ece2sm3015087c88.16.2026.09.28.04.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:58:26 -0700 (PDT)
Message-Id: <27673137aae961105a3d3b6ea615879e0686cc65.1790596702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 11:58:21 +0000
Subject: [PATCH v5 2/3] rerere: add "gc --auto" that skips a held lock
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The previous commit made "git rerere gc" wait for MERGE_RR.lock like
every other rerere command before it fails, as it always has. That
suits a user who runs it by hand and wants to know when nothing was
pruned. It does not suit the gc that auto maintenance starts after
a commit: nobody is waiting for that run, and the next commit starts
another one.

So add "--auto", with which "git rerere gc" quietly does nothing when
the lock is taken, and pass it from "git maintenance run --auto" and
"git gc --auto", as they already do for "git pack-refs --auto". A run
without it, from the command line or a maintenance schedule, keeps
waiting and failing.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  3 ++-
 Documentation/git-rerere.adoc    |  9 ++++++---
 builtin/gc.c                     |  4 +++-
 builtin/rerere.c                 | 13 ++++++++++---
 rerere.c                         | 22 +++++++++++++++++-----
 rerere.h                         |  4 +++-
 t/t4200-rerere.sh                | 21 +++++++++++++++++++++
 t/t7900-maintenance.sh           | 25 ++++++++++++++++++++++++-
 8 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 30e827f32b..a58c2ff684 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -17,4 +17,5 @@ rerere.lockTimeout::
 	`git rerere gc`.  Value 0 means not to wait at all; -1 means
 	to wait indefinitely.  Default is 1000 (i.e., wait for 1
 	second).  When the time is up, the command fails as it does
-	for any other lock it cannot take.
+	for any other lock it cannot take.  `git rerere gc --auto`
+	does not wait and does nothing while the lock is held.
diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 4e6ab9a27c..da7a1d093e 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
+'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc [--auto]]
 
 DESCRIPTION
 -----------
@@ -63,14 +63,17 @@ Print paths with conflicts that have not been autoresolved by rerere.
 This includes paths whose resolutions cannot be tracked by rerere,
 such as conflicting submodules.
 
-'gc'::
+'gc' [--auto]::
 
 Prune records of conflicted merges that
 occurred a long time ago.  By default, unresolved conflicts older
 than 15 days and resolved conflicts older than 60
 days are pruned.  These defaults are controlled via the
 `gc.rerereUnresolved` and `gc.rerereResolved` configuration
-variables respectively.
+variables respectively.  With `--auto`, which `git maintenance run
+--auto` and `git gc --auto` pass, `gc` does nothing while another
+process holds the rerere lock.  Without it, `gc` waits for the lock
+as long as `rerere.lockTimeout` allows and then fails.
 
 
 DISCUSSION
diff --git a/builtin/gc.c b/builtin/gc.c
index 57a3520263..5c33082b5b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,12 +385,14 @@ out:
 	return should_prune;
 }
 
-static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
+static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts,
 				      struct gc_config *cfg UNUSED)
 {
 	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	rerere_cmd.git_cmd = 1;
 	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
+	if (opts->auto_flag)
+		strvec_push(&rerere_cmd.args, "--auto");
 	return run_command(&rerere_cmd);
 }
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index a056cb791b..2a8871df41 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -12,7 +12,8 @@
 #include "pathspec.h"
 
 static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
+	N_("git rerere [clear | forget <pathspec>... | diff | status | "
+	   "remaining | gc [--auto]]"),
 	NULL,
 };
 
@@ -56,16 +57,21 @@ int cmd_rerere(int argc,
 	       struct repository *repo UNUSED)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int autoupdate = -1, flags = 0;
+	int autoupdate = -1, auto_flag = 0, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
 			N_("register clean resolutions in index"), 1),
+		OPT_BOOL(0, "auto", &auto_flag,
+			 N_("skip gc while another process holds the lock")),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
 
+	if (auto_flag && (argc < 1 || strcmp(argv[0], "gc")))
+		die(_("the option '%s' requires '%s'"), "--auto", "gc");
+
 	repo_config(the_repository, git_xmerge_config, NULL);
 
 	if (autoupdate == 1)
@@ -94,7 +100,8 @@ int cmd_rerere(int argc,
 	if (!strcmp(argv[0], "clear")) {
 		rerere_clear(the_repository, &merge_rr);
 	} else if (!strcmp(argv[0], "gc"))
-		rerere_gc(the_repository, &merge_rr);
+		rerere_gc(the_repository, &merge_rr,
+			  auto_flag ? RERERE_NOWAIT : 0);
 	else if (!strcmp(argv[0], "status")) {
 		if (setup_rerere(the_repository, &merge_rr,
 				 flags | RERERE_READONLY) < 0)
diff --git a/rerere.c b/rerere.c
index 64fac07c71..43c8eb04db 100644
--- a/rerere.c
+++ b/rerere.c
@@ -887,18 +887,30 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
+	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
+		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
 	if (flags & RERERE_READONLY) {
 		fd = 0;
 	} else {
+		int lock_flags = LOCK_DIE_ON_ERROR;
+		int timeout_ms = rerere_lock_timeout_ms;
+
 		/*
 		 * Another process may hold the lock for a while, e.g.
 		 * "git rerere gc" while it prunes rr-cache, so wait for
-		 * it instead of dying right away.
+		 * it instead of dying right away.  The gc of an automatic
+		 * maintenance run does not wait, since skipping one of
+		 * its runs costs nothing.
 		 */
+		if (flags & RERERE_NOWAIT) {
+			lock_flags = 0;
+			timeout_ms = 0;
+		}
 		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
 							    git_path_merge_rr(r),
-							    LOCK_DIE_ON_ERROR,
-							    rerere_lock_timeout_ms);
+							    lock_flags, timeout_ms);
+		if (fd < 0)
+			return -1;
 	}
 	read_rr(r, merge_rr);
 	return fd;
@@ -1284,7 +1296,7 @@ out:
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr)
+void rerere_gc(struct repository *r, struct string_list *rr, int flags)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
 	DIR *dir;
@@ -1294,7 +1306,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, flags) < 0)
 		return;
 
 	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
diff --git a/rerere.h b/rerere.h
index feeb0e2c9f..d54c53d0d4 100644
--- a/rerere.h
+++ b/rerere.h
@@ -10,6 +10,8 @@ struct repository;
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 #define RERERE_READONLY     04
+/* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
+#define RERERE_NOWAIT       010
 
 /*
  * Marks paths that have been hand-resolved and added to the
@@ -37,7 +39,7 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *);
+void rerere_gc(struct repository *, struct string_list *, int);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bd92235dc..9435b0ed58 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,27 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
+test_expect_success 'gc --auto does nothing while MERGE_RR is locked' '
+	mkdir -p $rr2 &&
+	echo Hello >$rr2/preimage &&
+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
+
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	git rerere gc --auto 2>err &&
+	test_must_be_empty err &&
+	test_path_is_file $rr2/preimage &&
+
+	rm .git/MERGE_RR.lock &&
+	git rerere gc --auto &&
+	test_path_is_missing $rr2/preimage
+'
+
+test_expect_success '--auto is only accepted by gc' '
+	test_must_fail git rerere --auto clear 2>err &&
+	test_grep "option .--auto. requires .gc." err
+'
+
 test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
 	git reset --hard &&
 	rm -rf $rr &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4f65fa9439..8842340236 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1007,9 +1007,17 @@ test_expect_rerere_gc () {
 		shift
 	fi
 
+	# an automatic run passes --auto on to "git rerere gc"
+	auto=
+	case " $* " in
+	*" --auto "*)
+		auto=--auto
+		;;
+	esac
+
 	rm -f "rerere-gc.txt" &&
 	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" "$@" &&
-	test_subcommand $negate git rerere gc <rerere-gc.txt
+	test_subcommand $negate git rerere gc $auto <rerere-gc.txt
 }
 
 test_expect_success 'rerere-gc task without --auto always collects garbage' '
@@ -1084,6 +1092,21 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 
+test_expect_success 'rerere-gc task with --auto succeeds while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	mkdir .git/rr-cache &&
+	>.git/MERGE_RR.lock &&
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc
+'
+
+test_expect_success 'rerere-gc task without --auto fails while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	mkdir .git/rr-cache &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 maintenance run --task=rerere-gc 2>err &&
+	test_grep "Unable to create" err
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "cannot be used together" err
-- 
gitgitgadget

