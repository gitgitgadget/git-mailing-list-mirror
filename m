Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F67220248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfCOQAL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCOQAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so10142934wrm.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H91ZOSVSvZqAh8VLqwiiYFPDAP0jx6VJ8J1GnAi/TEo=;
        b=cyfaDDT5smizQEE4LDwGlD0LbBkiKME6MQwjbhq95RF0HA/4BVl25RdQz9pRPY0uuM
         xq630qVtwmpKFFLoE3aEDgUlkyNZrwGOjbp+RhT5fVqZSaXS5NcJudBSegcOzwUsF46c
         Zp7TjapRO40aU9RpiUite963t9F7ZOCAS3YG5L7Dv9QrDsLQOsBRLsK7YAjhqC1dH5gk
         HiYuEBgfjsS+/gXWl/FZWONitFuz4uGoWt79rueqYAdUNRFEhDsh7Q2Bf9QYT4YtUXu6
         pttL554M38QyugpXH8fEiBRvoKhapWfkFYI74NHMyn5EyKia7CUKl77TYMokyvq8oETY
         /MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H91ZOSVSvZqAh8VLqwiiYFPDAP0jx6VJ8J1GnAi/TEo=;
        b=lhDDMuTQOdFxTYf7m8ZXO61wPz+XrfTIbZEik0H+7LSf+Zp8g980RGepnIab6Udy/X
         AAKo42DGnUxaGd6KH7NaJz7IaYuSwUH3BO2BSqff3Ttj3Ii9qjoZOT8k6nogkzLULgOS
         6G5DVIoiZbdG5RA7QvVOYHDcpqKs3LRkpVwnlWVQsYk5bGMbLQHb8v93E3NgoaF/tLlY
         6+6qOg5q2Vum494xEHgNK8ODBqVqHnTSqozeDiIi2ru1OrmmMOOlqmQ85kjiTWTJKyPq
         Jg9N0MUju0i8WcLTn4JO6Z1L0X+25xjx9V+zJ+zYuX+CFHF5zRp35LTw2FBkyngDXpsz
         fJ5g==
X-Gm-Message-State: APjAAAUFvw0W34PhW1CItF1Bk4+gU7AHApRCIqDXcFo1BU5TU/Q75VXG
        uJDdEziabqsQKOleEyGLfj4kpCMgXlQ=
X-Google-Smtp-Source: APXvYqxdgSKe9WiUvtyLDF9ocfU98zVinKzNKV3py99K+rv0pmXsHqrjhr9cCCwIUtTbEpMNcj4jMw==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr1645000wrx.32.1552665608841;
        Fri, 15 Mar 2019 09:00:08 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/8] gc: minor code cleanup + contention fixes
Date:   Fri, 15 Mar 2019 16:59:51 +0100
Message-Id: <20190315155959.12390-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * The "let's detect that we don't need work in reflog expire" patch
   is gone, as noted in a new set of tests/commit messages that was
   tricker than expected, and not worth it.

 * Minor rewording fixes to commit messages.

 * Further paraphrased rationale in commit messages from replies to v2
   feedback (thanks all!)

 * The "no OID" and "no mustexist" case was confusingly conflated, now
   we still do that in 8/8, but with a commit message & commit
   explaining why and how that works.

Ævar Arnfjörð Bjarmason (8):
  gc: remove redundant check for gc_auto_threshold
  gc: convert to using the_hash_algo
  gc: refactor a "call me once" pattern
  reflog tests: make use of "test_config" idiom
  reflog tests: test for the "points nowhere" warning
  reflog tests: assert lack of early exit with expiry="never"
  gc: handle & check gc.reflogExpire config
  reflog expire: don't assert the OID when locking refs

 builtin/gc.c         | 37 +++++++++++++++++++++++++++++--------
 refs/files-backend.c | 15 ++++++++++++++-
 t/t1410-reflog.sh    | 25 +++++++++++++++++--------
 t/t6500-gc.sh        | 19 +++++++++++++++++++
 4 files changed, 79 insertions(+), 17 deletions(-)

