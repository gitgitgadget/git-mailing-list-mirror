Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2034B7A4D
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596708; cv=none; b=GokMOsx2A3zcAW7WdTj/hTJ8XShm6hOOe5avNGL8s7QlIrZBfAov1J/bbSGopTeY6zD1GdBVv8MBU29arUUQtw5/P+l/0kjQk7pmMQVd0E3i4KB489zoaQI0/g25SI+n5X5a70nbpWare/bzxU+b613HKcfpJNmieCFrUX69Ryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596708; c=relaxed/simple;
	bh=uFtErnlmrrNokYnNaSrVuoyx9dKawT+6F8NpLaQaW3k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mD/wtGkZAhxxK3jpEjYxIesGMu+2uUwHUgTOff7jae2xT0mUVz5/N/gOWQPW5mQEzp1oFb/NNNC6PlG4DLCeXwHUBaAQagVLyHqf6QHetUn509rPuAv+NaigRsS4xafx8Gjh8L9A5ssM2WT9FILzKbrISo216srOfbdMHLwGeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDrj49CU; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDrj49CU"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso715993eec.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596705; x=1791201505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cLT3AWwBQBLa0KExu3UUM7bk/zVkTdl1iAjwvJCS5G8=;
        b=SDrj49CUu3elMapdNnJaPHt0TESs6F9OjnpZNMdQG9f1o7XV94mXoF+2gNe1+bI/0d
         DQIuKJs/1iLEJhBgaKAL7QKh+HwMen+Dchbhd4EV0KlH4St8VgM2pEjp8QGTf8Zq6l3S
         Mnwfwxog41wd1mvGk8P4iI2z1qo96+54MvO7uJ1AIvosV9vP9neN+/iRtVE6Ccfc/djK
         vXNVhnPUysqsvt4MfjHJFp7Wv1kRKpFp51YE0tZcE6jqU9mt1puls1sFo8ILQnGzNkRI
         p5O7qofnguTMqFn3wdZAuvsPD3RRi5fVh0/GSq4dVVeVLrreMCBqe+RyWvh0cRTDsZGS
         Enhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596705; x=1791201505;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLT3AWwBQBLa0KExu3UUM7bk/zVkTdl1iAjwvJCS5G8=;
        b=2v9fvPS8UFoCh5p/s7QJDSSQUCb0CmQi693zW0LcYnJMMJS9k/7DKAOmRPZF29q0XT
         ZKQgdQ/tqo5VKc/4hm+aPgZz2T9tE8uTDGTJgAqcOCn5UDygEmknEHjT0YTigDtB7nwb
         8c5I39fiZWDF5TorvtjcSmwgVtO1RyD1svR2lnADEOFsG+HkJSrbrgaYmnJZylk70VKO
         76JQ9M3lhPlXsB/tNMAA+AtWCwYpoDbqMHciKLDqkeaP2W9lDe1bfdNdYkqryBYXlmME
         QcGgOjkDHzlu9acnMFu6ArYpvVVji3qOfFWO+R50+REBRDThFXpjr5wDoB5BGvGos1Y5
         xmoQ==
X-Gm-Message-State: AFq9FYJC+3d9yAgBQTcRsDfjsVtYGrfbfhq5mSSZ6If/4LadY0m4VKyC
	I9x4xcsF6SMjh7qcy1G41ysm+rHAVzcwAygn6EMJKNN8c9AcdPQeNWCzN6Bxfw==
X-Gm-Gg: AYBFou2MiQ1ck5wElYEI2GkX2xheOhgqDg6vXcPx1ww9aW5OwqybC538Uht7wI/t/li
	Yh94KlsflaaTPyT3OK0v2WVMw7HkOhyZX813qfHoAmGIy87/dLQSeHG7baN8CSYgi6W+5y4OLPj
	LHdXUx5HJbBx2SR2/znLZuG+8hayQRFc1zZ2T2TzuwrVAj5zNeEcKH++5yGIr92d9vWOR3j0Ufj
	SVKa0IouYxj8VtxJD9X3lhQMhynfQRTF97xKTsvqm0aMP16Km5N+pmMmJMtBiJj7vLg4HSKQfRm
	7WashutxH+Y5On0Zo5XPhGGBOcdlzOtRwUgJC6kp8u5JflWc7ThvW3tKdIOld1yQLGk28A9otZ7
	hRoAH0mW2wsflXXL2ckQNX/hnn8NQaCUhzn6ZgkaBdM+83hz9qTfNqn07QZyrpGtKvgFMN2y2/c
	VQOguivebH7wGwqguNB09vC4sM8bGKeRAh+xhiaDDQo/rcNBqBmMgTp4oCU1ZY2lk08ppF0AhHX
	A==
