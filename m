Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE697C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 01:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F420767
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 01:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="af4yh3rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgFZBMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:12:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65421 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFZBMu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 21:12:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA40461A20;
        Thu, 25 Jun 2020 21:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=l
        4Keh4gLMx58QtpBJ0qAyTOt4fg=; b=af4yh3rDBhtyj2GWT1/tUDvcUKknx1PXN
        y1cuO0MJ3HVWYtyYGkh4HxZ/pdasa8AVrPvLydrxdfLL/Cu+mwPyh4vxTVhgZDIc
        daJO7IcVwCSTW5YFz3y5KlRjpuCDjcGVj9QNCQvBpkxsDxgeAPQMRoSBEz+yte7N
        zBnHo018KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=lhe
        J5sxSO1TZFaGWyEDgmWRuuH1L75xjNIXYRvfNVXMp7wUaEVjk6zHgn20SL6OKrds
        UhHYuV+tcurpzhJI12ctMVibTIzuG+M0cktEvFSs4Q7j5URUrYzqOKV6syKLVCZC
        +WfZPO5G03EEEaGhBBYcMUrgWvhtIeStWwrA6aFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9044A61A1F;
        Thu, 25 Jun 2020 21:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3DE761A1E;
        Thu, 25 Jun 2020 21:12:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2020, #05; Thu, 25)
X-master-at: f402ea68166bd77f09b176c96005ac7f8886e14b
X-next-at: b9a2d1a0207fb9ded3fa524f54db3bc322a12cc4
Date:   Thu, 25 Jun 2020 18:12:40 -0700
Message-ID: <xmqq1rm24ol3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21B930AC-B74A-11EA-A153-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

A handful of topics have graduated to 'master' and a bunch of topics
have been merged to 'next'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/upload-pack-data-3 (2020-06-11) 14 commits
  (merged to 'next' on 2020-06-17 at 393eff577a)
 + upload-pack: refactor common code into do_got_oid()
 + upload-pack: move oldest_have to upload_pack_data
 + upload-pack: pass upload_pack_data to got_oid()
 + upload-pack: pass upload_pack_data to ok_to_give_up()
 + upload-pack: pass upload_pack_data to send_acks()
 + upload-pack: pass upload_pack_data to process_haves()
 + upload-pack: change allow_unadvertised_object_request to an enum
 + upload-pack: move allow_unadvertised_object_request to upload_pack_data
 + upload-pack: move extra_edge_obj to upload_pack_data
 + upload-pack: move shallow_nr to upload_pack_data
 + upload-pack: pass upload_pack_data to send_unshallow()
 + upload-pack: pass upload_pack_data to deepen_by_rev_list()
 + upload-pack: pass upload_pack_data to deepen()
 + upload-pack: pass upload_pack_data to send_shallow_list()

 Code clean-up in the codepath that serves "git fetch" continues.


* ct/diff-with-merge-base-clarification (2020-06-12) 3 commits
  (merged to 'next' on 2020-06-17 at e0b54a001c)
 + Documentation: usage for diff combined commits
 + git diff: improve range handling
 + t/t3430: avoid undefined git diff behavior

 "git diff" used to take arguments in random and nonsense range
 notation, e.g. "git diff A..B C", "git diff A..B C...D", etc.,
 which has been cleaned up.


* dl/branch-cleanup (2020-06-17) 3 commits
  (merged to 'next' on 2020-06-18 at 76e151342c)
 + branch: don't mix --edit-description
 + t3200: test for specific errors
 + t3200: rename "expected" to "expect"

 Code clean-up around "git branch" with a minor bugfix.


* ds/merge-base-is-ancestor-optim (2020-06-17) 2 commits
  (merged to 'next' on 2020-06-18 at 86b34a3688)
 + commit-reach: use fast logic in repo_in_merge_base
 + commit-reach: create repo_is_descendant_of()
 (this branch is used by cb/is-descendant-of.)

 "git merge-base --is-ancestor" is taught to take advantage of the
 commit graph.


* en/clean-cleanups (2020-06-12) 4 commits
  (merged to 'next' on 2020-06-17 at 2c4ec990a6)
 + clean: optimize and document cases where we recurse into subdirectories
 + clean: consolidate handling of ignored parameters
 + dir, clean: avoid disallowed behavior
 + dir: fix a few confusing comments

 Code clean-up of "git clean" resulted in a fix of recent
 performance regression.


