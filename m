Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC87C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1BC20708
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 21:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qDi5pwmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGIVlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:41:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGIVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 17:41:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B2B3C9C42;
        Thu,  9 Jul 2020 17:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=L
        VBfXt7ZtEECXxUr7Lge67BukC4=; b=qDi5pwmoa+b4/O4zUKHNaxmNnTh/CH2vt
        noDoehraAbrNlAkakvM2oCrd1sPJGqQ7LBpijQAsu3navEBrOElT4Kf4l5OkDSz/
        7lg0WleXead76sptqKV8ZibW+NlhzFMLfH0Q6HgrU6ZJBuobFhBhEiyn7RqmIkcR
        D2KR72tvww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ivZ
        3JckcsK5Er71zjUTfPPAV9FHSirLk+PIbMT3kVDp5Vd/qWNKdfBBvCkw1//SxLpn
        oC62ULTwU9f3db7d3i2y3Px047BIjgssAp3Qn8gPeMOJQdBzKJzGghbU7lp1vKZr
        e3Ojlh7oGoXGHURaY+BNeJHy7ypYzRG3Kcv7iu1c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63C11C9C41;
        Thu,  9 Jul 2020 17:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5022CC9C40;
        Thu,  9 Jul 2020 17:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2020, #02; Thu, 9)
X-master-at: bd42bbe1a46c0fe486fc33e82969275e27e4dc19
X-next-at: f9edc3c819edc268d3a429d06d1efb8fa957866b
Date:   Thu, 09 Jul 2020 14:40:49 -0700
Message-ID: <xmqqa708wen2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBFD9F7E-C22C-11EA-BE48-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of the 'master' branch has been tagged as 'v2.28.0-rc0', as
the preview of upcoming release.  From here on, let's focus mostly
on stabilizing what will be in the upcoming 2.28 release and less on
polishing topics not yet in 'next' or starting new ones, so that we
can have a solid release by the end of the month.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* cc/cat-file-usage-update (2020-07-01) 1 commit
  (merged to 'next' on 2020-07-06 at 270769a009)
 + cat-file: add missing [=<format>] to usage/synopsis

 Doc/usage update.


* ct/diff-with-merge-base-clarification (2020-07-08) 1 commit
  (merged to 'next' on 2020-07-08 at fc1ab4a479)
 + diff: check for merge bases before assigning sym->base

 Recent update to "git diff" meant as a code clean-up introduced a
 bug in its error handling code, which has been corrected.


* jn/eject-fetch-write-commit-graph-out-of-experimental (2020-07-08) 1 commit
  (merged to 'next' on 2020-07-08 at 1f7cf947f8)
 + experimental: default to fetch.writeCommitGraph=false

 "fetch.writeCommitGraph" was enabled when "feature.experimental" is
 asked for, but it was found to be a bit too risky even for bold
 folks in its current shape.  The configuration has been ejected, at
 least for now, from the "experimental" feature set.


* ma/rebase-doc-typofix (2020-07-09) 1 commit
  (merged to 'next' on 2020-07-09 at 6bf0e26bee)
 + git-rebase.txt: fix description list separator

 Typofix.


* mt/entry-fstat-fallback-fix (2020-07-09) 1 commit
  (merged to 'next' on 2020-07-09 at fa0dce39d2)
 + entry: check for fstat() errors after checkout

 "git checkout" failed to catch an error from fstat() after updating
 a path in the working tree.


* ra/send-email-in-reply-to-from-command-line-wins (2020-07-01) 1 commit
  (merged to 'next' on 2020-07-06 at 3892a1ab88)
 + send-email: restore --in-reply-to superseding behavior

 "git send-email --in-reply-to=<msg>" did not use the In-Reply-To:
 header with the value given from the command line, and let it be
 overridden by the value on In-Reply-To: header in the messages
 being sent out (if exists).


* rs/line-log-until (2020-07-06) 1 commit
  (merged to 'next' on 2020-07-06 at 84d6bc67fa)
 + revision: disable min_age optimization with line-log

 "git log -Lx,y:path --before=date" lost track of where the range
 should be because it didn't take the changes made by the youngest
 commits that are omitted from the output into account.


* tb/fix-persistent-shallow (2020-07-08) 1 commit
  (merged to 'next' on 2020-07-08 at ef1709f4bb)
 + commit.c: don't persist substituted parents when unshallowing

 When "fetch.writeCommitGraph" configuration is set in a shallow
 repository and a fetch moves the shallow boundary, we wrote out
 broken commit-graph files that do not match the reality, which has
 been corrected.


