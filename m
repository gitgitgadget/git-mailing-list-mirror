Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED644C7E
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829534; cv=none; b=b+Rt9sEtDnlKuqKvEcznRoLWU8emUbxQ9x3f1lRDb+fvshVJSlqYy06OBd6jmK2eyb7cH3El0w6ZtpadAD63jZlh9lu+phpX2Rr530m8KpZ/tE/44vrjkB0l+24VVDEBcTnKJR3qnaAOl/cLDaZaMmXCZ9tP5DxbxcPos78Ta2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829534; c=relaxed/simple;
	bh=k78S4M85Y8KEoAEV8mXiZkQ9sTCr6ELg/GvCd4Mzdzg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=al6pZ8M9GDBuNV2J/mGoHDDqtDgEokUva2N1Rhxg8E2f98aepTiNopQ2AJVZJ4tvZZFq8OucqWryqJHynTP4X+8vvMndteG56sfrMUzFxWhn0LhZo4yUgZzZmAYTPe6ODdytjx3S1SjpIaRXT7OIRbhsq4aBDCTebs0NpJ/3d8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dyhh6U20; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dyhh6U20"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 118E61FA625;
	Mon, 22 Apr 2024 19:45:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	78S4M85Y8KEoAEV8mXiZkQ9sTCr6ELg/GvCd4Mzdzg=; b=Dyhh6U20xX89tyFB0
	L0bMLk4XCqo/XTTKb9S6PAqqUTJoVr9RNUBYjLPihv9Q+oQX3OBl5TGco3GgXqy7
	lL8HqbBwrLoZ4x3bVkR1atSC2yvaVDDng87h/O3PI6RTDKEyDec57q6mI73z30Qs
	tg4/0LdNAk3g0sc++jiPG7xn9o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 038091FA624;
	Mon, 22 Apr 2024 19:45:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4FA1F1FA622;
	Mon, 22 Apr 2024 19:45:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2024, #08; Mon, 22)
X-master-at: 00e10ef10e161a913893b8cb33aa080d4ca5baa6
X-next-at: 0c9c63564e25443fb8d0688fe3c87722ba128238
Date: Mon, 22 Apr 2024 16:45:23 -0700
Message-ID: <xmqqzftlrmgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 638BDEDE-0102-11EF-B732-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

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
[New Topics]

* aj/stash-staged-fix (2024-04-22) 1 commit
 - stash: fix "--staged" with binary files

 "git stash -S" did not handle binary files correctly, which has
 been corrected.

 Will merge to 'next'.
 source: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>


* rj/add-i-leak-fix (2024-04-22) 4 commits
 - add: plug a leak on interactive_add
 - add-patch: plug a leak handling the '/' command
 - add-interactive: plug a leak in get_untracked_files
 - apply: plug a leak in apply_data

 Leakfix.

 Will merge to 'next'.
 source: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>


* rj/add-p-typo-reaction (2024-04-21) 1 commit
 - add-patch: response to unknown command

 When the user responds to a prompt given by "git add -p" with an
 unsupported command, list of available commands were given, which
 was too much if the user knew what they wanted to type but merely
 made a typo.  Now the user gets a much shorter error message.

 Will merge to 'next'.
 source: <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>


* rs/vsnprintf-failure-is-not-a-bug (2024-04-21) 1 commit
 - don't report vsnprintf(3) error as bug

 Demote a BUG() to an die() when the failure from vsnprintf() may
 not be due to a programmer error.

 Will merge to 'next'.
 source: <ea752a2b-9b74-4a59-a037-4782abf7161e@web.de>

--------------------------------------------------
[Cooking]

* ds/format-patch-rfc-and-k (2024-04-19) 1 commit
 - format-patch: ensure that --rfc and -k are mutually exclusive

 The "-k" and "--rfc" options of "format-patch" will now error out
 when used together, as one tells us not to add anything to the
 title of the commit, and the other one tells us to add "RFC" in
 addition to "PATCH".

 Will merge to 'next'.
 source: <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>