* jk/complete-git-switch (2020-05-28) 16 commits
  (merged to 'next' on 2020-06-17 at 5b31140c0a)
 + completion: improve handling of --orphan option of switch/checkout
 + completion: improve handling of -c/-C and -b/-B in switch/checkout
 + completion: improve handling of --track in switch/checkout
 + completion: improve handling of --detach in checkout
 + completion: improve completion for git switch with no options
 + completion: improve handling of DWIM mode for switch/checkout
 + completion: perform DWIM logic directly in __git_complete_refs
 + completion: extract function __git_dwim_remote_heads
 + completion: replace overloaded track term for __git_complete_refs
 + completion: add tests showing subpar switch/checkout --orphan logic
 + completion: add tests showing subpar -c/C argument completion
 + completion: add tests showing subpar -c/-C startpoint completion
 + completion: add tests showing subpar switch/checkout --track logic
 + completion: add tests showing subar checkout --detach logic
 + completion: add tests showing subpar DWIM logic for switch/checkout
 + completion: add test showing subpar git switch completion

 The command line completion (in contrib/) learned to complete
 options that the "git switch" command takes.


* jt/cdn-offload (2020-06-17) 10 commits
  (merged to 'next' on 2020-06-18 at e8ba1cc988)
 + upload-pack: fix a sparse '0 as NULL pointer' warning
 + upload-pack: send part of packfile response as uri
 + fetch-pack: support more than one pack lockfile
 + upload-pack: refactor reading of pack-objects out
 + Documentation: add Packfile URIs design doc
 + Documentation: order protocol v2 sections
 + http-fetch: support fetching packfiles by URL
 + http-fetch: refactor into function
 + http: refactor finish_http_pack_request()
 + http: use --stdin when indexing dumb HTTP pack

 The "fetch/clone" protocol has been updated to allow the server to
 instruct the clients to grab pre-packaged packfile(s) in addition
 to the packed object data coming over the wire.


* pb/t4014-unslave (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-19 at 4d328a12d9)
 + t4014: do not use "slave branch" nomenclature

 A branch name used in a test has been clarified to match what is
 going on.


* ss/submodule-set-branch-in-c (2020-06-02) 1 commit
  (merged to 'next' on 2020-06-18 at 8880b35c5a)
 + submodule: port subcommand 'set-branch' from shell to C

 Rewrite of parts of the scripted "git submodule" Porcelain command
 continues; this time it is "git submodule set-branch" subcommand's
 turn.

--------------------------------------------------
[New Topics]

* bc/http-push-flagsfix (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at 1dabb1f61b)
 + http-push: ensure unforced pushes fail when data would be lost

 The code to push changes over "dumb" HTTP had a bad interaction
 with the commit reachability code due to incorrect allocation of
 object flag bits, which has been corrected.

 Will merge to 'master'.


* cb/is-descendant-of (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at ca0eaddf5e)
 + commit-reach: avoid is_descendant_of() shim

 Code clean-up.

 Will merge to 'master'.


* jk/fast-export-anonym-alt (2020-06-25) 11 commits
 - fast-export: use local array to store anonymized oid
 - fast-export: anonymize "master" refname
 - fast-export: allow seeding the anonymized mapping
 - fast-export: add a "data" callback parameter to anonymize_str()
 - fast-export: move global "idents" anonymize hashmap into function
 - fast-export: use a flex array to store anonymized entries
 - fast-export: stop storing lengths in anonymized hashmaps
 - fast-export: tighten anonymize_mem() interface to handle only strings
 - fast-export: store anonymized oids as hex strings
 - fast-export: use xmemdupz() for anonymizing oids
 - t9351: derive anonymized tree checks from original repo

 "git fast-export --anonymize" learned to take customized mapping to
 allow its users to tweak its output more usable for debugging.

 Will merge to 'next'.


* js/diff-files-i-t-a-fix-for-difftool (2020-06-25) 2 commits
 - difftool -d: ensure that intent-to-add files are handled correctly
 - diff-files --raw: show correct post-image of intent-to-add files
 (this branch uses sk/diff-files-show-i-t-a-as-new.)

 "git difftool" has trouble dealing with paths added to the index
 with the intent-to-add bit.

 Will merge to 'next'.


* js/pu-to-seen (2020-06-25) 3 commits
  (merged to 'next' on 2020-06-25 at 06c9e5a885)
 + tests: reference `seen` wherever `pu` was referenced
 + docs: adjust the technical overview for the rename `pu` -> `seen`
 + docs: adjust for the recent rename of `pu` to `seen`

 The documentation and some tests have been adjusted for the recent
 renaming of "pu" branch to "seen".

 Will merge to 'master'.