Range-diff:
1:  f11699d8e77 = 1:  81694c82130 gc: remove redundant check for gc_auto_threshold
2:  e18433f9c6b ! 2:  4bdcf1d0be2 gc: convert to using the_hash_algo
    @@ -17,20 +17,33 @@
         but objects for that hash will share a directory storage with the
         other hash.
     
    -    Thus we could theoretically have 1k SHA-1 loose objects, and say 1
    -    million SHA-256 objects, and not notice because we're currently using
    -    SHA-1.
    +    Thus we could theoretically have e.g. 1k SHA-1 loose objects, and 1
    +    million SHA-256 objects. Then not notice that we need to pack them
    +    because we're currently using SHA-1, even though our FS may be
    +    straining under the stress of such humongous directories.
     
         So assuming that "gc" eventually learns to pack up both SHA-1 and
    -    SHA-256 objects regardless of what the current the_hash_alg is perhaps
    -    this check should be changed to consider all files in objects/17/
    -    matching [0-9a-f] 38 or 62 characters in length (i.e. both SHA-1 and
    -    SHA-256).
    +    SHA-256 objects regardless of what the current the_hash_algo is,
    +    perhaps this check should be changed to consider all files in
    +    objects/17/ matching [0-9a-f] 38 or 62 characters in length (i.e. both
    +    SHA-1 and SHA-256).
     
         But none of that is something we need to worry about now, and
         supporting both 38 and 62 characters depending on "the_hash_algo"
         removes another case of SHA-1 hardcoding.
     
    +    As noted in [1] I'm making no effort to somehow remove the hardcoding
    +    for "2" as in "use the first two hexdigits for the directory
    +    name". There's no indication that that'll ever change, and somehow
    +    generalizing it here would be a drop in the ocean, so there's no point
    +    in doing that. It also couldn't be done without coming up with some
    +    generalized version of the magical "objects/17" directory. See [2] for
    +    a discussion of that directory.
    +
    +    1. https://public-inbox.org/git/874l84ber7.fsf@evledraar.gmail.com/
    +
    +    2. https://public-inbox.org/git/87k1mta9x5.fsf@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/builtin/gc.c b/builtin/gc.c
3:  54e4bce91c3 = 3:  9444a1233af gc: refactor a "call me once" pattern
4:  82f87db1348 = 4:  60a06ae6185 reflog tests: make use of "test_config" idiom
-:  ----------- > 5:  52838fdc449 reflog tests: test for the "points nowhere" warning
5:  c79608dbbb3 ! 6:  6063429f108 reflog: exit early if there's no work to do
    @@ -1,32 +1,25 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    reflog: exit early if there's no work to do
    +    reflog tests: assert lack of early exit with expiry="never"
     
         When gc.reflogExpire and gc.reflogExpireUnreachable are set to "never"
         and --stale-fix isn't in effect (covered by the first part of the "if"
    -    statement being modified here) we can exit early without pointlessly
    -    looping over all the reflogs.
    +    statement being modified here) we *could* exit early without
    +    pointlessly looping over all the reflogs.
     
    -    Signed-off-by: Jeff King <peff@peff.net>
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    However, as an earlier change to add a test for the "points nowhere"
    +    warning shows even in such a mode we might want to print out a
    +    warning.
     
    - diff --git a/builtin/reflog.c b/builtin/reflog.c
    - --- a/builtin/reflog.c
    - +++ b/builtin/reflog.c
    -@@
    - 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
    - 		if (flags & EXPIRE_REFLOGS_VERBOSE)
    - 			putchar('\n');
    -+	} else if (!cb.cmd.expire_total && !cb.cmd.expire_unreachable) {
    -+		/*
    -+		 * If we're not expiring anything and not dropping
    -+		 * stale entries, there's no point in even opening the
    -+		 * reflogs, since we're guaranteed to do nothing.
    -+		 */
    -+		return 0;
    - 	}
    - 
    - 	if (do_all) {
    +    So while it's conceivable to implement this, I don't think it's worth
    +    it. It's going to be too easy to inadvertently add some flag that'll
    +    make the expiry happen anyway, and even with "never" we'd like to see
    +    all the lines we're going to keep.
    +
    +    So let's assert that we're going to loop over all the references even
    +    when this configuration is in effect.
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
      --- a/t/t1410-reflog.sh
    @@ -37,7 +30,7 @@
      
     -	git reflog expire --verbose --all &&
     +	git reflog expire --verbose --all >output &&
    -+	test_line_count = 0 output &&
    ++	test_line_count = 9 output &&
     +
      	git reflog refs/heads/master >output &&
      	test_line_count = 4 output
6:  c47dedab58d ! 7:  6693d1d84da gc: don't run "reflog expire" when keeping reflogs
    @@ -1,22 +1,38 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    gc: don't run "reflog expire" when keeping reflogs
    +    gc: handle & check gc.reflogExpire config
     
         Don't redundantly run "git reflog expire --all" when gc.reflogExpire
    -    and gc.reflogExpireUnreachable are set to "never".
    +    and gc.reflogExpireUnreachable are set to "never", and die immediately
    +    if those configuration valuer are bad.
     
    -    An earlier change taught "git reflog expire" itself to exit early
    -    under this scenario, so in some sense this isn't strictly
    -    necessary. Reasons to also do it here:
    +    As an earlier "assert lack of early exit" change to the tests for "git
    +    reflog expire" shows, an early check of gc.reflogExpire{Unreachable,}
    +    isn't wanted in general for "git reflog expire", but it makes sense
    +    for "gc" because:
     
    -     1) Similar to 8ab5aa4bd8 ("parseopt: handle malformed --expire
    -        arguments more nicely", 2018-04-21). We'll die early if the config
    -        variables are set to invalid values. We run "pack-refs" before
    -        "reflog expire", which can take a while, only to then die on an
    -        invalid gc.reflogExpire{Unreachable,} configuration.
    +     1) Similarly to 8ab5aa4bd8 ("parseopt: handle malformed --expire
    +        arguments more nicely", 2018-04-21) we'll now die early if the
    +        config variables are set to invalid values.
    +
    +        We run "pack-refs" before "reflog expire", which can take a while,
    +        only to then die on an invalid gc.reflogExpire{Unreachable,}
    +        configuration.
     
          2) Not invoking the command at all means it won't show up in trace
    -        output, which makes what's going on more obvious.
    +        output, which makes what's going on more obvious when the two are
    +        set to "never".
    +
    +     3) As a later change documents we lock the refs when looping over the
    +        refs to expire, even in cases where we end up doing nothing due to
    +        this config.
    +
    +        For the reasons noted in the earlier "assert lack of early exit"
    +        change I don't think it's worth it to bend over backwards in "git
    +        reflog expire" itself to carefully detect if we'll really do
    +        nothing given the combination of all its possible options and skip
    +        that locking, but that's easy to detect here in "gc" where we'll
    +        only run "reflog expire" in a relatively simple mode.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
