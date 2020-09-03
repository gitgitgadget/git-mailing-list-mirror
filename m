Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10910C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE062206CA
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VBKrZ5Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgICVgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:36:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58761 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgICVgg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:36:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3733F88B4E;
        Thu,  3 Sep 2020 17:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=N
        WBvd5Q1v2/oGyj8sxKjHJhY8cI=; b=VBKrZ5Cv4y+5TAjYwHQv0LvCyZJwkbo4v
        h0oI3+9nXq9r+Tzb2eakKL57mDELK7i49tDAXKong4lTVuY6+ftp8AXzFWKPewDT
        tHCFourLp2OAKITGj0Is+kY61+23/cgxrjPks9lSXw4YSa6De60FtNNNcGlHgC+w
        4wf7ed42ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=BqJ
        UzHRPGLU7RxzX/wDyoFNQhBJ86gYkLWOntEPFewzM1ySMIXW89MyqxgRvR/hcrFX
        90oSW0vNwulPKe0TS2pTO/HTrhLvhPOBD/xB0BaaoYWBiEIOUqOfCBS+po+9lrTw
        YYJgADpBdnNeJWMc/0LBIyUv1XB0SBBWEtPHcqaY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EEEC88B4D;
        Thu,  3 Sep 2020 17:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FDF988B4C;
        Thu,  3 Sep 2020 17:36:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2020, #02; Thu, 3)
X-master-at: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
X-next-at: f4bc123cb7519b4205da0f439b0cefc5a5f176ac
Date:   Thu, 03 Sep 2020 14:36:28 -0700
Message-ID: <xmqqk0xa8rvn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 870A2960-EE2D-11EA-85A0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

It is a bit too soon since the previous edition of the "What's
cooking" report, but I'd expect to be inactive tomorrow, and today
happened to be the day several topics have graduated to 'master',
so here it is.

The "stalled" state have accumulated way too many topics to my
liking.  I'll probably start pinging the patch and discussion
threads and see what status they are in and then start dropping
truly dead ones.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* hl/bisect-doc-clarify-bad-good-ordering (2020-08-28) 1 commit
  (merged to 'next' on 2020-08-31 at 11ce613916)
 + bisect: swap command-line options in documentation

 Doc update.


* jc/post-checkout-doc (2020-08-27) 1 commit
  (merged to 'next' on 2020-09-02 at bb06b5f978)
 + doc: clarify how exit status of post-checkout hook is used

 Doc update.


* jc/run-command-use-embedded-args (2020-08-26) 1 commit
  (merged to 'next' on 2020-08-27 at c2b688e8e9)
 + run_command: teach API users to use embedded 'args' more

 Various callers of run_command API has been modernized.


* jc/undash-in-tree-git-callers (2020-08-27) 3 commits
  (merged to 'next' on 2020-08-27 at 671fa2f87e)
 + credential-cache: use child_process.args
 + cvsexportcommit: do not run git programs in dashed form
 + transport-helper: do not run git-remote-ext etc. in dashed form
 (this branch is used by jc/war-on-dashed-git.)

 A handful of places in in-tree code still relied on being able to
 execute the git subcommands, especially built-ins, in "git-foo"
 form, which have been corrected.


* jk/slimmed-down (2020-08-13) 5 commits
  (merged to 'next' on 2020-08-27 at bc8e9450c6)
 + drop vcs-svn experiment
 + make git-fast-import a builtin
 + make git-bugreport a builtin
 + make credential helpers builtins
 + Makefile: drop builtins from MSVC pdb list

 Trim an unused binary and turn a bunch of commands into built-in.


* jk/xrealloc-avoid-use-after-free (2020-09-02) 1 commit
  (merged to 'next' on 2020-09-02 at a1ad92fe1c)
 + xrealloc: do not reuse pointer freed by zero-length realloc()

 It was possible for xrealloc() to send a non-NULL pointer that has
 been freed, which has been fixed.


* jt/fetch-pack-loosen-validation-with-packfile-uri (2020-08-24) 3 commits
  (merged to 'next' on 2020-08-27 at efd171f172)
 + fetch-pack: make packfile URIs work with transfer.fsckobjects
 + fetch-pack: document only_packfile in get_pack()
 + (various): document from_promisor parameter

 Bugfix for "git fetch" when the packfile URI capability is in use.