* mk/pb-pretty-email-without-domain-part-fix (2020-06-23) 1 commit
  (merged to 'next' on 2020-06-25 at 81a3aca46b)
 + doc: fix author vs. committer copy/paste error

 Docfix.

 Will merge to 'master'.


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* rs/pack-bits-in-object-better (2020-06-24) 1 commit
  (merged to 'next' on 2020-06-25 at b3cb296341)
 + revision: reallocate TOPO_WALK object flags

 By renumbering object flag bits, "struct object" managed to lose
 bloated inter-field padding.

 Will merge to 'master'.


* es/worktree-code-cleanup (2020-06-24) 1 commit
 - worktree: avoid dead-code in conditional

 Code cleanup.

 Will merge to 'next'.


* ra/send-email-in-reply-to-from-command-line-wins (2020-06-24) 1 commit
 - send-email: restore --in-reply-to superseding behavior

 "git send-email --in-reply-to=<msg>" did not use the In-Reply-To:
 header with the value given from the command line, and let it be
 overridden by the value on In-Reply-To: header in the messages
 being sent out (if exists).

 Expecting a reroll/redesign.
 Does not behave sensibly for a multi-patch series.

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

 Expecting a response to reviews.
 cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* en/sparse-status (2020-06-22) 3 commits
  (merged to 'next' on 2020-06-25 at 404403a075)
 + git-prompt: include sparsity state as well
 + git-prompt: document how in-progress operations affect the prompt
 + wt-status: show sparse checkout status as well

 "git status" learned to report the status of sparse checkout.

 Will merge to 'master'.


* dl/diff-usage-comment-update (2020-06-23) 2 commits
  (merged to 'next' on 2020-06-23 at 48d685cd45)
 + builtin/diff: fix botched update of usage comment
  (merged to 'next' on 2020-06-19 at b53a12bb66)
 + builtin/diff: update usage comment

 An in-code comment in "git diff" has been updated.

 Will merge to 'master'.


* ps/ref-transaction-hook (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at 3a23dcdbdc)
 + refs: implement reference transaction hook

 A new hook.

 Will merge to 'master'.


* sk/diff-files-show-i-t-a-as-new (2020-06-22) 1 commit
  (merged to 'next' on 2020-06-22 at 825a823416)
 + diff-files: treat "i-t-a" files as "not-in-index"
 (this branch is used by js/diff-files-i-t-a-fix-for-difftool.)

 "git diff-files" has been taught to say paths that are marked as
 intent-to-add are new files, not modified from an empty blob.

 Will merge to 'master'.


* jk/fast-export-anonym (2020-06-22) 4 commits
  (merged to 'next' on 2020-06-22 at b517b2f707)
 + fast-export: allow dumping the path mapping
 + fast-export: refactor path printing to not rely on stdout
 + fast-export: anonymize "master" refname
 + fast-export: allow dumping the refname mapping

 The way refnames are anonymized has been updated and a way to help
 debugging using the anonymized output hsa been added.

 Will merge to 'master'.


* rs/commit-reach-leakfix (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at fcc1e385f0)
 + commit-reach: plug minor memory leak after using is_descendant_of()

 Leakfix.

 Will merge to 'master'.


* rs/pull-leakfix (2020-06-19) 1 commit
  (merged to 'next' on 2020-06-22 at d80a6b9ca3)
 + pull: plug minor memory leak after using is_descendant_of()

 Leakfix.

 Will merge to 'master'.


* rs/retire-strbuf-write-fd (2020-06-19) 2 commits
  (merged to 'next' on 2020-06-22 at c175b54f2a)
 + strbuf: remove unreferenced strbuf_write_fd method.
 + bugreport.c: replace strbuf_write_fd with write_in_full

 A misdesigned strbuf_write_fd() function has been retired.

 Will merge to 'master'.


* bc/sha-256-cvs-svn-updates (2020-06-22) 14 commits
  (merged to 'next' on 2020-06-25 at e0d1c87fcf)
 + git-cvsexportcommit: port to SHA-256
 + git-cvsimport: port to SHA-256
 + git-cvsserver: port to SHA-256
 + git-svn: set the OID length based on hash algorithm
 + perl: make SVN code hash independent
 + perl: make Git::IndexInfo work with SHA-256
 + perl: create and switch variables for hash constants
 + t/lib-git-svn: make hash size independent
 + t9101: make hash independent
 + t9104: make hash size independent
 + t9100: make test work with SHA-256
 + t9108: make test hash independent
 + t9168: make test hash independent
 + t9109: make test hash independent
 (this branch uses bc/sha-256-part-2.)

 CVS/SVN interface have been prepared for SHA-256 transition

 Will merge to 'master'.


