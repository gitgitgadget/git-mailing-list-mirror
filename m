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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D77BC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 05:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4AE464FB6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 05:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCKFVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 00:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhCKFUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 00:20:46 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B33C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 21:20:46 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so29451ool.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 21:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XYyMgTmWZl7LOTuYtCd4fXY/7FxhLL3b0YABtoFd5Xg=;
        b=imrpHQwmxmcuOD+YjU8X2NwCHBiEreOq4cvh2pKRhAzN4VD9Gsolqa8vm7XbhelGTs
         ON6l8RG37yfWFg5JeHDR9ZSkroyU4eOCef5Rf4BKNz6rarjw9UoRKi99BiagQaFZaO2S
         i1p4xJd9Wjt8JXsZihDDIWqRQeeO2zok9vdtDFbTBOm8ENOAbV1jRLIY2wOnH7NEk28A
         fixGmoqeMBOEGk+pa2EEpr+YpG1hwXUbA//lbpK/UU25MBxDfsvJnCggHj9Mc8gD/TRv
         XX93gamaHXuWcUDIYeL8mIdFqSjFVqHclhQltfGdbVaJrtFaqLVGKdFxZQqBOt8O7vDi
         2qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XYyMgTmWZl7LOTuYtCd4fXY/7FxhLL3b0YABtoFd5Xg=;
        b=bxGVBlNI2IlIQxOZ2gbWw3bXHqxTGota432VeDdnZTk7GWQBHBm1KQBQNNHxmqamAi
         JV2Pz4Rg8gDfB/KMMcqJd4XNiNPp7VcBAjarClW+M4vNLnYSiKAF2xB5nhhNL1NxAsHE
         VQrWjsyBX047n/MuL7mlmWewfpuz+j/sYVeahyirVVa656/VsNxJQZrnnC7sgpdfvm+i
         ji1hCx+v/1Yykx/BunGREvXRfqP2zsPFUJHe/444jRJsbDBpeu8fOdilbL0RB9wya2TA
         o//E80eww/pH1p8qjbsADpwuSqlnAomBj6LYgHSIvjZJOZd7/CtAziwNLIvAmyC+FBRd
         CRSA==
X-Gm-Message-State: AOAM532CEc27dGop1aSeggQQhxY3sSugn0w79pZZ/KEeb3btruBFyNDg
        9qxZjSyjjJNZU/YVJ+WXmmIlLOsLtVNhLeV8z8MtWmSP0P3iJA==
X-Google-Smtp-Source: ABdhPJz1/u1PGQnVCUSNCUp6BWlC5kAXGKaLlPROr+8uEnF+ut+WhZvFRLBoI2UNMs/xz2R1GRGI9baBRLgorVHcS0E=
X-Received: by 2002:a4a:4958:: with SMTP id z85mr5216154ooa.3.1615440045255;
 Wed, 10 Mar 2021 21:20:45 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmtvafl62.fsf@gitster.g>
