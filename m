Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC2C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F7720721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 22:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rh6N3ok9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEEWiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 18:38:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55904 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgEEWiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 18:38:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A194FC7A1C;
        Tue,  5 May 2020 18:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=g
        eRAKSFahDfVpMT0oOD5m+xqTHs=; b=Rh6N3ok9O+8kXMT3kEhiuM8xlFC06FKSg
        QQMW2TvRa4iGgn5AXfS4l0eb8h3AGUGSw1KI5OE8W9ie1xZmP9zKAEvUn/RshEb8
        AoYK1bh94ur1Z9rFhG6GNSvfyeYqiB5kABdUzNfAjgNRNBNJ4h5wpdy8C9C5Pi5k
        cp4NUavsK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=xTI
        kyOv4bIg9GsMDuk73M0KRpUhIwdBT5vzCsI1dEYRWHsw8ygfA51ij5s5DF4iabc3
        3yReFdFQm6MQ0SC+mF0PoVAuG5LyyXS3h2glxsmJ1ovTEaXYu3UdOkdfTL5qwSLP
        P+vkDuHH3kmBnQCA7ujFx9SejBrfwA73M5ipTPuE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99B46C7A1B;
        Tue,  5 May 2020 18:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C45E9C7A19;
        Tue,  5 May 2020 18:38:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2020, #02; Tue, 5)
X-master-at: 07d8ea56f2ecb64b75b92264770c0a664231ce17
X-next-at: 55c56c9c57da646085d27e61a3420043978ab4a1
Date:   Tue, 05 May 2020 15:38:41 -0700
Message-ID: <xmqq8si69fda.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C4DCB96-8F21-11EA-A939-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/wildcard-credential (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 1a0d6b91dc)
 + credential: fix matching URLs with multiple levels in path

 Update the parser used for credential.<URL>.<variable>
 configuration, to handle <URL>s with '/' in them correctly.


* dd/iso-8601-updates (2020-04-24) 4 commits
  (merged to 'next' on 2020-04-28 at 18fba39171)
 + date.c: allow compact version of ISO-8601 datetime
 + date.c: skip fractional second part of ISO-8601
 + date.c: validate and set time in a helper function
 + date.c: s/is_date/set_date/

 The approxidate parser learns to parse seconds with fraction.


* dd/mailinfo-with-nul (2020-04-22) 3 commits
  (merged to 'next' on 2020-04-28 at b1d3e40d49)
 + mailinfo: disallow NUL character in mail's header
 + mailinfo.c: avoid strlen on strings that can contains NUL
 + t4254: merge 2 steps of a single test

 Tighten "git mailinfo" to notice and error out when decoded result
 contains NUL in it.


* dd/sparse-fixes (2020-04-27) 4 commits
  (merged to 'next' on 2020-04-28 at d809f916ee)
 + progress.c: silence cgcc suggestion about internal linkage
 + graph.c: limit linkage of internal variable
 + compat/regex: move stdlib.h up in inclusion chain
 + test-parse-pathspec-file.c: s/0/NULL/ for pointer type

 Compilation fix.


* dl/opt-callback-cleanup (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at aa773e183a)
 + Use OPT_CALLBACK and OPT_CALLBACK_F

 Code cleanup.


* dl/push-recurse-submodules-fix (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at c2cd20ef9e)
 + push: unset PARSE_OPT_OPTARG for --recurse-submodules

 Code cleanup.


* dl/test-must-fail-fixes-4 (2020-04-20) 7 commits
  (merged to 'next' on 2020-04-28 at 6f4804aa09)
 + t9819: don't use test_must_fail with p4
 + t9164: use test_must_fail only on git commands
 + t9160: use test_path_is_missing()
 + t9141: use test_path_is_missing()
 + t7508: don't use `test_must_fail test_cmp`
 + t7408: replace incorrect uses of test_must_fail
 + t6030: use test_path_is_missing()

 Test clean-up.


