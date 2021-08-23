Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE6C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB956113B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbhHWL1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHWL1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:27:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A96C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:26:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a25so9591409ejv.6
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mDniVpp0dAXa47JV/6w/5vUqyuWBuq8GmXi7XEaj0vo=;
        b=cXPXDHJjhvmCE5pLnmupHBeVL4rmZhkNpTJ5Y6Wf8q/HiO8OrxdCbCgg4gAm+/ZusV
         gzwGNNgUDDCWxrFyJKJvB4moYUxjDQ2JEThV+SFP/h/TjguwTwSMIttOR7Z7ZxOJtLmj
         HQwm3wqbDkQWt9kSzYPjFqV6ZuSBZx3ism0Qke7pr83h6TYavtLTKP7GKEtmPoHVv4Ae
         JSezU2dCyMsAQ9OIsnRx6QMOlNho6fCHYQ5PBi3HgZ3WiaZHJvhTzCVKQMaUzV0gBrzb
         yVqHGD7KObpIK/hhQepuTLmBe2ysFKfOjzI4WZ9ygKYG7dth4Jgv6/gK5WAJLxyo+IHt
         /WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mDniVpp0dAXa47JV/6w/5vUqyuWBuq8GmXi7XEaj0vo=;
        b=aipJEadQOdbylD111VtBv/7XTxZhDP/XRn1xoHm475xS5Z3Gye3hFynNXgL4rYOzcE
         5cpvuO+H+N3tDAPdYK4TyPr2YY4Ojw9Udp589jI9sw7ZmO9vYrk+/i/V4lmFkcKsKTgI
         onbOzkHHdiY7QsRT9704UN6PPcUQK+SoksC0wrOo8DZBWhXCtkGd7yjzy5DGjeKD2abd
         Re3Jl/sjiqozTQaSD6VxegO2hNm2PrUgS9EjUfmTt+sWAm//RTifBydJp/6hlc8orPzh
         2p21eKbR117KPvPVtmdPJOo+dSND6qGfHaFbedaZkDs763tthbiP09UqwDUVAdkAwkEv
         0iFg==
X-Gm-Message-State: AOAM531zS0fPMznX/U7gdOBm9rMpWoRel4bBUGf82Q8LLzt3J6JVmGcO
        8cdWnKJHBAjnGcSXBUcLKdw=
X-Google-Smtp-Source: ABdhPJzMJDvzSuyidJRcZfyMjpQ3uI68BPH10/qZPPmjXVdyGDEECJ6p8yq65Lvzvya+mk+c6v3/Vw==
X-Received: by 2002:a17:907:a04d:: with SMTP id gz13mr2221911ejc.91.1629717976918;
        Mon, 23 Aug 2021 04:26:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lb12sm7285982ejc.28.2021.08.23.04.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:26:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2021, #07; Fri, 20)
Date:   Mon, 23 Aug 2021 12:45:06 +0200
References: <xmqqh7fkuhyx.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqh7fkuhyx.fsf@gitster.g>
Message-ID: <87v93wflm0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 20 2021, Junio C Hamano wrote:

Updates on my topics:

> * es/config-based-hooks (2021-08-19) 7 commits
>  - hook: allow out-of-repo 'git hook' invocations
>  - hook: include hooks from the config
>  - hook: allow running non-native hooks
>  - hook: introduce "git hook list"
>  - hook: allow parallel hook execution
>  - hook: run a list of hooks instead
>  - Merge branch 'ab/config-based-hooks-base' into es/config-based-hooks
>  (this branch uses ab/config-based-hooks-base.)
>
>  Revamp the hooks subsystem to allow multiple of them to trigger
>  upon the same event and control via the configuration variables.
>
>  Will merge to 'next'?

