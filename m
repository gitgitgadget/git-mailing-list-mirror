Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FC9C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 09:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B125C6127A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 09:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhG0JYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhG0JYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 05:24:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE9C061760
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 02:24:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x14so9651375edr.12
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UCupxsnkV7MAmuj4/QuY5W7AqV+qePkvrZn+j1rwtlY=;
        b=BAn6ytVvn4ELMQrZqKym8WMoo0PEMMT1GKJS6eQijFaGpJibpY3YVCZd0ykgQgGgVP
         IABlCHFxDqZxIkJ1fKI/+f6URAISjdbOunhfmHdpKHyyocc8gEFvidpSSiloEggLxt+z
         nuED3ShpcD/hQaFL3+7ev4nGDxCF9ZxfMIezEtSg6SnlBIGk+8OELq913fz+VEmkHle9
         YTTFy9Ebd+5hP0WKZ62bGiVQYsD4jE8NAKzD6Dn1t+LbIpk7d8XIbkBFJGeStWmOXW1O
         t7ZFpnWYd0hXyrKHKzIXw/Zr26VcxGdEAjfJh9i28G68mDwaB/rlapKfY7t7vZZviAqg
         OlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UCupxsnkV7MAmuj4/QuY5W7AqV+qePkvrZn+j1rwtlY=;
        b=rwUr/lTzOFJzB74iWVZTHHwkF0/dv/GguiuI+qUSuHrFVMaB3U74kbIYm+fQ90TItG
         hho5hcAcWfOsT1Va1jnaAsJph1vG+8e8w39G2HRXZFAhHW/h+XIQGOeF08D2CTZ/km0t
         Kq07+UHsVbssL8wQPJZC2ElGm/vpyws/63QZ6gFQrL89z9cnZvt8bVbiJbXiPvTWRIeH
         URM8SEurDiF3G6lSIIT8XAMDsEaZwUWFBnt6akd5Kp0zP7EyPikRPIqrpyydNn35f9VP
         aNRsI8T+17ea0K+ENfjN+78pF9fJiSHIxEvUBKNWRpTdwTtYAcQhBeAO7TNSAbfavrP9
         Tycw==
X-Gm-Message-State: AOAM532J+nEw/Sr4pW68IIU66Xs/9NS0dfEmKd0N8SX65r3HmiTWi2i9
        cR33uc1akNxMb0r/A19sPN4=
X-Google-Smtp-Source: ABdhPJw5++0/7uvLHtlU3xbRoGM9bX5EacHRxGgr7+zuvGGdKUvxqk7U+fmeX8cYdMxNgYRNiADkfQ==
X-Received: by 2002:a05:6402:1768:: with SMTP id da8mr26502862edb.43.1627377868484;
        Tue, 27 Jul 2021 02:24:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t15sm680258ejf.119.2021.07.27.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:24:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: What's cooking in git.git (Jul 2021, #06; Mon, 26)
Date:   Tue, 27 Jul 2021 10:36:08 +0200
References: <xmqq35s0fj9o.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq35s0fj9o.fsf@gitster.g>
Message-ID: <87sg00qfbp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 26 2021, Junio C Hamano wrote:

> Here are the topics that have been cooking in my tree.

[As usual, updates on my/other topics]

> * ab/http-drop-old-curl (2021-07-21) 5 commits
>  - http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
>  - http: drop support for curl < 7.19.3 and < 7.16.4 (again)
>  - http: drop support for curl < 7.19.4
>  - http: drop support for curl < 7.16.0
>  - http: drop support for curl < 7.11.1
>
>  Support for ancient versions of cURL library has been dropped.
>
>  Expecting a hopefully final reroll to correct log messages.

Will re-roll, just had to re-read that discussion...

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
>  (this branch uses jk/t0000-subtests-fix and ps/t0000-output-directory-fix.)
>
>  Updates to the tests in t0000 to test th etest framework.

