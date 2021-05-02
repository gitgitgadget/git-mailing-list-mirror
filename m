Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8474C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 12:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A06C611AC
	for <git@archiver.kernel.org>; Sun,  2 May 2021 12:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhEBMBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 08:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhEBMBI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 08:01:08 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8EC06174A
        for <git@vger.kernel.org>; Sun,  2 May 2021 05:00:16 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j20so1869268ilo.10
        for <git@vger.kernel.org>; Sun, 02 May 2021 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixM/FFr8G/bzAkeCdQt/zA4DKAbdzd0DhaMDIC2064k=;
        b=fT4yEncmWaC4Dx3ftUBvG3eGD5IRjJQmUH5VZBlL0Qt5CiagKo344Q0VAdqPC/jN66
         549DNA9rb8AnDCI5jmIdzi3ux++3JPzVgVZcZhDnENlkaofeCJs9kChsjc0HNuA9RebX
         oqaFmHXdst2YgaZIdV222dcD37DvzX6l0zpl/9ws934EFGAs/rf9OH5OzioFjMGmWGiu
         tTfXSs/5Rvck7HJqnZY7ob/YFx/qUG9BXdMWfG4VdE0+KQ79OHz3cfwa4HHrKUrgx2Wp
         f2EQmmSy4kSBs6ZeWxaN8Ha1oDOqNfZSlAvatZVr9YnuH/3LCTsXt5/v/jhLgppgdDue
         LLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixM/FFr8G/bzAkeCdQt/zA4DKAbdzd0DhaMDIC2064k=;
        b=NA6F+MGLfSM2Aj3g6ZFV+AOYBtNE2tR5txuPgJ1VjfWoMDZBy9kKFQ6rdaRCwb6siA
         OZJXSAX0GRKS5VBicz2dQgC4hk0NT8IotQs1wC75/2C24Tq47+gMhJra0UbEmUmSZw+7
         RCVZQpD+bFTkkciY4Jhm6pnKax7lVwg/e53noo1medJLz/k2L3kLhAiu/dgqFXwy0Gip
         hcWSMcuzcVBXnHyPtWjDGQfN9TFm1FqHzZOr54KIAaLZVgiZ/qprwJMwo+t8YAu4mRCY
         rBmLEMIn3fVzxDNG103Z6fuQHcgHI1mFGpYQORL7BCrQ90h2SxZY8NoJVCNz0Vz2uAmx
         oMSg==
X-Gm-Message-State: AOAM532FsmyR0EVArokvUf5c2ghOB1fzTSj7Jm0GvVnvRLBUyo/qyexK
        EC8DFlVZo8WcdH+T53vpwWPkOH7euW29LseMSkw=
X-Google-Smtp-Source: ABdhPJwPUWXbPfJzVGIMP+6uQqE4rqXWQSJDrl/HHssASchZVmRAEXWEplDkVkZxNOS8lFe5Lns7x/z7XQnklx7Ow+c=
X-Received: by 2002:a92:c20e:: with SMTP id j14mr2139080ilo.259.1619956815813;
 Sun, 02 May 2021 05:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqr1itfo41.fsf@gitster.g>
In-Reply-To: <xmqqr1itfo41.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 2 May 2021 20:00:02 +0800
Message-ID: <CAOLTT8TWLUCOnL=s-SgCaJYbOw7YCyX5WNssZw5HCspaSAoxmw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio,

> * zh/pretty-date-human (2021-04-27) 1 commit
>  - pretty: provide human date format
>  (this branch uses ab/pretty-date-format-tests.)
>
>  "git log --format=..." placeholders learned %ah/%ch placeholders to
>  request the --date=human output.
>
>  Will merge to 'next'?
>

Here is a small typo error, I forget a small blank, which was pointed
out by Josh
Soref in https://github.com/gitgitgadget/git/pull/939

