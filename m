Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96444ED1B4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893278; cv=none; b=PgGnxM2hO1M3odmtH8At1KKg7WiNTdpnTwAC9tt94S4WoIR7yKqq7PC01L0oT3iNgAlT9vJwMOJBCXHbfg+3cSxKlgNzTONXVzyfx15LBVmztJKMhbEMRIfih6acLODUGsAD5ZG/e3Bp/RkBha27PTnSUNGXRVNoOvd1mMIJ4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893278; c=relaxed/simple;
	bh=Qp0TuhLgw73CcTw+y8uuOdB/VefnZYB+VGGYgs1Eh5s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HtAa23iLBxzcefOlN9qbSuTVqwvnPy0YK1OChbNlyvxfn/TNayvYcgMhPL33Jbi3OA6BFZ/S3TvXB2j5Qhx/7ynRJ7B/b+YkGYzZc0RAlmdbjTIO+YCd2g4E0AZDbMwIRAtcXhn9PSJPR+djSeUs23tPQLP2y1opm0k2bdGpyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHj8Uq6O; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHj8Uq6O"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-873a4edb243so1713880b3a.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791893276; x=1792498076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C2DvJgY/qpqrhGuRgHyunLH2z3h70aNjx2c8BJeh7ZY=;
        b=HHj8Uq6OAOyvuf2lnSnkWlDtrHoze2/KIVCa8++0iAN/qpEF7SWzrzha365EVJT8+l
         ZquFuUL9bR7487An0tI0gTKBX1x3qEwwbgwwioxkEEvAlZBNHuu/TWTbuwZV7QZ8QXAu
         plDFbuuiHIkv6l3pdYL2P9Blyk6KM4jbDDI1XEs424UyENiMAp3bkYrttIsyoHXeZfV4
         1MtjXhFz3s1iIqP7dNEGueQWNb3NYwWXOCgv7pjdM5MyIRjiX2Rk+dUaCIBGvcCHmsEu
         OhgPADBOloX2fdPsxmfjgo/5fusXRtHeD7FX9e/H6O++ZcuFmzBwRMxO5Fj8FbcwWN/+
         KgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893276; x=1792498076;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2DvJgY/qpqrhGuRgHyunLH2z3h70aNjx2c8BJeh7ZY=;
        b=UZlRztwALYV7Zw7p/tvdnPKiqQgDxCwUQC+OrVoo+Ocel45YAX73KgtIOztPNroM4a
         pbOzQXVGXKDfYblnhVkZavX72L2zyu4fBGXWdoxRmeUjNjM0Sbxdr7FV9Y6d4zbaNgQe
         3nT7YUCLvRX3kU4ond2aJSYcqjGIrcU5bXvMaVXQugK+xdNdI9JoTuDaskgj33HjGKhb
         zUqFn7wOeOghNa8gEPo0857WIRcXePUDTXAE9COUk86riApBuMXVk6tKRa2E//hD82XH
         857UIikRDSVT9u0/gRXf91hfz8Yi+7tUDqXB1A+N2X0VJVyjHZVf/Ie7fw23MOubBwIQ
         L4rA==
X-Gm-Message-State: AFq9FYLKIzgDSXypWLqjpsaLjdkjP10b9G+qb5taJm2XAiW37ohLTYph
	20GG0Be/ic7P0FmooJ0Dg2q0aG30vRetkz2Eb1UjhTdpYFt50tiQ7CqylEdGEQ==
X-Gm-Gg: AYBFou18HHqlJ5g4K/gjCK/VVIFwAsKKwQShGtbufDPr/yCKZkpp1aytEfe0IwbMMXw
	/LBC5hu5zZnoTBU/ioR0b9xspMgWCiE2e+3oF9rPmOzfzizzXBxeI5extdgm9ECl3ahnRtvRUI1
	nhCsMDRs74R1rxG6JZ0Asr+/c5i833AatbIwtvAugdytiRPmkQDxN/mUqWBGl2kji5EQiMu+has
	Hk98SVg5d8lXSxXV0LICjkzo9pKTZ+2KUGtO6WkZeOE9Ub75dGA46eUyo+HqzrOMJRA3G9bKhRO
	K/XqwRNLBElHlC9tTF6VTp0W2ng2/J9o76mEokWKcyO4b6w+5mIzotwGJEdQl66XP0OWcEePoDE
	zDlUd6fns/cwH0idWKBmUAYJvyMvRkCZ3PWNU9tryPDRQOIE2yNf/Grmw+P59qG/ibFEhOhe5rD
	NnSyGKM/LNeEo4Nl5LuazrUBx2ybjY/hGh728ASkuRM0H7Iv1YBd4xktjP8vdyJoORg092JhnLu
	B8=
X-Received: by 2002:a05:6a00:13a6:b0:886:7d7d:cfb4 with SMTP id d2e1a72fcca58-897c86a4052mr11009164b3a.59.1791893275803;
        Tue, 13 Oct 2026 05:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3107398sm4998262b3a.17.2026.10.13.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:07:55 -0700 (PDT)
