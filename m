Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305728FF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833747; cv=none; b=pVCY03gHtfXGDEyZoTxhprwMnO38BSUVnpJg5szoPVtvkUwK4iHlNLpU+tAz7HBchrK8nYOjCjut4yWtYHYOdTFTsA5arBH1zb5Mcm8EHrVduJGN+CYzvf/9FZJpvhzYXwM14eLn5+eMzoiS1SXCu78Xe1Wb17eDMNLMeNgyx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833747; c=relaxed/simple;
	bh=EBA0iE5JdgOeA8DeflN5LTKCwSaVLri3Lnx6shFgakk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iy0jMuRlcDzeQ6xjZEqJbpVwzhrLlMa9OIdgPUorO2KE5u5dzMN8baM1VjLCZeLbWB1OBmWzEeEOL2bUaiEhry1JxtL5ckzsP8lsZHfAD1dHs1CIfW2UgSEsYroZWEo24LrG47oou5Ua3PMv9SmjVBzTI/AgNbhVHholxrW+Ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AFSTB2qJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFSTB2qJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 304642B127;
	Fri, 16 Aug 2024 14:42:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=E
	BA0iE5JdgOeA8DeflN5LTKCwSaVLri3Lnx6shFgakk=; b=AFSTB2qJfcNHTxRFc
	eZCyCtdCJAAze0estW+NadnMVTxK5zdkZG+hurCg5HhjHIm0gC8ytVqWUQDQ6bI9
	DIjgGlIyEK2ts+dBivV2jDs4PolK/QU/MaXigd09qjKmKtWvVbxrFH5KhUwYU7/D
	VHWaHPhGAL3Gdm4/E+gfY43qSo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E932B126;
	Fri, 16 Aug 2024 14:42:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75FBA2B125;
	Fri, 16 Aug 2024 14:42:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2024, #06; Fri, 16)
X-master-at: 87a1768b93a67d0420255a43d9e07387b2e805ad
X-next-at: a157f53b32d1635eb6dc54bf001924b543cd6568
Date: Fri, 16 Aug 2024 11:42:22 -0700
Message-ID: <xmqqwmkgjomp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 46D5A4B6-5BFF-11EF-800D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

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

* ag/t7004-modernize (2024-08-08) 8 commits
  (merged to 'next' on 2024-08-09 at 7bce577df4)
 + t7004: make use of write_script
 + t7004: use single quotes instead of double quotes
 + t7004: begin the test body on the same line as test_expect_success
 + t7004: description on the same line as test_expect_success
 + t7004: do not prepare things outside test_expect_success
 + t7004: use indented here-doc
 + t7004: one command per line
 + t7004: remove space after redirect operators

 Coding style fixes to a test script.
 source: <20240808163302.17521-1-abdobngad@gmail.com>


* es/doc-platform-support-policy (2024-08-02) 1 commit
  (merged to 'next' on 2024-08-09 at 110c94ea82)
 + Documentation: add platform support policy

 A policy document that describes platform support levels and
 expectation on platform stakeholders has been introduced.
 source: <20240802221948.2367124-1-emilyshaffer@google.com>


* gt/unit-test-hashmap (2024-08-06) 1 commit
  (merged to 'next' on 2024-08-09 at e62febfb4e)
 + t: port helper/test-hashmap.c to unit-tests/t-hashmap.c

 An existing test of hashmap API has been rewritten with the
 unit-test framework.
 cf. <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>
 source: <20240803133517.73308-2-shyamthakkar001@gmail.com>


* jc/refs-symref-referent (2024-08-09) 3 commits
  (merged to 'next' on 2024-08-09 at 3183f3d05b)
 + ref-filter: populate symref from iterator
 + refs: add referent to each_ref_fn
 + refs: keep track of unresolved reference value in iterators

 The refs API has been taught to give symref target information to
 the users of ref iterators, allowing for-each-ref and friends to
 avoid an extra ref_resolve_* API call per a symbolic ref.
 source: <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>


* jc/safe-directory (2024-07-30) 4 commits
  (merged to 'next' on 2024-08-05 at 77aa0f1d08)
 + safe.directory: setting safe.directory="." allows the "current" directory
 + safe.directory: normalize the configured path
 + safe.directory: normalize the checked path
 + safe.directory: preliminary clean-up

 Follow-up on 2.45.1 regression fix.
 source: <20240730184352.2503276-1-gitster@pobox.com>


