Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE522309
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709099109; cv=none; b=FqLI/7/j1XMJ2m5LNcphuhDO1w4iOxcSKexb6CRXjabKBOWABtpA3ia70KAGmIDzlp0Uke3wNBH0UdQA9FaZYPz0xQWqSrqY5KkBuEWUsOGrnD9DKo2Xk/qsphmWlRz0I3wV0qGjxggAaY8GCWRIeHugUYRdswYBKcT77xFGEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709099109; c=relaxed/simple;
	bh=CJCXm5rkpv7ebNFYxBZvF5FffR9g3OnUqTBgiDSoYNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwifp3yatrfglK2+3fG3fRQuDa2OYR1T86Jz3GPoJmbTogeRmYl4yJmZIsYRpeO0z4SymkCTsm2+ARca+Pw+OqnMFNPZmbUIXCgzFqs8iUaxJVyjMY3Py40mOmQZdxeb2fdpLns1f3Vu049xDKX/6BhWwpsmhcnuWj+iITfoGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mA7iV0UR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mA7iV0UR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31F3B1D6CAE;
	Wed, 28 Feb 2024 00:45:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	JCXm5rkpv7ebNFYxBZvF5FffR9g3OnUqTBgiDSoYNA=; b=mA7iV0URv5Pw6GiW6
	gDQtu8X0uNKvAgbg/cZBMZ8BFsptqWphRYmjGTvl/9fu5zXs/5wjmAj37SzouRg2
	YmInO75WoNFkhHpUh8gGSsan9NTFlUGr2dU3XgUBHi06+TpIG7mbPUPPj+dfvoI8
	X9Qgl3Uaj49qhqI9Qfnf8hpTCM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12B8E1D6CAD;
	Wed, 28 Feb 2024 00:45:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 396D51D6CA0;
	Wed, 28 Feb 2024 00:45:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2024, #09; Tue, 27)
X-master-at: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
X-next-at: dc8dd223a70561ef1480098663d61af5531a1f47
Date: Tue, 27 Feb 2024 21:44:59 -0800
Message-ID: <xmqqjzmpm9b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8456766E-D5FC-11EE-ABBC-25B3960A682E-77302942!pb-smtp2.pobox.com

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

* ba/credential-test-clean-fix (2024-02-15) 1 commit
  (merged to 'next' on 2024-02-19 at 290708b10a)
 + t/lib-credential: clean additional credential
 (this branch is used by jk/t0303-clean.)

 Test clean-up.
 source: <pull.1664.git.1707959036807.gitgitgadget@gmail.com>


* bb/completion-no-grep-into-awk (2024-02-16) 1 commit
  (merged to 'next' on 2024-02-19 at 8373f95424)
 + completion: use awk for filtering the config entries

 Some parts of command line completion script (in contrib/) have
 been micro-optimized.
 source: <20240216171046.927552-1-dev+git@drbeat.li>


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
 cf. <xmqqzfwb53a9.fsf@gitster.g>
 source: <20231226233218.472054-1-gitster@pobox.com>


* gt/at-is-synonym-for-head-in-add-patch (2024-02-13) 2 commits
  (merged to 'next' on 2024-02-14 at cd901555d6)
 + add -p tests: remove PERL prerequisites
 + add-patch: classify '@' as a synonym for 'HEAD'

 Teach "git checkout -p" and friends that "@" is a synonym for
 "HEAD".
 source: <20240211202035.7196-2-shyamthakkar001@gmail.com>


* jb/doc-interactive-singlekey-do-not-need-perl (2024-02-19) 1 commit
  (merged to 'next' on 2024-02-19 at 9eda75497d)
 + doc: remove outdated information about interactive.singleKey

 Doc clean-up.
 source: <20240218030327.40453-1-julio.bacel@gmail.com>


* jc/am-whitespace-doc (2024-02-14) 1 commit
  (merged to 'next' on 2024-02-19 at 492f0f9174)
 + doc: add shortcut to "am --whitespace=<action>"

 "git am --help" now tells readers what actions are available in
 "git am --whitespace=<action>", in addition to saying that the
 option is passed through to the underlying "git apply".
 source: <xmqqplwyvqby.fsf@gitster.g>


