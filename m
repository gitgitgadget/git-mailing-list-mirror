Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD65233138
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534690; cv=none; b=pj/WdKDeXiwqQjmRdnh7f7Z1hkUO//ZxVR1CI1q5QTp7r4EHhhNljQLxXJtcH7/3Jzkf2/KVcdLl63/fsnChHWevo1bu6Zr27Ov1WPIy2JkZra08aM3aI30l1A5doHks4aZrsupedk30sGf3Qul2BEowKvoFjWY6TdNsDYKYbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534690; c=relaxed/simple;
	bh=EmHU2OxOoS9+twJ90lCnM2tGHyhZ9hmbuQRFQPYHnM4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=htmdQHVxCsTJ5wBAS7p2CvptE1oykmzDx3/bm3pi90Khjxufi2uujNnDmsAhlCWts/CPxOYlhLO5GUWTsDi3qECxfhLLyXvdlwH09GRpuLcNRg0U2WVr1jnOcx5YKxHTRQ2Jh9M6L8Kz0QOrC42F9BZPqHz/G1oU1iWHqoGAzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uuhBaf73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kik3cgSr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uuhBaf73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kik3cgSr"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 255EB2540199;
	Fri, 10 Jan 2025 13:44:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 10 Jan 2025 13:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1736534685; x=1736621085; bh=9z57nc7c1saK1RNf+nBajRvg1+jjh9H8
	h7AVQuHkq8k=; b=uuhBaf73BhxiFTZ3muo0s9zkItJHUyCYuiBFewZxHMxq97tV
	LjptGwlZPFZR3n1NuPS25Bi0Ar1bOnlHklqy5YTA3XScUXHfz2lHewjTyL1i1bVd
	PsQvmhGfhIxChiTblplsbwe6vUY4RPVmvGebHG99yg1mir8Awnlxj5BIPDA/fnQn
	NJDIJcEj2Gk07Pg9GEtaboiqwda4pOgDGOZD2O48NW8hTtrKg6SeZyb/d73bqKnL
	uHKs4VH95vyg4ynIvDovB+Wkr9OmkBmMY9cU2R7wFs43lz+XXl1GuiEFz5sMGwXU
	6pf3w4XfKJSGpdOI750PKWHQ9fI0xpJLYGEC9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736534685; x=
	1736621085; bh=9z57nc7c1saK1RNf+nBajRvg1+jjh9H8h7AVQuHkq8k=; b=K
	ik3cgSrBrUVayJbnRXqUAAP3qX9j0T3J2DDvbDpYH+zkL5TROGBK2SBgfLVTJfmY
	uQpxbUOizZfT+smhRPTDcJcG3yMNJ3KBM3QLWbzg6CsSZcvBh3/dN87yibsht61Q
	2o6MMkVFl4qelKTurah1YK/4yJs62fyPMpcuoEs1tD6wVmcpcPmTs6up9dmPSWD6
	nq3vW9lCzUpnkgAC7CY0boFlC0R4jy3UQjuMys/17YoOyS7WRxFNxCpIy81rxU3c
	Q/E48uOUUcNIBVORTFCshY+OPuZV35bCvrrz2yVVsu7i+Dz1VBJSDmGEawJfVmmu
	9W3Rz0tueB6JmBPoC12mA==
X-ME-Sender: <xms:nWqBZ_LquNn-KegVIGAHgl7t6dGFLcqYiCCo-6WsNLBfcNBQjHFRAg>
    <xme:nWqBZzKR35HyrEpq-svxuad2mz40Ya3nduNdLfPB5d8P__wDkL0dnxMN2ukEtlryW
    Wt39XtlZ32j1bR-dw>
