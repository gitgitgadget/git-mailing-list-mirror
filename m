Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF44C6C
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730693153; cv=none; b=iubbjODgA1GkSxSXWDf9ht5R9ipwfavzwYJfjdGHDf22LF3u9lgoGhU18wEDtwfwnMu5Cq2/NhNpkGPihAa1X+pxyn2ivtlSxX+bFbxEriPi+3Gy4cOiJrt55gAm9urEEfgXWMiHDbW0leFGZXuLmCykEL5i10rKBOEzSrjJpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730693153; c=relaxed/simple;
	bh=/i9xiMnXizYqYlZU1rWeOpiOYw+vTH9yHipb27ToJ9Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBC1AhnsMbeDvkN82VZKz5KjeRmGmlN0ZKWLsRMlQC0Z4mMq/lLaecLFvh8C8P8hwkxHd1IFdSr8pb6pq7hruLbJqksgLKa9tk2LBrncb1Cuiy8/9z68dtfU7Fbcn8MAlS1CedOL7lc0tzp8FHQcwTr4yb/YK2gFRNdcvgnvMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GMlyPXWs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lax/uztw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMlyPXWs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lax/uztw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0BB5411400C6;
	Sun,  3 Nov 2024 23:05:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 03 Nov 2024 23:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1730693148; x=1730779548; bh=ucumGUxl/i
	ad2fkdjbD88wnkBHU9hDUk2BhS+ZLtdVI=; b=GMlyPXWs+YlggkgAa0b0NSautG
	rBxvRcne7RohjlPCSMdtqSsdaGV9OdDE//Wrsd5SQxt5yw/pGWeIU2FzTRn5w2Sf
	qyMhfnyze/I4oVsI7TvdM5hbUrc4whiLdA9kss6X/UIal9f0AWG6IfzH1ZpWvkGu
	n5tr2S+SRPijqKMhMjDPKmEU+3zm5x2iVQ6Kt5wr43aMW6xndPyyQ9PuAZogkRrV
	245tMvgG65TNw+/UrgHLQvLsuCKCMpiRop7KJGYRt1HsO0Yo4kzdyEpU5qNE8iUb
	UcSMo5+0dSfw6bGxrUgsH+bX20bzD4n+Hta8tdBZHo+pRyhbOCgcF8ut3mIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730693148; x=1730779548; bh=ucumGUxl/iad2fkdjbD88wnkBHU9hDUk2Bh
	S+ZLtdVI=; b=Lax/uztw5j3exKm9J8JxTfB3jDaaIfVh0CBp/zeGb9h5TAO4o2g
	NDeTf7wmE8cWcHHECeyfciU2jMQwcM0G/TmdVwRzkhjxL3OgPQwV2xPEdkDQbJan
	O23nT6SuvieWswn/HRdWXdYPkw+g+LQfKxR+B2Nt9KuI5GciVjFT3r7WkgrubeZp
	m4Xcel25qorcjPEz4PY6o62LyXVWNplPiqYo/jg00wchU0bN9QpNyv3Bcpz76JCc
	A74CKH1qI47e/DbWEu4r2UfmbrV8bC8cAG8fVhzaimJO6L3gq/NdFdceVlvEkZoN
	8C9zrQD9tLeuUjSdGx1waopsVVyYvcoZuzw==
X-ME-Sender: <xms:HEgoZ93KssW4mr_txVHgHN0OO8Dfq8En4N7HO97kl9kNaF_BiVFTsw>
    <xme:HEgoZ0EKFcED3FH7aNwmp6WKyZXFrBCV-NQ2qrOnYw-cDzWFp01Yzy8zfmgsayWsW
    _6fyUe_FWnwMRdpCw>