* jc/t9210-lazy-fix (2024-02-08) 1 commit
  (merged to 'next' on 2024-02-13 at fb61ca2fba)
 + t9210: do not rely on lazy fetching to fail
 (this branch is used by cc/rev-list-allow-missing-tips.)

 Adjust use of "rev-list --missing" in an existing tests so that it
 does not depend on a buggy failure mode.
 source: <xmqq7cjemttr.fsf@gitster.g>


* jk/t0303-clean (2024-02-19) 2 commits
  (merged to 'next' on 2024-02-19 at f57b65215f)
 + t0303: check that helper_test_clean removes all credentials
 + Merge branch 'ba/credential-test-clean-fix' into jk/t0303-clean
 (this branch uses ba/credential-test-clean-fix.)

 Test clean-up.
 source: <20240217045814.GA539459@coredump.intra.peff.net>


* kh/column-reject-negative-padding (2024-02-13) 2 commits
  (merged to 'next' on 2024-02-14 at c30c08e495)
 + column: guard against negative padding
 + column: disallow negative padding

 "git column" has been taught to reject negative padding value, as
 it would lead to nonsense behaviour including division by zero.
 source: <cover.1707839454.git.code@khaugsbakk.name>


* km/mergetool-vimdiff-layout-fallback (2024-02-19) 1 commit
  (merged to 'next' on 2024-02-19 at bf7f086f05)
 + mergetools: vimdiff: use correct tool's name when reading mergetool config

 Variants of vimdiff learned to honor mergetool.<variant>.layout settings.
 source: <20240217162718.21272-1-kipras@kipras.org>


* mh/libsecret-empty-password-fix (2024-02-19) 1 commit
  (merged to 'next' on 2024-02-19 at b2e17695ca)
 + libsecret: retrieve empty password

 Credential helper based on libsecret (in contrib/) has been updated
 to handle an empty password correctly.
 source: <pull.1676.v2.git.git.1708375258296.gitgitgadget@gmail.com>


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
 source: <cover.1707985173.git.ps@pks.im>


* ps/reftable-backend (2024-02-07) 3 commits
  (merged to 'next' on 2024-02-08 at ba1c4c52bb)
 + refs/reftable: fix leak when copying reflog fails
  (merged to 'next' on 2024-02-07 at 1115200acb)
 + ci: add jobs to test with the reftable backend
 + refs: introduce reftable backend
 (this branch is used by kn/for-all-refs and ps/reflog-list.)

 Integrate the reftable code into the refs framework as a backend.
 source: <cover.1707288261.git.ps@pks.im>


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
 source: <cover.1707726654.git.ps@pks.im>


* rj/tag-column-fix (2024-02-14) 1 commit
  (merged to 'next' on 2024-02-19 at 9aa52b4ffb)
 + tag: error when git-column fails

 "git tag --column" failed to check the exit status of its "git
 column" invocation, which has been corrected.
 source: <59df085d-0de8-45b1-9b8b-c69e91e56a1f@gmail.com>


* rs/use-xstrncmpz (2024-02-12) 1 commit
  (merged to 'next' on 2024-02-12 at 37e5f0fc14)
 + use xstrncmpz()

 Code clean-up.
 source: <954b75d0-1504-4f57-b34e-e770a4b7b3ea@web.de>

--------------------------------------------------
[New Topics]

* cw/git-std-lib (2024-02-22) 3 commits
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Needs review.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/merge-base-with-missing-commit (2024-02-27) 11 commits
 - repo_get_merge_bases_many_dirty(): pass on errors from `merge_bases_many()`
 - repo_get_merge_bases_many(): pass on errors from `merge_bases_many()`
 - get_octopus_merge_bases(): pass on errors from `merge_bases_many()`
 - repo_get_merge_bases(): pass on errors from `merge_bases_many()`
 - get_merge_bases_many_0(): pass on errors from `merge_bases_many()`
 - merge_bases_many(): pass on errors from `paint_down_to_common()`
 - commit-reach: start reporting errors in `paint_down_to_common()`
 - Prepare `paint_down_to_common()` for handling shallow commits
 - Start reporting missing commits in `repo_in_merge_bases_many()`
 - Prepare `repo_in_merge_bases_many()` to optionally expect missing commits
 - paint_down_to_common: plug two memory leaks

 Make sure failure return from merge_bases_many() is properly caught.

 Needs review.
 source: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>


