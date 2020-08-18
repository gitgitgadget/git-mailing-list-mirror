Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84AAC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D46F2065D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CKvx0ixX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHRWuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:50:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54013 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRWuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:50:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4233E7C1C9;
        Tue, 18 Aug 2020 18:50:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=w
        L0KhjH6hkA3OOnGwiijT9vXhaU=; b=CKvx0ixXzRAePni3OBvMHQWTbf7WR1bLM
        UDE35ZRuqPZC/sGOQL4sy42CJF5rtg8cEw5mFmdVJQ/qkSQUW6Vv3L/qcM1yZda4
        T0t0fQl+fw68Lej4VeFgcSrFQmZ6XbngtpR0kDmKOFACPi8j7DEWQ0OS2y57QZdj
        X976YlG0W8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=I5R
        sLDFPfUrnL9OEsxjrHwdiko9YvurTdbqiiOl3QdjhDuO14jYrJKlO9HU9tT4ew5K
        e+Hq4+Y4pDYxT3sYUL+fCtPeya+/P+dKMY4z1TSBsrGZUh63rlL+9dn9XShWkvio
        B1KaD/CjW2exHLj33AMByD4O/EiGqcRI0s5Spu34=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38C8B7C1C8;
        Tue, 18 Aug 2020 18:50:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EACA7C1C5;
        Tue, 18 Aug 2020 18:50:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2020, #04; Tue, 18)
X-master-at: 2befe97201e1f3175cce557866c5822793624b5a
X-next-at: 76ed4a4daf6aec5583ad1c21b86f032a08bf353f
Date:   Tue, 18 Aug 2020 15:50:10 -0700
Message-ID: <xmqqft8jwov1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C1C114C-E1A5-11EA-90DC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* al/bisect-first-parent (2020-08-07) 5 commits
  (merged to 'next' on 2020-08-11 at b232f7ca17)
 + bisect: combine args passed to find_bisection()
 + bisect: introduce first-parent flag
 + cmd_bisect__helper: defer parsing no-checkout flag
 + rev-list: allow bisect and first-parent flags
 + t6030: modernize "git bisect run" tests

 "git bisect" learns the "--first-parent" option to find the first
 breakage along the first-parent chain.


* dd/send-email-config (2020-07-23) 1 commit
  (merged to 'next' on 2020-08-11 at aaf9f3a301)
 + git-send-email: die if sendmail.* config is set

 Stop when "sendmail.*" configuration variables are defined, which
 could be a mistaken attempt to define "sendemail.*" variables.


* es/test-cmp-typocatcher (2020-08-09) 1 commit
  (merged to 'next' on 2020-08-11 at ee5557b170)
 + test_cmp: diagnose incorrect arguments

 Test framework update.


* hn/reftable-prep-part-2 (2020-07-27) 3 commits
  (merged to 'next' on 2020-08-11 at 43ac0bc60a)
 + Make HEAD a PSEUDOREF rather than PER_WORKTREE.
 + Modify pseudo refs through ref backend storage
 + t1400: use git rev-parse for testing PSEUDOREF existence

 Further preliminary change to refs API.


* jc/noop-with-static-inline (2020-08-06) 1 commit
  (merged to 'next' on 2020-08-11 at 8a63ff648e)
 + compat-util: type-check parameters of no-op replacement functions

 A no-op replacement function implemented as a C preprocessor macro
 does not perform as good a job as one implemented as a "static
 inline" function in catching errors in parameters; replace the
 former with the latter in <git-compat-util.h> header.


