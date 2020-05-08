Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5105FC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 22:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E442207DD
	for <git@archiver.kernel.org>; Fri,  8 May 2020 22:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQO+SyxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEHW2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 18:28:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53008 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEHW2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 18:28:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BACA65E22A;
        Fri,  8 May 2020 18:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=4
        JTccP6iP8Oh/HPPIzAfl5GHXRE=; b=WQO+SyxBNKqzuFNwfCCzxde9tjnBRajzy
        MV4HHjFij2wU0kYIAGmZI5XfoFBIxIA1ONaKhzg7koo5KjyH/h+QlvysC6kndSAl
        iokX4kYN0eNC9ndJoBUmAVeanHd23ZQpsTogQ8VZCdep27c1lP2WKkJ+byVdAyLw
        eHTrROV0xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=FiD
        qEnFBfjGbc6Q3+g6nA3Sqq5SVc8A6nnvNmh5sKfHkNKL6EKC4d/kwZgsTBx6fMKs
        eb+/xhYd7rBruo7tKOOjbpZ1IxiVRRTK5ZxygqVXLtgpCeRQPiEpcz8Ln0WDp+Mm
        ApmCtdt3wtKlTFeRsSXqBE4PxMlclTFnBCe5RqT8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B05F05E229;
        Fri,  8 May 2020 18:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EE215E228;
        Fri,  8 May 2020 18:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2020, #03; Fri, 8)
X-master-at: b994622632154fc3b17fb40a38819ad954a5fb88
X-next-at: 0e0b3e54bef85529846ce55fa34a67746509a2cd
Date:   Fri, 08 May 2020 15:28:26 -0700
Message-ID: <xmqqftcavz79.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C9C2C16-917B-11EA-B130-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

I have been a bit more aggressive than usual in merging topics down
to 'next' and 'master' this week, in preparation for -rc0, scheduled
on the 14th.  We may need to apply last-minute fixes to some of
these topics but let's hope that we can keep them to the minimum.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/userdiff-markdown (2020-05-02) 1 commit
  (merged to 'next' on 2020-05-05 at b8e64b75d0)
 + userdiff: support Markdown

 The userdiff patterns for Markdown documents have been added.


* bc/doc-credential-helper-value (2020-05-06) 1 commit
  (merged to 'next' on 2020-05-07 at de685cea7b)
 + docs: document credential.helper allowed values

 Doc update.


* cb/avoid-colliding-with-netbsd-hmac (2020-05-05) 1 commit
  (merged to 'next' on 2020-05-06 at 5cccb0e1a8)
 + builtin/receive-pack: avoid generic function name hmac()

 The <stdlib.h> header on NetBSD brings in its own definition of
 hmac() function (eek), which conflicts with our own and unrelated
 function with the same name.  Our function has been renamed to work
 around the issue.


* cb/credential-store-ignore-bogus-lines (2020-05-02) 2 commits
  (merged to 'next' on 2020-05-05 at 5b919ec5d6)
 + credential-store: ignore bogus lines from store file
 + credential-store: document the file format a bit more

 With the recent tightening of the code that is used to parse
 various parts of a URL for use in the credential subsystem, a
 hand-edited credential-store file causes the credential helper to
 die, which is a bit too harsh to the users.  Demote the error
 behaviour to just ignore and keep using well-formed lines instead.


* cb/t0000-use-the-configured-shell (2020-05-07) 1 commit
  (merged to 'next' on 2020-05-07 at c5db4882c4)
 + t/t0000-basic: make sure subtests also use TEST_SHELL_PATH

 The basic test did not honor $TEST_SHELL_PATH setting, which has
 been corrected.


* cb/test-bash-lineno-fix (2020-05-07) 1 commit
  (merged to 'next' on 2020-05-07 at 8c07e52d2f)
 + t/test_lib: avoid naked bash arrays in file_lineno

 Recent change to show files and line numbers of a breakage during
 test (only available when running the tests with bash) were hurting
 other shells with syntax errors, which has been corrected.


* dl/doc-stash-remove-mention-of-reflog (2020-05-05) 1 commit
  (merged to 'next' on 2020-05-06 at 8b570b7722)
 + Doc: reference the "stash list" in autostash docs

 Doc update.


