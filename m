Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D02AEE1
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487234; cv=none; b=QEue1WAjytVKWAGZRJK6azNMk9D4vX6e/hn66vMJ4QhoIVf7uzGxL5mFrwmZ1Nc9eoM2FGf29OO9Dj5hfhCvqIUd+5GH62yrzgCdpn/ZsHXQ5MnLaiIGBauqHELIBs226ADjee8ojwZ9096nJ/wxZU6EsZM5R849EKWUPoOWmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487234; c=relaxed/simple;
	bh=CfyukEILZPVE+Gn/z/iHwBfRcTQ+NVeQvE9v9QPGg5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kgw+gM8W8+j9WPaitVVNIvSYEj/DnTcIn9hv4ka8XBHkDBdgoa6wVVkJmxl5bHIVcp9UaPHQaN4F6cjvJjGtvnWgf7ykgtFIgNz/YIhbgxTJpSCMn26xIWAcdv8Yb5fug6+fOnUy1aNAAk3r40pmIPgmrdooR/3jAW3nvIhA3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cV1qnVnl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cV1qnVnl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 37CB425411;
	Mon,  8 Jul 2024 21:07:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	fyukEILZPVE+Gn/z/iHwBfRcTQ+NVeQvE9v9QPGg5Q=; b=cV1qnVnlOSHuXujHw
	A0tI+Rpmw9AaHistwFEqSI9c3GjQ8mJN5alx2I5BVXQ/5qfwgvJdKbsRB+ZRO3ls
	VUpTKIVY1eDW4gfKzU5qBeJ4y5mdV1z/31/HeZCSiCxpkHGjHQwJtKIJG75Ta2tm
	6fmJgodSP6ChLHoAHYBtEaWNAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DD1825410;
	Mon,  8 Jul 2024 21:07:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 774042540F;
	Mon,  8 Jul 2024 21:07:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2024, #02; Mon, 8)
X-master-at: 557ae147e6cdc9db121269b058c757ac5092f9c9
X-next-at: 0f21945a48084c71d64695aac932748af8ec35cc
Date: Mon, 08 Jul 2024 18:07:09 -0700
Message-ID: <xmqqle2bgypu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 91A74F3C-3D8F-11EF-A348-965B910A682E-77302942!pb-smtp2.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* db/date-underflow-fix (2024-06-25) 2 commits
  (merged to 'next' on 2024-06-26 at 8074493d4e)
 + date: detect underflow/overflow when parsing dates with timezone offset
 + t0006: simplify prerequisites

 date parser updates to be more careful about underflowing epoch
 based timestamp.
 source: <20240625231248.4070257-1-gitster@pobox.com>


* ds/sparse-lstat-caching (2024-06-28) 5 commits
  (merged to 'next' on 2024-06-28 at 9efaea181d)
 + sparse-index: improve lstat caching of sparse paths
 + sparse-index: count lstat() calls
 + sparse-index: use strbuf in path_found()
 + sparse-index: refactor path_found()
 + sparse-checkout: refactor skip worktree retry logic

 The code to deal with modified paths that are out-of-cone in a
 sparsely checked out working tree has been optimized.
 cf. <CABPp-BFd7Bk68Omdao5LS0sP5bK1WQ7V6dodB5x8EsncNARxNA@mail.gmail.com>
 source: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>


* jc/archive-prefix-with-add-virtual-file (2024-06-26) 1 commit
  (merged to 'next' on 2024-06-26 at da3ae88d56)
 + archive: document that --add-virtual-file takes full path

 "git archive --add-virtual-file=<path>:<contents>" never paid
 attention to the --prefix=<prefix> option but the documentation
 said it would. The documentation has been corrected.
 source: <xmqq5xubfjuu.fsf_-_@gitster.g>


