Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90461C1AA9
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796325; cv=none; b=ikJ1A+4o56FN6IWHmKBV1dfm+5U3FJrKclvZKerwE+an8cnZ26239dGE9iXeAs15MjQJA+gCK5Sp9loO5O/5BoIYDCNLcDJ6CqJdoAuXlgZWhrrL35QDtmxTVpqDFch/lP0BXLzZEiMhhJf+qBRAog6mICeELiHZhJzqKeFP3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796325; c=relaxed/simple;
	bh=NCW5lGoQUrQRQPLBir5hNU7Y9NMToBxuYTe9MhAAwbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSxlcaE6/xzuAA0Ulsia5ze/SxUYet/Gy5lGfmd+8BTL6BEb0d/lY9p2mQFXZljBJlxQ3M+tLGAo6gNCMJ7Vp+PuzH2s5hPpE4uJOJACosy/RTSZyLzzWA/VZ8TKh8VX0SXPG5jvr9J3758w8HUQoT8Od8L5h1fNUof0XCw/Sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CFL7Pdjm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HSDaMLEC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFL7Pdjm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSDaMLEC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CDB8711401E7;
	Tue,  5 Nov 2024 03:45:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 05 Nov 2024 03:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1730796320; x=1730882720; bh=WksVmhui69
	h/iOUpPgK3p6D9L9337BvMGjE77Gl3jow=; b=CFL7PdjmO+31orYGQknPCCrC72
	wbiHkx9SZf+6aBl29qGt3GQpO4yEoSM5x3Dy7ea9tvfiKr97RUzv1Nea3Z+5yuZh
	AcTwAvnrffp6hdy/CKQ9EeYOvGzpc3S0HWeRWFKYoTf/QzKwYRnN7Y/b6uXSg4wg
	7JOY/K2C/BqMi6fhGZ0+au5xObqXVTu+lvZsSOmBJJf9aRpRFlS19vwVWTtZJOo1
	xKrn/i+DBnSs2GLFW4/ShXJKbTGzi+t+5V6GZ0DZOHvjN3WdONqbo9urp/90Wwqi
	vKO/PJh4nutHUUiaDHYUguXnhY+Mfcp9W2f69AQfAAgxdy8frmHesZxcxBeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730796320; x=1730882720; bh=WksVmhui69h/iOUpPgK3p6D9L9337BvMGjE
	77Gl3jow=; b=HSDaMLEC2wvns9oiEwaZeoett9x6TneVFM/7R8+UYrrfHw0cOx+
	73DU3N160x1bkRxh/upawQv4rpFIuCCSkludMOAUSgNEx7dw8owLepGldOlJeKj+
	1v8EoP7JfYbtjeIlPzFaUvy5sZczdM/4jW9p4+Wv6XRlnvxjjF4zN8DLaU1W0jum
	pdk75uS2Pg9mETVDmbRP0X+wJbsTYjm9VA8WKXidinwbJ+zIc5V4wenEWANpQ45I
	Jk8j2u4NHCJ6bMidbcQy81v18n8lwQlthS0JVZd7ubOHh8hNa4KOB03fqXX0AnU0
	QjNqrUzwK7hDMeszr8sQIkipjl5xmtd0mhA==
X-ME-Sender: <xms:INspZ5CCaHP1PYcI1UrL64t-pnO9rTHfk8O1cSbL7osYfep3uIAy5Q>
    <xme:INspZ3gTg40a7j8P7f7QUoKVy2WXQzGr7m_3NaoCsMFZW89ke3dGxkBP8kRDZ-Hbq
    lm7swo9lAGNV9luSw>
