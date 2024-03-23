Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539AA7F
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711155272; cv=none; b=pfc2Q0vjA5gBW+sqLgUM15kz4jy3GRJh1A1Fmg+BtdJxux58Ne+9PEjq4VGC/UdCbgQA7XkS8FbAmgTeGWZpyRh5qqPtKwzhQNJzTIJA8v1CQxplO79Xi6yIERikzY8TUwDcOn8cYto1cfynZ9rT457N04lWwLyYi07hfZwa+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711155272; c=relaxed/simple;
	bh=r1u3icN+46hT6l+YL4RKE03gJ7tuekgvkHQKCvGPL8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rEBKt4aQPYSz5RLbrkWjFv3iMosMHeRlNnlBj1L3nvp+o5k8Ls8MigUMbxje4xJl1ytCqjYURH3TXKoIuov0fdpH8rrUn9aMj0uyUF4hXjsp7H4kVwRZ4InAopPgU/bqetLGZ2hIFd8PqIGnw2vgTDW5vMOZDUeElws7hU78N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z2lUNiUs; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z2lUNiUs"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FEE61F7E68;
	Fri, 22 Mar 2024 20:54:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	1u3icN+46hT6l+YL4RKE03gJ7tuekgvkHQKCvGPL8w=; b=Z2lUNiUsZXCdrC+DS
	bOUReCCOTnXzcfWyAYqH8BYHPnX9o3PhW0bLaZCkhfHJkbfZhPSluaKKhq1/fbZW
	7srN0AfgWLMWxo7/m//TdRB/BlA5vIDzyf4zJ550uCINi82GhwbkJm+1xpEDFa7A
	ZtZrsWZRdk3Y4YVZ6OpuLdxkhc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 069591F7E65;
	Fri, 22 Mar 2024 20:54:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 448AB1F7E5E;
	Fri, 22 Mar 2024 20:54:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2024, #07; Fri, 22)
X-master-at: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
X-next-at: 2796f347adbd255e43ba5d93f092851042834c28
Date: Fri, 22 Mar 2024 17:54:26 -0700
Message-ID: <xmqqedc1zs1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E622265C-E8AF-11EE-ADF8-25B3960A682E-77302942!pb-smtp2.pobox.com

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

* bb/iso-strict-utc (2024-03-13) 1 commit
  (merged to 'next' on 2024-03-14 at d2ac616873)
 + date: make "iso-strict" conforming for the UTC timezone

 The output format for dates "iso-strict" has been tweaked to show
 a time in the Zulu timezone with "Z" suffix, instead of "+00:00".
 source: <20240313225423.11373-1-dev+git@drbeat.li>


* bb/t0006-negative-tz-offset (2024-03-14) 1 commit
  (merged to 'next' on 2024-03-14 at 3f4751b6b2)
 + t0006: add more tests with a negative TZ offset

 More tests on showing time with negative TZ offset.
 source: <20240314085512.1827031-1-dev+git@drbeat.li>


* dg/user-manual-hash-example (2024-03-12) 1 commit
  (merged to 'next' on 2024-03-14 at 767800d3a7)
 + Documentation/user-manual.txt: example for generating object hashes

 User manual (the original one) update.
 source: <20240312104238.4920-2-dirk@gouders.net>


* fs/find-end-of-log-message-fix (2024-03-07) 1 commit
  (merged to 'next' on 2024-03-13 at 2bed63caaf)
 + wt-status: don't find scissors line beyond buf len

 The code to find the effective end of log message can fall into an
 endless loop, which has been corrected.
 cf. <08b9b37d-f0f8-4c1a-b72e-194202ff3d9f@nutanix.com>
 source: <20240307183743.219951-1-flosch@nutanix.com>


* ja/doc-markup-fixes (2024-03-11) 6 commits
  (merged to 'next' on 2024-03-14 at 4d1c26143f)
 + doc: git-clone: format placeholders
 + doc: git-clone: format verbatim words
 + doc: git-init: rework config item init.templateDir
 + doc: git-init: rework definition lists
 + doc: git-init: format placeholders
 + doc: git-init: format verbatim parts

 Mark-ups used in the documentation has been improved for
 consistency.
 source: <pull.1687.git.1710097830.gitgitgadget@gmail.com>


