Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3u2SdF6"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1EDB3
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 00:31:06 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 414E71C44B;
	Fri, 17 Nov 2023 03:31:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	8rmEBx0VADzoQdpOHYFcCc4hv85+/q3JTf+ksVWNV4=; b=X3u2SdF6ObId2SRQ/
	jhoBPFtNRhkY0CIHlIo+0EvkNBXC4QU3tE7GM70CGprEuj2fZTH6/SVVyR9JwCF3
	dCttU2H9DDGPG2pGowKpAVr/LqAXgp+2bAdm1OzYRy2uIUm/9PJl1g1FGNE+WYKw
	1MpBZXVQMkN1r6WS4a5zFGeNrI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 38FB21C44A;
	Fri, 17 Nov 2023 03:31:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC1691C442;
	Fri, 17 Nov 2023 03:30:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2023, #07; Fri, 17)
X-master-at: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
X-next-at: f09e533e43c38d90657504164412796b01e6a322
Date: Fri, 17 Nov 2023 17:30:58 +0900
Message-ID: <xmqqpm08pyrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2D3CB16-8523-11EE-A77D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.43-rc2 has been tagged.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

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
[New Topics]

* jw/builtin-objectmode-attr (2023-11-16) 2 commits
 - SQUASH???
 - attr: add builtin objectmode values support

 The builtin_objectmode attribute is populated for each path
 without adding anything in .gitattributes files, which would be
 useful in magic pathspec, e.g., ":(attr:builtin_objectmode=100755)"
 to limit to executables.
 source: <20231116054437.2343549-1-jojwang@google.com>


* ps/ref-deletion-updates (2023-11-17) 4 commits
 - refs: remove `delete_refs` callback from backends
 - refs: deduplicate code to delete references
 - refs/files: use transactions to delete references
 - t5510: ensure that the packed-refs file needs locking

 Simplify API implementation to delete references by eliminating
 duplication.

 Will merge to 'next'.
 source: <cover.1699951815.git.ps@pks.im>


* tz/send-email-helpfix (2023-11-16) 1 commit
  (merged to 'next' on 2023-11-17 at 8422271795)
 + send-email: remove stray characters from usage

 Typoes in "git send-email -h" have been corrected.

 Will merge to 'master'.
 source: <20231115173952.339303-3-tmz@pobox.com>


* tz/send-email-negatable-options (2023-11-17) 2 commits
  (merged to 'next' on 2023-11-17 at f09e533e43)
 + send-email: avoid duplicate specification warnings
 + perl: bump the required Perl version to 5.8.1 from 5.8.0

 Newer versions of Getopt::Long started giving warnings against our
 (ab)use of it in "git send-email".  Bump the minimum version
 requirement for Perl to 5.8.1 (from September 2002) to allow
 simplifying our implementation.

 Will cook in 'next'.
 source: <20231116193014.470420-1-tmz@pobox.com>

--------------------------------------------------
[Stalled]

* pw/rebase-sigint (2023-09-07) 1 commit
 - rebase -i: ignore signals when forking subprocesses

 If the commit log editor or other external programs (spawned via
 "exec" insn in the todo list) receive internactive signal during
 "git rebase -i", it caused not just the spawned program but the
 "Git" process that spawned them, which is often not what the end
 user intended.  "git" learned to ignore SIGINT and SIGQUIT while
 waiting for these subprocesses.

 Expecting a reroll.
 cf. <12c956ea-330d-4441-937f-7885ab519e26@gmail.com>
 source: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>


* tk/cherry-pick-sequence-requires-clean-worktree (2023-06-01) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <999f12b2-38d6-f446-e763-4985116ad37d@gmail.com>
 source: <pull.1535.v2.git.1685264889088.gitgitgadget@gmail.com>


* jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
 - diff-lib: fix check_removed() when fsmonitor is active
 - Merge branch 'jc/fake-lstat' into jc/diff-cached-fsmonitor-fix
 - Merge branch 'js/diff-cached-fsmonitor-fix' into jc/diff-cached-fsmonitor-fix
 (this branch uses jc/fake-lstat.)

 The optimization based on fsmonitor in the "diff --cached"
 codepath is resurrected with the "fake-lstat" introduced earlier.

 It is unknown if the optimization is worth resurrecting, but in case...
 source: <xmqqr0n0h0tw.fsf@gitster.g>

