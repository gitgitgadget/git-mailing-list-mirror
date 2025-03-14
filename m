Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8120468F
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973805; cv=none; b=eW/Pgn10ffsNif8M2yhPM6lNUTUTuwxd4WZF4/R5S3HENT0lpfY4Omuzlq53sYLtFyBaT/jVTaDWxEDsfe5BdpEL2+108EFGSbz1J6uIHS/G/JM/3RP0cJtmSlrMa92xm601czC0Osyf1MP4qIWnPQKtDad6ts3q1i+W/r4sW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973805; c=relaxed/simple;
	bh=+65rHD3X2J+nr2uDoX2UmGZsnr7s+8qcV9kMTVoEyR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRXRCua97LDRzUh83ABYc2bsIHaLi2M51mzKq9UijRbWPMFn0VDl8VaOcgODfqv+rm86BiYXq76AsL/jgVHm5hCSYeRJKyRvE3yoAPoNszeetsW380WXwpQPQZcpGzsqqXH2PJpNv5GgpKywBOCIqBsIewID+sBVVniBO+9qoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bqRynQwF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ooFcxPPI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bqRynQwF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ooFcxPPI"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8179A1140143;
	Fri, 14 Mar 2025 13:36:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 13:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1741973801; x=1742060201; bh=e13m5gjm21ZqRy484pHyrwp3HnEF2hAV
	VdVJHTrxo8I=; b=bqRynQwFwRESimWhC1TTLWr6BI+coEVqt1QQMlXhbnQZttH1
	sDu9RfChEJqQ1bkUfNiU6QiT+m8/LGWUOVe8EbLNgCAO8/4TsW+vJtS2T+9RT23b
	RGQDzIVJDw1Ee3kCr/GQFLVD8vnp6K4/ckQTxlRxL+ivbAfRwlmgZgqcVznfIk16
	MylaYgvo3kbB6pYuA5c3bQiybolLyxmEmA4nXdj2/dnh7tbYf0KE6Pja44xG/lbW
	mn8l1XVE+8ei+5mUyyYuAzPh7GuuYNZGRjeSbF7PiTvDxnO4Hn67YEFCVi78HWbc
	9VP7R4Qw92C7EItVatCubKPJjRWIljwQjL1yTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741973801; x=
	1742060201; bh=e13m5gjm21ZqRy484pHyrwp3HnEF2hAVVdVJHTrxo8I=; b=o
	oFcxPPIohnUJTd9dfbq8uS1p1YsfiWys/DWrZWRcyYaVLqqN3mF7MuIuvJ3vhbqu
	Iu6qMogXa/Qf3HGZ4u9crBmJcjE6LfZmzPDl6yaGr4SgdIBwiMBcEhAjE095nvck
	vKM13yHhqeepG9hugOzDFOKKu1+A/Tyh/agGBq2AzH9HeTHVdnmvOClZ3nomY5Zo
	JEBj7TOUxajWpxRm8OptwEPovUAb4W4BFnGyFblCopPCN226IJ2HPTOkAqUNb9kX
	bbRfdrYUgWupjlh0fAUai8rSzz6YtgpjaoYjPMuNKR1z9KrBhIek/CAjilB2EFhK
	7r2BnLjFeTr2wl611HHxw==
X-ME-Sender: <xms:KWnUZ75PorCN8AeOgkvX9fjNesbKCOx4TntJeO3soqo64llCq6wChg>
    <xme:KWnUZw7E3pfk64vAESTo8OWVaLq6AScdcsO5SPynAVcKPaaOnTLyehmmk2unooulX
    7YCfVwhnP4xtNDMJg>