X-ME-Received: <xmr:HEgoZ94beOagFentNERrcgejgaZJqdgHYeY9NRjsU-FjlH2eZ5bR9I6IypPUHuCP7RKAsaFLg_DGFq6cMOsJDiQcLH1CZygtzAU6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelhedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejleehhe
    ejvdevtdfgteetjeegveevheefteeltefgtdejudejhfettefgtddvvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhorhdrtgiipdhgohhoghhlvghsohhurhgtvgdrtghomh
    dpghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhdpphhkshdrihhmpdgtlhgrrhdq
    uggvtghlshdrhhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HEgoZ629uIP07cxHUvdSNBC6Y9Zch2ZxI6MGyPeSLh3TcTAu9Lxp2A>
    <xmx:HEgoZwH10S103gd-aU5X0Q3qAmYcH7zoNEFBpVkxe4wBp-Gwxe4P2g>
    <xmx:HEgoZ7_TVmAG6KRz3kpHVjIboSszrnBHzpmgvrSBCg-_Gr4f3o3TxQ>
    <xmx:HEgoZ9lT509Lge_zeIa0TtQJXYUjhMz8iBPIH5GMwrLcb3fPcCv3PQ>
    <xmx:HEgoZ8gkNDSJemte6QZsJuQVVCpPTQk-nATOkr3_bVknWPXbpUizO1Kz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 23:05:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2024, #02; Fri, 1)
X-master-at: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
X-next-at: c08e6fccd86136592273e319042f44cc8eadbb2a
Date: Sun, 03 Nov 2024 20:05:46 -0800
Message-ID: <xmqqr07rwsmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Thanks everybody, especially Taylor, for keeping things going while
I was away.  Unfortunately, we seem to have acquired way too many
topics that were posted and picked up without getting reviewed.  As
we discussed a few months ago in <xmqqployf6z5.fsf@gitster.g>, I'll
start discarding topics that have seen no activities for 3 or more
weeks.  Interested parties can of course revive these topics.

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

* ds/path-walk-1 (2024-10-31) 6 commits
 - path-walk: mark trees and blobs as UNINTERESTING
 - path-walk: visit tags and cached objects
 - path-walk: allow consumer to specify object types
 - t6601: add helper for testing path-walk API
 - test-lib-functions: add test_cmp_sorted
 - path-walk: introduce an object walk by path

 Introduce a new API to visit objects in batches based on a common
 path, or by type.

 Under discussion.
 cf. <ZyUqr/wb5K4Og9j9@nand.local>
 source: <pull.1818.git.1730356023.gitgitgadget@gmail.com>


* tb/cross-pack-delta-reuse (2024-10-11) 11 commits
 . pack-bitmap: enable reusing deltas with base objects in 'haves' bitmap
 . pack-bitmap.c: record whether the result was filtered
 . pack-bitmap: enable cross-pack delta reuse
 . t5332: enable OFS_DELTAs via test_pack_objects_reused
 . write_reused_pack_one(): translate bit positions directly
 . pack-bitmap: drop `from_midx` field from `bitmapped_pack`
 . pack-bitmap.c: extract `find_base_bitmap_pos()`
 . pack-bitmap.c: compare `base_offset` to `delta_obj_offset`
 . pack-bitmap.c: delay calling 'offset_to_pack_pos()'
 . pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
 . pack-bitmap.c: do not pass `pack_pos` to `try_partial_reuse()`

 Allow pack-objects to reuse an existing delta in a packfile, when
 it ends up sending the base object from a different packfile.

 Needs review.
 source: <cover.1728505840.git.me@ttaylorr.com>


* tb/incremental-midx-part-2 (2024-10-04) 17 commits
 . fixup! pack-bitmap.c: open and store incremental bitmap layers
 . fixup! midx: implement writing incremental MIDX bitmaps
 . midx: implement writing incremental MIDX bitmaps
 . pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
 . pack-bitmap.c: keep track of each layer's type bitmaps
 . ewah: implement `struct ewah_or_iterator`
 . pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
 . pack-bitmap.c: compute disk-usage with incremental MIDXs
 . pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
 . pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
 . pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
 . pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
 . pack-bitmap.c: open and store incremental bitmap layers
 . pack-revindex: prepare for incremental MIDX bitmaps
 . Documentation: describe incremental MIDX bitmaps
 . Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
 . Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1723760847.git.me@ttaylorr.com>
 source: <ZwBsbW5jsFw0mxKk@nand.local>

