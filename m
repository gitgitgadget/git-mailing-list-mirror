Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44122C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2538F61411
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhGAOiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGAOiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:38:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC0C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:36:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c17so10703751ejk.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5h/iot08wzdNSj112B4k/aNBmObkOA16T1N65f+J4PI=;
        b=fkW30zsHhq0cH/t7wqCGGafhFPFJrbCRSp8AE4EjLs+0reNeaOcFVRb3X3Zo9RPGiz
         V31LtJJ+F9gS9HKYdTgvTNW3jODta3GzUy3RCyJy9ik+zTzTmD5fULscXHcU3vddJBUO
         TVPtTKuiBY/93PwuoSomBKIHN/3P3TVXyApa+0FCqmKwaIHPfBuFXw3sqCzrIHlnbl8M
         WqIC/sRttwtQfFvFLbTEeyU/WqIaMRiCaOXRn36GoHHqdEQ6X5B0xH8mc9toM0nmn1C6
         e2Pt2Q4dIsrNhe2kHzTFOu5NiuvMKe4fmfykkHQoSPtWBmN6wfwPoJ5c3nBZhjolMhGP
         P2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5h/iot08wzdNSj112B4k/aNBmObkOA16T1N65f+J4PI=;
        b=AUGA0azN/1wvy2teJs1FvR5yrIhHHaF9YbpDSHN6J43Z0fk/L9+QiIJ/CJFaX0b/V9
         gdreGfnjPGUQILqgpktQ3WZsj9qoiGaVdqZnxmsNrMvpV0knpoXfXl6SY4pRmQ4tT7wb
         lp4mvKCooP5Nu/pqbE/CNSOkzHLiswQNtxXzL81ILZTzW7kJ+gpO47ZhTCm5GRCDkVNd
         YTRiwopemY48K56OuTne4cMELx+2Z5meg2UUt5D+j3faQWYgbsjHzUfag4JX5TzRXzaU
         7T8uUsDsvuL7Znev5CCI4TGp+5UmFHLvQwD9pRZy0PE1ePhNJv2rLlQ9wOMPQlFwvo3W
         pNJg==
X-Gm-Message-State: AOAM531a496gp+ChdU2FATUKc2nQJ20HQDxlU7ReezMD9TCLevMW9E09
        P7NLN27w3lCe2jSyB/+u2Xg=
X-Google-Smtp-Source: ABdhPJwiHpO0wMeV4FzMhZTI9GdgWTn6WtpoWA/MnVCVs51fBpO2RYFGsAXYengGRVbLadf57AoE0g==
X-Received: by 2002:a17:906:8144:: with SMTP id z4mr177822ejw.244.1625150178421;
        Thu, 01 Jul 2021 07:36:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z26sm5447eja.26.2021.07.01.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:36:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Date:   Thu, 01 Jul 2021 16:00:01 +0200
References: <xmqq4kdft122.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq4kdft122.fsf@gitster.g>
Message-ID: <87o8bmcd9a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Comments on my outstanding:

On Wed, Jun 30 2021, Junio C Hamano wrote:

> * ab/bundle-doc (2021-06-30) 3 commits
>  - bundle doc: elaborate on rev<->ref restriction
>  - bundle doc: split out open v.s. closed discussion from <rev-arg>
>  - bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.

Will update per your https://lore.kernel.org/git/xmqqk0mbt5rj.fsf@gitster.g/

> * ab/pack-stdin-packs-fix (2021-06-28) 2 commits
>  - pack-objects: fix segfault in --stdin-packs option
>  - pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  cf. <YND3h2l10PlnSNGJ@nand.local>

Will address & re-roll.

> * ab/bundle-updates (2021-06-30) 3 commits
>  - bundle: remove "ref_list" in favor of string-list.c API
>  - bundle.c: use a temporary variable for OIDs and names
>  - bundle cmd: stop leaking memory from parse_options_cmd_bundle()
>
>
> * ab/fetch-negotiate-segv-fix (2021-06-30) 3 commits
>  - fetch: fix segfault in --negotiate-only without --negotiation-tip=3D*
>  - fetch: document the --negotiate-only option
>  - send-pack.c: move "no refs in common" abort earlier

Has outstanding comments, will re-roll.

> * ab/make-delete-on-error (2021-06-29) 1 commit
>  - Makefile: add and use the ".DELETE_ON_ERROR" flag

I think this is stable at this point & has gotten a lot of
attention/review:
https://lore.kernel.org/git/patch-1.1-2557117855-20210629T084356Z-avarab@gm=
ail.com/

> * ab/make-tags-cleanup (2021-06-29) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: fix "cscope" target to refer to cscope.out
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target