7:  55dd203a042 ! 8:  e0814569aba reflog expire: don't assert the OID when locking refs
    @@ -79,6 +79,25 @@
         really tight loop). That can be resolved by being more generous with
         higher values of core.filesRefLockTimeout than the 100ms default.
     
    +    As noted in the commentary being added here we also need to handle the
    +    case of references being racily deleted, that can be tested by adding
    +    this to the above:
    +
    +        (
    +            cd /tmp/git-clone &&
    +            while git branch topic master && git branch -D topic
    +            do
    +                date
    +            done
    +        )
    +
    +    We could change lock_ref_oid_basic() to always pass down
    +    RESOLVE_REF_READING to refs_resolve_ref_unsafe() and then
    +    files_reflog_expire() to detect the "is it deleted?" state. But let's
    +    not bother, in the event of such a race we're going to redundantly
    +    create a lock on the deleted reference, and shortly afterwards handle
    +    that case and others with the refs_reflog_exists() check.
    +
         1. https://public-inbox.org/git/54857871.5090805@alum.mit.edu/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ -87,11 +106,32 @@
      --- a/refs/files-backend.c
      +++ b/refs/files-backend.c
     @@
    + 	 * The reflog file is locked by holding the lock on the
      	 * reference itself, plus we might need to update the
      	 * reference if --updateref was specified:
    ++	 *
    ++	 * We don't pass down the oid here because we'd like to be
    ++	 * tolerant to the OID of the ref having changed, and to
    ++	 * gracefully handle the case where it's been deleted (see oid
    ++	 * -> mustexist -> RESOLVE_REF_READING in
    ++	 * lock_ref_oid_basic()) ...
      	 */
     -	lock = lock_ref_oid_basic(refs, refname, oid,
    -+	lock = lock_ref_oid_basic(refs, refname, NULL /* NOT oid! */,
    ++	lock = lock_ref_oid_basic(refs, refname, NULL,
      				  NULL, NULL, REF_NO_DEREF,
      				  &type, &err);
      	if (!lock) {
    +@@
    + 		strbuf_release(&err);
    + 		return -1;
    + 	}
    ++	/*
    ++	 * When refs are deleted their reflog is deleted before the
    ++	 * loose ref is deleted. This catches that case, i.e. when
    ++	 * racing against a ref deletion lock_ref_oid_basic() will
    ++	 * have acquired a lock on the now-deleted ref, but here's
    ++	 * where we find out it has no reflog anymore.
    ++	 */
    + 	if (!refs_reflog_exists(ref_store, refname)) {
    + 		unlock_ref(lock);
    + 		return 0;
-- 
2.21.0.360.g471c308f928