X-ME-Received: <xmr:nWqBZ3sWHCYVbPYdfIyZVY5bkqZx5cKbCKZbbVT_bXj6AW3OBKPpHN5Yrc34Lp__EJWAL4mMk2v_8QeeP9-r-c5qlsrJAWmz8Giq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtff
    homhgrihhnucdlgeelmdenucfjughrpefhvffufffkfgggtgesthdtredttdertdenucfh
    rhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnheptdetjedugfejtdfgudeffeejkeelkeeiuddutefh
    jeeigedtleekveeigffgieetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohhrrd
    gtiidpghhoohhglhgvshhouhhrtggvrdgtohhmpdhgihhthhhusgdrtghomhdpghhithhl
    rggsrdgtohhmpdifohhrughprhgvshhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlfihnsehlfihnrdhnvght
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nWqBZ4aAbx6v8UWxpCV9dWdQTpt9ETQjfvnuHvFrqddtbHjzMASZRQ>
    <xmx:nWqBZ2bhvQ73XOOfxsUXJyrJS7j-YQdtRdhWhatXl69KLsDENNyKvg>
    <xmx:nWqBZ8A4SZ7lYh0QZfKv-dmYd9BlcfFOCZE7_oYLoH3Q8M0qpYoplA>
    <xmx:nWqBZ0Y7x3Ez740NC4OBytKX_hVmueuDnSR8ZCZ0k0QO-b__BTJ7_Q>
    <xmx:nWqBZ2H2FzufM732aCbUq62WYeUVFlt7zmeWjgBYc6EfrFF6xT0Hbojd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 13:44:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2025, #03; Fri, 10)
X-master-at: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
X-next-at: d3603152ad074a50ed6022133a71b91a16cc7baf
Date: Fri, 10 Jan 2025 10:44:44 -0800
Message-ID: <xmqqwmf25x0j.fsf@gitster.g>
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

Git 2.48.0 has been tagged.  Thank you, everybody, for your hard
work.

There are quite a few topics that are listed here but without much
review activities.  I'll review the notes below with list archive
myself to see which ones are truly stale and discard them, maybe
later next week.

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

* bf/fetch-set-head-config (2025-01-06) 1 commit
  (merged to 'next' on 2025-01-06 at 841c3a38a6)
 + fetch: fix erroneous set_head advice message

 A hotfix on an advice message added during this cycle.
 source: <20250105161017.210412-1-bence@ferdinandy.com>


* js/git-version-gen-update (2025-01-10) 1 commit
  (merged to 'next' on 2025-01-10 at e4c4bf6b44)
 + GIT-VERSION-GEN: allow it to be run in parallel

 Build regression fix.
 
 source: <pull.1850.v2.git.1736509717426.gitgitgadget@gmail.com>


* js/reftable-realloc-errors-fix (2025-01-08) 1 commit
  (merged to 'next' on 2025-01-08 at 5efe7e2f5d)
 + t-reftable-basics: allow for `malloc` to be `#define`d

 Last-minute fix to a recent update.
 source: <pull.1848.git.1736352005578.gitgitgadget@gmail.com>


* ps/build-sign-compare (2025-01-10) 2 commits
  (merged to 'next' on 2025-01-10 at 8b4d916cbf)
 + builtin/blame: fix out-of-bounds write with blank boundary commits
 + builtin/blame: fix out-of-bounds read with excessive `--abbrev`

 Last-minute fix for a regression in "git blame --abbrev=<length>"
 when insane <length> is specified; we used to correctly cap it to
 the hash output length but broke it during the cycle.
 
 source: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>


* sj/meson-perl-build-fix (2025-01-08) 1 commit
  (merged to 'next' on 2025-01-08 at cce5ed7397)
 + meson: fix perl dependencies

 The build procedure in "meson" for the "perl/" hierarchy lacked
 necessary dependencies, which has been corrected.
 source: <371571630df201b0b0c680f6437decc6c60ecd3b.1736307757.git.sam@gentoo.org>

--------------------------------------------------
[New Topics]

* dk/zsh-config-completion-fix (2025-01-06) 1 commit
  (merged to 'next' on 2025-01-10 at efba7d534c)
 + completion: repair config completion for Zsh

 Completion script updates for zsh

 Will cook in 'next'.
 source: <pull.1860.v3.git.git.1736200026899.gitgitgadget@gmail.com>


* en/object-name-with-funny-refname-fix (2025-01-06) 2 commits
 - object-name: be more strict in parsing describe-like output
 - object-name: fix resolution of object names containing curly braces

 Extended SHA-1 expression parser did not work well when a branch
 with an unusual name (e.g. "foo{bar") is involved.

 Expecting a reroll.
 cf. <CABPp-BHyWgu47mCDH_f_MkS4CMGh_OtX4K-YGFsB-fZvvaNJPQ@mail.gmail.com>
 source: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>