Thanks, SZEDER: I've got some fixes to make --verbose-log even more
awesome waiting on this, i.e. you can supply -V, -VV etc. for different
verbosity levels on stdout, while getting the full log in the log
file. Maybe you're interested in eyeballing it ?:)

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

SZEDER: Ditto a review request. Addresses one big issue your
https://lore.kernel.org/git/20210623215736.8279-1-szeder.dev@gmail.com/
had a test-only assertion for.

I've got other progress updates queued on top of this locally, including
more bug fixes, better output etc.

My not-nearly-there-yet end goal is:

 * "Stalled" progress output if we have a progress bar but no
   display_progress() calls.

 * Ditto showing a "spinner"

 * Prettier progress, outright stealing some UI from various other prior
   work, e.g. https://www.npmjs.com/package/cli-progress &
   https://www.npmjs.com/package/cli-spinners &
   https://github.com/sindresorhus/cli-spinners/blob/main/spinners.json

 * Ability to show N progress bars at the same time, e.g. when
   downloading 3x files in parallel:

     Downloading: 1: 25%; N sec left; 2: 10%; N sec left; ....

   The UI not being representative, but the idea being you can have N
   fields updating at a time. Helps with parallel downloads, "git fetch
   --jobs=10 --all" etc.


> * ab/progress-users-adjust-counters (2021-07-23) 3 commits
>  - entry: show finer-grained counter in "Filtering content" progress line
>  - midx: don't provide a total for QSORT() progress
>  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
>
>  The code to show progress indicator in a few codepaths did not
>  cover between 0-100%, which has been corrected.
>
>  Will merge to 'next'.

Thanks. Do you think a re-roll is needed for what you mentioned in
https://lore.kernel.org/git/xmqqbl6slmer.fsf@gitster.g/?

It's SZEDER'S code, but I think you're right there.

More generally I tried splitting up the progress API into simpler and
more complex cases, I like that WIP version I have locally, basically
1/3 to 1/2 of all our progress can be moved to this API:

    progress = start_progress(....)
    increment_progress(&progress);
    stop_progress(&progress)

I.e. replacing display_progress(&progress, i + 1) with just an
increment_progress().

I.e. the API now covers at least these cases:

 1. We have 100 items, do one at a time, and we always do all items (the
    increment_progress() case). We have no gaps, so 1, 2, 3 ....

 2. Ditto, but maybe we only reach 90 or whatever, but "snap to" 100 at
    the end (not common, I think 1-3 cases).

 3. We have an accurate target number, but there's gaps, e.g. iterating
    over objects/??, we have 256 max, but we won't count all 256. Maybe
    another 1-5 cases of this.

 4. We have an ~accurate target number, but e.g. due to concurrent FS
    action it might slip. The progress code needs to cope with this (we
    can't BUG() out because our estimate based on a readdir() isn't true
    anymore).

 5. We don't provide a target number because doing so requires two
    loops, some of these should not have a target number, but for others
    it's so cheap to do the target number (the actual work is expensive)
    that we could improve the UI with two loops.

 6. Messier long tail: We want progress, but have no idea how many
    (e.g. the initial counting objects), some of these could have UI
    improvements with a fuzzy target estimate,

> * ab/bundle-tests (2021-07-22) 2 commits
>   (merged to 'next' on 2021-07-22 at 053b5d0ecf)
>  + bundle tests: use test_cmp instead of grep
>  + bundle tests: use ">file" not ": >file"
>
>  "git bundle" gained more test coverage.
>
>  Will merge to 'master'.

Thanks!

> * ab/refs-files-cleanup (2021-07-26) 11 commits
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
>  Patches are mostly good, but needs typofixes etc.
>
>  Will merge to 'next'.

Great, thanks!

> * ab/attribute-format (2021-07-13) 5 commits
> * ab/pkt-line-tests (2021-07-19) 1 commit
> [...]
>  Will merge to 'master'.

Also yay! :)

> * ab/bundle-doc (2021-07-20) 3 commits
>  - bundle doc: elaborate on rev<->ref restriction
>  - bundle doc: elaborate on object prerequisites
>  - bundle doc: rewrite the "DESCRIPTION" section
>
>  Doc update.
>
>  Expecting a reroll.
>  at least for the second patch.

