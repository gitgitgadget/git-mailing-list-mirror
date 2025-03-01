Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22533E1
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789938; cv=none; b=hFL0areid0zWoEJJy+s2o5kHif8X9Xr4whSQBZSxMHGb2kM8Cujd+dKwye9mZvk96cU7UVbJbMJ8kkcHjZaRv724xTaDPImu/CoOcXwCFFmgdAgx3p75+HEr8OCjf44zqw4uks34/i3ob9U7Y50M0ggNiNNwbSgICFCHoZPgg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789938; c=relaxed/simple;
	bh=z8qedM2H8WTFcBMLWvmvo20XG5RmMoaMneyS8vjUJEw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bfo4gg7xCAY1S9x4M/g4KuwvL5B00RNWsFoINucXOYtXYUkXzNRtHq6F7m1+Er7YQaUj93JCtelBJUJay9LbKGiOnT0K+77bOOQnhQC9+AOiFe9set1W44P1ZlN5cIrE/E7KcMLtXWyE1DfosBSCuWGKDjQywDb6VS8KH+lKSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xhRPuOyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u34ybXX5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xhRPuOyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u34ybXX5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E861E25400F6;
	Fri, 28 Feb 2025 19:45:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 19:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1740789933; x=1740876333; bh=XTIYndeB8V7wDk3lnyowj1jz+Ur+ePtl
	6R+rEhdQn1M=; b=xhRPuOyErVrqOLA0UCTwXLuOTWtJqpfdz35d+3SmoM/flh9a
	k08Sz6qt2rdeqatI2W81uPNioDMmHdju3FwT83QzDZoME4qzMg0nT5jwdulFUz/q
	45QXYpE5d/MQDvRFKmeU+0KpP9uB4UmLl/oCakcnZcUykOUhAEFqEJWvNRqlovev
	BAa+OSF9sqI+lWWSeOSXlydFU8zzyleZTMXpIOMi8zIXcSvccRMT7YChazxbTpVA
	WXUeR+W6WSJ9kGBi6Y+aWKqgI20JFBncsCgkiK2vuEZ57wMCJ1vz3/nsmq0SGgGx
	g/KvHuG4fro263pzan+BtqkBj7pU2Qrk8QRcuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740789933; x=
	1740876333; bh=XTIYndeB8V7wDk3lnyowj1jz+Ur+ePtl6R+rEhdQn1M=; b=u
	34ybXX5pbTZLz3630glFQfguXiuqnd1vmhu00qMk5RvkjHiVMtY/vUMpA+OTXssA
	F3n7QENVE0z8F9w7c44xtuOKVgZHMQzojIVGTTSo9uSsPUEpxVia3AXFsYS9LFdY
	1F1UA7usu8ws35KCLrFLOUVK7KNmYQWHrFHMaz8IJNWxNSqEZ8xhfyOvl916y25r
	G3oK98Dj/rbJuAXAoDGtTntI9c/CvVqxINaGyLB46U7WiDXvhz12P9CxB2pKlapq
	EU+JmN//qMo28SWUiBAKKn5kquN/vzfE7I+L8AgmNXIMGU0C+TJHjdtd0QHSqpWB
	fa5XtUFkB8jQcVDPRgqlg==
X-ME-Sender: <xms:rVjCZ5561LKbd0uIeeBPmAynr7-gcNL5OiNI8NieyDuS155hoNULZg>
    <xme:rVjCZ25FQGD2Zw33ItaaDZK1NukDQguZUigjzcgLsTNPGA6KH4uKurtOMMSjlGNgL
    MThIs2uXlRNfma7NQ>
X-ME-Received: <xmr:rVjCZwe8hhbV0S6FjwPtkQChyRoqL_hbVxKep-UPxe8bxBFKej6kbqpqH8hz0vJy2-QUpa3VAlokSwUPmpQni-vghzfDhVdRHwew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedttddvff
    eljeevhfejiefglefffeejgfefgeejleehkeffgeeivdekvdekieeludenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhorhdrtgiipdhgohhoghhlvghsohhurhgtvgdrtghomh
    dpghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifnheslhifnhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rVjCZyLFo1G9XyTfUp-PXQeJT_5JDZ7VtWg0Ga8sEQr7QyVR2Bsipw>
    <xmx:rVjCZ9I_c1lDFor46W59U_-dAbf7eTgD37p1oVET5hQoD_X03AwX4Q>
    <xmx:rVjCZ7x05xOzKlIRhMibLTP4zhh2aqHBwBIgeqQ8NVg_1IiYHXHTIg>
    <xmx:rVjCZ5ItW4RdpcAz3GM24V5j_noljG2gvG4VVzyWvoNWE1o-lvwZDg>
    <xmx:rVjCZ901K9toARSrA20H3-lp7DRAZK_MLbLKVqVORm8R4MWZXtt0u4SZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 19:45:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2025, #09; Fri, 28)