--------------------------------------------------
[Cooking]

* bc/ancient-ci (2024-11-01) 3 commits
 - Add additional CI jobs to avoid accidental breakage
 - ci: remove clause for Ubuntu 16.04
 - gitlab-ci: switch from Ubuntu 16.04 to 20.04

 Drop support for ancient environments in various CI jobs.

 Needs review.
 source: <20241031234934.3451390-1-sandals@crustytoothpaste.net>


* cw/worktree-extension (2024-11-01) 9 commits
 - worktree: refactor `repair_worktree_after_gitdir_move()`
 - worktree: add relative cli/config options to `repair` command
 - worktree: add relative cli/config options to `move` command
 - worktree: add relative cli/config options to `add` command
 - worktree: add `write_worktree_linking_files()` function
 - worktree: refactor infer_backlink return
 - worktree: add `relativeWorktrees` extension
 - setup: correctly reinitialize repository version
 - Merge branch 'cw/config-extensions' into cw/worktree
 (this branch uses cw/config-extensions.)

 Introduce a new repository extension to prevent older Git versions
 from mis-interpreting worktrees created with relative paths.

 Needs review.
 source: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>


* jk/left-right-bitmap (2024-11-01) 1 commit
  (merged to 'next' on 2024-11-01 at f1d0c395f5)
 + rev-list: skip bitmap traversal for --left-right

 When called with '--left-right' and '--use-bitmap-index', 'rev-list'
 will produce output without any left/right markers, which has been
 corrected.

 Will merge to 'master'.
 source: <20241101121606.GA2327410@coredump.intra.peff.net>


* kh/bundle-docs (2024-10-29) 3 commits
 - Documentation/git-bundle.txt: discuss naïve backups
 - Documentation/git-bundle.txt: mention --all in spec. refs
 - Documentation/git-bundle.txt: mention full backup example

 Documentation improvements to more prominently call out the use of
 '--all' when creating bundles.

 Expecting a reroll.
 source: <cover.1730234365.git.code@khaugsbakk.name>


* as/show-index-uninitialized-hash (2024-10-27) 1 commit
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Expecting a reroll.
 cf. <26d1bd3c-4f90-4406-8a1f-2eb085c46bab@gmail.com>
 source: <20241026120950.72727-1-abhijeet.nkt@gmail.com>


* ps/mingw-rename (2024-10-27) 3 commits
 - compat/mingw: support POSIX semantics for atomic renames
 - compat/mingw: allow deletion of most opened files
 - compat/mingw: share file handles created via `CreateFileW()`

 Teaches the MinGW compatibility layer to support POSIX semantics for
 atomic renames when other process(es) have a file opened at the
 destination path.

 Waiting for final ack before 'next'.
 source: <cover.1730042775.git.ps@pks.im>


* ps/reftable-detach (2024-10-23) 8 commits
 - reftable/system: provide thin wrapper for lockfile subsystem
 - reftable/stack: drop only use of `get_locked_file_path()`
 - reftable/system: provide thin wrapper for tempfile subsystem
 - reftable/stack: stop using `fsync_component()` directly
 - reftable/system: stop depending on "hash.h"
 - reftable: explicitly handle hash format IDs
 - reftable/system: move "dir.h" to its only user
 - Merge branch 'ps/reftable-strbuf' into ps/reftable-detach

 Isolates the reftable subsystem from the rest of Git's codebase by
 using fewer pieces of Git's infrastructure.

 Needs review.
 source: <cover.1729677003.git.ps@pks.im>


* cw/config-extensions (2024-10-22) 1 commit
  (merged to 'next' on 2024-10-30 at 875fa0b619)
 + doc: consolidate extensions in git-config documentation
 (this branch is used by cw/worktree-extension.)

 Centralize documentation for repository extensions into a single place.

 Will merge to 'master'.
 source: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>


* km/config-remote-by-name (2024-10-21) 1 commit
 - config: support remote name in includeIf.hasconfig condition

 Support conditionally including configuration by remote name, instead
 of just URL.

 Needs review.
 source: <20241020173216.40852-2-ken@kmatsui.me>