* jk/log-fp-implies-m (2020-07-29) 7 commits
  (merged to 'next' on 2020-08-03 at 39fefa6b82)
 + doc/git-log: clarify handling of merge commit diffs
 + doc/git-log: move "-t" into diff-options list
 + doc/git-log: drop "-r" diff option
 + doc/git-log: move "Diff Formatting" from rev-list-options
 + log: enable "-m" automatically with "--first-parent"
 + revision: add "--no-diff-merges" option to counteract "-m"
 + log: drop "--cc implies -m" logic
 (this branch is used by so/log-diff-merges-opt.)

 Originally merged to 'next' on 2020-08-01

 "git log --first-parent -p" showed patches only for single-parent
 commits on the first-parent chain; the "--first-parent" option has
 been made to imply "-m".  Use "--no-diff-merges" to restore the
 previous behaviour to omit patches for merge commits.

 Will merge to 'master' together with 'so/log-diff-merges-opt'


* jk/sideband-error-l10n (2020-08-07) 1 commit
  (merged to 'next' on 2020-08-11 at 27dbe05a65)
 + sideband: mark "remote error:" prefix for translation

 Mark error message for i18n.


* ma/stop-progress-null-fix (2020-08-10) 1 commit
  (merged to 'next' on 2020-08-13 at 8bdec5209f)
 + progress: don't dereference before checking for NULL

 NULL dereference fix.


* pd/mergetool-nvimdiff (2020-07-29) 2 commits
  (merged to 'next' on 2020-08-11 at 947ce686d0)
 + mergetools: add support for nvimdiff (neovim) family
 + mergetool--lib: improve support for vimdiff-style tool variants

 The existing backends for "git mergetool" based on variants of vim
 have been refactored and then support for "nvim" has been added.


* ps/ref-transaction-hook (2020-08-11) 2 commits
  (merged to 'next' on 2020-08-11 at 311c045810)
 + t1416: avoid hard-coded sha1 ids
  (merged to 'next' on 2020-08-10 at d8ad7cc8f6)
 + refs: fix interleaving hook calls with reference-transaction hook

 The logic to find the ref transaction hook script attempted to
 cache the path to the found hook without realizing that it needed
 to keep a copied value, as the API it used returned a transitory
 buffer space.  This has been corrected.
 to be followed by a removal of the caching feature, which does not
 seem to help even as a negative cache.


* rp/apply-cached-with-i-t-a (2020-08-09) 3 commits
  (merged to 'next' on 2020-08-11 at c28eaa6a0e)
 + t4140: test apply with i-t-a paths
 + apply: make i-t-a entries never match worktree
 + apply: allow "new file" patches on i-t-a entries

 Recent versions of "git diff-files" shows a diff between the index
 and the working tree for "intent-to-add" paths as a "new file"
 patch; "git apply --cached" should be able to take "git diff-files"
 and should act as an equivalent to "git add" for the path, but the
 command failed to do so for such a path.


* so/log-diff-merges-opt (2020-08-11) 3 commits
  (merged to 'next' on 2020-08-11 at 99e070bdca)
 + t/t4013: add test for --diff-merges=off
 + doc/git-log: describe --diff-merges=off
 + revision: change "--diff-merges" option to require parameter
 (this branch uses jk/log-fp-implies-m.)

 Earlier, to countermand the implicit "-m" option when the
 "--first-parent" option is used with "git log", we added the
 "--[no-]diff-merges" option in the jk/log-fp-implies-m topic.  To
 leave the door open to allow the "--diff-merges" option to take
 values that instructs how patches for merge commits should be
 computed (e.g. "cc"? "-p against first parent?"), redefine
 "--diff-merges" to take non-optional value, and implement "off"
 that means the same thing as "--no-diff-merges".

 Will merge to 'master' together with 'jk/lo-implies-m'.

--------------------------------------------------
[New Topics]

* bc/sha-256-doc-updates (2020-08-13) 2 commits
  (merged to 'next' on 2020-08-17 at 7154a0ce3c)
 + docs: fix step in transition plan
 + docs: document SHA-256 pack and indices

 Further update of docs to adjust to the recent SHA-256 work.

 Will merge to 'master'.