X-Received: by 2002:a05:7300:3081:b0:343:ff9f:26f3 with SMTP id 5a478bee46e88-343ff9f3572mr9344969eec.9.1790596704073;
        Mon, 28 Sep 2026 04:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a49febsm30311790eec.2.2026.09.28.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:58:23 -0700 (PDT)
Message-Id: <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 11:58:19 +0000
Subject: [PATCH v5 0/3] rerere: wait for MERGE_RR.lock, and go on at a conflict
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
    Thomas Bachem <mail@thomasbachem.com>

This is now three patches: the wait on its own, the gc's skip as "git rerere
gc --auto", and the conflict-time callers on top, as before.

Patch 1 makes every writer wait rerere.lockTimeout for MERGE_RR.lock before
it fails as it does today. That alone keeps a rebase alive through the gc
that a commit's auto maintenance starts, since pruning a few thousand
entries takes well under the one second default.

Patch 2 is the split Patrick asked for: a "git rerere gc" run by hand waits
and then fails as it does today, like every other rerere command, and only
"git rerere gc --auto" skips a held lock, quietly, as "git gc --auto" does
with its own lock. "git maintenance run --auto" and "git gc --auto" pass the
option, as they do for "git pack-refs --auto". A manual or scheduled
maintenance run does not and fails on a held lock like the command itself. I
left scheduled runs on that side since maintenance treats them like manual
runs for pack-refs and gc too.

Patch 3 is v4's second patch: a command that stops at a conflict warns and
goes on when the lock is still held after the wait, and the warning says to
run "git rerere" before resolving.

Changes since v4:

 * Based on today's master, which has ps/tune-rerere-gc, and merges cleanly
   into next. In seen it only conflicts with its own v4.

 * "git rerere gc" no longer skips a held lock on its own. Only "git rerere
   gc --auto" does, and silently, so a background run prints nothing
   (Patrick, Phillip).

 * The git-rerere(1) sentence with the merge and rebase examples is gone.
   The gc paragraph describes --auto instead (Patrick).

 * I kept the timeout an int, like core.filesRefLockTimeout and
   core.packedRefsTimeout, and dropped the long local (Patrick).

 * The hint to run "git rerere" goes through advise_if_enabled() under
   advice.mergeConflict (Patrick).

 * Tests: the old gc test became the "gc --auto" test of patch 2, "git
   rerere gc" joined the commands that fail on a held lock in patch 1, and
   t7900 checks that maintenance passes --auto and that a run without it
   fails on a held lock.

Thomas Bachem (3):
  rerere: wait for MERGE_RR.lock before giving up
  rerere: add "gc --auto" that skips a held lock
  rerere: go on at a conflict when the lock stays busy

 Documentation/config/rerere.adoc |  13 +++
 Documentation/git-rerere.adoc    |   9 +-
 apply.c                          |   2 +-
 builtin/am.c                     |   3 +-
 builtin/gc.c                     |   4 +-
 builtin/merge.c                  |   2 +-
 builtin/rerere.c                 |  13 ++-
 builtin/stash.c                  |   2 +-
 rerere.c                         |  56 ++++++++--
 rerere.h                         |   6 +-
 sequencer.c                      |   4 +-
 t/t4200-rerere.sh                | 175 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |  25 ++++-
 13 files changed, 292 insertions(+), 22 deletions(-)