* kn/arbitrary-suffixes (2024-10-24) 1 commit
  (merged to 'next' on 2024-10-30 at 3eedf30c6c)
 + CodingGuidelines: discourage arbitrary suffixes in function names

 Update the project's CodingGuidelines to discourage naming functions
 with a "_1()" suffix.

 Will merge to 'master'.
 source: <20241024105357.2605168-1-karthik.188@gmail.com>


* ps/leakfixes-part-9 (2024-10-21) 22 commits
 - list-objects-filter-options: work around reported leak on error
 - builtin/merge: release outbut buffer after performing merge
 - dir: fix leak when parsing "status.showUntrackedFiles"
 - t/helper: fix leaking buffer in "dump-untracked-cache"
 - t/helper: stop re-initialization of `the_repository`
 - sparse-index: correctly free EWAH contents
 - dir: release untracked cache data
 - combine-diff: fix leaking lost lines
 - builtin/tag: fix leaking key ID on failure to sign
 - transport-helper: fix leaking import/export marks
 - builtin/commit: fix leaking cleanup config
 - trailer: fix leaking strbufs when formatting trailers
 - trailer: fix leaking trailer values
 - builtin/commit: fix leaking change data contents
 - upload-pack: fix leaking URI protocols
 - pretty: clear signature check
 - diff-lib: fix leaking diffopts in `do_diff_cache()`
 - revision: fix leaking bloom filters
 - builtin/grep: fix leak with `--max-count=0`
 - grep: fix leak in `grep_splice_or()`
 - t/helper: fix leaks in "reach" test tool
 - builtin/ls-remote: plug leaking server options

 More leakfixes.

 Needs review.
 source: <cover.1729502823.git.ps@pks.im>


* y5/diff-pager (2024-10-21) 1 commit
 - diff: setup pager only before diff contents truly ready

 Delay setting up the pager in 'git diff' until after the diff contents
 itself is fully prepared.

 Needs review.
 source: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com>


* kn/ci-clang-format-tidy (2024-10-18) 2 commits
  (merged to 'next' on 2024-10-30 at d063e828d5)
 + clang-format: align consecutive macro definitions
 + clang-format: re-adjust line break penalties

 Updates the '.clang-format' to match project conventions.

 Will merge to 'master'.
 source: <cover.1729241030.git.karthik.188@gmail.com>


* la/trailer-info (2024-10-14) 1 commit
 - trailer: spread usage of "trailer_block" language

 Refactoring.

 Needs review.
 source: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>


* ps/upgrade-clar (2024-10-21) 5 commits
  (merged to 'next' on 2024-10-30 at b8b092bb78)
 + cmake: set up proper dependencies for generated clar headers
 + cmake: fix compilation of clar-based unit tests
 + Makefile: extract script to generate clar declarations
 + Makefile: adjust sed command for generating "clar-decls.h"
 + t/unit-tests: update clar to 206accb
 (this branch is used by ps/build.)

 Buildfix and upgrade of Clar to a newer version.

 Will merge to 'master'.
 source: <cover.1729506329.git.ps@pks.im>


* bc/drop-ancient-libcurl-and-perl (2024-10-23) 12 commits
 - gitweb: make use of s///r
 - Require Perl 5.26.0
 - INSTALL: document requirement for libcurl 7.61.0
 - git-curl-compat: remove check for curl 7.56.0
 - git-curl-compat: remove check for curl 7.53.0
 - git-curl-compat: remove check for curl 7.52.0
 - git-curl-compat: remove check for curl 7.44.0
 - git-curl-compat: remove check for curl 7.43.0
 - git-curl-compat: remove check for curl 7.39.0
 - git-curl-compat: remove check for curl 7.34.0
 - git-curl-compat: remove check for curl 7.25.0
 - git-curl-compat: remove check for curl 7.21.5

 Drop support for older libcURL and Perl.

 Under discussion.
 source: <20241023004600.1645313-1-sandals@crustytoothpaste.net>


