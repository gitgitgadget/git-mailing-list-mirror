Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FE143C63
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284467; cv=none; b=sBbYqKpPxBoZHAItXKEnxLLB1jC/BeQ2YHzzvaIE0a45hvTIvKfkFzIKgxTKsRTYjGcLggVR/xWIebPAWIIBxxP1rMa2O5/4CT76DlhwSjoREa5b7GIKAo0tPW5EKFakk1w1yAIie/+0iu0S56c08VfmADalIWouupU4PcyqwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284467; c=relaxed/simple;
	bh=2cJw+KUrSNijZ0mYuejNEKE0d9WT4tiDhCjj0NVs29c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hi2N6nq/3FtdoEfWW9YlbP7kAjF9Gna2uFre18UUbF9wJ92gbltY103aJxA/UYddnjEcf4ZxbeIWwbj5Tp1lDKlY2H6HtVNYDLQJQtsZjNXlEsJ1hEjzWcNae3c42kfgCPtow+dU1MqJUlX4qUw9atqgVbUJidIiRcGe7D6b7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cxs6g3Rq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9Jfeyw/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cxs6g3Rq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9Jfeyw/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 15A231140161;
	Fri, 27 Dec 2024 02:27:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 27 Dec 2024 02:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1735284462; x=1735370862; bh=ykNUns294xzo7WIxHvrtNMZAdAlV/hXQ
	svEvNs+JgZ4=; b=cxs6g3RqbYo6lx6OV6yhFCWvUClE6R3X00YFs/JnrOJDMa6D
	JHMzgUm6JzU1pzYe7Uhvz8H13lRmP+29IAFzV6Z3s6whDkWrHpT/7D2PTOFm7QYd
	KMaHQfATsJJK7pqn68Xfm15mSSlr1FFxYKRYoov8m+Y7EmkBGW4qIya7EFkjTUeh
	e5bZ9sZGHvYtn95pnzluZZETjaaZnCZBFWPvhsXhNhLf4XkAWKo7UIFO4+IKF6QX
	wHmRuldE4KzJS0M5+QX2FsPvTrwzBdR/obPGafvs/Ixm6oe5uKVAGQ9MoU286W9S
	pheBm9uyOwH+g0khHsJzzShXmQgSCNytWs/29g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735284462; x=
	1735370862; bh=ykNUns294xzo7WIxHvrtNMZAdAlV/hXQsvEvNs+JgZ4=; b=B
	9Jfeyw/8GgP3oLsDxQEP25V9NfNuW+GLqSL3WrNvtXnjPsqk4E6d8QB4fU5r3JVs
	nIO3rnbOf/YdP/Uj+St3XHbS784ffPRmQGfEKQPF6guY+04khsv8tw1KaESI7djp
	3hauQh0WZb2/glb3RekJBaU3N0PcVNj517Xh0tQ/NFUqG+B+A2JMCz27ZJq/WQe7
	Nx5uLzufI+rhK6TedjJM9Bs3gKx6I3RUDSj790uQvVevzXS1R/5qQojVA94G9mO0
	HOjPdzZN2qbsPWkkgwZctc54Qh3tWMTTJYhMYrbrFA8s+k8Ge+0pBFR8IQ6kYSBO
	se7scqNG1+X4MGOCKSGtA==
X-ME-Sender: <xms:7lZuZ_t785FBHz3ou877iFd8uIWLrDJ9LGdY4K1rIym5j7uhHi_GjQ>
    <xme:7lZuZwdoaSMhi5zeWeGspSEL_Ow4RIZA7hWxUF16uqQWW2ublse9f2gVcFqGcHbbU
    kFLfPL3MIv7hkgNMQ>
X-ME-Received: <xmr:7lZuZyztK7cFvrfsyBMhWGWKtJRU9091Cgf1HdcA6gHKM6SPcc4obetplyNWT5WmZbiIyZqhw6vttij17Di-OGTS3cj7E2dp4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledguddtkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:7lZuZ-PvPIYC727kDM9v6sfzfI-Op_r1wGnLNPrGX6cGm0dbEqh4Fg>
    <xmx:7lZuZ__Z_yIYEwhSrV4e_rOuq0CkXE5lT31U0dEadF0KRTIhxrhFaA>
    <xmx:7lZuZ-WHxV59lVrFnlMBV5MDxN20x2WtehfoICXjEZzqUeQA4X9cCg>
    <xmx:7lZuZwcs7CGcwwL4mb6UsDIvoijwm8yFb-HFSb_zDMw2yt2GizToRQ>
    <xmx:7lZuZyYln6t1yH2rO2ejdiF5skYc8pZ0d3Hn4vc2KQMg4FvRkrbCmIsf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 02:27:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2024, #09; Thu, 26)