X-ME-Received: <xmr:KWnUZydmRqaturOtuifYD31_viDqtj32ZVVU1gWKVL-xCLG5YnC_p3r380wKlKFY-08KKm2DgoEnm_Ye813yCujPgAQl2tZ_Ku8G6xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvefgge
    etkedtkeefhedtheetgedtteeuteevfeejjeelueekudejueetueelieffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpohhrrdgtiidpghhoohhglhgvshhouhhrtggvrdgtoh
    hmpdhgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhmrghkrdguvghvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:KWnUZ8L0l04GpSUS6ELsYKwtRuUy93oErbLjZ6TSWIaSV7YoeK5GKQ>
    <xmx:KWnUZ_JGtRcRlM9LRVjQLdks0nWTxNwjJPyNUrxSHFJnGzd-k1iqKw>
    <xmx:KWnUZ1w967k4Ggvwd-1HaLihTiuY0lh-wt74ZnQqSZqGO6Jw261cdQ>
    <xmx:KWnUZ7JZt00ni84Bd6EgTlyffvE1HslA7SQaPvfoKZ9R-WWq0d5JxQ>
    <xmx:KWnUZ31yY_pU9tx6pAApvPRswE6hv1qEvbjuGC0zb8J-eaHkclc_YxDW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:36:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2025, #04; Fri, 14)
X-master-at: 683c54c999c301c2cd6f715c411407c413b1d84e
X-next-at: d1b26642dacc169ed6e4a1495e3fa114e8b27faa
Date: Fri, 14 Mar 2025 10:36:39 -0700
Message-ID: <xmqqv7sbfra0.fsf@gitster.g>
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

Git 2.49 final has been tagged.

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

* en/diff-rename-follow-fix (2025-03-13) 1 commit
 - diffcore-rename: fix BUG when break detection and --follow used together

 A corner-case bug in "git log --follow -B" has been fixed.

 Will merge to 'next'.
 source: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* en/merge-ort-prepare-to-remove-recursive (2025-03-13) 6 commits
 - am: switch from merge_recursive_generic() to merge_ort_generic()
 - merge-ort: fix merge.directoryRenames=false
 - t3650: document bug when directory renames are turned off
 - merge-ort: support having merge verbosity be set to 0
 - merge-ort: allow rename detection to be disabled
 - merge-ort: add new merge_ort_generic() function

 First step of deprecating and removing merge-recursive.

 Will merge to 'next'.
 source: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>


* jk/use-wunreachable-code-for-devs (2025-03-07) 1 commit
  (merged to 'next' on 2025-03-07 at b5c54fea6a)
 + config.mak.dev: enable -Wunreachable-code

 Enable -Wunreachable-code for developer builds.

 Reverted out of 'next', as macOS CI job stops with a false positive.
 cf. <20250310160440.GA26189@coredump.intra.peff.net>
 source: <20250307225444.GA42758@coredump.intra.peff.net>


* ab/decorate-code-cleanup (2025-03-10) 1 commit
 - decorate: fix sign comparison warnings

 Code clean-up.

 Will merge to 'next'.
 source: <7c219279-8151-49c0-8fc0-8abe2624aca9@gmail.com>


* ds/path-walk-2 (2025-03-10) 13 commits
 - pack-objects: allow --shallow and --path-walk
 - path-walk: add new 'edge_aggressive' option
 - pack-objects: thread the path-based compression
 - pack-objects: refactor path-walk delta phase
 - scalar: enable path-walk during push via config
 - pack-objects: enable --path-walk via config
 - repack: add --path-walk option
 - t5538: add tests to confirm deltas in shallow pushes
 - pack-objects: introduce GIT_TEST_PACK_PATH_WALK
 - p5313: add performance tests for --path-walk
 - pack-objects: update usage to match docs
 - pack-objects: add --path-walk option
 - pack-objects: extract should_attempt_deltas()

 "git pack-objects" learns to find delta bases from blobs at the
 same path, using the --path-walk API.
 source: <pull.1819.git.1741571455.gitgitgadget@gmail.com>