* es/oss-fuzz (2024-10-16) 3 commits
 - fuzz: port fuzz-url-decode-mem from OSS-Fuzz
 - fuzz: port fuzz-parse-attr-line from OSS-Fuzz
 - fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz

 Backport oss-fuzz tests for us to our codebase.

 Needs review.
 source: <cover.1728939687.git.steadmon@google.com>


* bf/set-head-symref (2024-10-23) 8 commits
 - fetch set_head: handle mirrored bare repositories
 - fetch: set remote/HEAD if it does not exist
 - refs: add create_only option to refs_update_symref_extended
 - refs: add TRANSACTION_CREATE_EXISTS error
 - remote set-head: better output for --auto
 - remote set-head: refactor for readability
 - refs: atomically record overwritten ref in update_symref
 - t/t5505-remote: set default branch to main

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Needs review.
 source: <20241023153736.257733-1-bence@ferdinandy.com>


* ps/build (2024-10-24) 21 commits
 - meson: fix conflicts with in-flight topics
 - Introduce support for the Meson build system
 - Documentation: add comparison of build systems
 - t: allow overriding build dir
 - t: better support for out-of-tree builds
 - Documentation: extract script to generate a list of mergetools
 - Documentation: teach "cmd-list.perl" about out-of-tree builds
 - Documentation: allow sourcing generated includes from separate dir
 - Makefile: simplify building of templates
 - Makefile: allow "bin-wrappers/" directory to exist
 - Makefile: refactor generators to be PWD-independent
 - Makefile: refactor GIT-VERSION-GEN to be reusable
 - Makefile: extract script to generate gitweb.cgi
 - Makefile: extract script to massage Shell scripts
 - Makefile: use "generate-perl.sh" to massage Perl library
 - Makefile: extract script to massage Perl scripts
 - Makefile: consistently use PERL_PATH
 - Makefile: consistently use @PLACEHOLDER@ to substitute
 - Makefile: use common template for GIT-BUILD-OPTIONS
 - Merge branch 'ps/platform-compat-fixes' into ps/build
 - Merge branch 'ps/upgrade-clar' into ps/build
 (this branch uses ps/upgrade-clar.)

 Build procedure update plus introduction of Mason based builds

 Under discussion.
 source: <cover.1729771605.git.ps@pks.im>


* ej/cat-file-remote-object-info (2024-10-31) 6 commits
 - cat-file: add remote-object-info to batch-command
 - cat-file: add declaration of variable i inside its for loop
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 "git cat-file --batch" and friends can optionally ask a remote
 server about objects it does not have.

 Needs review.
 source: <20241028203457.19715-1-eric.peijian@gmail.com>


* cc/promisor-remote-capability (2024-09-10) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?  I got an impression that this is premature without
 finishing the discussion on a larger picture.
 cf. <ZvpZv_fed_su4w2-@pks.im>
 source: <20240910163000.1985723-1-christian.couder@gmail.com>


* sj/ref-contents-check (2024-10-21) 9 commits
 - ref: add symlink ref content check for files backend
 - ref: check whether the target of the symref is a ref
 - ref: add basic symref content check for files backend
 - ref: add more strict checks for regular refs
 - ref: port git-fsck(1) regular refs check for files backend
 - ref: support multiple worktrees check for refs
 - ref: initialize target name outside of check functions
 - ref: check the full refname instead of basename
 - ref: initialize "fsck_ref_report" with zero

 "git fsck" learned to issue warnings on "curiously formatted" ref
 contents that have always been taken valid but something Git
 wouldn't have written itself (e.g., missing terminating end-of-line
 after the full object name).

 Needs review.
 cf. <ZxZ+xteOnm0im5vC@nand.local>
 source: <ZxZX5HDdq_R0C77b@ArchLinux>


* js/libgit-rust (2024-10-16) 5 commits
 - Makefile: add option to build and test libgit-rs and libgit-rs-sys
 - libgit: add higher-level libgit crate
 - libgit-sys: also export some config_set functions
 - libgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.

 Needs review.
 source: <cover.1729032373.git.steadmon@google.com>