In-Reply-To: <xmqqmtvafl62.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 11 Mar 2021 13:20:33 +0800
Message-ID: <CAOLTT8SBv9QE22bMT2x6_DYNPZDaBjoEv8o6d2MenOnwKng8Xw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,Junio,

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Here are the topics that have been cooking.  Commits prefixed with '-' ar=
e
> only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
> with '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The second release candidate Git v2.31.0-rc2, together with
> maintenance releases for CVE-2021-21300, have been released.
>
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.
>
> With maint, master, next, seen, todo:
>
>         git://git.kernel.org/pub/scm/git/git.git/
>         git://repo.or.cz/alt-git.git/
>         https://kernel.googlesource.com/pub/scm/git/git/
>         https://github.com/git/git/
>         https://gitlab.com/git-vcs/git/
>
> With all the integration branches and topics broken out:
>
>         https://github.com/gitster/git/
>
> Even though the preformatted documentation in HTML and man format
> are not sources, they are published in these repositories for
> convenience (replace "htmldocs" with "manpages" for the manual
> pages):
>
>         git://git.kernel.org/pub/scm/git/git-htmldocs.git/
>         https://github.com/gitster/git-htmldocs.git/
>
> Release tarballs are available at:
>
>         https://www.kernel.org/pub/software/scm/git/
>
> --------------------------------------------------
> [New Topics]
>
> * ab/tests-cleanup-around-sha1 (2021-03-10) 4 commits
>  - tests: get rid of $_x05 from the test suite
>  - shortlog tests: rewrite to get rid of --abbrev=3D35 hardcoding
>  - test-lib: remove unused $_x40 and $_z40 variables
>  - git-bisect: remove unused SHA-1 $x40 shell variable
>
>  Remove variables that hold regexp and glob that match fixed number
>  of hexadecimal digits from the test suite.
>
>  Expecting a reroll.
>  At least the last one weakens a test; there may be similar breakage
>  due to not understanding what they are trying to test.
>
>
> * jk/filter-branch-sha256 (2021-03-10) 3 commits
>  - filter-branch: drop $_x40 glob
>  - filter-branch: drop multiple-ancestor warning
>  - t7003: test ref rewriting explicitly
>
>  Code clean-up.
>
>  Will merge to 'next'.
>  In the longer term, we might want to remove filter-branch and nudge
>  folks to more modern tools.
>
>
> * jn/mergetool-hideresolved-is-optional (2021-03-10) 1 commit
>  - mergetool: do not enable hideResolved by default
>
>  Disable the recent mergetool's hideresolved feature by default for
>  backward compatibility and safety.
>
>  Expecting a reroll.
>  We may want to give a more meaning log message to explain why it is
>  undesirable to turn it on by default.
>
>
> --------------------------------------------------
> [Graduated to 'master']
>
> * jt/transfer-fsck-across-packs-fix (2021-03-05) 1 commit
>   (merged to 'next' on 2021-03-07 at c79f295216)
>  + fetch-pack: do not mix --pack_header and packfile uri
>
>  The code to fsck objects received across multiple packs during a
>  single git fetch session has been broken when the packfile URI
>  feature was in use.  A workaround has been added by disabling the
>  codepath that avoids keeping a packfile that is too small.
>
> --------------------------------------------------
> [Stalled]
>
> * hn/reftable (2021-03-08) 17 commits
>  - SQUASH??? calloc(nmemb,size)
>  - SQUASH??? allow t0031 to run with any default branch name
>  - Add "test-tool dump-reftable" command.
>  - git-prompt: prepare for reftable refs backend
>  - Reftable support for git-core
>  - reftable: rest of library
>  - reftable: reftable file level tests
>  - reftable: read reftable files
>  - reftable: write reftable files
>  - reftable: a generic binary tree implementation
>  - reftable: reading/writing blocks
>  - reftable: (de)serialization for the polymorphic record type.
>  - reftable: add blocksource, an abstraction for random access reads
>  - reftable: utility functions
>  - reftable: add error related functionality
>  - reftable: add LICENSE
>  - init-db: set the_repository->hash_algo early on
>
>  The "reftable" backend for the refs API.
>
>
> * mt/parallel-checkout-part-1 (2020-12-16) 9 commits
>  - entry: add checkout_entry_ca() taking preloaded conv_attrs
>  - entry: move conv_attrs lookup up to checkout_entry()
>  - entry: extract update_ce_after_write() from write_entry()
>  - entry: make fstat_output() and read_blob_entry() public
>  - entry: extract a header file for entry.c functions
>  - convert: add classification for conv_attrs struct
>  - convert: add get_stream_filter_ca() variant
>  - convert: add [async_]convert_to_working_tree_ca() variants
>  - convert: make convert_attrs() and convert structs public
>
>  Parallel checkout.
>
>  Looking good.
>
>
> * es/config-hooks-part-1 (2021-02-16) 17 commits
>  - hooks: allow callers to capture output
>  - run-command: allow capturing of collated output
>  - hook: provide stdin by string_list or callback
>  - run-command: add stdin callback for parallelization
>  - hook: allow specifying working directory for hooks
>  - hook: allow parallel hook execution
>  - run-command: allow stdin for run_processes_parallel
>  - hook: support passing stdin to hooks
>  - hook: replace find_hook() with hook_exists()
>  - hook: add 'run' subcommand
>  - parse-options: parse into strvec
>  - hook: implement hookcmd.<name>.skip
>  - hook: respect hook.runHookDir
>  - hook: include hookdir hook in list
>  - hook: add list command
>  - hook: scaffolding for git-hook subcommand
>  - doc: propose hooks managed by the config
>  (this branch is used by es/config-hooks.)
>
>  A way to specify hooks in the configuration files is introduced.
>
>  Expecting another reroll??
>  cf. <YC7o2rUQOEdiMdqh@google.com>
>
>
> * dl/stash-show-untracked (2021-03-05) 2 commits
>   (merged to 'next' on 2021-03-08 at 510d4cfa5f)
>  + stash show: learn stash.showIncludeUntracked
>  + stash show: teach --include-untracked and --only-untracked
>
>  "git stash show" learned to optionally show untracked part of the
>  stash.
>
>  Will cook in 'next'.
>
>
> * ab/fsck-api-cleanup (2021-02-18) 10 commits
>  - fsck.h: update FSCK_OPTIONS_* for object_name
>  - fsck.c: give "FOREACH_MSG_ID" a more specific name
>  - fsck.c: undefine temporary STR macro after use
>  - fsck.c: call parse_msg_type() early in fsck_set_msg_type()
>  - fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
>  - fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
>  - fsck.c: move definition of msg_id into append_msg_id()
>  - fsck.c: rename variables in fsck_set_msg_type() for less confusion
>  - fsck.h: use "enum object_type" instead of "int"
>  - fsck.h: indent arguments to of fsck_set_msg_type
>
>  Preliminary fsck API clean-up.
>
>  Expecting a reroll.
>  cf. <xmqqczwxc8bw.fsf@gitster.g>
>
>
> * jk/symlinked-dotgitx-files (2020-10-23) 9 commits
>  - docs: document symlink restrictions for .git* files
>  - fsck: complain when .gitattributes or .gitignore is a symlink
>  - verify_path(): disallow symlinks in .gitattributes and .gitignore
>  - t0060: test obscured .gitattributes and .gitignore matching
>  - t7450: test .gitmodules symlink matching against obscured names
>  - t7450: test verify_path() handling of gitmodules
>  - t7415: rename to expand scope
>  - fsck_tree(): wrap some long lines
>  - fsck_tree(): fix shadowed variable
>
>  "git fsck" and the corresponding check done during the transport
>  learned to ensure that in-tree files like `.gitignore` and
>  `.gitattributes` are not symbolic links.
>
>  It seems that there are real projects with .gitignore recorded as
>  symlinks, which may need to loosen the fsck setting.  Do we need to
>  introduce a class that is separate from symlinked .gitmodules that
>  has potential consequences that is more/less grave, so that these
>  projects can opt out of the new checks?
>
>
> * ag/merge-strategies-in-c (2020-11-24) 13 commits
>  - sequencer: use the "octopus" merge strategy without forking
>  - sequencer: use the "resolve" strategy without forking
>  - merge: use the "octopus" strategy without forking
>  - merge: use the "resolve" strategy without forking
>  - merge-octopus: rewrite in C
>  - merge-recursive: move better_branch_name() to merge.c
>  - merge-resolve: rewrite in C
>  - merge-index: don't fork if the requested program is `git-merge-one-fil=
e'
>  - merge-index: libify merge_one_path() and merge_all()
>  - merge-one-file: rewrite in C
>  - update-index: move add_cacheinfo() to read-cache.c
>  - t6060: modify multiple files to expose a possible issue with merge-ind=
ex
>  - t6407: modernise tests
>
>  The resolve and octopus merge strategy backends have been rewritten
>  in C.
>
>  Got enough review comments to get updated.
>
> --------------------------------------------------
> [Cooking]
>
> * ab/make-cocci-dedup (2021-03-05) 4 commits
>  - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>  - Makefile/coccicheck: allow for setting xargs concurrency
>  - Makefile/coccicheck: speed up and fix bug with duplicate hunks
>  - Makefile/coccicheck: add comment heading for all SPATCH flags
>
>  An attempt to speed up the coccicheck target with incorrect
>  results.
>
>  A reroll exists to address correctness issue, but not picked up.
>
>
> * ab/read-tree (2021-03-08) 6 commits
>  - tree.h API: remove "stage" parameter from read_tree_recursive()
>  - tree.h API: remove support for starting at prefix !=3D ""
>  - ls-files: refactor away read_tree()
>  - ls-files: don't needlessly pass around stage variable
>  - tree.c API: move read_tree() into builtin/ls-files.c
>  - ls-files tests: add meaningful --with-tree tests
>
>  Code simplification by removing support for a caller that is long gone.
>
>  Looked good.
>
>
> * ab/unexpected-object-type (2021-03-08) 7 commits
>  - tag: don't misreport type of tagged objects in errors
>  - object tests: add test for unexpected objects in tags
>  - object.c: add a utility function for "expected type X, got Y"
>  - tree.c: fix misindentation in parse_tree_gently()
>  - oid_object_info(): return "enum object_type"
>  - object.c: make type_from_string() return "enum object_type"
>  - object.c: refactor type_from_string_gently()
>
>  Error reporting upon object type mismatch has been improved
>
>  Looked good.
>
>
> * ah/make-fuzz-all-doc-update (2021-03-08) 1 commit
>  - Makefile: update 'make fuzz-all' docs to reflect modern clang
>
>  Update insn in Makefile comments to run fuzz-all target.
>
>  Needs review.
>  cf. <pull.889.v3.git.1615223682911.gitgitgadget@gmail.com>
>  cf. <defff7a3-2104-4fa1-7750-0b13ca5cdf59@ahunt.org>
>
>
> * ah/plugleaks (2021-03-08) 7 commits
>  - parse-options: don't leak alias help messages
>  - init-db: silence template_dir leak when converting to absolute path
>  - init: remove git_init_db_config() while fixing leaks
>  - worktree: fix leak in dwim_branch()
>  - clone: free or UNLEAK further pointers when finished
>  - reset: free instead of leaking unneeded ref
>  - symbolic-ref: don't leak shortened refname in check_symref()
>
>  Plug or annotate remaining leaks that trigger while running the
>  very basic set of tests.
>
>
> * bc/clone-bare-with-conflicting-config (2021-03-10) 1 commit
>  - builtin/init-db: handle bare clones when core.bare set to false
>
>  "git -c core.bare=3Dfalse clone --bare ..." would have segfaulted,
>  which has been corrected.
>
>  Will merge to 'next'.
>
>
> * dl/cat-file-doc-cleanup (2021-03-03) 2 commits
>  - git-cat-file.txt: remove references to "sha1"
>  - git-cat-file.txt: monospace args, placeholders and filenames
>
>  Doc cleanup.
>
>  Will merge to 'next'.
>
>
> * jr/doc-ignore-typofix (2021-03-03) 1 commit
>  - doc: .gitignore documentation typofix
>
>  Doc cleanup.
>
>  Will merge to 'next'.
>
>
> * rr/mailmap-entry-self (2021-03-08) 1 commit
>  - Add entry for Ramkumar Ramachandra
>
>  Will merge to 'next'.
>
>
> * rs/xcalloc-takes-nelem-first (2021-03-08) 1 commit
>  - fix xcalloc() argument order
>
>  Code cleanup.
>
>  Will merge to 'next'.
>
>
> * sv/t9801-test-path-is-file-cleanup (2021-03-03) 1 commit
>  - t9801: replace test -f with test_path_is_file
>
>  Test cleanup.
>
>  Will merge to 'next'.
>
>
> * tb/git-mv-icase-fix (2021-03-03) 1 commit
>  - git mv foo FOO ; git mv foo bar gave an assert
>
>  Fix a corner case bug in "git mv" on case insensitive systems,
>  which was introduced in 2.29 timeframe.
>
>  Will merge to 'next'.
>
>
> * tb/push-simple-uses-branch-merge-config (2021-03-08) 1 commit
>  - Documentation/git-push.txt: correct configuration typo
>
>  Doc update.
>
>  cf. <YEaM7ruZCvaQQbPI@nand.local>
>
>
> * ab/remote-write-config-in-camel-case (2021-02-24) 2 commits
>   (merged to 'next' on 2021-03-01 at a01bd0d8e4)
>  + remote: write camel-cased *.pushRemote on rename
>  + remote: add camel-cased *.tagOpt key, like clone
>
>  Update C code that sets a few configuration variables when a remote
>  is configured so that it spells configuration variable names in the
>  canonical camelCase.
>
>  Will cook in 'next'.
>
>
> * ds/commit-graph-generation-config (2021-02-25) 2 commits
>   (merged to 'next' on 2021-03-01 at 926537ea97)
>  + commit-graph: use config to specify generation type
>  + commit-graph: create local repository pointer
>
>  A new configuration variable has been introduced to allow choosing
>  which version of the generation number gets used in the
>  commit-graph file.
>
>  Will cook in 'next'.
>
>
> * mt/cleanly-die-upon-missing-required-filter (2021-02-26) 1 commit
>   (merged to 'next' on 2021-03-01 at 357954af7c)
>  + convert: fail gracefully upon missing clean cmd on required filter
>
>  We had a code to diagnose and die cleanly when a required
>  clean/smudge filter is missing, but an assert before that
>  unnecessarily fired, hiding the end-user facing die() message.
>
>  Will cook in 'next'.
>
>
> * ab/describe-tests-fix (2021-03-01) 10 commits
>  - test-lib: return 1 from test_expect_{success,failure}
>  - svn tests: refactor away a "set -e" in test body
>  - svn tests: remove legacy re-setup from init-clone test
>  - describe tests: support -C in "check_describe"
>  - describe tests: fix nested "test_expect_success" call
>  - describe tests: convert setup to use test_commit
>  - test-lib functions: add an --annotated-tag option to "test_commit"
>  - describe tests: always assert empty stderr from "describe"
>  - describe tests: refactor away from glob matching
>  - describe tests: improve test for --work-tree & --dirty
>
>  Various updates to tests around "git describe"
>
>
> * en/ort-perf-batch-8 (2021-02-26) 10 commits
>   (merged to 'next' on 2021-03-07 at f03b2c1acd)
>  + diffcore-rename: compute dir_rename_guess from dir_rename_counts
>  + diffcore-rename: limit dir_rename_counts computation to relevant dirs
>  + diffcore-rename: compute dir_rename_counts in stages
>  + diffcore-rename: extend cleanup_dir_rename_info()
>  + diffcore-rename: move dir_rename_counts into dir_rename_info struct
>  + diffcore-rename: add function for clearing dir_rename_count
>  + Move computation of dir_rename_count from merge-ort to diffcore-rename
>  + diffcore-rename: add a mapping of destination names to their indices
>  + diffcore-rename: provide basic implementation of idx_possible_rename()
>  + diffcore-rename: use directory rename guided basename comparisons
>
>  Rename detection rework continues.
>
>  Will cook in 'next'.
>
>
> * jk/perf-in-worktrees (2021-02-26) 2 commits
>   (merged to 'next' on 2021-03-02 at ea298cb298)
>  + t/perf: avoid copying worktree files from test repo
>  + t/perf: handle worktrees as test repos
>
>  Perf test update to work better in secondary worktrees.
>
>  Will cook in 'next'.
>
>
> * ps/update-ref-trans-hook-doc (2021-03-01) 2 commits
>  - githooks.txt: clarify documentation on reference-transaction hook
>  - githooks.txt: replace mentions of SHA-1 specific properties
>
>
> * tb/pack-revindex-on-disk (2021-02-26) 1 commit
>  - pack-revindex.c: don't close unopened file descriptors
>
>
> * zh/format-patch-fractional-reroll-count (2021-03-01) 1 commit
>  - format-patch: allow a non-integral version numbers
>
I noticed that you used the'previous-count' version of
"zh/format-patch-fractional-reroll-count" in seen.
 Do you want me to deal with this version instead of the
 previous version that Denton Liu and Eric Sunshine helped