* jc/t3206-test-when-finished-fix (2024-08-06) 1 commit
  (merged to 'next' on 2024-08-08 at 46461db3a2)
 + t3206: test_when_finished before dirtying operations, not after

 Test clean-up.
 source: <xmqqwmkttwfm.fsf@gitster.g>


* ps/reftable-stack-compaction (2024-08-08) 9 commits
  (merged to 'next' on 2024-08-09 at d7875bf14b)
 + reftable/stack: handle locked tables during auto-compaction
 + reftable/stack: fix corruption on concurrent compaction
 + reftable/stack: use lock_file when adding table to "tables.list"
 + reftable/stack: do not die when fsyncing lock file files
 + reftable/stack: simplify tracking of table locks
 + reftable/stack: update stats on failed full compaction
 + reftable/stack: test compaction with already-locked tables
 + reftable/stack: extract function to setup stack with N tables
 + reftable/stack: refactor function to gather table sizes
 (this branch is used by ps/reftable-drop-generic.)

 The code paths to compact multiple reftable files have been updated
 to correctly deal with multiple compaction triggering at the same
 time.
 source: <cover.1723123606.git.ps@pks.im>


* ps/submodule-ref-format (2024-08-08) 8 commits
  (merged to 'next' on 2024-08-09 at 2b17964809)
 + object: fix leaking packfiles when closing object store
 + submodule: fix leaking seen submodule names
 + submodule: fix leaking fetch tasks
 + builtin/submodule: allow "add" to use different ref storage format
 + refs: fix ref storage format for submodule ref stores
 + builtin/clone: propagate ref storage format to submodules
 + builtin/submodule: allow cloning with different ref storage format
 + git-submodule.sh: break overly long command lines

 Support to specify ref backend for submodules has been enhanced.
 source: <cover.1723102259.git.ps@pks.im>


* rs/t-example-simplify (2024-07-30) 1 commit
  (merged to 'next' on 2024-08-08 at edeb01c38e)
 + t-example-decorate: remove test messages

 Unit test simplification.
 source: <5c838884-b606-465a-8f7e-ab760ddadef8@web.de>


* xx/diff-tree-remerge-diff-fix (2024-08-09) 1 commit
  (merged to 'next' on 2024-08-09 at cabe67c0d1)
 + diff-tree: fix crash when used with --remerge-diff
 (this branch is used by jc/range-diff-lazy-setup.)

 "git rev-list ... | git diff-tree -p --remerge-diff --stdin" should
 behave more or less like "git log -p --remerge-diff" but instead it
 crashed, forgetting to prepare a temporary object store needed.
 source: <pull.1771.v2.git.1723188292498.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* jc/how-to-maintain-updates (2024-08-14) 1 commit
  (merged to 'next' on 2024-08-15 at 20ebc08e74)
 + howto-maintain: mention preformatted docs

 Doc updates.

 Will merge to 'master'.
 source: <xmqqikw2wvup.fsf@gitster.g>


* ah/git-prompt-portability (2024-08-15) 8 commits
 - git-prompt: support custom 0-width PS1 markers
 - git-prompt: ta-da! document usage in other shells
 - git-prompt: don't use shell $'...'
 - git-prompt: add some missing quotes
 - git-prompt: replace [[...]] with standard code
 - git-prompt: don't use shell arrays
 - git-prompt: fix uninitialized variable
 - git-prompt: use here-doc instead of here-string

 The command line prompt support used to be littered with bash-isms,
 which has been corrected to work with more shells.

 Will merge to 'next'?
 source: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>


* jk/apply-patch-mode-check-fix (2024-08-15) 1 commit
  (merged to 'next' on 2024-08-15 at 8e077b7875)
 + t4129: fix racy index when calling chmod after git-add

 Test fix.

 Will merge to 'master'.
 source: <20240815153007.GA1477220@coredump.intra.peff.net>


