Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88320457E
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372893; cv=none; b=CutKft5aPsTATrfqywaIvDewfxe8jfqTV89PNjeL87qQHxcxA1Jcbb9nmN+gpQdKwo8ATbK8P2+S0pCwLZQm5wEW3EWuZUECCHQxkV2ebOY+nrs4SpYWZbyWc9t/NcNgXPTwktCP5fb/nj1I1MmFc9Y7mP09gq1zQo9Ih6URwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372893; c=relaxed/simple;
	bh=9xNi6fujZ5v577U0gwT/cF1KlVYHS13LdeiVZ7OEBUI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EuLmH2PKOUSr53ZxNXUoV/8ppf69OB3U6flygtJvvSFTg59KuDCVl+9n7d4/PHhYYD2oboAzF6aU59QYgPi4pUpQNKc4hHrKi321YM/kN4YA2pMBzYy/Zpa858bsTHOU+tY5OGae4XDzppeCEJi9FzFPgWocefUaQth8lyhOBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rqHC1M5i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iT2XJ2le; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rqHC1M5i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iT2XJ2le"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C81C01140192;
	Mon, 16 Dec 2024 13:14:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 16 Dec 2024 13:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1734372889; x=1734459289; bh=1eg9tno1NB/TCeIPJ984X8NclJqUc1Yg
	J2w37jfFiwI=; b=rqHC1M5ismaVqg/6l0v5uWjvF7hg3svQXE0vPGqEtqwiSI6S
	e/ZLm2c2WpQatTkie16Tk7f11Z0KReOevuWc2EFCuBhVwgXN/NADy5jkmUArCenp
	NxyaqUlgkpB1k5HOQGGipFXsb5ywy7TI9+rEu66rfEnheRXg3leJMctINF1xag5J
	ujoQB4B4L0jHt87NsbRRz6XrkICHpjc1VhsL6TixAZxba+xDR3r1naLhCo2kgt9O
	ECSkneS8HXUlk0osGNoG1MVeKlQ3wKaV9EccTIcMOB9yvvSBPLQJ7xqXBqCA8h/9
	Wq2zKm2Z4ek8giSXFECXq52s6BCP6HkmWQ9VAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734372889; x=
	1734459289; bh=1eg9tno1NB/TCeIPJ984X8NclJqUc1YgJ2w37jfFiwI=; b=i
	T2XJ2le+cy3ZIU69JYhdbTFeOVV703pOoiHyHjxV1j03Yf6taKLmEQpSXv2CVpNP
	stQjhpReNL6UO5GQJ5Ra+WEGRd+uGjsRQVMwi+xuTLRvJipjpe50aTC8rYxaLR12
	Z4UaX7H7+PncJUSNFOnAIKClpmRbXds92F5f2sl6W+/yD4bKpAzB8GYumrBPUoOi
	PonPNeke4Lz09bta/UfmHyEbembACEDzIMHJLvdMxaqTageAHQYMxmwJZG72sqzb
	U8OLCZBGD4w26njXAUW7F/AhX4FDOFVHWevhOumS80WGXEuKaWcO+rKfUWKzlVNg
	0A5letLsKUuoYcS/zIMlg==
X-ME-Sender: <xms:GW5gZytCLwgcH04GkxJZ50O1CeqVugNr1iTk6LkldBSYIxJ1bfy_-w>
    <xme:GW5gZ3fqK4OYXb7r3cRli5X9Au63QXWpsTpJcS_KAY5B0v_BudjPOzFmvzcCjteJq
    cfOYLopnqEVeFwkxg>