* ma/sha-256-docs (2020-08-17) 4 commits
  (merged to 'next' on 2020-08-17 at 6861142a20)
 + shallow.txt: document SHA-256 shallow format
 + protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
 + index-format.txt: document SHA-256 index format
 + http-protocol.txt: document SHA-256 "want"/"have" format

 Further update of docs to adjust to the recent SHA-256 work.

 Will merge to 'master'.


* dd/diff-customize-index-line-abbrev (2020-08-13) 2 commits
 - diff: index-line: respect --abbrev in object's name
 - revision: differentiate if --no-abbrev asked explicitly

 The output from the "diff" family of the commands had abbreviated
 object names of blobs involved in the patch, but its length was not
 affected by the --abbrev option.  Now it is.

 The first patch is unneeded.


* ds/sha256-leftover-bits (2020-08-17) 3 commits
  (merged to 'next' on 2020-08-17 at a8e6f9f3f4)
 + multi-pack-index: use hash version byte
 + commit-graph: use the "hash version" byte
 + t/README: document GIT_TEST_DEFAULT_HASH

 midx and commit-graph files now use the byte defined in their file
 format specification for identifying the hash function used for
 object names.

 Will merge to 'master'.


* hn/refs-fetch-head-is-special (2020-08-17) 4 commits
 - refs: read FETCH_HEAD generically
 - refs: move gitdir into base ref_store
 - refs: fix comment about submodule ref_stores
 - Split off reading loose ref data in separate function
 (this branch is used by hn/refs-pseudorefs.)

 The FETCH_HEAD is now always read from the filesystem regardless of
 the ref backend in use, as its format is much richer than the
 normal refs, and written directly by "git fetch" as a plain file..


* hv/ref-filter-misc (2020-08-17) 9 commits
 - ref-filter: add `sanitize` option for 'subject' atom
 - format-support: move `format_sanitized_subject()` from pretty
 - pretty: refactor `format_sanitized_subject()`
 - ref-filter: add `short` modifier to 'parent' atom
 - ref-filter: add `short` modifier to 'tree' atom
 - ref-filter: rename `objectname` related functions and fields
 - ref-filter: modify error messages in `grab_objectname()`
 - ref-filter: refactor `grab_objectname()`
 - ref-filter: support different email formats

 The "--format=" option to the "for-each-ref" command and friends
 learned a few more tricks, e.g. the ":short" suffix that applies to
 "objectname" now also can be used for "parent", "tree", etc.


* jc/object-names-are-not-sha-1 (2020-08-14) 1 commit
  (merged to 'next' on 2020-08-17 at 400fe9e831)
 + messages: avoid SHA-1 in end-user facing messages

 A few end-user facing messages have been update to be
 hash-algorithm agnostic.

 Will merge to 'master'.


* jh/mingw-unlink (2020-08-17) 1 commit
  (merged to 'next' on 2020-08-17 at fb53a3d1a1)
 + mingw: improve performance of mingw_unlink()

 "unlink" emulation on MinGW has been optimized.

 Will merge to 'master'.


* jk/leakfix (2020-08-17) 7 commits
 - submodule--helper: fix leak of core.worktree value
 - config: fix leak in git_config_get_expiry_in_days()
 - config: drop git_config_get_string_const()
 - config: fix leaks from git_config_get_string_const()
 - checkout: fix leak of non-existent branch names
 - submodule--helper: use strbuf_release() to free strbufs
 - clear_pattern_list(): clear embedded hashmaps

 Code clean-up.

 Will merge to 'next'.


* jk/refspecs-negative (2020-08-17) 3 commits
 - refspec: add support for negative refspecs
 - refspec: make sure stack refspec_item variables are zeroed
 - refspec: fix documentation referring to refspec_item

 "negative refspecs"


* jt/fetch-pack-loosen-validation-with-packfile-uri (2020-08-14) 1 commit
 - fetch-pack: make packfile URIs work with transfer.fsckobjects

 Bugfix for "git fetch" when the packfile URI capability is in use.

 Need to pick up a reroll.


