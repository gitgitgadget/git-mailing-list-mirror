Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4F383A5
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723692879; cv=none; b=MA3cqe1qXs455uxg8kfPB4vEsglWIjIGiKY2DYL/BRJgcOK6vlTuW8UxT9xBPGMOrP8tS4gpx6EUQWMaz6wdYGEH1pEp7L3gcElY7e1NgOyo41wQ+pH83+9FnH+yXXUoCyhDt0DFMsX9tzIt/f3QfYTXlpW2xo5PxBwo5CtA5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723692879; c=relaxed/simple;
	bh=ZaPJo3Y5pFOCXPwlXl9Uh62XxUCZSWORYyS5Qnps5jA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=klXEi5NuhllthiQayYSdtcAk+qoUfpZ11TmVDDBB5Nmn8uBIfb+QGviXXVbsTjd37T5w7yqJEG0i995sjgxZRYlagDpaQ84sovFINhTZF5F22QWsr8OIAp2kTtDFQroRUQZbRsPuxm651gVtC8rMyfp/KJsmppT1AJDXH7mqZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5eLuvLS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5eLuvLS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 822F318EBD;
	Wed, 14 Aug 2024 23:34:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	aPJo3Y5pFOCXPwlXl9Uh62XxUCZSWORYyS5Qnps5jA=; b=L5eLuvLSJC3Ts8pkC
	e5i9ZtmvFNCtcm1isQZXlQ/1RfvAX4Fxp9jjQs0cQvQ7bobElqgvpOdYeKdJvXTF
	qhKey6VQmWc2wBCZJ2z7nyPAgcx9O5u0O8FbeFCz6fFr07YlLm4SuskJr9JsY+Q3
	U4K+aXjpcNs+n7Jyzh5pP2vD+0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7860118EBC;
	Wed, 14 Aug 2024 23:34:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C58E618EBB;
	Wed, 14 Aug 2024 23:34:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2024, #05; Wed, 14)
X-master-at: 477ce5ccd69bda5c44f53e3b230f8a9c54217ed6
X-next-at: ddde3f2535d17d0698e32c8f15e9fd627603e752
Date: Wed, 14 Aug 2024 20:34:32 -0700
Message-ID: <xmqqcymawjav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A8FE376-5AB7-11EF-A238-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

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

* cp/unit-test-reftable-pq (2024-08-01) 7 commits
  (merged to 'next' on 2024-08-05 at 05e47f7097)
 + t-reftable-pq: add tests for merged_iter_pqueue_top()
 + t-reftable-pq: add test for index based comparison
 + t-reftable-pq: make merged_iter_pqueue_check() callable by reference
 + t-reftable-pq: make merged_iter_pqueue_check() static
 + t: move reftable/pq_test.c to the unit testing framework
 + reftable: change the type of array indices to 'size_t' in reftable/pq.c
 + reftable: remove unnecessary curly braces in reftable/pq.c

 The tests for "pq" part of reftable library got rewritten to use
 the unit test framework.
 cf. <Zqt02XmevPRB3idt@tanuki>
 source: <20240801110453.5087-1-chandrapratap3519@gmail.com>


* cp/unit-test-reftable-tree (2024-08-04) 5 commits
  (merged to 'next' on 2024-08-06 at e32c456e45)
 + t-reftable-tree: improve the test for infix_walk()
 + t-reftable-tree: add test for non-existent key
 + t-reftable-tree: split test_tree() into two sub-test functions
 + t: move reftable/tree_test.c to the unit testing framework
 + reftable: remove unnecessary curly braces in reftable/tree.c

 A test in reftable library has been rewritten using the unit test
 framework.
 cf. <Zqt1WTT_eJKEuO1z@tanuki>
 cf. <ZrCx0NWRbFOOReki@tanuki>
 source: <20240804141105.4268-1-chandrapratap3519@gmail.com>


* jc/document-use-of-local (2024-07-15) 1 commit
  (merged to 'next' on 2024-08-07 at 3321b54659)
 + doc: note that AT&T ksh does not work with our test suite

 Doc update.
 source: <xmqq1q3u8zmr.fsf@gitster.g>