* ja/doc-block-delimiter-markup-fix (2025-03-10) 1 commit
  (merged to 'next' on 2025-03-11 at 8d6641a77e)
 + doc: add a blank line around block delimiters

 Doc markup updates.

 Will cook in 'next'.
 source: <pull.1878.git.1741549511665.gitgitgadget@gmail.com>


* jc/name-rev-stdin (2025-03-12) 6 commits
 - name-rev: remove "--stdin" support
 - t6120: further modernize
 - t6120: avoid hiding "git" exit status
 - t: introduce WITH_BREAKING_CHANGES prerequisite
 - t: extend test_lazy_prereq
 - t: document test_lazy_prereq

 Using "git name-rev --stdin" as an example, improve the framework to
 prepare tests to pretend to be in the future where the breaking
 changes have already happened.

 Will merge to 'next'.
 source: <20250311212505.2920181-1-gitster@pobox.com>


* jk/fetch-ref-prefix-cleanup (2025-03-10) 9 commits
 - fetch: use ref prefix list to skip ls-refs
 - fetch: avoid ls-refs only to ask for HEAD symref update
 - fetch: stop protecting additions to ref-prefix list
 - fetch: ask server to advertise HEAD for config-less fetch
 - refspec_ref_prefixes(): clean up refspec_item logic
 - t5516: beef up exact-oid ref prefixes test
 - t5516: drop NEEDSWORK about v2 reachability behavior
 - t5516: prefer "oid" to "sha1" in some test titles
 - t5702: fix typo in test name

 In protocol v2 where the refs advertisement is constrained, we try
 to tell the server side not to limit the advertisement when there
 is no specific need to, which has been the source of confusion and
 recent bugs.  Revamp the logic to simplify.

 Will merge to 'next'.
 source: <20250309030101.GA2334064@coredump.intra.peff.net>


* jt/rev-list-z (2025-03-13) 6 commits
 - rev-list: support NUL-delimited --missing option
 - rev-list: support NUL-delimited --boundary option
 - rev-list: support delimiting objects with NUL bytes
 - revision: support NUL-delimited --stdin mode
 - rev-list: refactor early option parsing
 - rev-list: inline `show_object_with_name()` in `show_object()`

 "git rev-list" learns machine-parsable output format that delimits
 each field with NUL.

 Will merge to 'next'?
 source: <20250313001706.3390502-1-jltobler@gmail.com>


* kn/reflog-drop (2025-03-10) 1 commit
 - reflog: implement subcommand to drop reflogs

 "git reflog" learns "drop" subcommand, that discards the entire
 reflog data for a ref.

 Will merge to 'next'?
 source: <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>


* am/dir-dedup-decl-of-repository (2025-03-11) 1 commit
 - dir.h: remove duplicate forward declaration of struct repository

 Code cleanup.

 Will merge to 'next'.
 source: <pull.1879.git.1741705175922.gitgitgadget@gmail.com>


* cc/lop-remote (2025-03-13) 1 commit
 - promisor-remote: fix segfault when remote URL is missing

 Bugfix in newly introduced large-object-promisor remote support.

 Will merge to 'next'?
 source: <20250313103859.817127-1-christian.couder@gmail.com>


* ps/ci-meson-check-build-docs (2025-03-12) 1 commit
 - ci: perform build and smoke tests for Meson docs

 CI update.

 Will merge to 'next'.
 source: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>


* ps/meson-with-breaking-changes (2025-03-12) 3 commits
 - meson: don't install git-pack-redundant(1) docs with breaking changes
 - meson: don't compile git-pack-redundant(1) with breaking changes
 - meson: define WITH_BREAKING_CHANGES when enabling breaking changes

 Update meson based build procedure for breaking changes support.

 Will merge to 'next'.
 source: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>


* md/t1403-path-is-file (2025-03-04) 1 commit
 - t1403: verify that path exists and is a file

 Test tweak.
 source: <20250304112728.41228-2-danimahendra0904@gmail.com>


