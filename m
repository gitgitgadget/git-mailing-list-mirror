Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F777652
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451077; cv=none; b=hjzufiP6wo7Qmw5vPT1OZMqG6/mGhBx6aHulODf+h013uhvWZ7ojaciJPnwRpuGMNQx5QyoWKYFOM68IPj3rc4mBKG9/TFLFGvQJ0NIBZevUix2cIJx1KOknceyHE2iMSuDSVxqv/tM934I/OOdA4RXRfnfwcJHwbkJY2ACl07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451077; c=relaxed/simple;
	bh=9OkEEzVUqLPhvedINdksElMxN8K7gdh8bArOuT4EvSc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1TkbHKNovXrDmOmH3KYSVNL1zps7cbuDa0B05dSIKMYxZvEG3V9RRCiKwr1nmELj415ERy6g7c0+yOjqlgocxsc6gvy5vGqpdahwgzwgUTacMYOV6Hpi2+KPV1iJK7vK5YBbXY2+CmzDggXoKDq5+76POVtTq/duPGLkKZ+Sps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwUjN5eN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwUjN5eN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1755E1E9387;
	Tue, 20 Feb 2024 12:44:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	OkEEzVUqLPhvedINdksElMxN8K7gdh8bArOuT4EvSc=; b=bwUjN5eNUaAr1a0hM
	brQwOUIBku4RwmsPLjoy3ua5t5gOtoP/FhK2vDfX25BCaBcaahsMOezVy1rvPaVx
	1KKFBPEzEEL2ZvRxPWL1YM9Q4hl4rg6poY2mH+eMqBSI/t7lmqWEd927OpTSn5EZ
	tB701WpYzmOWGi+POPo6a1XOr8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DF271E9386;
	Tue, 20 Feb 2024 12:44:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AD531E9384;
	Tue, 20 Feb 2024 12:44:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2024, #07; Tue, 20)
X-master-at: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
X-next-at: e91efceb0f2ddd49aa201fe3bd057235203b2dcd
Date: Tue, 20 Feb 2024 09:44:25 -0800
Message-ID: <xmqqplwrqbd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0D311EC-D017-11EE-A672-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.44-rc2 has been tagged to fix a regression discovered the last
minute.  The final release is postponed until later this week.

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
[Graduated to 'master']

* la/trailer-cleanups (2024-02-19) 1 commit
 - trailer: fix comment/cut-line regression with opts->no_divider

 Fix to an already-graduated topic.

 source: <20240220010936.GA1793660@coredump.intra.peff.net>

--------------------------------------------------
[New Topics]

* as/option-names-in-messages (2024-02-16) 5 commits
 - revision.c: trivial fix to message
 - builtin/clone.c: trivial fix of message
 - builtin/remote.c: trivial fix of error message
 - transport-helper.c: trivial fix of error message
 - rebase: trivial fix of error message

 Error message updates.

 Expecting a reroll.
 source: <20240216101647.28837-1-ash@kambanaria.org>


* bb/completion-no-grep-into-awk (2024-02-16) 1 commit
  (merged to 'next' on 2024-02-19 at 8373f95424)
 + completion: use awk for filtering the config entries

 Some parts of command line completion script (in contrib/) have
 been micro-optimized.

 Will cook in 'next'.
 source: <20240216171046.927552-1-dev+git@drbeat.li>


* jb/doc-interactive-singlekey-do-not-need-perl (2024-02-19) 1 commit
  (merged to 'next' on 2024-02-19 at 9eda75497d)
 + doc: remove outdated information about interactive.singleKey

 Doc clean-up.

 Will cook in 'next'.
 source: <20240218030327.40453-1-julio.bacel@gmail.com>


* jk/t0303-clean (2024-02-19) 2 commits
  (merged to 'next' on 2024-02-19 at f57b65215f)
 + t0303: check that helper_test_clean removes all credentials
 + Merge branch 'ba/credential-test-clean-fix' into jk/t0303-clean
 (this branch uses ba/credential-test-clean-fix.)

 Test clean-up.

 Will cook in 'next'.
 source: <20240217045814.GA539459@coredump.intra.peff.net>


* km/mergetool-vimdiff-layout-fallback (2024-02-19) 1 commit
  (merged to 'next' on 2024-02-19 at bf7f086f05)
 + mergetools: vimdiff: use correct tool's name when reading mergetool config

 Variants of vimdiff learned to honor mergetool.<variant>.layout settings.

 Will cook in 'next'.
 source: <20240217162718.21272-1-kipras@kipras.org>