X-master-at: 76cf4f61c87855ebf0784b88aaf737d6b09f504b
X-next-at: b6c66824c156363e934b3d989fb123efb1a9c63d
Date: Thu, 26 Dec 2024 23:27:41 -0800
Message-ID: <xmqqjzblvb4i.fsf@gitster.g>
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

Let's wait for gitk and possibly po/ and delay the tagging of the
-rc1.  Many people are already offline for the end-of-year holidays
and it is a slow week, and 'master' front has too many new things
graduated from 'next' a bit too early for me to feel comfortable.

Extra testing the tip of 'master' before we actually tag it is as
always very much appreciated.  Right now, the optional meson-based
build does not pass gitweb tests, IIUC.

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

* as/gitk-git-gui-repo-update (2024-12-26) 1 commit
  (merged to 'next' on 2024-12-26 at 10b9e8227b)
 + Update the official repo of gitk

 The developer documentation has been updated to give the latest
 info on gitk and git-gui maintainer.

 Will merge to 'master'.
 source: <20241224122912.20666-2-ash@kambanaria.org>


* rs/reftable-realloc-errors (2024-12-26) 4 commits
 - t-reftable-merged: check realloc errors
 - reftable: handle realloc error in parse_names()
 - reftable: fix allocation count on realloc error
 - reftable: avoid leaks on realloc error

 The custom allocator code in the reftable library did not handle
 failing realloc() very well, which has been addressed.

 Needs review.
 source: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>

--------------------------------------------------
[Cooking]

* jc/show-index-h-update (2024-12-20) 1 commit
 - show-index: the short help should say the command reads from its input

 Doc and short-help text for "show-index" has been clarified to
 stress that the command reads its data from the standard input.

 Comments?
 source: <xmqqfrmidyhk.fsf@gitster.g>


* ps/the-repository (2024-12-18) 15 commits
 - match-trees: stop using `the_repository`
 - graph: stop using `the_repository`
 - add-interactive: stop using `the_repository`
 - tmp-objdir: stop using `the_repository`
 - resolve-undo: stop using `the_repository`
 - credential: stop using `the_repository`
 - mailinfo: stop using `the_repository`
 - diagnose: stop using `the_repository`
 - server-info: stop using `the_repository`
 - send-pack: stop using `the_repository`
 - serve: stop using `the_repository`
 - trace: stop using `the_repository`
 - pager: stop using `the_repository`
 - progress: stop using `the_repository`
 - Merge branch 'ps/build-sign-compare' into ps/the-repository

 More code paths have a repository passed through the callchain,
 instead of assuming the primary the_repository object.
 source: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>


* ps/build-meson-html (2024-12-13) 11 commits
 - meson: install static files for HTML documentation
 - meson: generate articles
 - Documentation: refactor "howto-index.sh" for out-of-tree builds
 - Documentation: refactor "api-index.sh" for out-of-tree builds
 - meson: generate user manual
 - Documentation: inline user-manual.conf
 - meson: generate HTML pages for all man page categories
 - meson: fix generation of merge tools
 - meson: properly wire up dependencies for our docs
 - meson: wire up support for AsciiDoctor
 - Merge branch 'ps/build' into ps/build-meson-html

 The build procedure based on meson learned to generate HTML
 documention pages.

 Needs review. On hold.
 source: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>


* jc/doc-attr-tree (2024-12-14) 1 commit
 - doc: give attr.tree a bit more visibility

 Make sure that "git --attr-source=X", GIT_ATTR_SOURCE, and
 attr.tree configuration variables appear at the same places in the
 documentation.

 On hold.
 cf. <20241216111112.GA2201417@coredump.intra.peff.net>
 source: <xmqq5xnladwi.fsf@gitster.g>


* ps/3.0-remote-deprecation (2024-12-12) 6 commits
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

 Needs review.
 source: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>


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