* jc/jl-git-no-advice-fix (2024-08-01) 1 commit
  (merged to 'next' on 2024-08-06 at 468bfce24b)
 + t0018: remove leftover debugging cruft

 Remove leftover debugging cruft from a test script.
 source: <xmqq7cd0ulen.fsf_-_@gitster.g>


* jc/leakfix-hashfile (2024-07-26) 1 commit
  (merged to 'next' on 2024-08-06 at 7793a7fc56)
 + csum-file: introduce discard_hashfile()

 Leakfix.
 source: <xmqqle1p1367.fsf@gitster.g>


* jc/leakfix-mailmap (2024-07-26) 1 commit
  (merged to 'next' on 2024-08-06 at 22f73301fd)
 + mailmap: plug memory leak in read_mailmap_blob()

 Leakfix.
 source: <xmqqcyn112xi.fsf@gitster.g>


* jc/patch-id (2024-07-29) 5 commits
  (merged to 'next' on 2024-08-06 at 9ad078b49c)
 + patch-id: tighten code to detect the patch header
 + patch-id: rewrite code that detects the beginning of a patch
 + patch-id: make get_one_patchid() more extensible
 + patch-id: call flush_current_id() only when needed
 + t4204: patch-id supports various input format

 The patch parser in "git patch-id" has been tightened to avoid
 getting confused by lines that look like a patch header in the log
 message.
 cf. <Zqh2T_2RLt0SeKF7@tanuki>
 source: <20240730011738.4032377-1-gitster@pobox.com>


* jc/reflog-expire-lookup-commit-fix (2024-07-16) 1 commit
  (merged to 'next' on 2024-08-06 at 1e59eac417)
 + Revert "reflog expire: don't use lookup_commit_reference_gently()"

 "git reflog expire" failed to honor annotated tags when computing
 reachable commits.
 source: <xmqqv8156rh2.fsf@gitster.g>


* jc/transport-leakfix (2024-08-07) 1 commit
  (merged to 'next' on 2024-08-07 at eec3a24826)
 + transport: fix leak with transport helper URLs
 (this branch is used by ps/transport-leakfix-test-updates.)

 Leakfix.
 source: <xmqq34nfn7ip.fsf@gitster.g>


* jk/apply-patch-mode-check-fix (2024-08-05) 1 commit
  (merged to 'next' on 2024-08-05 at 2dc1a81c89)
 + apply: canonicalize modes read from patches

 The patch parser in 'git apply' has been a bit more lenient against
 unexpected mode bits, like 100664, recorded on extended header lines.
 source: <20240805060010.GA120016@coredump.intra.peff.net>


* jk/osxkeychain-username-is-nul-terminated (2024-08-01) 1 commit
  (merged to 'next' on 2024-08-05 at 34a238e047)
 + credential/osxkeychain: respect NUL terminator in username

 The credential helper to talk to OSX keychain sometimes sent
 garbage bytes after the username, which has been corrected.
 source: <20240801082556.GA640360@coredump.intra.peff.net>


* jr/ls-files-expand-literal-doc (2024-07-26) 1 commit
  (merged to 'next' on 2024-08-06 at 0e7c8858ef)
 + doc: fix hex code escapes in git-ls-files

 Docfix.
 source: <CACStHN-Gs2Sxej+md6zWr3V1dFo+pp=B4yEPm9=uPambDR2NaQ@mail.gmail.com>


* kl/test-fixes (2024-08-05) 2 commits
  (merged to 'next' on 2024-08-06 at 2cdcac6ce4)
 + t6421: fix test to work when repo dir contains d0
 + set errno=0 before strtoX calls

 A flakey test and incorrect calls to strtoX() functions have been
 fixed.
 source: <pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>


