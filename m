Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD2C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC822B4B
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 19:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IiXk2EJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgHJTog (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:44:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgHJToe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 15:44:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79FC37BE9A;
        Mon, 10 Aug 2020 15:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=T
        BqlDBwupYucdDM82VzaBzsc5Ok=; b=IiXk2EJhXxuD8Bst4KzhA/l2JUr1DTxMd
        OdRVNvTnC119w2Ksvoxeuvr7KAd+mKyUDt5vpwxbiLUHbF/4CBicAjQwZnA1pWrF
        mpbjdTEJWVodJFK6zbmkBctevVlhyUF2X1HAUp7oRAP7Oi6WJWH8S3ziDYngTrKR
        J0m7lkQXzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Jnx
        De/BUq5gQo+oR3qMPKA6nR19S9lzQBf3uqV2I+iThm2rfzoc9IeOJwNQ7FRgBbZo
        QgGTfif6EN2fk3UpD4Z43HAFbPMl5vLY1FhDfHjI03TZSUDZKHX5AvKGcyCNPvat
        i3EQVQTF+j3tibbvKSUCJ/mbW5/GETv6phoooBTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7292A7BE99;
        Mon, 10 Aug 2020 15:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3AFC7BE98;
        Mon, 10 Aug 2020 15:44:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2020, #02; Mon, 10)
X-master-at: 4f0a8be78499454eac3985b6e7e144b8376ab0a5
X-next-at: 1739fa56f16d224373590068a68d990fb82ab9d0
Date:   Mon, 10 Aug 2020 12:44:26 -0700
Message-ID: <xmqqsgcub811.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E62FF572-DB41-11EA-9672-01D9BED8090B-77302942!pb-smtp1.pobox.com
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

* en/eol-attrs-gotchas (2020-08-03) 4 commits
  (merged to 'next' on 2020-08-05 at 46e73f4c94)
 + checkout: support renormalization with checkout -m <paths>
 + merge: make merge.renormalize work for all uses of merge machinery
 + t6038: remove problematic test
 + t6038: make tests fail for the right reason

 All "mergy" operations that internally use the merge-recursive
 machinery should honor the merge.renormalize configuration, but
 many of them didn't.


* en/merge-recursive-comment-fixes (2020-08-02) 1 commit
  (merged to 'next' on 2020-08-04 at ec14b8ea94)
 + merge-recursive: fix unclear and outright wrong comments

 Comment fix.


* es/adjust-subtree-test-for-merge-msg-update (2020-08-03) 1 commit
  (merged to 'next' on 2020-08-04 at 634b1fcbac)
 + Revert "contrib: subtree: adjust test to change in fmt-merge-msg"

 Adjust tests in contrib/ to the recent change to fmt-merge-msg.


* es/worktree-cleanup (2020-07-31) 4 commits
  (merged to 'next' on 2020-08-04 at 798f642f66)
 + worktree: retire special-case normalization of main worktree path
 + worktree: drop bogus and unnecessary path munging
 + worktree: drop unused code from get_linked_worktree()
 + worktree: drop pointless strbuf_release()

 Code cleanup around "worktree" API implementation.


* jk/compiler-fixes-and-workarounds (2020-08-04) 3 commits
  (merged to 'next' on 2020-08-04 at a1caf8edbc)
 + revision: avoid leak when preparing bloom filter for "/"
 + revision: avoid out-of-bounds read/write on empty pathspec
 + config: work around gcc-10 -Wstringop-overflow warning

 Small fixes and workarounds.


* jk/strvec (2020-07-30) 11 commits
  (merged to 'next' on 2020-08-04 at 61addb841f)
 + strvec: rename struct fields
 + strvec: drop argv_array compatibility layer
 + strvec: update documention to avoid argv_array
 + strvec: fix indentation in renamed calls
 + strvec: convert remaining callers away from argv_array name
 + strvec: convert more callers away from argv_array name
 + strvec: convert builtin/ callers away from argv_array name
 + quote: rename sq_dequote_to_argv_array to mention strvec
 + strvec: rename files from argv-array to strvec
 + argv-array: rename to strvec
 + argv-array: use size_t for count and alloc
 (this branch is used by ds/maintenance and ds/maintenance-part-2.)

 The argv_array API is useful for not just managing argv but any
 "vector" (NULL-terminated array) of strings, and has seen adoption
 to a certain degree.  It has been renamed to "strvec" to reduce the
 barrier to adoption.


* jt/pack-objects-prefetch-in-batch (2020-07-21) 2 commits
  (merged to 'next' on 2020-08-03 at 29424e614d)
 + pack-objects: prefetch objects to be packed
 + pack-objects: refactor to oid_object_info_extended

 Originally merged to 'next' on 2020-08-01

 While packing many objects in a repository with a promissor remote,
 lazily fetching missing objects from the promissor remote one by
 one may be inefficient---the code now attempts to fetch all the
 missing objects in batch (obviously this won't work for a lazy
 clone that lazily fetches tree objects as you cannot even enumerate
 what blobs are missing until you learn which trees are missing).


* jt/pretend-object-never-come-from-elsewhere (2020-07-21) 1 commit
  (merged to 'next' on 2020-08-03 at 36cd23aae5)
 + sha1-file: make pretend_object_file() not prefetch

 Originally merged to 'next' on 2020-08-01

 The pretend-object mechanism checks if the given object already
 exists in the object store before deciding to keep the data
 in-core, but the check would have triggered lazy fetching of such
 an object from a promissor remote.


* ma/t1450-quotefix (2020-08-01) 1 commit
  (merged to 'next' on 2020-08-04 at 0e762e3553)
 + t1450: fix quoting of NUL byte when corrupting pack

 Test fix.


* mp/complete-show-color-moved (2020-07-15) 1 commit
  (merged to 'next' on 2020-08-03 at c90fea8e5e)
 + completion: add show --color-moved[-ws]

 Originally merged to 'next' on 2020-08-01

 Command line completion (in contrib/) update.
 A follow-up patch to reduce duplication may be warranted.


* ny/notes-doc-sample-update (2020-08-03) 1 commit
  (merged to 'next' on 2020-08-04 at a63dcb2c55)
 + docs: improve the example that illustrates git-notes path names

 Doc updates.


* pb/guide-docs (2020-08-04) 4 commits
  (merged to 'next' on 2020-08-05 at 031cab2bc2)
 + git.txt: add list of guides
 + Documentation: don't hardcode command categories twice
 + help: drop usage of 'common' and 'useful' for guides
 + command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'

 Update "git help guides" documentation organization.


* rs/bisect-oid-to-hex-fix (2020-08-02) 1 commit
  (merged to 'next' on 2020-08-04 at dc3c8ea699)
 + bisect: use oid_to_hex_r() instead of memcpy()+oid_to_hex()

 Code cleanup.


* so/rev-parser-errormessage-fix (2020-08-04) 1 commit
  (merged to 'next' on 2020-08-05 at dd9653da77)
 + revision: fix die() message for "--unpacked="

 Error message fix.

--------------------------------------------------
[New Topics]

* bc/sha-256-cvs-svn-updates (2020-08-05) 1 commit
  (merged to 'next' on 2020-08-07 at b1ce7e5ec5)
 + git-cvsexportcommit: support Perl before 5.10.1

 Portability fix.

 Will merge to 'master'.


* ds/maintenance-part-2 (2020-08-06) 9 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 - fetch: optionally allow disabling FETCH_HEAD update
 (this branch uses ds/maintenance.)


* jt/has_object (2020-08-06) 4 commits
  (merged to 'next' on 2020-08-07 at ed08abb693)
 + fsck: do not lazy fetch known non-promisor object
 + pack-objects: no fetch when allow-{any,promisor}
 + apply: do not lazy fetch when applying binary
 + sha1-file: introduce no-lazy-fetch has_object()

 A new helper function has_object() has been introduced to make it
 easier to mark object existence checks that do and don't want to
 trigger lazy fetches, and a few such checks are converted using it.

 Will merge to 'master'.


* ma/doc-sha-256-is-experimental (2020-08-06) 1 commit
 - Documentation: mark `--object-format=sha256` as experimental

 The recent addition of SHA-256 support is marked as experimental in
 the documentation.


* ma/test-quote-cleanup (2020-08-06) 2 commits
  (merged to 'next' on 2020-08-10 at 63a95c2926)
 + t4104: modernize and simplify quoting
 + t: don't spuriously close and reopen quotes

 Test cleanup.

 Will merge to 'master'.


* rp/apply-cached-with-i-t-a (2020-08-09) 3 commits
 - t4140: test apply with i-t-a paths
 - apply: make i-t-a entries never match worktree
 - apply: allow "new file" patches on i-t-a entries

 Recent versions of "git diff-files" shows a diff between the index
 and the working tree for "intent-to-add" paths as a "new file"
 patch; "git apply --cached" should be able to take "git diff-files"
 and should act as an equivalent to "git add" for the path, but the
 command failed to do so for such a path.

 Will merge to 'next'.


* rp/blame-first-parent-doc (2020-08-06) 1 commit
  (merged to 'next' on 2020-08-10 at 3fdbebe1ea)
 + blame-options.txt: document --first-parent option

 The "git blame --first-parent" option was not documented, but now
 it is.

 Will merge to 'master'.


* jc/noop-withstatic-inline (2020-08-06) 1 commit
 - compat-util: type-check parameters of no-op replacement functions

 A no-op replacement function implemented as a C preprocessor macro
 does not perform as good a job as one implemented as a "static
 inline" function in catching errors in parameters; replace the
 former with the latter in <git-compat-util.h> header.


* ps/ref-transaction-hook (2020-08-07) 1 commit
  (merged to 'next' on 2020-08-10 at d8ad7cc8f6)
 + refs: fix interleaving hook calls with reference-transaction hook

 The logic to find the ref transaction hook script attempted to
 cache the path to the found hook without realizing that it needed
 to keep a copied value, as the API it used returned a transitory
 buffer space.  This has been corrected.

 Will merge to 'master'.
 to be followed by a removal of the caching feature, which does not
 seem to help even as a negative cache.


* ss/submodule-summary-in-c (2020-08-06) 5 commits
 - submodule: port submodule subcommand 'summary' from shell to C
 - t7421: introduce a test script for verifying 'summary' output
 - submodule: rename helper functions to avoid ambiguity
 - submodule: remove extra line feeds between callback struct and macro
 - submodule: expose the '--for-status' option of summary

 Yet another subcommand of "git submodule" is getting rewritten in C.


* am/ci-wsfix (2020-08-10) 1 commit
 - ci: fix inconsistent indentation


* es/init-no-separate-git-dir-in-bare (2020-08-10) 1 commit
 - init: disallow --separate-git-dir with bare repository

 "git init --separate-git-dir" can be used in an existing repository
 with a working tree to move its .git/ directory away from the
 working tree.  Even though this re-init feature makes no sense in
 an existing bare repository, it was not erroring out.  Now it does.


* es/test-cmp-typocatcher (2020-08-09) 1 commit
 - test_cmp: diagnose incorrect arguments

 Test framework update.

 Will merge to 'next'.


* jk/sideband-error-l10n (2020-08-07) 1 commit
 - sideband: mark "remote error:" prefix for translation

 Mark error message for i18n.

 Will merge to 'next'.


* rp/ita-diff-modefix (2020-08-09) 1 commit
 - diff-lib: use worktree mode in diffs from i-t-a entries

 "git diff [<tree-ish>] $path" for a $path that is marked with i-t-a
 bit was not showing the mode bits from the working tree.

--------------------------------------------------
[Stalled]

* pw/rebase-i-more-options (2020-07-16) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Waiting for a (hopefully final) review.


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


* rs/more-buffered-io (2020-08-02) 3 commits
 - upload-pack: use buffered I/O to talk to rev-list
 - midx: use buffered I/O to talk to pack-objects
 - connected: use buffered I/O to talk to rev-list

 Expecting a reroll.


* ls/mergetool-meld-auto-merge (2020-07-12) 2 commits
 - SQUASH???
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Expecting a reroll.


* jx/proc-receive-hook (2020-05-18) 11 commits
 . doc: add documentation for the proc-receive hook
 . transport: parse report options for tracking refs
 . t5411: test updates of remote-tracking branches
 . receive-pack: new config receive.procReceiveRefs
 . refs.c: refactor to reuse ref_is_hidden()
 . receive-pack: feed report options to post-receive
 . doc: add document for capability report-status-v2
 . New capability "report-status-v2" for git-push
 . receive-pack: add new proc-receive hook
 . t5411: add basic test cases for proc-receive hook
 . transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Ejected out of 'seen'; somehow its tests seem to break with clang
 cf. https://travis-ci.org/github/git/git/builds/713443572


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

* es/worktree-doc-cleanups (2020-08-03) 5 commits
  (merged to 'next' on 2020-08-04 at cbb53ca464)
 + git-worktree.txt: link to man pages when citing other Git commands
 + git-worktree.txt: make start of new sentence more obvious
 + git-worktree.txt: fix minor grammatical issues
 + git-worktree.txt: consistently use term "working tree"
 + git-worktree.txt: employ fixed-width typeface consistently

 Doc cleanup around "worktree".

 Will merge to 'master'.


* jk/log-fp-implies-m (2020-07-29) 7 commits
  (merged to 'next' on 2020-08-03 at 39fefa6b82)
 + doc/git-log: clarify handling of merge commit diffs
 + doc/git-log: move "-t" into diff-options list
 + doc/git-log: drop "-r" diff option
 + doc/git-log: move "Diff Formatting" from rev-list-options
 + log: enable "-m" automatically with "--first-parent"
 + revision: add "--no-diff-merges" option to counteract "-m"
 + log: drop "--cc implies -m" logic

 Originally merged to 'next' on 2020-08-01

 "git log --first-parent -p" showed patches only for single-parent
 commits on the first-parent chain; the "--first-parent" option has
 been made to imply "-m".  Use "--no-diff-merges" to restore the
 previous behaviour to omit patches for merge commits.

 On hold a bit.
 cf. <20200804200018.GB2014743@coredump.intra.peff.net>


* pd/mergetool-nvimdiff (2020-07-29) 2 commits
 - mergetools: add support for nvimdiff (neovim) family
 - mergetool--lib: improve support for vimdiff-style tool variants

 The existing backends for "git mergetool" based on variants of vim
 have been refactored and then support for "nvim" has been added.

 Will merge to 'next'.


* al/bisect-first-parent (2020-08-07) 5 commits
 - bisect: combine args passed to find_bisection()
 - bisect: introduce first-parent flag
 - cmd_bisect__helper: defer parsing no-checkout flag
 - rev-list: allow bisect and first-parent flags
 - t6030: modernize "git bisect run" tests

 "git bisect" learns the "--first-parent" option to find the first
 breakage along the first-parent chain.

 Will merge to 'next'.


* dd/send-email-config (2020-07-23) 1 commit
 - git-send-email: die if sendmail.* config is set

 Stop when "sendmail.*" configuration variables are defined, which
 could be a mistaken attempt to define "sendemail.*" variables.

 Will merge to 'next'.


* bc/sha-256-part-3 (2020-07-30) 39 commits
  (merged to 'next' on 2020-08-04 at 57115e548f)
 + t: remove test_oid_init in tests
 + docs: add documentation for extensions.objectFormat
 + ci: run tests with SHA-256
 + t: make SHA1 prerequisite depend on default hash
 + t: allow testing different hash algorithms via environment
 + t: add test_oid option to select hash algorithm
 + repository: enable SHA-256 support by default
 + setup: add support for reading extensions.objectformat
 + bundle: add new version for use with SHA-256
 + builtin/verify-pack: implement an --object-format option
 + http-fetch: set up git directory before parsing pack hashes
 + t0410: mark test with SHA1 prerequisite
 + t5308: make test work with SHA-256
 + t9700: make hash size independent
 + t9500: ensure that algorithm info is preserved in config
 + t9350: make hash size independent
 + t9301: make hash size independent
 + t9300: use $ZERO_OID instead of hard-coded object ID
 + t9300: abstract away SHA-1-specific constants
 + t8011: make hash size independent
 + t8003: make hash size independent
 + t8002: make hash size independent
 + t7508: use $ZERO_OID instead of hard-coded constant
 + t7506: avoid checking for SHA-1-specific constants
 + t7405: make hash size independent
 + t7400: make hash size independent
 + t7102: abstract away SHA-1-specific constants
 + t7201: abstract away SHA-1-specific constants
 + t7063: make hash size independent
 + t7003: compute appropriate length constant
 + t6501: avoid hard-coded objects
 + t6500: specify test values for SHA-256
 + t6301: make hash size independent
 + t6101: make hash size independent
 + t6100: make hash size independent
 + t3404: prepare 'short SHA-1 collision' tests for SHA-256
 + t3305: make hash agnostic
 + t1001: use $ZERO_OID
 + t: make test-bloom initialize repository

 The final leg of SHA-256 transition.

 Will merge to 'master'.


* hn/reftable-prep-part-2 (2020-07-27) 3 commits
 - Make HEAD a PSEUDOREF rather than PER_WORKTREE.
 - Modify pseudo refs through ref backend storage
 - t1400: use git rev-parse for testing PSEUDOREF existence

 Further preliminary change to refs API.

 Will merge to 'next'.


* ds/maintenance (2020-08-06) 11 commits
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


* tb/upload-pack-filters (2020-08-05) 4 commits
  (merged to 'next' on 2020-08-05 at 918e7092fe)
 + t5616: use test_i18ngrep for upload-pack errors
  (merged to 'next' on 2020-08-04 at 3ae57cc90c)
 + upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
 + upload-pack.c: allow banning certain object filter(s)
 + list_objects_filter_options: introduce 'list_object_filter_config_name'

 The component to respond to "git fetch" request is made more
 configurable to selectively allow or reject object filtering
 specification used for partial cloning.

 Will merge to 'master'.
 cf. <20200804003722.GA2726931@coredump.intra.peff.net>


* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Expecting a reroll.
 cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>


* ss/cmake-build (2020-06-26) 8 commits
  (merged to 'next' on 2020-08-03 at a0d70165c1)
 + ci: modification of main.yml to use cmake for vs-build job
 + cmake: support for building git on windows with msvc and clang.
 + cmake: support for building git on windows with mingw
 + cmake: support for testing git when building out of the source tree
 + cmake: support for testing git with ctest
 + cmake: installation support for git
 + cmake: generate the shell/perl/python scripts and templates, translations
 + Introduce CMake support for configuring Git

 Originally merged to 'next' on 2020-08-01

 CMake support to build with MSVC for Windows bypassing the Makefile.

 Will merge to 'master'.


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

* jk/fast-export-anonym (2020-06-22) 4 commits
  (merged to 'next' on 2020-06-22 at b517b2f707)
 + fast-export: allow dumping the path mapping
 + fast-export: refactor path printing to not rely on stdout
 + fast-export: anonymize "master" refname
 + fast-export: allow dumping the refname mapping

 The way refnames are anonymized has been updated and a way to help
 debugging using the anonymized output hsa been added.

 Superseded by 'jk/fast-export-anonym-alt'.


* jk/t6000-timestamp-fix (2020-07-07) 1 commit
  (merged to 'next' on 2020-07-09 at 633bcd552f)
 + t6000: use test_tick consistently

 Test update.

 Now it is part of jk/tests-timestamp-fix with a larger scope.


* jc/no-update-fetch-head (2020-07-29) 1 commit
 . fetch: optionally allow disabling FETCH_HEAD update

 "git fetch" learned the "--[no-]write-fetch-head" option to
 optionally stop describing what was fetched in FETCH_HEAD.

 Now it is part of ds/maintenance topic.