* mh/libsecret-empty-password-fix (2024-02-19) 1 commit
  (merged to 'next' on 2024-02-19 at b2e17695ca)
 + libsecret: retrieve empty password

 Credential helper based on libsecret (in contrib/) has been updated.

 Will cook in 'next'.
 source: <pull.1676.v2.git.git.1708375258296.gitgitgadget@gmail.com>


* ps/reflog-list (2024-02-19) 7 commits
  (merged to 'next' on 2024-02-19 at 6c491b5079)
 + builtin/reflog: introduce subcommand to list reflogs
 + refs: stop resolving ref corresponding to reflogs
 + refs: drop unused params from the reflog iterator callback
 + refs/files: sort reflogs returned by the reflog iterator
 + dir-iterator: support iteration in sorted order
 + dir-iterator: pass name to `prepare_next_entry_data()` directly
 + Merge branch 'ps/reftable-backend' into ps/reflog-list
 (this branch uses ps/reftable-backend.)

 "git reflog" learned a "list" subcommand that enumerates known reflogs.

 Will cook in 'next'.
 source: <cover.1708353264.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* jh/fsmonitor-icase-corner-case-fix (2024-02-14) 11 commits
 - t7527: update case-insenstive fsmonitor test
 - fsmonitor: refactor bit invalidation in refresh callback
 - fsmonitor: support case-insensitive non-directory events
 - fsmonitor: refactor non-directory callback
 - fsmonitor: support case-insensitive directory events
 - fsmonitor: refactor untracked-cache invalidation
 - fsmonitor: clarify handling of directory events in callback
 - fsmonitor: refactor refresh callback for non-directory events
 - fsmonitor: refactor refresh callback on directory events
 - t7527: add case-insensitve test for FSMonitor
 - name-hash: add index_dir_exists2()

 FSMonitor client code was confused when FSEvents were given in a
 different case on a case-insensitive filesystem, which has been
 corrected.

 Needs review.
 source: <pull.1662.git.1707857541.gitgitgadget@gmail.com>


* mh/credential-oauth-refresh-token-with-osxkeychain (2024-02-14) 1 commit
 - credential/osxkeychain: store new attributes

 OAuth refresh tokens and password expiry timestamps are now stored
 in the osxkeychain backend , just the way libsecret and wincred
 backends of the credential subsystem do.

 Needs testing.
 cf. <CAGJzqsmSzMqEG1OU9dH6CORV6=L7qUAFNJSmi41Lqrajf9mSew@mail.gmail.com>
 source: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>


* ps/reftable-iteration-perf-part2 (2024-02-14) 13 commits
 - reftable: allow inlining of a few functions
 - reftable/record: decode keys in place
 - reftable/record: reuse refname when copying
 - reftable/record: reuse refname when decoding
 - reftable/merged: avoid duplicate pqueue emptiness check
 - reftable/merged: circumvent pqueue with single subiter
 - reftable/merged: handle subiter cleanup on close only
 - reftable/merged: remove unnecessary null check for subiters
 - reftable/merged: make subiters own their records
 - reftable/merged: advance subiter on subsequent iteration
 - reftable/merged: make `merged_iter` structure private
 - reftable/pq: use `size_t` to track iterator index
 - Merge branch 'ps/reftable-iteration-perf' into ps/reftable-iteration-perf-part2
 (this branch uses ps/reftable-iteration-perf.)

 The code to iterate over refs with the reftable backend has seen
 some optimization.

 Needs review.
 source: <cover.1707895758.git.ps@pks.im>


* cp/t9146-use-test-path-helpers (2024-02-14) 1 commit
 - t9146: replace test -d/-e/-f with appropriate test_path_is_* function

 Test script clean-up.
 source: <pull.1661.v3.git.1707933048210.gitgitgadget@gmail.com>


* rj/tag-column-fix (2024-02-14) 1 commit
  (merged to 'next' on 2024-02-19 at 9aa52b4ffb)
 + tag: error when git-column fails

 "git tag --column" failed to check the exit status of its "git
 column" invocation, which has been corrected.

 Will cook in 'next'.
 source: <59df085d-0de8-45b1-9b8b-c69e91e56a1f@gmail.com>


* jc/am-whitespace-doc (2024-02-14) 1 commit
  (merged to 'next' on 2024-02-19 at 492f0f9174)
 + doc: add shortcut to "am --whitespace=<action>"

 "git am --help" now tells readers what actions are available in
 "git am --whitespace=<action>", in addition to saying that the
 option is passed through to the underlying "git apply".

 Will cook in 'next'.
 source: <xmqqplwyvqby.fsf@gitster.g>


* ba/credential-test-clean-fix (2024-02-15) 1 commit
  (merged to 'next' on 2024-02-19 at 290708b10a)
 + t/lib-credential: clean additional credential
 (this branch is used by jk/t0303-clean.)

 Test clean-up.

 Will cook in 'next'.
 source: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>