* tb/multi-pack-verbatim-reuse (2024-02-23) 1 commit
  (merged to 'next' on 2024-02-23 at 8ee07f1da4)
 + Documentation/config/pack.txt: fix broken AsciiDoc mark-up

 Docfix.

 Will merge to 'master'.
 source: <72bb58e5f3b8a5a622394c5ff40426156e122580.1708720255.git.me@ttaylorr.com>


* eg/add-uflags (2024-02-24) 1 commit
 - add: use unsigned type for collection of bits

 Code clean-up practice.

 cf. <CAP8UFD3qR8E0gvUQtzzkLPWv4Db45kFS4pEqHKQr5siciVJ-zQ@mail.gmail.com>
 source: <20240224112638.72257-2-giganteeugenio2@gmail.com>


* jc/doc-compat-util (2024-02-27) 1 commit
  (merged to 'next' on 2024-02-27 at a838805d8c)
 + doc: clarify the wording on <git-compat-util.h> requirement

 Clarify wording in the CodingGuidelines that requires <git-compat-util.h>
 to be the first header file.

 Will merge to 'master'.
 source: <xmqqle76kdpr.fsf_-_@gitster.g>


* jc/no-include-of-compat-util-from-headers (2024-02-24) 1 commit
  (merged to 'next' on 2024-02-26 at 85857c09d9)
 + compat: drop inclusion of <git-compat-util.h>

 Header file clean-up.

 Will merge to 'master'.
 source: <xmqqwmqtli18.fsf@gitster.g>


* jk/reflog-special-cases-fix (2024-02-26) 3 commits
  (merged to 'next' on 2024-02-27 at e9fbe29d06)
 + read_ref_at(): special-case ref@{0} for an empty reflog
 + get_oid_basic(): special-case ref@{n} for oldest reflog entry
 + Revert "refs: allow @{n} to work with n-sized reflog"

 The logic to access reflog entries by date and number had ugly
 corner cases at the boundaries, which have been cleaned up.

 Will merge to 'master'.
 source: <20240226100010.GA1214708@coredump.intra.peff.net>


* jk/textconv-cache-outside-repo-fix (2024-02-26) 1 commit
  (merged to 'next' on 2024-02-26 at d4a81531ef)
 + userdiff: skip textconv caching when not in a repository

 The code incorrectly attempted to use textconv cache when asked,
 even when we are not running in a repository, which has been
 corrected.

 Will merge to 'master'.
 source: <20240226102729.GB2685773@coredump.intra.peff.net>


* js/remove-cruft-files (2024-02-26) 1 commit
  (merged to 'next' on 2024-02-26 at c6491c1c5d)
 + neue: remove a bogus empty file

 Remove an empty file that shouldn't have been added in the first
 place.

 Will merge to 'master'.
 source: <pull.1674.git.1708958183225.gitgitgadget@gmail.com>


* jt/commit-redundant-scissors-fix (2024-02-27) 2 commits
 - commit: unify logic to avoid multiple scissors lines when merging
 - commit: avoid redundant scissor line with --cleanup=scissors -v

 "git commit -v --cleanup=scissors" used to add the scissors line
 twice in the log message buffer, which has been corrected.

 Comments?
 source: <Zd2eLxPelxvP8FDk@localhost>


* pb/ort-make-submodule-conflict-message-an-advice (2024-02-26) 1 commit
  (merged to 'next' on 2024-02-27 at abe2ab5ed7)
 + merge-ort: turn submodule conflict suggestions into an advice

 When a merge conflicted at a submodule, merge-ort backend used to
 unconditionally give a lengthy message to suggest how to resolve
 it.  Now the message can be squelched as an advice message.

 Will merge to 'master'.
 source: <pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>


* rj/complete-worktree-paths-fix (2024-02-27) 1 commit
 - completion: fix __git_complete_worktree_paths

 The logic to complete the command line arguments to "git worktree"
 subcommand (in contrib/) has been updated to correctly honor things
 like "git -C dir" etc.

 Comments?
 source: <b8f09e20-d0d3-4e0b-afe2-31affeb61052@gmail.com>


* rs/fetch-simplify-with-starts-with (2024-02-26) 1 commit
  (merged to 'next' on 2024-02-27 at 84bba0a921)
 + fetch: convert strncmp() with strlen() to starts_with()

 Code simplification.

 Will merge to 'master'.
 source: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>