* ds/blame-on-bloom (2020-04-23) 6 commits
  (merged to 'next' on 2020-04-28 at 6152eb2eb3)
 + test-bloom: check that we have expected arguments
 + test-bloom: fix some whitespace issues
 + blame: drop unused parameter from maybe_changed_path
  (merged to 'next' on 2020-04-22 at dc4f24e54b)
 + blame: use changed-path Bloom filters
 + tests: write commit-graph with Bloom filters
 + revision: complicated pathspecs disable filters
 (this branch is used by ds/line-log-on-bloom; uses gs/commit-graph-path-filter.)

 "git blame" learns to take advantage of the "changed-paths" Bloom
 filter stored in the commit-graph file.


* ds/build-homebrew-gettext-fix (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 70c6eca470)
 + macOS/brew: let the build find gettext headers/libraries/msgfmt

 Recent update to Homebrew used by macOS folks breaks build by
 moving gettext library and necessary headers.


* ds/multi-pack-index (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at b8f9691cbc)
 + multi-pack-index: close file descriptor after mmap

 The multi-pack-index left mmapped file descriptors open when it
 does not have to.


* eb/gitweb-more-trailers (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at 7b16ac0810)
 + gitweb: Recognize *-to and Closes/Fixes trailers

 Gitweb updates.


* en/rebase-root-and-fork-point-are-incompatible (2020-04-27) 1 commit
  (merged to 'next' on 2020-04-28 at 8ea4882905)
 + rebase: display an error if --root and --fork-point are both provided

 Incompatible options "--root" and "--fork-point" of "git rebase"
 have been marked and documented as being incompatible.


* es/bugreport (2020-04-27) 6 commits
  (merged to 'next' on 2020-04-28 at fdfd36a5d7)
 + bugreport: drop extraneous includes
  (merged to 'next' on 2020-04-22 at f5a2ab988e)
 + bugreport: add compiler info
 + bugreport: add uname info
 + bugreport: gather git version and build info
 + bugreport: add tool to generate debugging info
 + help: move list_config_help to builtin/help
 (this branch is used by es/bugreport-with-hooks.)

 The "bugreport" tool.


* gs/commit-graph-path-filter (2020-04-09) 16 commits
  (merged to 'next' on 2020-04-22 at 34b35f43bd)
 + bloom: ignore renames when computing changed paths
 + commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
 + t4216: add end to end tests for git log with Bloom filters
 + revision.c: add trace2 stats around Bloom filter usage
 + revision.c: use Bloom filters to speed up path based revision walks
 + commit-graph: add --changed-paths option to write subcommand
 + commit-graph: reuse existing Bloom filters during write
 + commit-graph: write Bloom filters to commit graph file
 + commit-graph: examine commits by generation number
 + commit-graph: examine changed-path objects in pack order
 + commit-graph: compute Bloom filters for changed paths
 + diff: halt tree-diff early after max_changes
 + bloom.c: core Bloom filter implementation for changed paths.
 + bloom.c: introduce core Bloom filter constructs
 + bloom.c: add the murmur3 hash implementation
 + commit-graph: define and use MAX_NUM_CHUNKS
 (this branch is used by ds/blame-on-bloom and ds/line-log-on-bloom.)

 Introduce an extension to the commit-graph to make it efficient to
 check for the paths that were modified at each commit using Bloom
 filters.


* jk/build-with-right-curl (2020-04-05) 3 commits
  (merged to 'next' on 2020-04-28 at 1718c25b44)
 + Makefile: avoid running curl-config unnecessarily
 + Makefile: use curl-config --cflags
 + Makefile: avoid running curl-config multiple times

 The build procedure did not use the libcurl library and its include
 files correctly for a custom-built installation.
 cf. <20200428033611.GB2369457@coredump.intra.peff.net>


* jk/test-fail-prereqs-fix (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at 75787711c0)
 + t0000: disable GIT_TEST_FAIL_PREREQS in sub-tests

 Test update.