* jc/format-patch-rfc-more (2024-04-22) 2 commits
 - format-patch: "--rfc=-(WIP)" appends to produce [PATCH (WIP)]
 - format-patch: allow --rfc to optionally take a value, like --rfc=WIP

 The "--rfc" option of "git format-patch" learned to take an
 optional string value to be used in place of "RFC" to tweak the
 "[PATCH]" on the subject header.

 Will merge to 'next'?
 source: <20240421185915.1031590-1-gitster@pobox.com>


* ps/the-index-is-no-more (2024-04-18) 6 commits
 - repository: drop `initialize_the_repository()`
 - repository: drop `the_index` variable
 - builtin/clone: stop using `the_index`
 - repository: initialize index in `repo_init()`
 - builtin: stop using `the_index`
 - t/helper: stop using `the_index`

 The singleton index_state instance "the_index" has been eliminated
 by always instantiating "the_repository" and replacing references
 to "the_index"  with references to its .index member.

 Comments?
 source: <cover.1713442061.git.ps@pks.im>


* pw/rebase-m-signoff-fix (2024-04-18) 6 commits
 - rebase -m: fix --signoff with conflicts
 - sequencer: store commit message in private context
 - sequencer: move current fixups to private context
 - sequencer: start removing private fields from public API
 - sequencer: always free "struct replay_opts"
 - Merge branch 'pw/t3428-cleanup' into pw/rebase-m-signoff-fix

 "git rebase --signoff" used to forget that it needs to add a
 sign-off to the resulting commit when told to continue after a
 conflict stops its operation.

 Will merge to 'next'.
 source: <cover.1713445918.git.phillip.wood@dunelm.org.uk>


* mr/rerere-crash-fix (2024-04-16) 1 commit
  (merged to 'next' on 2024-04-17 at 60be8e2d74)
 + rerere: fix crashes due to unmatched opening conflict markers

 When .git/rr-cache/ rerere database gets corrupted or rerere is fed to
 work on a file with conflicted hunks resolved incompletely, the rerere
 machinery got confused and segfaulted, which has been corrected.

 Will merge to 'master'.
 source: <20240416105320.1113401-1-marcel@roethke.info>


* pk/bisect-use-show (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-22 at 4dd13c288f)
 + bisect: report the found commit with "show"

 When "git bisect" reports the commit it determined to be the
 culprit, we used to show it in a format that does not honor common
 UI tweaks, like log.date and log.decorate.  The code has been
 taught to use "git show" to follow more customizations.

 Will merge to 'master'.
 source: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>


* ps/missing-btmp-fix (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-16 at c70779ba4b)
 + pack-bitmap: gracefully handle missing BTMP chunks

 GIt 2.44 introduced a regression that makes the updated code to
 barf in repositories with multi-pack index written by older
 versions of Git, which has been corrected.

 Will merge to 'master'.
 source: <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>


* rj/launch-editor-error-message (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-16 at 3d0dd46fc2)
 + launch_editor: waiting message on error

 Git writes a "waiting for your editor" message on an incomplete
 line after launching an editor, and then append another error
 message on the same line if the editor errors out.  It now clears
 the "waiting for..." line before giving the error message.

 Will merge to 'master'.
 source: <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>


* rs/imap-send-simplify-cmd-issuing-codepath (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-17 at 0255e49f8b)
 + imap-send: increase command size limit

 Code simplification.

 Will merge to 'master'.
 source: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>


* rs/no-openssl-compilation-fix-on-macos (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-15 at 48cab93d0a)
 + git-compat-util: fix NO_OPENSSL on current macOS

 Build fix.

 Will merge to 'master'.
 source: <3188f4e2-9744-40b1-8f05-0896b8679d25@web.de>


* yb/replay-doc-linkfix (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-15 at e8cf9cd9a8)
 + Documentation: fix linkgit reference

 Docfix.

 Will merge to 'master'.
 source: <pull.1706.git.git.1713132482976.gitgitgadget@gmail.com>