* sj/ref-consistency-checks-more (2025-01-06) 10 commits
 - builtin/fsck: add `git refs verify` child process
 - packed-backend: check whether the "packed-refs" is sorted
 - packed-backend: add check for object consistency
 - packed-backend: create "fsck_packed_ref_entry" to store parsing info
 - packed-backend: add "packed-refs" entry consistency check
 - packed-backend: check whether the refname contains NULL binaries
 - packed-backend: add "packed-refs" header consistency check
 - packed-backend: check whether the "packed-refs" is regular
 - builtin/refs.h: get worktrees without reading head info
 - files-backend: add object check for regular ref

 "git fsck" becomes more careful when checking the refs.
 source: <Z3qNUizvHJLgMx1y@ArchLinux>


* jk/lsan-race-ignore-false-positive (2025-01-07) 3 commits
  (merged to 'next' on 2025-01-09 at 3d7cd910b5)
 + test-lib: add a few comments to LSan log checking
 + test-lib: simplify lsan results check
 + test-lib: invert return value of check_test_results_san_file_empty

 The code to check LSan results has been simplified and made more
 robust.

 Will cook in 'next'.
 source: <20250107070409.GA584456@coredump.intra.peff.net>


* jk/t7407-use-test-grep (2025-01-07) 1 commit
  (merged to 'next' on 2025-01-09 at 1d584ee42d)
 + t7407: use test_grep

 Test clean-up.

 Will cook in 'next'.
 source: <20250107071824.GA594237@coredump.intra.peff.net>


* jt/fsck-skiplist-parse-fix (2025-01-07) 1 commit
  (merged to 'next' on 2025-01-09 at d08b30fd78)
 + fsck: reject misconfigured fsck.skipList

 A misconfigured "fsck.skiplist" configuration variable was not
 diagnosed as an error, which has been corrected.

 Will cook in 'next'.
 source: <20250107162914.3756968-2-jltobler@gmail.com>


* ps/reftable-get-random-fix (2025-01-07) 2 commits
  (merged to 'next' on 2025-01-09 at bc024b7a45)
 + reftable/stack: accept insecure random bytes
 + wrapper: allow generating insecure random bytes

 The code to compute "unique" name used git_rand() which can fail or
 get stuck; the callsite does not require cryptographic security.
 Introduce the "insecure" mode and use it appropriately.

 Will cook in 'next'.
 source: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>


* mh/credential-cache-authtype-request-fix (2025-01-09) 1 commit
 - credential-cache: respect authtype capability

 The "cache" credential back-end did not handle authtype correctly,
 which has been corrected.
 source: <pull.1842.v5.git.1736462721156.gitgitgadget@gmail.com>


* mh/gitattr-doc-markup-fix (2025-01-07) 1 commit
  (merged to 'next' on 2025-01-10 at 9b8f84ebe2)
 + docs: fix typesetting of merge driver placeholders

 Doc markup fix.

 Will cook in 'next'.
 source: <20250107212421.7yyvuzw4uqxnqv7t@archP14s>


* sk/unit-test-hash (2025-01-09) 1 commit
 - t/unit-tests: convert hash to use clar test framework

 Test update.

 Will merge to 'next'.
 source: <20250109140952.5267-1-kuforiji98@gmail.com>


* aj/difftool-config-doc-fix (2025-01-09) 1 commit
  (merged to 'next' on 2025-01-10 at b8902a53d1)
 + difftool docs: restore correct position of tool list

 Docfix.

 Will cook in 'next'.
 source: <pull.1849.git.1736379323427.gitgitgadget@gmail.com>


* jk/combine-diff-cleanup (2025-01-09) 14 commits
 - tree-diff: make list tail-passing more explicit
 - tree-diff: simplify emit_path() list management
 - tree-diff: use the name "tail" to refer to list tail
 - tree-diff: drop list-tail argument to diff_tree_paths()
 - combine-diff: drop public declaration of combine_diff_path_size()
 - tree-diff: inline path_appendnew()
 - tree-diff: pass whole path string to path_appendnew()
 - tree-diff: drop path_appendnew() alloc optimization
 - run_diff_files(): de-mystify the size of combine_diff_path struct
 - diff: add a comment about combine_diff_path.parent.path
 - combine-diff: use pointer for parent paths
 - tree-diff: clear parent array in path_appendnew()
 - combine-diff: add combine_diff_path_new()
 - run_diff_files(): delay allocation of combine_diff_path

 Code clean-up for code paths around combined diff.
 source: <20250109082723.GA2748497@coredump.intra.peff.net>