* vs/completion-with-set-u (2020-07-01) 1 commit
  (merged to 'next' on 2020-07-06 at 72b1eca511)
 + completion: nounset mode fixes

 The command line completion support (in contrib/) used to be
 prepared to work with "set -u" but recent changes got a bit more
 sloppy.  This has been corrected.

--------------------------------------------------
[New Topics]

* dl/test-must-fail-fixes-6 (2020-07-07) 6 commits
 - test-lib-functions: restrict test_must_fail usage
 - t9400: don't use test_must_fail with cvs
 - t9834: remove use of `test_might_fail p4`
 - t7107: don't use test_must_fail()
 - t5324: reorder `run_with_limited_open_files test_might_fail`
 - t3701: stop using `env` in force_color()

 Dev support to limit the use of test_must_fail to only git commands.


* ds/maintenance (2020-07-07) 21 commits
 - midx: use start_delayed_progress()
 - maintenance: add pack-files auto condition
 - maintenance: create auto condition for loose-objects
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: auto-size pack-files batch
 - maintenance: add pack-files task
 - maintenance: add loose-objects task
 - maintenance: add fetch task
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array and hashmap
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 - gc: drop the_repository in log location
 - gc: use repo config
 - gc: use repository in too_many_loose_objects()
 - gc: use the_repository less often

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.


* jk/t6000-timestamp-fix (2020-07-07) 1 commit
  (merged to 'next' on 2020-07-09 at 633bcd552f)
 + t6000: use test_tick consistently

 Test update.

 Will cook in 'next'.


* sg/commit-graph-progress-fix (2020-07-09) 2 commits
  (merged to 'next' on 2020-07-09 at 3a9f916ca4)
 + commit-graph: fix "Writing out commit graph" progress counter
 + commit-graph: fix progress of reachable commits

 The code to produce progress output from "git commit-graph --write"
 had a few breakages, which have been fixed.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* mr/bisect-in-c-2 (2020-07-08) 13 commits
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


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* bw/fail-cloning-into-non-empty (2020-07-06) 1 commit
 - git clone: don't clone into non-empty directory

 "git clone --separate-git-dir=$elsewhere" used to stomp on the
 contents of the existing directory $elsewhere, which has been
 taught to fail when $elsewhere is not an empty directory.

 Expecting a reroll.
 with improved commit log message.
 cf. <xmqqv9j08dxo.fsf@gitster.c.googlers.com>


* cc/pretty-contents-size (2020-07-07) 5 commits
 . SQUASH???
 . ref-filter: add support for %(contents:size)
 . t6300: test refs pointing to tree and blob
 . Documentation: clarify 'complete message'
 . Documentation: clarify %(contents:XXXX) doc

 "git for-each-ref --format=<>" learned %(contents:size).

 Expecting a reroll.
 breaks a test on macOS
 cf. <xmqqk0zf3y8s.fsf@gitster.c.googlers.com>


* ls/mergetool-meld-auto-merge (2020-07-08) 1 commit
 - mergetool: mergetool: update meld backend to allow using '--auto-merge'

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.


* pb/log-rev-list-doc (2020-07-08) 6 commits
 - git-log.txt: include rev-list-description.txt
 - git-rev-list.txt: move description to separate file
 - git-rev-list.txt: tweak wording in set operations
 - git-rev-list.txt: fix Asciidoc syntax
 - revisions.txt: describe 'rev1 rev2 ...' meaning for ranges
 - git-log.txt: add links to 'rev-list' and 'diff' docs

 "git help log" has been enhanced by sharing more material from the
 documentation for the underlying "git rev-list" command.


* ta/wait-on-aliased-commands-upon-signal (2020-07-07) 2 commits
  (merged to 'next' on 2020-07-09 at de8bde9182)
 + Wait for child on signal death for aliases to externals
 + Wait for child on signal death for aliases to builtins

 When an aliased command, whose output is piped to a pager by git,
 gets killed by a signal, the pager got into a funny state, which
 has been corrected (again).

 Will merge to 'master'.


* tb/upload-pack-filters (2020-07-06) 4 commits
 - upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
 - upload-pack.c: pass 'struct list_objects_filter_options *'
 - upload-pack.c: allow banning certain object filter(s)
 - list_objects_filter_options: introduce 'list_object_filter_config_name'

 The component to respond to "git fetch" request is made more
 configurable to selectively allow or reject object filtering
 specification used for partial cloning.

 Waiting for reviews.
 cf. <cover.1593720075.git.me@ttaylorr.com>


