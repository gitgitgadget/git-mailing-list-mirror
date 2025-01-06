Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F11D5CF4
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193753; cv=none; b=L6Dt17xQFNlW7nF1KMT98W2RaacQ6ieXjSZuxXqEUhNUREYPxFs4TTl/opaWM+6SwnW4iRpTX0Kc1gPDgrqIBVMVghucPiobUfrgPS3VjoDuoTufI2qwac9kUe8gPXjNI62AO9pHZgqKOSXBJ4jvnjz3E72ozSsIRWZCVcGkfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193753; c=relaxed/simple;
	bh=eQJjmxXsPMp2GhwJqWlXPg97FunZxR3vgdjvxMh/Q/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/00RNCBmCgIYpiC+hgc6UuFh/hHTy4CvcFdOfrHUTbPCWi4/Sym3PVIAlzHjWoLnjCXox/wTu2ImYrBj52gCgpmteSxUVLbMhLyv8dlsUZD5V5pR10OhV1t1zFLZxdAO6/xCaw++erA1cix+6PvPLIPIXT6HhGD0K4kuOyUrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OywbZRe6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYDfwrLD; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OywbZRe6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYDfwrLD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B6DD1380950;
	Mon,  6 Jan 2025 15:02:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jan 2025 15:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1736193748; x=1736280148; bh=M9z8nl4olDLWHX8qbEpSNbVrHZzZKYXd
	MUwY8EUZ6rM=; b=OywbZRe6JnJOWhStM1lwJQ8t6jphYAsodhqvhLDBruhKVFiC
	bSysx88U27q/jZJTtv9PErpImuZt9Wis52/4nFlFf0iLukY6aXVh+0Dq21QUq05R
	MdcAQVZYGp3qcL5BMycMZ8wuRjNm19KKdEhbxXV9el1/GN5TPmEnc8bA9xeVWTcS
	ETVJKDDgEcnx6P9Oa5PCZN8JyEAV6okJL3nuuitmfLQfweKseFq5qNBRyaJV8oJo
	S9r8O7VD3+ZGPSpbDotToVKDQpT8SH+hlkhDXwkMv7yznDOXzioEzGcC5oJxWEZq
	N6se6cju9l3BrYa7XDSt2ZZ/mrBUzAxwlvxoug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736193748; x=
	1736280148; bh=M9z8nl4olDLWHX8qbEpSNbVrHZzZKYXdMUwY8EUZ6rM=; b=F
	YDfwrLDzDGydWRRFt1Dmxp50IodRvm0fe58ndmjog+HHGJzq0pWhnl11Lldhp1I2
	uju7uUG514+EHUiw9rVzoYHLoGP7CFa39j1wHpNLsiliMGwPQJC7Ko6gVdDs6b8k
	p627uktgqyfTpSNn1gkdTHpBln9uCW1a4q8U2LBFhuflsu8oTNDzrBBytvERJzrb
	ASnwEUsXjrUMG7TJf3hRF1vKa8Y+z6/7fwvpSSG+q9CZuEUMA/+mlqlzfI0eVgLP
	NnwHWgFH13UhSXCTScHIRWvtKmbQFMIajfvdKZHg3KECQ+NgSOB5Ql2Htl95sIpS
	viy66B1r/WzZWDmkKAHVg==
X-ME-Sender: <xms:1DZ8Z0kzXytwhSy4gJaiiBUK0fqkiBsG5jTWJvWdyNU1F3TZ7wHcLw>
    <xme:1DZ8Zz2I3tyRczPe1DNozMkabQXafAS9XKR0vbyou2ZeBJFS4suZ_Jqw-Bo6OJvXe
    wWJAYHTyAIzeY-PLA>
X-ME-Received: <xmr:1DZ8Zyoow26qa8Qwxlwup5Kb6-Q9WeoMnwGEg-Xtrz6x8W9vRS2pTMXLweitTHyY0JjmobXxWi3S4NMMYp0SXDfuore33MSWDvhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgudefvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:1DZ8ZwlCyTalnViXAYpzkHsKT4uxBobIJrOvoA8t9NzU0YYJF5hrnQ>
    <xmx:1DZ8Zy34lA8HZIjtKGy7Nl839X1_nnpbEiyPszFYf6ht2DEfJxM4KA>
    <xmx:1DZ8Z3u1yMkY272qOMxHNQdjq8v8R1g4lhs06AtYaypitdnNlSNvJw>
    <xmx:1DZ8Z-VYg6cQHrlboSi_FGUx4f_ZLQ-p5AUKpKHPunmmddnwQgmg_A>
    <xmx:1DZ8Z3wvBjFTpWO_H-wQGUPI5ZWt9vMelDrkVUNn1bXwHSJvn_ZnMfLZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 15:02:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jan 2025, #02; Mon, 6)
X-master-at: b74ff38af58464688b211140b90ec90598d340c6
X-next-at: 9ec6785566993ea05d28010e7a742dc2d8f0daae
Date: Mon, 06 Jan 2025 12:02:26 -0800
Message-ID: <xmqq5xmryalp.fsf@gitster.g>
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

Git 2.48-rc2 has been tagged.  I expect there will be a few more
"finishing touches" before the final release is tagged later this
week.  Extra testing the tip of 'master' before we actually tag it
is as always very much appreciated.

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

* jc/doc-opt-tilde-expand (2025-01-03) 1 commit
  (merged to 'next' on 2025-01-03 at b3e6e7acbc)
 + gitcli.txt: typeset pathnames as monospace

 Docfix.

 Will merge to 'next' and then to 'master'.
 source: <6e0abe96b60a94d4fdee15a45b7d53c2f44a0c69.1735903029.git.martin.agren@gmail.com>


* mh/doc-windows-home-env (2025-01-03) 1 commit
  (merged to 'next' on 2025-01-03 at 1d4db69ce0)
 + git.txt: fix heading line of tildes

 Docfix.

 Will merge to 'next' and then to 'master'.
 source: <50e47d14a8a0a2ca0dd158f01b833a28c7b46887.1735903029.git.martin.agren@gmail.com>

--------------------------------------------------
[New Topics]

* ja/doc-notes-markup-updates (2025-01-03) 1 commit
 - doc: git-notes.txt: migrate to new documentation format

 Doc mark-up updates.

 source: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>


* mb/t7110-use-test-path-helper (2025-01-03) 1 commit
 - t7110: replace `test -f` with `test_path_is_*` helpers

 Test modernization.

 Will merge to 'next'.
 source: <20250103130035.79376-1-matteobagnolini2003@gmail.com>


* bf/fetch-set-head-config (2025-01-06) 1 commit
  (merged to 'next' on 2025-01-06 at 841c3a38a6)
 + fetch: fix erroneous set_head advice message

 A hotfix on an advice messagge added during this cycle.

 Will merge to 'master'.
 source: <20250105161017.210412-1-bence@ferdinandy.com>


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

--------------------------------------------------
[Cooking]

* ja/doc-commit-markup-updates (2025-01-03) 3 commits
 - doc: git-commit: migrate secondary files to new format
 - doc: git-commit.txt: convert git commit config to new format
 - doc: git-commit: apply new documentation guidelines

 Doc updates.
 source: <pull.1845.git.1735912046.gitgitgadget@gmail.com>


* ps/ci-misc-updates (2025-01-06) 10 commits
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
 source: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>


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