* rs/name-rev-with-mempool (2024-02-26) 2 commits
  (merged to 'next' on 2024-02-27 at b10b58ad64)
 + name-rev: use mem_pool_strfmt()
 + mem-pool: add mem_pool_strfmt()

 Many small allocations "git name-rev" makes have been updated to
 allocate from a mem-pool.

 Will merge to 'master'.
 source: <20240225113947.89357-1-l.s.r@web.de>


* rs/submodule-prefix-simplify (2024-02-26) 1 commit
  (merged to 'next' on 2024-02-27 at c6051f9f6b)
 + submodule: use strvec_pushf() for --submodule-prefix

 Code simplification.

 Will merge to 'master'.
 source: <8cd983fb-32b9-41c6-a9e7-a485b190488c@web.de>


* rs/t-ctype-simplify (2024-02-26) 3 commits
 - t-ctype: do one test per class and char
 - t-ctype: avoid duplicating class names
 - t-ctype: allow NUL anywhere in the specification string

 Code simplification to one unit-test program.

 Comments?
 source: <20240225112722.89221-1-l.s.r@web.de>


* sg/upload-pack-error-message-fix (2024-02-26) 1 commit
  (merged to 'next' on 2024-02-27 at 7cd7a4c4d8)
 + upload-pack: don't send null character in abort message to the client

 An error message from "git upload-pack", which responds to "git
 fetch" requests, had a trialing NUL in it, which has been
 corrected.

 Will merge to 'master'.
 source: <20240225183452.1939334-1-szeder.dev@gmail.com>


* ak/rebase-autosquash (2024-02-27) 1 commit
  (merged to 'next' on 2024-02-27 at 1a37c5ed5e)
 + rebase: fix typo in autosquash documentation

 Typofix.

 Will merge to 'master'.
 source: <pull.1676.git.1709015578890.gitgitgadget@gmail.com>


* ps/reftable-repo-init-fix (2024-02-27) 2 commits
 - refs/reftable: don't fail empty transactions in repo without HEAD
 - Merge branch 'ps/remote-helper-repo-initialization-fix' into ps/reftable-repo-init-fix
 (this branch uses ps/remote-helper-repo-initialization-fix.)

 Clear the fallout from a fix for 2.44 regression.

 Will merge to 'next'?
 source: <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>


* ps/remote-helper-repo-initialization-fix (2024-02-27) 1 commit
 - builtin/clone: allow remote helpers to detect repo
 (this branch is used by ps/reftable-repo-init-fix.)

 A custom remote helper no longer cannot access the newly created
 repository during "git clone", which is a regression in Git 2.44.
 This has been corrected.

 Will merge to 'next'?
 source: <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>


* pw/rebase-i-ignore-cherry-pick-help-environment (2024-02-27) 1 commit
 - rebase -i: stop setting GIT_CHERRY_PICK_HELP

 Code simplification by getting rid of code that sets an environment
 variable that is no longer used.

 Comments?
 source: <pull.1678.git.1709042783847.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ps/difftool-dir-diff-exit-code (2024-02-20) 1 commit
  (merged to 'next' on 2024-02-21 at a7bbef5a5f)
 + git-difftool--helper: honor `--trust-exit-code` with `--dir-diff`

 "git difftool --dir-diff" learned to honor the "--trust-exit-code"
 option; it used to always exit with 0 and signalled success.

 Will merge to 'master'.
 source: <0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.im>


* ds/doc-send-email-capitalization (2024-02-20) 1 commit
  (merged to 'next' on 2024-02-21 at c4aac4b993)
 + documentation: send-email: use camel case consistently

 Doc update.

 Will merge to 'master'.
 source: <88f1fe08c3047e14090957093ee8d98b0f60cb6c.1708467601.git.dsimic@manjaro.org>


* ja/docfixes (2024-02-20) 3 commits
  (merged to 'next' on 2024-02-21 at 6d778ca672)
 + doc: end sentences with full-stop
 + doc: close unclosed angle-bracket of a placeholder in git-clone doc
 + doc: git-rev-parse: enforce command-line description syntax

 Doc update.

 Will merge to 'master'.
 source: <pull.1670.git.1708468374.gitgitgadget@gmail.com>