* ps/leakfixes-part-3 (2024-08-01) 24 commits
  (merged to 'next' on 2024-08-05 at e3d94036ff)
 + commit-reach: fix trivial memory leak when computing reachability
 + convert: fix leaking config strings
 + entry: fix leaking pathnames during delayed checkout
 + object-name: fix leaking commit list items
 + t/test-repository: fix leaking repository
 + builtin/credential-cache: fix trivial leaks
 + builtin/worktree: fix leaking derived branch names
 + builtin/shortlog: fix various trivial memory leaks
 + builtin/rerere: fix various trivial memory leaks
 + builtin/credential-store: fix leaking credential
 + builtin/show-branch: fix several memory leaks
 + builtin/rev-parse: fix memory leak with `--parseopt`
 + builtin/stash: fix various trivial memory leaks
 + builtin/remote: fix various trivial memory leaks
 + builtin/remote: fix leaking strings in `branch_list`
 + builtin/ls-remote: fix leaking `pattern` strings
 + builtin/submodule--helper: fix leaking buffer in `is_tip_reachable`
 + builtin/submodule--helper: fix leaking clone depth parameter
 + builtin/name-rev: fix various trivial memory leaks
 + builtin/describe: fix trivial memory leak when describing blob
 + builtin/describe: fix leaking array when running diff-index
 + builtin/describe: fix memory leak with `--contains=`
 + builtin/log: fix leaking branch name when creating cover letters
 + builtin/replay: plug leaking `advance_name` variable
 (this branch is used by ps/leakfixes-part-4.)

 More leakfixes.
 cf. <ZqvDJpNxMkvd3hSZ@nand.local>
 source: <cover.1722499961.git.ps@pks.im>


* ps/ls-remote-out-of-repo-fix (2024-08-02) 1 commit
  (merged to 'next' on 2024-08-05 at 6438d8196d)
 + builtin/ls-remote: fall back to SHA1 outside of a repo

 A recent update broke "git ls-remote" used outside a repository,
 which has been corrected.
 source: <c52112d3946b2fd8d030580cd7acb809fa54012a.1722573777.git.ps@pks.im>


* ps/ref-api-cleanup (2024-08-02) 1 commit
  (merged to 'next' on 2024-08-05 at d57856ae19)
 + refs: drop `ref_store`-less functions

 Code clean-up.
 source: <1d9add71065dabb3d7bf81529d04afbcf91e3a69.1722577074.git.ps@pks.im>


* ps/refs-wo-the-repository (2024-07-30) 5 commits
  (merged to 'next' on 2024-08-06 at fef5e26d47)
 + refs/reftable: stop using `the_repository`
 + refs/packed: stop using `the_repository`
 + refs/files: stop using `the_repository`
 + refs/files: stop using `the_repository` in `parse_loose_ref_contents()`
 + refs: stop using `the_repository`
 (this branch is used by ps/config-wo-the-repository.)

 In the refs subsystem, implicit reliance of the_repository has been
 eliminated; the repository associated with the ref store object is
 used instead.
 cf. <ZqnEuz9uFgUwWKkc@tanuki>
 source: <cover.1722316795.git.ps@pks.im>


* rh/http-proxy-path (2024-08-02) 1 commit
  (merged to 'next' on 2024-08-05 at d6f1fb194a)
 + http: do not ignore proxy path

 The value of http.proxy can have "path" at the end for a socks
 proxy that listens to a unix-domain socket, but we started to
 discard it when we taught proxy auth code path to use the
 credential helpers, which has been corrected.
 source: <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>


* rs/use-decimal-width (2024-08-05) 1 commit
  (merged to 'next' on 2024-08-06 at 99ccbb43de)
 + log-tree: use decimal_width()

 Code clean-up.
 source: <06783722-5184-41d5-8edd-94f97b2f2794@web.de>


* ss/packed-ref-store-leakfix (2024-08-05) 1 commit
  (merged to 'next' on 2024-08-06 at 5003ec4218)
 + refs/files: prevent memory leak by freeing packed_ref_store

 Leakfix.
 source: <pull.1757.v2.git.git.1722851612505.gitgitgadget@gmail.com>