* mr/diff-hide-stat-wo-textual-change (2020-08-17) 1 commit
 - diff: teach --stat to ignore uninteresting modifications

 Expecting a reroll.


* pw/add-p-allowed-options-fix (2020-08-17) 2 commits
 - add -p: fix checking of user input
 - add -p: use ALLOC_GROW_BY instead of ALLOW_GROW

 "git add -p" update.

 Doubts?
 cf. <pull.702.git.1597670589.gitgitgadget@gmail.com>


* dl/subtree-docs (2020-08-18) 2 commits
 - contrib/subtree: document 'push' does not take '--squash'
 - contrib/subtree: fix "unsure" for --message in the document

 Doc updates for subtree (in contrib/)

 Will merge to 'next'.


* en/mem-pool (2020-08-18) 3 commits
 - mem-pool: use consistent pool variable name
 - mem-pool: use more standard initialization and finalization
 - mem-pool: add convenience functions for strdup and strndup

 API update.

 Will merge to 'next'.


* jc/no-update-fetch-head (2020-08-18) 1 commit
 - fetch: optionally allow disabling FETCH_HEAD update
 (this branch is used by ds/maintenance-part-1, ds/maintenance-part-2 and jt/lazy-fetch.)

 "git fetch" learned --no-write-fetch-head option to avoid writing
 the FETCH_HEAD file.

 Will merge to 'next'.


* jt/lazy-fetch (2020-08-18) 7 commits
 - fetch-pack: remove no_dependents code
 - promisor-remote: lazy-fetch objects in subprocess
 - fetch-pack: do not lazy-fetch during ref iteration
 - fetch: only populate existing_refs if needed
 - fetch: avoid reading submodule config until needed
 - fetch: allow refspecs specified through stdin
 - negotiator/noop: add noop fetch negotiator
 (this branch uses jc/no-update-fetch-head; is tangled with ds/maintenance-part-1 and ds/maintenance-part-2.)

 Updates to on-demand fetching code in lazily cloned repositories.



* mt/checkout-entry-dead-code-removal (2020-08-18) 1 commit
 - checkout_entry(): remove unreachable error() call

 Code clean-up.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* mt/grep-sparse-checkout (2020-06-12) 6 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: facilitate addition of new cli options
 - t/helper/test-config: return exit codes consistently
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Review needed on 4/6; otherwise looking sane.
 cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>


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


* mr/bisect-in-c-2 (2020-07-17) 14 commits
 . SQUASH??? do not add new users of git_path_bisect_head()
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: finish porting `bisect_start()` to C
 . bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 . bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 . bisect--helper: reimplement `bisect_autostart` shell function in C
 . bisect--helper: introduce new `write_in_file()` function
 . bisect--helper: use '-res' in 'cmd_bisect__helper' return
 . bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the remainder of "git bisect" script in C continues.

 Needs more work.
 Ejected out of 'seen'; al/bisect-first-parent topic has a bit of
 textual conflict with this topic.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* jx/proc-receive-hook (2020-08-17) 10 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - receive-pack: feed report options to post-receive
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


* pw/rebase-i-more-options (2020-08-17) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - rebase -i: support --committer-date-is-author-date
 - am: stop exporting GIT_COMMITTER_DATE
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Waiting for a (hopefully final) review.


* rs/more-buffered-io (2020-08-17) 3 commits
 - upload-pack: use buffered I/O to talk to rev-list
 - midx: use buffered I/O to talk to pack-objects
 - connected: use buffered I/O to talk to rev-list

 Use more buffered I/O where we used to call many small write(2)s.

 Will merge to 'next'.