base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v4:

 1:  8a7a74d6aa ! 1:  3dc3d02f12 rerere: wait for MERGE_RR.lock, and let the gc skip it
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    rerere: wait for MERGE_RR.lock, and let the gc skip it
     +    rerere: wait for MERGE_RR.lock before giving up
      
     -    setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR. When two
     -    processes want the lock at the same time, the second one dies. This
     -    was always the case, but since 452b12c2e0 (builtin/maintenance: use
     -    "geometric" strategy by default, 2026-02-24) it is easy to hit: auto
     -    maintenance now runs "git rerere gc" after every commit whenever
     -    rr-cache contains at least one entry, and the gc holds the lock
     -    while it prunes.
     +    setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR, so of two
     +    processes that want it at the same time the second one dies. That
     +    used to be rare. Since 452b12c2e0 (builtin/maintenance: use
     +    "geometric" strategy by default, 2026-02-24) the auto maintenance
     +    after a commit runs "git rerere gc" whenever rr-cache has enough
     +    stale entries, and the gc holds the lock while it prunes.
      
     -    A rebase whose next pick conflicts while the gc holds the lock dies
     -    inside repo_rerere(). That runs before the sequencer writes the state
     -    that "git rebase --continue" needs, so every later "git rebase
     -    --continue" fails with "you have staged changes".
     +    A rebase whose next pick conflicts while that happens dies inside
     +    repo_rerere(), before the sequencer has written the state that
     +    "git rebase --continue" needs. Every later "git rebase --continue"
     +    then fails with "you have staged changes in your working tree".
      
     -    Instead of dying right away, wait for the lock for up to
     -    rerere.lockTimeout milliseconds, 1000 by default, and only then fail
     -    as before. The gc itself does not wait: when the lock is held, it
     -    skips this run and leaves the pruning to the next one.
     +    Wait for the lock for up to rerere.lockTimeout milliseconds, 1000 by
     +    default, and only then fail as before. Pruning a few thousand entries
     +    takes well under a second, so the default covers a rebase that runs
     +    into the gc.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.enabled::
      +	`git rerere gc`.  Value 0 means not to wait at all; -1 means
      +	to wait indefinitely.  Default is 1000 (i.e., wait for 1
      +	second).  When the time is up, the command fails as it does
     -+	for any other lock it cannot take.  `git rerere gc` never
     -+	waits and skips its run while the lock is held.
     -
     - ## Documentation/git-rerere.adoc ##
     -@@ Documentation/git-rerere.adoc: occurred a long time ago.  By default, unresolved conflicts older
     - than 15 days and resolved conflicts older than 60
     - days are pruned.  These defaults are controlled via the
     - `gc.rerereUnresolved` and `gc.rerereResolved` configuration
     --variables respectively.
     -+variables respectively.  If another process holds the rerere lock,
     -+for example a merge or rebase that is recording a conflict, `gc`
     -+does nothing and says so.
     - 
     - 
     - DISCUSSION
     ++	for any other lock it cannot take.
      
       ## rerere.c ##
      @@ rerere.c: static int rerere_enabled = -1;
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
       	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
       		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
      -	if (flags & RERERE_READONLY)
     -+	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
     -+		BUG("RERERE_READONLY takes no lock, so RERERE_NOWAIT does not apply");
      +	if (flags & RERERE_READONLY) {
       		fd = 0;
      -	else
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
      -						    git_path_merge_rr(r),
      -						    LOCK_DIE_ON_ERROR);
      +	} else {
     -+		const char *path = git_path_merge_rr(r);
     -+		int lock_flags = LOCK_DIE_ON_ERROR;
     -+		long timeout_ms = rerere_lock_timeout_ms;
     -+
      +		/*
      +		 * Another process may hold the lock for a while, e.g.
      +		 * "git rerere gc" while it prunes rr-cache, so wait for
     -+		 * it instead of dying right away.  The gc itself never
     -+		 * waits: skipping one of its runs costs nothing.
     ++		 * it instead of dying right away.
      +		 */
     -+		if (flags & RERERE_NOWAIT) {
     -+			lock_flags = 0;
     -+			timeout_ms = 0;
     -+		}
      +		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
     -+							    path, lock_flags,
     -+							    timeout_ms);
     -+		if (fd < 0) {
     -+			warning_errno(_("skipping rerere, "
     -+					"unable to create '%s.lock'"), path);
     -+			return -1;
     -+		}
     ++							    git_path_merge_rr(r),
     ++							    LOCK_DIE_ON_ERROR,
     ++							    rerere_lock_timeout_ms);
      +	}
       	read_rr(r, merge_rr);
       	return fd;
       }
     -@@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
     - 	timestamp_t cutoff_resolve = now - 60 * 86400;
     - 	struct strbuf buf = STRBUF_INIT;
     - 
     --	if (setup_rerere(r, rr, 0) < 0)
     -+	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
     - 		return;
     - 
     - 	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
     -
     - ## rerere.h ##
     -@@ rerere.h: struct repository;
     - #define RERERE_AUTOUPDATE   01
     - #define RERERE_NOAUTOUPDATE 02
     - #define RERERE_READONLY     04
     -+/* Never wait for MERGE_RR.lock, and skip the run when it is held */
     -+#define RERERE_NOWAIT       010
     - 
     - /*
     -  * Marks paths that have been hand-resolved and added to the
      
       ## t/t4200-rerere.sh ##
      @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
       	test_path_is_missing $rr2/preimage
       '
       
     -+test_expect_success 'gc does nothing while MERGE_RR is locked' '
     -+	mkdir -p $rr2 &&
     -+	echo Hello >$rr2/preimage &&
     -+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
     -+
     -+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     -+	>.git/MERGE_RR.lock &&
     -+	git rerere gc 2>err &&
     -+	test_grep "MERGE_RR.lock" err &&
     -+	test_path_is_file $rr2/preimage &&
     -+
     -+	rm .git/MERGE_RR.lock &&
     -+	git rerere gc &&
     -+	test_path_is_missing $rr2/preimage
     -+'
     -+
      +test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
      +	git reset --hard &&
      +	rm -rf $rr &&
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_path_is_missing $rr/preimage
      +'
      +
     -+test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
     ++test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
      +	test_grep "Unable to create" err &&
      +	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
     ++	test_grep "Unable to create" err &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rerere gc 2>err &&
      +	test_grep "Unable to create" err
      +'
      +
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
       rerere_gc_custom_expiry_test () {
       	five_days="$1" right_now="$2"
       	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
     -
     - ## t/t7900-maintenance.sh ##
     -@@ t/t7900-maintenance.sh: test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
     - 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
     - '
     - 
     -+test_expect_success 'rerere-gc task succeeds while MERGE_RR is locked' '
     -+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
     -+	mkdir .git/rr-cache &&
     -+	: >.git/rr-cache/entry &&
     -+	>.git/MERGE_RR.lock &&
     -+	test_expect_rerere_gc git maintenance run --task=rerere-gc
     -+'
     -+
     - test_expect_success '--auto and --schedule incompatible' '
     - 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
     - 	test_grep "cannot be used together" err
 -:  ---------- > 2:  27673137aa rerere: add "gc --auto" that skips a held lock
 2:  1cce403113 ! 3:  3984c7666b rerere: go on at a conflict when the lock stays busy
     @@ Commit message
          When a merge, rebase, cherry-pick, revert, am, stash or apply stops
          at a conflict, it runs rerere right before it returns to the user.
          If MERGE_RR.lock is still held when rerere.lockTimeout runs out, the
     -    command dies there. For a rebase that is worse than a lost
     -    recording: the sequencer has not yet written the state that
     -    "git rebase --continue" needs, so the rebase cannot continue, and
     -    following the "git commit --amend" advice folds the conflicted pick
     -    into the previous commit.
     +    command dies there. A rebase loses more than a recording that way.
     +    The sequencer has not yet written the state that "git rebase
     +    --continue" needs, so the rebase cannot go on, and the "git commit
     +    --amend" it suggests instead folds the conflicted pick into the
     +    previous commit.
      
     -    So print a warning and go on instead. The conflict is still in
     -    place, and the warning tells the user to run "git rerere" before
     -    resolving it. That records the preimage, or replays a known
     -    resolution, just as the command would have done.
     +    So warn and go on. The conflict is still in place, and the warning
     +    tells the user to run "git rerere" before resolving it, which records
     +    the preimage or replays a known resolution as the command would have.
     +    The hint is under advice.mergeConflict like the other hints printed
     +    at a conflict stop.
      
     -    All other callers still fail when the timeout runs out. "git commit"
     -    and "git am --continue" record the resolution and then move on to
     -    the next commit or patch. A warning would come too late there, and
     -    the next rerere run would record whatever the file contains by then.
     -    The "rerere clear" that am and rebase run for --skip and --abort
     -    would leave the same stale entry behind. "git rerere", "git rerere
     -    forget" and "git rerere clear" fail because the user asked for that
     -    state explicitly.
     +    Callers that run rerere after a resolution, like "git commit" and
     +    "git am --continue", still fail when the wait is up. They move on
     +    right away, and a leftover MERGE_RR entry would make the next rerere
     +    run record whatever the file holds by then. The user's own rerere
     +    commands and the "rerere clear" of --skip and --abort fail as well.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.lockTimeout::
       	`git rerere gc`.  Value 0 means not to wait at all; -1 means
       	to wait indefinitely.  Default is 1000 (i.e., wait for 1
      -	second).  When the time is up, the command fails as it does
     --	for any other lock it cannot take.  `git rerere gc` never
     --	waits and skips its run while the lock is held.
     +-	for any other lock it cannot take.  `git rerere gc --auto`
     +-	does not wait and does nothing while the lock is held.
      +	second).  When the time is up, a command that stops at a
      +	conflict, such as `git merge` or `git rebase`, prints a
      +	warning and goes on without rerere; run `git rerere` before
      +	resolving the conflict to record it after all.  Any other
      +	command fails, as it does for any other lock it cannot take.
     -+	`git rerere gc` never waits and skips its run while the lock
     -+	is held.
     ++	`git rerere gc --auto` does not wait and does nothing while
     ++	the lock is held.
      
       ## apply.c ##
      @@ apply.c: static int write_out_results(struct apply_state *state, struct patch *list)
     @@ builtin/merge.c: static int suggest_conflicts(void)
       	return 1;
      
       ## builtin/stash.c ##
     -@@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
     +@@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefix,
       		ret = error(_("could not write index"));
       
       	if (ret) {
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
       	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
       		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
      -	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
     --		BUG("RERERE_READONLY takes no lock, so RERERE_NOWAIT does not apply");
     +-		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
      +	if ((flags & RERERE_READONLY) &&
      +	    (flags & (RERERE_NOWAIT | RERERE_SKIP_LOCKED)))
      +		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
       	if (flags & RERERE_READONLY) {
       		fd = 0;
       	} else {
     ++		const char *path = git_path_merge_rr(r);
     + 		int lock_flags = LOCK_DIE_ON_ERROR;
     + 		int timeout_ms = rerere_lock_timeout_ms;
     + 
      @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
     - 		 * Another process may hold the lock for a while, e.g.
       		 * "git rerere gc" while it prunes rr-cache, so wait for
     - 		 * it instead of dying right away.  The gc itself never
     --		 * waits: skipping one of its runs costs nothing.
     -+		 * waits: skipping one of its runs costs nothing.  A
     -+		 * command that stops at a conflict must not die here
     -+		 * either, so it warns and goes on without rerere.
     + 		 * it instead of dying right away.  The gc of an automatic
     + 		 * maintenance run does not wait, since skipping one of
     +-		 * its runs costs nothing.
     ++		 * its runs costs nothing.  A command that stops at a
     ++		 * conflict must not die here either, so it warns and
     ++		 * goes on without rerere.
       		 */
       		if (flags & RERERE_NOWAIT) {
       			lock_flags = 0;
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
      +		if (flags & RERERE_SKIP_LOCKED)
      +			lock_flags = 0;
       		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
     - 							    path, lock_flags,
     - 							    timeout_ms);
     - 		if (fd < 0) {
     - 			warning_errno(_("skipping rerere, "
     - 					"unable to create '%s.lock'"), path);
     -+			if (flags & RERERE_SKIP_LOCKED)
     -+				advise(_("run \"git rerere\" before resolving "
     -+					 "the conflict to record or replay "
     -+					 "its resolution"));
     +-							    git_path_merge_rr(r),
     +-							    lock_flags, timeout_ms);
     +-		if (fd < 0)
     ++							    path, lock_flags,
     ++							    timeout_ms);
     ++		if (fd < 0) {
     ++			if (flags & RERERE_SKIP_LOCKED) {
     ++				warning_errno(_("skipping rerere, "
     ++						"unable to create '%s.lock'"),
     ++					      path);
     ++				advise_if_enabled(ADVICE_MERGE_CONFLICT,
     ++						  _("run \"git rerere\" before "
     ++						    "resolving the conflict to "
     ++						    "record or replay its "
     ++						    "resolution"));
     ++			}
       			return -1;
     - 		}
     ++		}
       	}
     + 	read_rr(r, merge_rr);
     + 	return fd;
      
       ## rerere.h ##
      @@ rerere.h: struct repository;
       #define RERERE_READONLY     04
     - /* Never wait for MERGE_RR.lock, and skip the run when it is held */
     + /* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
       #define RERERE_NOWAIT       010
      +/* Warn and go on without rerere if MERGE_RR.lock cannot be taken in time */
      +#define RERERE_SKIP_LOCKED  020
     @@ t/t4200-rerere.sh: test_expect_success 'a held lock is waited out within rerere.
      +	test_grep "^=======\$" a1
      +'
      +
     - test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
     + test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
       	test_when_finished "rm -f .git/MERGE_RR.lock" &&
       	>.git/MERGE_RR.lock &&

-- 
gitgitgadget