* sc/help-autocorrect-one (2025-01-09) 1 commit
 - help: interpret help.autocorrect=1 as "immediate" rather than 0.1s

 "[help] autocorrect = 1" used to be a way to say "please wait for
 0.1 second after suggesting a typofix of the command name before
 running that command"; now it means "yes, if there is a plausible
 typofix for the command name, please run it immediately".

 Expecting a reroll.
 Almost there.
 source: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ja/doc-notes-markup-updates (2025-01-03) 1 commit
 - doc: git-notes.txt: migrate to new documentation format

 Doc mark-up updates.
 source: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>


* mb/t7110-use-test-path-helper (2025-01-03) 1 commit
  (merged to 'next' on 2025-01-06 at cd96b0ac82)
 + t7110: replace `test -f` with `test_path_is_*` helpers

 Test modernization.

 Will cook in 'next'.
 source: <20250103130035.79376-1-matteobagnolini2003@gmail.com>


* ja/doc-restore-markup-update (2025-01-04) 1 commit
 - doc: git-restore: migrate to new style format

 Doc mark-up updates.
 source: <pull.1847.git.1735996601092.gitgitgadget@gmail.com>


* ua/os-version-capability (2025-01-06) 4 commits
 - version: introduce osversion.command config for os-version output
 - connect: advertise OS version
 - version: refactor get_uname_info()
 - version: refactor redact_non_printables()

 The value of "uname -s" is by default sent over the wire as a new
 capability, with an opt-out for privacy-concious folks.
 source: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>


* ja/doc-commit-markup-updates (2025-01-03) 3 commits
 - doc: git-commit: migrate secondary files to new format
 - doc: git-commit.txt: convert git commit config to new format
 - doc: git-commit: apply new documentation guidelines

 Doc updates.
 source: <pull.1845.git.1735912046.gitgitgadget@gmail.com>


* ps/ci-misc-updates (2025-01-10) 10 commits
 - ci: remove stale code for Azure Pipelines
 - ci: use latest Ubuntu release
 - ci: stop special-casing for Ubuntu 16.04
 - gitlab-ci: add linux32 job testing against i386
 - gitlab-ci: remove the "linux-old" job
 - github: simplify computation of the job's distro
 - github: convert all Linux jobs to be containerized
 - github: adapt containerized jobs to be rootless
 - t7422: fix flaky test caused by buffered stdout
 - t0060: fix EBUSY in MinGW when setting up runtime prefix

 CI updates (containerization, dropping stale ones, etc.).
 source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>


* ps/meson-weak-sha1-build (2024-12-30) 8 commits
  (merged to 'next' on 2025-01-01 at e01db872e4)
 + meson: provide a summary of configured backends
 + meson: wire up unsafe SHA1 backend
 + meson: add missing dots for build options
 + meson: simplify conditions for HTTPS and SHA1 dependencies
 + meson: require SecurityFramework when it's used as SHA1 backend
 + meson: deduplicate access to SHA1/SHA256 backend options
 + meson: consistenlty spell 'CommonCrypto'
 + Merge branch 'ps/weak-sha1-for-tail-sum-fix' into ps/meson-weak-sha1-build

 meson-based build now supports the unsafe-sha1 build knob.

 Will cook in 'next'.
 source: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>


* ps/object-collision-check (2025-01-06) 4 commits
  (merged to 'next' on 2025-01-06 at 540e2bae11)
 + object-file: retry linking file into place when occluding file vanishes
 + object-file: don't special-case missing source file in collision check
 + object-file: rename variables in `check_collision()`
  (merged to 'next' on 2024-12-30 at e083ea3154)
 + object-file: fix race in object collision check

 CI jobs gave sporadic failures, which turns out that that the
 object finalization code was giving an error when it did not have
 to.

 Will cook in 'next'.
 source: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>


* sk/strlen-returns-size_t (2024-12-26) 1 commit
 - date.c: Fix type missmatch warings from msvc

 Code clean-up.

 The remainder needs to be reviewed.
 source: <20241223110407.3308-3-soekkle@freenet.de>