* js/cmake-with-test-tool (2024-02-15) 1 commit
 - cmake: let `test-tool` run the unit tests, too
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <cover.1706921262.git.steadmon@google.com>


* ps/ref-tests-update-even-more (2024-02-15) 7 commits
  (merged to 'next' on 2024-02-15 at 064b2b4089)
 + t7003: ensure filter-branch prunes reflogs with the reftable backend
 + t2011: exercise D/F conflicts with HEAD with the reftable backend
 + t1405: remove unneeded cleanup step
 + t1404: make D/F conflict tests compatible with reftable backend
 + t1400: exercise reflog with gaps with reftable backend
 + t0410: convert tests to use DEFAULT_REPO_FORMAT prereq
 + t: move tests exercising the "files" backend

 More tests that are marked as "ref-files only" have been updated to
 improve test coverage of reftable backend.

 Will cook in 'next'.
 source: <cover.1707985173.git.ps@pks.im>


* rs/use-xstrncmpz (2024-02-12) 1 commit
  (merged to 'next' on 2024-02-12 at 37e5f0fc14)
 + use xstrncmpz()

 Code clean-up.

 Will cook in 'next'.
 source: <954b75d0-1504-4f57-b34e-e770a4b7b3ea@web.de>


* kn/for-all-refs (2024-02-12) 6 commits
 - for-each-ref: add new option to include root refs
 - ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
 - refs: introduce `refs_for_each_include_root_refs()`
 - refs: extract out `loose_fill_ref_dir_regular_file()`
 - refs: introduce `is_pseudoref()` and `is_headref()`
 - Merge branch 'ps/reftable-backend' into kn/for-all-refs
 (this branch uses ps/reftable-backend.)

 "git for-each-ref" filters its output with prefixes given from the
 command line, but it did not honor an empty string to mean "pass
 everything", which has been corrected.

 Will merge to 'next'?
 source: <20240211183923.131278-1-karthik.188@gmail.com>


* kh/column-reject-negative-padding (2024-02-13) 2 commits
  (merged to 'next' on 2024-02-14 at c30c08e495)
 + column: guard against negative padding
 + column: disallow negative padding

 "git column" has been taught to reject negative padding value, as
 it would lead to nonsense behaviour including division by zero.

 Will cook in 'next'.
 source: <cover.1707839454.git.code@khaugsbakk.name>


* jc/no-lazy-fetch (2024-02-16) 3 commits
 - git: extend --no-lazy-fetch to work across subprocesses
 - git: document GIT_NO_REPLACE_OBJECTS environment variable
  (merged to 'next' on 2024-02-13 at 7c7136e547)
 + git: --no-lazy-fetch option

 "git --no-lazy-fetch cmd" allows to run "cmd" while disabling lazy
 fetching of objects from the promisor remote, which may be handy
 for debugging.
 source: <xmqq1q9mmtpw.fsf@gitster.g>
 source: <xmqqv86pslos.fsf@gitster.g>


* jc/t9210-lazy-fix (2024-02-08) 1 commit
  (merged to 'next' on 2024-02-13 at fb61ca2fba)
 + t9210: do not rely on lazy fetching to fail
 (this branch is used by cc/rev-list-allow-missing-tips.)

 Adjust use of "rev-list --missing" in an existing tests so that it
 does not depend on a buggy failure mode.

 Will cook in 'next'.
 source: <xmqq7cjemttr.fsf@gitster.g>


* gt/at-is-synonym-for-head-in-add-patch (2024-02-13) 2 commits
  (merged to 'next' on 2024-02-14 at cd901555d6)
 + add -p tests: remove PERL prerequisites
 + add-patch: classify '@' as a synonym for 'HEAD'

 Teach "git checkout -p" and friends that "@" is a synonym for
 "HEAD".

 Will cook in 'next'.
 source: <20240211202035.7196-2-shyamthakkar001@gmail.com>


* js/unit-test-suite-runner (2024-02-03) 7 commits
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

 Expecting a reroll.
 cf. <20240207225802.GA538110@coredump.intra.peff.net>
 source: <cover.1706921262.git.steadmon@google.com>


* ps/reftable-backend (2024-02-07) 3 commits
  (merged to 'next' on 2024-02-08 at ba1c4c52bb)
 + refs/reftable: fix leak when copying reflog fails
  (merged to 'next' on 2024-02-07 at 1115200acb)
 + ci: add jobs to test with the reftable backend
 + refs: introduce reftable backend
 (this branch is used by kn/for-all-refs and ps/reflog-list.)

 Integrate the reftable code into the refs framework as a backend.

 Will cook in 'next'.
 source: <cover.1707288261.git.ps@pks.im>


