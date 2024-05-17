Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD0EED3
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989770; cv=none; b=BzSEnfobGqn9e9fSAcIWylv92wbsNtlog/29G4CL3zkxMIHPnJ/G5Wta72Ms5L2RqtVHzkCOU7sGukXZDhwSgYAdy/NER3Ks/hfi5WsMW88wkeURF2lIu4a6M+ybzdFr9+WcUsFmi8hKE3WOAt/+ryaDaty1ABXGpj8NSUOGTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989770; c=relaxed/simple;
	bh=Ld59OoaiWxqOMSuhlCHgqpmFVCJFqQ2qZiA/BCClGXs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eDMsFGAI1qE7vaS4dDr9wZJpN/gQMjiE0JYsAO4twJQsIGao52I9ClsoUPbFuT8J4V/qBAtxRm2ARVNy7gzAbJSzd/hh7ukvwr0Ds9xAXI1dATN8MXGlHq8KXMi8sTsTlcJJKdv1sev5fqu8KACp7pEr2p6wSFTY2yP10l4Pans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=eeNMYYgG; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eeNMYYgG"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BF65321B1;
	Fri, 17 May 2024 19:49:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	d59OoaiWxqOMSuhlCHgqpmFVCJFqQ2qZiA/BCClGXs=; b=eeNMYYgGV4KW2kjJ1
	+q6KRsidn7LGAI32rInMq9JrpdXlEAr7FFF5sT9QEV48qyfMCijEKQ2Og6z3F87z
	uysDO+xY8rlsbQIbrY8E2iI8NfQjFWY1HqxuRaO282IMMU0ftufPn08KPmQbp3W6
	sfU7YmPRrq1iCooWa8k/s67d1E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 56A83321B0;
	Fri, 17 May 2024 19:49:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2074321AF;
	Fri, 17 May 2024 19:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (May 2024, #07; Fri, 17)
X-master-at: d8ab1d464d07baa30e5a180eb33b3f9aa5c93adf
X-next-at: de53f37879660c0da62a72472ba37f8680a3587c
Date: Fri, 17 May 2024 16:49:22 -0700
Message-ID: <xmqqfrugdmnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 16873C50-14A8-11EF-9AA9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

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

* ds/scalar-reconfigure-all-fix (2024-05-07) 1 commit
  (merged to 'next' on 2024-05-08 at eca398f4a5)
 + scalar: avoid segfault in reconfigure --all

 Scalar fix.
 source: <pull.1724.v3.git.1715126749391.gitgitgadget@gmail.com>


* jl/git-no-advice (2024-05-07) 4 commits
  (merged to 'next' on 2024-05-08 at c9e7e0866e)
 + t0018: two small fixes
  (merged to 'next' on 2024-05-06 at 95cc03ef96)
 + advice: add --no-advice global option
 + doc: add spacing around paginate options
 + doc: clean up usage documentation for --no-* opts

 A new global "--no-advice" option can be used to disable all advice
 messages, which is meant to be used only in scripts.
 source: <20240503071706.78109-1-james@jamesliu.io>


* jp/tag-trailer (2024-05-07) 3 commits
  (merged to 'next' on 2024-05-07 at 646013793d)
 + builtin/tag: add --trailer option
 + builtin/commit: refactor --trailer logic
 + builtin/commit: use ARGV macro to collect trailers

 "git tag" learned the "--trailer" option to futz with the trailers
 in the same way as "git commit" does.
 source: <pull.1723.v5.git.1714934950.gitgitgadget@gmail.com>


* js/unit-test-suite-runner (2024-05-06) 9 commits
  (merged to 'next' on 2024-05-07 at 3b376223e3)
 + cmake: let `test-tool` run the unit tests, too
 + ci: use test-tool as unit test runner on Windows
 + t/Makefile: run unit tests alongside shell tests
 + unit tests: add rule for running with test-tool
 + test-tool run-command testsuite: support unit tests
 + test-tool run-command testsuite: remove hardcoded filter
 + test-tool run-command testsuite: get shell from env
 + t0080: turn t-basic unit test into a helper
 + Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.
 source: <cover.1715024899.git.steadmon@google.com>
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* jt/port-ci-whitespace-check-to-gitlab (2024-05-03) 5 commits
  (merged to 'next' on 2024-05-08 at 774a29dde4)
 + gitlab-ci: add whitespace error check
 + ci: make the whitespace report optional
 + ci: separate whitespace check script
 + github-ci: fix link to whitespace error
 + ci: pre-collapse GitLab CI sections

 The "whitespace check" task that was enabled for GitHub Actions CI
 has been ported to GitLab CI.
 source: <20240503172110.181326-1-jltobler@gmail.com>


* ow/refspec-glossary-update (2024-05-06) 1 commit
  (merged to 'next' on 2024-05-07 at 7d55ebb0c8)
 + Documentation: Mention that refspecs are explained elsewhere

 Doc update.
 source: <20240506182317.13477-1-oystwa@gmail.com>


* ps/config-subcommands (2024-05-06) 14 commits
  (merged to 'next' on 2024-05-07 at f10c689a30)
 + builtin/config: display subcommand help
 + builtin/config: introduce "edit" subcommand
 + builtin/config: introduce "remove-section" subcommand
 + builtin/config: introduce "rename-section" subcommand
 + builtin/config: introduce "unset" subcommand
 + builtin/config: introduce "set" subcommand
 + builtin/config: introduce "get" subcommand
 + builtin/config: introduce "list" subcommand
 + builtin/config: pull out function to handle `--null`
 + builtin/config: pull out function to handle config location
 + builtin/config: use `OPT_CMDMODE()` to specify modes
 + builtin/config: move "fixed-value" option to correct group
 + builtin/config: move option array around
 + config: clarify memory ownership when preparing comment strings
 (this branch is used by ps/builtin-config-cleanup.)

 The operation mode options (like "--get") the "git config" command
 uses have been deprecated and replaced with subcommands (like "git
 config get").
 source: <cover.1714982328.git.ps@pks.im>


* ps/refs-without-the-repository (2024-05-07) 5 commits
  (merged to 'next' on 2024-05-08 at 2479b9de46)
 + refs: remove functions without ref store
 + cocci: apply rules to rewrite callers of "refs" interfaces
 + cocci: introduce rules to transform "refs" to pass ref store
 + refs: add `exclude_patterns` parameter to `for_each_fullref_in()`
 + refs: introduce missing functions that accept a `struct ref_store`
 (this branch is used by ps/refs-without-the-repository-updates.)

 The refs API lost functions that implicitly assumes to work on the
 primary ref_store by forcing the callers to pass a ref_store as an
 argument.
 source: <cover.1715065736.git.ps@pks.im>


* rs/external-diff-with-exit-code (2024-05-06) 1 commit
  (merged to 'next' on 2024-05-08 at ad5fee3cbf)
 + diff: report unmerged paths as changes in run_diff_cmd()

 The "--exit-code" option of "git diff" command learned to report
 unmerged paths as changes.

 [jc: the tip one was reverted out]
 source: <82561c70-ec33-41bf-b036-52310ffc1926@web.de>


* vd/doc-merge-tree-x-option (2024-05-07) 1 commit
  (merged to 'next' on 2024-05-08 at 42637b8bdf)
 + Documentation/git-merge-tree.txt: document -X

 Doc update.
 source: <pull.1728.git.1715117789985.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* tb/pack-bitmap-write-cleanups (2024-05-15) 6 commits
 - pack-bitmap: introduce `bitmap_writer_free()`
 - pack-bitmap-write.c: avoid uninitialized 'write_as' field
 - pack-bitmap: drop unused `max_bitmaps` parameter
 - pack-bitmap: avoid use of static `bitmap_writer`
 - pack-bitmap-write.c: move commit_positions into commit_pos fields
 - object.h: add flags allocated by pack-bitmap.h

 The pack bitmap code saw some clean-up to prepare for a follow-up topic.

 Will merge to 'next'?
 source: <cover.1715716605.git.me@ttaylorr.com>


* jc/t0017-clarify-bogus-expectation (2024-05-16) 1 commit
 - t0017: clarify dubious test set-up

 Test clean-up.

 Will merge to 'next'?
 source: <xmqqcypmx44l.fsf@gitster.g>


* kn/osxkeychain-skip-idempotent-store (2024-05-15) 2 commits
 - osxkeychain: state to skip unnecessary store operations
 - osxkeychain: exclusive lock to serialize execution of operations

 The credential helper that talks with osx keychain learned to avoid
 storing back the authentication material it just got received from
 the keychain.

 Comments?
 source: <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>


* kn/update-ref-symref (2024-05-15) 7 commits
 - update-ref: add support for 'symref-update' command
 - reftable: pick either 'oid' or 'target' for new updates
 - update-ref: add support for 'symref-create' command
 - update-ref: add support for 'symref-delete' command
 - update-ref: add support for 'symref-verify' command
 - refs: create and use `ref_update_ref_must_exist()`
 - Merge branch 'kn/ref-transaction-symref' into kn/update-ref-symref
 (this branch uses kn/ref-transaction-symref.)

 "git update-ref --stdin" learned to handle transactional updates of
 symbolic-refs.

 Expecting a reroll.
 cf. <ZkXpcvF6dxGr6qmj@tanuki>
 source: <20240514124411.1037019-1-knayak@gitlab.com>


* mt/t0211-typofix (2024-05-16) 1 commit
 - t/t0211-trace2-perf.sh: fix typo patern -> pattern

 Test fix.

 Will merge to 'next'.
 source: <ZkW5ggOVlglfi64u@telcontar>


* ps/complete-config-w-subcommands (2024-05-17) 1 commit
 - completion: adapt git-config(1) to complete subcommands

 Update the command line completion script (in contrib/) to adjust
 to the recent update to "git config" that adopted subcommand based
 UI.

 Will merge to 'next'.
 source: <8d43dee33289969a5afbbf7635ac40b7312d8e19.1715926344.git.ps@pks.im>


* ps/refs-without-the-repository-updates (2024-05-17) 17 commits
 - refs/packed: remove references to `the_hash_algo`
 - refs/files: remove references to `the_hash_algo`
 - refs/files: use correct repository
 - refs: remove `dwim_log()`
 - refs: drop `git_default_branch_name()`
 - refs: pass repo when peeling objects
 - refs: move object peeling into "object.c"
 - refs: pass ref store when detecting dangling symrefs
 - refs: convert iteration over replace refs to accept ref store
 - refs: retrieve worktree ref stores via associated repository
 - refs: refactor `resolve_gitlink_ref()` to accept a repository
 - refs: pass repo when retrieving submodule ref store
 - refs: track ref stores via strmap
 - refs: implement releasing ref storages
 - refs: rename `init_db` callback to avoid confusion
 - refs: adjust names for `init` and `init_db` callbacks
 - Merge branch 'ps/refs-without-the-repository' into ps/refs-without-the-repository-updates

 Further clean-up the refs subsystem to stop relying on
 the_repository, and instead use the repository associated to the
 ref_store object.

 Will merge to 'next'?
 source: <cover.1715929858.git.ps@pks.im>


* jc/doc-diff-name-only (2024-05-17) 1 commit
 - diff: document what --name-only shows

 The documentation for "git diff --name-only" has been clarified
 that it is about showing the names in the post-image tree.

 Will merge to 'next'.
 source: <xmqqeda0jr7d.fsf@gitster.g>


* kn/patch-iteration-doc (2024-05-17) 2 commits
 - SubmittingPatches: add section for iterating patches
 - Merge branch 'jc/patch-flow-updates' into kn/patch-iteration-doc
 (this branch uses jc/patch-flow-updates.)

 Doc updates.

 Will merge to 'next'.
 source: <20240517122724.270706-1-knayak@gitlab.com>


* mt/openindiana-portability (2024-05-17) 7 commits
  (merged to 'next' on 2024-05-17 at de53f37879)
 + t/t9001-send-email.sh: sed - remove the i flag for s
 + t/t9118-git-svn-funky-branch-names.sh: sed needs semicolon
 + t/t1700-split-index.sh: mv -v is not portable
 + t/t4202-log.sh: fix misspelled variable
 + t/t0600-reffiles-backend.sh: rm -v is not portable
 + t/t9902-completion.sh: backslashes in echo
 + Switch grep from non-portable BRE to portable ERE

 Portability updates to various uses of grep and sed.

 Will merge to 'master'.
 source: <ZkeMiifGHkIsehz3@telcontar>


* mt/openindiana-scalar (2024-05-17) 1 commit
 - scalar: make enlistment delete to work on all POSIX platforms

 Avoid removing the $(cwd) for portability.

 Needs review.
 source: <Zkds81OB7C5bTCl_@telcontar>


* ts/archive-prefix-with-add-virtual-file (2024-05-17) 1 commit
 - archive: make --add-virtual-file honor --prefix

 source: <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>


* js/doc-decisions (2024-05-17) 1 commit
 - doc: describe the project's decision-making process

 The project decision making policy has been documented.
 source: <10f217915600eda3ebec886e4f020f87c22e318a.1715978031.git.steadmon@google.com>

--------------------------------------------------
[Cooking]

* jc/compat-regex-calloc-fix (2024-05-13) 1 commit
  (merged to 'next' on 2024-05-13 at 077c4e1dcc)
 + compat/regex: fix argument order to calloc(3)

 Windows CI running in GitHub Actions started complaining about the
 order of arguments given to calloc(); the imported regex code uses
 the wrong order almost consistently, which has been corrected.

 Will merge to 'master'.
 source: <xmqqbk5bim2n.fsf@gitster.g>


* jc/undecided-is-not-necessarily-sha1-fix (2024-05-16) 6 commits
 - apply: fix uninitialized hash function
 - builtin/hash-object: fix uninitialized hash function
 - builtin/patch-id: fix uninitialized hash function
 - t1517: test commands that are designed to be run outside repository
 - setup: add an escape hatch for "no more default hash algorithm" change
 - Merge branch 'ps/undecided-is-not-necessarily-sha1' into jc/undecided-is-not-necessarily-sha1-fix
 (this branch uses ps/undecided-is-not-necessarily-sha1.)

 The base topic started to make it an error for a command to leave
 the hash algorithm unspecified, which revealed a few commands that
 were not ready for the change.  Give users a knob to revert back to
 the "default is sha-1" behaviour as an escape hatch, and start
 fixing these breakages.

 Comments?
 source: <20240513224127.2042052-1-gitster@pobox.com>


* dg/fetch-pack-code-cleanup (2024-05-13) 1 commit
  (merged to 'next' on 2024-05-17 at c8f8136d2e)
 + fetch-pack: remove unused 'struct loose_object_iter'

 Code clean-up to remove an unused struct definition.

 Will merge to 'master'.
 source: <20240512005913.342287-1-dave@treblig.org>


* dm/update-index-doc-fix (2024-05-13) 1 commit
  (merged to 'next' on 2024-05-17 at 2f6cd0d1cc)
 + documentation: git-update-index: add --show-index-version to synopsis

 Doc fix.

 Will merge to 'master'.
 source: <20240512031400.28416-1-dov.murik@linux.dev>


* ps/builtin-config-cleanup (2024-05-15) 22 commits
 - builtin/config: pass data between callbacks via local variables
 - builtin/config: convert flags to a local variable
 - builtin/config: track "fixed value" option via flags only
 - builtin/config: convert `key` to a local variable
 - builtin/config: convert `key_regexp` to a local variable
 - builtin/config: convert `regexp` to a local variable
 - builtin/config: convert `value_pattern` to a local variable
 - builtin/config: convert `do_not_match` to a local variable
 - builtin/config: move `respect_includes_opt` into location options
 - builtin/config: move default value into display options
 - builtin/config: move type options into display options
 - builtin/config: move display options into local variables
 - builtin/config: move location options into local variables
 - builtin/config: refactor functions to have common exit paths
 - config: make the config source const
 - builtin/config: check for writeability after source is set up
 - builtin/config: move actions into `cmd_config_actions()`
 - builtin/config: move legacy options into `cmd_config()`
 - builtin/config: move subcommand options into `cmd_config()`
 - builtin/config: move legacy mode into its own function
 - builtin/config: stop printing full usage on misuse
 - Merge branch 'ps/config-subcommands' into ps/builtin-config-cleanup

 Code clean-up to reduce inter-function communication inside
 builtin/config.c done via the use of global variables.

 Will merge to 'next'?
 source: <cover.1715755055.git.ps@pks.im>


* jc/doc-manpages-l10n (2024-05-17) 1 commit
 - SubmittingPatches: advertise git-manpages-l10n project a bit

 The SubmittingPatches document now refers folks to manpages
 translation project.

 Will merge to 'next'.
 source: <xmqqv83muc12.fsf@gitster.g>


* ps/reftable-reusable-iterator (2024-05-13) 13 commits
 - reftable/merged: adapt interface to allow reuse of iterators
 - reftable/stack: provide convenience functions to create iterators
 - reftable/reader: adapt interface to allow reuse of iterators
 - reftable/generic: adapt interface to allow reuse of iterators
 - reftable/generic: move seeking of records into the iterator
 - reftable/merged: simplify indices for subiterators
 - reftable/merged: split up initialization and seeking of records
 - reftable/reader: set up the reader when initializing table iterator
 - reftable/reader: inline `reader_seek_internal()`
 - reftable/reader: separate concerns of table iter and reftable reader
 - reftable/reader: unify indexed and linear seeking
 - reftable/reader: avoid copying index iterator
 - reftable/block: use `size_t` to track restart point index

 Code clean-up to make the reftable iterator closer to be reusable.

 Comments?
 source: <cover.1715589670.git.ps@pks.im>


* tb/precompose-getcwd (2024-05-09) 1 commit
  (merged to 'next' on 2024-05-11 at d1b507b01a)
 + macOS: ls-files path fails if path of workdir is NFD

 We forgot to normalize the result of getcwd() to NFC on macOS where
 all other paths are normalized, which has been corrected.

 Will merge to 'master'.
 source: <20240509161110.12121-1-tboegi@web.de>


* jc/patch-flow-updates (2024-05-10) 2 commits
  (merged to 'next' on 2024-05-16 at d7a885574b)
 + SubmittingPatches: extend the "flow" section
 + SubmittingPatches: move the patch-flow section earlier
 (this branch is used by kn/patch-iteration-doc.)

 Doc updates.

 Will merge to 'master'.
 source: <20240510165526.1412338-1-gitster@pobox.com>


* it/refs-name-conflict (2024-05-06) 1 commit
  (merged to 'next' on 2024-05-15 at 39ef3ecc88)
 + refs: return conflict error when checking packed refs

 Expose "name conflict" error when a ref creation fails due to D/F
 conflict in the ref namespace, to improve an error message given by
 "git fetch".

 Will merge to 'master'.
 source: <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>


* jc/format-patch-more-aggressive-range-diff (2024-05-06) 1 commit
 - format-patch: run range-diff with larger creation-factor

 The default "creation-factor" used by "git format-patch" has been
 raised to make it more aggressively find matching commits.

 Comments?
 source: <xmqqbk5i3ncw.fsf_-_@gitster.g>


* kn/ref-transaction-symref (2024-05-07) 8 commits
  (merged to 'next' on 2024-05-11 at 0a7119f2a3)
 + refs: remove `create_symref` and associated dead code
 + refs: rename `refs_create_symref()` to `refs_update_symref()`
 + refs: use transaction in `refs_create_symref()`
 + refs: add support for transactional symref updates
 + refs: move `original_update_refname` to 'refs.c'
 + refs: support symrefs in 'reference-transaction' hook
 + files-backend: extract out `create_symref_lock()`
 + refs: accept symref values in `ref_transaction_update()`
 (this branch is used by kn/update-ref-symref.)

 Updates to symbolic refs can now be made as a part of ref
 transaction.

 Will merge to 'master'.
 source: <20240507125859.132116-1-knayak@gitlab.com>


* ps/reftable-write-options (2024-05-13) 11 commits
 - refs/reftable: allow configuring geometric factor
 - reftable: make the compaction factor configurable
 - refs/reftable: allow disabling writing the object index
 - refs/reftable: allow configuring restart interval
 - reftable: use `uint16_t` to track restart interval
 - refs/reftable: allow configuring block size
 - reftable/dump: support dumping a table's block structure
 - reftable/writer: improve error when passed an invalid block size
 - reftable/writer: drop static variable used to initialize strbuf
 - reftable: pass opts as constant pointer
 - reftable: consistently refer to `reftable_write_options` as `opts`

 The knobs to tweak how reftable files are written have been made
 available as configuration variables.

 Comments?
 source: <cover.1715587849.git.ps@pks.im>


* ps/pseudo-ref-terminology (2024-05-15) 10 commits
 - refs: refuse to write pseudorefs
 - ref-filter: properly distinuish pseudo and root refs
 - refs: pseudorefs are no refs
 - refs: classify HEAD as a root ref
 - refs: do not check ref existence in `is_root_ref()`
 - refs: rename `is_special_ref()` to `is_pseudo_ref()`
 - refs: rename `is_pseudoref()` to `is_root_ref()`
 - Documentation/glossary: define root refs as refs
 - Documentation/glossary: clarify limitations of pseudorefs
 - Documentation/glossary: redefine pseudorefs as special refs

 Terminology to call various ref-like things are getting
 straightened out.

 Will merge to 'next'?
 cf. <vgzwb5xnlvz2gfiqamzrfcjs2xya3zhhoootyzopfpdrjapayq@wfsomyal4cf6>
 source: <cover.1715755591.git.ps@pks.im>


* jc/rev-parse-fatal-doc (2024-05-01) 1 commit
 - rev-parse: document how --is-* options work outside a repository

 Doc update.

 Comments?
 source: <xmqqplu54fbg.fsf@gitster.g>


* ps/undecided-is-not-necessarily-sha1 (2024-05-06) 15 commits
  (merged to 'next' on 2024-05-08 at 9f8e894685)
 + repository: stop setting SHA1 as the default object hash
 + oss-fuzz/commit-graph: set up hash algorithm
 + builtin/shortlog: don't set up revisions without repo
 + builtin/diff: explicitly set hash algo when there is no repo
 + builtin/bundle: abort "verify" early when there is no repository
 + builtin/blame: don't access potentially unitialized `the_hash_algo`
 + builtin/rev-parse: allow shortening to more than 40 hex characters
 + remote-curl: fix parsing of detached SHA256 heads
 + attr: fix BUG() when parsing attrs outside of repo
 + attr: don't recompute default attribute source
 + parse-options-cb: only abbreviate hashes when hash algo is known
 + path: move `validate_headref()` to its only user
 + path: harden validation of HEAD with non-standard hashes
 + Merge branch 'ps/the-index-is-no-more' into ps/undecided-is-not-necessarily-sha1
 + Merge branch 'jc/no-default-attr-tree-in-bare' into ps/undecided-is-not-necessarily-sha1
 (this branch is used by jc/undecided-is-not-necessarily-sha1-fix.)

 Before discovering the repository details, We used to assume SHA-1
 as the "default" hash function, which has been corrected. Hopefully
 this will smoke out codepaths that rely on such an unwarranted
 assumptions.

 Will cook in 'next'.
 source: <cover.1715057362.git.ps@pks.im>


* pw/rebase-i-error-message (2024-04-08) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Expecting a reroll.
 cf. <88bc0787-e7ae-49e5-99e8-97f6c55ea8c6@gmail.com>
 source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>


* ds/send-email-per-message-block (2024-04-10) 1 commit
 - send-email: move newline characters out of a few translatable strings

 Preliminary code clean-up for "git send-email".

 Will merge to 'next'.
 The topmost commit in the original series was dropped per author's request.
 cf. <a07d3807a24f6d68cb48ee48366ae25e@manjaro.org>
 source: <29ea3a9b07bf1aa17b5d6a1e41325379c494bcb2.1712732383.git.dsimic@manjaro.org>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 cf. <xmqqy1a4ao3t.fsf@gitster.g>
 source: <20240328101356.300374-1-e@80x24.org>


* la/hide-trailer-info (2024-05-02) 11 commits
  (merged to 'next' on 2024-05-15 at 955ffe4f37)
 + trailer unit tests: inspect iterator contents
 + trailer: document parse_trailers() usage
 + trailer: retire trailer_info_get() from API
 + trailer: make trailer_info struct private
 + trailer: make parse_trailers() return trailer_info pointer
 + interpret-trailers: access trailer_info with new helpers
 + sequencer: use the trailer iterator
 + trailer: teach iterator about non-trailer lines
 + trailer: add unit tests for trailer iterator
 + Makefile: sort UNIT_TEST_PROGRAMS
 + Merge branch 'la/format-trailer-info' into la/hide-trailer-info

 The trailer API has been reshuffled a bit.

 Will merge to 'master'.
 source: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


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

--------------------------------------------------
[Discarded]

* tb/pseudo-merge-reachability-bitmap (2024-04-30) 23 commits
 . t/perf: implement performace tests for pseudo-merge bitmaps
 . pseudo-merge: implement support for finding existing merges
 . ewah: `bitmap_equals_ewah()`
 . pack-bitmap: extra trace2 information
 . pack-bitmap.c: use pseudo-merges during traversal
 . t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
 . pack-bitmap: implement test helpers for pseudo-merge
 . ewah: implement `ewah_bitmap_popcount()`
 . pseudo-merge: implement support for reading pseudo-merge commits
 . pack-bitmap.c: read pseudo-merge extension
 . pseudo-merge: scaffolding for reads
 . pack-bitmap: extract `read_bitmap()` function
 . pack-bitmap-write.c: write pseudo-merge table
 . pack-bitmap-write.c: select pseudo-merge commits
 . pseudo-merge: implement support for selecting pseudo-merge commits
 . pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 . pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 . pack-bitmap-write: support storing pseudo-merge commits
 . pseudo-merge.ch: initial commit
 . pack-bitmap: move some initialization to `bitmap_writer_init()`
 . pack-bitmap: drop unused `max_bitmaps` parameter
 . ewah: implement `ewah_bitmap_is_subset()`
 . Documentation/technical: describe pseudo-merge bitmaps format

 The pack-bitmap machinery learned to write pseudo-merge bitmaps,
 which act as imaginary octopus merges covering un-bitmapped
 reference tips. This enhances bitmap coverage, and thus,
 performance, for repositories with many references using bitmaps.

 Retracted to be rebuilt on top of tb/pack-bitmap-write-cleanups topic
 source: <cover.1714422410.git.me@ttaylorr.com>