* en/merge-tests (2020-08-10) 11 commits
  (merged to 'next' on 2020-08-13 at eab952350b)
 + t6425: be more flexible with rename/delete conflict messages
 + t642[23]: be more flexible for add/add conflicts involving pair renames
 + t6422, t6426: be more flexible for add/add conflicts involving renames
 + t6423: add an explanation about why one of the tests does not pass
 + t6416, t6423: clarify some comments and fix some typos
 + t6422: fix multiple errors with the mod6 test expectations
 + t6423: fix test setup for a couple tests
 + t6416, t6422: fix incorrect untracked file count
 + t6422: fix bad check against missing file
 + t6418: tighten delete/normalize conflict testcase
 + Collect merge-related tests to t64xx

 Updates to "git merge" tests, in preparation for a new merge
 strategy backend.

 Will merge to 'master'.


* ds/midx-repack-to-batch-size (2020-08-11) 1 commit
  (merged to 'next' on 2020-08-17 at eee94634aa)
 + multi-pack-index: repack batches below --batch-size

 The "--batch-size" option of "git multi-pack-index repack" command
 is now used to specify that very small packfiles are collected into
 one until the total size roughly exceeds it.

 Will merge to 'master'.


* rs/upload-pack-sigchain-fix (2020-08-11) 1 commit
  (merged to 'next' on 2020-08-17 at 997473f309)
 + upload-pack: remove superfluous sigchain_pop() call

 Code clean-up.

 Will merge to 'master'.


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


* ak/sequencer-fix-find-uniq-abbrev (2020-08-13) 1 commit
  (merged to 'next' on 2020-08-17 at 6ce0f1d111)
 + rebase -i: fix possibly wrong onto hash in todo

 Ring buffer with size 4 used for bin-hex translation resulted in a
 wrong object name in the sequencer's todo output, which has been
 corrected.

 Will merge to 'master'.


* en/dir-nonbare-embedded (2020-08-12) 2 commits
  (merged to 'next' on 2020-08-17 at ab180b7fcb)
 + dir: avoid prematurely marking nonbare repositories as matches
 + t3000: fix some test description typos

 "ls-files -o" mishandled the top-level directory of another git
 working tree that hangs in the current git working tree.

 Will merge to 'master'.


* en/sequencer-merge-labels (2020-08-14) 1 commit
  (merged to 'next' on 2020-08-17 at 2010e329ed)
 + sequencer: avoid garbled merge machinery messages due to commit labels

 The commit labels used to explain each side of conflicted hunks
 placed by the sequencer machinery have been made more readable by
 humans.

 Will merge to 'master'.


* jb/commit-graph-doc-fix (2020-08-13) 1 commit
  (merged to 'next' on 2020-08-17 at d83ee98955)
 + docs: commit-graph: fix some whitespace in the diagram

 Docfix.

 Will merge to 'master'.


* jk/blame-coalesce-fix (2020-08-13) 3 commits
  (merged to 'next' on 2020-08-17 at 122c701ec7)
 + blame: only coalesce lines that are adjacent in result
 + t8003: factor setup out of coalesce test
 + t8003: check output of coalesced blame

 When given more than one target line ranges, "git blame -La,b
 -Lc,d" was over-eager to coalesce groups of original lines and
 showed incorrect results, which has been corrected.

 Will merge to 'master'.


* jk/slimmed-down (2020-08-13) 5 commits
 - drop vcs-svn experiment
 - make git-fast-import a builtin
 - make git-bugreport a builtin
 - make credential helpers builtins
 - Makefile: drop builtins from MSVC pdb list

 Trim an unused binary and turn a bunch of commands into built-in.

 In general this is a good thing to do, modulo 'bugreport'.


* jk/unleak-fixes (2020-08-13) 2 commits
  (merged to 'next' on 2020-08-17 at f9bd296b25)
 + ls-remote: simplify UNLEAK() usage
 + stop calling UNLEAK() before die()

 Fix some incorrect UNLEAK() annotations.

 Will merge to 'master'.


* pb/set-url-docfix (2020-08-13) 1 commit
  (merged to 'next' on 2020-08-17 at 19b56c6ebb)
 + fetch, pull doc: correct description of '--set-upstream'

 Doc fix.

 Will merge to 'master'.