Message-Id: <pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 12:07:51 +0000
Subject: [PATCH v8 0/2] rerere: wait for MERGE_RR.lock, but not in auto maintenance
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

A rebase dies at a conflict when a background "git rerere gc" holds
MERGE_RR.lock at that moment. With the first patch, rerere waits for the
lock instead of dying at once. With the second, the "git rerere gc" started
by auto maintenance does nothing while the lock is held.

For v8 I took Junio's suggestions on patch 1 and Patrick's on patch 2.
Changes since v7:

 * The rerere.lockTimeout entry no longer says that the command fails when
   the time is up (Junio).

 * The lock tests grep for the "Unable to create" message about
   MERGE_RR.lock (Junio).

 * The wait for the background unlocker is now in test_when_finished
   (Junio).

 * The rebase --abort test aborts its rebase in test_when_finished, so a
   failed check cannot break later tests.

 * The test "merge fails once rerere.lockTimeout is up" never waits, so it
   is now called "merge fails on a lock it cannot take".

 * In patch 2, rerere_gc() takes RERERE_NOWAIT again instead of its own enum
   rerere_gc_flags (Patrick).

 * The comment about waiting in setup_rerere() now says "by default", and as
   in patch 1 it sits directly above the call that takes the lock.

 * A comment in t7900 says why the tests with a held lock create rr-cache.

Thomas Bachem (2):
  rerere: wait for MERGE_RR.lock before giving up
  rerere: add "gc --skip-locked" for auto maintenance

 Documentation/config/rerere.adoc |  9 ++++
 builtin/gc.c                     |  4 +-
 builtin/rerere.c                 | 10 +++-
 rerere.c                         | 37 ++++++++++++---
 rerere.h                         |  4 +-
 t/t4200-rerere.sh                | 79 ++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           | 26 ++++++++++-
 7 files changed, 157 insertions(+), 12 deletions(-)