- '%ch':: committer date, human style(like the `--date=human` option of
+ '%ch':: committer date, human style (like the `--date=human` option of


> --------------------------------------------------
> [Stalled]
>
> * jh/rfc-builtin-fsmonitor (2021-04-08) 23 commits
>  - t7527: test status with untracked-cache and fsmonitor--daemon
>  - p7519: add fsmonitor--daemon
>  - t7527: create test for fsmonitor--daemon
>  - fsmonitor: force update index when fsmonitor token advances
>  - fsmonitor--daemon: use a cookie file to sync with file system
>  - fsmonitor--daemon:: introduce client delay for testing
>  - fsmonitor--daemon: periodically truncate list of modified files
>  - fsmonitor--daemon: implement handle_client callback
>  - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>  - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>  - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>  - fsmonitor--daemon: create token-based changed path cache
>  - fsmonitor--daemon: define token-ids
>  - fsmonitor--daemon: add pathname classification
>  - fsmonitor--daemon: implement daemon command options
>  - fsmonitor-fs-listen-macos: stub in backend for MacOS
>  - fsmonitor-fs-listen-win32: stub in backend for Windows
>  - fsmonitor--daemon: implement client command options
>  - fsmonitor--daemon: add a built-in fsmonitor daemon
>  - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
>  - config: FSMonitor is repository-specific
>  - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>  - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
>
>  An attempt to write and ship with a watchman equivalent tailored
>  for our use.
>
>
> * ag/merge-strategies-in-c (2021-03-17) 15 commits
>  - sequencer: use the "octopus" merge strategy without forking
>  - sequencer: use the "resolve" strategy without forking
>  - merge: use the "octopus" strategy without forking
>  - merge: use the "resolve" strategy without forking
>  - merge-octopus: rewrite in C
>  - merge-recursive: move better_branch_name() to merge.c
>  - merge-resolve: rewrite in C
>  - merge-one-file: rewrite in C
>  - update-index: move add_cacheinfo() to read-cache.c
>  - merge-index: add a new way to invoke `git-merge-one-file'
>  - merge-index: drop the index
>  - merge-index: libify merge_one_path() and merge_all()
>  - t6060: add tests for removed files
>  - t6060: modify multiple files to expose a possible issue with merge-index
>  - t6407: modernise tests
>
>  The resolve and octopus merge strategy backends have been rewritten
>  in C.
>
>  Expecting a (hopefully final) reroll.
>  cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>
>
>
> * ab/describe-tests-fix (2021-04-29) 5 commits
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: don't rely on err.actual from "check_describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>  (this branch uses ab/test-lib-updates.)
>
>  Various updates to tests around "git describe"
>
>
> * ab/pickaxe-pcre2 (2021-04-29) 22 commits
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
>  (this branch uses ab/test-lib-updates.)
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.
>
>
> * es/config-hooks (2021-03-10) 36 commits
>  . run-command: stop thinking about hooks
>  . git-send-email: use 'git hook run' for 'sendemail-validate'
>  . bugreport: use hook_exists instead of find_hook
>  . receive-pack: convert receive hooks to hook.h
>  . post-update: use hook.h library
>  . proc-receive: acquire hook list from hook.h
>  . receive-pack: convert 'update' hook to hook.h
>  . reference-transaction: look for hooks in config
>  . transport: convert pre-push hook to use config
>  . hook: convert 'post-rewrite' hook to config
>  . hooks: convert 'post-checkout' hook to hook library
>  . git-p4: use 'git hook' to run hooks
>  . receive-pack: convert push-to-checkout hook to hook.h
>  . read-cache: convert post-index-change hook to use config
>  . rebase: teach pre-rebase to use hook.h
>  . gc: use hook library for pre-auto-gc hook
>  . merge: use config-based hooks for post-merge hook
>  . am: convert applypatch hooks to use config
>  . commit: use config-based hooks
>  . hooks: allow callers to capture output
>  . run-command: allow capturing of collated output
>  . hook: provide stdin by string_list or callback
>  . run-command: add stdin callback for parallelization
>  . hook: allow specifying working directory for hooks
>  . hook: allow parallel hook execution
>  . run-command: allow stdin for run_processes_parallel
>  . hook: support passing stdin to hooks
>  . hook: introduce hook_exists()
>  . hook: add 'run' subcommand
>  . parse-options: parse into strvec
>  . hook: implement hookcmd.<name>.skip
>  . hook: teach hook.runHookDir
>  . hook: include hookdir hook in list
>  . hook: add list command
>  . hook: scaffolding for git-hook subcommand
>  . doc: propose hooks managed by the config
>
>  The "hooks defined in config" topic.
>
> --------------------------------------------------
> [Cooking]
>
> * dl/complete-stash (2021-03-24) 3 commits
>   (merged to 'next' on 2021-03-24 at ce573a99cc)
>  + git-completion.bash: use __gitcomp_builtin() in _git_stash()
>  + git-completion.bash: extract from else in _git_stash()
>  + git-completion.bash: pass $__git_subcommand_idx from __git_main()
>  (this branch is used by dl/complete-stash-updates.)
>
>  The command line completion (in contrib/) for "git stash" has been
>  updated.
>
>  Wait until dl/complete-stash-updates matures.
>
>
> * ba/object-info (2021-04-20) 1 commit
>  - object-info: support for retrieving object info
>
>  Over-the-wire protocol learns a new request type to ask for object
>  sizes given a list of object names.
>
>
> * zh/format-ref-array-optim (2021-04-20) 2 commits
>  - ref-filter: reuse output buffer
>  - ref-filter: get rid of show_ref_array_item
>
>  "git (branch|tag) --format=..." has been micro-optimized.
>
>  Will merge to 'next'?
>
>
> * vs/completion-with-set-u (2021-04-16) 1 commit
>   (merged to 'next' on 2021-04-20 at 179933f961)
>  + completion: avoid aliased command lookup error in nounset mode
>
>  Effort to make the command line completion (in contrib/) safe with
>  "set -u" continues.
>
>  Will merge to 'master'.
>
>
> * hn/prep-tests-for-reftable (2021-04-28) 21 commits
>  - t1415: set REFFILES for test specific to storage format
>  - t4202: mark bogus head hash test with REFFILES
>  - t7003: check reflog existence only for REFFILES
>  - t7900: mark pack-refs tests as REFFILES
>  - t1404: mark tests that muck with .git directly as REFFILES.
>  - t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
>  - t1414: mark corruption test with REFFILES
>  - t1407: require REFFILES for for_each_reflog test
>  - test-lib: provide test prereq REFFILES
>  - t5304: use "reflog expire --all" to clear the reflog
>  - t5304: restyle: trim empty lines, drop ':' before >
>  - t7003: use rev-parse rather than FS inspection
>  - t5000: inspect HEAD using git-rev-parse
>  - t5000: reformat indentation to the latest fashion
>  - t1301: fix typo in error message
>  - t1413: use tar to save and restore entire .git directory
>  - t1401-symbolic-ref: avoid direct filesystem access
>  - t5601: read HEAD using rev-parse
>  - t9300: check ref existence using test-helper rather than a file system check
>  - t/helper/ref-store: initialize oid in resolve-ref
>  - t4202: split testcase for invalid HEAD symref and HEAD hash
>
>  Preliminary clean-up of tests before the main reftable changes
>  hits the codebase.
>
>
> * ps/config-env-option-with-separate-value (2021-04-19) 2 commits
>  - git: support separate arg for `--config-env`'s value
>  - git.txt: fix synopsis of `--config-env` missing the equals sign
>
>  "git --config-env var=val cmd" weren't accepted (only
>  --config-env=var=val was).
>
>  Will merge to 'next'.
>  possibly with minimum fix-up?
>  cf. <YIKcZxEDsG7qsE4G@coredump.intra.peff.net>
>
>
> * ab/fsck-unexpected-type (2021-04-13) 6 commits
>  - fsck: report invalid object type-path combinations
>  - fsck: report invalid types recorded in objects
>  - object-store.h: move read_loose_object() below 'struct object_info'
>  - fsck: don't hard die on invalid object types
>  - fsck tests: refactor one test to use a sub-repo
>  - cache.h: move object functions to object-store.h
>
>  "git fsck" has been taught to report mismatch between expected and
>  actual types of an object better.
>
>  Expecting a reroll.
>
>
> * jk/promisor-optim (2021-04-13) 3 commits
>   (merged to 'next' on 2021-04-15 at 41f303ef9b)
>  + revision: avoid parsing with --exclude-promisor-objects
>  + lookup_unknown_object(): take a repository argument
>  + is_promisor_object(): free tree buffer after parsing
>  (this branch is used by rs/repack-without-loosening-promised-objects.)
>
>  Handling of "promisor packs" that allows certain objects to be
>  missing and lazily retrievable has been optimized (a bit).
>
>  Will merge to 'master'.
>
>
> * so/log-diff-merge (2021-04-16) 5 commits
>   (merged to 'next' on 2021-04-17 at 6c1eba8ee3)
>  + doc/diff-options: document new --diff-merges features
>  + diff-merges: introduce log.diffMerges config variable
>  + diff-merges: adapt -m to enable default diff format
>  + diff-merges: refactor set_diff_merges()
>  + diff-merges: introduce --diff-merges=on
>
>  "git log" learned "--diff-merges=<style>" option, with an
>  associated configuration variable log.diffMerges.
>
>  Will merge to 'master'.
>
>
> * rs/repack-without-loosening-promised-objects (2021-04-28) 1 commit
>  - repack: avoid loosening promisor objects in partial clones
>  (this branch uses jk/promisor-optim.)
>
>  "git repack -A -d" in a partial clone unnecessarily loosened
>  objects in promisor pack.
>
>
> * mt/pkt-write-errors (2021-04-15) 1 commit
>   (merged to 'next' on 2021-04-16 at 4a82d89ff3)
>  + pkt-line: do not report packet write errors twice
>
>  When packet_write() fails, we gave an extra error message
>  unnecessarily, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * ow/push-quiet-set-upstream (2021-04-15) 1 commit
>   (merged to 'next' on 2021-04-16 at 9466d4ef38)
>  + transport: respect verbosity when setting upstream
>
>  "git push --quiet --set-upstream" was not quiet when setting the
>  upstream branch configuration, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * jt/push-negotiation (2021-04-08) 6 commits
>  - send-pack: support push negotiation
>  - fetch: teach independent negotiation (no packfile)
>  - fetch-pack: refactor command and capability write
>  - fetch-pack: refactor add_haves()
>  - fetch-pack: refactor process_acks()
>  - Merge branch 'jt/fetch-pack-request-fix' into jt/push-negotiation
>
>  "git push" learns to discover common ancestor with the receiving
>  end over protocol v2.
>
>
> * ab/doc-lint (2021-04-10) 7 commits
>  - docs: fix linting issues due to incorrect relative section order
>  - doc lint: lint relative section order
>  - doc lint: lint and fix missing "GIT" end sections
>  - doc lint: fix bugs in, simplify and improve lint script
>  - doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
>  - Documentation/Makefile: make doc.dep dependencies a variable again
>  - Documentation/Makefile: make $(wildcard howto/*.txt) a var
>
>  Dev support.
>
>  Will merge to 'next'.
>
>
> * ab/rebase-no-reschedule-failed-exec (2021-04-10) 2 commits
>  - rebase: don't override --no-reschedule-failed-exec with config
>  - rebase tests: camel-case rebase.rescheduleFailedExec consistently
>
>  "git rebase --[no-]reschedule-failed-exec" did not work well with
>  its configuration variable, which has been corrected.
>
>  Will merge to 'next'.
>
>
> * ah/plugleaks (2021-04-28) 12 commits
>  - builtin/rm: avoid leaking pathspec and seen
>  - builtin/rebase: release git_format_patch_opt too
>  - builtin/for-each-ref: free filter and UNLEAK sorting.
>  - mailinfo: also free strbuf lists when clearing mailinfo
>  - builtin/checkout: clear pending objects after diffing
>  - builtin/check-ignore: clear_pathspec before returning
>  - builtin/bugreport: don't leak prefixed filename
>  - branch: FREE_AND_NULL instead of NULL'ing real_ref
>  - bloom: clear each bloom_key after use
>  - ls-files: free max_prefix when done
>  - wt-status: fix multiple small leaks
>  - revision: free remainder of old commit list in limit_list
>
>  Plug various leans reported by LSAN.
>
>  Will merge to 'next'?
>
>
> * bc/hash-transition-interop-part-1 (2021-04-27) 13 commits
>  - hex: print objects using the hash algorithm member
>  - hex: default to the_hash_algo on zero algorithm value
>  - builtin/pack-objects: avoid using struct object_id for pack hash
>  - commit-graph: don't store file hashes as struct object_id
>  - builtin/show-index: set the algorithm for object IDs
>  - hash: provide per-algorithm null OIDs
>  - hash: set, copy, and use algo field in struct object_id
>  - builtin/pack-redundant: avoid casting buffers to struct object_id
>  - Use the final_oid_fn to finalize hashing of object IDs
>  - hash: add a function to finalize object IDs
>  - http-push: set algorithm when reading object ID
>  - Always use oidread to read into struct object_id
>  - hash: add an algo member to struct object_id
>
>  SHA-256 transition.
>
>  Will merge to 'next'?
>
>
> * ps/rev-list-object-type-filter (2021-04-19) 8 commits
>  - rev-list: allow filtering of provided items
>  - pack-bitmap: implement combined filter
>  - pack-bitmap: implement object type filter
>  - list-objects: implement object type filter
>  - list-objects: support filtering by tag and commit
>  - list-objects: move tag processing into its own function
>  - revision: mark commit parents as NOT_USER_GIVEN
>  - uploadpack.txt: document implication of `uploadpackfilter.allow`
>
>  "git rev-list" learns the "--filter=object:type=<type>" option,
>  which can be used to exclude objects of the given kind from the
>  packfile generated by pack-objects.
>
>  Will merge to 'next'.
>  cf. <YIKPwRFbgzKJ1EBg@coredump.intra.peff.net>
>
>
> * tb/multi-pack-bitmaps (2021-04-10) 23 commits
>  - p5326: perf tests for MIDX bitmaps
>  - p5310: extract full and partial bitmap tests
>  - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
>  - t7700: update to work with MIDX bitmap test knob
>  - t5319: don't write MIDX bitmaps in t5319
>  - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
>  - t5326: test multi-pack bitmap behavior
>  - t/helper/test-read-midx.c: add --checksum mode
>  - t5310: move some tests to lib-bitmap.sh
>  - pack-bitmap: write multi-pack bitmaps
>  - pack-bitmap: read multi-pack bitmaps
>  - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
>  - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
>  - pack-bitmap.c: introduce 'bitmap_num_objects()'
>  - midx: respect 'core.multiPackIndex' when writing
>  - midx: clear auxiliary .rev after replacing the MIDX
>  - midx: make a number of functions non-static
>  - Documentation: describe MIDX-based bitmaps
>  - Documentation: build 'technical/bitmap-format' by default
>  - pack-bitmap-write.c: free existing bitmaps
>  - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
>  - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
>  - Merge branch 'tb/pack-preferred-tips-to-give-bitmap' into tb/multi-pack-bitmaps
>
>  The reachability bitmap file used to be generated only for a single
>  pack, but now we've learned to generate bitmaps for history that
>  span across multiple packfiles.
>
>  Waiting for reviews.
>  cf. <cover.1617991824.git.me@ttaylorr.com>
>
>
> * ab/svn-tests-set-e-fix (2021-04-12) 2 commits
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>
>  Test clean-up.
>
>  Will merge to 'next'.
>
>
> * ab/test-lib-updates (2021-04-29) 11 commits
>  - test-lib: split up and deprecate test_create_repo()
>  - test-lib: do not show advice about init.defaultBranch under --verbose
>  - test-lib: reformat argument list in test_create_repo()
>  - submodule tests: use symbolic-ref --short to discover branch name
>  - test-lib functions: add --printf option to test_commit
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated option to "test_commit"
>  - test-lib-functions: document test_commit --no-tag
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
>  - test-lib: bring $remove_trash out of retirement
>  (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)
>
>  Test clean-up.
>
>  Waiting for an Ack before merging them to 'next'.
>
>
> * ao/p4-avoid-decoding (2021-04-12) 2 commits
>  - git-p4: do not decode data from perforce by default
>  - git-p4: avoid decoding more data from perforce
>
>  "git p4" in Python-2 days used to accept a lot more kinds of data
>  from Perforce server as uninterrupted byte sequence, but after
>  switching to Python-3, too many things are expected to be in UTF-8,
>  which broke traditional use cases.
>
>  Waiting for reviews.
>
>
> * hn/refs-trace-errno (2021-04-12) 1 commit
>   (merged to 'next' on 2021-04-20 at 0816e49d22)
>  + refs: print errno for read_raw_ref if GIT_TRACE_REFS is set
>
>  Show errno in the trace output in the error codepath that calls
>  read_raw_ref method.
>
>  Will merge to 'master'
>
>
> * ma/t0091-bugreport-fix (2021-04-12) 1 commit
>  - t0091-bugreport.sh: actually verify some content of report
>
>  Test fix.
>
>  Expecting a reroll.
>  cf. <YHYZTLl90rkWWVOr@google.com>, <87a6q22dei.fsf@evledraar.gmail.com>
>
>
> * ps/config-global-override (2021-04-27) 4 commits
>  - t1300: fix unset of GIT_CONFIG_NOSYSTEM leaking into subsequent tests
>   (merged to 'next' on 2021-04-20 at 82578c696d)
>  + config: allow overriding of global and system configuration
>  + config: unify code paths to get global config paths
>  + config: rename `git_etc_config()`
>
>  Replace GIT_CONFIG_NOSYSTEM mechanism to decline from reading the
>  system-wide configuration file with GIT_CONFIG_SYSTEM that lets
>  users specify from which file to read the system-wide configuration
>  (setting it to an empty file would essentially be the same as
>  setting NOSYSTEM), and introduce GIT_CONFIG_GLOBAL to override the
>  per-user configuration in $HOME/.gitconfig.
>
>  Will merge to 'next'.
>
>
> * ds/maintenance-prefetch-fix (2021-04-16) 4 commits
>   (merged to 'next' on 2021-04-16 at 0a1818e235)
>  + maintenance: respect remote.*.skipFetchAll
>  + maintenance: use 'git fetch --prefetch'
>  + fetch: add --prefetch option
>  + maintenance: simplify prefetch logic
>
>  The prefetch task in "git maintenance" assumed that "git fetch"
>  from any remote would fetch all its local branches, which would
>  fetch too much if the user is interested in only a subset of
>  branches there.
>
>  Will merge to 'master'.
>
>
> * mr/bisect-in-c-4 (2021-04-11) 4 commits
>  - bisect--helper: retire `--bisect-next-check` subcommand
>  - bisect--helper: reimplement `bisect_run` shell function in C
>  - bisect--helper: reimplement `bisect_visualize()`shell function in C
>  - run-command: make `exists_in_PATH()` non-static
>
>  The codepaths involved in running "git bisect visualize" and "git
>  bisect run" has been rewritten in C.
>
>  Expecting a reroll.
>  cf. <xmqq35vwh8qk.fsf@gitster.g>, <xmqqy2doftrj.fsf@gitster.g>
>  May want to boost the test coverage.
>
>
> * mt/add-rm-in-sparse-checkout (2021-04-08) 7 commits
>  - rm: honor sparse checkout patterns
>  - add: warn when asked to update SKIP_WORKTREE entries
>  - refresh_index(): add flag to ignore SKIP_WORKTREE entries
>  - pathspec: allow to ignore SKIP_WORKTREE entries on index matching
>  - add: make --chmod and --renormalize honor sparse checkouts
>  - t3705: add tests for `git add` in sparse checkouts
>  - add: include magic part of pathspec on --refresh error
>  (this branch is used by ds/status-with-sparse-index.)
>
>  "git add" and "git rm" learned not to touch those paths that are
>  outside of sparse checkout.
>
>  Will merge to 'next'.
>
>
> * zh/trailer-cmd (2021-04-17) 2 commits
>  - trailer: add new .cmd config option
>  - docs: correct description of .command
>
>  The way the command line specified by the trailer.<token>.command
>  configuration variable receives the end-user supplied value was
>  both error prone and misleading.  An alternative to achieve the
>  same goal in a safer and more intuitive way has been added, as
>  the trailer.<token>.cmd configuration variable, to replace it.
>
>  Expecting a reroll, after waiting for "commit --trailer" to stabilize.
>

I have a little doubt here. Do I need to modify the "Commit-Count"
example in the docs immediately? I thought this should be left to
the next step?

If necessary, I will make changes immediately.

>
> * ds/sparse-index (2021-03-30) 21 commits
>   (merged to 'next' on 2021-04-07 at f1290a7929)
>  + p2000: add sparse-index repos
>  + sparse-index: loose integration with cache_tree_verify()
>  + cache-tree: integrate with sparse directory entries
>  + sparse-checkout: disable sparse-index
>  + sparse-checkout: toggle sparse index from builtin
>  + sparse-index: add index.sparse config option
>  + sparse-index: check index conversion happens
>  + unpack-trees: allow sparse directories
>  + submodule: sparse-index should not collapse links
>  + sparse-index: convert from full to sparse
>  + sparse-index: add 'sdir' index extension
>  + sparse-checkout: hold pattern list in index
>  + unpack-trees: ensure full index
>  + test-tool: don't force full index
>  + test-read-cache: print cache entries with --table
>  + t1092: compare sparse-checkout to sparse-index
>  + sparse-index: implement ensure_full_index()
>  + sparse-index: add guard to ensure full index
>  + t1092: clean up script quoting
>  + t/perf: add performance test for sparse operations
>  + sparse-index: design doc and format update
>  (this branch is used by ds/sparse-index-protections and ds/status-with-sparse-index.)
>
>  Both in-core and on-disk index has been updated to optionally omit
>  individual entries and replace them with the tree object that
>  corresponds to the directory that contains them when the "cone"
>  mode of sparse checkout is in use.
>
>  On hold, waiting for the "protections" topic to stablize.
>
>
> * mt/parallel-checkout-part-2 (2021-04-19) 5 commits
>   (merged to 'next' on 2021-04-20 at d4779b8864)
>  + parallel-checkout: add design documentation
>  + parallel-checkout: support progress displaying
>  + parallel-checkout: add configuration options
>  + parallel-checkout: make it truly parallel
>  + unpack-trees: add basic support for parallel checkout
>  (this branch is used by mt/parallel-checkout-part-3.)
>
>  The checkout machinery has been taught to perform the actual
>  write-out of the files in parallel when able.
>
>  Will merge to 'master'.
>
>
> * ds/sparse-index-protections (2021-04-14) 26 commits
>   (merged to 'next' on 2021-04-17 at f1c40f89ba)
>  + name-hash: use expand_to_path()
>  + sparse-index: expand_to_path()
>  + name-hash: don't add directories to name_hash
>  + revision: ensure full index
>  + resolve-undo: ensure full index
>  + read-cache: ensure full index
>  + pathspec: ensure full index
>  + merge-recursive: ensure full index
>  + entry: ensure full index
>  + dir: ensure full index
>  + update-index: ensure full index
>  + stash: ensure full index
>  + rm: ensure full index
>  + merge-index: ensure full index
>  + ls-files: ensure full index
>  + grep: ensure full index
>  + fsck: ensure full index
>  + difftool: ensure full index
>  + commit: ensure full index
>  + checkout: ensure full index
>  + checkout-index: ensure full index
>  + add: ensure full index
>  + cache: move ensure_full_index() to cache.h
>  + read-cache: expand on query into sparse-directory entry
>  + *: remove 'const' qualifier for struct index_state
>  + sparse-index: API protection strategy
>  (this branch is used by ds/status-with-sparse-index; uses ds/sparse-index.)
>
>  Builds on top of the sparse-index infrastructure to mark operations
>  that are not ready to mark with the sparse index, causing them to
>  fall back on fully-populated index that they always have worked with.
>
>  Will merge to 'master'.
>
>
> * hn/reftable (2021-04-20) 28 commits
>  - t1404: annotate test cases with REFFILES
>  - t1401,t2011: parameterize HEAD.lock for REFTABLE
>  - t1301: document what needs to be done for REFTABLE
>  - Add "test-tool dump-reftable" command.
>  - git-prompt: prepare for reftable refs backend
>  - Reftable support for git-core
>  - reftable: add dump utility
>  - reftable: implement stack, a mutable database of reftable files.
>  - reftable: implement refname validation
>  - reftable: add merged table view
>  - reftable: add a heap-based priority queue for reftable records
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: generic interface to tables
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - Provide zlib's uncompress2 from compat/zlib-compat.c
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: add LICENSE
>  - init-db: set the_repository->hash_algo early on
>  - hash.h: provide constants for the hash IDs
>  - refs/debug: trace into reflog expiry too
>  - refs: document reflog_expire_fn's flag argument
>  - refs: ref_iterator_peel returns boolean, rather than peel_status
>
>  The "reftable" backend for the refs API.