X-master-at: cb0ae672aeabefca9704477ea8018ac94f523970
X-next-at: 41875498b7944e2c73e7a8ed9b6a91c9d7001b12
Date: Fri, 28 Feb 2025 16:45:31 -0800
Message-ID: <xmqq7c591sus.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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

* bc/http-push-auth-netrc-fix (2025-02-24) 1 commit
  (merged to 'next' on 2025-02-26 at c2b83ec2e7)
 + http: allow using netrc for WebDAV-based HTTP protocol

 The netrc support (via the cURL library) for the HTTP transport has
 been re-enabled.
 source: <20250223015331.588161-2-sandals@crustytoothpaste.net>


* ek/mingw-rename-symlink (2025-02-21) 1 commit
  (merged to 'next' on 2025-02-24 at 8a9f3a5cdc)
 + compat/mingw: rename the symlink, not the target

 Symlink renaming fix.
 source: <pull.1864.git.1740139296483.gitgitgadget@gmail.com>


* jc/3.0-branches-remotes-update (2025-02-25) 1 commit
  (merged to 'next' on 2025-02-26 at 76db3e05d5)
 + BreakingChanges: clarify branches/ and remotes/

 Removal of ".git/branches" and ".git/remotes" support in the
 BreakingChanges document has been further clarified.
 source: <xmqqcyf5io61.fsf@gitster.g>


* jk/check-mailmap-wo-name-fix (2025-02-21) 1 commit
  (merged to 'next' on 2025-02-25 at d6d4e05ad1)
 + mailmap: fix check-mailmap with full mailmap line

 "git check-mailmap" segfault fix.
 source: <20250221-jk-fix-sendemail-mailinfo-v2-1-9aca7dc05dbb@gmail.com>


* kn/ref-migrate-skip-reflog (2025-02-21) 1 commit
  (merged to 'next' on 2025-02-25 at c402e09d08)
 + builtin/refs: add '--no-reflog' flag to drop reflogs

 "git refs migrate" can optionally be told not to migrate the reflog.
 source: <20250221100423.91075-1-karthik.188@gmail.com>


* pw/rebase-i-ff-empty-commit (2025-02-11) 1 commit
  (merged to 'next' on 2025-02-25 at 63db268d47)
 + rebase -i: reword empty commit after fast-forward

 "git rebase -i" failed to allow rewording an empty commit that has
 been fast-forwarded.
 source: <pull.1860.v2.git.1739289549299.gitgitgadget@gmail.com>


* rs/clear-commit-marks-optim (2025-02-24) 1 commit
  (merged to 'next' on 2025-02-26 at 1773f2a2ff)
 + commit: avoid parent list buildup in clear_commit_marks_many()

 A micro-optimization.
 source: <2bd2d71f-0ee6-405f-bec8-368406ca53c8@web.de>


* ua/os-version-capability (2025-02-19) 6 commits
  (merged to 'next' on 2025-02-24 at 89ad48db14)
 + agent: advertise OS name via agent capability
 + t5701: add setup test to remove side-effect dependency
 + version: extend get_uname_info() to hide system details
 + version: refactor get_uname_info()
 + version: refactor redact_non_printables()
 + version: replace manual ASCII checks with isprint() for clarity

 The value of "uname -s" is by default sent over the wire as a part
 of the "version" capability.
 source: <20250215155130.1756934-1-usmanakinyemi202@gmail.com>

--------------------------------------------------
[New Topics]

* lo/doc-merge-submodule-update (2025-02-25) 1 commit
  (merged to 'next' on 2025-02-27 at 8086c4ca60)
 + merge-strategies.adoc: detail submodule merge

 What happens to submodules during merge has been documented in a
 bit more detail.

 Will merge to 'master'.
 source: <20250225161800.8268-1-lucasseikioshiro@gmail.com>