* ps/reftable-drop-generic (2024-08-15) 16 commits
 - reftable/generic: drop interface
 - t/helper: refactor to not use `struct reftable_table`
 - t/helper: use `hash_to_hex_algop()` to print hashes
 - t/helper: inline printing of reftable records
 - t/helper: inline `reftable_table_print()`
 - t/helper: inline `reftable_stack_print_directory()`
 - t/helper: inline `reftable_reader_print_file()`
 - t/helper: inline `reftable_dump_main()`
 - reftable/dump: drop unused `compact_stack()`
 - reftable/generic: move generic iterator code into iterator interface
 - reftable/iter: drop double-checking logic
 - reftable/stack: open-code reading refs
 - reftable/merged: stop using generic tables in the merged table
 - reftable/merged: rename `reftable_new_merged_table()`
 - reftable/merged: expose functions to initialize iterators
 - Merge branch 'ps/reftable-stack-compaction' into ps/reftable-drop-generic

 The code in the reftable library has been cleaned up by discarding
 unused "generic" interface.

 Needs review.
 source: <cover.1723640107.git.ps@pks.im>


* ps/hash-and-ref-format-from-config (2024-08-16) 5 commits
 - setup: make ref storage format configurable via config
 - setup: make object format configurable via config
 - setup: merge configuration of repository formats
 - t0001: delete repositories when object format tests finish
 - t0001: exercise initialization with ref formats more thoroughly

 The default object hash and ref backend format used to be settable
 only with explicit command line option to "git init" and
 environment variables, but now they can be configured in the user's
 global and system wide configuration.

 Will merge to 'next'.
 source: <cover.1723798388.git.ps@pks.im>


* tb/pseudo-merge-bitmap-fixes (2024-08-15) 8 commits
 - pseudo-merge.c: ensure pseudo-merge groups are closed
 - pseudo-merge.c: do not generate empty pseudo-merge commits
 - t/t5333-pseudo-merge-bitmaps.sh: demonstrate empty pseudo-merge groups
 - pack-bitmap-write.c: select pseudo-merges even for small bitmaps
 - pack-bitmap: drop redundant args from `bitmap_writer_finish()`
 - pack-bitmap: drop redundant args from `bitmap_writer_build()`
 - pack-bitmap: drop redundant args from `bitmap_writer_build_type_index()`
 - pack-bitmap: initialize `bitmap_writer_init()` with packing_data
 (this branch is used by tb/incremental-midx-part-2.)

 We created a useless pseudo-merge reachability bitmap that is about
 0 commits, and attempted to include commits that are not in packs,
 which made no sense.  These bugs have been corrected.

 Will merge to 'next'.
 source: <cover.1723743050.git.me@ttaylorr.com>


* tb/incremental-midx-part-2 (2024-08-15) 15 commits
 - midx: implement writing incremental MIDX bitmaps
 - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 - pack-bitmap.c: keep track of each layer's type bitmaps
 - ewah: implement `struct ewah_or_iterator`
 - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 - pack-bitmap.c: compute disk-usage with incremental MIDXs
 - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 - pack-bitmap.c: open and store incremental bitmap layers
 - pack-revindex: prepare for incremental MIDX bitmaps
 - Documentation: describe incremental MIDX bitmaps
 - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
 (this branch uses tb/incremental-midx-part-1 and tb/pseudo-merge-bitmap-fixes.)

 Incremental updates of multi-pack index files.

 source: <cover.1723760847.git.me@ttaylorr.com>


* mt/rebase-x-quiet (2024-08-15) 1 commit
 - rebase -x: don't print "Executing:" msgs with --quiet

 "git rebase -x --quiet" was not quiet, which was corrected.

 Expecting a reroll.
 cf. <Zr8NOh-gMuhp-p0M@tanuki>
 source: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>


* ps/stash-keep-unrack-empty-fix (2024-08-16) 1 commit
 - builtin/stash: fix `--keep-index --include-untracked` with empty HEAD

 A corner case bug in "git stash" was fixed.

 Will merge to 'next'.
 source: <6067675b5edf36e2eb28e98119a1c02d0a7ae670.1723804926.git.ps@pks.im>

--------------------------------------------------
[Stalled]

* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* gt/unit-test-urlmatch-normalization (2024-08-14) 1 commit
 - t: migrate t0110-urlmatch-normalization to the new framework

 Another rewrite of test.

 Comments?
 source: <20240814142057.94671-1-shyamthakkar001@gmail.com>