I've got a re-roll at
https://lore.kernel.org/git/cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com/
which presumably raced with this What's Cooking / you being busy with
other things. Should address your & Philip Oakley's comments.

> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>  - pack-objects: fix segfault in --stdin-packs option
>  - pack-objects tests: cover blindspots in stdin handling
>
>  Input validation of "git pack-objects --stdin-packs" has been
>  corrected.
>
>  Ack?
>  cf. <YND3h2l10PlnSNGJ@nand.local>

Downthread of that is (by my reading) an ack from Taylor:
https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/

> * ab/make-tags-cleanup (2021-07-22) 5 commits
>  - Makefile: normalize clobbering & xargs for tags targets
>  - Makefile: the "cscope" target always creates a "cscope.out"
>  - Makefile: don't use "FORCE" for tags targets
>  - Makefile: add QUIET_GEN to "cscope" target
>  - Makefile: move ".PHONY: cscope" near its target
>
>  Build clean-up for "make tags" and friends.
>
>  Will merge to 'next'?
>  4/5 may want a minor tweak to the log and the patch text but otherwise looks good.

I think it's fine as-is per
https://lore.kernel.org/git/87k0lit57x.fsf@evledraar.gmail.com/

But I don't feel strongly about it, so if you say "nah" I'll re-roll it
and keep that glob "rm".

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
>  - hook: add 'run' subcommand
>  - hook-list.h: add a generated list of hooks, like config-list.h
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

I'll stop trying to prod you to split this one up:
https://lore.kernel.org/git/87a6mevkrx.fsf@evledraar.gmail.com/ except I
think I'm probably doing that again now, anyway, last time. I promise :)

Anyway, I was hoping Emily would have some time to review this in-depth
before a re-roll, but since it's been over a month I'll just send a
re-roll with small trivial tweaks I've got locally (commit message fixes
and the like, mostly).

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
>
>  Expecting a reroll.
>  cf. <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
>  cf. <87tul24iw2.fsf@evledraar.gmail.com>

Re-rolled at
https://lore.kernel.org/git/cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com/

> * ab/test-tool-cache-cleanup (2021-06-08) 4 commits
>  - read-cache perf: add a perf test for refresh_index()
>  - test-tool: migrate read-cache-again to parse_options()
>  - test-tool: migrate read-cache-perf to parse_options()
>  - test-tool: split up test-tool read-cache
>
>  Test code shuffling.
>
>  Waiting for reviews.

Ditto waiting on Emily & timing out, will re-roll with clarifications
per my https://lore.kernel.org/git/87pmw3dlkl.fsf@evledraar.gmail.com/

> * ab/pack-objects-stdin (2021-07-09) 5 commits
>  - pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
>  - pack-objects.c: do stdin parsing via revision.c's API
>  - revision.[ch]: add a "handle_stdin_line" API
>  - revision.h: refactor "disable_stdin" and "read_from_stdin"
>  - upload-pack: run is_repository_shallow() before setup_revisions()
>
>  Introduce handle_stdin_line callback to revision API and uses it.

Re-rolled for conflicts with master yesterday:
https://lore.kernel.org/git/cover-0.5-00000000000-20210726T124425Z-avarab@gmail.com/

As noted in
https://lore.kernel.org/git/cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com/
I've got some new useful features for "git bundle" waiting on it, it
would be great to have it merged down for submitting that follow-up
work.


> * ab/update-submitting-patches (2021-07-22) 2 commits
>  - SubmittingPatches: replace discussion of Travis with GitHub Actions
>  - SubmittingPatches: move discussion of Signed-off-by above "send"
>
>  Reorganize and update the SubmitingPatches document.
>
>  Will merge to 'next'.

Thanks. Perhaps Johannes wants to pick up the peeled-off Pine patch per
my comments on the re-roll.