* ps/leakfixes-more (2024-06-11) 30 commits
  (merged to 'next' on 2024-06-27 at 9550a05068)
 + builtin/blame: fix leaking ignore revs files
 + builtin/blame: fix leaking prefixed paths
 + blame: fix leaking data for blame scoreboards
 + line-range: plug leaking find functions
 + merge: fix leaking merge bases
 + builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
 + sequencer: fix memory leaks in `make_script_with_merges()`
 + builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
 + apply: fix leaking string in `match_fragment()`
 + sequencer: fix leaking string buffer in `commit_staged_changes()`
 + commit: fix leaking parents when calling `commit_tree_extended()`
 + config: fix leaking "core.notesref" variable
 + rerere: fix various trivial leaks
 + builtin/stash: fix leak in `show_stash()`
 + revision: free diff options
 + builtin/log: fix leaking commit list in git-cherry(1)
 + merge-recursive: fix memory leak when finalizing merge
 + builtin/merge-recursive: fix leaking object ID bases
 + builtin/difftool: plug memory leaks in `run_dir_diff()`
 + object-name: free leaking object contexts
 + builtin/rev-list: fix leaking bitmap index when calculating disk usage
 + notes: fix memory leak when pruning notes
 + revision: fix leaking display notes
 + merge-recursive: fix leaking rename conflict info
 + biultin/rev-parse: fix memory leaks in `--parseopt` mode
 + bundle: plug leaks in `create_bundle()`
 + notes-utils: free note trees when releasing copied notes
 + parse-options: fix leaks for users of OPT_FILENAME
 + revision: fix memory leak when reversing revisions
 + Merge branch 'ps/leakfixes' into ps/leakfixes-more

 More memory leaks have been plugged.
 cf. <CAOLa=ZRBrR5X1bQFAEqM3Ovx5G=J9aqdyD2XKrGT9s6j1jEnnQ@mail.gmail.com>
 source: <cover.1718095906.git.ps@pks.im>


* rj/pager-die-upon-exec-failure (2024-06-25) 1 commit
  (merged to 'next' on 2024-06-26 at bfb6361ca8)
 + pager: die when paging to non-existing command

 When GIT_PAGER failed to spawn, depending on the code path taken,
 we failed immediately (correct) or just spew the payload to the
 standard output (incorrect).  The code now always fail immediately
 when GIT_PAGER fails.
 source: <392deded-9eb2-42fa-b6f9-54c22d3ffd33@gmail.com>


* ss/doc-eol-attr-fix (2024-06-24) 1 commit
  (merged to 'next' on 2024-06-26 at 6b96672a5f)
 + doc: fix case error of eol attribute in example

 Doc update.
 source: <pull.1736.git.git.1719178817386.gitgitgadget@gmail.com>


* tb/path-filter-fix (2024-06-25) 16 commits
  (merged to 'next' on 2024-06-27 at a82d734201)
 + bloom: introduce `deinit_bloom_filters()`
 + commit-graph: reuse existing Bloom filters where possible
 + object.h: fix mis-aligned flag bits table
 + commit-graph: new Bloom filter version that fixes murmur3
 + commit-graph: unconditionally load Bloom filters
 + bloom: prepare to discard incompatible Bloom filters
 + bloom: annotate filters with hash version
 + repo-settings: introduce commitgraph.changedPathsVersion
 + t4216: test changed path filters with high bit paths
 + t/helper/test-read-graph: implement `bloom-filters` mode
 + bloom.h: make `load_bloom_filter_from_graph()` public
 + t/helper/test-read-graph.c: extract `dump_graph_info()`
 + gitformat-commit-graph: describe version 2 of BDAT
 + commit-graph: ensure Bloom filters are read with consistent settings
 + revision.c: consult Bloom filters for root commits
 + t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.
 source: <cover.1719333276.git.me@ttaylorr.com>


* xx/bundie-uri-fixes (2024-06-20) 3 commits
  (merged to 'next' on 2024-06-27 at 2045d9dbc2)
 + unbundle: extend object verification for fetches
 + fetch-pack: expose fsckObjects configuration logic
 + bundle-uri: verify oid before writing refs

 When bundleURI interface fetches multiple bundles, Git failed to
 take full advantage of all bundles and ended up slurping duplicated
 objects.
 source: <pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* jc/checkout-no-op-switch-errors (2024-07-02) 1 commit
 - checkout: special case error messages during noop switching

 "git checkout --ours" (no other arguments) complained that the
 option is incompatible with branch switching, which is technically
 correct, but found confusing by some users.  It now says that the
 user needs to give pathspec to specify what paths to checkout.

 Needs review.
 source: <xmqqikxnqzz4.fsf@gitster.g>


* jc/disable-push-nego-for-deletion (2024-07-02) 1 commit
  (merged to 'next' on 2024-07-08 at 18411fb8ac)
 + push: avoid showing false negotiation errors

 "git push" that pushes only deletion gave an unnecessary and
 harmless error message when push negotiation is configured, which
 has been corrected.

 Will merge to 'master'.
 source: <xmqqo77fr2h0.fsf@gitster.g>


* bc/gitfaq-more (2024-07-03) 4 commits
 - doc: mention that proxies must be completely transparent
 - gitfaq: add entry about syncing working trees
 - gitfaq: give advice on using eol attribute in gitattributes
 - gitfaq: add documentation on proxies

 A handful of entries are added to the GitFAQ document.

 Expecting a (hopefully small and final) reroll.
 cf. <ZocPrtrOVTqSeUTY@tapette.crustytoothpaste.net>
 source: <20240704003818.750223-1-sandals@crustytoothpaste.net>