--------------------------------------------------
[Cooking]

* js/ci-discard-prove-state (2023-11-14) 1 commit
  (merged to 'next' on 2023-11-14 at fade3ba143)
 + ci: avoid running the test suite _twice_
 (this branch uses ps/ci-gitlab.)

 The way CI testing used "prove" could lead to running the test
 suite twice needlessly, which has been corrected.

 Will cook in 'next'.
 source: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>


* jk/chunk-bounds-more (2023-11-09) 9 commits
  (merged to 'next' on 2023-11-13 at 3df4b18bea)
 + commit-graph: mark chunk error messages for translation
 + commit-graph: drop verify_commit_graph_lite()
 + commit-graph: check order while reading fanout chunk
 + commit-graph: use fanout value for graph size
 + commit-graph: abort as soon as we see a bogus chunk
 + commit-graph: clarify missing-chunk error messages
 + commit-graph: drop redundant call to "lite" verification
 + midx: check consistency of fanout table
 + commit-graph: handle overflow in chunk_size checks
 (this branch is used by tb/pair-chunk-expect.)

 Code clean-up for jk/chunk-bounds topic.

 Will cook in 'next'.
 source: <20231109070310.GA2697602@coredump.intra.peff.net>


* ps/httpd-tests-on-nixos (2023-11-11) 3 commits
  (merged to 'next' on 2023-11-13 at 81bd6f5334)
 + t9164: fix inability to find basename(1) in Subversion hooks
 + t/lib-httpd: stop using legacy crypt(3) for authentication
 + t/lib-httpd: dynamically detect httpd and modules path

 Portability tweak.

 Will cook in 'next'.
 source: <cover.1699596457.git.ps@pks.im>


* ss/format-patch-use-encode-headers-for-cover-letter (2023-11-10) 1 commit
  (merged to 'next' on 2023-11-14 at 1a4bd59e15)
 + format-patch: fix ignored encode_email_headers for cover letter

 "git format-patch --encode-email-headers" ignored the option when
 preparing the cover letter, which has been corrected.

 Will cook in 'next'.
 source: <20231109111950.387219-1-contact@emersion.fr>


* ps/ban-a-or-o-operator-with-test (2023-11-11) 4 commits
  (merged to 'next' on 2023-11-14 at d84471baab)
 + Makefile: stop using `test -o` when unlinking duplicate executables
 + contrib/subtree: convert subtree type check to use case statement
 + contrib/subtree: stop using `-o` to test for number of args
 + global: convert trivial usages of `test <expr> -a/-o <expr>`

 Test and shell scripts clean-up.

 Will cook in 'next'.
 source: <cover.1699609940.git.ps@pks.im>


* vd/glossary-dereference-peel (2023-11-14) 1 commit
  (merged to 'next' on 2023-11-17 at bac3ab0c0b)
 + glossary: add definitions for dereference & peel

 "To dereference" and "to peel" were sometimes used in in-code
 comments and documentation but without description in the glossary.

 Will merge to 'master'.
 source: <pull.1610.v2.git.1699917471769.gitgitgadget@gmail.com>


* ak/rebase-autosquash (2023-11-16) 3 commits
  (merged to 'next' on 2023-11-17 at 3ed6e79445)
 + rebase: rewrite --(no-)autosquash documentation
 + rebase: support --autosquash without -i
 + rebase: fully ignore rebase.autoSquash without -i

 "git rebase --autosquash" is now enabled for non-interactive rebase,
 but it is still incompatible with the apply backend.

 Will cook in 'next'.
 source: <20231114214339.10925-1-andy.koppe@gmail.com>