me complete?What

 If you want me to deal with the `previous-count` version,
 I will roll it back again and deal with some small details:
use "strtol_i".
>
> * ab/make-cleanup (2021-02-23) 6 commits
>  - Makefile: build "$(FUZZ_OBJS)" in CI, not under "all"
>  - Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets
>  - Makefile: split OBJECTS into OBJECTS and GIT_OBJS
>  - Makefile: sort OBJECTS assignment for subsequent change
>  - Makefile: split up long OBJECTS line
>  - Makefile: guard against TEST_OBJS in the environment
>
>  Reorganize Makefile to allow building git.o and other essential
>  objects without extra stuff needed only for testing.
>
>  The last step is of dubious value, but otherwise looked OK.
>  cf. <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>
>
>
> * ab/grep-pcre2-allocfix (2021-02-17) 10 commits
>   (merged to 'next' on 2021-03-04 at 26d2b726b1)
>  + grep/pcre2: move definitions of pcre2_{malloc,free}
>  + grep/pcre2: move back to thread-only PCREv2 structures
>  + grep/pcre2: actually make pcre2 use custom allocator
>  + grep/pcre2: use pcre2_maketables_free() function
>  + grep/pcre2: use compile-time PCREv2 version test
>  + grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
>  + grep/pcre2: prepare to add debugging to pcre2_malloc()
>  + grep/pcre2: correct reference to grep_init() in comment
>  + grep/pcre2: drop needless assignment to NULL
>  + grep/pcre2: drop needless assignment + assert() on opt->pcre2
>
>  Updates to memory allocation code around the use of pcre2 library.
>
>  Will cook in 'next'.
>
>
> * tb/reverse-midx (2021-02-24) 16 commits
>  - pack-revindex: write multi-pack reverse indexes
>  - pack-write.c: extract 'write_rev_file_order'
>  - pack-revindex: read multi-pack reverse indexes
>  - Documentation/technical: describe multi-pack reverse indexes
>  - midx: make some functions non-static
>  - midx: keep track of the checksum
>  - midx: don't free midx_name early
>  - midx: allow marking a pack as preferred
>  - t/helper/test-read-midx.c: add '--show-objects'
>  - builtin/multi-pack-index.c: display usage on unrecognized command
>  - builtin/multi-pack-index.c: don't enter bogus cmd_mode
>  - builtin/multi-pack-index.c: split sub-commands
>  - builtin/multi-pack-index.c: define common usage with a macro
>  - builtin/multi-pack-index.c: don't handle 'progress' separately
>  - builtin/multi-pack-index.c: inline 'flags' with options
>  - Merge branch 'ds/chunked-file-api' into tb/reverse-midx
>
>  An on-disk reverse-index to map the in-pack location of an object
>  back to its object name across multiple packfiles is introduced.
>
>
> * ab/pickaxe-pcre2 (2021-02-18) 24 commits
>  - pickaxe -G: don't special-case create/delete
>  - pickaxe -G: terminate early on matching lines
>  - xdiff-interface: support early exit in xdiff_outf()
>  - xdiff-interface: allow early return from xdiff_emit_{line,hunk}_fn
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
>  - pickaxe tests: test for -G, -S and --find-object incompatibility
>  - pickaxe tests: add test for "log -S" not being a regex
>  - pickaxe tests: add test for diffgrep_consume() internals
>  - pickaxe tests: refactor to use test_commit --append --printf
>  - test-lib functions: add --printf option to test_commit
>  - test-lib-functions: reword "test_commit --append" docs
>  - test-lib-functions: document and test test_commit --no-tag
>  - grep/pcre2 tests: reword comments referring to kwset
>  - Merge branch 'jk/rev-list-disk-usage' into ab/pickaxe-pcre2
>  - Merge branch 'ab/test-lib' into ab/pickaxe-pcre2
>
>  Rewrite the backend for "diff -G/-S" to use pcre2 engine when
>  available.
>
>  Needs review.
>  cf. <20210216115801.4773-1-avarab@gmail.com>
>
>
> * cm/rebase-i-fixup-amend-reword (2021-03-10) 6 commits
>  - doc/git-commit: add documentation for fixup=3D[amend|reword] options
>  - t3437: use --fixup with options to create amend! commit
>  - t7500: add tests for --fixup=3D[amend|reword] options
>  - commit: add a reword suboption to --fixup
>  - commit: add amend suboption to --fixup to create amend! commit
>  - sequencer: export and rename subject_length()
>  (this branch uses cm/rebase-i and cm/rebase-i-updates.)
>
>  "git commit --fixup=3D<commit>", which was to tweak the changes made
>  to the contents while keeping the original log message intact,
>  learned "--fixup=3D(amend|reword):<commit>", that can be used to
>  tweak both the message and the contents, and only the message,
>  respectively.
>
>  Getting there.
>
>
> * jk/open-dotgitx-with-nofollow (2021-02-16) 6 commits
>   (merged to 'next' on 2021-02-25 at a784bf7be6)
>  + mailmap: do not respect symlinks for in-tree .mailmap
>  + exclude: do not respect symlinks for in-tree .gitignore
>  + attr: do not respect symlinks for in-tree .gitattributes
>  + exclude: add flags parameter to add_patterns()
>  + attr: convert "macro_ok" into a flags field
>  + add open_nofollow() helper
>
>  It does not make sense to make ".gitattributes", ".gitignore" and
>  ".mailmap" symlinks, as they are supposed to be usable from the
>  object store (think: bare repositories where HEAD:.mailmap etc. are
>  used).  When these files are symbolic links, we used to read the
>  contents of the files pointed by them by mistake, which has been
>  corrected.
>
>  Will cook in 'next'.
>
>
> * rs/pretty-describe (2021-03-01) 4 commits
>   (merged to 'next' on 2021-03-01 at bee9248828)
>  + pretty: document multiple %(describe) being inconsistent
>  + t4205: assert %(describe) test coverage
>   (merged to 'next' on 2021-02-25 at 2347ed8fe6)
>  + pretty: add merge and exclude options to %(describe)
>  + pretty: add %(describe)
>
>  "git log --format=3D'...'" learned "%(describe)" placeholder.
>
>  Will cook in 'next'.
>
>
> * cm/rebase-i-updates (2021-02-10) 11 commits
>   (merged to 'next' on 2021-02-12 at e29227780b)
>  + doc/rebase -i: fix typo in the documentation of 'fixup' command
>  + t/t3437: fixup the test 'multiple fixup -c opens editor once'
>  + t/t3437: use named commits in the tests
>  + t/t3437: simplify and document the test helpers
>  + t/t3437: check the author date of fixed up commit
>  + t/t3437: remove the dependency of 'expected-message' file from tests
>  + t/t3437: fixup here-docs in the 'setup' test
>  + t/lib-rebase: update the documentation of FAKE_LINES
>  + rebase -i: clarify and fix 'fixup -c' rebase-todo help
>  + sequencer: rename a few functions
>  + sequencer: fixup the datatype of the 'flag' argument
>  (this branch is used by cm/rebase-i-fixup-amend-reword; uses cm/rebase-i=
.)
>
>  Follow-up fixes to "cm/rebase-i" topic.
>
>  Will cook in 'next', together with "cm/rebase-i".
>
>
> * jh/simple-ipc (2021-03-09) 12 commits
>  - t0052: add simple-ipc tests and t/helper/test-simple-ipc tool
>  - simple-ipc: add Unix domain socket implementation
>  - unix-stream-server: create unix domain socket under lock
>  - unix-socket: disallow chdir() when creating unix domain sockets
>  - unix-socket: add backlog size option to unix_stream_listen()
>  - unix-socket: eliminate static unix_stream_socket() helper function
>  - simple-ipc: add win32 implementation
>  - simple-ipc: design documentation for new IPC mechanism
>  - pkt-line: add options argument to read_packetized_to_strbuf()
>  - pkt-line: add PACKET_READ_GENTLE_ON_READ_ERROR option
>  - pkt-line: do not issue flush packets in write_packetized_*()
>  - pkt-line: eliminate the need for static buffer in packet_write_gently(=
)
>
>  A simple IPC interface gets introduced to build services like
>  fsmonitor on top.
>
>  Replaced with a new iteration.
>
>
>
> * cm/rebase-i (2021-01-29) 9 commits
>   (merged to 'next' on 2021-02-01 at 4f9aa6cec3)
>  + doc/git-rebase: add documentation for fixup [-C|-c] options
>  + rebase -i: teach --autosquash to work with amend!
>  + t3437: test script for fixup [-C|-c] options in interactive rebase
>  + rebase -i: add fixup [-C | -c] command
>  + sequencer: use const variable for commit message comments
>  + sequencer: pass todo_item to do_pick_commit()
>  + rebase -i: comment out squash!/fixup! subjects from squash message
>  + sequencer: factor out code to append squash message
>  + rebase -i: only write fixup-message when it's needed
>  (this branch is used by cm/rebase-i-fixup-amend-reword and cm/rebase-i-u=
pdates.)
>
>  "rebase -i" is getting cleaned up and also enhanced.
>
>  Will cook in 'next', together with "cm/rebase-i-updates".
>
>
> * tb/geometric-repack (2021-03-05) 13 commits
>   (merged to 'next' on 2021-03-08 at def1c48d43)
>  + builtin/repack.c: reword comment around pack-objects flags
>  + builtin/repack.c: be more conservative with unsigned overflows
>  + builtin/repack.c: assign pack split later
>  + t7703: test --geometric repack with loose objects
>  + builtin/repack.c: do not repack single packs with --geometric
>   (merged to 'next' on 2021-02-25 at a854fdbaff)
>  + builtin/repack.c: add '--geometric' option
>  + packfile: add kept-pack cache for find_kept_pack_entry()
>  + builtin/pack-objects.c: rewrite honor-pack-keep logic
>  + p5303: measure time to repack with keep
>  + p5303: add missing &&-chains
>  + builtin/pack-objects.c: add '--stdin-packs' option
>  + revision: learn '--no-kept-objects'
>  + packfile: introduce 'find_kept_pack_entry()'
>
>  "git repack" so far has been only capable of repacking everything
>  under the sun into a single pack (or split by size).  A cleverer
>  strategy to reduce the cost of repacking a repository has been
>  introduced.
>
>  Will cook in 'next'.
>
>
> * es/config-hooks (2021-02-16) 17 commits
>  - run-command: stop thinking about hooks
>  - receive-pack: convert receive hooks to hook.h
>  - post-update: use hook.h library
>  - proc-receive: acquire hook list from hook.h
>  - receive-pack: convert 'update' hook to hook.h
>  - reference-transaction: look for hooks in config
>  - transport: convert pre-push hook to use config
>  - hook: convert 'post-rewrite' hook to config
>  - hooks: convert 'post-checkout' hook to hook library
>  - git-p4: use 'git hook' to run hooks
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change hook to use config
>  - rebase: teach pre-rebase to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - merge: use config-based hooks for post-merge hook
>  - am: convert applypatch hooks to use config
>  - commit: use config-based hooks
>  (this branch uses es/config-hooks-part-1.)
>
>  The "hooks defined in config" topic.
>
>  Expecting doc updates, but otherwise seems to be progressing nicely.
>
> --------------------------------------------------
> [Discarded]
>
> * cw/pack-vs-bigfilethreashold (2021-02-09) 2 commits
>  . fixup! doc: mention bigFileThreshold for packing
>  . doc: mention bigFileThreshold for packing
>
>  Doc update.
>
>  cw/pack-config-doc supersedes this with a bit more coverage on
>  related knobs.
>
>
> * jh/simple-ipc-cleanups (2021-03-04) 9 commits
>  - SQUASH???
>  - simple-ipc: update design documentation with more details
>  - test-simple-ipc: add --token=3D<token> string option
>  - test-simple-ipc: refactor command line option processing in helper
>  - unix-stream-server: add st_dev and st_mode to socket stolen checks
>  - simple-ipc: move error handling up a level
>  - unix-stream-server: create unix-stream-server.c
>  - unix-socket: simplify initialization of unix_stream_listen_opts
>  - pkt-line: remove buffer arg from write_packetized_from_fd_no_flush()
>
>  After kicking jh/simple-ipc out of 'next' and rewinding
>  jh/simple-ipc to contain the incremental clean-up in this follow-up
>  topic, it is no longer needed, hence retired.

Thanks.
--
ZheNingHu