* pb/userdiff-fortran-update (2020-08-13) 2 commits
  (merged to 'next' on 2020-08-17 at 534af3f35a)
 + userdiff: improve Fortran xfuncname regex
 + userdiff: add tests for Fortran xfuncname regex

 The regexp to identify the function boundary for FORTRAN programs
 has been updated.

 Will merge to 'master'.


* rs/preserve-merges-unused-code-removal (2020-08-12) 1 commit
  (merged to 'next' on 2020-08-17 at b96393455c)
 + rebase: remove unused function reschedule_last_action

 Code clean-up.

 Will merge to 'master'.


* ss/t7401-modernize (2020-08-12) 4 commits
 - t7401: add a NEEDSWORK
 - t7401: change indentation for enhanced readability
 - t7401: change test_i18ncmp syntax for clarity
 - t7401: modernize style

 Test clean-up.

 Expecting a reroll.
 cf. <c70f7bb5d1289f5318da7b99e41cf5828a451174.camel@gmail.com>
 Almost there, it seems.


* ds/maintenance-part-2 (2020-08-18) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch uses ds/maintenance-part-1 and jc/no-update-fetch-head; is tangled with jt/lazy-fetch.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.


* ma/doc-sha-256-is-experimental (2020-08-17) 1 commit
 - Documentation: mark `--object-format=sha256` as experimental

 The recent addition of SHA-256 support is marked as experimental in
 the documentation.

 Will merge to 'next'.


* ss/submodule-summary-in-c (2020-08-12) 4 commits
  (merged to 'next' on 2020-08-17 at 9bc352cb70)
 + submodule: port submodule subcommand 'summary' from shell to C
 + t7421: introduce a test script for verifying 'summary' output
 + submodule: rename helper functions to avoid ambiguity
 + submodule: remove extra line feeds between callback struct and macro

 Yet another subcommand of "git submodule" is getting rewritten in C.

 Will merge to 'master'.


* am/ci-wsfix (2020-08-10) 1 commit
 - ci: fix inconsistent indentation

 Aesthetic fix to a CI configuration file.

 Waiting for a reroll.
 It needs a better log message.


* es/init-no-separate-git-dir-in-bare (2020-08-10) 1 commit
  (merged to 'next' on 2020-08-17 at 80498c8659)
 + init: disallow --separate-git-dir with bare repository

 The purpose of "git init --separate-git-dir" is to initialize a
 new project with the repository separate from the working tree,
 or, in the case of an existing project, to move the repository
 (the .git/ directory) out of the working tree. It does not make
 sense to use --separate-git-dir with a bare repository for which
 there is no working tree, so disallow its use with bare
 repositories.

 Will merge to 'master'.


* rp/ita-diff-modefix (2020-08-09) 1 commit
  (merged to 'next' on 2020-08-17 at c03a9cfb6e)
 + diff-lib: use worktree mode in diffs from i-t-a entries

 "git diff [<tree-ish>] $path" for a $path that is marked with i-t-a
 bit was not showing the mode bits from the working tree.

 Will merge to 'master'.


* ds/maintenance-part-1 (2020-08-18) 11 commits
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
 (this branch is used by ds/maintenance-part-2; uses jc/no-update-fetch-head; is tangled with jt/lazy-fetch.)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.


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

--------------------------------------------------
[Discarded]

* rs/fast-export-anon-simplify (2020-08-13) 1 commit
 . fast-export: factor out print_oid()

 Code simplification.

 Retracted.
 cf. <6e2d4472-8293-4f10-0ba6-82ae83f7a465@web.de>


* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 . hex: make hash_to_hex_algop() and friends thread-safe
 . compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Retracted.
 cf. <CAHd-oW7Wd8oSaMhPFeRcEeKTJ-k_hC7b6e28efhXT5LFu1E_Uw@mail.gmail.com>