* vd/for-each-ref-unsorted-optimization (2023-11-16) 10 commits
  (merged to 'next' on 2023-11-17 at ff99420bf6)
 + t/perf: add perf tests for for-each-ref
 + ref-filter.c: use peeled tag for '*' format fields
 + for-each-ref: clean up documentation of --format
 + ref-filter.c: filter & format refs in the same callback
 + ref-filter.c: refactor to create common helper functions
 + ref-filter.c: rename 'ref_filter_handler()' to 'filter_one()'
 + ref-filter.h: add functions for filter/format & format-only
 + ref-filter.h: move contains caches into filter
 + ref-filter.h: add max_count and omit_empty to ref_format
 + ref-filter.c: really don't sort when using --no-sort

 "git for-each-ref --no-sort" still sorted the refs alphabetically
 which paid non-trivial cost.  It has been redefined to show output
 in an unspecified order, to allow certain optimizations to take
 advantage of.

 Will cook in 'next'.
 source: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>


* jw/git-add-attr-pathspec (2023-11-04) 1 commit
  (merged to 'next' on 2023-11-13 at b61be94e4d)
 + attr: enable attr pathspec magic for git-add and git-stash

 "git add" and "git stash" learned to support the ":(attr:...)"
 magic pathspec.

 Will cook in 'next'.
 source: <20231103163449.1578841-1-jojwang@google.com>


* ps/ci-gitlab (2023-11-09) 8 commits
  (merged to 'next' on 2023-11-10 at ea7ed67945)
 + ci: add support for GitLab CI
 + ci: install test dependencies for linux-musl
 + ci: squelch warnings when testing with unusable Git repo
 + ci: unify setup of some environment variables
 + ci: split out logic to set up failed test artifacts
 + ci: group installation of Docker dependencies
 + ci: make grouping setup more generic
 + ci: reorder definitions for grouping functions
 (this branch is used by js/ci-discard-prove-state.)

 Add support for GitLab CI.

 Will cook in 'next'.
 source: <cover.1699514143.git.ps@pks.im>


* ps/ref-tests-update (2023-11-03) 10 commits
  (merged to 'next' on 2023-11-13 at dc26e55d6f)
 + t: mark several tests that assume the files backend with REFFILES
 + t7900: assert the absence of refs via git-for-each-ref(1)
 + t7300: assert exact states of repo
 + t4207: delete replace references via git-update-ref(1)
 + t1450: convert tests to remove worktrees via git-worktree(1)
 + t: convert tests to not access reflog via the filesystem
 + t: convert tests to not access symrefs via the filesystem
 + t: convert tests to not write references via the filesystem
 + t: allow skipping expected object ID in `ref-store update-ref`
 + Merge branch 'ps/show-ref' into ps/ref-tests-update

 Update ref-related tests.

 Will cook in 'next'.
 source: <cover.1698914571.git.ps@pks.im>


* jx/fetch-atomic-error-message-fix (2023-10-19) 2 commits
 - fetch: no redundant error message for atomic fetch
 - t5574: test porcelain output of atomic fetch

 "git fetch --atomic" issued an unnecessary empty error message,
 which has been corrected.

 Expecting an update.
 cf. <ZTjQIrCgSANAT8wR@tanuki>
 source: <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>


* js/bugreport-in-the-same-minute (2023-10-16) 1 commit
 - bugreport: include +i in outfile suffix as needed

 Instead of auto-generating a filename that is already in use for
 output and fail the command, `git bugreport` learned to fuzz the
 filename to avoid collisions with existing files.

 Expecting a reroll.
 cf. <ZTtZ5CbIGETy1ucV.jacob@initialcommit.io>
 source: <20231016214045.146862-2-jacob@initialcommit.io>


* kh/t7900-cleanup (2023-10-17) 9 commits
 - t7900: fix register dependency
 - t7900: factor out packfile dependency
 - t7900: fix `print-args` dependency
 - t7900: fix `pfx` dependency
 - t7900: factor out common schedule setup
 - t7900: factor out inheritance test dependency
 - t7900: create commit so that branch is born
 - t7900: setup and tear down clones
 - t7900: remove register dependency

 Test clean-up.

 Perhaps discard?
 cf. <655ca147-c214-41be-919d-023c1b27b311@app.fastmail.com>
 source: <cover.1697319294.git.code@khaugsbakk.name>


* tb/merge-tree-write-pack (2023-10-23) 5 commits
 - builtin/merge-tree.c: implement support for `--write-pack`
 - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
 - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
 - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
 - bulk-checkin: extract abstract `bulk_checkin_source`

 "git merge-tree" learned "--write-pack" to record its result
 without creating loose objects.

 Broken when an object created during a merge is needed to continue merge
 cf. <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 source: <cover.1698101088.git.me@ttaylorr.com>


