Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ACC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 10:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B33661029
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 10:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhHDKoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbhHDKod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 06:44:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A24C061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 03:44:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id go31so3041267ejc.6
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aPywmmbXf1mZG7aQdp3b1ype4JREuHnd4DB+BF8D0Xs=;
        b=IvWfuxXI8fKLNlRBgXuHnZNSNF86yuv9i/cYdvm/iY3AmSyaoN59KbmRL8fGktByY2
         UGQEm4iYE93s1/DpXSB2S7WcVurXNBaaSdAleC/PjL2ZN+5XbEgn8NvY3lczKDkmtmhb
         f6oxGkkp5SJEsFAZFR4QPgBVgtc0SdmhUt0OCJdXYdojl7kpb+rMRTh/sS6ngI8eoSwX
         GNHxAksjTrTE0g9N52acwD5FpOVtogfjiLY+MvPu7KuCvJcgMAmgLXZ+B2b8bJmIDeQd
         6PsWxIV2L4raxGhHT9HkOQx6anFHM8N8k7uRtU6xh6pktNSX6xAY5t3Qgc1OG1wwFS9P
         IL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aPywmmbXf1mZG7aQdp3b1ype4JREuHnd4DB+BF8D0Xs=;
        b=bLTC/pODvOPfzSmNwyLdumgsSYI0LQqPqeE/CygHUMLNTPZGwbalVnZA7d4R9IDrco
         xjzB8zTGfZ76pyoJOVSSocB6LeE3YtTYNiD+bAEpgsrKnLKbajZ4TJCe3+7R/yd7O6zo
         ivrUu8tLmLVPCZMAix4y2JEBQto+B9uVxZ6CPjBI1MG8j2Vqccn2zn99eOq/mPLZL6Zj
         zT4ZvoguJdTxPEE1J3qHWTnBC0N1jYLhpVx4ChrecW9albCbTG45/NYPzeQ1A1UrXH0l
         uXrLiMobQJwM5fGWuf/ChOLqeu5oCqiKCuIC1/sFXXgkRJDxy0GTcaj50u+XHnAkwlzN
         xhsQ==
X-Gm-Message-State: AOAM533ofmw0tCiscIbXzMaly5uTvOrr52W6zgiPbSugvcgVwLivVsYc
        eM/nceiQxVF/Y5tL8F/1BA0=
X-Google-Smtp-Source: ABdhPJwWWpqFfERFJquXw6AgqLLS65WtkRbBStpw7Lhdb6Lvi5DA7OnWp2UGUiBxaVcAaZLQuih/MA==
X-Received: by 2002:a17:906:72ce:: with SMTP id m14mr24268908ejl.394.1628073858430;
        Wed, 04 Aug 2021 03:44:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h19sm796884edt.87.2021.08.04.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 03:44:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Date:   Wed, 04 Aug 2021 12:22:44 +0200
References: <xmqqfsvpr8t5.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqfsvpr8t5.fsf@gitster.g>
Message-ID: <87wnp1mqv2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Junio C Hamano wrote:

Comments on my topics & other things I've got feedback on:

> * ab/bundle-tests (2021-07-22) 2 commits
>   (merged to 'next' on 2021-07-22 at 053b5d0ecf)
>  + bundle tests: use test_cmp instead of grep
>  + bundle tests: use ">file" not ": >file"
>
>  "git bundle" gained more test coverage.

Thanks!

> * ab/test-columns (2021-08-02) 3 commits
>  - test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
>  - test-lib-functions.sh: add a test_with_columns function
>  - test-lib-functions.sh: rename test_must_fail_acceptable()

We're going to need this or another solution to the v2.33.0-rc0
regression in c49a177beca (test-lib.sh: set COLUMNS=80 for --verbose
repeatability, 2021-06-29) before the final v2.33.0.

I think whatever we do we should act on that soon so it's in master
before rc1, or at least in rc1, so we can get testing of the fix well
before the release...

> * ab/getcwd-test (2021-07-30) 1 commit
>   (merged to 'next' on 2021-08-02 at 22ecd02929)
>  + t0001: fix broken not-quite getcwd(3) test in bed67874e2
>
>  Portability test update.
>
>  Will merge to 'master'.

Thanks!

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

Makes sense, thanks. So post-release.

> * ab/lib-subtest (2021-07-21) 10 commits
>  - test-lib tests: assert 1 exit code, not non-zero
>  - test-lib tests: refactor common part of check_sub_test_lib_test*()
>  - test-lib tests: avoid subshell for "test_cmp" for readability
>  - test-lib tests: get rid of copy/pasted mock test code
>  - test-lib tests: don't provide a description for the sub-tests
>  - test-lib tests: stop using a subshell in write_sub_test_lib_test()
>  - test-lib tests: split up "write and run" into two functions
>  - test-lib tests: move "run_sub_test" to a new lib-subtest.sh
>  - Merge branch 'ps/t0000-output-directory-fix' into ab/lib-subtest
>  - Merge branch 'jk/t0000-subtests-fix' into ab/lib-subtest
>
>  Updates to the tests in t0000 to test the test framework.
>
> [...]
>
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

Thanks, it would be great to have both of these move soon after the
release. I think the chances of unexpected breakage here are minimal
given their nature.