* jc/safe-implicit-bare (2024-03-11) 1 commit
  (merged to 'next' on 2024-03-14 at e8bdbed1a4)
 + setup: notice more types of implicit bare repositories

 Users with safe.bareRepository=explicit can still work from within
 $GIT_DIR of a seconary worktree (which resides at .git/worktrees/$name/)
 of the primary worktree without explicitly specifying the $GIT_DIR
 environment variable or the --git-dir=<path> option.
 source: <xmqq5xxv0ywi.fsf_-_@gitster.g>


* jw/doc-show-untracked-files-fix (2024-03-13) 1 commit
  (merged to 'next' on 2024-03-14 at 091f64ad6c)
 + doc: status.showUntrackedFiles does not take "false"

 The status.showUntrackedFiles configuration variable was
 incorrectly documented to accept "false", which has been corrected.
 source: <pull.1686.git.git.1710279251901.gitgitgadget@gmail.com>


* pb/ci-win-artifact-names-fix (2024-03-11) 1 commit
  (merged to 'next' on 2024-03-14 at 5076389536)
 + ci(github): make Windows test artifacts name unique

 CI update.
 source: <pull.1688.git.1710101097072.gitgitgadget@gmail.com>


* ps/reftable-block-search-fix (2024-03-07) 2 commits
  (merged to 'next' on 2024-03-13 at 34938e24ab)
 + reftable/block: fix binary search over restart counter
 + reftable/record: fix memory leak when decoding object records

 The reftable code has its own custom binary search function whose
 comparison callback has an unusual interface, which caused the
 binary search to degenerate into a linear search, which has been
 corrected.
 source: <cover.1709843663.git.ps@pks.im>


* ps/reftable-reflog-iteration-perf (2024-03-05) 8 commits
  (merged to 'next' on 2024-03-14 at 72465c29be)
 + refs/reftable: track last log record name via strbuf
 + reftable/record: use scratch buffer when decoding records
 + reftable/record: reuse message when decoding log records
 + reftable/record: reuse refnames when decoding log records
 + reftable/record: avoid copying author info
 + reftable/record: convert old and new object IDs to arrays
 + refs/reftable: reload correct stack when creating reflog iter
 + Merge branch 'ps/reftable-iteration-perf-part2' into ps/reftable-reflog-iteration-perf

 The code to iterate over reflogs in the reftable has been optimized
 to reduce memory allocation and deallocation.

 Reviewed-by: Josh Steadmon <steadmon@google.com>
 cf. <Ze9eX-aaWoVaqsPP@google.com>
 source: <cover.1709640322.git.ps@pks.im>


* ps/reftable-stack-tempfile (2024-03-07) 4 commits
  (merged to 'next' on 2024-03-13 at dcfb0cde8c)
 + reftable/stack: register compacted tables as tempfiles
 + reftable/stack: register lockfiles during compaction
 + reftable/stack: register new tables as tempfiles
 + lockfile: report when rollback fails
 (this branch is used by ps/pack-refs-auto.)

 The code in reftable backend that creates new table files works
 better with the tempfile framework to avoid leaving cruft after a
 failure.
 source: <cover.1709816483.git.ps@pks.im>


* rs/opt-parse-long-fixups (2024-03-03) 6 commits
  (merged to 'next' on 2024-03-13 at 3755b50794)
 + parse-options: rearrange long_name matching code
 + parse-options: normalize arg and long_name before comparison
 + parse-options: detect ambiguous self-negation
 + parse-options: factor out register_abbrev() and struct parsed_option
 + parse-options: set arg of abbreviated option lazily
 + parse-options: recognize abbreviated negated option with arg

 The parse-options code that deals with abbreviated long option
 names have been cleaned up.

 Reviewed-by: Josh Steadmon <steadmon@google.com>
 cf. <ZfDM5Or3EKw7Q9SA@google.com>
 source: <20240303121944.20627-1-l.s.r@web.de>

--------------------------------------------------
[New Topics]