* rs/apply-reject-long-name (2024-04-16) 1 commit
  (merged to 'next' on 2024-04-17 at 701ccded8b)
 + apply: avoid using fixed-size buffer in write_out_one_reject()

 The filename used for rejected hunks "git apply --reject" creates
 was limited to PATH_MAX, which has been lifted.

 Will merge to 'master'.
 source: <a93cd243-cb17-4ad5-8d23-30768dc5213b@web.de>


* js/for-each-repo-keep-going (2024-04-18) 2 commits
 - maintenance: running maintenance should not stop on errors
 - for-each-repo: optionally keep going on an error

 A scheduled "git maintenance" job is expected to work on all
 repositories it knows about, but it stopped at the first one that
 errored out.  Now it keeps going.

 Expecting a hopefully small and final reroll.
 Can change exit condition, which needs fixing.
 cf. <20240419175621.GB14309@coredump.intra.peff.net>
 source: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>


* ps/run-auto-maintenance-in-receive-pack (2024-04-17) 2 commits
  (merged to 'next' on 2024-04-22 at cacdcac452)
 + builtin/receive-pack: convert to use git-maintenance(1)
 + run-command: introduce function to prepare auto-maintenance process

 The "receive-pack" program (which responds to "git push") was not
 converted to run "git maintenance --auto" when other codepaths that
 used to run "git gc --auto" were updated, which has been corrected.

 Will merge to 'master'.
 source: <cover.1713334241.git.ps@pks.im>


* xx/disable-replace-when-building-midx (2024-04-17) 1 commit
 - midx: disable replace objects

 The procedure to build multi-pack-index got confused by the
 replace-refs mechanism, which has been corrected by disabling the
 latter.

 Will merge to 'next'.
 source: <pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>


* dd/t9604-use-posix-timezones (2024-04-10) 1 commit
  (merged to 'next' on 2024-04-16 at 46ab81737f)
 + t9604: Fix test for musl libc and new Debian

 The cvsimport tests required that the platform understands
 traditional timezone notations like CST6CDT, which has been
 updated to work on those systems as long as they understand
 POSIX notation with explicit tz transition dates.

 Will merge to 'master'.
 source: <20240410032812.30476-1-congdanhqx@gmail.com>


* kn/update-ref-symrefs (2024-04-12) 8 commits
 - SQUASH???
 - refs: support symrefs in 'reference-transaction' hook
 - update-ref: add support for symref-update
 - update-ref: add support for symref-create
 - files-backend: extract out `create_symref_lock`
 - update-ref: add support for symref-delete
 - update-ref: add support for symref-verify
 - refs: accept symref values in `ref_transaction[_add]_update`

 source: <20240412095908.1134387-1-knayak@gitlab.com>


* ta/fast-import-parse-path-fix (2024-04-15) 8 commits
  (merged to 'next' on 2024-04-15 at 00cc71a679)
 + fast-import: make comments more precise
 + fast-import: forbid escaped NUL in paths
 + fast-import: document C-style escapes for paths
 + fast-import: improve documentation for path quoting
 + fast-import: remove dead strbuf
 + fast-import: allow unquoted empty path for root
 + fast-import: directly use strbufs for paths
 + fast-import: tighten path unquoting

 The way "git fast-import" handles paths described in its input has
 been tightened up and more clearly documented.

 Will merge to 'master'.
 source: <cover.1713056559.git.thalia@archibald.dev>


* xx/rfc2822-date-format-in-doc (2024-04-12) 1 commit
  (merged to 'next' on 2024-04-17 at f2186bd6e8)
 + Documentation: fix typos describing date format

 Docfix.

 Will merge to 'master'.
 source: <pull.1716.git.1712911876943.gitgitgadget@gmail.com>