There's still outstanding feedback on the "base" topic at
https://lore.kernel.org/git/cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com/
and I haven't gotten around to reviewing v2 and v3
(https://lore.kernel.org/git/20210819033450.3382652-1-emilyshaffer@google.com/)
of this post-vacation. The v2 had some major changes in response to my
feedback.

I'm getting to all of that SOON, but probably best to hold it off from
"next" for now...

> * jk/refs-files-cleanup-cleanup (2021-08-19) 1 commit
>  - refs: drop unused "flags" parameter to lock_ref_oid_basic()
>  (this branch is used by hn/refs-errno-cleanup; uses ab/refs-files-cleanup.)
>
>  Code cleanup.
>
>  Kicked out of 'next', to give ab/refs/files-cleanup a clean restart.
>  I suspect that ab/refs-files-cleanup can fix its commit by
>  squashing it in, but I'll leave that to the owner of the topic.

Commented on below.

> * ab/http-drop-old-curl (2021-07-30) 5 commits
>   (merged to 'next' on 2021-08-02 at b382ac042f)
>  + http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
>  + http: drop support for curl < 7.19.3 and < 7.17.0 (again)
>  + http: drop support for curl < 7.19.4
>  + http: drop support for curl < 7.16.0
>  + http: drop support for curl < 7.11.1
>
>  Support for ancient versions of cURL library has been dropped.
>
>  Will cook in 'next'.

Thanks, hopefully we can have that land sooner than later. There's
already been one on-list patch in the interim doing manual checks of
LIBCURL_VERSION_NUM, which would benefit from the subsequent change I
have in
https://lore.kernel.org/git/patch-v3-7.7-93a2775d0ee-20210730T092843Z-avarab@gmail.com/
(i.e. https://lore.kernel.org/git/20210819131808.40759-2-chenan.xxw@alibaba-inc.com/
is that patch using LIBCURL_VERSION_NUM).

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

Has been stalled waiting on review for a while. I split up a tricky part
of it in the v3 to make it more palatable, but so for no takers:
https://lore.kernel.org/git/cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com

Perhaps given that these are test-only changes we can declare it in good
enough state as it is?

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

The changes are rather straightforward, see
https://lore.kernel.org/git/cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com;
so if anyone's interested in reviewing them.

There's been no reports of anyone running into the new BUG() assertion
in 8/8 of it:
https://lore.kernel.org/git/patch-8.8-1a14176bee-20210722T125012Z-avarab@gmail.com/

Given the chicken & egg problem of such a thing needing wider testing,
but at least "next" being needed for that wider testing I'd think
merging this down early-ish in the 2.34 cycle would be good to smoke out
any potential issues.

As noted in earlier summaries this series is paving the way for some
subsequent feature work in progress.c.

> * ab/progress-users-adjust-counters (2021-08-05) 3 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - midx: don't provide a total for QSORT() progress
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  The middle one wants to be discarded.
>  cf. <87v94jzoxj.fsf@evledraar.gmail.com>

Re-rolled earlier as
https://lore.kernel.org/git/cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com/
with that ejection.

> * ab/refs-files-cleanup (2021-08-19) 11 commits
>  - refs/files: remove unused "errno != ENOTDIR" condition
>  - refs/files: remove unused "errno == EISDIR" code
>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>  - reflog expire: don't lock reflogs using previously seen OID
>  - refs/files: add a comment about refs_reflog_exists() call
>  - refs: make repo_dwim_log() accept a NULL oid
>  - refs/debug: re-indent argument list for "prepare"
>  - refs/files: remove unused "skip" in lock_raw_ref() too
>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>  - refs/packet: add missing BUG() invocations to reflog callbacks
>  (this branch is used by hn/refs-errno-cleanup and jk/refs-files-cleanup-cleanup.)
>
>  Kicked out of 'next', to give ab/refs/files-cleanup a clean restart.
>
>  I suspect that jk/refs-files-cleanup-cleanup should be squashed
>  into the commits in this topic, but I'll leave that to the owner of
>  the topic.

Commented on below.

> * ab/bundle-doc (2021-08-02) 4 commits
>   (merged to 'next' on 2021-08-04 at b3b3b0fa98)
>  + bundle doc: replace "basis" with "prerequsite(s)"
>  + bundle doc: elaborate on rev<->ref restriction
>  + bundle doc: elaborate on object prerequisites
>  + bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.
>
>  Will cook in 'next'.
>
>
> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>   (merged to 'next' on 2021-08-04 at f464b74a6f)
>  + pack-objects: fix segfault in --stdin-packs option
>  + pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  Will cook in 'next'.

Thanks, hopefully these are landing soon after immediate post-release
work...

> * ab/make-tags-cleanup (2021-08-05) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: remove "cscope.out", not "cscope*" in cscope.out target
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Expecting a reroll.
>  4/5 may want a minor tweak to the log and the patch text but otherwise looks good.

This entire comment has been in What's Cooking since v3 of the series,
but v4 has been out since August 4th:
https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com/

I believe this is ready for "next" at this point.

> * ab/config-based-hooks-base (2021-08-03) 36 commits
>  - hooks: fix a TOCTOU in "did we run a hook?" heuristic
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - receive-pack: convert 'update' hook to hook.h
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - reference-transaction: use hook.h to run hooks
>  - hook tests: use a modern style for "pre-push" tests
>  - hook tests: test for exact "pre-push" hook input
>  - transport: convert pre-push hook to hook.h
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
>  - hook: provide stdin by string_list or callback
>  - run-command: add stdin callback for parallelization
>  - am: convert 'post-rewrite' hook to hook.h
>  - hook: support passing stdin to hooks
>  - run-command: allow stdin for run_processes_parallel
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: convert post-merge to use hook.h
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook: add 'run' subcommand
>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c users: use "hook_exists()" insted of "find_hook()"
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() to this new library
>  - Makefile: remove an out-of-date comment
>  - Makefile: stop hardcoding {command,config}-list.h
>  - Makefile: mark "check" target as .PHONY
>  (this branch is used by es/config-based-hooks.)
>
>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

*Nod*, see also my commentary on es/config-based-hooks above.

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
>  Expecting a reroll.

The "Expecting a reroll" here was added in response to (I think) my
commentary in
https://lore.kernel.org/git/87wnp1mqv2.fsf@evledraar.gmail.com/ that I'd
re-roll it, but the already picked up v4 is that re-roll:
https://lore.kernel.org/git/cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com/

> [...]
> * hn/refs-errno-cleanup (2021-08-19) 7 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>  - refs file backend: move raceproof_create_file() here
>  (this branch uses ab/refs-files-cleanup and jk/refs-files-cleanup-cleanup.)
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.
>
>  Kicked out of 'next', to give ab/refs/files-cleanup a clean restart.

Will re-roll (hopefully today) along with jk/refs-files-cleanup-cleanup
and ab/refs-files-cleanup.

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Expecting a reroll.

I've been intending to re-roll this...

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

*Nod*, Jonathan Tan: Perhaps given your earlier reviews you'd like to
look it over, at:
https://lore.kernel.org/git/cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com/

> * ab/fsck-unexpected-type (2021-07-12) 21 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: report invalid types recorded in objects
>  - object-store.h: move read_loose_object() below 'struct object_info'
>  - fsck: don't hard die on invalid object types
>  - object-file.c: return -2 on "header too long" in unpack_loose_header()
>  - object-file.c: return -1, not "status" from unpack_loose_header()
>  - object-file.c: guard against future bugs in loose_object_info()
>  - object-file.c: stop dying in parse_loose_header()
>  - object-file.c: split up ternary in parse_loose_header()
>  - object-file.c: simplify unpack_loose_short_header()
>  - object-file.c: add missing braces to loose_object_info()
>  - object-file.c: make parse_loose_header_extended() public
>  - object-file.c: don't set "typep" when returning non-zero
>  - cache.h: move object functions to object-store.h
>  - cat-file tests: test for current --allow-unknown-type behavior
>  - cat-file tests: add corrupt loose object test
>  - rev-list tests: test for behavior with invalid object types
>  - cat-file tests: test that --allow-unknown-type isn't on by default
>  - cat-file tests: test for missing object with -t and -s
>  - fsck tests: add test for fsck-ing an unknown type
>  - fsck tests: refactor one test to use a sub-repo
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Needs review.

*Poke* @ Jeff King & Jonathan Tan: Interested in taking a look?
