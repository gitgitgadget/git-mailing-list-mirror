Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E411183
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892035; cv=none; b=Q/p4LcVFYke+VPSfnCL7fiM+0uoRA22NMYJ4Gh3axBHz5OZSoiWLpjaWGKybxfjsdV7UBpWHjUF5plnQKWiNB0MKZWJSnbei3rAvOV4TfY5ACBm7gcaBFLjY2g/Ikap88SgX8CCFLAm4WuRgCCX6Ui36I8wqSi8fzC7RJA05vws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892035; c=relaxed/simple;
	bh=DMk+qNKxV5GZPHN8YJARVuMIHjqgbFotPQYJHr6Byqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eK8nzSWem0aEKarhY7T6ZqZFewXeLD359jEvVjw9vOZxB97z0LNAgzcpvIDQEI1QqNlv6YGDqzJRpAw4oa0QRyDfUVaGZuDgIJYTi2x1mH9DMhiqRa6ailHkgCUHL/WfKE+E/dz55V/Pn5P+jtkWTAlnJ8nAKQD96wxKJXy7QhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aT9q3+7N; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aT9q3+7N"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54B971CE2B4;
	Wed, 14 Feb 2024 01:27:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	Mk+qNKxV5GZPHN8YJARVuMIHjqgbFotPQYJHr6Byqc=; b=aT9q3+7NvYGuNoLSo
	tuT5WMESVie50hHmLAB7BHMnK+YO0SuakKrL34JDoOQV/Q5WnX9e7TjXECQd5BlU
	VVre+/9rSmOScSqMRGklmOLCjPvuz1X4xh0VP0qSrhxY5onoM2vvRm10rt/3ANKo
	yfCjhtdzW+qbowRxhIA+F4wdcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48E9D1CE2B3;
	Wed, 14 Feb 2024 01:27:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 929CC1CE2B1;
	Wed, 14 Feb 2024 01:27:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2024, #05; Tue, 13)
X-master-at: 2996f11c1d11ab68823f0939b6469dedc2b9ab90
X-next-at: d0d6417c1e3e625e276a94050391e37766a706c2
Date: Tue, 13 Feb 2024 22:27:07 -0800
Message-ID: <xmqqo7cjzhl0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 144F4D82-CB02-11EE-BAA1-25B3960A682E-77302942!pb-smtp2.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Git 2.44-rc1 will be tagged soon.  This round, let's try having just
one release candidate before the final, which is expected to be
tagged on or around 20th.

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

* bk/complete-bisect (2024-02-06) 7 commits
  (merged to 'next' on 2024-02-07 at ac95a595b7)
 + completion: bisect: recognize but do not complete view subcommand
 + completion: bisect: complete log opts for visualize subcommand
 + completion: new function __git_complete_log_opts
 + completion: bisect: complete missing --first-parent and - -no-checkout options
 + completion: bisect: complete custom terms and related options
 + completion: bisect: complete bad, new, old, and help subcommands
 + completion: tests: always use 'master' for default initial branch name

 Command line completion support (in contrib/) has been
 updated for "git bisect".
 source: <20240206215048.488344-1-britton.kerin@gmail.com>


* jc/bisect-doc (2024-02-07) 2 commits
  (merged to 'next' on 2024-02-07 at 914fa6775f)
 + bisect: document command line arguments for "bisect start"
 + bisect: document "terms" subcommand more fully

 Doc update.
 source: <20240207214436.538586-1-gitster@pobox.com>


* jc/sign-buffer-failure-propagation-fix (2024-02-07) 2 commits
  (merged to 'next' on 2024-02-08 at badb96b5ac)
 + ssh signing: signal an error with a negative return value
  (merged to 'next' on 2024-02-07 at 2cedac9d38)
 + tag: fix sign_buffer() call to create a signed tag

 A failed "git tag -s" did not necessarily result in an error
 depending on the crypto backend, which has been corrected.
 source: <xmqq4jek9ko1.fsf@gitster.g>
 source: <xmqq5xyzr6tm.fsf@gitster.g>


* pb/template-for-single-commit-pr (2024-02-06) 1 commit
  (merged to 'next' on 2024-02-07 at 2a56c8eb13)
 + .github/PULL_REQUEST_TEMPLATE.md: add a note about single-commit PRs

 Doc update.
 source: <pull.1665.v2.git.git.1707225612576.gitgitgadget@gmail.com>