* ps/maintenance-reflog-expire (2025-02-26) 6 commits
 - builtin/maintenance: introduce "reflog-expire" task
 - builtin/gc: split out function to expire reflog entries
 - builtin/reflog: make functions regarding `reflog_expire_options` public
 - builtin/reflog: stop storing per-reflog expiry dates globally
 - builtin/reflog: stop storing default reflog expiry dates globally
 - reflog: rename `cmd_reflog_expire_cb` to `reflog_expire_options`

 "git maintenance" learns a new task to expire reflog entries.

 Needs (real) review.
 source: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>


* ps/refname-avail-check-optim (2025-02-28) 16 commits
 - refs: reuse iterators when determining refname availability
 - refs/iterator: implement seeking for files iterators
 - refs/iterator: implement seeking for packed-ref iterators
 - refs/iterator: implement seeking for ref-cache iterators
 - refs/iterator: implement seeking for reftable iterators
 - refs/iterator: implement seeking for merged iterators
 - refs/iterator: provide infrastructure to re-seek iterators
 - refs/iterator: separate lifecycle from iteration
 - refs: stop re-verifying common prefixes for availability
 - refs/files: batch refname availability checks for initial transactions
 - refs/files: batch refname availability checks for normal transactions
 - refs/reftable: batch refname availability checks
 - refs: introduce function to batch refname availability checks
 - builtin/update-ref: skip ambiguity checks when parsing object IDs
 - object-name: allow skipping ambiguity checks in `get_oid()` family
 - object-name: introduce `repo_get_oid_with_flags()`

 The code paths to check whether a refname X is available (by seeing
 if another ref X/Y exists, etc.) have been optimized.

 Needs review.
 source: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>


* ps/build-meson-fixes (2025-02-27) 1 commit
  (merged to 'next' on 2025-02-28 at 7e8431ab25)
 + gitlab-ci: fix "msvc-meson" test job succeeding despite test failures

 CI fix.

 Will merge to 'master'.
 source: <20250227-b4-pks-gitlab-ci-fix-msvc-meson-tests-v1-1-0420abde3807@pks.im>


* tb/multi-cruft-paxk-refresh-fix (2025-02-27) 2 commits
 - builtin/pack-objects.c: freshen objects from existing cruft packs
 - builtin/repack.c: simplify cruft pack aggregation

 Certain "cruft" objects would have never been refreshed when there
 are multiple cruft packs in the repository, which has been
 corrected.

 Expecting a (hopefully minor and final) reroll.
 cf. <Z8Dvr3F1t7JKuNQf@nand.local>
 source: <cover.1740680964.git.me@ttaylorr.com>

--------------------------------------------------
[Cooking]

* jk/zlib-inflate-fixes (2025-02-25) 10 commits
 - unpack_loose_rest(): rewrite return handling for clarity
 - unpack_loose_rest(): simplify error handling
 - unpack_loose_rest(): never clean up zstream
 - unpack_loose_rest(): avoid numeric comparison of zlib status
 - unpack_loose_header(): avoid numeric comparison of zlib status
 - git_inflate(): skip zlib_post_call() sanity check on Z_NEED_DICT
 - unpack_loose_header(): fix infinite loop on broken zlib input
 - unpack_loose_header(): report headers without NUL as "bad"
 - unpack_loose_header(): simplify next_out assignment
 - loose_object_info(): BUG() on inflating content with unknown type

 Fix our use of zlib corner cases.

 Will merge to 'next'?
 source: <20250225062518.GA1293854@coredump.intra.peff.net>


* cc/signed-fast-export-import (2025-02-24) 6 commits
 - fast-export, fast-import: add support for signed-commits
 - fast-export: do not modify memory from get_commit_buffer
 - git-fast-export.txt: clarify why 'verbatim' may not be a good idea
 - fast-export: rename --signed-tags='warn' to 'warn-verbatim'
 - fast-export: fix missing whitespace after switch
 - git-fast-import.adoc: add missing LF in the BNF

 "git fast-export | git fast-import" learns to deal with commit and
 tag objects with embedded signatures a bit better.

 Needs review.
 source: <20250224142744.279643-1-christian.couder@gmail.com>


* dk/test-aggregate-results-paste-fix (2025-02-24) 1 commit
  (merged to 'next' on 2025-02-27 at cf8ba1cde5)
 + t/aggregate-results: fix paste(1) invocation

 The use of "paste" command for aggregating the test results have
 been corrected.

 Will merge to 'master'.
 source: <20250224192724.7625-1-ben.knoble+github@gmail.com>