* jk/midx-unused-fix (2024-08-13) 1 commit
  (merged to 'next' on 2024-08-14 at 2ec51e52e1)
 + midx: drop unused parameters from add_midx_to_chain()
 (this branch uses tb/incremental-midx-part-1.)

 Code clean-up in the base topic.

 Will merge to 'master'.
 source: <cover.1722958595.git.me@ttaylorr.com>


* ps/bundle-outside-repo-fix (2024-08-13) 2 commits
  (merged to 'next' on 2024-08-15 at 3b9ea8a38a)
 + bundle: default to SHA1 when reading bundle headers
 + builtin/bundle: have unbundle check for repo before opening its bundle

 "git bundle unbundle" outside a repository triggered a BUG()
 unnecessarily, which has been corrected.

 Will merge to 'master'.
 source: <cover.1723540604.git.ps@pks.im>


* ps/clar-unit-test (2024-08-16) 9 commits
 - t/unit-tests: convert ctype tests to use clar
 - t/unit-tests: convert strvec tests to use clar
 - Makefile: wire up the clar unit testing framework
 - Makefile: do not use sparse on third-party sources
 - Makefile: make hdr-check depend on generated headers
 - Makefile: fix sparse dependency on GENERATED_H
 - t/clar: fix compatibility with NonStop
 - t: import the clar unit testing framework
 - t: do not pass GIT_TEST_OPTS to unit tests with prove

 Import clar unit tests framework libgit2 folks invented for our
 use.

 Needs to decide how to fill feature gap with our home-grown one
 cf. <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com>
 source: <cover.1723791831.git.ps@pks.im>


* ps/maintenance-detach-fix (2024-08-16) 7 commits
 - run-command: fix detaching when running auto maintenance
 - builtin/maintenance: add a `--detach` flag
 - builtin/gc: add a `--detach` flag
 - builtin/gc: stop processing log file on signal
 - builtin/gc: fix leaking config values
 - builtin/gc: refactor to read config into structure
 - config: fix constness of out parameter for `git_config_get_expiry()`

 Allow maintance tasks other than "gc" to properly go background
 when "git maintenance" run them.

 Will merge to 'next'.
 source: <cover.1723804990.git.ps@pks.im>


* jk/send-email-translate-aliases (2024-08-15) 4 commits
 - fixup! send-email: teach git send-email option to translate aliases
 - send-email: teach git send-email option to translate aliases
 - t9001-send-email.sh: update alias list used for pine test
 - t9001-send-email.sh: fix quoting for mailrc --dump-aliases test

 "git send-email" learned "--translate-aliases" option that reads
 addresses from the standard input and emits the result of applying
 aliases on them to the standard output.

 Will merge to 'next' after squashing the fix in.
 source: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>


* cp/unit-test-reftable-block (2024-08-14) 10 commits
 - t-reftable-block: add tests for index blocks
 - t-reftable-block: add tests for obj blocks
 - t-reftable-block: add tests for log blocks
 - t-reftable-block: remove unnecessary variable 'j'
 - t-reftable-block: use xstrfmt() instead of xstrdup()
 - t-reftable-block: use block_iter_reset() instead of block_iter_close()
 - t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
 - t-reftable-block: use reftable_record_equal() instead of check_str()
 - t-reftable-block: release used block reader
 - t: move reftable/block_test.c to the unit testing framework

 Another test for reftable library ported to the unit test framework.

 Needs Review.
 source: <20240814121122.4642-1-chandrapratap3519@gmail.com>


* jc/tests-no-useless-tee (2024-08-08) 1 commit
  (merged to 'next' on 2024-08-12 at 188e777e16)
 + tests: drop use of 'tee' that hides exit status

 Test fixes.

 Will merge to 'master'.
 source: <xmqq4j7uhfvm.fsf@gitster.g>


* js/libgit-rust (2024-08-09) 5 commits
 - cgit: add higher-level cgit crate
 - config: add git_configset_alloc() and git_configset_clear_and_free()
 - cgit-sys: add repo initialization and config access
 - cgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Inviting further comments.
 source: <cover.1723242556.git.steadmon@google.com>


* jc/grammo-fixes (2024-08-09) 2 commits
  (merged to 'next' on 2024-08-15 at 111d5f5c13)
 + doc: grammofix in git-diff-tree
 + tutorial: grammofix

 Doc updates.

 Will merge to 'master'.
 source: <xmqqed6xehzv.fsf@gitster.g>