* jt/lazy-fetch (2020-09-02) 8 commits
  (merged to 'next' on 2020-09-02 at 1f8cd016d4)
 + fetch: no FETCH_HEAD display if --no-write-fetch-head
  (merged to 'next' on 2020-08-27 at 85f2319ba1)
 + fetch-pack: remove no_dependents code
 + promisor-remote: lazy-fetch objects in subprocess
 + fetch-pack: do not lazy-fetch during ref iteration
 + fetch: only populate existing_refs if needed
 + fetch: avoid reading submodule config until needed
 + fetch: allow refspecs specified through stdin
 + negotiator/noop: add noop fetch negotiator

 Updates to on-demand fetching code in lazily cloned repositories.


* mr/diff-hide-stat-wo-textual-change (2020-08-19) 1 commit
  (merged to 'next' on 2020-08-27 at b9e97254ae)
 + diff: teach --stat to ignore uninteresting modifications

 "git diff --stat -w" showed 0-line changes for paths whose changes
 were only whitespaces, which was not intuitive.  We now omit such
 paths from the stat output.


* pb/doc-external-diff-env (2020-09-01) 1 commit
  (merged to 'next' on 2020-09-02 at a789fe3fd9)
 + git.txt: correct stale 'GIT_EXTERNAL_DIFF' description

 Doc update.


* pb/doc-sequence-editor-configuration (2020-08-31) 1 commit
  (merged to 'next' on 2020-08-31 at 506466270c)
 + doc: mention GIT_SEQUENCE_EDITOR and 'sequence.editor' more

 Doc update.


* pw/add-p-allowed-options-fix (2020-08-17) 2 commits
  (merged to 'next' on 2020-08-27 at 6cd62753f7)
 + add -p: fix checking of user input
 + add -p: use ALLOC_GROW_BY instead of ALLOW_GROW

 "git add -p" update.


* pw/rebase-i-more-options (2020-08-26) 6 commits
  (merged to 'next' on 2020-08-27 at c55cfeb247)
 + t3436: do not run git-merge-recursive in dashed form
  (merged to 'next' on 2020-08-21 at ade71fd49b)
 + rebase: add --reset-author-date
 + rebase -i: support --ignore-date
 + rebase -i: support --committer-date-is-author-date
 + am: stop exporting GIT_COMMITTER_DATE
 + rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.


* so/pretty-abbrev-doc (2020-08-27) 1 commit
  (merged to 'next' on 2020-08-31 at d664bd0c06)
 + pretty-options.txt: fix --no-abbrev-commit description

 Documentation update for "--no-abbrev-commit".


* ss/t7401-modernize (2020-08-21) 5 commits
  (merged to 'next' on 2020-08-27 at 516cba9c64)
 + t7401: add a NEEDSWORK
 + t7401: change indentation for enhanced readability
 + t7401: change syntax of test_i18ncmp calls for clarity
 + t7401: use 'short' instead of 'verify' and cut in rev-parse calls
 + t7401: modernize style

 Test clean-up.

--------------------------------------------------
[New Topics]

* js/ci-squelch-false-failure (2020-09-02) 2 commits
  (merged to 'next' on 2020-09-03 at 254f390305)
 + ci: avoid ugly "failure" in the `ci-config` job
 + ci: fix indentation of the `ci-config` job

 CI noise reduction.

 Will merge to 'master'.


* pb/clang-json-compilation-database (2020-09-02) 1 commit
 - Makefile: add support for generating JSON compilation database

 Developer support.

 Waiting for a response to a sanity check.
 cf. <xmqq1rjkccw8.fsf@gitster.c.googlers.com>