* jk/doc-remote-helpers-markup-fix (2024-03-20) 1 commit
 - doc/gitremote-helpers: fix more missing single-quotes

 Documentation mark-up fix.

 Will merge to 'next'.
 source: <20240320091748.GA2444639@coredump.intra.peff.net>


* jk/drop-hg-to-git (2024-03-20) 1 commit
  (merged to 'next' on 2024-03-21 at 603d614310)
 + contrib: drop hg-to-git script

 Remove an ancient and not well maintained Hg-to-git migration
 script from contrib/.

 Acked-by: Stelian Pop <stelian@popies.net>
 cf. <37e4cd61-b370-437e-bd42-f98f47d3ad32@popies.net>

 Will merge to 'master'.
 source: <20240320094824.GA2445978@coredump.intra.peff.net>


* ps/reftable-unit-test-nfs-workaround (2024-03-21) 1 commit
 - reftable: fix tests being broken by NFS' delete-after-close semantics

 A unit test for reftable code tried to enumerate all files in a
 directory after reftable operations and expected to see nothing but
 the files it wanted to leave there, but was fooled by .nfs* cruft
 files left, which has been corrected.

 Will merge to 'next'.
 source: <8ac5e94a3930cdd2aee9ea86acda3155674b635c.1711035529.git.ps@pks.im>


* ps/t7800-variable-interpolation-fix (2024-03-22) 3 commits
 - t/README: document how to loop around test cases
 - t7800: use single quotes for test bodies
 - t7800: improve test descriptions with empty arguments

 Fix the way recently added tests interpolate variables defined
 outside them, and document the best practice to help future
 developers.

 Will merge to 'next'.
 source: <cover.1711074118.git.ps@pks.im>


* tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
 - t/perf: implement performace tests for pseudo-merge bitmaps
 - pseudo-merge: implement support for finding existing merges
 - ewah: `bitmap_equals_ewah()`
 - pack-bitmap: extra trace2 information
 - pack-bitmap.c: use pseudo-merges during traversal
 - t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
 - pack-bitmap: implement test helpers for pseudo-merge
 - ewah: implement `ewah_bitmap_popcount()`
 - pseudo-merge: implement support for reading pseudo-merge commits
 - pack-bitmap.c: read pseudo-merge extension
 - pseudo-merge: scaffolding for reads
 - pack-bitmap: extract `read_bitmap()` function
 - pack-bitmap-write.c: write pseudo-merge table
 - pack-bitmap-write.c: select pseudo-merge commits
 - pseudo-merge: implement support for selecting pseudo-merge commits
 - pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 - pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 - pack-bitmap-write: support storing pseudo-merge commits
 - pseudo-merge.ch: initial commit
 - pack-bitmap: move some initialization to `bitmap_writer_init()`
 - pack-bitmap: drop unused `max_bitmaps` parameter
 - ewah: implement `ewah_bitmap_is_subset()`
 - config: repo_config_get_expiry()
 - Documentation/technical: describe pseudo-merge bitmaps format

 The pack-bitmap machinery has been extended to write bitmaps for
 pseudo-merges, which are imaginary commits which act as octopus
 merges covering groups of the un-bitmapped parts of history at
 reference tips.  This is good for ... what ...?

 Expecting a reroll.
 cf. <ZfyxCLpjbaScIdWA@nand.local>
 source: <cover.1710972293.git.me@ttaylorr.com>


* jc/release-notes-entry-experiment (2024-03-22) 1 commit
 - SubmittingPatches: release-notes entry experiment

 Introduce an experimental protocol for contributors to propose the
 topic description to be used in the "What's cooking" report, the
 merge commit message for the topic, and in the release notes and
 document it in the SubmittingPatches document.

 source: <xmqqcyrn58mf.fsf@gitster.g>


* jk/rebase-apply-leakfix (2024-03-22) 1 commit
 - rebase: use child_process_clear() to clean

 Leakfix.

 Will merge to 'next'.
 source: <20240322103502.GA2045297@coredump.intra.peff.net>

--------------------------------------------------
[Cooking]