* cp/unit-test-reftable-merged (2024-07-03) 5 commits
 - t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
 - t-reftable-merged: use reftable_ref_record_equal to compare ref records
 - t-reftable-merged: add tests for reftable_merged_table_max_update_index
 - t: harmonize t-reftable-merged.c with coding guidelines
 - t: move reftable/merged_test.c to the unit testing framework

 Another reftable test has been ported to use the unit test framework.

 Expecting a (hopefully small and final) reroll.
 cf. <CAOLa=ZSTb-kKiGHkGJwSgx3acxcfFe_+KGW=p7O7B7=CgeX7rw@mail.gmail.com>
 source: <20240703171131.3929-1-chandrapratap3519@gmail.com>


* ds/advice-sparse-index-expansion (2024-07-08) 1 commit
 - advice: warn when sparse index expands

 A new warning message is issued when a command has to expand a
 sparse index to handle working tree cruft that are outside of the
 sparse checkout.

 Will merge to 'next'?
 source: <pull.1756.v2.git.1720448038745.gitgitgadget@gmail.com>


* am/gitweb-feed-use-committer-date (2024-07-07) 1 commit
  (merged to 'next' on 2024-07-08 at 65215ab842)
 + gitweb: rss/atom change published/updated date to committer date

 GitWeb update to use committer date consistently in rss/atom feeds.

 Will merge to 'master'.
 source: <20240707184813.33166-1-080ariel@gmail.com>


* rs/clang-format-updates (2024-07-06) 1 commit
  (merged to 'next' on 2024-07-08 at d2b5b41844)
 + clang-format: include kh_foreach* macros in ForEachMacros

 Custom control structures we invented more recently have been
 taught to the clang-format file.

 Will merge to 'master'.
 source: <4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de>


* rs/t-strvec-use-test-msg (2024-07-06) 1 commit
  (merged to 'next' on 2024-07-08 at c28c2553de)
 + t-strvec: use test_msg()

 Unit test clean-up.

 Will merge to 'master'.
 source: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>


* tb/dev-build-pedantic-fix (2024-07-06) 1 commit
  (merged to 'next' on 2024-07-08 at 7f34cc6c5b)
 + config.mak.dev: fix typo when enabling -Wpedantic

 Developer build procedure fix.

 Will merge to 'master'.
 source: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>


* gt/unit-test-hashmap (2024-07-08) 1 commit
 - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c

 An existing test of hashmap API has been rewritten with the
 unit-test framework.

 Needs review.
 source: <20240708161641.10335-2-shyamthakkar001@gmail.com>


* ri/doc-show-branch-fix (2024-07-08) 1 commit
  (merged to 'next' on 2024-07-08 at efcb154dfe)
 + doc: fix the max number of branches shown by "show-branch"

 Docfix.

 Will merge to 'master'.
 source: <pull.1757.v5.git.1720444080034.gitgitgadget@gmail.com>

--------------------------------------------------
[Stalled]

* cp/unit-test-reftable-tree (2024-06-13) 5 commits
 - t-reftable-tree: improve the test for infix_walk()
 - t-reftable-tree: add test for non-existent key
 - t-reftable-tree: split test_tree() into two sub-test functions
 - t: move reftable/tree_test.c to the unit testing framework
 - reftable: remove unnecessary curly braces in reftable/tree.c

 A test in reftable library has been rewritten using the unit test
 framework.

 Needs review.
 source: <20240612130217.8877-1-chandrapratap3519@gmail.com>


* sj/ref-fsck (2024-07-03) 9 commits
 - fsck: add ref content check for files backend
 - fsck: add ref name check for files backend
 - files-backend: add unified interface for refs scanning
 - builtin/fsck: add `git-refs verify` child process
 - builtin/refs: add verify subcommand
 - refs: set up ref consistency check infrastructure
 - fsck: add refs-related options and error report function
 - fsck: add a unified interface for reporting fsck messages
 - fsck: rename "skiplist" to "oid_skiplist"

 "git fsck" infrastructure has been taught to also check the sanity
 of the ref database, in addition to the object database.

 Needs review.
 cf. <ysrjjyksfwto35ug7o6xbgbu53vvjso6nov3u2q6vvdprolqwh@vjhcc4x45j7t>
 cf. <adijctr2gmmyydpnnrmnu5p5n7mambfrd2ylqm6jtmvv2jdlxo@fbmhti7b4tks>
 source: <ZoVX6sn2C9VIeZ38@ArchLinux>