X-ME-Received: <xmr:GW5gZ9wWbp3UcmGE1yOtcLWnJfQo01TWmnvKszRVPiLLqZUkC-fm7oLxnjfYoYF4JSrN2b_uVTFtenF9d6Zf4uiU4CHAhkTkamgkx6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvefggeetke
    dtkeefhedtheetgedtteeuteevfeejjeelueekudejueetueelieffnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtohhmpd
    hgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhmrghkrdguvghvnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlfi
    hnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GW5gZ9PPHBBKSBjY_Vkp8mLyvViEaNjrPW931xG6GWHJRH8AiPTG1g>
    <xmx:GW5gZy_Tw4u2WySoHikfPB-FO92LFgGvdTFL0e1eeSE9cf7TNbDP8g>
    <xmx:GW5gZ1XBV2R-GOulBN66UFNW6GxOYzrNFLZQQ9k-sd8Cm62txqi6YA>
    <xmx:GW5gZ7dACfSgoXH_JeBqVgGUno21q9_B0HhJt-8K6na4yReaNGWO8Q>
    <xmx:GW5gZ2aPx4zO1Xo9HbdW-4tkNrIPye3WdcrAy7guxtVQb05gMZaY5lne>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 13:14:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2024, #06; Mon, 16)
X-master-at: 063bcebf0c917140ca0e705cbe0fdea127e90086
X-next-at: 0fc57dec578fcc8dcda5cc3de6b81fa1f6719770
Date: Mon, 16 Dec 2024 10:14:47 -0800
Message-ID: <xmqqldwf4hrc.fsf@gitster.g>
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

An early preview release Git 2.48-rc0 has been tagged.  The rate of
arrival of new topics unfortunately exceeds the rate of reviews and
iterations, which means that many topics are left out of 'next',
waiting to be reviewed.

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
[Cooking]

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

 Needs review.
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


* ps/ci-meson (2024-12-13) 10 commits
 - ci: wire up Meson builds
 - t: introduce compatibility options to clar-based tests
 - t: fix out-of-tree tests for some git-p4 tests
 - Makefile: detect missing Meson tests
 - meson: detect missing tests at configure time
 - t/unit-tests: rename clar-based unit tests to have a common prefix
 - Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
 - ci/lib: support custom output directories when creating test artifacts
 - Merge branch 'ps/build' into ps/ci-meson
 - Merge branch 'cw/worktree-extension' into ps/ci-meson

 The meson-build procedure is integrated into CI to catch and
 prevent bitrotting.

 Will merge to 'next'.
 cf. <87zfkwgehr.fsf@iotcl.com>
 source: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>


* kn/reflog-migration (2024-12-15) 9 commits
 . refs: add support for migrating reflogs
 . refs: allow multiple reflog entries for the same refname
 . refs: introduce the `ref_transaction_update_reflog` function
 . refs: add `committer_info` to `ref_transaction_add_update()`
 . refs: extract out refname verification in transactions
 . refs/files: add count field to ref_lock
 . refs: add `index` field to `struct ref_udpate`
 . refs: include committer info in `ref_update` struct
 . Merge branch 'kn/reftable-writer-log-write-verify' into kn/reflog-migration
 (this branch uses kn/reftable-writer-log-write-verify.)

 "git refs migrate" learned to also migrate the reflog data across
 backends.

 Does not seem to pass its own test.
 source: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>


* mh/doc-windows-home-env (2024-12-10) 1 commit
  (merged to 'next' on 2024-12-13 at 9f49e6f9dd)
 + Document HOME environment variable

 Doc update.

 Will merge to 'master'.
 source: <pull.1834.git.1733771894867.gitgitgadget@gmail.com>


* tc/bundle-with-tag-remove-workaround (2024-12-12) 1 commit
  (merged to 'next' on 2024-12-13 at 7f4ebe0be3)
 + bundle: remove unneeded code

 "git bundle create" with an annotated tag on the positive end of
 the revision range had a workaround code for older limitation in
 the revision walker, which has become unnecessary.

 Will merge to 'master'.
 source: <20241211-fix-bundle-create-race-v3-1-0587f6f9db1b@iotcl.com>


* cc/lop-remote (2024-12-07) 5 commits
 . doc: add technical design doc for large object promisors
 . promisor-remote: check advertised name or URL
 . Add 'promisor-remote' capability to protocol v2
 . strbuf: refactor strbuf_trim_trailing_ch()
 . version: refactor strbuf_sanitize()

 Expecting a reroll.
 cf. <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
 source: <20241206124248.160494-1-christian.couder@gmail.com>