* dl/switch-c-option-in-error-message (2020-04-30) 1 commit
  (merged to 'next' on 2020-05-05 at 472db48735)
 + switch: fix errors and comments related to -c and -C

 In error messages that "git switch" mentions its option to create a
 new branch, "-b/-B" options were shown, where "-c/-C" options
 should be, which has been corrected.


* ds/sparse-allow-empty-working-tree (2020-05-04) 1 commit
  (merged to 'next' on 2020-05-06 at de7b38aee5)
 + sparse-checkout: stop blocking empty workdirs

 The sparse-checkout patterns have been forbidden from excluding all
 paths, leaving an empty working tree, for a long time.  This
 limitation has been lifted.


* es/restore-staged-from-head-by-default (2020-05-05) 1 commit
  (merged to 'next' on 2020-05-06 at c4abf9b5df)
 + restore: default to HEAD when combining --staged and --worktree

 "git restore --staged --worktree" now defaults to take the contents
 out of "HEAD", instead of erring out.


* jk/arith-expansion-coding-guidelines (2020-05-04) 1 commit
  (merged to 'next' on 2020-05-06 at 2325148249)
 + CodingGuidelines: drop arithmetic expansion advice to use "$x"

 The coding guideline for shell scripts instructed to refer to a
 variable with dollar-sign inside arithmetic expansion to work
 around a bug in old versions of dash, which is a thing of the past.
 Now we are not forbidden from writing $((var+1)).


* jk/credential-sample-update (2020-05-01) 2 commits
  (merged to 'next' on 2020-05-06 at c72ed30ee5)
 + gitcredentials(7): make shell-snippet example more realistic
 + gitcredentials(7): clarify quoting of helper examples

 The samples in the credential documentation has been updated to
 make it clear that we depict what would appear in the .git/config
 file, by adding appropriate quotes as needed..


* jk/for-each-ref-multi-key-sort-fix (2020-05-04) 2 commits
  (merged to 'next' on 2020-05-06 at f4e4ca3cb4)
 + ref-filter: apply fallback refname sort only after all user sorts
 + ref-filter: apply --ignore-case to all sorting keys

 "git branch" and other "for-each-ref" variants accepted multiple
 --sort=<key> options in the increasing order of precedence, but it
 had a few breakages around "--ignore-case" handling, and tie-breaking
 with the refname, which have been fixed.


* jt/commit-graph-plug-memleak (2020-05-04) 1 commit
  (merged to 'next' on 2020-05-06 at 0f80a2b561)
 + commit-graph: avoid memory leaks

 Fix a leak noticed by fuzzer.

--------------------------------------------------
[New Topics]

* ss/faq-ignore (2020-05-06) 1 commit
  (merged to 'next' on 2020-05-07 at 6273caaf77)
 + gitfaq: files in .gitignore are tracked

 Random bits of FAQ.

 Will merge to 'master'.


* ss/faq-fetch-pull (2020-05-06) 1 commit
  (merged to 'next' on 2020-05-07 at d57224374e)
 + gitfaq: fetching and pulling a repository

 Random bits of FAQ.

 Will merge to 'master'.


* jc/auto-gc-quiet (2020-05-07) 2 commits
  (merged to 'next' on 2020-05-07 at 6cc69513c3)
 + auto-gc: pass --quiet down from am, commit, merge and rebase
 + auto-gc: extract a reusable helper from "git fetch"

 Teach "am", "commit", "merge" and "rebase", when they are run with
 the "--quiet" option, to pass "--quiet" down to "gc --auto".

 Will merge to 'master'.


* jt/t5500-unflake (2020-05-06) 1 commit
 - t5500: count objects through stderr, not trace

 Test fix for a topic already in 'master' and meant for 'maint'.

 Expecting an update to clarify the log message.
 Otherwise the change itself looked good.


* jk/ci-only-on-selected-branches (2020-05-07) 1 commit
  (merged to 'next' on 2020-05-07 at f3227dd3d3)
 + ci: allow per-branch config for GitHub Actions

 Instead of always building all branches at GitHub via Actions,
 users can specify which branches to build.

 Will merge to 'master'.


* cc/upload-pack-v2-fetch-fix (2020-05-08) 1 commit
  (merged to 'next' on 2020-05-08 at d26b87d06d)
 + upload-pack: clear filter_options for each v2 fetch command

 Serving a "git fetch" client over "git://" and "ssh://" protocols
 using the on-wire protocol version 2 was buggy on the server end
 when the client needs to make a follow-up request to
 e.g. auto-follow tags.

 Will merge to 'master'.