* dg/myfirstobjectwalk-updates (2024-03-19) 5 commits
 - MyFirstObjectWalk: add stderr to pipe processing
 - MyFirstObjectWalk: fix description for counting omitted objects
 - MyFirstObjectWalk: fix filtered object walk
 - MyFirstObjectWalk: fix misspelled "builtins/"
 - MyFirstObjectWalk: use additional arg in config_fn_t

 Update a more recent tutorial doc.

 Needs review.
 source: <cover.1710840596.git.dirk@gouders.net>


* ds/config-internal-whitespace-fix (2024-03-21) 4 commits
 - config.txt: describe handling of whitespace further
 - t1300: add more tests for whitespace and inline comments
 - config: really keep value-internal whitespace verbatim
 - config: minor addition of whitespace

 "git config" corrupted literal HT characters written in the
 configuration file as part of a value, which has been corrected.

 Will merge to 'next'.
 source: <cover.1711001016.git.dsimic@manjaro.org>


* jc/apply-parse-diff-git-header-names-fix (2024-03-19) 1 commit
 - apply: parse names out of "diff --git" more carefully

 "git apply" failed to extract the filename the patch applied to,
 when the change was about an empty file created in or deleted from
 a directory whose name ends with a SP, which has been corrected.

 Needs review.
 source: <xmqqfrwlltjn.fsf@gitster.g>


* jk/pretty-subject-cleanup (2024-03-22) 7 commits
  (merged to 'next' on 2024-03-22 at 2796f347ad)
 + format-patch: fix leak of empty header string
 + format-patch: simplify after-subject MIME header handling
 + format-patch: return an allocated string from log_write_email_headers()
 + log: do not set up extra_headers for non-email formats
 + pretty: drop print_email_subject flag
 + pretty: split oneline and email subject printing
 + shortlog: stop setting pp.print_email_subject

 Code clean-up in the "git log" machinery that implements custom log
 message formatting.

 Will merge to 'master'.
 source: <20240320002555.GB903718@coredump.intra.peff.net>


* bb/sh-scripts-cleanup (2024-03-16) 22 commits
  (merged to 'next' on 2024-03-18 at 4501a04796)
 + git-quiltimport: avoid an unnecessary subshell
 + contrib/coverage-diff: avoid redundant pipelines
 + t/t9*: merge "grep | sed" pipelines
 + t/t8*: merge "grep | sed" pipelines
 + t/t5*: merge a "grep | sed" pipeline
 + t/t4*: merge a "grep | sed" pipeline
 + t/t3*: merge a "grep | awk" pipeline
 + t/t1*: merge a "grep | sed" pipeline
 + t/t9*: avoid redundant uses of cat
 + t/t8*: avoid redundant use of cat
 + t/t7*: avoid redundant use of cat
 + t/t6*: avoid redundant uses of cat
 + t/t5*: avoid redundant uses of cat
 + t/t4*: avoid redundant uses of cat
 + t/t3*: avoid redundant uses of cat
 + t/t1*: avoid redundant uses of cat
 + t/t0*: avoid redundant uses of cat
 + t/perf: avoid redundant use of cat
 + t/annotate-tests.sh: avoid redundant use of cat
 + t/lib-cvs.sh: avoid redundant use of cat
 + contrib/subtree/t: avoid redundant use of cat
 + doc: avoid redundant use of cat

 Shell scripts clean-up.

 Will merge to 'master'.
 source: <20240315194620.10713-1-dev+git@drbeat.li>


* bl/doc-config-fixes (2024-03-16) 2 commits
  (merged to 'next' on 2024-03-18 at a9038d5a9e)
 + docs: fix typo in git-config `--default`
 + docs: clarify file options in git-config `--edit`

 A few typoes in "git config --help" have been corrected.

 Will merge to 'master'.
 source: <20240316050149.1182867-2-brianmlyles@gmail.com>


* bl/doc-key-val-sep-fix (2024-03-18) 2 commits
  (merged to 'next' on 2024-03-18 at b2e1babb85)
 + docs: adjust trailer `separator` and `key_value_separator` language
 + docs: correct trailer `key_value_separator` description

 The documentation for "%(trailers[:options])" placeholder in the
 "--pretty" option of commands in the "git log" family has been
 updated.

 Will merge to 'master'.
 source: <20240316035612.752910-1-brianmlyles@gmail.com>