* ds/backfill (2024-12-09) 7 commits
 - SQUASH??? leakfix
 - backfill: assume --sparse when sparse-checkout is enabled
 - backfill: add --sparse option
 - backfill: add --batch-size=<n> option
 - backfill: basic functionality and tests
 - backfill: add builtin boilerplate
 - Merge branch 'ds/path-walk-1' into ds/backfill
 (this branch uses ds/path-walk-1.)

 source: <pull.1820.git.1733515638.gitgitgadget@gmail.com>


* kn/reftable-writer-log-write-verify (2024-12-07) 1 commit
  (merged to 'next' on 2024-12-15 at 7e6b58d98e)
 + reftable/writer: ensure valid range for log's update_index
 (this branch is used by kn/reflog-migration.)

 Reftable backend adds check for upper limit of log's update_index.

 Will merge to 'master'.
 source: <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>


* ps/ci-gitlab-update (2024-12-12) 4 commits
  (merged to 'next' on 2024-12-15 at e0ca818197)
 + ci/lib: fix "CI setup" sections with GitLab CI
 + ci/lib: do not interpret escape sequences in `group ()` arguments
 + ci/lib: remove duplicate trap to end "CI setup" group
 + gitlab-ci: update macOS images to Sonoma

 GitLab CI updates.

 Will merge to 'master'.
 source: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>


* jc/set-head-symref-fix (2024-12-07) 2 commits
  (merged to 'next' on 2024-12-13 at 478444359e)
 + fetch: do not ask for HEAD unnecessarily
 + Merge branch 'bf/set-head-symref' into js/set-head-symref-fix
 (this branch uses bf/set-head-symref.)

 "git fetch" from a configured remote learned to update a missing
 remote-tracking HEAD but it asked the remote about their HEAD even
 when it did not need to, which has been corrected.  Incidentally,
 this also corrects "git fetch --tags $URL" which was broken by the
 new feature in an unspecified way.

 Will merge to 'master'.
 source: <xmqqcyi5xmhr.fsf@gitster.g>


* re/submodule-parse-opt (2024-12-11) 7 commits
 - git-submodule.sh: rename some variables
 - git-submodule.sh: improve variables readability
 - git-submodule.sh: add some comments
 - git-submodule.sh: get rid of unused variable
 - git-submodule.sh: get rid of isnumber
 - git-submodule.sh: improve parsing of short options
 - git-submodule.sh: improve parsing of some long options

 "git submodule" learned various ways to spell the same option,
 e.g. "--branch=B" can be spelled "--branch B" or "-bB".

 Will merge to 'next'?
 source: <20241210184442.10723-1-royeldar0@gmail.com>


* ps/build-sign-compare (2024-12-06) 16 commits
  (merged to 'next' on 2024-12-16 at 1ddb1485df)
 + t/helper: don't depend on implicit wraparound
 + scalar: address -Wsign-compare warnings
 + builtin/patch-id: fix type of `get_one_patchid()`
 + builtin/blame: fix type of `length` variable when emitting object ID
 + gpg-interface: address -Wsign-comparison warnings
 + daemon: fix type of `max_connections`
 + daemon: fix loops that have mismatching integer types
 + global: trivial conversions to fix `-Wsign-compare` warnings
 + pkt-line: fix -Wsign-compare warning on 32 bit platform
 + csum-file: fix -Wsign-compare warning on 32-bit platform
 + diff.h: fix index used to loop through unsigned integer
 + config.mak.dev: drop `-Wno-sign-compare`
 + global: mark code units that generate warnings with `-Wsign-compare`
 + compat/win32: fix -Wsign-compare warning in "wWinMain()"
 + compat/regex: explicitly ignore "-Wsign-compare" warnings
 + git-compat-util: introduce macros to disable "-Wsign-compare" warnings

 Start working to make the codebase buildable with -Wsign-compare.

 Will merge to 'master'.
 source: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>