* tb/pair-chunk-expect (2023-11-10) 8 commits
 - midx: read `OOFF` chunk with `pair_chunk_expect()`
 - midx: read `OIDL` chunk with `pair_chunk_expect()`
 - commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 - commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 - commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
 - chunk-format: introduce `pair_chunk_expect()` helper
 - Merge branch 'jk/chunk-bounds-more' into HEAD
 (this branch uses jk/chunk-bounds-more.)

 Further code clean-up.

 Needs review.
 source: <cover.1699569246.git.me@ttaylorr.com>


* tb/path-filter-fix (2023-10-18) 17 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: drop unnecessary `graph_read_bloom_data_context`
 - commit-graph.c: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - commit-graph: new filter ver. that fixes murmur3
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Needs (hopefully final and quick) review.
 source: <cover.1697653929.git.me@ttaylorr.com>


* cc/git-replay (2023-11-16) 14 commits
 - replay: stop assuming replayed branches do not diverge
 - replay: add --contained to rebase contained branches
 - replay: add --advance or 'cherry-pick' mode
 - replay: use standard revision ranges
 - replay: make it a minimal server side command
 - replay: remove HEAD related sanity check
 - replay: remove progress and info output
 - replay: add an important FIXME comment about gpg signing
 - replay: change rev walking options
 - replay: introduce pick_regular_commit()
 - replay: die() instead of failing assert()
 - replay: start using parse_options API
 - replay: introduce new builtin
 - t6429: remove switching aspects of fast-rebase

 Introduce "git replay", a tool meant on the server side without
 working tree to recreate a history.
 source: <20231115143327.2441397-1-christian.couder@gmail.com>


* ak/color-decorate-symbols (2023-10-23) 7 commits
 - log: add color.decorate.pseudoref config variable
 - refs: exempt pseudorefs from pattern prefixing
 - refs: add pseudorefs array and iteration functions
 - log: add color.decorate.ref config variable
 - log: add color.decorate.symbol config variable
 - log: use designated inits for decoration_colors
 - config: restructure color.decorate documentation

 A new config for coloring.

 Needs review.
 source: <20231023221143.72489-1-andy.koppe@gmail.com>


* js/update-urls-in-doc-and-comment (2023-09-26) 4 commits
 - doc: refer to internet archive
 - doc: update links for andre-simon.de
 - doc: update links to current pages
 - doc: switch links to https

 Stale URLs have been updated to their current counterparts (or
 archive.org) and HTTP links are replaced with working HTTPS links.

 Needs review.
 source: <pull.1589.v2.git.1695553041.gitgitgadget@gmail.com>


* la/trailer-cleanups (2023-10-20) 3 commits
 - trailer: use offsets for trailer_start/trailer_end
 - trailer: find the end of the log message
 - commit: ignore_non_trailer computes number of bytes to ignore

 Code clean-up.

 Comments?
 source: <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com>