* ja/doc-formatting-fix (2024-03-16) 2 commits
  (merged to 'next' on 2024-03-18 at edde7a576d)
 + doc: fix some placeholders formating
 + doc: format alternatives in synopsis

 Documentation mark-up fix.

 Will merge to 'master'.
 source: <pull.1697.git.1710602501.gitgitgadget@gmail.com>


* la/hide-trailer-info (2024-03-16) 7 commits
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - trailer: make parse_trailers() return trailer_info pointer
 - interpret-trailers: access trailer_info with new helpers
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - Merge branch 'la/format-trailer-info' into la/hide-trailer-info
 (this branch uses la/format-trailer-info.)

 The trailer API has been reshuffled a bit.
 source: <pull.1696.git.1710570428.gitgitgadget@gmail.com>


* pb/advice-merge-conflict (2024-03-18) 2 commits
 - builtin/am: allow disabling conflict advice
 - sequencer: allow disabling conflict advice

 Hints that suggest what to do after resolving conflicts can now be
 squelched by disabling advice.mergeConflict.

 Will merge to 'next'?
 source: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>


* rs/t-prio-queue-fixes (2024-03-18) 2 commits
  (merged to 'next' on 2024-03-21 at 0730741187)
 + t-prio-queue: check result array bounds
 + t-prio-queue: shorten array index message

 Test clean-up.

 Will merge to 'master'.
 source: <9bf36cc8-ff27-44df-b2fb-9f959c781269@web.de>


* ps/pack-refs-auto (2024-03-18) 16 commits
 - builtin/gc: pack refs when using `git maintenance run --auto`
 - builtin/gc: forward git-gc(1)'s `--auto` flag when packing refs
 - t6500: extract objects with "17" prefix
 - builtin/gc: move `struct maintenance_run_opts`
 - builtin/pack-refs: introduce new "--auto" flag
 - builtin/pack-refs: release allocated memory
 - refs/reftable: expose auto compaction via new flag
 - refs: remove `PACK_REFS_ALL` flag
 - refs: move `struct pack_refs_opts` to where it's used
 - t/helper: drop pack-refs wrapper
 - refs/reftable: print errors on compaction failure
 - reftable/stack: gracefully handle failed auto-compaction due to locks
 - reftable/stack: use error codes when locking fails during compaction
 - reftable/error: discern locked/outdated errors
 - reftable/stack: fix error handling in `reftable_stack_init_addition()`
 - Merge branch 'ps/reftable-stack-tempfile' into ps/pack-refs-auto

 "git pack-refs" learned the "--auto" option, which is a useful
 addition to be triggered from "git gc --auto".

 Being reviewed (Karthik e.g. <CAOLa=ZS6uF3fuor3V2F_GM__JNRpUAyLcrVDbCHsJ6JStL96cA@mail.gmail.com>)
 source: <cover.1710706118.git.ps@pks.im>


* jc/show-untracked-false (2024-03-13) 2 commits
  (merged to 'next' on 2024-03-21 at 6d1f5603c6)
 + status: allow --untracked=false and friends
 + status: unify parsing of --untracked= and status.showUntrackedFiles

 The status.showUntrackedFiles configuration variable had a name
 that tempts users to set a Boolean value expressed in our usual
 "false", "off", and "0", but it only took "no".  This has been
 corrected so "true" and its synonyms are taken as "normal", while
 "false" and its synonyms are taken as "no".

 Will merge to 'master'.
 source: <20240313173214.962532-1-gitster@pobox.com>


* js/bugreport-no-suffix-fix (2024-03-16) 1 commit
  (merged to 'next' on 2024-03-18 at 180db8ec38)
 + bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option

 "git bugreport --no-suffix" was not supported and instead
 segfaulted, which has been corrected.

 Will merge to 'master'.
 source: <9c6f3f5203ae26c501a5711e2610573130bfd550.1710388817.git.gitgitgadget@gmail.com>


