Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077ED1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 05:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbdKHFua (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 00:50:30 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:50491 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdKHFu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 00:50:27 -0500
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 5D16012DD4;
        Wed,  8 Nov 2017 00:50:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=+
        53eHlEeujqbKOIQBE8tSMVbhuU=; b=Rr+1VWERGE1+dIxJlApoD+FO0xMGzLewy
        WpFX162CwZU++vIYxCKpZZAXKZDmSptU2XnmuLFqR9X+r172dpGar4tKnWVlVFil
        8v/iFRpLTtpC2cmvFZhOs/z+l46PQAUFz+U8cgbOccBeYsUyHB/dcRtrKBDeEbSY
        CU/flX2Iag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=b0q
        IG2a2YZSu/CmlNLE5mjRyn/bvzDGGiaGJajzW5jIPukIC96+7+Q2Uo88Vf2CT5t8
        lzeVuyE+srDckk1g/c8DasAVeHujUGeg605W41N+sgFRoIdpDix7cK+2GI29wE0s
        dwrVV4TLP5ICB76KXtLY01Z/2Vvz1PZoiadeqGD8=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 477EA12DD3;
        Wed,  8 Nov 2017 00:50:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64E62B2D1A;
        Wed,  8 Nov 2017 00:50:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2017, #03; Wed, 8)
X-master-at: 7668cbc60578f99a4c048f8f8f38787930b8147b
X-next-at: 9af6a3dea062db2d4b3807c453d2f678c7f12e9c
Date:   Wed, 08 Nov 2017 14:50:24 +0900
Message-ID: <xmqqinell3of.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B79786C0-C448-11E7-A758-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'next' has been rebuilt on top of v2.15, while kicking a
few topics back to 'pu'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* bw/rebase-i-ignored-submodule-fix (2017-11-07) 1 commit
 - wt-status: actually ignore submodules when requested

 "git rebase -i" recently started misbehaving when a submodule that
 is configured with 'submodule.<name>.ignore' is dirty; this has
 been corrected.

 Will merge to 'next'.
 I've edited in the tweak brought up in the discussion.  Please
 eyeball to sanity check.


* ar/unconfuse-three-dots (2017-11-07) 3 commits
 - Documentation: revisions: add note about 3dots usages as continuation indications
 - Documentation: user-manual: limit potentially confusing usage of 3dots (and 2dots)
 - checkout: describe_detached_head: remove 3dots after committish

 Ancient part of codebase still shows dots after an abbreviated
 object name just to show that it is not a full object name, but
 these ellipses are confusing to people who newly discovered Git
 who are used to seeing abbreviated object names and find them
 confusing with the range syntax.


* jt/submodule-tests-cleanup (2017-11-08) 1 commit
 - Tests: clean up and document submodule helpers

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jn/ssh-wrappers (2017-10-30) 6 commits
 - fixup! ssh: 'auto' variant to select between 'ssh' and 'simple'
 - ssh: 'simple' variant does not support --port
 - ssh: 'simple' variant does not support -4/-6
 - ssh: 'auto' variant to select between 'ssh' and 'simple'
 - connect: split ssh command line options into separate function
 - connect: split git:// setup into a separate function
 (this branch uses bw/protocol-v1.)

 The ssh-variant 'simple' introduced earlier broke existing
 installations by not passing --port/-4/-6 and not diagnosing an
 attempt to pass these as an error.  Instead, default to
 automatically detect how compatible the GIT_SSH/GIT_SSH_COMMAND is
 to OpenSSH convention and then error out an invocation to make it
 easier to diagnose connection errors.

 Expecting a reroll.
 cf. <20171025163243.xmm7szrkwgblpgcc@aiede.mtv.corp.google.com>


* jc/merge-symlink-ours-theirs (2017-09-26) 1 commit
 - merge: teach -Xours/-Xtheirs to symbolic link merge

 "git merge -Xours/-Xtheirs" learned to use our/their version when
 resolving a conflicting updates to a symbolic link.

 Needs review.


* mg/merge-base-fork-point (2017-09-17) 3 commits
 - merge-base: find fork-point outside partial reflog
 - merge-base: return fork-point outside reflog
 - t6010: test actual test output

 "merge-base --fork-point $branch $commit" is used to guess on which
 commit among the commits that were once at the tip of the $branch the
 $commit was built on top of, and it learns these historical tips from
 the reflog of the $branch.  When the true fork-point is lost due to
 pruning of old reflog entries, the command does not give any output,
 because it has no way to guess correctly and does not want to mislead
 the user with a wrong guess.

 The command has been updated to give the best but not known to be
 correct guess, based on a hope that a merge-base between $commit and a
 virtual merge across all the reflog entries that still are available
 for $branch may still be a closer to the true fork-point than the
 merge-base between $commit and the current tip of the $branch.

 This may have to be offered by an additional option, to allow the
 users that are prepared to see a potentially incorrect guess to opt
 into the feature, without affecting the current callers that may not
 be prepared to accept a guess that is not known to be correct.

 What's the doneness of this one?


* cc/perf-run-config (2017-09-24) 9 commits
 - perf: store subsection results in "test-results/$GIT_PERF_SUBSECTION/"
 - perf/run: show name of rev being built
 - perf/run: add run_subsection()
 - perf/run: update get_var_from_env_or_config() for subsections
 - perf/run: add get_subsections()
 - perf/run: add calls to get_var_from_env_or_config()
 - perf/run: add GIT_PERF_DIRS_OR_REVS
 - perf/run: add get_var_from_env_or_config()
 - perf/run: add '--config' option to the 'run' script

 Needs review.


* jk/drop-ancient-curl (2017-08-09) 5 commits
 - http: #error on too-old curl
 - curl: remove ifdef'd code never used with curl >=7.19.4
 - http: drop support for curl < 7.19.4
 - http: drop support for curl < 7.16.0
 - http: drop support for curl < 7.11.1

 Some code in http.c that has bitrot is being removed.

 Expecting a reroll.


* mk/use-size-t-in-zlib (2017-08-10) 1 commit
 . zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

 Needs resurrecting by making sure the fix is good and still applies
 (or adjusted to today's codebase).


* mg/status-in-progress-info (2017-05-10) 2 commits
 - status --short --inprogress: spell it as --in-progress
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 cf. <xmqqmvakcdqw.fsf@gitster.mtv.corp.google.com>


* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Expecting a reroll.
 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>

--------------------------------------------------
[Cooking]

* js/for-each-ref-remote-name-and-ref (2017-11-08) 3 commits
 - for-each-ref: test :remotename and :remoteref
 - for-each-ref: let upstream/push report the remote ref name
 - for-each-ref: let upstream/push optionally report the remote name

 The "--format=..." option "git for-each-ref" takes learned to show
 the name of the 'remote' repository and the ref at the remote side
 that is affected for 'upstream' and 'push' via "%(push:remotename)"
 and friends.

 Will merge to 'next'.


* js/mingw-redirect-std-handles (2017-11-02) 3 commits
  (merged to 'next' on 2017-11-07 at 9af6a3dea0)
 + mingw: document the standard handle redirection
 + mingw: optionally redirect stderr/stdout via the same handle
 + mingw: add experimental feature to redirect standard handles

 MinGW updates.

 Will merge to 'master'.


* ma/bisect-leakfix (2017-11-06) 4 commits
 - bisect: fix memory leak when returning best element
 - bisect: fix off-by-one error in `best_bisection_sorted()`
 - bisect: fix memory leak in `find_bisection()`
 - bisect: change calling-convention of `find_bisection()`

 Leak fixes.

 Will merge to 'next'.


* ma/reduce-heads-leakfix (2017-11-08) 2 commits
 - reduce_heads: fix memory leaks
 - builtin/merge-base: free commit lists

 Leak fixes.

 Will merge to 'next'.


* sg/travis-fixes (2017-11-02) 2 commits
  (merged to 'next' on 2017-11-07 at bbf39361b6)
 + travis-ci: don't build Git for the static analysis job
 + travis-ci: fix running P4 and Git LFS tests in Linux build jobs

 TravisCI build updates.

 Will merge to 'master'.


* sr/wrapper-quote-filenames (2017-11-06) 1 commit
 - wrapper.c: consistently quote filenames in error messages

 Some error messages did not quote filenames shown in it, which have
 been fixed.

 Will merge to 'next'.


* jh/fsck-promisors (2017-11-08) 9 commits
 - gc: do not repack promisor packfiles
 - sha1_file: support lazily fetching missing objects
 - introduce fetch-object: fetch one promisor object
 - index-pack: refactor writing of .keep files
 - fsck: support promisor objects as CLI argument
 - fsck: support referenced promisor objects
 - fsck: support refs pointing to promisor objects
 - fsck: introduce partialclone extension
 - extension.partialclone: introduce partial clone extension
 (this branch is used by jh/partial-clone; uses jh/object-filtering.)


* jh/object-filtering (2017-11-08) 6 commits
 - pack-objects: add list-objects filtering
 - rev-list: add list-objects filtering support
 - list-objects: filter objects in traverse_commit_list
 - oidset: add iterator methods to oidset
 - oidmap: add oidmap iterator methods
 - dir: allow exclusions from blob in addition to file
 (this branch is used by jh/fsck-promisors and jh/partial-clone.)


* jh/partial-clone (2017-11-08) 15 commits
 - fixup! upload-pack: add object filtering for partial clone
 - index-pack: silently assume missing objects are promisor
 - fetch-pack: restore save_commit_buffer after use
 - unpack-trees: batch fetching of missing blobs
 - t5500: more tests for partial clone and fetch
 - t5601: test for partial clone
 - t5500: add fetch-pack tests for partial clone
 - fetch: add from_promisor and exclude-promisor-objects parameters
 - fetch-pack: test support excluding large blobs
 - pack-objects: test support for blob filtering
 - remote-curl: add object filtering for partial clone
 - fetch: add object filtering for partial fetch
 - fetch: refactor calculation of remote list
 - clone, fetch-pack, index-pack, transport: partial clone
 - upload-pack: add object filtering for partial clone
 (this branch uses jh/fsck-promisors and jh/object-filtering.)


* js/early-config (2017-11-03) 1 commit
  (merged to 'next' on 2017-11-07 at 9477c7c8ea)
 + setup: avoid double slashes when looking for HEAD

 Correct start-up sequence so that a repository could be placed
 immediately under the root directory again (which was broken at
 around Git 2.13).

 Will merge to 'master'.


* ks/mailmap (2017-11-03) 1 commit
  (merged to 'next' on 2017-11-07 at 46975637c7)
 + mailmap: use Kaartic Sivaraam's new address

 Will merge to 'master'.


* rs/imap-send-next-arg-fix (2017-11-03) 2 commits
  (merged to 'next' on 2017-11-07 at f4df55fe5b)
 + imap-send: handle missing response codes gracefully
 + imap-send: handle NULL return of next_arg()

 Error checking in "git imap-send" for empty response has been
 improved.

 Will merge to 'master'.


* dk/libsecret-unlock-to-load-fix (2017-11-04) 1 commit
  (merged to 'next' on 2017-11-07 at 57d1d76c8c)
 + credential-libsecret: unlock locked secrets

 The credential helper for libsecret (in contrib/) has been improved
 to allow possibly prompting the end user to unlock secrets that are
 currently locked (otherwise the secrets may not be loaded).

 Will merge to 'master'.


* jm/relnotes-2.15-typofix (2017-11-06) 1 commit
  (merged to 'next' on 2017-11-07 at 60fc937b62)
 + fix typos in 2.15.0 release notes

 Typofix.

 Will merge to 'master'.


* sb/blame-config-doc (2017-11-06) 1 commit
  (merged to 'next' on 2017-11-07 at 0576cb452f)
 + config: document blame configuration

 Description of blame.{showroot,blankboundary,showemail,date}
 configuration variables have been added to "git config --help".

 Will merge to 'master'.


* ad/5580-unc-tests-on-cygwin (2017-11-01) 1 commit
  (merged to 'next' on 2017-11-07 at 34fc479da2)
 + t5580: add Cygwin support

 UNC paths are also relevant in Cygwin builds and they are now
 tested just like Mingw builds.

 Will merge to 'master'.


* ao/merge-verbosity-getenv-just-once (2017-11-01) 1 commit
 - merge-recursive: check GIT_MERGE_VERBOSITY only once

 Code cleanup.

 Will merge to 'next'.


* bp/read-index-from-skip-verification (2017-11-08) 1 commit
 - read_index_from(): speed index loading by skipping verification of the entry order

 Drop (perhaps overly cautious) sanity check before using the index
 read from the filesystem at runtime.

 Will merge to 'next'.


* rs/hex-to-bytes-cleanup (2017-11-01) 3 commits
  (merged to 'next' on 2017-11-07 at fac14770e1)
 + sha1_file: use hex_to_bytes()
 + http-push: use hex_to_bytes()
 + notes: move hex_to_bytes() to hex.c and export it

 Code cleanup.

 Will merge to 'master'.


* rs/sequencer-rewrite-file-cleanup (2017-11-02) 3 commits
 - sequencer.c: check return value of close() in rewrite_file()
 - sequencer: use O_TRUNC to truncate files
 - sequencer: factor out rewrite_file()

 Code cleanup.

 Will merge to 'next'.


* sb/describe-blob (2017-11-03) 7 commits
 - builtin/describe.c: describe a blob
 - builtin/describe.c: factor out describe_commit
 - builtin/describe.c: print debug statements earlier
 - builtin/describe.c: rename `oid` to avoid variable shadowing
 - revision.h: introduce blob/tree walking in order of the commits
 - list-objects.c: factor out traverse_trees_and_blobs
 - t6120: fix typo in test name

 "git describe" was taught to dig trees deeper to find a
 <commit-ish>:<path> that refers to a given blob object.


* tb/add-renormalize (2017-11-07) 2 commits
 - SQUASH???
 - add: introduce "--renormalize"

 "git add --renormalize ." is a new and safer way to record the fact
 that you are correcting the end-of-line convention and other
 "convert_to_git()" glitches in the in-repository data.


* ab/mediawiki-name-truncation (2017-11-01) 1 commit
  (merged to 'next' on 2017-11-07 at b30233d585)
 + remote-mediawiki: limit filenames to legal

 The remote-helper for talking to MediaWiki has been updated to
 truncate an overlong pagename so that ".mw" suffix can still be
 added.

 Will merge to 'master'.


* ab/mediawiki-namespace (2017-11-08) 7 commits
 - remote-mediawiki: show progress while fetching namespaces
 - remote-mediawiki: process namespaces in order
 - remote-mediawiki: support fetching from (Main) namespace
 - remote-mediawiki: skip virtual namespaces
 - remote-mediawiki: show known namespace choices on failure
 - remote-mediawiki: allow fetching namespaces with spaces
 - remote-mediawiki: add namespace support

 The remote-helper for talking to MediaWiki has been updated to
 work with mediawiki namespaces.

 Will merge to 'next'.


* js/mingw-full-version-in-resources (2017-11-01) 1 commit
  (merged to 'next' on 2017-11-07 at 3a256b5ddc)
 + mingw: include the full version information in the resources

 MinGW updates.

 Will merge to 'master'.


* js/wincred-empty-cred (2017-11-01) 2 commits
  (merged to 'next' on 2017-11-07 at 43d3fcc30a)
 + wincred: handle empty username/password correctly
 + t0302: check helper can handle empty credentials

 MinGW updates.

 Will merge to 'master'.


* bw/diff-opt-impl-to-bitfields (2017-11-01) 8 commits
  (merged to 'next' on 2017-11-07 at 8be78206ba)
 + diff: make struct diff_flags members lowercase
 + diff: remove DIFF_OPT_CLR macro
 + diff: remove DIFF_OPT_SET macro
 + diff: remove DIFF_OPT_TST macro
 + diff: remove touched flags
 + diff: add flag to indicate textconv was set via cmdline
 + diff: convert flags to be stored in bitfields
 + add, reset: use DIFF_OPT_SET macro to set a diff flag

 A single-word "unsigned flags" in the diff options is being split
 into a structure with many bitfields.

 Will merge to 'master'.


* mh/tidy-ref-update-flags (2017-11-06) 10 commits
 - refs: update some more docs to use "oid" rather than "sha1"
 - write_packed_entry(): take `object_id` arguments
 - refs: rename constant `REF_ISPRUNING` to `REF_IS_PRUNING`
 - refs: rename constant `REF_NODEREF` to `REF_NO_DEREF`
 - refs: tidy up and adjust visibility of the `ref_update` flags
 - ref_transaction_add_update(): remove a check
 - ref_transaction_update(): die on disallowed flags
 - prune_ref(): call `ref_transaction_add_update()` directly
 - files_transaction_prepare(): don't leak flags to packed transaction
 - Merge branch 'bc/object-id' into base

 Code clean-up in refs API implementation.

 Will merge to 'next'.


* ao/diff-populate-filespec-lstat-errorpath-fix (2017-10-29) 1 commit
  (merged to 'next' on 2017-11-07 at b03241e6e5)
 + diff: fix lstat() error handling in diff_populate_filespec()

 After an error from lstat(), diff_populate_filespec() function
 sometimes still went ahead and used invalid data in struct stat,
 which has been fixed.

 Will merge to 'master'.


* av/fsmonitor (2017-11-01) 4 commits
  (merged to 'next' on 2017-11-07 at a06178754d)
 + fsmonitor: delay updating state until after split index is merged
 + fsmonitor: document GIT_TRACE_FSMONITOR
 + fsmonitor: don't bother pretty-printing JSON from watchman
 + fsmonitor: set the PWD to the top of the working tree
 (this branch uses bp/fsmonitor.)

 Various fixes to bp/fsmonitor topic.

 Will merge to 'master'.


* bc/submitting-patches-in-asciidoc (2017-10-30) 2 commits
 - Documentation: convert SubmittingPatches to AsciiDoc
 - Documentation: enable compat-mode for Asciidoctor

 The SubmittingPatches document has been converted to produce an
 HTML version via AsciiDoc/Asciidoctor.

 Any further comments?  Otherwise, will merge to 'next'.


* pb/bisect-helper-2 (2017-10-28) 8 commits
 - t6030: make various test to pass GETTEXT_POISON tests
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `bisect_reset` shell function in C

 Expecting a reroll.
 cf. <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>


* jc/ignore-cr-at-eol (2017-11-08) 2 commits
 - diff: --ignore-cr-at-eol
 - xdiff: reassign xpparm_t.flags bits

 The "diff" family of commands learned to ignore differences in
 carriage return at the end of line.


* mh/avoid-rewriting-packed-refs (2017-10-30) 2 commits
 - files-backend: don't rewrite the `packed-refs` file unnecessarily
 - t1409: check that `packed-refs` is not rewritten unnecessarily

 Recent update to the refs infrastructure implementation started
 rewriting packed-refs file more often than before; this has been
 optimized again for most trivial cases.

 Will merge to 'next'.


* cc/git-packet-pm (2017-11-07) 8 commits
 - Git/Packet.pm: extract parts of t0021/rot13-filter.pl for reuse
 - t0021/rot13-filter: add capability functions
 - t0021/rot13-filter: refactor checking final lf
 - t0021/rot13-filter: add packet_initialize()
 - t0021/rot13-filter: improve error message
 - t0021/rot13-filter: improve 'if .. elsif .. else' style
 - t0021/rot13-filter: refactor packet reading functions
 - t0021/rot13-filter: fix list comparison

 Parts of a test to drive the long-running content filter interface
 has been split into its own module, hopefully to eventually become
 reusable.

 Will merge to 'next'.


* jm/status-ignored-files-list (2017-10-31) 4 commits
  (merged to 'next' on 2017-11-07 at 682c74a2cb)
 + status: test ignored modes
 + status: document options to show matching ignored files
 + status: report matching ignored and normal untracked
 + status: add option to show ignored files differently

 Originally merged to 'next' on 2017-11-01

 The set of paths output from "git status --ignored" was tied
 closely with its "--untracked=<mode>" option, but now it can be
 controlled more flexibly.  Most notably, a directory that is
 ignored because it is listed to be ignored in the ignore/exclude
 mechanism can be handled differently from a directory that ends up
 to be ignored only because all files in it are ignored.

 Will merge to 'master'.


* jc/branch-name-sanity (2017-10-14) 3 commits
 - branch: forbid refs/heads/HEAD
 - branch: split validate_new_branchname() into two
 - branch: streamline "attr_only" handling in validate_new_branchname()

 "git branch" and "git checkout -b" are now forbidden from creating
 a branch whose name is "HEAD".

 Reported to cause problems when renaming HEAD during a rebase.
 cf. <49563f7c-354e-334e-03a6-c3a40884b6d0@gmail.com>


* ot/mru-on-list (2017-10-01) 1 commit
 - mru: use double-linked list from list.h

 The first step to getting rid of mru API and using the
 doubly-linked list API directly instead.

 Is there any remaining issues on this one?


* jm/svn-pushmergeinfo-fix (2017-09-17) 1 commit
 - git-svn: fix svn.pushmergeinfo handling of svn+ssh usernames.

 "git svn dcommit" did not take into account the fact that a
 svn+ssh:// URL with a username@ (typically used for pushing) refers
 to the same SVN repository without the username@ and failed when
 svn.pushmergeinfo option is set.

 Needs a test, perhaps as a follow-up patch.

 Will merge to 'next'.


* bp/fsmonitor (2017-10-05) 15 commits
  (merged to 'next' on 2017-11-07 at b08d44ba60)
 + fsmonitor: preserve utf8 filenames in fsmonitor-watchman log
 + fsmonitor: read entirety of watchman output
 + fsmonitor: MINGW support for watchman integration
 + fsmonitor: add a performance test
 + fsmonitor: add a sample integration script for Watchman
 + fsmonitor: add test cases for fsmonitor extension
 + split-index: disable the fsmonitor extension when running the split index test
 + fsmonitor: add a test tool to dump the index extension
 + update-index: add fsmonitor support to update-index
 + ls-files: Add support in ls-files to display the fsmonitor valid bit
 + fsmonitor: add documentation for the fsmonitor extension.
 + fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
 + update-index: add a new --force-write-index option
 + preload-index: add override to enable testing preload-index
 + bswap: add 64 bit endianness helper get_be64
 (this branch is used by av/fsmonitor.)

 Originally merged to 'next' on 2017-10-05

 We learned to talk to watchman to speed up "git status" and other
 operations that need to see which paths have been modified.

 Will merge to 'master'.


* bw/protocol-v1 (2017-10-17) 11 commits
 - Documentation: document Extra Parameters
 - ssh: introduce a 'simple' ssh variant
 - i5700: add interop test for protocol transition
 - http: tell server that the client understands v1
 - connect: tell server that the client understands v1
 - connect: teach client to recognize v1 server response
 - upload-pack, receive-pack: introduce protocol version 1
 - daemon: recognize hidden request arguments
 - protocol: introduce protocol extension mechanisms
 - pkt-line: add packet_write function
 - connect: in ref advertisement, shallows are last
 (this branch is used by jn/ssh-wrappers.)

 A new mechanism to upgrade the wire protocol in place is proposed
 and demonstrated that it works with the older versions of Git
 without harming them.

 Waiting for jn/ssh-wrappers topic.


* bc/hash-algo (2017-10-30) 4 commits
 - Switch empty tree and blob lookups to use hash abstraction
 - Integrate hash algorithm support with repo setup
 - Add structure representing hash algorithm
 - setup: expose enumerated repo info

 An infrastructure to define what hash function is used in Git is
 introduced, and an effort to plumb that throughout various
 codepaths has been started.

 cf. <20171028181239.59458-1-sandals@crustytoothpaste.net>


* sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
 - Documentation/checkout: clarify submodule HEADs to be detached
 - recursive submodules: detach HEAD from new state

 "git checkout --recursive" may overwrite and rewind the history of
 the branch that happens to be checked out in submodule
 repositories, which might not be desirable.  Detach the HEAD but
 still allow the recursive checkout to succeed in such a case.

 Expecting a reroll.

--------------------------------------------------
[Discarded]

* jk/ui-color-always-to-auto-maint (2017-10-13) 2 commits
 . color: document that "git -c color.*=always" is a bit special
 . color: downgrade "always" to "auto" only for on-disk configuration

 It turns out that "git -c color.ui=always cmd" is relied on by many
 third-party tools as a way to force coloured output no matter what
 the end-user configuration is, and a recent attempt to downgrade
 'always' to 'auto' to fix the regression to "git add -p" broke it.

 This has been reverted from 'next'.


* jt/partial-clone-lazy-fetch (2017-10-02) 18 commits
 . fetch-pack: restore save_commit_buffer after use
 . unpack-trees: batch fetching of missing blobs
 . clone: configure blobmaxbytes in created repos
 . clone: support excluding large blobs
 . fetch: support excluding large blobs
 . fetch: refactor calculation of remote list
 . fetch-pack: support excluding large blobs
 . pack-objects: support --blob-max-bytes
 . pack-objects: rename want_.* to ignore_.*
 . gc: do not repack promisor packfiles
 . rev-list: support termination at promisor objects
 . sha1_file: support lazily fetching missing objects
 . introduce fetch-object: fetch one promisor object
 . index-pack: refactor writing of .keep files
 . fsck: support promisor objects as CLI argument
 . fsck: support referenced promisor objects
 . fsck: support refs pointing to promisor objects
 . fsck: introduce partialclone extension

 A journey for "git clone" and "git fetch" to become "lazier" by
 depending more on its remote repository---this is the beginning of
 it.

 Superseded by three topics that end with jh/partial-clone.


* jh/dir-add-exclude-from-blob (2017-10-27) 1 commit
 . dir: allow exclusions from blob in addition to file

 The code to read exclusion list from a blob, which is used when the
 .gitignore file is outside a sparse checkout area, has been
 refactored so that other codepath can later use it to do the same
 outside the context of "sparse checkout".

 Now part of jh/object-filtering topic.