Will re-roll per https://lore.kernel.org/git/67c45b13-df8f-8065-377a-fbd2f8=
0992ee@ramsayjones.plus.com/

> * ab/describe-tests-fix (2021-05-11) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>
>  Various updates to tests around "git describe"
>
>  Will merge to 'next'.

Thanks!

> * ab/pickaxe-pcre2 (2021-05-11) 22 commits
>  - xdiff-interface: replace discard_hunk_line() with a flag
>  - xdiff users: use designated initializers for out_line
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: allow early return from xdiff_emit_line_fn
>  - xdiff-interface: prepare for allowing early return
>  - pickaxe -S: slightly optimize contains()
>  - pickaxe: rename variables in has_changes() for brevity
>  - pickaxe -S: support content with NULs under --pickaxe-regex
>  - pickaxe: assert that we must have a needle under -G or -S
>  - pickaxe: refactor function selection in diffcore-pickaxe()
>  - perf: add performance test for pickaxe
>  - pickaxe/style: consolidate declarations and assignments
>  - diff.h: move pickaxe fields together again
>  - pickaxe: die when --find-object and --pickaxe-all are combined
>  - pickaxe: die when -G and --pickaxe-regex are combined
>  - pickaxe tests: add missing test for --no-pickaxe-regex being an error
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - grep/pcre2 tests: reword comments referring to kwset
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.
>
>  Will merge to 'next'.

Thanks!

> * ab/config-based-hooks-base (2021-06-29) 33 commits
>  - hooks: fix a TOCTOU in "did we run a hook?" heuristic
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - receive-pack: convert 'update' hook to hook.h
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - reference-transaction: use hook.h to run hooks
>  - transport: convert pre-push hook to use config
>  - hook: convert 'post-rewrite' hook in sequencer.c to hook.h
>  - hook: provide stdin by string_list or callback
>  - run-command: add stdin callback for parallelization
>  - am: convert 'post-rewrite' hook to hook.h
>  - hook: support passing stdin to hooks
>  - run-command: allow stdin for run_processes_parallel
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change hook to use config
>  - commit: use hook.h to execute hooks
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - merge: use config-based hooks for post-merge hook
>  - hooks: convert 'post-checkout' hook to hook library
>  - am: convert applypatch hooks to use config
>  - rebase: teach pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook

For this one I'd submitted these independently as

>  - hook: add 'run' subcommand
>  - hook-list.h: add a generated list of hooks, like config-list.h
>  - hook.c: add a hook_exists() wrapper and use it in bugreport.c
>  - hook.[ch]: move find_hook() to this new library

https://lore.kernel.org/git/cover-0.3-0000000000-20210629T183325Z-avarab@gm=
ail.com/

(Ren=C3=A9 had a comment about his SOB on a patch there, but I see you
addressed it while queuing it (changed to Helped-by))

And:

>  - Makefile: remove an out-of-date comment
>  - Makefile: stop hardcoding {command,config}-list.h
>  - Makefile: mark "check" target as .PHONY

https://lore.kernel.org/git/cover-0.3-0000000000-20210629T190137Z-avarab@gm=
ail.com/

But you re-combined them. If it makes things easier for you I'm all for
it, but it seems better to me keep them split if that mean that some
parts can advance faster, and thus make the rest easier to review.

>  Restructuring of (a subset of) Emily's config-based-hooks series,
>  to demonstrate that a series can be presented as a more logical and
>  focused progression.
>
>  Waiting for reviews.

I think it's mainly waiting on Emily giving it a detailed look, per
https://lore.kernel.org/git/YNEoMZ1QhZwmS0v2@google.com/

>
> * ab/config-hooks-path-testfix (2021-06-16) 1 commit
>  - pre-commit hook tests: don't leave "actual" nonexisting on failure
>
>  Test fix.
>
>  Will merge to 'next'.
>
>
> * ab/doc-retire-alice-bob (2021-06-16) 6 commits
>  - pack-protocol doc: use "www-data" in place of "alice"
>  - doc: replace "alice" and "bob" with "jdoe" and "msmith"
>  - fast-import doc: change "bob" in an example to "file.txt"
>  - daemon doc + code comments: reword "alice" example
>  - gitcvs-migration doc: replace "alice" and "bob" with "you" and "www-da=
ta"
>  - gittutorial doc: replace "alice" and "bob" with "you" and "www-data"

Having re-read the discussion now I don't know if there's anything
outstanding to change about this series. It's gotten a lot of attention
so far, so it's more of a matter of if you're willing to take this sort
of documentation change or not.