* la/doc-use-of-contacts-when-contributing (2024-04-18) 8 commits
 - SubmittingPatches: demonstrate using git-contacts with git-send-email
 - SubmittingPatches: add heading for format-patch and send-email
 - SubmittingPatches: dedupe discussion of security patches
 - SubmittingPatches: discuss reviewers first
 - SubmittingPatches: quote commands
 - SubmittingPatches: mention GitGitGadget
 - SubmittingPatches: clarify 'git-contacts' location
 - MyFirstContribution: mention contrib/contacts/git-contacts

 Advertise "git contacts", a tool for newcomers to find people to
 ask review for their patches, a bit more in our developer
 documentation.

 Will merge to 'next'?
 source: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>


* ps/ci-test-with-jgit (2024-04-12) 13 commits
 - t0612: add tests to exercise Git/JGit reftable compatibility
 - t0610: fix non-portable variable assignment
 - t06xx: always execute backend-specific tests
 - ci: install JGit dependency
 - ci: make Perforce binaries executable for all users
 - ci: merge scripts which install dependencies
 - ci: fix setup of custom path for GitLab CI
 - ci: merge custom PATH directories
 - ci: convert "install-dependencies.sh" to use "/bin/sh"
 - ci: drop duplicate package installation for "linux-gcc-default"
 - ci: skip sudo when we are already root
 - ci: expose distro name in dockerized GitHub jobs
 - ci: rename "runs_on_pool" to "distro"

 Tests to ensure interoperability between reftable written by jgit
 and our code have been added and enabled in CI.
 source: <cover.1712896868.git.ps@pks.im>


* pw/rebase-i-error-message (2024-04-08) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Expecting a reroll.
 cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
 source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>


* ps/reftable-write-optim (2024-04-08) 11 commits
 - reftable/block: reuse compressed array
 - reftable/block: reuse zstream when writing log blocks
 - reftable/writer: reset `last_key` instead of releasing it
 - reftable/writer: unify releasing memory
 - reftable/writer: refactorings for `writer_flush_nonempty_block()`
 - reftable/writer: refactorings for `writer_add_record()`
 - refs/reftable: don't recompute committer ident
 - reftable: remove name checks
 - refs/reftable: skip duplicate name checks
 - refs/reftable: perform explicit D/F check when writing symrefs
 - refs/reftable: fix D/F conflict error message on ref copy

 Code to write out reftable has seen some optimization and
 simplification.
 source: <cover.1712578837.git.ps@pks.im>


* ds/send-email-per-message-block (2024-04-10) 2 commits
 - send-email: make it easy to discern the messages for each patch
 - send-email: move newline characters out of a few translatable strings

 "git send-email" learned to separate its reports on each message it
 sends out with an extra blank line in between.

 Comments?
 source: <cover.1712732383.git.dsimic@manjaro.org>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 cf. <xmqqy1a4ao3t.fsf@gitster.g>
 source: <20240328101356.300374-1-e@80x24.org>


* ps/reftable-block-iteration-optim (2024-04-15) 10 commits
  (merged to 'next' on 2024-04-15 at 3a2353c7f2)
 + reftable/block: avoid copying block iterators on seek
 + reftable/block: reuse `zstream` state on inflation
 + reftable/block: open-code call to `uncompress2()`
 + reftable/block: reuse uncompressed blocks
 + reftable/reader: iterate to next block in place
 + reftable/block: move ownership of block reader into `struct table_iter`
 + reftable/block: introduce `block_reader_release()`
 + reftable/block: better grouping of functions
 + reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
 + reftable/block: rename `block_reader_start()`

 The code to iterate over reftable blocks has seen some optimization
 to reduce memory allocation and deallocation.

 Will merge to 'master'.
 source: <cover.1712578376.git.ps@pks.im>