* cp/unit-test-reftable-pq (2024-06-14) 7 commits
 - t-reftable-pq: add tests for merged_iter_pqueue_top()
 - t-reftable-pq: add test for index based comparison
 - t-reftable-pq: make merged_iter_pqueue_check() callable by reference
 - t-reftable-pq: make merged_iter_pqueue_check() static
 - t: move reftable/pq_test.c to the unit testing framework
 - reftable: change the type of array indices to 'size_t' in reftable/pq.c
 - reftable: remove unncessary curly braces in reftable/pq.c

 The tests for "pq" part of reftable library got rewritten to use
 the unit test framework.

 Needs review.
 source: <20240614095136.12052-1-chandrapratap3519@gmail.com>


* tb/incremental-midx-part-1 (2024-06-07) 19 commits
 - midx: implement support for writing incremental MIDX chains
 - t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 - t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - midx: implement verification support for incremental MIDXs
 - midx: support reading incremental MIDX chains
 - midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 - midx: teach `midx_preferred_pack()` about incremental MIDXs
 - midx: teach `midx_contains_pack()` about incremental MIDXs
 - midx: remove unused `midx_locate_pack()`
 - midx: teach `fill_midx_entry()` about incremental MIDXs
 - midx: teach `nth_midxed_offset()` about incremental MIDXs
 - midx: teach `bsearch_midx()` about incremental MIDXs
 - midx: introduce `bsearch_one_midx()`
 - midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 - midx: teach `prepare_midx_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 - midx: add new fields for incremental MIDX chains
 - Documentation: describe incremental MIDX format

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1717715060.git.me@ttaylorr.com>


* vd/mktree (2024-06-20) 17 commits
 - mktree: remove entries when mode is 0
 - mktree: allow deeper paths in input
 - mktree: optionally add to an existing tree
 - mktree: add directory-file conflict hashmap
 - mktree: use iterator struct to add tree entries to index
 - mktree: create tree using an in-core index
 - mktree: overwrite duplicate entries
 - mktree: validate paths more carefully
 - mktree: add a --literally option
 - mktree.c: do not fail on mismatched submodule type
 - mktree: use read_index_info to read stdin lines
 - index-info.c: parse object type in provided in read_index_info
 - index-info.c: return unrecognized lines to caller
 - update-index: generalize 'read_index_info'
 - mktree: use non-static tree_entry array
 - mktree: rename treeent to tree_entry
 - mktree: use OPT_BOOL

 "git mktree" has been rewritten, taking advantage of the cache-tree
 API.

 Will merge to 'next'?
 source: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>


* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>

--------------------------------------------------
[Cooking]

* as/pathspec-h-typofix (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-02 at ae7cee4189)
 + pathspec: fix typo "glossary-context.txt" -> "glossary-content.txt"

 Typofix.

 Will merge to 'master'.
 source: <20240629193137.54037-1-abhijeet.nkt@gmail.com>


* gt/unit-test-oidmap (2024-07-03) 1 commit
  (merged to 'next' on 2024-07-08 at 4e7394fc67)
 + t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c

 An existing test of oidmap API has been rewritten with the
 unit-test framework.

 Will merge to 'master'.
 source: <20240703062958.23262-2-shyamthakkar001@gmail.com>


* jk/test-body-in-here-doc (2024-07-01) 2 commits
 . t: convert some here-doc test bodies
 . test-lib: allow test snippets as here-docs

 The test framework learns to take the test body not as a single
 string but as a here-document.

 May need a matching change to shell script linter.
 cf. <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 cf. <20240706060143.GD698153@coredump.intra.peff.net>
 source: <20240701220815.GA20293@coredump.intra.peff.net>


* rj/t0612-no-longer-leaks (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-08 at a63b027a20)
 + t0612: mark as leak-free

 A test that no longer leaks has been marked as such.

 Will merge to 'master'.
 source: <86427b9e-9574-4e61-890a-691779a8da82@gmail.com>


* rj/t0613-no-longer-leaks (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-08 at b6149c3032)
 + t0613: mark as leak-free

 A test that no longer leaks has been marked as such.

 Will merge to 'master'.
 source: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>


* rj/test-sanitize-leak-log-fix (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-08 at c7ee7d03e1)
 + test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG

 Tests that use GIT_TEST_SANITIZE_LEAK_LOG feature got their exit
 status inverted, which has been corrected.

 Will merge to 'master'.
 source: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>


* rs/simplify-submodule-helper-super-prefix-invocation (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-02 at 06e1677920)
 + submodule--helper: use strvec_pushf() for --super-prefix

 Code clean-up.

 Will merge to 'master'.
 source: <fb79ebc4-5ecf-4257-ac2e-39f98db5649c@web.de>


* rs/unit-tests-test-run (2024-07-01) 6 commits
 - t-strbuf: use TEST_RUN
 - t-strvec: use TEST_RUN
 - t-reftable-basics: use TEST_RUN
 - t-ctype: use TEST_RUN
 - unit-tests: add TEST_RUN
 - t0080: move expected output to a file

 Unit-test framework clean-up.

 Will merge to 'next'?
 source: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>


* cp/unit-test-reftable-record (2024-07-02) 11 commits
  (merged to 'next' on 2024-07-08 at b534dac338)
 + t-reftable-record: add tests for reftable_log_record_compare_key()
 + t-reftable-record: add tests for reftable_ref_record_compare_name()
 + t-reftable-record: add index tests for reftable_record_is_deletion()
 + t-reftable-record: add obj tests for reftable_record_is_deletion()
 + t-reftable-record: add log tests for reftable_record_is_deletion()
 + t-reftable-record: add ref tests for reftable_record_is_deletion()
 + t-reftable-record: add comparison tests for obj records
 + t-reftable-record: add comparison tests for index records
 + t-reftable-record: add comparison tests for ref records
 + t-reftable-record: add reftable_record_cmp() tests for log records
 + t: move reftable/record_test.c to the unit testing framework

 A test in reftable library has been rewritten using the unit test
 framework.

 Will merge to 'master'.
 cf. <CAOLa=ZT_x1Kf7EopU+RbBFzX3EPU5NWx6f8L9Uw=sM0MbCXDAQ@mail.gmail.com>
 source: <20240702074906.5587-1-chandrapratap3519@gmail.com>


* as/describe-broken-refresh-index-fix (2024-06-26) 1 commit
  (merged to 'next' on 2024-07-08 at 2307a4a4ae)
 + describe: refresh the index when 'broken' flag is used

 "git describe --dirty --broken" forgot to refresh the index before
 seeing if there is any chang, ("git describe --dirty" correctly did
 so), which has been corrected.

 Will merge to 'master'.
 source: <20240626190801.68472-1-abhijeet.nkt@gmail.com>


* cb/send-email-sanitize-trailer-addresses (2024-07-01) 1 commit
 - git-send-email: use sanitized address when reading mbox body

 Address-looking strings found on the trailer are now placed on the
 Cc: list after running through sanitize_address.

 Will merge to 'next'?
 source: <20240701090115.56957-1-csokas.bence@prolan.hu>


* jk/tests-without-dns (2024-06-26) 3 commits
  (merged to 'next' on 2024-07-08 at 21af592457)
 + t/lib-bundle-uri: use local fake bundle URLs
 + t5551: do not confirm that bogus url cannot be used
 + t5553: use local url for invalid fetch

 Test suite has been taught not to unnecessarily rely on DNS failing
 a bogus external name.

 Will merge to 'master'.
 source: <20240626205355.GA1009060@coredump.intra.peff.net>


* bc/http-proactive-auth (2024-07-03) 1 commit
 - http: allow authenticating proactively

 The http transport can now be told to send request with
 authentication material without first getting a 401 response.

 Getting there.
 cf. <xmqqo77d7lkr.fsf@gitster.g>
 source: <20240704001748.746429-2-sandals@crustytoothpaste.net>


* jc/patch-id (2024-06-21) 5 commits
 - patch-id: tighten code to detect the patch header
 - patch-id: rewrite code that detects the beginning of a patch
 - patch-id: make get_one_patchid() more extensible
 - patch-id: call flush_current_id() only when needed
 - t4204: patch-id supports various input format

 The patch parser in "git patch-id" has been tightened to avoid
 getting confused by lines that look like a patch header in the log
 message.

 Needs review.
 source: <20240621231826.3280338-1-gitster@pobox.com>


* en/ort-inner-merge-error-fix (2024-07-06) 8 commits
 - merge-ort: fix missing early return
  (merged to 'next' on 2024-06-28 at a85fe270e6)
 + merge-ort: convert more error() cases to path_msg()
 + merge-ort: upon merge abort, only show messages causing the abort
 + merge-ort: loosen commented requirements
 + merge-ort: clearer propagation of failure-to-function from merge_submodule
 + merge-ort: fix type of local 'clean' var in handle_content_merge ()
 + merge-ort: maintain expected invariant for priv member
 + merge-ort: extract handling of priv member into reusable function

 The "ort" merge backend saw one bugfix for a crash that happens
 when inner merge gets killed, and assorted code clean-ups.

 Will merge to 'next' and then to 'master'.
 source: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