* cw/bisect-replay-with-dos (2020-05-08) 1 commit
 - bisect: allow CRLF line endings in "git bisect replay" input

 "git bisect replay" had trouble with input files when they used
 CRLF line ending, which has been corrected.

 Will merge to 'next'.


* dd/bloom-sparse-fix (2020-05-07) 1 commit
  (merged to 'next' on 2020-05-08 at 1067403c01)
 + bloom: fix `make sparse` warning

 Code clean-up.

 Will merge to 'master'.


* ds/sparse-updates-oob-access-fix (2020-05-08) 1 commit
  (merged to 'next' on 2020-05-08 at fd007758ea)
 + unpack-trees: avoid array out-of-bounds error

 The code to skip unmerged paths in the index when sparse checkout
 is in use would have made out-of-bound access of the in-core index
 when the last path was unmerged, which has been corrected.

 Will merge to 'master'.


* hn/refs-cleanup (2020-05-08) 4 commits
 - t: use update-ref and show-ref to reading/writing refs
 - refs: document how ref_iterator_advance_fn should handle symrefs
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - refs.h: clarify reflog iteration order
 (this branch is used by hn/reftable.)

 Preliminary clean-ups around refs API.

 Needs minor rework but otherwise looks ready.
 I splitted these out of the hn/reftable topic, hoping that these
 should be easier to polish and merge quickly than the rest of the
 series.


* jc/codingstyle-compare-with-null (2020-05-08) 1 commit
 - CodingGuidelines: do not ==/!= compare with 0 or '\0' or NULL

 Doc update.

 Will merge to 'next'.


* ss/submodule-set-url-in-c (2020-05-08) 1 commit
  (merged to 'next' on 2020-05-08 at 93e390eb33)
 + submodule: port subcommand 'set-url' from shell to C

 Rewriting various parts of "git submodule" in C continues.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* ds/line-log-on-bloom (2020-05-01) 12 commits
 - line-log: integrate with changed-path Bloom filters
 - line-log: try to use generation number-based topo-ordering
 - line-log: more responsive, incremental 'git log -L'
 - t4211-line-log: add tests for parent oids
 - line-log: remove unused fields from 'struct line_log_data'
 - completion: offer '--(no-)patch' among 'git log' options
 - bloom: use num_changes not nr for limit detection
 - bloom: parse commit before computing filters
 - bloom: de-duplicate directory entries
 - Documentation: changed-path Bloom filters use byte words
 - test-bloom: fix usage typo
 - bloom: fix whitespace around tab length

 "git log -L..." now takes advantage of the "which paths are touched
 by this commit?" info stored in the commit-graph system.

 Expecting a reroll.
 cf. <4b7e5f51-9fdb-45ac-123e-2589087afa48@gmail.com>


* js/rebase-autosquash-double-fixup-fix (2020-05-05) 1 commit
 - rebase --autosquash: fix a potential segfault

 "rebase -i" segfaulted when rearranging a sequence that has a
 fix-up that applies another fix-up (which may or may not be a
 fix-up of yet another step).

 Expecting a bit more explanation in the log message.


* cb/credential-doc-fixes (2020-05-07) 4 commits
  (merged to 'next' on 2020-05-07 at 993b36071e)
 + credential: document protocol updates
 + credential: update gitcredentials documentation
 + credential: correct order of parameters for credential_match
 + credential: update description for credential_from_url_gently

 Minor in-code comments and documentation updates around credential
 API.

 Will merge to 'master'.


* tb/bitmap-walk-with-tree-zero-filter (2020-05-04) 4 commits
  (merged to 'next' on 2020-05-06 at fbb3fbbb85)
 + pack-bitmap: pass object filter to fill-in traversal
 + pack-bitmap.c: support 'tree:0' filtering
 + pack-bitmap.c: make object filtering functions generic
 + list-objects-filter: treat NULL filter_options as "disabled"

 The object walk with object filter "--filter=tree:0" can now take
 advantage of the pack bitmap when available.

 Will merge to 'master'.