* sk/unit-test-oid (2025-02-25) 4 commits
 - t/unit-tests: convert oidtree test to use clar test framework
 - t/unit-tests: convert oidmap test to use clar test framework
 - t/unit-tests: convert oid-array test to use clar test framework
 - t/unit-tests: implement clar specific oid helper functions

 Convert a few unit tests to the clar framework.

 Comments?
 source: <20250225101044.84210-1-kuforiji98@gmail.com>


* ps/meson-contrib-bits (2025-02-20) 10 commits
  (merged to 'next' on 2025-02-27 at ef18273a2d)
 + ci: exercise credential helpers
 + ci: fix propagating UTF-8 test locale in musl-based Meson job
 + meson: wire up static analysis via Coccinelle
 + meson: wire up git-contacts(1)
 + meson: wire up credential helpers
 + contrib/credential: fix compilation of "osxkeychain" helper
 + contrib/credential: fix compiling "libsecret" helper
 + contrib/credential: fix compilation of wincred helper with MSVC
 + contrib/credential: fix "netrc" tests with out-of-tree builds
 + GIT-BUILD-OPTIONS: propagate project's source directory

 Update meson-based build procedure to cover contrib/ and other
 places as well.

 Will merge to 'master'.
 source: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>


* ms/merge-recursive-string-list-micro-optimization (2025-02-13) 1 commit
  (merged to 'next' on 2025-02-27 at 839741ad40)
 + merge-recursive: optimize time complexity for process_renames

 Rename processing in the recursive merge backend has seen a micro
 optimization.

 Will merge to 'master'.
 source: <20250214044129.15282-1-meetsoni3017@gmail.com>


* pb/doc-follow-remote-head (2025-02-14) 2 commits
 - config/remote.txt: improve wording for 'remote.<name>.followRemoteHEAD'
 - config/remote.txt: reunite 'severOption' description paragraphs

 source: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>


* jt/diff-pairs (2025-02-26) 3 commits
 - builtin/diff-pairs: allow explicit diff queue flush
 - builtin: introduce diff-pairs command
 - diff: return diff_filepair from diff queue helpers

 A post-processing filter for "diff --raw" output has been
 introduced.

 Comments?
 source: <20250225233925.1345086-1-jltobler@gmail.com>


* ps/path-sans-the-repository (2025-02-28) 16 commits
  (merged to 'next' on 2025-02-28 at 41875498b7)
 + path: adjust last remaining users of `the_repository`
 + environment: move access to "core.sharedRepository" into repo settings
 + environment: move access to "core.hooksPath" into repo settings
 + repo-settings: introduce function to clear struct
 + path: drop `git_path()` in favor of `repo_git_path()`
 + rerere: let `rerere_path()` write paths into a caller-provided buffer
 + path: drop `git_common_path()` in favor of `repo_common_path()`
 + worktree: return allocated string from `get_worktree_git_dir()`
 + path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
 + path: drop `git_pathdup()` in favor of `repo_git_path()`
 + path: drop unused `strbuf_git_path()` function
 + path: refactor `repo_submodule_path()` family of functions
 + submodule: refactor `submodule_to_gitdir()` to accept a repo
 + path: refactor `repo_worktree_path()` family of functions
 + path: refactor `repo_git_path()` family of functions
 + path: refactor `repo_common_path()` family of functions

 The path.[ch] API takes an explicit repository parameter passed
 throughout the callchain, instead of relying on the_repository
 singleton instance.

 Will merge to 'master'.
 source: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>


* ib/diff-S-G-with-longhand (2025-02-12) 10 commits
 - diff: docs: Use --patch-{grep,modifies} over -G/-S
 - diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
 - diff: test: Use --patch-{grep,modifies} over -G/-S
 - completion: Support --patch-{grep,modifies}
 - diff: --patch-{grep,modifies} arg names for -G and -S
 - docs: gitdiffcore: -G and -S: Use regex/string placeholders
 - diff: short help: Add -G and --pickaxe-grep
 - diff: short help: Correct -S description
 - diff: -G description: Correct copy/paste error
 - t/t4209-log-pickaxe: Naming typo: -G takes a regex

 The commands in the "diff" family learned longhands for "-S" and
 "-G" options.

 The core part looked mostly good.
 source: <20250212032657.1807939-1-illia.bobyr@gmail.com>


* ps/reftable-windows-unlink-fix (2025-02-18) 2 commits
 - reftable: ignore file-in-use errors when unlink(3p) fails on Windows
 - Merge branch 'ps/reftable-sans-compat-util' into ps/reftable-windows-unlink-fix
 (this branch uses ps/reftable-sans-compat-util.)

 Portability fix.

 Waiting for the base topic to settle.
 source: <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>