* bf/fetch-set-head-config (2024-12-06) 5 commits
  (merged to 'next' on 2024-12-11 at 900cadd7b7)
 + remote set-head: set followRemoteHEAD to "warn" if "always"
 + fetch set_head: add warn-if-not-$branch option
 + fetch set_head: move warn advice into advise_if_enabled
  (merged to 'next' on 2024-12-04 at 69bfc59fb5)
 + fetch: add configuration for set_head behaviour
 + Merge branch 'bf/set-head-symref' into bf/fetch-set-head-config
 (this branch uses bf/set-head-symref.)

 "git fetch" honors "remote.<remote>.followRemoteHEAD" settings to
 tweak the remote-tracking HEAD in "refs/remotes/<remote>/HEAD".

 Will merge to 'master' after bf/set-head-symref and its fix-up.
 source: <20241128230806.2058962-1-bence@ferdinandy.com>
 source: <20241204104003.514905-1-bence@ferdinandy.com>
 source: <20241128111946.366584-1-bence@ferdinandy.com>


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


* js/log-remerge-keep-ancestry (2024-12-13) 1 commit
  (merged to 'next' on 2024-12-13 at 90156d79ed)
 + log: --remerge-diff needs to keep around commit parents
 (this branch is used by js/range-diff-diff-merges.)

 "git log -p --remerge-diff --reverse" was completely broken.

 Will merge to 'master'.
 source: <pull.1825.v3.git.1733999352289.gitgitgadget@gmail.com>


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


* js/range-diff-diff-merges (2024-12-16) 3 commits
 - range-diff: introduce the convenience option `--remerge-diff`
 - range-diff: optionally include merge commits' diffs in the analysis
 - Merge branch 'js/log-remerge-keep-ancestry' into js/range-diff-diff-merges
 (this branch uses js/log-remerge-keep-ancestry.)

 "git range-diff" learned to optionally show and compare merge
 commits in the ranges being compared, with the --diff-merges
 option.

 Will merge to 'next'?
 source: <pull.1734.v3.git.1734358282.gitgitgadget@gmail.com>


* ds/name-hash-tweaks (2024-12-03) 8 commits
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
 source: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>


* ds/path-walk-1 (2024-12-07) 7 commits
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

 Under review.
 source: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>


* as/show-index-uninitialized-hash (2024-11-11) 2 commits
  (merged to 'next' on 2024-12-16 at b54e9a56f0)
 + t5300: add test for 'show-index --object-format'
 + show-index: fix uninitialized hash function

 Regression fix for 'show-index' when run outside of a repository.

 Will merge to 'master'.
 source: <20241109092739.14276-1-abhijeet.nkt@gmail.com>


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


* bf/set-head-symref (2024-11-25) 10 commits
  (merged to 'next' on 2024-12-02 at b142ff3d8e)
 + fetch set_head: handle mirrored bare repositories
 + fetch: set remote/HEAD if it does not exist
 + refs: add create_only option to refs_update_symref_extended
 + refs: add TRANSACTION_CREATE_EXISTS error
 + remote set-head: better output for --auto
 + remote set-head: refactor for readability
 + refs: atomically record overwritten ref in update_symref
 + refs: standardize output of refs_read_symbolic_ref
 + t/t5505-remote: test failure of set-head
 + t/t5505-remote: set default branch to main
 (this branch is used by bf/fetch-set-head-config and jc/set-head-symref-fix.)

 When "git fetch $remote" notices that refs/remotes/$remote/HEAD is
 missing and discovers what branch the other side points with its
 HEAD, refs/remotes/$remote/HEAD is updated to point to it.

 Will merge to 'master' together with jc/set-head-symref-fix.
 source: <20241122123138.66960-1-bence@ferdinandy.com>


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

--------------------------------------------------
[Discarded]

* js/set-head-symref-fix (2024-12-06) 2 commits
 . Fix `git fetch --tags` in repo with no configured remote
 - Merge branch 'bf/set-head-symref' into js/set-head-symref-fix
 (this branch uses bf/set-head-symref.)

 Superseded by jc/set-head-symref-fix
 source: <b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