X-ME-Received: <xmr:INspZ0lyTf5_zKj2YUFNCW_S62XQ9zj6a9VTv_D6ZRMPbQqUfnDtKLvptY2qF3vR8EkL_O3N5oLVAWk92hQafsCz9l-5R_qbGf0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgfehge
    dtteekkefgteelffefudethfevgfdvueehgfetfeevhfettdejgfekgfevnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtoh
    hmpdhgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhpkhhsrdhimhdptghlrghr
    qdguvggtlhhsrdhhthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhifnheslhifnhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:INspZzyr1skjNR44hLF10qNylR8lS3lpSQeAGqzBZEblQMmmUr60xg>
    <xmx:INspZ-SU0u2LQhDQWgqUSZ855AjjfGqonw-idelgwLnbCmG5O1CkQQ>
    <xmx:INspZ2bZhO-BqzFoDFdEjDdZoGrwYZvLPtLjPIABD8OVReT5A0Xojw>
    <xmx:INspZ_TFh6cQk1xLcxAm-0FMT0uj1iaT_HJETI3RL6kHrrf7M3rjNg>
    <xmx:INspZ8fFjA5t1hGv_YOmr5sd2VTJ8Gp2EDMmlYFwwx5D7g_hPFHYDOKU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 03:45:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Nov 2024, #03; Mon, 4)
X-master-at: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
X-next-at: c08e6fccd86136592273e319042f44cc8eadbb2a
Date: Tue, 05 Nov 2024 00:45:18 -0800
Message-ID: <xmqqwmhirrvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The last issue was somewhat botched in that I had a few topics
missing in my tree in the broken-out form, which confused the script
that updates this report.  Let's see if I fixed them all...



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

* ak/t1016-style (2024-11-03) 1 commit
 - t1016: clean up style

 Test modernization.

 Will merge to 'next'.
 source: <20241103135111.13508-1-algonell@gmail.com>


* en/shallow-exclude-takes-a-ref-fix (2024-11-04) 2 commits
 - doc: correct misleading descriptions for --shallow-exclude
 - upload-pack: fix ambiguous error message

 The "--shallow-exclude=<ref>" option to various history transfer
 commands takes a ref, not an arbitrary revision.

 Will merge to 'next'.
 source: <pull.1822.git.1730746964.gitgitgadget@gmail.com>


* kh/sequencer-comment-char (2024-10-23) 1 commit
 - sequencer: comment checked-out branch properly

 The sequencer failed to honor core.commentString in some places.

 Expecting a reroll.
 cf. <c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com>
 source: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>


* ds/full-name-hash (2024-11-04) 7 commits
 - test-tool: add helper for name-hash values
 - pack-objects: disable --full-name-hash when shallow
 - p5313: add size comparison test
 - git-repack: update usage to match docs
 - pack-objects: add GIT_TEST_FULL_NAME_HASH
 - repack: add --full-name-hash option
 - pack-objects: add --full-name-hash option

 "git pack-objects" and its wrapper "git repack" learned an option
 to use an alternative path-hash function to improve delta-base
 selection to produce a packfile with deeper history than window
 size.
 
 Needs review.
 source: <pull.1823.git.1730775907.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* jt/repack-local-promisor (2024-11-03) 5 commits
 - fixup! index-pack: repack local links into promisor packs
 - index-pack: repack local links into promisor packs
 - t5300: move --window clamp test next to unclamped
 - t0410: use from-scratch server
 - t0410: make test description clearer

 "git gc" discards any objects that are outside promisor packs that
 are referred to by an object in a promisor pack, and we do not
 refetch them from the promisor at runtime, resulting an unusable
 repository.  Work it around by including these objects in the
 referring promisor pack at the receiving end of the fetch.

 Needs review.
 Breaks CI (with a known fix).
 source: <cover.1730491845.git.jonathantanmy@google.com>


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


* as/show-index-uninitialized-hash (2024-11-04) 2 commits
 - t5300: add test for 'show-index --object-format'
 - show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Expecting a reroll.
 cf. <xmqq4j4mv5o6.fsf@gitster.g>
 source: <20241104192958.64310-1-abhijeet.nkt@gmail.com>


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