* js/anonymise-push-url-in-errors (2020-04-28) 1 commit
  (merged to 'next' on 2020-04-28 at 49539cf116)
 + push: anonymize URLs in error messages and warnings

 Error and verbose trace messages from "git push" did not redact
 credential material embedded in URLs.


* js/partial-urlmatch (2020-04-29) 3 commits
  (merged to 'next' on 2020-05-01 at e7017fcfd1)
 + Sync with js/partial-urlmatch-2.17
 + credential: handle `credential.<partial-URL>.<key>` again
 + credential: optionally allow partial URLs in credential_from_url_gently()
 (this branch uses js/partial-urlmatch-2.17.)

 The same as js/partial-urlmatch-2.17, built on more recent codebase
 to avoid unnecessary merge conflicts.


* js/partial-urlmatch-2.17 (2020-04-29) 3 commits
  (merged to 'next' on 2020-05-01 at 7c69571f89)
 + credential: handle `credential.<partial-URL>.<key>` again
 + credential: optionally allow partial URLs in credential_from_url_gently()
 + credential: fix grammar
 (this branch is used by js/partial-urlmatch.)

 Recent updates broke parsing of "credential.<url>.<key>" where
 <url> is not a full URL (e.g. [credential "https://"] helper = ...)
 stopped working, which has been corrected.


* jt/v2-fetch-nego-fix (2020-04-28) 3 commits
  (merged to 'next' on 2020-04-28 at c6f9ebf2f7)
 + fetch-pack: in protocol v2, reset in_vain upon ACK
 + fetch-pack: in protocol v2, in_vain only after ACK
 + fetch-pack: return enum from process_acks()

 The upload-pack protocol v2 gave up too early before finding a
 common ancestor, resulting in a wasteful fetch from a fork of a
 project.  This has been corrected to match the behaviour of v0
 protocol.


* mt/doc-worktree-ref (2020-04-24) 1 commit
  (merged to 'next' on 2020-04-28 at d96c05cb0a)
 + config doc: fix reference to config.worktree info

 Docfix.


* tb/commit-graph-fd-exhaustion-fix (2020-04-24) 4 commits
  (merged to 'next' on 2020-04-28 at 6d5fd6bc49)
 + commit-graph: close descriptors after mmap
 + commit-graph.c: gracefully handle file descriptor exhaustion
 + t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to tests
 + commit-graph.c: don't use discarded graph_name in error
 (this branch is tangled with tb/commit-graph-split-strategy.)

 The commit-graph code exhausted file descriptors easily when it
 does not have to.


* tb/commit-graph-perm-bits (2020-04-29) 5 commits
  (merged to 'next' on 2020-04-29 at 66a87c1fbc)
 + commit-graph.c: make 'commit-graph-chain's read-only
 + commit-graph.c: ensure graph layers respect core.sharedRepository
 + commit-graph.c: write non-split graphs as read-only
 + lockfile.c: introduce 'hold_lock_file_for_update_mode'
 + tempfile.c: introduce 'create_tempfile_mode'

 Some of the files commit-graph subsystem keeps on disk did not
 correctly honor the core.sharedRepository settings and some were
 left read-write.


* tb/commit-graph-split-strategy (2020-04-29) 8 commits
  (merged to 'next' on 2020-04-29 at 99fa922569)
 + Revert "commit-graph.c: introduce '--[no-]check-oids'"
 + commit-graph.c: introduce '--[no-]check-oids'
 + commit-graph.h: replace 'commit_hex' with 'commits'
 + oidset: introduce 'oidset_size'
 + builtin/commit-graph.c: introduce split strategy 'replace'
 + builtin/commit-graph.c: introduce split strategy 'no-merge'
 + builtin/commit-graph.c: support for '--split[=<strategy>]'
 + t/helper/test-read-graph.c: support commit-graph chains
 (this branch is tangled with tb/commit-graph-fd-exhaustion-fix.)

 "git commit-graph write" learned different ways to write out split
 files.