* ps/reftable-multi-level-indices-fix (2024-02-01) 6 commits
  (merged to 'next' on 2024-02-07 at 143f47a079)
 + reftable: document reading and writing indices
 + reftable/writer: fix writing multi-level indices
 + reftable/writer: simplify writing index records
 + reftable/writer: use correct type to iterate through index entries
 + reftable/reader: be more careful about errors in indexed seeks
 + Merge branch 'jc/reftable-core-fsync' into ps/reftable-multi-level-indices-fix

 Write multi-level indices for reftable has been corrected.
 source: <cover.1706773842.git.ps@pks.im>


* ps/reftable-styles (2024-02-06) 9 commits
  (merged to 'next' on 2024-02-07 at 18670512e2)
 + reftable/record: improve semantics when initializing records
 + reftable/merged: refactor initialization of iterators
 + reftable/merged: refactor seeking of records
 + reftable/stack: use `size_t` to track stack length
 + reftable/stack: use `size_t` to track stack slices during compaction
 + reftable/stack: index segments with `size_t`
 + reftable/stack: fix parameter validation when compacting range
 + reftable: introduce macros to allocate arrays
 + reftable: introduce macros to grow arrays

 Code clean-up in various reftable code paths.
 source: <cover.1707200355.git.ps@pks.im>


* ps/report-failure-from-git-stash (2024-02-06) 1 commit
  (merged to 'next' on 2024-02-07 at a8a3f91f61)
 + builtin/stash: report failure to write to index

 "git stash" sometimes was silent even when it failed due to
 unwritable index file, which has been corrected.
 source: <cb098cf88cbfcbf7c4872f8887856629b909cb91.1707197653.git.ps@pks.im>


* pw/show-ref-pseudorefs (2024-02-07) 2 commits
  (merged to 'next' on 2024-02-08 at 7e9f850dba)
 + t1400: use show-ref to check pseudorefs
 + show-ref --verify: accept pseudorefs

 "git show-ref --verify" did not show things like "CHERRY_PICK_HEAD",
 which has been corrected.
 source: <pull.1654.git.1707324277.gitgitgadget@gmail.com>


* tb/multi-pack-reuse-experiment (2024-02-05) 2 commits
  (merged to 'next' on 2024-02-08 at e92afaa170)
 + pack-objects: enable multi-pack reuse via `feature.experimental`
 + t5332-multi-pack-reuse.sh: extract pack-objects helper functions

 Setting `feature.experimental` opts the user into multi-pack reuse
 experiment

 Will cook in 'next'.
 source: <cover.1707173415.git.me@ttaylorr.com>


* vd/for-each-ref-sort-with-formatted-timestamp (2024-02-07) 1 commit
  (merged to 'next' on 2024-02-08 at 5f86cad208)
 + ref-filter.c: sort formatted dates by byte value

 "git branch" and friends learned to use the formatted text as
 sorting key, not the underlying timestamp value, when the --sort
 option is used with author or committer timestamp with a format
 specifier (e.g., "--sort=creatordate:format:%H:%M:%S").
 source: <pull.1655.git.1707357439586.gitgitgadget@gmail.com>

--------------------------------------------------
[New Topics]

* ps/ref-tests-update-even-more (2024-02-09) 7 commits
 - t7003: ensure filter-branch prunes reflogs with the reftable backend
 - t2011: exercise D/F conflicts with HEAD with the reftable backend
 - t1405: remove unneeded cleanup step
 - t1404: make D/F conflict tests compatible with reftable backend
 - t1400: exercise reflog with gaps with reftable backend
 - t0410: enable tests with extensions with non-default repo format
 - t: move tests exercising the "files" backend

 More tests that are marked as "ref-files only" have been updated to
 improve test coverage of reftable backend.

 Needs review.
 source: <cover.1707463221.git.ps@pks.im>


* pw/gc-during-rebase (2024-02-09) 1 commit
  (merged to 'next' on 2024-02-12 at d54c5ce325)
 + prune: mark rebase autostash and orig-head as reachable

 The sequencer machinery does not use the ref API and instead
 records names of certain objects it needs for its correct operation
 in temporary files, which makes these objects susceptible to loss
 by garbage collection.  These temporary files have been added as
 starting points for reachability analysis to fix this.

 Will merge to 'master'.
 source: <pull.1656.v2.git.1707495579886.gitgitgadget@gmail.com>


* rs/receive-pack-remove-find-header (2024-02-12) 2 commits
  (merged to 'next' on 2024-02-12 at f1bf281e10)
 + receive-pack: use find_commit_header() in check_nonce()
 + receive-pack: use find_commit_header() in check_cert_push_options()

 Code simplification.

 Will merge to 'master'.
 source: <8b350cae-2180-4ac7-a911-d40043576445@web.de>