* hs/rebase-not-in-progress (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at ce53f5243f)
 + rebase: make warning less passive aggressive

 Error message update.

 Will merge to 'master'.
 source: <pull.1669.v2.git.1708537097448.gitgitgadget@gmail.com>


* jw/remote-doc-typofix (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at fe95873cfa)
 + git-remote.txt: fix typo

 Docfix.

 Will merge to 'master'.
 source: <20240221083554.5255-1-jwilk@jwilk.net>


* ja/doc-placeholders-markup-rules (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at b6761ceeac)
 + doc: clarify the format of placeholders

 The way placeholders are to be marked-up in documentation have been
 specified; use "_<placeholder>_" to typeset the word inside a pair
 of <angle-brakets> emphasized.

 Will merge to 'master'.
 source: <pull.1671.git.1708550340094.gitgitgadget@gmail.com>


* jc/doc-add-placeholder-fix (2024-02-21) 1 commit
  (merged to 'next' on 2024-02-23 at 6950ff216b)
 + doc: apply the new placeholder rules to git-add documentation

 Practice the new mark-up rule for <placeholders> with "git add"
 documentation page.

 Will merge to 'master'.
 source: <xmqqbk89molz.fsf@gitster.g>


* as/option-names-in-messages (2024-02-16) 5 commits
 - revision.c: trivial fix to message
 - builtin/clone.c: trivial fix of message
 - builtin/remote.c: trivial fix of error message
 - transport-helper.c: trivial fix of error message
 - rebase: trivial fix of error message

 Error message updates.

 Expecting a reroll.
 source: <20240216101647.28837-1-ash@kambanaria.org>


* ps/reflog-list (2024-02-21) 9 commits
  (merged to 'next' on 2024-02-23 at 7413632239)
 + builtin/reflog: introduce subcommand to list reflogs
 + refs: stop resolving ref corresponding to reflogs
 + refs: drop unused params from the reflog iterator callback
 + refs: always treat iterators as ordered
 + refs/files: sort merged worktree and common reflogs
 + refs/files: sort reflogs returned by the reflog iterator
 + dir-iterator: support iteration in sorted order
 + dir-iterator: pass name to `prepare_next_entry_data()` directly
 + Merge branch 'ps/reftable-backend' into ps/reflog-list

 "git reflog" learned a "list" subcommand that enumerates known reflogs.

 Will merge to 'master'.
 source: <cover.1708518982.git.ps@pks.im>


* jh/fsmonitor-icase-corner-case-fix (2024-02-26) 14 commits
 - fsmonitor: support case-insensitive events
 - fsmonitor: refactor bit invalidation in refresh callback
 - fsmonitor: trace the new invalidated cache-entry count
 - fsmonitor: return invalided cache-entry count on non-directory event
 - fsmonitor: remove custom loop from non-directory path handler
 - fsmonitor: return invalidated cache-entry count on directory event
 - fsmonitor: move untracked-cache invalidation into helper functions
 - fsmonitor: refactor untracked-cache invalidation
 - dir: create untracked_cache_invalidate_trimmed_path()
 - fsmonitor: refactor refresh callback for non-directory events
 - fsmonitor: clarify handling of directory events in callback helper
 - fsmonitor: refactor refresh callback on directory events
 - t7527: add case-insensitve test for FSMonitor
 - name-hash: add index_dir_find()

 FSMonitor client code was confused when FSEvents were given in a
 different case on a case-insensitive filesystem, which has been
 corrected.

 Comments?
 source: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>


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

 The code to iterate over refs with the reftable backend has seen
 some optimization.

 Needs review.
 source: <cover.1707895758.git.ps@pks.im>


* cp/t9146-use-test-path-helpers (2024-02-14) 1 commit
  (merged to 'next' on 2024-02-21 at 0b8356ef33)
 + t9146: replace test -d/-e/-f with appropriate test_path_is_* function

 Test script clean-up.

 Will merge to 'master'.
 source: <pull.1661.v3.git.1707933048210.gitgitgadget@gmail.com>