* ph/diff-src-dst-prefix-config (2024-03-18) 2 commits
  (merged to 'next' on 2024-03-21 at 96801520db)
 + diff.*Prefix: use camelCase in the doc and test titles
 + diff: add diff.srcPrefix and diff.dstPrefix configuration variables

 "git diff" and friends learned two extra configuration variables.

 Will merge to 'master'.
 source: <20240315010310.GA1901653@quokka>
 source: <xmqq8r2ioh19.fsf@gitster.g>


* ps/clone-with-includeif-onbranch (2024-03-12) 1 commit
 - t5601: exercise clones with "includeIf.*.onbranch"

 An additional test to demonstrate something I am not sure what.

 Waiting for a review response.
 cf. <xmqqo7bjjid9.fsf@gitster.g>
 source: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>


* rj/restore-plug-leaks (2024-03-14) 1 commit
  (merged to 'next' on 2024-03-15 at ac10ae7892)
 + checkout: plug some leaks in git-restore

 Leaks from "git restore" have been plugged.

 Will merge to 'master'.
 source: <64c1c3cc-51d7-4168-9731-4389889e1449@gmail.com>


* bt/fuzz-config-parse (2024-03-15) 1 commit
  (merged to 'next' on 2024-03-21 at 6e9f331d68)
 + fuzz: add fuzzer for config parsing

 A new fuzz target that exercises config parsing code.

 Will merge to 'master'.
 source: <pull.1692.v2.git.1710481652130.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Comments?
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* jc/index-pack-fsck-levels (2024-03-15) 1 commit
  (merged to 'next' on 2024-03-18 at 243c5f4125)
 + t5300: fix test_with_bad_commit()

 Test fix.

 Will merge to 'master'.
 source: <pull.1688.git.git.1710478646776.gitgitgadget@gmail.com>


* la/format-trailer-info (2024-03-15) 5 commits
 - trailer: finish formatting unification
 - trailer: begin formatting unification
 - format_trailer_info(): append newline for non-trailer lines
 - format_trailer_info(): drop redundant unfold_value()
 - format_trailer_info(): use trailer_item objects
 (this branch is used by la/hide-trailer-info.)

 The code to format trailers have been cleaned up.

 Comments?
 source: <pull.1694.git.1710485706.gitgitgadget@gmail.com>


* rs/config-comment (2024-03-15) 3 commits
 - config: allow tweaking whitespace between value and comment
 - config: fix --comment formatting
 - config: add --comment option to add a comment

 "git config" learned "--comment=<message>" option to leave a
 comment immediately after the "variable = value" on the same line
 in the configuration file.

 Waiting for review response.
 cf. <xmqq8r2jp2eq.fsf@gitster.g>
 source: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>


* pw/checkout-conflict-errorfix (2024-03-14) 5 commits
  (merged to 'next' on 2024-03-22 at 9977ac6c75)
 + checkout: fix interaction between --conflict and --merge
 + checkout: cleanup --conflict=<style> parsing
 + merge options: add a conflict style member
 + merge-ll: introduce LL_MERGE_OPTIONS_INIT
 + xdiff-interface: refactor parsing of merge.conflictstyle

 "git checkout --conflict=bad" reported a bad conflictStyle as if it
 were given to a configuration variable; it has been corrected to
 report that the command line option is bad.

 Will merge to 'master'.
 source: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>


* bl/cherry-pick-empty (2024-03-20) 7 commits
 - cherry-pick: add `--empty` for more robust redundant commit handling
 - cherry-pick: enforce `--keep-redundant-commits` incompatibility
 - sequencer: do not require `allow_empty` for redundant commit options
 - sequencer: handle unborn branch with `--allow-empty`
 - rebase: update `--empty=ask` to `--empty=stop`
 - docs: clean up `--empty` formatting in git-rebase(1) and git-am (1)
 - docs: address inaccurate `--empty` default with `--exec`

 Allow git-cherry-pick(1) to automatically drop redundant commits via
 a new `--empty` option, similar to the `--empty` options for
 git-rebase(1) and git-am(1). Includes a soft deprecation of
 `--keep-redundant-commits` as well as some related docs changes and
 sequencer code cleanup.

 Will merge to 'next'?
 source: <20240119060721.3734775-2-brianmlyles@gmail.com>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* jk/remote-helper-object-format-option-fix (2024-03-20) 3 commits
 - transport-helper: send "true" value for object-format option
 - transport-helper: drop "object-format <algo>" option
 - transport-helper: use write helpers more consistently

 The implementation and documentation of "object-format" option
 exchange between the Git itself and its remote helpers did not
 quite match.
 source: <20240320093226.GA2445531@coredump.intra.peff.net>