* sk/clar-trailer-urlmatch-norm-test (2025-03-04) 2 commits
 - t/unit-tests: convert urlmatch-normalization test to clar
 - t/unit-tests: convert trailer test to use clar

 A few traditional unit tests have been rewritten to use the clar
 framework.

 Comments?
 source: <20250304113323.10564-1-kuforiji98@gmail.com>


* dm/completion-remote-names-fix (2025-03-05) 2 commits
 - completion: fix bugs with slashes in remote names
 - completion: add helper to count path components

 The bash command line completion script (in contrib/) has been
 updated to cope with remote repository nicknames with slashes in
 them.

 Comments?
 source: <d5860dbe1e6a149d72739af3271369b3@mandelberg.org>


* tb/refs-exclude-fixes (2025-03-06) 2 commits
  (merged to 'next' on 2025-03-06 at 50707f29db)
 + refs.c: stop matching non-directory prefixes in exclude patterns
 + refs.c: remove empty '--exclude' patterns

 The refname exclusion logic in the packed-ref backend has been
 broken for some time, which confused upload-pack to advertise
 different set of refs.  This has been corrected.

 Will cook in 'next'.
 source: <cover.1741275245.git.me@ttaylorr.com>


* en/merge-process-renames-crash-fix (2025-03-06) 2 commits
  (merged to 'next' on 2025-03-06 at 8f38331e32)
 + merge-ort: fix slightly overzealous assertion for rename-to-self
 + t6423: add a testcase causing a failed assertion in process_renames

 The merge-recursive and merge-ort machinery crashed in corner cases
 when certain renames are involved.

 Will cook in 'next'.
 source: <pull.1873.git.1741275027.gitgitgadget@gmail.com>


* kn/non-transactional-batch-updates (2025-03-12) 9 commits
 . update-ref: add --allow-partial flag for stdin mode
 . refs: support partial update rejections during F/D checks
 . refs: implement partial reference transaction support
 . refs: introduce enum-based transaction error types
 . refs/reftable: extract code from the transaction preparation
 . refs/files: remove duplicate duplicates check
 . refs: move duplicate refname update check to generic layer
 . refs/files: remove redundant check in split_symref_update()
 . Merge branch 'ps/refname-avail-check-optim' into kn/non-transactional-batch-updates
 (this branch uses ps/refname-avail-check-optim.)

 Updating multiple references have only been possible in all-or-none
 fashion with transactions, but it can be more efficient to batch
 multiple updates even when some of them are allowed to fail in a
 best-effort manner.  A new "best effort batches of updates" mode
 has been introduced.

 Trips up -Wunreachable-code checker.
 source: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>


* ps/object-wo-the-repository (2025-03-10) 12 commits
 - hash: stop depending on `the_repository` in `null_oid()`
 - hash: fix "-Wsign-compare" warnings
 - object-file: split out logic regarding hash algorithms
 - delta-islands: stop depending on `the_repository`
 - object-file-convert: stop depending on `the_repository`
 - pack-bitmap-write: stop depending on `the_repository`
 - pack-revindex: stop depending on `the_repository`
 - pack-check: stop depending on `the_repository`
 - environment: move access to "core.bigFileThreshold" into repo settings
 - pack-write: stop depending on `the_repository` and `the_hash_algo`
 - object: stop depending on `the_repository`
 - csum-file: stop depending on `the_repository`

 The object layer has been updated to take an explicit repository
 instance as a parameter in more code paths.

 Looking good.
 source: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>


* ua/some-builtins-wo-the-repository (2025-03-07) 8 commits
  (merged to 'next' on 2025-03-07 at 01f2b84529)
 + builtin/checkout-index: stop using `the_repository`
 + builtin/for-each-ref: stop using `the_repository`
 + builtin/ls-files: stop using `the_repository`
 + builtin/pack-refs: stop using `the_repository`
 + builtin/send-pack: stop using `the_repository`
 + builtin/verify-commit: stop using `the_repository`
 + builtin/verify-tag: stop using `the_repository`
 + config: teach repo_config to allow `repo` to be NULL

 A handful of built-in command implementations have been rewritten
 to use the repository instance supplied by git.c:run_builtin(), its
 caller.

 Will cook in 'next'.
 source: <20250307233543.1721552-1-usmanakinyemi202@gmail.com>


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