* mt/hash-to-hex-thread-safety (2020-06-26) 2 commits
 - hex: make hash_to_hex_algop() and friends thread-safe
 - compat/win32/pthread: add pthread_once()

 hash_to_hex() used a set of rotating static buffers, which was not
 safe to use in a threaded environment.  This has been made safer by
 using thread-local storage.

 Expecting a reroll.
 cf. <CAHd-oW6A2aBHg80R9kyifvF7thwzam5EYYoN9d2TaBcHJrcKWw@mail.gmail.com>


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* ds/commit-graph-bloom-updates (2020-07-01) 10 commits
  (merged to 'next' on 2020-07-06 at 177e6b362e)
 + commit-graph: check all leading directories in changed path Bloom filters
 + revision: empty pathspecs should not use Bloom filters
 + revision.c: fix whitespace
 + commit-graph: check chunk sizes after writing
 + commit-graph: simplify chunk writes into loop
 + commit-graph: unify the signatures of all write_graph_chunk_*() functions
 + commit-graph: persist existence of changed-paths
 + bloom: fix logic in get_bloom_filter()
 + commit-graph: change test to die on parse, not load
 + commit-graph: place bloom_settings in context
 (this branch uses sg/commit-graph-cleanups.)

 Updates to the changed-paths bloom filter.

 Will cook in 'next'.


* ss/cmake-build (2020-06-26) 8 commits
 - ci: modification of main.yml to use cmake for vs-build job
 - cmake: support for building git on windows with msvc and clang.
 - cmake: support for building git on windows with mingw
 - cmake: support for testing git when building out of the source tree
 - cmake: support for testing git with ctest
 - cmake: installation support for git
 - cmake: generate the shell/perl/python scripts and templates, translations
 - Introduce CMake support for configuring Git

 CMake support to build with MSVC for Windows bypassing the Makefile.

 Waiting for a (hopefully final) review.


* sg/commit-graph-cleanups (2020-06-08) 10 commits
  (merged to 'next' on 2020-07-06 at 15c9d77eb9)
 + commit-graph: simplify write_commit_graph_file() #2
 + commit-graph: simplify write_commit_graph_file() #1
 + commit-graph: simplify parse_commit_graph() #2
 + commit-graph: simplify parse_commit_graph() #1
 + commit-graph: clean up #includes
 + diff.h: drop diff_tree_oid() & friends' return value
 + commit-slab: add a function to deep free entries on the slab
 + commit-graph-format.txt: all multi-byte numbers are in network byte order
 + commit-graph: fix parsing the Chunk Lookup table
 + tree-walk.c: don't match submodule entries for 'submod/anything'
 (this branch is used by ds/commit-graph-bloom-updates.)

 The changed-path Bloom filter is improved using ideas from an
 independent implementation.

 Will cook in 'next'.


* es/config-hooks (2020-05-21) 4 commits
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 What's the status of this one?  Abandoned?


* pw/rebase-i-more-options (2020-06-26) 5 commits
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


* jx/proc-receive-hook (2020-05-18) 11 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - refs.c: refactor to reuse ref_is_hidden()
 - receive-pack: feed report options to post-receive
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Needs review.


* hn/reftable (2020-07-06) 4 commits
 - Treat BISECT_HEAD as a pseudo ref
 - checkout: add '\n' to reflog message
 - t3432: use git-reflog to inspect the reflog for HEAD
 - lib-t6000.sh: write tag using git-update-ref

 Preliminary clean-up of the refs API in preparation for adding a
 new refs backend "reftable".

 Expecting a reroll.
 The second one should be dropped, and possibly replaced with a
 patch that moves message normalization from backends to the more
 generic layer.
 cf. <xmqqmu4ca31g.fsf@gitster.c.googlers.com>

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


* jk/fast-export-anonym (2020-06-22) 4 commits
  (merged to 'next' on 2020-06-22 at b517b2f707)
 + fast-export: allow dumping the path mapping
 + fast-export: refactor path printing to not rely on stdout
 + fast-export: anonymize "master" refname
 + fast-export: allow dumping the refname mapping

 The way refnames are anonymized has been updated and a way to help
 debugging using the anonymized output hsa been added.

 Superseded by 'jk/fast-export-anonym-alt'.