* jt/commit-graph-missing (2024-11-01) 2 commits
 . fetch-pack: warn if in commit graph but not obj db
 . Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"

 A regression where commit objects missing from a commit-graph can
 cause an infinite loop when doing a fetch in a partial clone has
 been fixed.

 Breaks CI.
 cf. https://github.com/ttaylorr/git/actions/runs/11631453312/job/32392591229
 source: <cover.1730409376.git.jonathantanmy@google.com>


* kn/the-repository (2024-10-31) 9 commits
 . midx: add repository to `multi_pack_index` struct
 . config: make `packed_git_(limit|window_size)` non-global variables
 . config: make `delta_base_cache_limit` a non-global variable
 . packfile: pass down repository to `for_each_packed_object`
 . packfile: pass down repository to `has_object[_kept]_pack`
 . packfile: pass down repository to `odb_pack_name`
 . packfile: pass `repository` to static function in the file
 . packfile: use `repository` from `packed_git` directly
 . packfile: add repository to struct `packed_git`

 Various uses of 'the_repoository' in the packfile code have been
 eliminated.

 Breaks CI, and expecting another round.
 cf. https://github.com/ttaylorr/git/actions/runs/11602969593/job/32309061019
 source: <cover.1730366765.git.karthik.188@gmail.com>


--------------------------------------------------
[Will Discard]

* wf/diff-highlight-install (2024-10-14) 1 commit
 - diff-highlight: make install link into DESTDIR

 Adds an 'install' recipe to diff-highlight's Makefile.

 Will discard.
 Have been in stalled state for too long without activity.
 cf. <Zw2YXD6XEiQVKj9j@nand.local>
 source: <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>


* am/git-blame-ignore-revs-by-default (2024-10-14) 2 commits
 - blame: introduce --override-ignore-revs to bypass ignore revisions list
 - blame: respect .git-blame-ignore-revs automatically

 Teaches 'git blame' to treat '.git-blame-ignore-revs' as if it were
 passed as '--ignore-revs-file' by default.

 Will discard.
 Stalled for too long, with many questions unanswered.
 source: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>


* jc/optional-path (2024-10-14) 3 commits
 - parseopt: values of pathname type can be prefixed with :(optional)
 - config: values of pathname type can be prefixed with :(optional)
 - t7500: make each piece more independent

 Teach configuration values of type "pathname" a new ':(optional)'
 suffix.

 Will discard.
 In " Needs review." state for too long.
 source: <20241014204427.1712182-1-gitster@pobox.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 Will discard.
 In "On hold." state for too long.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 - strbuf: retire strbuf_commented_lines()
 - strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 Will discard.
 In "On hold." state for too long.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* ew/cat-file-optim (2024-08-25) 10 commits
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

 Will discard.
 In "Waiting for review responses" state for too long.
 source: <20240823224630.1180772-1-e@80x24.org>


--------------------------------------------------
[Discarded]

* hy/partial-repack-fix (2024-10-16) 3 commits
 . partial-clone: update doc
 . t0410: adapt tests to repack changes
 . repack: pack everything into packfile

 "git repack" avoids losing local objects that are reachable from
 objects in a packfile fetched from a promisor remote.

 Retracted.
 cf. <CAG1j3zHXThL_JXP=9xqvg=wg0R1wZYnA-okfFxqmcUQ9w0M36g@mail.gmail.com>
 source: <20241014032546.68427-1-hanyang.tony@bytedance.com>


* cw/fix-reachable-in-repo-with-promisor (2024-09-19) 2 commits
 . fetch-pack.c: do not declare local commits as "have" in partial repos
 . packfile: split promisor objects oidset into two

 "git gc" in a partial clone (i.e. lacking objects that can be
 lazily fetched from promisor remotes) collected more than objects
 that promisor-remote can give.

 Appears to break CI.
 cf. https://github.com/ttaylorr/git/actions/runs/11523538245
 source: <20240802073143.56731-1-hanyang.tony@bytedance.com>