* jt/commit-graph-missing (2024-11-04) 3 commits
 - SQUASH???
 - fetch-pack: warn if in commit graph but not obj db
 - Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"

 A regression where commit objects missing from a commit-graph can
 cause an infinite loop when doing a fetch in a partial clone has
 been fixed.

 Waiting an ack for CI breakage fix and possibly a reroll.
 source: <cover.1730409376.git.jonathantanmy@google.com>


* kn/the-repository (2024-11-04) 9 commits
 - midx: add repository to `multi_pack_index` struct
 - config: make `packed_git_(limit|window_size)` non-global variables
 - config: make `delta_base_cache_limit` a non-global variable
 - packfile: pass down repository to `for_each_packed_object`
 - packfile: pass down repository to `has_object[_kept]_pack`
 - packfile: pass down repository to `odb_pack_name`
 - packfile: pass `repository` to static function in the file
 - packfile: use `repository` from `packed_git` directly
 - packfile: add repository to struct `packed_git`

 Various implicit uses of 'the_repoository' in the packfile code
 have been eliminated.

 Needs review.
 source: <cover.1730714298.git.karthik.188@gmail.com>

--------------------------------------------------
[Discarded]

* wf/diff-highlight-install (2024-10-14) 1 commit
 . diff-highlight: make install link into DESTDIR

 Adds an 'install' recipe to diff-highlight's Makefile.

 Discarded.
 Have been in stalled state for too long without activity.
 cf. <Zw2YXD6XEiQVKj9j@nand.local>
 source: <pull.938.v3.git.git.1728764613835.gitgitgadget@gmail.com>


* am/git-blame-ignore-revs-by-default (2024-10-14) 2 commits
 . blame: introduce --override-ignore-revs to bypass ignore revisions list
 . blame: respect .git-blame-ignore-revs automatically

 Teaches 'git blame' to treat '.git-blame-ignore-revs' as if it were
 passed as '--ignore-revs-file' by default.

 Discarded.
 Stalled for too long, with many questions unanswered.
 source: <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>


* jc/optional-path (2024-10-14) 3 commits
 . parseopt: values of pathname type can be prefixed with :(optional)
 . config: values of pathname type can be prefixed with :(optional)
 . t7500: make each piece more independent

 Teach configuration values of type "pathname" a new ':(optional)'
 suffix.

 Discarded.
 In " Needs review." state for too long.
 source: <20241014204427.1712182-1-gitster@pobox.com>


* jc/too-many-arguments (2024-08-06) 4 commits
 . miscellaneous: avoid "too many arguments"
 . notes: avoid "too many arguments"
 . cat-file: avoid "too many arguments"
 . refs: avoid "too many arguments"

 Error message clarification.

 Discarded.
 In "On hold." state for too long.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* jc/strbuf-commented-something (2024-09-12) 2 commits
 . strbuf: retire strbuf_commented_lines()
 . strbuf: retire strbuf_commented_addf()

 Update two functions whose callers always pass the same global
 variable to omit the redundant parameter and use the global in the
 callee themselves.

 Discarded.
 In "On hold." state for too long.
 source: <20240912205301.1809355-1-gitster@pobox.com>


* ew/cat-file-optim (2024-08-25) 10 commits
 . cat-file: use writev(2) if available
 . cat-file: batch_write: use size_t for length
 . cat-file: batch-command uses content_limit
 . object_info: content_limit only applies to blobs
 . packfile: packed_object_info avoids packed_to_object_type
 . cat-file: use delta_base_cache entries directly
 . packfile: inline cache_or_unpack_entry
 . packfile: fix off-by-one in content_limit comparison
 . packfile: allow content-limit for cat-file
 . packfile: move sizep computation

 "git cat-file --batch" has been optimized.

 Discarded.
 In "Waiting for review responses" state for too long.
 source: <20240823224630.1180772-1-e@80x24.org>


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