* tb/config-fixed-value-with-valueless-true (2024-08-01) 1 commit
  (merged to 'next' on 2024-08-06 at 0476e5ba76)
 + config.c: avoid segfault with --fixed-value and valueless config

 "git config --value=foo --fixed-value section.key newvalue" barfed
 when the existing value in the configuration file used the
 valueless true syntax, which has been corrected.
 source: <c78bacfa8fb274fbb48f259b13f4f30253932f69.1722532013.git.me@ttaylorr.com>


* tb/t7704-deflake (2024-08-05) 1 commit
  (merged to 'next' on 2024-08-07 at d3c0727946)
 + t/t7704-repack-cruft.sh: avoid failures during long-running tests

 A test that fails on an unusually slow machine was found, and made
 less likely to cause trouble by lengthening the expiry value it
 uses.
 source: <95cdc30bad38f464b37e87d78f38e1d91c9e083b.1722886630.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* gt/unit-test-urlmatch-normalization (2024-08-14) 1 commit
 - t: migrate t0110-urlmatch-normalization to the new framework

 Another rewrite of test.

 Comments?
 source: <20240814142057.94671-1-shyamthakkar001@gmail.com>


* jk/midx-unused-fix (2024-08-13) 1 commit
  (merged to 'next' on 2024-08-14 at 2ec51e52e1)
 + midx: drop unused parameters from add_midx_to_chain()
 (this branch uses tb/incremental-midx-part-1.)

 Code clean-up in the base topic.

 Will merge to 'master'.
 source: <cover.1722958595.git.me@ttaylorr.com>


* ps/bundle-outside-repo-fix (2024-08-13) 2 commits
 - bundle: default to SHA1 when reading bundle headers
 - builtin/bundle: have unbundle check for repo before opening its bundle

 "git bundle unbundle" outside a repository triggered a BUG()
 unnecessarily, which has been corrected.

 Will merge to 'next'.
 source: <cover.1723540604.git.ps@pks.im>


* ps/clar-unit-test (2024-08-13) 8 commits
 . t/unit-tests: convert ctype tests to use clar
 . t/unit-tests: convert strvec tests to use clar
 . Makefile: wire up the clar unit testing framework
 . t/clar: fix compatibility with NonStop
 . t/clar: fix another whitespace error
 . t/clar: fix whitespace errors
 . t: import the clar unit testing framework
 . t: do not pass GIT_TEST_OPTS to unit tests with prove

 Import clar unit tests framework libgit2 folks invented for our
 use.

 On hold.
 cf. https://github.com/git/git/actions/runs/10377935505/job/28733214241
 Seems to break "make sparse" among other things.
 source: <cover.1723095269.git.ps@pks.im>


* ps/maintenance-detach-fix (2024-08-13) 7 commits
 - builtin/maintenance: fix auto-detach with non-standard tasks
 - builtin/maintenance: add a `--detach` flag
 - builtin/gc: add a `--detach` flag
 - builtin/gc: stop processing log file on signal
 - builtin/gc: fix leaking config values
 - builtin/gc: refactor to read config into structure
 - config: fix constness of out parameter for `git_config_get_expiry()`

 Allow maintance tasks other than "gc" to properly go background
 when "git maintenance" run them.

 Expecting a reroll.
 cf. <a3e9a4f9-baef-4c11-9f38-f30ff333e87a@gmail.com>
 source: <cover.1723533091.git.ps@pks.im>


* jk/send-email-translate-aliases (2024-08-14) 3 commits
 - send-email: teach git send-email option to translate aliases
 - t9001-send-email.sh: update alias list used for pine test
 - t9001-send-email.sh: fix quoting for mailrc --dump-aliases test

 "git send-email" learned "--translate-aliases" option that reads
 addresses from the standard input and emits the result of applying
 aliases on them to the standard output.

 Will merge to 'next'?
 source: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>


