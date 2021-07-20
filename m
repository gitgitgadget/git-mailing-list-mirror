Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82E7C6377D
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAE6610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhGTJt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A41C0613B1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l6so12008107wmq.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqg9aOzebD3fX8btn3qd4Os3xoqIxicT7oIPVsiLSPw=;
        b=MQHwnYLlE6a1RhvvePJfbY7/YXic67Pj6gjDgsD41n4s3xt95C46PNrQHpioxqQ59r
         Pnqzse+kLYQBSwxX7WyQbzGinC8fkSNMGZiEJ7pKbHakYjKAhHQJ2WrqqVX+GOjdAx4R
         SB6TNEURLt5b4O1uUPEBaSuovmHuDFEsk+g32Y0bTZCmgdvU2XPVJ7rL1mQAdo9dHkLw
         OLNTAuWd7kwf+RCQzVJbig3rn9W2UKFfOdTe9CyA/Y7dS1X/iHblyyzROhGXWhkj4bnH
         JgCvEht6IG6P1ybI2QXe/ZNFgE4/AfcmHNLwRQ/4MO0qhgHnWvskfE2abXIxEqXknUaU
         puUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqg9aOzebD3fX8btn3qd4Os3xoqIxicT7oIPVsiLSPw=;
        b=BCQGsJXhj9vPlvpHE3Jf0kpPcrxGfQ7UVHVSzqZRyL066wDUE6Qdn2RA3PSMrhxyd0
         vA3yAduIx3/Eb3Z4ParkUzyiBAHGHe54NJ5n+N9wn9vr+iHBnIi8CsDXc+lflNG/zDHK
         YsrrvbGQDnLlTTmB89YgSKDrEfB09PFBQ3uh2yiEGVQMDomRt6aotzz9m2xUWVoZ2h0O
         +73HR3cynwmfjk7WF/HYqu5kXEEvmxkaM8yuce4DMGqaRjXlKjYPSvY+uTdAFFXwHAI7
         kPsJdHQtQ4+0EtIvOEljmkBYaVL3pIkLa8HU/YJz6Yue+GsV9Qmz3pd0sPOzsoNtpz6J
         6yTg==
X-Gm-Message-State: AOAM531mHKkkXvcxvD81xR00/1Ym8pPtZ1uyVVJn3i3Tw0dI7ImKmjcM
        aIUBEWX2eZw3j1Uc27gXjVJQuCvs7vHPZA==
X-Google-Smtp-Source: ABdhPJyk2i3dY/5KnKQPO3VG/RwWzrxwp6R+CL4Q3YbcjWzH/Ct6RvApq4P0AirnsvwloKFrLEGqEA==
X-Received: by 2002:a05:600c:3593:: with SMTP id p19mr30136119wmq.33.1626776662553;
        Tue, 20 Jul 2021 03:24:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/12] fix "git reflog expire" race & get rid of EISDIR in refs API
Date:   Tue, 20 Jul 2021 12:24:05 +0200
Message-Id: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of
https://lore.kernel.org/git/cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com/;
hopefully addressing all the comments by Peff & Junio, thanks
both!

Changes:

 * Lots of commit message/comment changes, see range-diff

 * I referred to an assert() I forgot to add, the series now juggles
   an assert() of thei oid back and forth, for clarity of what we're
   actually doing.

   As noted in v2 I've got a series prepped for this one to finally
   clean up those loose ends/dead code, but let's focus on the
   behavior changes for now.

 * There's now a 12th patch to remove the "ENOTDIR" case Peff noted,

Ævar Arnfjörð Bjarmason (12):
  refs/packet: add missing BUG() invocations to reflog callbacks
  refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
  refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
  refs/files: remove unused "skip" in lock_raw_ref() too
  refs/debug: re-indent argument list for "prepare"
  refs API: pass the "lock OID" to reflog "prepare"
  refs: make repo_dwim_log() accept a NULL oid
  refs/files: add a comment about refs_reflog_exists() call
  reflog expire: don't lock reflogs using previously seen OID
  refs/files: remove unused "oid" in lock_ref_oid_basic()
  refs/files: remove unused "errno == EISDIR" code
  refs/files: remove unused "errno != ENOTDIR" condition

 builtin/reflog.c      |  17 +++---
 reflog-walk.c         |   3 +-
 refs.c                |   5 +-
 refs.h                |   4 +-
 refs/debug.c          |  10 ++--
 refs/files-backend.c  | 128 +++++++++++-------------------------------
 refs/packed-backend.c |   5 ++
 7 files changed, 58 insertions(+), 114 deletions(-)