* jc/range-diff-lazy-setup (2024-08-09) 2 commits
 - remerge-diff: clean up temporary objdir at a central place
 - remerge-diff: lazily prepare temporary objdir on demand

 Code clean-up.

 Comments?
 source: <xmqqr0ax9vlk.fsf@gitster.g>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ps/leakfixes-part-4 (2024-08-14) 23 commits
 - builtin/diff: free symmetric diff members
 - diff: free state populated via options
 - builtin/log: fix leak when showing converted blob contents
 - userdiff: fix leaking memory for configured diff drivers
 - builtin/format-patch: fix various trivial memory leaks
 - diff: fix leak when parsing invalid ignore regex option
 - unpack-trees: clear index when not propagating it
 - sequencer: release todo list on error paths
 - merge-ort: unconditionally release attributes index
 - builtin/fast-export: plug leaking tag names
 - builtin/fast-export: fix leaking diff options
 - builtin/fast-import: plug trivial memory leaks
 - builtin/notes: fix leaking `struct notes_tree` when merging notes
 - builtin/rebase: fix leaking `commit.gpgsign` value
 - config: fix leaking comment character config
 - submodule-config: fix leaking name entry when traversing submodules
 - read-cache: fix leaking hashfile when writing index fails
 - bulk-checkin: fix leaking state TODO
 - object-name: fix leaking symlink paths in object context
 - object-file: fix memory leak when reading corrupted headers
 - git: fix leaking system paths
 - remote: plug memory leak when aliasing URLs
 - Merge branch 'ps/leakfixes-part-3' into ps/leakfixes-part-4

 More leak fixes.

 Will merge to 'next'.
 source: <cover.1723614263.git.ps@pks.im>


* cp/unit-test-reftable-readwrite (2024-08-13) 4 commits
 - t-reftable-readwrite: add test for known error
 - t-reftable-readwrite: use 'for' in place of infinite 'while' loops
 - t-reftable-readwrite: use free_names() instead of a for loop
 - t: move reftable/readwrite_test.c to the unit testing framework

 Will merge to 'next'.
 source: <20240813144440.4602-1-chandrapratap3519@gmail.com>


* ps/config-wo-the-repository (2024-08-13) 21 commits
 - config: hide functions using `the_repository` by default
 - global: prepare for hiding away repo-less config functions
 - config: don't depend on `the_repository` with branch conditions
 - config: don't have setters depend on `the_repository`
 - config: pass repo to functions that rename or copy sections
 - config: pass repo to `git_die_config()`
 - config: pass repo to `git_config_get_expiry_in_days()`
 - config: pass repo to `git_config_get_expiry()`
 - config: pass repo to `git_config_get_max_percent_split_change()`
 - config: pass repo to `git_config_get_split_index()`
 - config: pass repo to `git_config_get_index_threads()`
 - config: expose `repo_config_clear()`
 - config: introduce missing setters that take repo as parameter
 - path: hide functions using `the_repository` by default
 - path: stop relying on `the_repository` in `worktree_git_path()`
 - path: stop relying on `the_repository` when reporting garbage
 - hooks: remove implicit dependency on `the_repository`
 - editor: do not rely on `the_repository` for interactive edits
 - path: expose `do_git_common_path()` as `repo_common_pathv()`
 - path: expose `do_git_path()` as `repo_git_pathv()`
 - Merge branch 'ps/refs-wo-the-repository' into ps/config-wo-the-repository

 Use of API functions that implicitly depend on the_repository
 object in the config subsystem has been rewritten to pass a
 repository object through the callchain.

 Will merge to 'next'.
 source: <cover.1723540226.git.ps@pks.im>


* ps/transport-leakfix-test-updates (2024-08-08) 1 commit
  (merged to 'next' on 2024-08-12 at ee80dbc4f6)
 + transport: mark more tests leak-free

 Test updates.

 Will merge to 'master'.
 source: <ZrRV_HrUArsvRgn8@tanuki>


* ds/for-each-ref-is-base (2024-08-14) 4 commits
 - p1500: add is-base performance tests
 - for-each-ref: add 'is-base' token
 - commit: add gentle reference lookup method
 - commit-reach: add get_branch_base_for_tip

 'git for-each-ref' learned a new "--format" atom to find the branch
 that the history leading to a given commit "%(is-base:<commit>)" is
 likely based on.

 Comments?
 source: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>