> * ab/serve-cleanup (2021-06-28) 8 commits
>  - upload-pack.c: convert to new serve.c "startup" config cb
>  - serve: add support for a "startup" git_config() callback
>  - serve.c: add trace2 regions for advertise & command
>  - serve.c: add call_{advertise,command}() indirection
>  - serve: use designated initializers
>  - transport: use designated initializers
>  - transport: rename "fetch" in transport_vtable to "fetch_refs"
>  - serve: mark has_capability() as static
>
>  Code clean-up around "git serve".

Jeff, what do you think about this version & the upload-pack.c changes?

> * ab/mktag-tests (2021-06-28) 6 commits
>  - mktag tests: test fast-export
>  - mktag tests: test for-each-ref
>  - mktag tests: test update-ref and reachable fsck
>  - mktag tests: test hash-object --literally and unreachable fsck
>  - mktag tests: invert --no-strict test
>  - mktag tests: parse out options in helper
>
>  Fill test gaps.
>
>
> * ab/show-branch-tests (2021-06-28) 4 commits
>  - show-branch tests: add missing tests
>  - show-branch: don't <COLOR></RESET> for space characters
>  - show-branch tests: modernize test code
>  - show-branch tests: rename the one "show-branch" test file
>
>  Fill test gaps.

I think both of these are ready for next.

The mktag one had trivial improvement suggestions I've addressed in a
re-roll already. Felipe gave v2 of ab/show-branch-tests a review here:
https://lore.kernel.org/git/60cbbe9d89cbd_1299208fa@natae.notmuch/

I'm partial to just keeping it as-is, I think in 2/4 it's OK to fix
various test modernization issues at once & they don't need to be split
up into more commits, it's easy enough to follow along with it. What do
you think?

> * ab/cmd-foo-should-return (2021-06-09) 1 commit
>  - builtins + test helpers: use return instead of exit() in cmd_*
>
>  Code clean-up.
>
>  Will merge to 'next'.
>
>
> * ab/progress-cleanup (2021-06-08) 1 commit
>  - read-cache.c: don't guard calls to progress.c API
>
>  Code clean-up.
>
>  Will merge to 'next'.

Thanks!

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Waiting for reviews.

Emily gave this a review, waiting on her reply to my reply at
https://lore.kernel.org/git/87pmw3dlkl.fsf@evledraar.gmail.com/

I.e. whether the outstanding is to merely clarify more in commit
messages that the goal is to split up a doing-to-many-things function,
not to optimize an existing perf test.

> * ab/xdiff-bug-cleanup (2021-06-08) 1 commit
>  - xdiff: use BUG(...), not xdl_bug(...)
>
>  Code clean-up.
>
>  Will merge to 'next'.

Thanks!

> * ab/pack-objects-stdin (2021-06-28) 4 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Code clean-up.

Emily & Jonathan Tan gave the version preceding this one a detailed
once-over, my re-roll addressed their concerns, but it would be good to
hear if they agree with that assessment.

> * ab/update-submitting-patches (2021-06-08) 3 commits
>  - SubmittingPatches: remove pine-specific hints from MUA hints
>  - SubmittingPatches: replace discussion of Travis with GitHub Actions
>  - SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Expecting a reroll.
>  cf. <20210607172542.GA6312@szeder.dev>
>  cf. <nycvar.QRO.7.76.6.2106072346560.55@tvgsbejvaqbjf.bet>

Will try to re-roll sooner than later...

> * ab/send-email-optim (2021-05-28) 13 commits
>  - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
>  - send-email: move trivial config handling to Perl
>  - perl: lazily load some common Git.pm setup code
>  - send-email: lazily load modules for a big speedup
>  - send-email: get rid of indirect object syntax
>  - send-email: use function syntax instead of barewords
>  - send-email: lazily shell out to "git var"
>  - send-email: lazily load config for a big speedup
>  - send-email: copy "config_regxp" into git-send-email.perl
>  - send-email: refactor sendemail.smtpencryption config parsing
>  - send-email: remove non-working support for "sendemail.smtpssl"
>  - send-email tests: test for boolean variables without a value
>  - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=3Dtrue
>
>  "git send-email" optimization.
>
>  Will merge to 'next'.

Thanks!

> * ab/fsck-unexpected-type (2021-06-28) 21 commits
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

There's one trivial comment on the v4, will re-roll as a v5:
https://lore.kernel.org/git/87mtrezya9.fsf@evledraar.gmail.com/

I think this should be ready to move to 'next', but it would be good to
get other eyes on the mid-series changes I made in v4:
https://lore.kernel.org/git/cover-00.21-00000000000-20210624T191754Z-avarab=
@gmail.com/