* jk/core-comment-string (2024-03-12) 16 commits
 - config: allow multi-byte core.commentChar
 - environment: drop comment_line_char compatibility macro
 - wt-status: drop custom comment-char stringification
 - sequencer: handle multi-byte comment characters when writing todo list
 - find multi-byte comment chars in unterminated buffers
 - find multi-byte comment chars in NUL-terminated strings
 - prefer comment_line_str to comment_line_char for printing
 - strbuf: accept a comment string for strbuf_add_commented_lines()
 - strbuf: accept a comment string for strbuf_commented_addf()
 - strbuf: accept a comment string for strbuf_stripspace()
 - environment: store comment_line_char as a string
 - strbuf: avoid shadowing global comment_line_char name
 - commit: refactor base-case of adjust_comment_line_char()
 - strbuf: avoid static variables in strbuf_add_commented_lines()
 - strbuf: simplify comment-handling in add_lines() helper
 - config: forbid newline as core.commentChar

 core.commentChar used to be limited to a single byte, but has been
 updated to allow an arbitrary multi-byte sequence.

 Waiting for the discussion to settle.
 cf. <20240315081041.GA1753560@coredump.intra.peff.net>
 source: <20240312091013.GA95442@coredump.intra.peff.net>


* js/build-fuzz-more-often (2024-03-05) 3 commits
 - SQUASH???
 - fuzz: link fuzz programs with `make all` on Linux
 - ci: also define CXX environment variable

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.

 Comments?
 source: <cover.1709673020.git.steadmon@google.com>


* sj/userdiff-c-sharp (2024-03-06) 1 commit
 - userdiff: better method/property matching for C#

 The userdiff patterns for C# has been updated.

 Needs review.
 source: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>


* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/cmake-with-test-tool (2024-02-23) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


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


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


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
  (merged to 'next' on 2024-03-11 at 9cff2e4ab7)
 + t1016-compatObjectFormat: add tests to verify the conversion between objects
 + t1006: test oid compatibility with cat-file
 + t1006: rename sha1 to oid
 + test-lib: compute the compatibility hash so tests may use it
 + builtin/ls-tree: let the oid determine the output algorithm
 + object-file: handle compat objects in check_object_signature
 + tree-walk: init_tree_desc take an oid to get the hash algorithm
 + builtin/cat-file: let the oid determine the output algorithm
 + rev-parse: add an --output-object-format parameter
 + repository: implement extensions.compatObjectFormat
 + object-file: update object_info_extended to reencode objects
 + object-file-convert: convert commits that embed signed tags
 + object-file-convert: convert commit objects when writing
 + object-file-convert: don't leak when converting tag objects
 + object-file-convert: convert tag objects when writing
 + object-file-convert: add a function to convert trees between algorithms
 + object: factor out parse_mode out of fast-import and tree-walk into in object.h
 + cache: add a function to read an OID of a specific algorithm
 + tag: sign both hashes
 + commit: export add_header_signature to support handling signatures on tags
 + commit: convert mergetag before computing the signature of a commit
 + commit: write commits for both hashes
 + object-file: add a compat_oid_in parameter to write_object_file_flags
 + object-file: update the loose object map when writing loose objects
 + loose: compatibilty short name support
 + loose: add a mapping between SHA-1 and SHA-256 for loose objects
 + repository: add a compatibility hash algorithm
 + object-names: support input of oids in any supported hash
 + oid-array: teach oid-array to handle multiple kinds of oids
 + object-file-convert: stubs for converting from one object format to another

 Teach a repository to work with both SHA-1 and SHA-256 hash algorithms.

 Will merge to 'master'?
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