* cp/git-flush-is-an-env-bool (2024-02-13) 1 commit
  (merged to 'next' on 2024-02-13 at c0850f5675)
 + write-or-die: fix the polarity of GIT_FLUSH environment variable

 Recent conversion to allow more than 0/1 in GIT_FLUSH broke the
 mechanism by flipping what yes/no means by mistake, which has been
 corrected.

 Will merge to 'master' and then to 'maint'
 source: <xmqqbk8k5eo0.fsf@gitster.g>


* jc/unit-tests-make-relative-fix (2024-02-12) 1 commit
  (merged to 'next' on 2024-02-12 at 554eddef80)
 + unit-tests: do show relative file paths on non-Windows, too

 The mechanism to report the filename in the source code, used by
 the unit-test machinery, assumed that the compiler expanded __FILE__
 to the path to the source given to the $(CC), but some compilers
 give full path, breaking the output.  This has been corrected.

 Will merge to 'master'.
 source: <xmqqle7r9enn.fsf_-_@gitster.g>


* js/github-actions-update (2024-02-12) 2 commits
  (merged to 'next' on 2024-02-12 at f52de8b126)
 + ci(linux32): add a note about Actions that must not be updated
 + ci: bump remaining outdated Actions versions
 (this branch uses jc/github-actions-update.)

 Update remaining GitHub Actions jobs to avoid warnings against
 using deprecated version of Node.js.

 Will merge to 'master'.
 source: <pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>


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

 Needs review.
 source: <20240211183923.131278-1-karthik.188@gmail.com>


* kh/column-reject-negative-padding (2024-02-13) 2 commits
 - column: guard against negative padding
 - column: disallow negative padding

 "git column" has been taught to reject negative padding value, as
 it would lead to nonsense behaviour including division by zero.

 Will merge to 'next'?
 source: <cover.1707839454.git.code@khaugsbakk.name>

--------------------------------------------------
[Cooking]

* vn/rebase-with-cherry-pick-authorship (2024-02-08) 1 commit
  (merged to 'next' on 2024-02-09 at ed35d33595)
 + sequencer: unset GIT_CHERRY_PICK_HELP for 'exec' commands

 "git cherry-pick" invoked during "git rebase -i" session lost
 the authorship information, which has been corrected.

 Will merge to 'master'.
 source: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>


* jc/no-lazy-fetch (2024-02-13) 1 commit
 - git: --no-lazy-fetch option

 "git --no-lazy-fetch cmd" allows to run "cmd" while disabling lazy
 fetching of objects from the promisor remote, which may be handy
 for debugging.

 Will merge to 'next'.
 source: <xmqq1q9mmtpw.fsf@gitster.g>


* jc/t9210-lazy-fix (2024-02-08) 1 commit
 - t9210: do not rely on lazy fetching to fail

 Adjust use of "rev-list --missing" in an existing tests so that it
 does not depend on a buggy failure mode.

 Will merge to 'next'.
 source: <xmqq7cjemttr.fsf@gitster.g>


* gt/at-is-synonym-for-head-in-add-patch (2024-02-13) 2 commits
 - add -p tests: remove PERL prerequisites
 - add-patch: classify '@' as a synonym for 'HEAD'

 Teach "git checkout -p" and friends that "@" is a synonym for
 "HEAD".

 Will merge to 'next'?
 source: <20240211202035.7196-2-shyamthakkar001@gmail.com>


* js/unit-test-suite-runner (2024-02-03) 7 commits
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.

 Expecting a reroll.
 cf. <20240207225802.GA538110@coredump.intra.peff.net>
 source: <cover.1706921262.git.steadmon@google.com>


* js/check-null-from-read-object-file (2024-02-06) 1 commit
  (merged to 'next' on 2024-02-12 at 3a18369516)
 + Always check the return value of `repo_read_object_file()`

 The code paths that call repo_read_object_file() have been
 tightened to react to errors.

 Will merge to 'master'.
 source: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>


* ps/reftable-backend (2024-02-07) 3 commits
  (merged to 'next' on 2024-02-08 at ba1c4c52bb)
 + refs/reftable: fix leak when copying reflog fails
  (merged to 'next' on 2024-02-07 at 1115200acb)
 + ci: add jobs to test with the reftable backend
 + refs: introduce reftable backend
 (this branch is used by kn/for-all-refs.)

 Integrate the reftable code into the refs framework as a backend.

 Will cook in 'next'.
 source: <cover.1707288261.git.ps@pks.im>