* ps/refname-avail-check-optim (2025-03-12) 16 commits
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
 (this branch is used by kn/non-transactional-batch-updates.)

 The code paths to check whether a refname X is available (by seeing
 if another ref X/Y exists, etc.) have been optimized.

 Will merge to 'next'.
 source: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>


* tb/multi-cruft-pack-refresh-fix (2025-03-13) 1 commit
 - builtin/pack-objects.c: freshen objects from existing cruft packs

 Certain "cruft" objects would have never been refreshed when there
 are multiple cruft packs in the repository, which has been
 corrected.

 Will merge to 'next'.
 source: <1563552bbda0bc910c9f41b0fabc3225c4d778fc.1741889018.git.me@ttaylorr.com>


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

 Still being discussed.
 cf. <20250304065501.GB1283901@coredump.intra.peff.net>
 source: <20250225062518.GA1293854@coredump.intra.peff.net>


* cc/signed-fast-export-import (2025-03-10) 6 commits
 - fast-export, fast-import: add support for signed-commits
 - fast-export: do not modify memory from get_commit_buffer
 - git-fast-export.adoc: clarify why 'verbatim' may not be a good idea
 - fast-export: rename --signed-tags='warn' to 'warn-verbatim'
 - fast-export: fix missing whitespace after switch
 - git-fast-import.adoc: add missing LF in the BNF

 "git fast-export | git fast-import" learns to deal with commit and
 tag objects with embedded signatures a bit better.

 Will merge to 'next'.
 cf. <CABPp-BGyA8iBA0BFO8FcpZAMca94aVu2vHHRi4Oz=nCWxJSDPg@mail.gmail.com>
 source: <20250310155746.879481-1-christian.couder@gmail.com>


* jt/diff-pairs (2025-03-03) 4 commits
  (merged to 'next' on 2025-03-03 at 32346e0c3b)
 + builtin/diff-pairs: allow explicit diff queue flush
 + builtin: introduce diff-pairs command
 + diff: add option to skip resolving diff statuses
 + diff: return diff_filepair from diff queue helpers

 A post-processing filter for "diff --raw" output has been
 introduced.

 Will cook in 'next'.
 source: <20250228213346.1335224-1-jltobler@gmail.com>


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
  (merged to 'next' on 2025-03-05 at 6bea9376c4)
 + builtin/fsck: add `git refs verify` child process
 + packed-backend: check whether the "packed-refs" is sorted
 + packed-backend: add "packed-refs" entry consistency check
 + packed-backend: check whether the refname contains NUL characters
 + packed-backend: add "packed-refs" header consistency check
 + packed-backend: check if header starts with "# pack-refs with: "
 + packed-backend: check whether the "packed-refs" is regular file
 + builtin/refs: get worktrees without reading head information
 + t0602: use subshell to ensure working directory unchanged

 "git fsck" becomes more careful when checking the refs.

 Will cook in 'next'.
 source: <Z8CMx7O19PMs9sVY@ArchLinux>


* jc/doc-attr-tree (2024-12-14) 1 commit
 - doc: give attr.tree a bit more visibility

 Make sure that "git --attr-source=X", GIT_ATTR_SOURCE, and
 attr.tree configuration variables appear at the same places in the
 documentation.

 On hold.
 cf. <20241216111112.GA2201417@coredump.intra.peff.net>
 source: <xmqq5xnladwi.fsf@gitster.g>


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

 Expecting a (hopefully minor and final) reroll.
 cf. <Z8JSreTnEFlocYQ9@nand.local> <Z8JLbxBQh7XUpplz@nand.local>
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