Range-diff against v2:
 1:  30bd7679a5c =  1:  737d2d8c3d1 refs/packet: add missing BUG() invocations to reflog callbacks
 2:  033c0cec33d !  2:  dfb9e34076e refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
    @@ Metadata
      ## Commit message ##
         refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
     
    -    The lock_ref_oid_basic() function has gradually been replaced by use
    -    of the file transaction API, there are only 4 remaining callers of
    -    it.
    -
    -    None of those callers pass REF_DELETING, the last such caller went
    -    away in 8df4e511387 (struct ref_update: move "have_old" into "flags",
    -    2015-02-17). This is the start of even more removal of unused code in
    -    and around this function.
    +    The lock_ref_oid_basic() function has gradually been by most callers
    +    no longer performing a low-level "acquire lock, update and release",
    +    and instead using the ref transaction API. So there are only 4
    +    remaining callers of lock_ref_oid_basic().
    +
    +    None of those callers pass REF_DELETING anymore, the last caller went
    +    away in 92b1551b1d (refs: resolve symbolic refs first,
    +    2016-04-25).
    +
    +    Before that we'd refactored and moved this code in:
    +
    +     - 8df4e511387 (struct ref_update: move "have_old" into "flags",
    +       2015-02-17)
    +
    +     - 7bd9bcf372d (refs: split filesystem-based refs code into a new
    +       file, 2015-11-09)
    +
    +     - 165056b2fc (lock_ref_for_update(): new function, 2016-04-24)
    +
    +    We then finally stopped using it in 92b1551b1d (noted above). So let's
    +    remove the handling of this parameter.
    +
    +    By itself this change doesn't benefit us much, but it's the start of
    +    even more removal of unused code in and around this function in
    +    subsequent commits.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 3:  94ffcd8cfda =  3:  0f2262fec69 refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 4:  61f9e0fc864 =  4:  7fb7ff97491 refs/files: remove unused "skip" in lock_raw_ref() too
 5:  95101c322b7 =  5:  4e526c34aaa refs/debug: re-indent argument list for "prepare"
 6:  e93465f4137 !  6:  295594fe8ae refs API: pass the "lock OID" to reflog "prepare"
    @@ Commit message
         refs API: pass the "lock OID" to reflog "prepare"
     
         Don't pass the object ID we pass into reflog_expire() back to the
    -    caller, but rather our locked OID.
    +    caller, but rather our locked OID. As the assert shows these two were
    +    the same thing in practice as we'd exit earlier in this function if we
    +    couldn't lock the desired OID.
     
    -    As the assert shows these two were the same thing in practice as we'd
    -    exit earlier in this function if we couldn't lock the desired OID, but
    -    as part of removing the passing of the OID to other functions further
    -    on I'm splitting up these concerns.
    +    This is in preparation for a subsequent change of not having
    +    reflog_expire() pass in the OID at all, also remove the "const" from
    +    the parameter since the "struct ref_lock" does not have it on its
    +    "old_oid" member.
     
         As we'll see in a subsequent commit we don't actually want to assert
         that we locked a given OID, we want this API to do the locking and
    -    tell us what the OID is, but for now let's just setup the scaffolding
    -    for that.
    +    tell us what the OID is, but for now let's just setup the basic
    +    scaffolding for that.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      	}
      
     -	(*prepare_fn)(refname, oid, cb.policy_cb);
    ++	assert(oideq(&lock->old_oid, oid));
     +	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
      	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
      	(*cleanup_fn)(cb.policy_cb);
 7:  0fff2d32cfc =  7:  e45ec439db0 refs: make repo_dwim_log() accept a NULL oid
 8:  1e25b7c59c5 !  8:  8ae8e5ac029 refs/files: add a comment about refs_reflog_exists() call
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      	}
     +
     +	/*
    -+	 * When refs are deleted their reflog is deleted before the
    -+	 * ref itself deleted. This race happens because there's no
    -+	 * such thing as a lock on the reflog, instead we always lock
    -+	 * the "loose ref" (even if packet) above with
    ++	 * When refs are deleted, their reflog is deleted before the
    ++	 * ref itself is deleted. This is because there is no separate
    ++	 * lock for reflog; instead we take a lock on the ref with
     +	 * lock_ref_oid_basic().
     +	 *
    -+	 * If race happens we've got nothing more to do, we were asked
    -+	 * to delete the reflog, and it's not there anymore. Great!
    ++	 * If a race happens and the reflog doesn't exist after we've
    ++	 * acquired the lock that's OK. We've got nothing more to do;
    ++	 * We were asked to delete the reflog, but someone else
    ++	 * deleted it! The caller doesn't care that we deleted it,
    ++	 * just that it is deleted. So we can return successfully.
     +	 */
      	if (!refs_reflog_exists(ref_store, refname)) {
      		unlock_ref(lock);
 9:  60d6cf342fc !  9:  1050743e27c reflog expire: don't lock reflogs using previously seen OID
    @@ Commit message
     
          1. Lookup the reflog name/OID via dwim_log()
          2. With that OID, lock the reflog
    -     3. Later in builtin/reflog.c we use the we looked as input to
    +     3. Later in builtin/reflog.c we use the OID we looked as input to
             lookup_commit_reference_gently(), assured that it's equal to the
             OID we got from dwim_log().
     
    -    What do I mean with "mostly" above? It mostly mitigates it because
    -    we'll still run into cases where the ref is locked and being updated
    -    as we want to expire it, and other git processes wanting to update the
    -    refs will in turn race with us as we expire the reflog.
    +    We can be sure that this change is safe to make because between
    +    dwim_log (step #1) and lock_ref_oid_basic (step #2) there was no other
    +    logic relevant to the OID or expiry run in the cmd_reflog_expire()
    +    caller.
     
    -    This remaining race can in turn be mitigated with the
    +    We can thus treat that code as a black box, before and after this
    +    change it would get an OID that's been locked, the only difference is
    +    that now we mostly won't be failing to get the lock due to the TOCTOU
    +    race[0]. That failure was purely an implementation detail in how the
    +    "current OID" was looked up, it was divorced from the locking
    +    mechanism.
    +
    +    What do we mean with "mostly"? It mostly mitigates it because we'll
    +    still run into cases where the ref is locked and being updated as we
    +    want to expire it, and other git processes wanting to update the refs
    +    will in turn race with us as we expire the reflog.
    +
    +    That remaining race can in turn be mitigated with the
         core.filesRefLockTimeout setting, see 4ff0f01cb7 ("refs: retry
         acquiring reference locks for 100ms", 2017-08-21). In practice if that
         value is high enough we'll probably never have ref updates or reflog
    @@ Commit message
     
         See [1] for an initial report of how this impacted "git gc" and a
         large discussion about this change in early 2019. In particular patch
    -    looked good to Michael Haggerty his[2], but that seems to not have
    -    made it to the ML archive, its content is quoted in full in my [3].
    +    looked good to Michael Haggerty, see his[2]. That message seems to not
    +    have made it to the ML archive, its content is quoted in full in my
    +    [3].
     
         I'm leaving behind now-unused code the refs API etc. that takes the
         now-NULL "oid" argument, and other code that can be simplified now
         that we never have on OID in that context, that'll be cleaned up in
         subsequent commits, but for now let's narrowly focus on fixing the
    -    "git gc" issue
    +    "git gc" issue. As the modified assert() shows we always pass a NULL
    +    oid to reflog_expire() now.
     
         Unfortunately this sort of probabilistic contention is hard to turn
         into a test. I've tested this by running the following three subshells
    @@ Commit message
             )
     
         Before this change the "reflog expire" would fail really quickly with
    -    a "but expected" error.
    +    the "but expected" error noted above.
     
         After this change both the "pull" and "reflog expire" will run for a
         while, but eventually fail because I get unlucky with
    @@ Commit message
         With core.filesRefLockTimeout set to 10 seconds (it can probably be a
         lot lower) I managed to run all four of these concurrently for about
         an hour, and accumulated ~125k commits, auto-gc's and all, and didn't
    -    have a single failure.
    +    have a single failure. The loops visibly stall while waiting for the
    +    lock, but that's expected and desired behavior.
     
    +    0. https://en.wikipedia.org/wiki/Time-of-check_to_time-of-use
         1. https://lore.kernel.org/git/87tvg7brlm.fsf@evledraar.gmail.com/
         2. http://lore.kernel.org/git/b870a17d-2103-41b8-3cbc-7389d5fff33a@alum.mit.edu
         3. https://lore.kernel.org/git/87pnqkco8v.fsf@evledraar.gmail.com/
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      				  REF_NO_DEREF,
      				  &type, &err);
      	if (!lock) {
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 		}
    + 	}
    + 
    +-	assert(oideq(&lock->old_oid, oid));
    ++	assert(!oid);
    + 	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
    + 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
    + 	(*cleanup_fn)(cb.policy_cb);