* os/vcbuild (2020-09-03) 2 commits
  (merged to 'next' on 2020-09-03 at 0216ec9cb9)
 + vcbuild: fix batch file name in README
 + vcbuild: fix library name for expat with make MSVC=1

 Fix build procedure for MSVC.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* vv/send-email-with-less-secure-apps-access (2020-08-29) 1 commit
 - Documentation/git-send-email.txt: Mention less secure app access might need to enable.

 Doc update.

 Expecting a reroll.
 cf. <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
 cf. <xmqqft85i72s.fsf@gitster.c.googlers.com>


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* tb/bloom-improvements (2020-08-11) 14 commits
 - builtin/commit-graph.c: introduce '--max-new-filters=<n>'
 - commit-graph: rename 'split_commit_graph_opts'
 - commit-graph: add large-filters bitmap chunk
 - commit-graph.c: sort index into commits list
 - bloom/diff: properly short-circuit on max_changes
 - bloom: use provided 'struct bloom_filter_settings'
 - csum-file.h: introduce 'hashwrite_be64()'
 - bloom: split 'get_bloom_filter()' in two
 - commit-graph.c: store maximum changed paths
 - commit-graph: respect 'commitGraph.readChangedPaths'
 - t/helper/test-read-graph.c: prepare repo settings
 - commit-graph: pass a 'struct repository *' in more places
 - t4216: use an '&&'-chain
 - commit-graph: introduce 'get_bloom_filter_settings()'

 Misc Bloom filter improvements.

 Expecting a reroll.
 It seems that the review is getting closer to result in another update.
 cf. <20200811220503.GC66656@syl.lan>


* es/config-hooks (2020-07-30) 6 commits
 - hook: add 'run' subcommand
 - parse-options: parse into argv_array
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting a reroll.
 Now jk/strvec is in 'master', we may want to see the topic reworked
 on top of it.  Are there unresolved issues, or does the topic need
 a round of detailed review?
 cf. <xmqqmu3i9kvg.fsf@gitster.c.googlers.com>


* ls/mergetool-meld-auto-merge (2020-07-12) 2 commits
 - SQUASH???
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Expecting a reroll.


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* mt/grep-sparse-checkout (2020-09-02) 8 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: unify exit labels
 - t/helper/test-config: check argc before accessing argv
 - t/helper/test-config: be consistent with exit codes
 - t1308-config-set: avoid false positives when using test-config
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.


* jt/interpret-branch-name-fallback (2020-09-02) 3 commits
  (merged to 'next' on 2020-09-03 at 28914ab788)
 + wt-status: tolerate dangling marks
 + refs: move dwim_ref() to header file
 + sha1-name: replace unsigned int with option struct

 "git status" has trouble showing where it came from by interpreting
 reflog entries that recordcertain events, e.g. "checkout @{u}", and
 gives a hard/fatal error.  Even though it inherently is impossible
 to give a correct answer because the reflog entries lose some
 information (e.g. "@{u}" does not record what branch the user was
 on hence which branch 'the upstream' needs to be computed, and even
 if the record were available, the relationship between branches may
 have changed), at least hide the error to allow "status" show its
 output.

 Will merge to 'master'.


* pb/imap-send-updates (2020-08-31) 3 commits
  (merged to 'next' on 2020-09-02 at 899fca3919)
 + git-imap-send.txt: add note about localized Gmail folders
 + git-imap-send.txt: do verify SSL certificate for gmail.com
 + git-imap-send.txt: don't duplicate 'Examples' sections

 "git imap-send" updates.

 Will merge to 'master'.


* so/separate-field-for-m-and-diff-merges (2020-08-31) 1 commit
  (merged to 'next' on 2020-08-31 at 8def2984ca)
 + revision: add separate field for "-m" of "diff-index -m"

 Internal API clean-up to handle two options "diff-index" and "log"
 have, which happen to share the same short form, more sensibly.

 Will merge to 'master'.


* ew/decline-core-abbrev (2020-09-01) 1 commit
 - core.abbrev <off|false|no> disables abbreviations

 Allow the configuration to specify no abbreviation regardless of
 the hash algorithm.

 Expecting a reroll.  The intent is very good.


* mr/bisect-in-c-2 (2020-08-31) 13 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the "git bisect" script in C continues.

 At v7; getting close
 cf. <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>


* tb/repack-clearing-midx (2020-08-28) 2 commits
  (merged to 'next' on 2020-08-28 at 4204c0cb5e)
 + midx: traverse the local MIDX first
  (merged to 'next' on 2020-08-27 at a465875cbb)
 + builtin/repack.c: invalidate MIDX only when necessary

 When a packfile is removed by "git repack", multi-pack-index gets
 cleared; the code was taught to do so less aggressively by first
 checking if the midx actually refers to a pack that no longer
 exists.

 Will merge to 'master'.