* eb/hash-transition (2023-10-02) 30 commits
 - t1016-compatObjectFormat: add tests to verify the conversion between objects
 - t1006: test oid compatibility with cat-file
 - t1006: rename sha1 to oid
 - test-lib: compute the compatibility hash so tests may use it
 - builtin/ls-tree: let the oid determine the output algorithm
 - object-file: handle compat objects in check_object_signature
 - tree-walk: init_tree_desc take an oid to get the hash algorithm
 - builtin/cat-file: let the oid determine the output algorithm
 - rev-parse: add an --output-object-format parameter
 - repository: implement extensions.compatObjectFormat
 - object-file: update object_info_extended to reencode objects
 - object-file-convert: convert commits that embed signed tags
 - object-file-convert: convert commit objects when writing
 - object-file-convert: don't leak when converting tag objects
 - object-file-convert: convert tag objects when writing
 - object-file-convert: add a function to convert trees between algorithms
 - object: factor out parse_mode out of fast-import and tree-walk into in object.h
 - cache: add a function to read an OID of a specific algorithm
 - tag: sign both hashes
 - commit: export add_header_signature to support handling signatures on tags
 - commit: convert mergetag before computing the signature of a commit
 - commit: write commits for both hashes
 - object-file: add a compat_oid_in parameter to write_object_file_flags
 - object-file: update the loose object map when writing loose objects
 - loose: compatibilty short name support
 - loose: add a mapping between SHA-1 and SHA-256 for loose objects
 - repository: add a compatibility hash algorithm
 - object-names: support input of oids in any supported hash
 - oid-array: teach oid-array to handle multiple kinds of oids
 - object-file-convert: stubs for converting from one object format to another

 Teach a repository to work with both SHA-1 and SHA-256 hash algorithms.

 Needs review.
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jx/remote-archive-over-smart-http (2023-10-04) 4 commits
 - archive: support remote archive from stateless transport
 - transport-helper: call do_take_over() in connect_helper
 - transport-helper: call do_take_over() in process_connect
 - transport-helper: no connection restriction in connect_helper

 "git archive --remote=<remote>" learned to talk over the smart
 http (aka stateless) transport.

 Needs review.
 source: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>


* jx/sideband-chomp-newline-fix (2023-10-04) 3 commits
 - pkt-line: do not chomp newlines for sideband messages
 - pkt-line: memorize sideband fragment in reader
 - test-pkt-line: add option parser for unpack-sideband

 Sideband demultiplexer fixes.

 Needs review.
 source: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com>


* js/config-parse (2023-09-21) 5 commits
 - config-parse: split library out of config.[c|h]
 - config.c: accept config_parse_options in git_config_from_stdin
 - config: report config parse errors using cb
 - config: split do_event() into start and flush operations
 - config: split out config_parse_options

 The parsing routines for the configuration files have been split
 into a separate file.

 Needs review.
 source: <cover.1695330852.git.steadmon@google.com>


* jc/fake-lstat (2023-09-15) 1 commit
 - cache: add fake_lstat()
 (this branch is used by jc/diff-cached-fsmonitor-fix.)

 A new helper to let us pretend that we called lstat() when we know
 our cache_entry is up-to-date via fsmonitor.

 Needs review.
 source: <xmqqcyykig1l.fsf@gitster.g>


* js/doc-unit-tests (2023-11-10) 3 commits
  (merged to 'next' on 2023-11-10 at 7d00ffd06b)
 + ci: run unit tests in CI
 + unit tests: add TAP unit test framework
 + unit tests: add a project plan document
 (this branch is used by js/doc-unit-tests-with-cmake.)

 Process to add some form of low-level unit tests has started.

 Will cook in 'next'.
 source: <cover.1699555664.git.steadmon@google.com>


* js/doc-unit-tests-with-cmake (2023-11-10) 7 commits
  (merged to 'next' on 2023-11-10 at b4503c9c8c)
 + cmake: handle also unit tests
 + cmake: use test names instead of full paths
 + cmake: fix typo in variable name
 + artifacts-tar: when including `.dll` files, don't forget the unit-tests
 + unit-tests: do show relative file paths
 + unit-tests: do not mistake `.pdb` files for being executable
 + cmake: also build unit tests
 (this branch uses js/doc-unit-tests.)

 Update the base topic to work with CMake builds.

 Will cook in 'next'.
 source: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>


* rj/status-bisect-while-rebase (2023-10-16) 1 commit
 - status: fix branch shown when not only bisecting

 "git status" is taught to show both the branch being bisected and
 being rebased when both are in effect at the same time.

 Needs review.
 source: <2e24ca9b-9c5f-f4df-b9f8-6574a714dfb2@gmail.com>

--------------------------------------------------
[Discarded]

* jc/strbuf-comment-line-char (2023-11-01) 4 commits
 . strbuf: move env-using functions to environment.c
 . strbuf: make add_lines() public
 . strbuf_add_commented_lines(): drop the comment_line_char parameter
 . strbuf_commented_addf(): drop the comment_line_char parameter

 Code simplification that goes directly against a past libification
 topic.  It is hard to judge because the "libification" is done
 piecewise without seemingly clear design principle.

 Will discard.
 source: <cover.1698791220.git.jonathantanmy@google.com>