> * ab/progress-users-adjust-counters (2021-07-23) 3 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - midx: don't provide a total for QSORT() progress
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  Waiting for a clarification.
>  cf. <xmqqbl6slmer.fsf@gitster.g>

I think that what SZEDER had to say in
https://lore.kernel.org/git/20210802220506.GF23408@szeder.dev/ should be
enough to clear this to proceed forward.

I.e. this topic is missing his subsequent
https://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com/
patch.

But as he notes we only encounter this in one of our tests (and are
unlikely to in the wild).

Between this topic and my ab/only-single-progress-at-once I think we're
better off getting those basic fixes in before proceeding with any
tricky additions of BUG() and other assertions, per what I noted in
https://public-inbox.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/;
i.e. that some of those assertions were themselves buggy.

> * ab/refs-files-cleanup (2021-08-02) 11 commits
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
>  (this branch is used by hn/refs-errno-cleanup.)
>
>  Will merge to 'next'.

Thanks!

> * ab/bundle-doc (2021-08-02) 4 commits
>  - bundle doc: replace "basis" with "prerequsite(s)"
>  - bundle doc: elaborate on rev<->ref restriction
>  - bundle doc: elaborate on object prerequisites
>  - bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.
>
>  Will merge to 'next'.

Yay, we finally got this in good enough shape :)

> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>  - pack-objects: fix segfault in --stdin-packs option
>  - pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  Will merge to 'next'.

Thanks!

> * ab/make-tags-cleanup (2021-07-22) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: the "cscope" target always creates a "cscope.out"
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Expecting a reroll.
>  4/5 may want a minor tweak to the log and the patch text but otherwise looks good.

This is the 3rd What's Cooking where I comment to the effect that I
don't think we need a re-roll (previously at
https://lore.kernel.org/git/87sg00qfbp.fsf@evledraar.gmail.com/ &
https://lore.kernel.org/git/87wnp4p4xo.fsf@evledraar.gmail.com/).

I.e. my comment in
https://lore.kernel.org/git/87k0lit57x.fsf@evledraar.gmail.com/ of:
    
    As long as we have no user of a -q flag ever, what's the point of
    forever carrying the "rm foo*" when we know it's foo.out, just
    because a future Makefile change might add foo.blah?
    
    Doesn't seem like something we'd trip over, and the .gitignore/rm
    rule is just misleading now...

So I think this is fine as-is, if you or Taylor still feel it should be
kept I can re-roll it, seems rather weird as long as we have no
$(CSCOPE_FLAGS), but whatever.

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
>
>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

Indeed: https://lore.kernel.org/git/87zgtxms4s.fsf@evledraar.gmail.com/

> * ab/serve-cleanup (2021-08-03) 13 commits
>  - fixup! {upload,receive}-pack tests: add --advertise-refs tests
>  - serve.[ch]: don't pass "struct strvec *keys" to commands
>  - upload-pack.c: convert to new serve.c "startup" config cb
>  - upload-pack: document and rename --advertise-refs
>  - {upload,receive}-pack tests: add --advertise-refs tests
>  - serve.[ch]: remove "serve_options", split up --advertise-refs code
>  - serve.c: move version line to advertise_capabilities()
>  - serve: add support for a "startup" git_config() callback
>  - serve.c: add call_{advertise,command}() indirection
>  - serve: use designated initializers
>  - transport: use designated initializers
>  - transport: rename "fetch" in transport_vtable to "fetch_refs"
>  - serve: mark has_capability() as static
>
>  Code clean-up around "git serve".

It seems the reception to the "config callback" part of this was rather
lukewarm. I'll re-roll to eject those changes and see if it's better
received.

> * hn/refs-errno-cleanup (2021-08-02) 7 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  - refs: make errno output explicit for read_raw_ref_fn
>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>  - refs file backend: move raceproof_create_file() here
>  (this branch uses ab/refs-files-cleanup.)
>
>  Futz with the way 'errno' is relied on in the refs API to carry the
>  failure modes up the callchain.
>
>  Will merge to 'next'.

Yay!

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Waiting for reviews.

Been saying I'll re-roll this one, willdo....

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.

Still keeen to get this moving, if there's any takers for reviews...

> * ab/update-submitting-patches (2021-07-22) 2 commits
>   (merged to 'next' on 2021-07-30 at 9ae2de7f7a)
>  + SubmittingPatches: replace discussion of Travis with GitHub Actions
>  + SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Will merge to 'master'.

Thanks...

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

...ditto a call-out for reviewer interest...

> * es/config-based-hooks (2021-07-20) 9 commits
>  - hook: implement hookcmd.<name>.skip
>  - hook: teach 'hookcmd' config to alias hook scripts
>  - hook: allow out-of-repo 'git hook' invocations
>  - hook: include hooks from the config
>  - hook: allow running non-native hooks
>  - hook: treat hookdir hook specially
>  - hook: introduce "git hook list"
>  - hook: allow parallel hook execution
>  - hook: run a list of hooks instead
>
>  Discarded to give room for updated ab/config-based-hooks-base.

I understand that Emily is re-rolling this on top of my
ab/config-based-hooks-base.