* es/worktree-repair (2020-08-31) 5 commits
  (merged to 'next' on 2020-08-31 at 604825c5e4)
 + init: make --separate-git-dir work from within linked worktree
 + init: teach --separate-git-dir to repair linked worktrees
 + worktree: teach "repair" to fix outgoing links to worktrees
 + worktree: teach "repair" to fix worktree back-links to main worktree
 + worktree: add skeleton "repair" command

 "git worktree" gained a "repair" subcommand to help users recover
 after moving the worktrees or repository manually without telling
 Git.  Also, "git init --separate-git-dir" no longer corrupts
 administrative data related to linked worktrees.

 Will merge to 'master'.


* jk/worktree-check-clean-leakfix (2020-08-27) 1 commit
  (merged to 'next' on 2020-08-31 at 220fc43629)
 + worktree: fix leak in check_clean_worktree()

 Leakfix.

 Will merge to 'master'.


* ss/submodule-summary-in-c-fixes (2020-08-27) 3 commits
  (merged to 'next' on 2020-09-02 at 7f959811b8)
 + t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
 + submodule: fix style in function definition
 + submodule: eliminate unused parameters from print_submodule_summary()
 (this branch uses ss/submodule-summary-in-c.)

 Fixups to a topic in 'next'.

 Will merge to 'master'.


* js/no-builtins-on-disk-option (2020-08-24) 3 commits
 - ci: stop linking built-ins to the dashed versions
 - install: optionally skip linking/copying the built-ins
 - msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.

 Expecting a reroll to update log message for the last one.
 as it confused at least two reviewers.
 cf. <xmqqwo1baop3.fsf@gitster.c.googlers.com>
 cf. <20200903104537.GA27325@szeder.dev>


* jt/threaded-index-pack (2020-08-27) 9 commits
 - builtin/index-pack.c: fix some sparse warnings
 - fixup! index-pack: make quantum of work smaller
 - index-pack: make quantum of work smaller
 - index-pack: make resolve_delta() assume base data
 - index-pack: calculate {ref,ofs}_{first,last} early
 - index-pack: remove redundant child field
 - index-pack: unify threaded and unthreaded code
 - index-pack: remove redundant parameter
 - Documentation: deltaBaseCacheLimit is per-thread

 "git index-pack" learned to resolve deltified objects with greater
 parallelism.

 Expecting the final reroll.
 cf. https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-08-31#l82


* hv/ref-filter-misc (2020-08-28) 8 commits
  (merged to 'next' on 2020-09-02 at 9a8bb84f20)
 + ref-filter: add `sanitize` option for 'subject' atom
 + pretty: refactor `format_sanitized_subject()`
 + ref-filter: add `short` modifier to 'parent' atom
 + ref-filter: add `short` modifier to 'tree' atom
 + ref-filter: rename `objectname` related functions and fields
 + ref-filter: modify error messages in `grab_objectname()`
 + ref-filter: refactor `grab_objectname()`
 + ref-filter: support different email formats

 The "--format=" option to the "for-each-ref" command and friends
 learned a few more tricks, e.g. the ":short" suffix that applies to
 "objectname" now also can be used for "parent", "tree", etc.

 Will merge to 'master'.


* jk/refspecs-negative (2020-08-21) 1 commit
 - refspec: add support for negative refspecs

 "negative refspecs"


* jx/proc-receive-hook (2020-08-27) 10 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: feed report options to post-receive
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Looking good.


* ds/maintenance-part-2 (2020-08-25) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch uses ds/maintenance-part-1.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.


* ss/submodule-summary-in-c (2020-08-12) 4 commits
  (merged to 'next' on 2020-08-17 at 9bc352cb70)
 + submodule: port submodule subcommand 'summary' from shell to C
 + t7421: introduce a test script for verifying 'summary' output
 + submodule: rename helper functions to avoid ambiguity
 + submodule: remove extra line feeds between callback struct and macro
 (this branch is used by ss/submodule-summary-in-c-fixes.)

 Yet another subcommand of "git submodule" is getting rewritten in C.

 Will merge to 'master'.


* ds/maintenance-part-1 (2020-08-25) 11 commits
 - maintenance: add trace2 regions for task execution
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 (this branch is used by ds/maintenance-part-2.)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.

 Almost ready for 'next'.
 cf. https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-08-31#l44

--------------------------------------------------
[Discarded]

* jc/remove-pack-redundant (2020-08-25) 1 commit
 . pack-redundant: gauge the usage before proposing its removal

 The first step to remove "git pack-redundant" by soliciting
 objections.

 Stop--we had some activity as late as last year.
