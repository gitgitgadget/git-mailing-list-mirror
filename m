Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B6C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 12:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2956115B
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 12:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbhIIMm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbhIIMjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 08:39:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876FC028C39
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 04:48:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eb14so2243792edb.8
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=e99J0iVKrfwbTUoHBqJtCgDOBgPnXBGt9Qyy31hC3p4=;
        b=dw/bmpZl2ebfHKB5lwLMtqMZDvUrcVUk0snJxi7MiGTyQWrCqQzP71nmd1orKFdS1U
         hEZkWyVzzwgmLCulOjpE2YV7DTo4wlnr7hkmENVE+RPsKgfILX4IVH+mSQDi7OzWctSb
         NiEIwVVyByOCy5soMBkxT1FERJA2/GtQGweNbVen0tmoMh2JGpreva9O0n/e5lHSxhNE
         y2TmreYFvF/Afs5Rbc8PEQGvtL6DtIw8x+FZVDBEnBh4RcmIFTgEX3N8gjYCiDqV+kZ8
         vonb/U8IS1XAwPabuZTsK91cc4SWFioaZNlxfGncQKkZekFqruaAl78Ukr0szEosGVok
         9Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=e99J0iVKrfwbTUoHBqJtCgDOBgPnXBGt9Qyy31hC3p4=;
        b=KJ3H6yAjhUCq2L6XsiF5ikZ5oEQ9+b7kzw/ZdnxUXWy0nCF+O5u7tjCwuTp65Bl0X1
         a1IJL2M2WJ4sswGE2Rq1HyPbuzgeMZPxaSi1HSvq1rGSoqrvZkrieCWysVtFru9+Sq2N
         zc4pRyUwkEO5C3FypNQMjOzMftrgpraHOVinQR7fpoE3A94E/518tTo5P9f6cZcnlfIL
         UwefxhQS1u0wnGdnpvYwfTi4fxCwoayM7JSqev7EP5ScdR5W/XN2n9AiPh1uw3/iHOzl
         zo7P4SPTxHySlChVopyHzJRohdHoefDaKZqiyvyrgoPwSu1B2bFfvTJep7BcuH9kP3eV
         5sGg==
X-Gm-Message-State: AOAM5331+/ZbDLe7So6SOVY0NrSm4QDI41kN61lNrWYeja+062C4ty5Y
        p7ADmqONOX+lIZlISdcnSkb3/v9O01Rg4w==
X-Google-Smtp-Source: ABdhPJzWPfIBOxfq+Y5RLtoeF1++uJWZ7+zmYRradhe5LvMDCJ7/H6d1/DB+FMtgWk/CewyJDeciKA==
X-Received: by 2002:aa7:d649:: with SMTP id v9mr2842653edr.38.1631188123990;
        Thu, 09 Sep 2021 04:48:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l8sm825548ejn.103.2021.09.09.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:48:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
Date:   Thu, 09 Sep 2021 13:18:41 +0200
References: <xmqqsfyf5b74.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <87fsuedl5x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Junio C Hamano wrote:

As usual, updates on my topics & related:

First, I realize you're busy & I have a lot of things outstanding, but
just for completeness, trivial one-patch topics I submitted recently
that you didn't pick up. I think all of these are rather simple &
straightforward bug fixes / improvements:

* fetch-negotiator: call BUG() on API misuse, don't segfault:
  <patch-1.1-f1da49de63-20210727T000203Z-avarab@gmail.com>
  (https://lore.kernel.org/git/patch-1.1-f1da49de63-20210727T000203Z-avarab@gmail.com/)

* http.c: use error_errno(), not error() after fopen() failure:
  <patch-1.1-ad71faa6da-20210727T000657Z-avarab@gmail.com>
  (https://lore.kernel.org/git/patch-1.1-ad71faa6da-20210727T000657Z-avarab@gmail.com/)

* stash: print the correct usage on "git stash [push] --invalid-option":
  <patch-1.1-47c582f1218-20210901T111930Z-avarab@gmail.com>:
  https://lore.kernel.org/git/patch-1.1-47c582f1218-20210901T111930Z-avarab@gmail.com/

And then this 2-patch and slightly more complex series to make "git
<built-in> -h" output prettily aligned:

* parse-options: properly align continued usage output:
  <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>:
  https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com/

Notes on picke-dup serieses below:

> * ab/no-more-check-bindir (2021-09-07) 1 commit
>  Will merge to 'next'.
> * ab/send-email-config-fix (2021-09-07) 1 commit
>  Will merge to 'next' and then to 'master'.
>  Will merge to 'next'.

Thanks!

>> * ab/reverse-midx-optim (2021-09-07) 1 commit
>  - pack-write: skip *.rev work when not writing *.rev

Already merged to "next" I see, thanks!

> * ab/sanitize-leak-ci (2021-09-07) 3 commits

Per your comment about this & my reply at
https://lore.kernel.org/git/87sfyfgtfh.fsf@evledraar.gmail.com/ & not
having heard back from Emily...

> * es/config-based-hooks (2021-08-19) 7 commits
> [...]
>  - Merge branch 'ab/config-based-hooks-base' into es/config-based-hooks
>  (this branch uses ab/config-based-hooks-base.)
>
>  Revamp the hooks subsystem to allow multiple of them to trigger
>  upon the same event and control via the configuration variables.
>
>  Expecting a reroll
>  but ab/config-based-hooks-base needs to be in a better shape first.
>  cf. <87v93wflm0.fsf@evledraar.gmail.com>
>  cf. <87tuj7xhqo.fsf@evledraar.gmail.com>

... I'll submit my version of this on top of my not-yet-picked-up (due
to a conflict with this stale topic) ab/config-based-hooks-base, pending
Emily's canonical version of that..

> * jh/builtin-fsmonitor (2021-09-03) 37 commits
> [...]
> Expecting a reroll post 2.33 release.

Per your "I may start discarding too ancient topics to nudge the authors
to resubmit updates to them" above I've got one one-patch series cleanup
that's been blocked by a conflict with this for a long time. Perhaps a
candidate for ejection until the re-roll materializes?

> * ab/fsck-unexpected-type (2021-09-07) 22 commits
> [...]
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Needs review.

Indeed, any takers? It's been cooking for a long time and I think it
should be well tested / mature at this point, but if there's no takers I
might need to split it up and submit it incrementally. I haven't thought
of a way to do that that doesn't make it more confusing, e.g. just the
tests or just some of the prep work is a "bridge to nowhere" without the
end parts of it...

> * gh/gitweb-branch-sort (2021-06-10) 1 commit
>  - gitweb: use HEAD as secondary sort key in git_get_heads_list()
>
>  Tie-break branches that point at the same object in the list of
>  branches on GitWeb to show the one pointed at by HEAD early.
>
>  Will merge to 'next'.

Nice!

> * js/retire-preserve-merges (2021-09-07) 11 commits
> [...]
>  The "--preserve-merges" option of "git rebase" has been removed.
>
>  Will merge to 'next'?

I agree that that would be nice, and re
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091307070.59@tvgsbejvaqbjf.bet/
think it would be fine for that to happen sooner than later, but if
Johannes would prefer to wait a while...

> * ab/gc-log-rephrase (2021-09-02) 1 commit
>  Will merge to 'master'.
> * ab/mailmap-leakfix (2021-08-31) 1 commit
>  Will merge to 'master'.
> * ba/object-info (2021-08-31) 1 commit
>  Will merge to 'master'.

Thanks!

> * ab/commit-graph-usage (2021-08-30) 7 commits
> [...]
>  Will merge to 'master'.

Thanks, I've got some more parse_options() fixes waiting on this.

> * ab/ls-remote-packet-trace (2021-08-24) 1 commit
>  Will merge to 'master'.
> * ab/rebase-fatal-fatal-fix (2021-08-24) 1 commit
>  Will merge to 'master'.

Thanks!

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  (this branch uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)
>
>  The "remainder" of hn/refs-errno-cleanup topic.

It would be nice to get some movement on this and the dependant topics,
per my https://lore.kernel.org/git/8735qnax0o.fsf@evledraar.gmail.com/

> * ab/retire-advice-config (2021-08-25) 4 commits
> [...]
>  Will merge to 'master'.

Thanks. I've also got some more advice fixes waiting on this.

> * js/maintenance-launchctl-fix (2021-08-24) 2 commits
> [...]
>  Will merge to 'master'.

Merged already I see, I have a trivial fix-on-top at
https://lore.kernel.org/git/patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com/

> * jv/pkt-line-batch (2021-09-01) 2 commits
>  - upload-pack: use stdio in send_ref callbacks
>  - pkt-line: add stdio packet write functions
>
>  Reduce number of write(2) system calls while sending the
>  ref advertisement.
>
>  Will merge to 'next'?

LGTM!

> * ab/unbundle-progress (2021-09-07) 4 commits
>  - bundle: show progress on "unbundle"
>  - index-pack: add --progress-title option
>  - bundle API: change "flags" to be "extra_index_pack_args"
>  - bundle API: start writing API documentation
>
>  Add progress display to "git bundle unbundle".
>
>  Will merge to 'next'?

I think so, the last re-roll was small, reduced net complexity, and
addressed all outstanding feedback.

> * ab/lib-subtest (2021-08-05) 11 commits
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: assert no copy/pasted mock test code
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: stop using a subshell in write_sub_test_lib_test()
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>
>  Updates to the tests in t0000 to test the test framework.

Would be nice to get movement on this, any takers for reviews? Perhaps I
should re-submit it.

> * ab/only-single-progress-at-once (2021-07-23) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - pack-bitmap-write.c: add a missing stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c: stop eagerly fflush(stderr) when not a terminal
>  - progress.c: call progress_interval() from progress_test_force_update()
>  - progress.c: move signal handler functions lower
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop verbs on stdin
>
>  Further tweaks on progress API.
>
>  On hold.
>  cf. <20210901050406.GB76263@szeder.dev>

SZEDER: Any hints as to what that issue is or how to reproduce it?

> * ab/progress-users-adjust-counters (2021-08-25) 2 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  Will merge to 'next'?

Sounds good, I re-rolled this at
https://lore.kernel.org/git/cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com/
to fix a relatively trivial and new conflict with "master", t omake that
easier.

> * ab/make-tags-cleanup (2021-08-05) 5 commits
> [...]
>  Build clean-up for "make tags" and friends.
>
>  Will merge to 'next'?

I think it's ready & has all previous feedback addressed.

> * ab/config-based-hooks-base (2021-08-03) 36 commits
> [...]
>  (this branch is used by es/config-based-hooks.)
>
>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

Per note on es/config-based-hooks above this is the v4 that's replaced
by my not-yet-picked-up due to conflict with es/config-based-hooks v5.

> * ab/serve-cleanup (2021-08-05) 10 commits
>  - upload-pack: document and rename --advertise-refs
>  - serve.[ch]: remove "serve_options", split up --advertise-refs code
>  - {upload,receive}-pack tests: add --advertise-refs tests
>  - serve.c: move version line to advertise_capabilities()
>  - serve: move transfer.advertiseSID check into session_id_advertise()
>  - serve.[ch]: don't pass "struct strvec *keys" to commands
>  - serve: use designated initializers
>  - transport: use designated initializers
>  - transport: rename "fetch" in transport_vtable to "fetch_refs"
>  - serve: mark has_capability() as static
>
>  Code clean-up around "git serve".
>
>  Will merge to 'next'?

That would be very nice, I think it's received thorough reviews of the
relevant parts that still remain, and the whole "config callback"
mechanism people were on the fence about has been entirely ejected.

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.
>
>  Waiting for reviews.

Per https://lore.kernel.org/git/8735qnax0o.fsf@evledraar.gmail.com/ I'd
prefer to have this reviewed & go in in isolation, but per the note
there if there's no interest perhaps I'll re-submit a larger version of
this that implements the "refs and tips on stdin to git bundle" that I
created this for.

> * ab/refs-files-cleanup (2021-08-25) 13 commits
>  - refs/files: remove unused "errno != ENOTDIR" condition
>  - refs/files: remove unused "errno == EISDIR" code
>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>  - refs API: remove OID argument to reflog_expire()
>  - reflog expire: don't lock reflogs using previously seen OID
>  - refs/files: add a comment about refs_reflog_exists() call
>  - refs: make repo_dwim_log() accept a NULL oid
>  - refs/debug: re-indent argument list for "prepare"
>  - refs/files: remove unused "skip" in lock_raw_ref() too
>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>  - refs: drop unused "flags" parameter to lock_ref_oid_basic()
>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>  - refs/packet: add missing BUG() invocations to reflog callbacks
>  (this branch is used by ab/refs-errno-cleanup and hn/refs-errno-cleanup.)
>
>  Continued work on top of the hn/refs-errno-cleanup topic.
>
>
> * hn/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>  - refs file backend: move raceproof_create_file() here
>  (this branch is used by ab/refs-errno-cleanup; uses ab/refs-files-cleanup.)
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.

I think these should be ready for merger down, also per the note in last
week's What's Cooking at
https://lore.kernel.org/git/8735qnax0o.fsf@evledraar.gmail.com/