* cc/rev-list-allow-missing-tips (2024-02-08) 4 commits
 - rev-list: allow missing tips with --missing=[print|allow*]
 - t6022: fix 'test' style and 'even though' typo
 - oidset: refactor oidset_insert_from_set()
 - revision: clarify a 'return NULL' in get_reference()

 "git rev-list --missing=print" have learned to optionally take
 "--allow-missing-tips", which allows the objects at the starting
 points to be missing.

 Comments?
 cf. <xmqq7cjemttr.fsf@gitster.g>
 source: <20240208135055.2705260-1-christian.couder@gmail.com>


* ps/reftable-iteration-perf (2024-02-12) 7 commits
  (merged to 'next' on 2024-02-12 at 6abaf58383)
 + reftable/reader: add comments to `table_iter_next()`
 + reftable/record: don't try to reallocate ref record name
 + reftable/block: swap buffers instead of copying
 + reftable/pq: allocation-less comparison of entry keys
 + reftable/merged: skip comparison for records of the same subiter
 + reftable/merged: allocation-less dropping of shadowed records
 + reftable/record: introduce function to compare records by key

 The code to iterate over refs with the reftable backend has seen
 some optimization.

 Will cook in 'next'.
 source: <cover.1707726654.git.ps@pks.im>


* jc/github-actions-update (2024-02-02) 3 commits
  (merged to 'next' on 2024-02-07 at 2cd6caaf70)
 + Merge branch 'jc/maint-github-actions-update' into jc/github-actions-update
 + GitHub Actions: update to github-script@v7
 + GitHub Actions: update to checkout@v4
 (this branch is used by js/github-actions-update.)

 Squelch node.js 16 deprecation warnings from GitHub Actions CI
 by updating actions/github-script and actions/checkout that use
 node.js 20.

 Will merge to 'master'.
 source: <20240202203935.1240458-1-gitster@pobox.com>


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


* pb/complete-config (2024-02-12) 4 commits
  (merged to 'next' on 2024-02-13 at d09f5e469a)
 + completion: add and use __git_compute_second_level_config_vars_for_section
 + completion: add and use __git_compute_first_level_config_vars_for_section
 + completion: complete 'submodule.*' config variables
 + completion: add space after config variable names also in Bash 3

 The command line completion script (in contrib/) learned to
 complete configuration variable names better.

 Will merge to 'master'.
 cf. <Zcs34kGTqTbIana6@tanuki>
 source: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>


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


* la/trailer-api (2024-02-06) 28 commits
 - trailer: introduce "template" term for readability
 - trailer_set_*(): put out parameter at the end
 - trailer: unify "--trailer ..." arg handling
 - trailer: deprecate "new_trailer_item" struct from API
 - trailer_add_arg_item(): drop new_trailer_item usage
 - trailer: add new helper functions to API
 - trailer: prepare to delete "parse_trailers_from_command_line_args()"
 - trailer: spread usage of "trailer_block" language
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - trailer: finish formatting unification
 - format_trailer_info(): avoid double-printing the separator
 - format_trailer_info(): teach it about opts->trim_empty
 - trailer: begin formatting unification
 - format_trailer_info(): append newline for non-trailer lines
 - format_trailer_info(): drop redundant unfold_value()
 - format_trailer_info(): use trailer_item objects
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
 source: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>


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

--------------------------------------------------
[Discarded]

* tb/pair-chunk-expect (2023-11-10) 8 commits
 . midx: read `OOFF` chunk with `pair_chunk_expect()`
 . midx: read `OIDL` chunk with `pair_chunk_expect()`
 . commit-graph: read `BIDX` chunk with `pair_chunk_expect()`
 . commit-graph: read `GDAT` chunk with `pair_chunk_expect()`
 . commit-graph: read `CDAT` chunk with `pair_chunk_expect()`
 . commit-graph: read `OIDL` chunk with `pair_chunk_expect()`
 . chunk-format: introduce `pair_chunk_expect()` helper
 . Merge branch 'jk/chunk-bounds-more' into HEAD

 Further code clean-up.

 Retracted for now.
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1699569246.git.me@ttaylorr.com>


* ak/color-decorate-symbols (2023-10-23) 7 commits
 - log: add color.decorate.pseudoref config variable
 - refs: exempt pseudorefs from pattern prefixing
 - refs: add pseudorefs array and iteration functions
 - log: add color.decorate.ref config variable
 - log: add color.decorate.symbol config variable
 - log: use designated inits for decoration_colors
 - config: restructure color.decorate documentation

 A new config for coloring.

 Ejected, to be rebuilt on updated kn/for-all-refs topic
 cf. <xmqqcyt853vz.fsf@gitster.g>
 source: <20231023221143.72489-1-andy.koppe@gmail.com>