base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v7:

 1:  3dc3d02f12 ! 1:  06f6c77439 rerere: wait for MERGE_RR.lock before giving up
     @@ Metadata
       ## Commit message ##
          rerere: wait for MERGE_RR.lock before giving up
      
     -    setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR, so of two
     -    processes that want it at the same time the second one dies. That
     +    setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR, so when two
     +    processes want it at the same time, the second one dies. That
          used to be rare. Since 452b12c2e0 (builtin/maintenance: use
          "geometric" strategy by default, 2026-02-24) the auto maintenance
          after a commit runs "git rerere gc" whenever rr-cache has enough
          stale entries, and the gc holds the lock while it prunes.
      
     -    A rebase whose next pick conflicts while that happens dies inside
     -    repo_rerere(), before the sequencer has written the state that
     +    If a rebase's next pick conflicts while the gc holds the lock, the
     +    rebase dies inside repo_rerere(), before the sequencer has written what
          "git rebase --continue" needs. Every later "git rebase --continue"
          then fails with "you have staged changes in your working tree".
      
     @@ Documentation/config/rerere.adoc: rerere.enabled::
      +	lock when another process holds it, typically a background
      +	`git rerere gc`.  Value 0 means not to wait at all; -1 means
      +	to wait indefinitely.  Default is 1000 (i.e., wait for 1
     -+	second).  When the time is up, the command fails as it does
     -+	for any other lock it cannot take.
     ++	second).
      
       ## rerere.c ##
      @@ rerere.c: static int rerere_enabled = -1;
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
      +	git reset --hard &&
      +	rm -rf $rr &&
     -+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     ++	test_when_finished "wait && rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	{
      +		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
      +	} &&
      +	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
     -+	wait &&
     -+	test_grep ! "MERGE_RR" err &&
     ++	test_grep ! "Unable to create.*MERGE_RR\.lock" err &&
      +	test_grep "^=======\$" $rr/preimage
      +'
      +
     -+test_expect_success 'merge fails once rerere.lockTimeout is up' '
     ++test_expect_success 'merge fails on a lock it cannot take' '
      +	git reset --hard &&
      +	rm -rf $rr &&
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
     -+	test_grep "Unable to create" err &&
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err &&
      +	test_grep "^=======\$" a1 &&
      +	test_path_is_missing $rr/preimage
      +'
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
     -+	test_grep "Unable to create" err &&
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err &&
      +	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
     -+	test_grep "Unable to create" err &&
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err &&
      +	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
     -+	test_grep "Unable to create" err &&
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err &&
      +	test_must_fail git -c rerere.lockTimeout=0 rerere gc 2>err &&
     -+	test_grep "Unable to create" err
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err
      +'
      +
      +test_expect_success 'rebase --abort fails on a lock it cannot take' '
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	git checkout -b lock-held-abort third &&
      +	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
      +	test_must_fail git rebase first &&
     ++	test_when_finished "test_might_fail git rebase --abort" &&
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 rebase --abort 2>err &&
     -+	test_grep "Unable to create" err &&
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err &&
      +	test_path_is_dir .git/rebase-merge &&
      +	rm .git/MERGE_RR.lock &&
      +	git rebase --abort &&
 2:  0002881196 ! 2:  4202361858 rerere: add "gc --skip-locked" for auto maintenance
     @@ Commit message
      
       ## Documentation/config/rerere.adoc ##
      @@ Documentation/config/rerere.adoc: rerere.lockTimeout::
     + 	lock when another process holds it, typically a background
       	`git rerere gc`.  Value 0 means not to wait at all; -1 means
       	to wait indefinitely.  Default is 1000 (i.e., wait for 1
     - 	second).  When the time is up, the command fails as it does
     --	for any other lock it cannot take.
     -+	for any other lock it cannot take.  A `git rerere gc` run by
     -+	`git maintenance run --auto` or `git gc --auto` does not wait
     -+	and does nothing while the lock is held.
     +-	second).
     ++	second).  A `git rerere gc` run by `git maintenance run --auto`
     ++	or `git gc --auto` does not wait and does nothing while the
     ++	lock is held.
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: out:
     @@ builtin/rerere.c: int cmd_rerere(int argc,
       	} else if (!strcmp(argv[0], "gc"))
      -		rerere_gc(the_repository, &merge_rr);
      +		rerere_gc(the_repository, &merge_rr,
     -+			  skip_locked ? RERERE_GC_NOWAIT : 0);
     ++			  skip_locked ? RERERE_NOWAIT : 0);
       	else if (!strcmp(argv[0], "status")) {
       		if (setup_rerere(the_repository, &merge_rr,
       				 flags | RERERE_READONLY) < 0)
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
      +		int lock_flags = LOCK_DIE_ON_ERROR;
      +		int timeout_ms = rerere_lock_timeout_ms;
      +
     - 		/*
     - 		 * Another process may hold the lock for a while, e.g.
     - 		 * "git rerere gc" while it prunes rr-cache, so wait for
     - 		 * it instead of dying right away.
     - 		 */
      +		if (flags & RERERE_NOWAIT) {
      +			lock_flags = 0;
      +			timeout_ms = 0;
      +		}
     ++
     + 		/*
     + 		 * Another process may hold the lock for a while, e.g.
     +-		 * "git rerere gc" while it prunes rr-cache, so wait for
     +-		 * it instead of dying right away.
     ++		 * "git rerere gc" while it prunes rr-cache, so by default
     ++		 * wait for it instead of dying right away.
     + 		 */
       		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
       							    git_path_merge_rr(r),
      -							    LOCK_DIE_ON_ERROR,
     @@ rerere.c: out:
       }
       
      -void rerere_gc(struct repository *r, struct string_list *rr)
     -+void rerere_gc(struct repository *r, struct string_list *rr,
     -+	       enum rerere_gc_flags flags)
     ++void rerere_gc(struct repository *r, struct string_list *rr, int flags)
       {
       	struct string_list to_remove = STRING_LIST_INIT_DUP;
       	DIR *dir;
     @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
       	struct strbuf buf = STRBUF_INIT;
       
      -	if (setup_rerere(r, rr, 0) < 0)
     -+	if (setup_rerere(r, rr,
     -+			 (flags & RERERE_GC_NOWAIT) ? RERERE_NOWAIT : 0) < 0)
     ++	if (setup_rerere(r, rr, flags) < 0)
       		return;
       
       	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
     @@ rerere.h: const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
       int rerere_remaining(struct repository *, struct string_list *);
       void rerere_clear(struct repository *, struct string_list *);
      -void rerere_gc(struct repository *, struct string_list *);
     -+
     -+enum rerere_gc_flags {
     -+	/* Skip the operation in case the MERGE_RR.lock is already taken. */
     -+	RERERE_GC_NOWAIT = (1 << 0),
     -+};
     -+
     -+void rerere_gc(struct repository *, struct string_list *,
     -+	       enum rerere_gc_flags flags);
     ++void rerere_gc(struct repository *, struct string_list *, int);
       
       /*
        * Check whether garbage collection for rerere entries is needed, which is
     @@ t/t7900-maintenance.sh: test_expect_success 'rerere-gc task with --auto honors m
       
      +test_expect_success 'rerere-gc task with --auto succeeds while MERGE_RR is locked' '
      +	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
     ++	# Without "rr-cache", rerere is disabled and never takes the lock.
      +	mkdir .git/rr-cache &&
      +	>.git/MERGE_RR.lock &&
      +	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc
     @@ t/t7900-maintenance.sh: test_expect_success 'rerere-gc task with --auto honors m
      +	mkdir .git/rr-cache &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 maintenance run --task=rerere-gc 2>err &&
     -+	test_grep "Unable to create" err
     ++	test_grep "Unable to create.*MERGE_RR\.lock" err
      +'
      +
       test_expect_success '--auto and --schedule incompatible' '

-- 
gitgitgadget