* js/cmake-with-test-tool (2024-02-23) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* kn/for-all-refs (2024-02-23) 6 commits
  (merged to 'next' on 2024-02-27 at aef2406cca)
 + for-each-ref: add new option to include root refs
 + ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
 + refs: introduce `refs_for_each_include_root_refs()`
 + refs: extract out `loose_fill_ref_dir_regular_file()`
 + refs: introduce `is_pseudoref()` and `is_headref()`
 + Merge branch 'ps/reftable-backend' into kn/for-all-refs

 "git for-each-ref" filters its output with prefixes given from the
 command line, but it did not honor an empty string to mean "pass
 everything", which has been corrected.

 Will merge to 'master'.
 source: <20240223100112.44127-1-karthik.188@gmail.com>


* jc/no-lazy-fetch (2024-02-27) 3 commits
 - git: extend --no-lazy-fetch to work across subprocesses
 - git: document GIT_NO_REPLACE_OBJECTS environment variable
  (merged to 'next' on 2024-02-13 at 7c7136e547)
 + git: --no-lazy-fetch option

 "git --no-lazy-fetch cmd" allows to run "cmd" while disabling lazy
 fetching of objects from the promisor remote, which may be handy
 for debugging.

 Will merge to 'next'?
 source: <xmqq1q8xx38i.fsf@gitster.g>
 source: <xmqq1q9cl3xv.fsf@gitster.g>
 source: <xmqq1q9mmtpw.fsf@gitster.g>


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


* cc/rev-list-allow-missing-tips (2024-02-14) 4 commits
  (merged to 'next' on 2024-02-21 at 9b63eec23f)
 + rev-list: allow missing tips with --missing=[print|allow*]
 + t6022: fix 'test' style and 'even though' typo
 + oidset: refactor oidset_insert_from_set()
 + revision: clarify a 'return NULL' in get_reference()

 "git rev-list --missing=print" has learned to optionally take
 "--allow-missing-tips", which allows the objects at the starting
 points to be missing.

 Will merge to 'master'.
 source: <20240214142513.4002639-1-christian.couder@gmail.com>


* js/merge-tree-3-trees (2024-02-23) 7 commits
 - fill_tree_descriptor(): mark error message for translation
 - cache-tree: avoid an unnecessary check
 - Always check `parse_tree*()`'s return value
 - t4301: verify that merge-tree fails on missing blob objects
 - merge-ort: do check `parse_tree()`'s return value
 - merge-tree: fail with a non-zero exit code on missing tree objects
  (merged to 'next' on 2024-01-30 at 0c77b04e59)
 + merge-tree: accept 3 trees as arguments

 "git merge-tree" has learned that the three trees involved in the
 3-way merge only need to be trees, not necessarily commits.

 Will merge to 'next'?
 source: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
 source: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>


* rj/complete-reflog (2024-01-26) 4 commits
 - completion: reflog show <log-options>
 - completion: reflog with implicit "show"
 - completion: introduce __git_find_subcommand
 - completion: introduce __gitcomp_subcommand

 The command line completion script (in contrib/) learned to
 complete "git reflog" better.

 Expecting a reroll.
 cf. <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
 source: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>


* ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-27) 2 commits
 - revision: implement `git log --merge` also for rebase/cherry-pick/revert
 - revision: ensure MERGE_HEAD is a ref in prepare_show_merge

 "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
 other kinds of *_HEAD pseudorefs.

 Will merge to 'next'?
 source: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>


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

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* la/trailer-api (2024-02-16) 9 commits
  (merged to 'next' on 2024-02-21 at 631e28bbbc)
 + format_trailers_from_commit(): indirectly call trailer_info_get()
 + format_trailer_info(): move "fast path" to caller
 + format_trailers(): use strbuf instead of FILE
 + trailer_info_get(): reorder parameters
 + trailer: start preparing for formatting unification
 + trailer: move interpret_trailers() to interpret-trailers.c
 + trailer: prepare to expose functions as part of API
 + shortlog: add test for de-duplicating folded trailers
 + trailer: free trailer_info _after_ all related usage

 Code clean-up.

 Will merge to 'master'.
 source: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>


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

* mh/credential-oauth-refresh-token-with-osxkeychain (2024-02-14) 1 commit
 . credential/osxkeychain: store new attributes

 OAuth refresh tokens and password expiry timestamps are now stored
 in the osxkeychain backend , just the way libsecret and wincred
 backends of the credential subsystem do.

 Retracted.
 cf. <CAGJzqsknN_RmYeT0xcn4cTLcJhsxSOUC6ppRVepxMDf3day5Fw@mail.gmail.com>
 source: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>