* cp/unit-test-reftable-block (2024-08-14) 10 commits
 - t-reftable-block: add tests for index blocks
 - t-reftable-block: add tests for obj blocks
 - t-reftable-block: add tests for log blocks
 - t-reftable-block: remove unnecessary variable 'j'
 - t-reftable-block: use xstrfmt() instead of xstrdup()
 - t-reftable-block: use block_iter_reset() instead of block_iter_close()
 - t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
 - t-reftable-block: use reftable_record_equal() instead of check_str()
 - t-reftable-block: release used block reader
 - t: move reftable/block_test.c to the unit testing framework

 source: <20240814121122.4642-1-chandrapratap3519@gmail.com>

--------------------------------------------------
[Stalled]

* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* jc/tests-no-useless-tee (2024-08-08) 1 commit
  (merged to 'next' on 2024-08-12 at 188e777e16)
 + tests: drop use of 'tee' that hides exit status

 Test fixes.

 Will merge to 'master'.
 source: <xmqq4j7uhfvm.fsf@gitster.g>


* js/libgit-rust (2024-08-09) 5 commits
 - cgit: add higher-level cgit crate
 - config: add git_configset_alloc() and git_configset_clear_and_free()
 - cgit-sys: add repo initialization and config access
 - cgit-sys: introduce Rust wrapper for libgit.a
 - common-main: split init and exit code into new files

 An rust binding to libgit.a functions has been introduced.
 source: <cover.1723242556.git.steadmon@google.com>


* xx/diff-tree-remerge-diff-fix (2024-08-09) 1 commit
  (merged to 'next' on 2024-08-09 at cabe67c0d1)
 + diff-tree: fix crash when used with --remerge-diff
 (this branch is used by jc/range-diff-lazy-setup.)

 "git rev-list ... | git diff-tree -p --remerge-diff --stdin" should
 behave more or less like "git log -p --remerge-diff" but instead it
 crashed, forgetting to prepare a temporary object store needed.

 Will merge to 'master'.
 source: <pull.1771.v2.git.1723188292498.gitgitgadget@gmail.com>


* jc/grammo-fixes (2024-08-09) 2 commits
 - doc: grammofix in git-diff-tree
 - tutorial: grammofix

 Doc updates.

 Will merge to 'next'.
 source: <xmqqed6xehzv.fsf@gitster.g>


* jc/range-diff-lazy-setup (2024-08-09) 2 commits
 - remerge-diff: clean up temporary objdir at a central place
 - remerge-diff: lazily prepare temporary objdir on demand
 (this branch uses xx/diff-tree-remerge-diff-fix.)

 Code clean-up.

 Comments?
 source: <pull.1771.git.1723123250958.gitgitgadget@gmail.com>


* jc/t3206-test-when-finished-fix (2024-08-06) 1 commit
  (merged to 'next' on 2024-08-08 at 46461db3a2)
 + t3206: test_when_finished before dirtying operations, not after

 Test clean-up.

 Will merge to 'master'.
 source: <xmqqwmkttwfm.fsf@gitster.g>


* jc/too-many-arguments (2024-08-06) 4 commits
 - miscellaneous: avoid "too many arguments"
 - notes: avoid "too many arguments"
 - cat-file: avoid "too many arguments"
 - refs: avoid "too many arguments"

 Error message clarification.

 On hold.
 source: <20240806003539.3292562-1-gitster@pobox.com>


* ps/leakfixes-part-4 (2024-08-14) 23 commits
 - builtin/diff: free symmetric diff members
 - diff: free state populated via options
 - builtin/log: fix leak when showing converted blob contents
 - userdiff: fix leaking memory for configured diff drivers
 - builtin/format-patch: fix various trivial memory leaks
 - diff: fix leak when parsing invalid ignore regex option
 - unpack-trees: clear index when not propagating it
 - sequencer: release todo list on error paths
 - merge-ort: unconditionally release attributes index
 - builtin/fast-export: plug leaking tag names
 - builtin/fast-export: fix leaking diff options
 - builtin/fast-import: plug trivial memory leaks
 - builtin/notes: fix leaking `struct notes_tree` when merging notes
 - builtin/rebase: fix leaking `commit.gpgsign` value
 - config: fix leaking comment character config
 - submodule-config: fix leaking name entry when traversing submodules
 - read-cache: fix leaking hashfile when writing index fails
 - bulk-checkin: fix leaking state TODO
 - object-name: fix leaking symlink paths in object context
 - object-file: fix memory leak when reading corrupted headers
 - git: fix leaking system paths
 - remote: plug memory leak when aliasing URLs
 - Merge branch 'ps/leakfixes-part-3' into ps/leakfixes-part-4

 More leak fixes.

 Will merge to 'next'?
 source: <cover.1723614263.git.ps@pks.im>