* ps/build-meson-fixes-0130 (2025-02-26) 14 commits
  (merged to 'next' on 2025-02-27 at 55aaa8c63e)
 + gitlab-ci: restrict maximum number of link jobs on Windows
 + meson: consistently use custom program paths to resolve programs
 + meson: fix overwritten `git` variable
 + meson: prevent finding sed(1) in a loop
 + meson: improve handling of `sane_tool_path` option
 + meson: improve PATH handling
 + meson: drop separate version library
 + meson: stop linking libcurl into all executables
 + meson: introduce `libgit_curl` dependency
 + meson: simplify use of the common-main library
 + meson: inline the static 'git' library
 + meson: fix OpenSSL fallback when not explicitly required
 + meson: fix exec path with enabled runtime prefix
 + Merge branch 'ps/build-meson-fixes' into ps/build-meson-fixes-0130

 Assorted fixes and improvements to the build procedure based on
 meson.

 Will merge to 'master'.
 source: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>


* ps/reftable-sans-compat-util (2025-02-18) 18 commits
 - Makefile: skip reftable library for Coccinelle
 - reftable: decouple from Git codebase by pulling in "compat/posix.h"
 - git-compat-util.h: split out POSIX-emulating bits
 - compat/mingw: split out POSIX-related bits
 - reftable/basics: introduce `REFTABLE_UNUSED` annotation
 - reftable/basics: stop using `SWAP()` macro
 - reftable/stack: stop using `sleep_millisec()`
 - reftable/system: introduce `reftable_rand()`
 - reftable/reader: stop using `ARRAY_SIZE()` macro
 - reftable/basics: provide wrappers for big endian conversion
 - reftable/basics: stop using `st_mult()` in array allocators
 - reftable: stop using `BUG()` in trivial cases
 - reftable/record: don't `BUG()` in `reftable_record_cmp()`
 - reftable/record: stop using `BUG()` in `reftable_record_init()`
 - reftable/record: stop using `COPY_ARRAY()`
 - reftable/blocksource: stop using `xmmap()`
 - reftable/stack: stop using `write_in_full()`
 - reftable/stack: stop using `read_in_full()`
 (this branch is used by ps/reftable-windows-unlink-fix.)

 Make the code in reftable library less reliant on the service
 routines it used to borrow from Git proper, to make it easier to
 use by external users of the library.

 Waiting for Acks, especially for Windows bits?
 source: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>


* sj/ref-consistency-checks-more (2025-02-27) 9 commits
 - builtin/fsck: add `git refs verify` child process
 - packed-backend: check whether the "packed-refs" is sorted
 - packed-backend: add "packed-refs" entry consistency check
 - packed-backend: check whether the refname contains NUL characters
 - packed-backend: add "packed-refs" header consistency check
 - packed-backend: check if header starts with "# pack-refs with: "
 - packed-backend: check whether the "packed-refs" is regular file
 - builtin/refs: get worktrees without reading head information
 - t0602: use subshell to ensure working directory unchanged

 "git fsck" becomes more careful when checking the refs.

 Comments?
 source: <Z8CMx7O19PMs9sVY@ArchLinux>


* jc/doc-attr-tree (2024-12-14) 1 commit
 - doc: give attr.tree a bit more visibility

 Make sure that "git --attr-source=X", GIT_ATTR_SOURCE, and
 attr.tree configuration variables appear at the same places in the
 documentation.

 On hold.
 cf. <20241216111112.GA2201417@coredump.intra.peff.net>
 source: <xmqq5xnladwi.fsf@gitster.g>


* cc/lop-remote (2025-02-18) 3 commits
 - doc: add technical design doc for large object promisors
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2

 Large-object promisor protocol extension.

 Comments?
 source: <20250218113204.2847463-1-christian.couder@gmail.com>


* tb/incremental-midx-part-2 (2024-11-20) 15 commits
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

 Incrementally updating multi-pack index files.

 Needs review.
 source: <cover.1732054032.git.me@ttaylorr.com>


* ej/cat-file-remote-object-info (2025-02-24) 8 commits
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing
 - t1006: split test utility functions into new "lib-cat-file.sh"
 - cat-file: add declaration of variable i inside its for loop
 - git-compat-util: add strtoul_ul() with error handling

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.
 source: <20250221190451.12536-1-eric.peijian@gmail.com>