* ds/commit-graph-bloom-updates (2020-06-23) 11 commits
 - bloom: enforce a minimum size of 8 bytes
 - commit-graph: check all leading directories in changed path Bloom filters
 - revision: empty pathspecs should not use Bloom filters
 - revision.c: fix whitespace
 - commit-graph: check chunk sizes after writing
 - commit-graph: simplify chunk writes into loop
 - commit-graph: unify the signatures of all write_graph_chunk_*() functions
 - commit-graph: persist existence of changed-paths
 - bloom: get_bloom_filter() cleanups
 - commit-graph: change test to die on parse, not load
 - commit-graph: place bloom_settings in context
 (this branch uses sg/commit-graph-cleanups.)

 Updates to the changed-paths bloom filter.

 Expecting a reroll.  Saw a lot of good review exchanges.
 cf. <4b08360d-04ab-b614-196b-76124f1d54ef@gmail.com>


* es/get-worktrees-unsort (2020-06-22) 2 commits
  (merged to 'next' on 2020-06-25 at 732d93a36d)
 + worktree: drop get_worktrees() unused 'flags' argument
 + worktree: drop get_worktrees() special-purpose sorting option

 API cleanup for get_worktrees()

 Will merge to 'master'.


* jl/complete-git-prune (2020-06-22) 1 commit
  (merged to 'next' on 2020-06-25 at 64f30b8b41)
 + bash-completion: add git-prune into bash completion

 Add "git prune" to the completion (in contrib/), which could be
 typed by end-users from the command line.

 Will merge to 'master'.


* js/default-branch-name (2020-06-24) 9 commits
  (merged to 'next' on 2020-06-25 at 8f962f9219)
 + testsvn: respect `init.defaultBranch`
 + remote: use the configured default branch name when appropriate
 + clone: use configured default branch name when appropriate
 + init: allow setting the default for the initial branch name via the config
 + init: allow specifying the initial branch name for the new repository
 + docs: add missing diamond brackets
 + submodule: fall back to remote's HEAD for missing remote.<name>.branch
 + send-pack/transport-helper: avoid mentioning a particular branch
 + fmt-merge-msg: stop treating `master` specially

 The name of the primary branch in existing repositories, and the
 default name used for the first branch in newly created
 repositories, is made configurable, so that we can eventually wean
 ourselves off of the hardcoded 'master'.

 Will merge to 'master'.


* ss/cmake-build (2020-06-12) 8 commits
 - ci: modification of main.yml to use cmake for vs-build job
 - cmake: support for building git on windows with msvc and clang.
 - cmake: support for building git on windows with mingw
 - cmake: support for testing git when building out of the source tree
 - cmake: support for testing git with ctest
 - cmake: installation support for git
 - cmake: generate the shell/perl/python scripts and templates, translations
 - Introduce CMake support for configuring Git

 CMake support to build with MSVC for Windows bypassing the Makefile.

 Expecting a reroll.
 Almost there.


* ak/commit-graph-to-slab (2020-06-17) 4 commits
  (merged to 'next' on 2020-06-25 at 9a10ae18d3)
 + commit-graph: minimize commit_graph_data_slab access
 + commit: move members graph_pos, generation to a slab
 + commit-graph: introduce commit_graph_data_slab
 + object: drop parsed_object_pool->commit_count

 A few fields in "struct commit" that do not have to always be
 present have been moved to commit slabs.

 Will merge to 'master'.


* dl/test-must-fail-fixes-5 (2020-06-24) 4 commits
 - lib-submodule-update: pass 'test_must_fail' as an argument
 - lib-submodule-update: prepend "git" to $command
 - lib-submodule-update: consolidate --recurse-submodules
 - lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Will merge to 'next'.


* sg/commit-graph-cleanups (2020-06-08) 10 commits
 - commit-graph: simplify write_commit_graph_file() #2
 - commit-graph: simplify write_commit_graph_file() #1
 - commit-graph: simplify parse_commit_graph() #2
 - commit-graph: simplify parse_commit_graph() #1
 - commit-graph: clean up #includes
 - diff.h: drop diff_tree_oid() & friends' return value
 - commit-slab: add a function to deep free entries on the slab
 - commit-graph-format.txt: all multi-byte numbers are in network byte order
 - commit-graph: fix parsing the Chunk Lookup table
 - tree-walk.c: don't match submodule entries for 'submod/anything'
 (this branch is used by ds/commit-graph-bloom-updates.)

 The changed-path Bloom filter is improved using ideas from an
 independent implementation.

 Will merge to 'next'.