* tb/commit-graph-no-check-oids (2020-05-05) 8 commits
 - commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
 - t5318: reorder test below 'graph_read_expect'
 - commit-graph.c: simplify 'fill_oids_from_commits'
 - builtin/commit-graph.c: dereference tags in builtin
 - builtin/commit-graph.c: extract 'read_one_commit()'
 - commit-graph.c: peel refs in 'add_ref_to_set'
 - commit-graph.c: show progress of finding reachable commits
 - commit-graph.c: extract 'refs_cb_data'

 Clean-up the commit-graph codepath.

 Expecting a reroll.
 cf. <20200507204204.GF29683@coredump.intra.peff.net>
 cf. <20200507200305.GB29683@coredump.intra.peff.net>


* dl/test-must-fail-fixes-5 (2020-05-05) 4 commits
 - lib-submodule-update: pass OVERWRITING_FAIL
 - lib-submodule-update: prepend "git" to $command
 - lib-submodule-update: consolidate --recurse-submodules
 - lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Needs review.
 cf. <cover.1588162842.git.liu.denton@gmail.com>


* es/bugreport-with-hooks (2020-05-07) 1 commit
 - bugreport: collect list of populated hooks

 "git bugreport" learned to report enabled hooks in the repository.

 Needs polishing the tests.


* tb/shallow-cleanup (2020-04-30) 4 commits
  (merged to 'next' on 2020-05-05 at 647588a8bd)
 + shallow: use struct 'shallow_lock' for additional safety
 + shallow.h: document '{commit,rollback}_shallow_file'
 + shallow: extract a header file for shallow-related functions
 + commit: make 'commit_graft_pos' non-static

 Code cleanup.

 Will merge to 'master'.


* mr/bisect-in-c-2 (2020-04-23) 12 commits
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: finish porting `bisect_start()` to C
 - bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 - bisect--helper: reimplement `bisect_autostart` shell function in C
 - bisect--helper: introduce new `write_in_file()` function
 - bisect--helper: use '-res' in 'cmd_bisect__helper' return
 - bisect--helper: fix `cmd_*()` function switch default return

 Rewrite of the remainder of "git bisect" script in C continues.

 Needs review.


* jk/complete-git-switch (2020-04-28) 11 commits
 - completion: complete remote branches for git switch --track
 - completion: recognize -c/-C when completing for git switch
 - completion: fix completion for git switch with no options
 - completion: perform DWIM logic directly in __git_complete_refs
 - completion: extract function __git_dwim_remote_heads
 - completion: rename --track option of __git_complete_refs
 - completion: stop completing refs for git switch --orphan
 - completion: add tests showing lack of support for git switch -c/-C
 - completion: add test highlighting subpar git switch --track completion
 - completion: add test showing subpar git switch completion
 - completion: add some simple test cases for git switch completion

 The command line completion (in contrib/) learned to complete
 options that the "git switch" command takes.

 Needs review.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* pw/rebase-i-more-options (2020-04-29) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Needs review.


* jx/proc-receive-hook (2020-05-07) 7 commits
 - doc: add documentation for the proc-receive hook
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: feed report options to post-receive
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


* hn/reftable (2020-05-08) 8 commits
 - Add some reftable testing infrastructure
 - vcxproj: adjust for the reftable changes
 - Reftable support for git-core
 - Add reftable library
 - reftable: clarify how empty tables should be written
 - reftable: define version 2 of the spec to accomodate SHA256
 - reftable: file format documentation
 - Add .gitattributes for the reftable/ directory
 (this branch uses hn/refs-cleanup.)

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Needs review.

--------------------------------------------------
[Discarded]

* jc/credential-store-file-format-doc (2020-04-27) 1 commit
 . credential-store: document the file format a bit more

 Now has become a part of Carlo's credential-store fix patches.


* js/ci-skip-on-github-workflow (2020-05-02) 1 commit
 . ci: respect the [skip ci] convention in our GitHub workflow "CI/PR"

 Allow contributors to mark a branch/push that it does not have to
 be built via GitHub actions, in a way similar to how Travis lets
 them mark the commits with an embedded "[skip ci]" string.

 Superseded by dd/ci-only-on-selective-branches topic.


* dd/ci-only-on-selective-branches (2020-05-05) 2 commits
 - CI: limit GitHub Actions to designated branches
 - SubmittingPatches: advertise GitHub Actions CI

 Instead of always building all branches of all forks of our project
 at GitHub via GitHub Actions, only build when branches with known
 and specific names are updated, and also a pull request.

 Superseded by jk/ci-only-on-selected-branches