> * jh/builtin-fsmonitor (2021-07-12) 35 commits
>  - BANDAID: sparse fixes
>  - t7527: test FS event reporing on MacOS WRT case and Unicode
>  - fsmonitor: handle shortname for .git
>  - t7527: test status with untracked-cache and fsmonitor--daemon
>  - fsmonitor: force update index after large responses
>  - fsmonitor: enhance existing comments
>  - fsmonitor--daemon: use a cookie file to sync with file system
>  - fsmonitor--daemon: periodically truncate list of modified files
>  - t7527: create test for fsmonitor--daemon
>  - t/perf/p7519: add fsmonitor--daemon test cases
>  - t/perf: avoid copying builtin fsmonitor files into test repo
>  - t/perf/p7519: speed up test using "test-tool touch"
>  - t/helper/test-touch: add helper to touch a series of files
>  - fsmonitor--daemon: implement handle_client callback
>  - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>  - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>  - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>  - fsmonitor--daemon: create token-based changed path cache
>  - fsmonitor--daemon: define token-ids
>  - fsmonitor--daemon: add pathname classification
>  - fsmonitor: do not try to operate on bare repos
>  - fsmonitor--daemon: implement 'start' command
>  - fsmonitor--daemon: implement 'run' command
>  - fsmonitor-fs-listen-macos: stub in backend for MacOS
>  - fsmonitor-fs-listen-win32: stub in backend for Windows
>  - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>  - fsmonitor--daemon: implement 'stop' and 'status' commands
>  - fsmonitor--daemon: add a built-in fsmonitor daemon
>  - fsmonitor: use IPC to query the builtin FSMonitor daemon
>  - fsmonitor: config settings are repository-specific
>  - help: include fsmonitor--daemon feature flag in version info
>  - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>  - fsmonitor--daemon: update fsmonitor documentation
>  - fsmonitor--daemon: man page
>  - simple-ipc: preparations for supporting binary messages.
>
>  An attempt to write and ship with a watchman equivalent tailored
>  for our use.
>
>  So, where are we with this topic?

The review for this mostly got somewhere between bogged-down in minutia
(of which I take some/most of the blame) and somewhat hostile, per
your/my:

    https://lore.kernel.org/git/xmqqr1fkfyh3.fsf@gitster.g/
    https://lore.kernel.org/git/87r1fsvhcr.fsf@evledraar.gmail.com/

As mentioned in the latter E-Mail I did have some questions about the
fundimental approach/assumptions/perf numbers motivating the topic in:

    https://lore.kernel.org/git/871r8c73ej.fsf@evledraar.gmail.com/

I don't think it should be blocked on that, but would really prefer to
pick the brain of the people involved in it while it's fresh in
everyone's mind rather than doing archaeology later.

E.g. I think an obvious thing to build on top of this would be to make
the new built-in support talking to watchman directly over its network
protocol, we'd thus have a good end-to-end test-case for any behavior
differences in the current hook v.s. built-in (knowing they have the
same backend), as well as a check & alternative for whatever bugs we
have in our own inotify-ish interfaces v.s. watchman's more
production-tested code.

Except that per my above one or both of Ben Peart and Jeff Hostetler
seem to have run into some problem where that approach is (according to
them) fundamentally unsound in some cases (or only on Windows?), but I
don't know if that's true yet, and if it is what those cases are.

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

I think the v3 of this got a detailed reviwew, and the v3->v4 delta
wasn't that big (although one commit in particular is a bit tricky):

    https://lore.kernel.org/git/cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com/

I.e. it's just this part being substantially different from v3:

    https://lore.kernel.org/git/patch-12.21-3f52149bfde-20210624T191755Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-13.21-ba632be1520-20210624T191755Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-14.21-ea4f446f5b1-20210624T191755Z-avarab@gmail.com/

So if you/anyone else could review that it would be great to get this
moving. I've got some more fsck/object reliability & reporting
improvements coming, but so far it's slow going...

(The v4->v5 delta on that topic is trivial & obviously correct (just
s/test_create/repo/git init --bare/g in tests places)).

    https://lore.kernel.org/git/cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com/