10:  09dd8836437 ! 10:  753c20f89bf refs/files: remove unused "oid" in lock_ref_oid_basic()
    @@ Commit message
         In the preceding commit the last caller that passed a non-NULL OID was
         changed to pass NULL to lock_ref_oid_basic(). As noted in preceding
         commits use of this API has been going away (we should use ref
    -    transactions, or lock_raw_rew()), so we're unlikely to gain new
    +    transactions, or lock_raw_ref()), so we're unlikely to gain new
         callers that want to pass the "oid".
     
         So let's remove it, doing so means we can remove the "mustexist"
         condition, and therefore anything except the "flags =
    -    RESOLVE_REF_NO_RECURSE" case. Furthermore, since the verify_lock()
    -    function we called did most of its work when the "oid" was passed (as
    -    "old_oid") we can inline the trivial part of it that remains in what's
    -    now its only caller.
    +    RESOLVE_REF_NO_RECURSE" case.
    +
    +    Furthermore, since the verify_lock() function we called did most of
    +    its work when the "oid" was passed (as "old_oid") we can inline the
    +    trivial part of it that remains in its only remaining caller. Without
    +    a NULL "oid" passed it was equivalent to calling refs_read_ref_full()
    +    followed by oidclr().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
11:  96c3e5e9f79 = 11:  8a71bbef972 refs/files: remove unused "errno == EISDIR" code
 -:  ----------- > 12:  452253d597d refs/files: remove unused "errno != ENOTDIR" condition
-- 
2.32.0.874.ge7a9d58bfcf