* ps/more-sign-compare (2024-12-27) 10 commits
  (merged to 'next' on 2025-01-01 at 41c78cf690)
 + sign-compare: avoid comparing ptrdiff with an int/unsigned
 + commit-reach: use `size_t` to track indices when computing merge bases
 + shallow: fix -Wsign-compare warnings
 + builtin/log: fix remaining -Wsign-compare warnings
 + builtin/log: use `size_t` to track indices
 + commit-reach: use `size_t` to track indices in `get_reachable_subset()`
 + commit-reach: use `size_t` to track indices in `remove_redundant()`
 + commit-reach: fix type of `min_commit_date`
 + commit-reach: fix index used to loop through unsigned integer
 + prio-queue: fix type of `insertion_ctr`

 More -Wsign-compare fixes.

 Will cook in 'next'.
 cf. https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/
 source: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>


* as/long-option-help-i18n (2024-12-30) 1 commit
  (merged to 'next' on 2024-12-30 at 900c79808f)
 + parse-options: localize mark-up of placeholder text in the short help

 Tweak the help text used for the option value placeholders by
 parse-options API so that translations can customize the "<>"
 placeholder signal (e.g. "--option=<value>").

 Will cook in 'next'.
 source: <20241228114221.10351-4-ash@kambanaria.org>


* sk/maintenance-remote-prune (2025-01-03) 1 commit
 - maintenance: add prune-remote-refs task

 A new periodic maintenance task to run "git remote prune" has been
 introduced.

 Expecting a reroll.
 source: <pull.1838.v3.git.1735928035056.gitgitgadget@gmail.com>


* jc/show-index-h-update (2024-12-20) 1 commit
 - show-index: the short help should say the command reads from its input

 Doc and short-help text for "show-index" has been clarified to
 stress that the command reads its data from the standard input.

 Comments?
 source: <xmqqfrmidyhk.fsf@gitster.g>


* ps/the-repository (2024-12-18) 15 commits
  (merged to 'next' on 2025-01-09 at 1de40edade)
 + match-trees: stop using `the_repository`
 + graph: stop using `the_repository`
 + add-interactive: stop using `the_repository`
 + tmp-objdir: stop using `the_repository`
 + resolve-undo: stop using `the_repository`
 + credential: stop using `the_repository`
 + mailinfo: stop using `the_repository`
 + diagnose: stop using `the_repository`
 + server-info: stop using `the_repository`
 + send-pack: stop using `the_repository`
 + serve: stop using `the_repository`
 + trace: stop using `the_repository`
 + pager: stop using `the_repository`
 + progress: stop using `the_repository`
 + Merge branch 'ps/build-sign-compare' into ps/the-repository

 More code paths have a repository passed through the callchain,
 instead of assuming the primary the_repository object.

 Will cook in 'next'.
 source: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>


* jc/doc-attr-tree (2024-12-14) 1 commit
 - doc: give attr.tree a bit more visibility

 Make sure that "git --attr-source=X", GIT_ATTR_SOURCE, and
 attr.tree configuration variables appear at the same places in the
 documentation.

 On hold.
 cf. <20241216111112.GA2201417@coredump.intra.peff.net>
 source: <xmqq5xnladwi.fsf@gitster.g>


* ps/3.0-remote-deprecation (2025-01-06) 6 commits
 - remote: announce removal of "branches/" and "remotes/"
 - builtin/pack-redundant: remove subcommand with breaking changes
 - ci: repurpose "linux-gcc" job for deprecations
 - ci: merge linux-gcc-default into linux-gcc
 - Makefile: wire up build option for deprecated features
 - Merge branch 'ps/build' into ps/3.0-remote-deprecation

 Following the procedure we established to introduce breaking
 changes for Git 3.0, allow an early opt-in for removing support of
 $GIT_DIR/branches/ and $GIT_DIR/remotes/ directories to configure
 remotes.
 source: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>


* cc/lop-remote (2024-12-07) 5 commits
 . doc: add technical design doc for large object promisors
 . promisor-remote: check advertised name or URL
 . Add 'promisor-remote' capability to protocol v2
 . strbuf: refactor strbuf_trim_trailing_ch()
 . version: refactor strbuf_sanitize()

 Expecting a reroll.
 cf. <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
 source: <20241206124248.160494-1-christian.couder@gmail.com>


* ds/backfill (2024-12-20) 6 commits
 - backfill: assume --sparse when sparse-checkout is enabled
 - backfill: add --sparse option
 - backfill: add --min-batch-size=<n> option
 - backfill: basic functionality and tests
 - backfill: add builtin boilerplate
 - Merge branch 'ds/path-walk-1' into ds/backfill
 (this branch uses ds/path-walk-1.)

 Lazy-loading missing files in a blobless clone on demand is costly
 as it tends to be one-blob-at-a-time.  "git backfill" is introduced
 to help bulk-download necessary files beforehand.

 Comments?
 source: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>