* cp/unit-test-reftable-readwrite (2024-08-13) 4 commits
 - t-reftable-readwrite: add test for known error
 - t-reftable-readwrite: use 'for' in place of infinite 'while' loops
 - t-reftable-readwrite: use free_names() instead of a for loop
 - t: move reftable/readwrite_test.c to the unit testing framework

 Will merge to 'next' by 2024-08-17 or so.
 source: <20240813144440.4602-1-chandrapratap3519@gmail.com>


* ps/config-wo-the-repository (2024-08-13) 21 commits
 - config: hide functions using `the_repository` by default
 - global: prepare for hiding away repo-less config functions
 - config: don't depend on `the_repository` with branch conditions
 - config: don't have setters depend on `the_repository`
 - config: pass repo to functions that rename or copy sections
 - config: pass repo to `git_die_config()`
 - config: pass repo to `git_config_get_expiry_in_days()`
 - config: pass repo to `git_config_get_expiry()`
 - config: pass repo to `git_config_get_max_percent_split_change()`
 - config: pass repo to `git_config_get_split_index()`
 - config: pass repo to `git_config_get_index_threads()`
 - config: expose `repo_config_clear()`
 - config: introduce missing setters that take repo as parameter
 - path: hide functions using `the_repository` by default
 - path: stop relying on `the_repository` in `worktree_git_path()`
 - path: stop relying on `the_repository` when reporting garbage
 - hooks: remove implicit dependency on `the_repository`
 - editor: do not rely on `the_repository` for interactive edits
 - path: expose `do_git_common_path()` as `repo_common_pathv()`
 - path: expose `do_git_path()` as `repo_git_pathv()`
 - Merge branch 'ps/refs-wo-the-repository' into ps/config-wo-the-repository

 Use of API functions that implicitly depend on the_repository
 object in the config subsystem has been rewritten to pass a
 repository object through the callchain.

 Will merge to 'next'?
 source: <cover.1723540226.git.ps@pks.im>


* ps/submodule-ref-format (2024-08-08) 8 commits
  (merged to 'next' on 2024-08-09 at 2b17964809)
 + object: fix leaking packfiles when closing object store
 + submodule: fix leaking seen submodule names
 + submodule: fix leaking fetch tasks
 + builtin/submodule: allow "add" to use different ref storage format
 + refs: fix ref storage format for submodule ref stores
 + builtin/clone: propagate ref storage format to submodules
 + builtin/submodule: allow cloning with different ref storage format
 + git-submodule.sh: break overly long command lines

 Support to specify ref backend for submodules has been enhanced.

 Will merge to 'master'.
 source: <cover.1723102259.git.ps@pks.im>


* ps/transport-leakfix-test-updates (2024-08-08) 1 commit
  (merged to 'next' on 2024-08-12 at ee80dbc4f6)
 + transport: mark more tests leak-free

 Test updates.

 Will merge to 'master'.
 source: <ZrRV_HrUArsvRgn8@tanuki>


* ag/t7004-modernize (2024-08-08) 8 commits
  (merged to 'next' on 2024-08-09 at 7bce577df4)
 + t7004: make use of write_script
 + t7004: use single quotes instead of double quotes
 + t7004: begin the test body on the same line as test_expect_success
 + t7004: description on the same line as test_expect_success
 + t7004: do not prepare things outside test_expect_success
 + t7004: use indented here-doc
 + t7004: one command per line
 + t7004: remove space after redirect operators

 Coding style fixes to a test script.

 Will merge to 'master'.
 source: <20240808163302.17521-1-abdobngad@gmail.com>