* tb/reset-shallow (2020-04-24) 2 commits
  (merged to 'next' on 2020-04-28 at 9510639ae8)
 + shallow.c: use '{commit,rollback}_shallow_file'
 + t5537: use test_write_lines and indented heredocs for readability
 (this branch is used by tb/shallow-cleanup.)

 Fix in-core inconsistency after fetching into a shallow repository
 that broke the code to write out commit-graph.

--------------------------------------------------
[New Topics]

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


* es/restore-staged-from-head-by-default (2020-05-05) 1 commit
 - restore: default to HEAD when combining --staged and --worktree

 "git restore --staged --worktree" now defaults to take the contents
 out of "HEAD", instead of erroring out.

 Will merge to 'next'.


* jk/credential-sample-update (2020-05-01) 2 commits
 - gitcredentials(7): make shell-snippet example more realistic
 - gitcredentials(7): clarify quoting of helper examples

 The samples in the credential documentation has been updated to
 make it clear that we depict what would appear in the .git/config
 file, by adding appropriate quotes as needed..

 Will merge to 'next'.


* jk/for-each-ref-multi-key-sort-fix (2020-05-04) 2 commits
 - ref-filter: apply fallback refname sort only after all user sorts
 - ref-filter: apply --ignore-case to all sorting keys

 "git branch" and other "for-each-ref" variants accepted multiple
 --sort=<key> options in the increasing order of precedence, but it
 had a few breakages around "--ignore-case" handling, and tiebreaking
 with the refname, which have been fixed.

 Will merge to 'next'.


* js/rebase-autosquash-double-fixup-fix (2020-05-04) 1 commit
 - rebase --autosquash: fix a potential segfault

 "rebase -i" segfaulted when rearranging a sequence that has a
 fix-up that applies another fix-up (which may or may not be a
 fix-up of yet another step).

 Under review.
 cf. <pull.625.git.1588624804554.gitgitgadget@gmail.com>


* jt/commit-graph-plug-memleak (2020-05-04) 1 commit
 - commit-graph: avoid memory leaks

 Fix a leak noticed by fuzzer.

 Will merge to 'next'.


* cb/credential-doc-fixes (2020-05-04) 4 commits
 - credential: document protocol updates
 - credential: update gitcredentials documentation
 - credential: correct order of parameters for credential_match
 - credential: update description for credential_from_url_gently

 Minor in-code comments and documentation updates around credential
 API.

 Needs review.
 cf. <20200505013908.4596-1-carenas@gmail.com>


* ds/sparse-allow-empty-working-tree (2020-05-04) 1 commit
 - sparse-checkout: stop blocking empty workdirs

 The sparse-checkout patterns have been forbidden from excluding all
 paths, leaving an empty working tree, for a long time.  This
 limitation has been lifted.

 Will merge to 'next'.


* jk/arith-expansion-coding-guidelines (2020-05-04) 1 commit
 - CodingGuidelines: drop arithmetic expansion advice to use "$x"

 The coding guideline for shell scripts instructed to refer to a
 variable with dollar-sign inside airthmetic expansion to work
 around a bug in old versions of dash, which is a thing of the past.
 Now we are not forbidden from writing $((var+1)).

 Will merge to 'next'.


* tb/bitmap-walk-with-tree-zero-filter (2020-05-04) 4 commits
 - pack-bitmap: pass object filter to fill-in traversal
 - pack-bitmap.c: support 'tree:0' filtering
 - pack-bitmap.c: make object filtering functions generic
 - list-objects-filter: treat NULL filter_options as "disabled"

 The object walk with object filter "--filter=tree:0" can now take
 advantage of the pack bitmap when available.

 Will merge to 'next'.


* tb/commit-graph-no-check-oids (2020-05-04) 8 commits
 - commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
 - t5318: reorder test below 'graph_read_expect'
 - commit-graph.c: simplify 'fill_oids_from_commits'
 - builtin/commit-graph.c: dereference tags in builtin
 - builtin/commit-graph.c: extract 'read_one_commit()'
 - commit-graph.c: peel refs in 'add_ref_to_set'
 - commit-graph.c: show progress of finding reachable commits
 - commit-graph.c: extract 'refs_cb_data'

 Clean-up the commit-graph codepath.

 Expecting a reroll
 cf. <20200505161649.GG69300@syl.local>