* bc/credential-scheme-enhancement (2024-04-16) 16 commits
 - credential: add method for querying capabilities
 - credential-cache: implement authtype capability
 - t: add credential tests for authtype
 - credential: add support for multistage credential rounds
 - t5563: refactor for multi-stage authentication
 - docs: set a limit on credential line length
 - credential: enable state capability
 - credential: add an argument to keep state
 - http: add support for authtype and credential
 - docs: indicate new credential protocol fields
 - credential: add a field called "ephemeral"
 - credential: gate new fields on capability
 - credential: add a field for pre-encoded credentials
 - http: use new headers for each object request
 - remote-curl: reset headers on new request
 - credential: add an authtype field

 The credential helper protocol, together with the HTTP layer, have
 been enhanced to support authentication schemes different from
 username & password pair, like Bearer and NTLM.
 source: <20240417000240.3611948-1-sandals@crustytoothpaste.net>


* tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
 - t/perf: implement performace tests for pseudo-merge bitmaps
 - pseudo-merge: implement support for finding existing merges
 - ewah: `bitmap_equals_ewah()`
 - pack-bitmap: extra trace2 information
 - pack-bitmap.c: use pseudo-merges during traversal
 - t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
 - pack-bitmap: implement test helpers for pseudo-merge
 - ewah: implement `ewah_bitmap_popcount()`
 - pseudo-merge: implement support for reading pseudo-merge commits
 - pack-bitmap.c: read pseudo-merge extension
 - pseudo-merge: scaffolding for reads
 - pack-bitmap: extract `read_bitmap()` function
 - pack-bitmap-write.c: write pseudo-merge table
 - pack-bitmap-write.c: select pseudo-merge commits
 - pseudo-merge: implement support for selecting pseudo-merge commits
 - pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 - pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 - pack-bitmap-write: support storing pseudo-merge commits
 - pseudo-merge.ch: initial commit
 - pack-bitmap: move some initialization to `bitmap_writer_init()`
 - pack-bitmap: drop unused `max_bitmaps` parameter
 - ewah: implement `ewah_bitmap_is_subset()`
 - config: repo_config_get_expiry()
 - Documentation/technical: describe pseudo-merge bitmaps format

 The pack-bitmap machinery learned to write pseudo-merge bitmaps,
 which act as imaginary octopus merges covering un-bitmapped
 reference tips. This enhances bitmap coverage, and thus,
 performance, for repositories with many references using bitmaps.

 Expecting a reroll.
 cf. <ZfyxCLpjbaScIdWA@nand.local>
 source: <cover.1710972293.git.me@ttaylorr.com>


* la/hide-trailer-info (2024-04-19) 9 commits
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - trailer: make parse_trailers() return trailer_info pointer
 - interpret-trailers: access trailer_info with new helpers
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - trailer: add unit tests for trailer iterator
 - Makefile: sort UNIT_TEST_PROGRAMS
 - Merge branch 'la/format-trailer-info' into la/hide-trailer-info
 (this branch uses la/format-trailer-info.)

 The trailer API has been reshuffled a bit.

 Needs review.
 source: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* la/format-trailer-info (2024-03-15) 5 commits
  (merged to 'next' on 2024-04-16 at dca4784407)
 + trailer: finish formatting unification
 + trailer: begin formatting unification
 + format_trailer_info(): append newline for non-trailer lines
 + format_trailer_info(): drop redundant unfold_value()
 + format_trailer_info(): use trailer_item objects
 (this branch is used by la/hide-trailer-info.)

 The code to format trailers have been cleaned up.

 Will merge to 'master'.
 source: <pull.1694.git.1710485706.gitgitgadget@gmail.com>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* js/build-fuzz-more-often (2024-04-11) 2 commits
 - fuzz: link fuzz programs with `make all` on Linux
 - ci: also define CXX environment variable

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.

 Expecting a hopefully small and final reroll.
 cf. <20240412042247.GA1077925@coredump.intra.peff.net>
 source: <cover.1712858920.git.steadmon@google.com>


* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/cmake-with-test-tool (2024-02-23) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* js/unit-test-suite-runner (2024-02-23) 8 commits
 - ci: use test-tool as unit test runner on Windows
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner
 (this branch is used by js/cmake-with-test-tool.)

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.

 Needs review.
 source: <cover.1708728717.git.steadmon@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
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

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