* ds/for-each-ref-is-base (2024-08-14) 4 commits
 - p1500: add is-base performance tests
 - for-each-ref: add 'is-base' token
 - commit: add gentle reference lookup method
 - commit-reach: add get_branch_base_for_tip

 'git for-each-ref' learned a new "--format" atom to find the branch
 that the history leading to a given commit "%(is-base:<commit>)" is
 likely based on.

 Comments?
 source: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>


* sj/ref-fsck (2024-08-08) 9 commits
  (merged to 'next' on 2024-08-09 at 3bde10da94)
 + fsck: add ref name check for files backend
 + files-backend: add unified interface for refs scanning
 + builtin/refs: add verify subcommand
 + refs: set up ref consistency check infrastructure
 + fsck: add refs report function
 + fsck: add a unified interface for reporting fsck messages
 + fsck: make "fsck_error" callback generic
 + fsck: rename objects-related fsck error functions
 + fsck: rename "skiplist" to "skip_oids"

 "git fsck" infrastructure has been taught to also check the sanity
 of the ref database, in addition to the object database.

 Will merge to 'master'.
 source: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>


* rs/t-example-simplify (2024-07-30) 1 commit
  (merged to 'next' on 2024-08-08 at edeb01c38e)
 + t-example-decorate: remove test messages

 Unit test simplification.

 Will merge to 'master'.
 source: <5c838884-b606-465a-8f7e-ab760ddadef8@web.de>


* cc/promisor-remote-capability (2024-07-31) 4 commits
 - promisor-remote: check advertised name or URL
 - Add 'promisor-remote' capability to protocol v2
 - strbuf: refactor strbuf_trim_trailing_ch()
 - version: refactor strbuf_sanitize()

 The v2 protocol learned to allow the server to advertise possible
 promisor remotes, and the client to respond with what promissor
 remotes it uses, so that the server side can omit objects that the
 client can lazily obtain from these other promissor remotes.

 Comments?
 source: <20240731134014.2299361-1-christian.couder@gmail.com>


* ps/reftable-stack-compaction (2024-08-08) 9 commits
  (merged to 'next' on 2024-08-09 at d7875bf14b)
 + reftable/stack: handle locked tables during auto-compaction
 + reftable/stack: fix corruption on concurrent compaction
 + reftable/stack: use lock_file when adding table to "tables.list"
 + reftable/stack: do not die when fsyncing lock file files
 + reftable/stack: simplify tracking of table locks
 + reftable/stack: update stats on failed full compaction
 + reftable/stack: test compaction with already-locked tables
 + reftable/stack: extract function to setup stack with N tables
 + reftable/stack: refactor function to gather table sizes

 The code paths to compact multiple reftable files have been updated
 to correctly deal with multiple compaction triggering at the same
 time.

 Will merge to 'master'.
 source: <cover.1723123606.git.ps@pks.im>


* jc/refs-symref-referent (2024-08-09) 3 commits
  (merged to 'next' on 2024-08-09 at 3183f3d05b)
 + ref-filter: populate symref from iterator
 + refs: add referent to each_ref_fn
 + refs: keep track of unresolved reference value in iterators

 The refs API has been taught to give symref target information to
 the users of ref iterators, allowing for-each-ref and friends to
 avoid an extra ref_resolve_* API call per a symbolic ref.

 Will merge to 'master'.
 source: <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>