* re/submodule-parse-opt (2024-12-11) 7 commits
  (merged to 'next' on 2024-12-21 at 9e65a56a63)
 + git-submodule.sh: rename some variables
 + git-submodule.sh: improve variables readability
 + git-submodule.sh: add some comments
 + git-submodule.sh: get rid of unused variable
 + git-submodule.sh: get rid of isnumber
 + git-submodule.sh: improve parsing of short options
 + git-submodule.sh: improve parsing of some long options

 "git submodule" learned various ways to spell the same option,
 e.g. "--branch=B" can be spelled "--branch B" or "-bB".

 Will cook in 'next'.
 source: <20241211063234.7610-1-royeldar0@gmail.com>


* tb/unsafe-hash-test (2024-11-21) 2 commits
 - t/helper/test-tool: implement sha1-unsafe helper
 - t/helper/test-sha1: prepare for an unsafe mode

 Preliminary addition to the test tool to allow a plain SHA-1 hash
 algorithm without collision protection.

 Comments?
 cf. <xmqqr073antj.fsf@gitster.g>
 source: <cover.1730833506.git.me@ttaylorr.com>


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


* ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
 - transport: don't ignore git-receive-pack(1) exit code on atomic push
 - t5504: modernize test by moving heredocs into test bodies

 "git push --atomic --porcelain" used to ignore failures from the
 other side, losing the error status from the child process, which
 has been corrected.

 Needs to see if competing parallel topic needs to replace this one.
 source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>


* jc/move-is-bare-repository-cfg-variable-to-repo (2024-11-07) 3 commits
 . repository: BUG when is_bare_cfg is not initialized
 . setup: initialize is_bare_cfg
 . git: remove is_bare_repository_cfg global variable

 Code rewrite to turn the is_bare_repository_cfg global variable
 into a member in the the_repo singleton repository object.

 Waiting for response to reviews.
 cf. <xmqqy116xvr3.fsf@gitster.g>
 Seems to break t0021-conversion on Windows.
 cf. https://lore.kernel.org/git/xmqqzfl1hl52.fsf@gitster.g/
 source: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>


* ds/name-hash-tweaks (2024-12-20) 8 commits
 - pack-objects: add third name hash version
 - pack-objects: prevent name hash version change
 - test-tool: add helper for name-hash values
 - p5313: add size comparison test
 - pack-objects: add GIT_TEST_NAME_HASH_VERSION
 - repack: add --name-hash-version option
 - pack-objects: add --name-hash-version option
 - pack-objects: create new name-hash function version

 "git pack-objects" and its wrapper "git repack" learned an option
 to use an alternative path-hash function to improve delta-base
 selection to produce a packfile with deeper history than window
 size.

 Comments?
 source: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>


* ds/path-walk-1 (2024-12-20) 7 commits
 - path-walk: reorder object visits
 - path-walk: mark trees and blobs as UNINTERESTING
 - path-walk: visit tags and cached objects
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - test-lib-functions: add test_cmp_sorted
 - path-walk: introduce an object walk by path
 (this branch is used by ds/backfill.)

 Introduce a new API to visit objects in batches based on a common
 path, or by type.

 Comments?
 source: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>


* km/config-remote-by-name (2024-10-21) 1 commit
 - config: support remote name in includeIf.hasconfig condition

 Support conditionally including configuration by remote name, instead
 of just URL.

 Will discard?
 source: <20241020173216.40852-2-ken@kmatsui.me>


* y5/diff-pager (2024-10-21) 1 commit
 - diff: setup pager only before diff contents truly ready

 Delay setting up the pager in 'git diff' until after the diff contents
 itself is fully prepared.

 Will discard?
 source: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>


* ej/cat-file-remote-object-info (2024-11-25) 6 commits
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing
 - cat-file: add declaration of variable i inside its for loop

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Expecting a reroll.
 cf. <Z0RIrKwUnaWWm_gJ@pks.im>
 source: <20241125053616.25170-1-eric.peijian@gmail.com>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 A rust binding to libgit.a functions has been introduced.

 Will discard?
 source: <cover.1729032373.git.steadmon@google.com>