* sj/ref-fsck (2024-08-08) 9 commits
  (merged to 'next' on 2024-08-09 at 3bde10da94)
 + fsck: add ref name check for files backend
 + files-backend: add unified interface for refs scanning
 + builtin/refs: add verify subcommand
 + refs: set up ref consistency check infrastructure
 + fsck: add refs report function
 + fsck: add a unified interface for reporting fsck messages
 + fsck: make "fsck_error" callback generic
 + fsck: rename objects-related fsck error functions
 + fsck: rename "skiplist" to "skip_oids"

 "git fsck" infrastructure has been taught to also check the sanity
 of the ref database, in addition to the object database.

 Will merge to 'master'.
 source: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>


* cc/promisor-remote-capability (2024-07-31) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?
 source: <20240731134014.2299361-1-christian.couder@gmail.com>


* tb/incremental-midx-part-1 (2024-08-06) 19 commits
  (merged to 'next' on 2024-08-12 at 92ec55fd49)
 + midx: implement support for writing incremental MIDX chains
 + t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 + t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 + midx: implement verification support for incremental MIDXs
 + midx: support reading incremental MIDX chains
 + midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 + midx: teach `midx_preferred_pack()` about incremental MIDXs
 + midx: teach `midx_contains_pack()` about incremental MIDXs
 + midx: remove unused `midx_locate_pack()`
 + midx: teach `fill_midx_entry()` about incremental MIDXs
 + midx: teach `nth_midxed_offset()` about incremental MIDXs
 + midx: teach `bsearch_midx()` about incremental MIDXs
 + midx: introduce `bsearch_one_midx()`
 + midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 + midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 + midx: teach `prepare_midx_pack()` about incremental MIDXs
 + midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 + midx: add new fields for incremental MIDX chains
 + Documentation: describe incremental MIDX format
 (this branch is used by jk/midx-unused-fix and tb/incremental-midx-part-2.)

 Incremental updates of multi-pack index files.

 Will merge to 'master'.
 source: <cover.1722958595.git.me@ttaylorr.com>


* ja/doc-synopsis-markup (2024-08-12) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis custom paragraph attribute

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Comments?
 source: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>


* tc/fetch-bundle-uri (2024-07-24) 3 commits
 - fetch: use bundle URIs when having creationToken heuristic
 - transport: introduce transport_has_remote_bundle_uri()
 - clone: remove double bundle list clear code

 Allow "git fetch" take advantage of bundleURI feature.

 Expecting a reroll or retraction.
 source: <ZqObobw8FsDMkllm@tanuki>


* ag/git-svn-global-ignores (2024-08-14) 3 commits
  (merged to 'next' on 2024-08-15 at b8332fe306)
 + git-svn: mention `svn:global-ignores` in help+docs
  (merged to 'next' on 2024-08-08 at 3ba5e164a6)
 + git-svn: use `svn:global-ignores` to create .gitignore
 + git-svn: add public property `svn:global-ignores`

 "git svn" has been taught about svn:global-ignores property
 recent versions of Subversion has.

 Will merge to 'master'.
 source: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
 source: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>


* ew/cat-file-optim (2024-07-15) 10 commits
 - cat-file: use writev(2) if available
 - cat-file: batch_write: use size_t for length
 - cat-file: batch-command uses content_limit
 - object_info: content_limit only applies to blobs
 - packfile: packed_object_info avoids packed_to_object_type
 - cat-file: use delta_base_cache entries directly
 - packfile: inline cache_or_unpack_entry
 - packfile: fix off-by-one in content_limit comparison
 - packfile: allow content-limit for cat-file
 - packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Expecting a reroll.
 cf. <ZqC82sDnj7Se_aVB@tanuki>
 source: <20240715003519.2671385-1-e@80x24.org>


* rs/unit-tests-test-run (2024-07-30) 6 commits
  (merged to 'next' on 2024-08-12 at 9df4336877)
 + t-strvec: use if_test
 + t-reftable-basics: use if_test
 + t-ctype: use if_test
 + unit-tests: add if_test
 + unit-tests: show location of checks outside of tests
 + t0080: use here-doc test body

 Unit-test framework has learned a simple control structure to allow
 embedding test statements in-line instead of having to create a new
 function to contain them.

 Will merge to 'master'.
 source: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