* xl/upgrade-repo-format (2020-06-05) 4 commits
  (merged to 'next' on 2020-06-19 at 02bf7a9d8c)
 + check_repository_format_gently(): refuse extensions for old repositories
 + sparse-checkout: upgrade repository to version 1 when enabling extension
 + fetch: allow adding a filter after initial clone
 + repository: add a helper function to perform repository format upgrade

 Allow runtime upgrade of the repository format version, which needs
 to be done carefully.

 There is a rather unpleasant backward compatibility worry with the
 last step of this series, but it is the right thing to do in the
 longer term.

 Will merge to 'master'.


* es/config-hooks (2020-05-21) 4 commits
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 What's the status of this one?  Abandoned?


* pw/rebase-i-more-options (2020-05-27) 5 commits
 - rebase: add --reset-author-date
 - rebase -i: support --ignore-date
 - sequencer: rename amend_author to author_to_free
 - rebase -i: support --committer-date-is-author-date
 - rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Expecting a reroll.
 cf. <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>


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


* bc/sha-256-part-2 (2020-06-19) 44 commits
  (merged to 'next' on 2020-06-22 at dc153f366d)
 + remote-testgit: adapt for object-format
 + bundle: detect hash algorithm when reading refs
 + t5300: pass --object-format to git index-pack
 + t5704: send object-format capability with SHA-256
 + t5703: use object-format serve option
 + t5702: offer an object-format capability in the test
 + t/helper: initialize the repository for test-sha1-array
 + remote-curl: avoid truncating refs with ls-remote
 + t1050: pass algorithm to index-pack when outside repo
 + builtin/index-pack: add option to specify hash algorithm
 + remote-curl: detect algorithm for dumb HTTP by size
 + builtin/ls-remote: initialize repository based on fetch
 + t5500: make hash independent
 + serve: advertise object-format capability for protocol v2
 + connect: parse v2 refs with correct hash algorithm
 + connect: pass full packet reader when parsing v2 refs
 + Documentation/technical: document object-format for protocol v2
 + t1302: expect repo format version 1 for SHA-256
 + builtin/show-index: provide options to determine hash algo
 + t5302: modernize test formatting
 + packfile: compute and use the index CRC offset
 + t3200: mark assertion with SHA1 prerequisite
 + setup: set the_repository's hash algo when checking format
 + fetch-pack: parse and advertise the object-format capability
 + t5562: pass object-format in synthesized test data
 + builtin/clone: initialize hash algorithm properly
 + remote-curl: implement object-format extensions
 + transport-helper: implement object-format extensions
 + docs: update remote helper docs for object-format extensions
 + builtin/receive-pack: detect when the server doesn't support our hash
 + connect: detect algorithm when fetching refs
 + fetch-pack: detect when the server doesn't support our hash
 + connect: make parse_feature_value extern
 + send-pack: detect when the server doesn't support our hash
 + connect: add function to detect supported v1 hash functions
 + transport: add a hash algorithm member
 + pkt-line: add a member for hash algorithm
 + connect: add function to fetch value of a v2 server capability
 + connect: add function to parse multiple v1 capability values
 + remote: advertise the object-format capability on the server side
 + wrapper: add function to compare strings with different NUL termination
 + connect: have ref processing code take struct packet_reader
 + Documentation: document v1 protocol object-format capability
 + t1050: match object ID paths in a hash-insensitive way
 (this branch is used by bc/sha-256-cvs-svn-updates.)

 SHA-256 migration work continues.

 Will merge to 'master'.


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


* hn/reftable (2020-06-22) 20 commits
 - SQUASH??? fix new blank line at EOF
 - Add "test-tool dump-reftable" command.
 - Add reftable testing infrastructure
 - git-prompt: prepare for reftable refs backend
 - vcxproj: adjust for the reftable changes
 - Add GIT_DEBUG_REFS debugging mechanism
 - Hookup unittests for the reftable library.
 - Reftable support for git-core
 - Add standalone build infrastructure for reftable
 - Add reftable library
 - Add .gitattributes for the reftable/ directory
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - Move REF_LOG_ONLY to refs-internal.h
 - Treat REVERT_HEAD as a pseudo ref
 - Treat CHERRY_PICK_HEAD as a pseudo ref
 - Treat BISECT_HEAD as a pseudo ref
 - Make refs_ref_exists public
 - Write pseudorefs through ref backends.
 - checkout: add '\n' to reflog message
 - lib-t6000.sh: write tag using git-update-ref

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 Does not seem to play well with the xl/upgrade-repo-format topic;
 perhaps rework on top of 'master' after that topic graduates?

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