* tb/incremental-midx-part-1 (2024-08-06) 19 commits
  (merged to 'next' on 2024-08-12 at 92ec55fd49)
 + midx: implement support for writing incremental MIDX chains
 + t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 + t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 + midx: implement verification support for incremental MIDXs
 + midx: support reading incremental MIDX chains
 + midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 + midx: teach `midx_preferred_pack()` about incremental MIDXs
 + midx: teach `midx_contains_pack()` about incremental MIDXs
 + midx: remove unused `midx_locate_pack()`
 + midx: teach `fill_midx_entry()` about incremental MIDXs
 + midx: teach `nth_midxed_offset()` about incremental MIDXs
 + midx: teach `bsearch_midx()` about incremental MIDXs
 + midx: introduce `bsearch_one_midx()`
 + midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 + midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 + midx: teach `prepare_midx_pack()` about incremental MIDXs
 + midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 + midx: add new fields for incremental MIDX chains
 + Documentation: describe incremental MIDX format
 (this branch is used by jk/midx-unused-fix.)

 Incremental updates of multi-pack index files.

 Will merge to 'master'.
 source: <cover.1722958595.git.me@ttaylorr.com>


* ja/doc-synopsis-markup (2024-08-12) 3 commits
 - doc: apply synopsis simplification on git-clone and git-init
 - doc: update the guidelines to reflect the current formatting rules
 - doc: introduce a synopsis custom paragraph attribute

 The way AsciiDoc is used for SYNOPSIS part of the manual pages has
 been revamped.  The sources, at least for the simple cases, got
 vastly pleasant to work with.

 Comments?
 source: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>


* tc/fetch-bundle-uri (2024-07-24) 3 commits
 - fetch: use bundle URIs when having creationToken heuristic
 - transport: introduce transport_has_remote_bundle_uri()
 - clone: remove double bundle list clear code

 Allow "git fetch" take advantage of bundleURI feature.

 Expecting a reroll or retraction.
 source: <ZqObobw8FsDMkllm@tanuki>


* ag/git-svn-global-ignores (2024-08-14) 3 commits
 - git-svn: mention `svn:global-ignores` in help+docs
  (merged to 'next' on 2024-08-08 at 3ba5e164a6)
 + git-svn: use `svn:global-ignores` to create .gitignore
 + git-svn: add public property `svn:global-ignores`

 "git svn" has been taught about svn:global-ignores property
 recent versions of Subversion has.

 Will merge to 'next'.
 source: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
 source: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>


* jc/safe-directory (2024-07-30) 4 commits
  (merged to 'next' on 2024-08-05 at 77aa0f1d08)
 + safe.directory: setting safe.directory="." allows the "current" directory
 + safe.directory: normalize the configured path
 + safe.directory: normalize the checked path
 + safe.directory: preliminary clean-up

 Follow-up on 2.45.1 regression fix.

 Will merge to 'master'.
 source: <20240730184352.2503276-1-gitster@pobox.com>


* ew/cat-file-optim (2024-07-15) 10 commits
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

 Expecting a reroll.
 cf. <ZqC82sDnj7Se_aVB@tanuki>
 source: <20240715003519.2671385-1-e@80x24.org>


* es/doc-platform-support-policy (2024-08-02) 1 commit
  (merged to 'next' on 2024-08-09 at 110c94ea82)
 + Documentation: add platform support policy

 A policy document that describes platform support levels and
 expectation on platform stakeholders has been introduced.

 Will merge to 'master'.
 source: <20240802221948.2367124-1-emilyshaffer@google.com>


* gt/unit-test-hashmap (2024-08-06) 1 commit
  (merged to 'next' on 2024-08-09 at e62febfb4e)
 + t: port helper/test-hashmap.c to unit-tests/t-hashmap.c

 An existing test of hashmap API has been rewritten with the
 unit-test framework.

 Will merge to 'master'.
 cf. <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>
 source: <20240803133517.73308-2-shyamthakkar001@gmail.com>


* rs/unit-tests-test-run (2024-07-30) 6 commits
  (merged to 'next' on 2024-08-12 at 9df4336877)
 + t-strvec: use if_test
 + t-reftable-basics: use if_test
 + t-ctype: use if_test
 + unit-tests: add if_test
 + unit-tests: show location of checks outside of tests
 + t0080: use here-doc test body

 Unit-test framework has learned a simple control structure to allow
 embedding test statements in-line instead of having to create a new
 function to contain them.

 Will merge to 'master'.
 source: <077a178e-eb30-45ff-b653-a514bfd33077@web.de>