* cb/avoid-colliding-with-netbsd-hmac (2020-05-05) 1 commit
 - builtin/receive-pack: avoid generic function name hmac()

 The <stdlib.h> header on NetBSD brings in its own definition of
 hmac() function (eek), which conflicts with our own and unrelated
 function with the same name.  Our function has been renamed to work
 around the issue.

 Will merge to 'next'.


* dl/doc-stash-remove-mention-of-reflog (2020-05-05) 1 commit
 - Doc: reference the "stash list" in autostash docs

 Doc update.

 Will merge to 'next'.


* dl/test-must-fail-fixes-5 (2020-05-05) 4 commits
 - lib-submodule-update: pass OVERWRITING_FAIL
 - lib-submodule-update: prepend "git" to $command
 - lib-submodule-update: consolidate --recurse-submodules
 - lib-submodule-update: add space after function name

 The effort to avoid using test_must_fail on non-git command continues.

 Needs review.
 cf. <cover.1588162842.git.liu.denton@gmail.com>


* dd/ci-only-on-selective-branches (2020-05-05) 2 commits
 - CI: limit GitHub Actions to designated branches
 - SubmittingPatches: advertise GitHub Actions CI

 Instead of always building all branches of all forks of our project
 at GitHub via GitHub Actions, only build when branches with known
 and specific names are updated, and also a pull request.

 Expecting an update.
 cf. <cover.1588695295.git.congdanhqx@gmail.com>
 The description talks too much about helping (or not getting in the
 way of) the current maintainer, but the focus should instead be
 general contributors.

--------------------------------------------------
[Stalled]

* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* cb/credential-store-ignore-bogus-lines (2020-05-02) 2 commits
  (merged to 'next' on 2020-05-05 at 5b919ec5d6)
 + credential-store: ignore bogus lines from store file
 + credential-store: document the file format a bit more

 With the recent tightening of the code that is used to parse
 various parts of a URL for use in the credential subsystem, a
 hand-edited credential-store file causes the credential helper to
 die, which is a bit too harsh to the users.  Demote the error
 behaviour to only warn and keep using well-formed lines instead.

 Will merge to 'master'.


* dl/switch-c-option-in-error-message (2020-04-30) 1 commit
  (merged to 'next' on 2020-05-05 at 472db48735)
 + switch: fix errors and comments related to -c and -C

 In error messages that "git switch" mentions its option to create a
 new branch, "-b/-B" options were shown, where "-c/-C" options
 should be, which has been corrected.

 Will merge to 'master'.


* es/bugreport-with-hooks (2020-04-30) 2 commits
 - SQUASH???
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


* ah/userdiff-markdown (2020-05-02) 1 commit
  (merged to 'next' on 2020-05-05 at b8e64b75d0)
 + userdiff: support Markdown

 The userdiff patterns for Markdown documents have been added.

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


* jx/proc-receive-hook (2020-05-05) 7 commits
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


* hn/reftable (2020-05-04) 12 commits
 - t: use update-ref and show-ref to reading/writing refs
 - Add some reftable testing infrastructure
 - vcxproj: adjust for the reftable changes
 - Reftable support for git-core
 - Add reftable library
 - reftable: clarify how empty tables should be written
 - reftable: define version 2 of the spec to accomodate SHA256
 - reftable: file format documentation
 - Add .gitattributes for the reftable/ directory
 - refs: document how ref_iterator_advance_fn should handle symrefs
 - Iterate over the "refs/" namespace in for_each_[raw]ref
 - refs.h: clarify reflog iteration order

 A new refs backend "reftable" to replace the traditional
 combination of packed-refs files and one-file-per-ref loose refs
 has been implemented and integrated for improved performance and
 atomicity.

 At v11.

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