* cc/rev-list-allow-missing-tips (2024-02-14) 4 commits
 - rev-list: allow missing tips with --missing=[print|allow*]
 - t6022: fix 'test' style and 'even though' typo
 - oidset: refactor oidset_insert_from_set()
 - revision: clarify a 'return NULL' in get_reference()
 (this branch uses jc/t9210-lazy-fix.)

 "git rev-list --missing=print" have learned to optionally take
 "--allow-missing-tips", which allows the objects at the starting
 points to be missing.

 Will merge to 'next'?
 source: <20240214142513.4002639-1-christian.couder@gmail.com>


* ps/reftable-iteration-perf (2024-02-12) 7 commits
  (merged to 'next' on 2024-02-12 at 6abaf58383)
 + reftable/reader: add comments to `table_iter_next()`
 + reftable/record: don't try to reallocate ref record name
 + reftable/block: swap buffers instead of copying
 + reftable/pq: allocation-less comparison of entry keys
 + reftable/merged: skip comparison for records of the same subiter
 + reftable/merged: allocation-less dropping of shadowed records
 + reftable/record: introduce function to compare records by key
 (this branch is used by ps/reftable-iteration-perf-part2.)

 The code to iterate over refs with the reftable backend has seen
 some optimization.

 Will cook in 'next'.
 source: <cover.1707726654.git.ps@pks.im>


* js/merge-tree-3-trees (2024-02-07) 6 commits
 - cache-tree: avoid an unnecessary check
 - Always check `parse_tree*()`'s return value
 - t4301: verify that merge-tree fails on missing blob objects
 - merge-ort: do check `parse_tree()`'s return value
 - merge-tree: fail with a non-zero exit code on missing tree objects
  (merged to 'next' on 2024-01-30 at 0c77b04e59)
 + merge-tree: accept 3 trees as arguments

 "git merge-tree" has learned that the three trees involved in the
 3-way merge only need to be trees, not necessarily commits.

 Expecting a reroll.
 cf. <CAPig+cSs8MFkLasTULh7tybrFm7SwaT+JeR7HnXjh+-agCHYMw@mail.gmail.com>
 cf. <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
 source: <pull.1647.v2.git.1706474063109.gitgitgadget@gmail.com>
 source: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>


* rj/complete-reflog (2024-01-26) 4 commits
 - completion: reflog show <log-options>
 - completion: reflog with implicit "show"
 - completion: introduce __git_find_subcommand
 - completion: introduce __gitcomp_subcommand

 The command line completion script (in contrib/) learned to
 complete "git reflog" better.

 Needs review.
 source: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>


* ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-12) 2 commits
 - revision: implement `git log --merge` also for rebase/cherry-pick/revert
 - revision: ensure MERGE_HEAD is a ref in prepare_show_merge

 "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
 other kinds of *_HEAD pseudorefs.

 Expecting a reroll.
 cf. <790a3f11-5a8c-42f2-7a35-f2900c0299b4@gmail.com>
 cf. <8384d1dc-b6c4-b853-9bf6-3d7ccee86d12@gmail.com>
 source: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Needs review.
 cf. <xmqq4jej6i1b.fsf@gitster.g>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* la/trailer-api (2024-02-16) 9 commits
 - format_trailers_from_commit(): indirectly call trailer_info_get()
 - format_trailer_info(): move "fast path" to caller
 - format_trailers(): use strbuf instead of FILE
 - trailer_info_get(): reorder parameters
 - trailer: start preparing for formatting unification
 - trailer: move interpret_trailers() to interpret-trailers.c
 - trailer: prepare to expose functions as part of API
 - shortlog: add test for de-duplicating folded trailers
 - trailer: free trailer_info _after_ all related usage

 Code clean-up.
 source: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>


* cp/apply-core-filemode (2023-12-26) 3 commits
  (merged to 'next' on 2024-02-07 at 089a3fbb86)
 + apply: code simplification
 + apply: correctly reverse patch's pre- and post-image mode bits
 + apply: ignore working tree filemode when !core.filemode

 "git apply" on a filesystem without filemode support have learned
 to take a hint from what is in the index for the path, even when
 not working with the "--index" or "--cached" option, when checking
 the executable bit match what is required by the preimage in the
 patch.

 Will cook in 'next'.
 cf. <xmqqzfwb53a9.fsf@gitster.g>
 source: <20231226233218.472054-1-gitster@pobox.com>


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

 Will merge to and cook in 'next'?
 cf. <xmqqv86z5359.fsf@gitster.g>
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
