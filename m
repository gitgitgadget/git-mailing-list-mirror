Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0811143899
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172481; cv=none; b=aPdxXzF0X6x1/vt5ONNWj4TNr6gEswZsuujHurNRKMpnxvyzbdDJwI0Ff7fQGGat8wg+Yc6UXROTEQrLGWpggRJ0ZqBTbjOWohw6J7LAfkrmaNmBKlfP/xnvj6w8mbyww2f6Wy1kWVzI7EZJ44PzaYNKBLwKlXusQZIVy9lqnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172481; c=relaxed/simple;
	bh=8XKaeTDFocj6t0hmkPCp5WzXsfQmstWgu8emaXnUE6M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/NvinKIoSu/9AiS93HvU4PZMz/Cidw76CBKaG4++oO9yhJEHvHqgtWd9ZSl5wMRp2xj+gCtRHuRS34E/gQ3pp45gudHLdNPfNzyfm19OGqrduaVID5R8e1iAfxpAQre5PEO3kKK7jXzZyvmmzKP2X2hDJ3ZhB7YVcPJqLxzivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uep+yab0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uep+yab0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 304E230611;
	Tue, 16 Jul 2024 19:27:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	XKaeTDFocj6t0hmkPCp5WzXsfQmstWgu8emaXnUE6M=; b=uep+yab06ERVrj2qY
	9rl7btLYiZoVyc4KqJpBuv8kx+u0wBcczIWJeA9SVco66t8JhfI2WbMz6kOotREQ
	Hxa1xxiZZNaq8BvUP2lMp+C8mXS+hO/WYisioY+wA5oThdu3qhkhhM7qAyeiAyeZ
	/wtwQqeEkNSShPI2k8LmmS8ifI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 289AF30610;
	Tue, 16 Jul 2024 19:27:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91CBF3060F;
	Tue, 16 Jul 2024 19:27:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Jul 2024, #05; Tue, 16)
X-master-at: 04f5a52757cd92347271e24f7cbdfe15dafce3b7
X-next-at: 44c27ab58a06e5c08647e891ceb89879d1423b71
Date: Tue, 16 Jul 2024 16:27:47 -0700
Message-ID: <xmqq8qy07w98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 03FD83E4-43CB-11EF-964C-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

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

* am/gitweb-feed-use-committer-date (2024-07-07) 1 commit
  (merged to 'next' on 2024-07-08 at 65215ab842)
 + gitweb: rss/atom change published/updated date to committer date

 GitWeb update to use committer date consistently in rss/atom feeds.
 source: <20240707184813.33166-1-080ariel@gmail.com>


* as/describe-broken-refresh-index-fix (2024-06-26) 1 commit
  (merged to 'next' on 2024-07-08 at 2307a4a4ae)
 + describe: refresh the index when 'broken' flag is used

 "git describe --dirty --broken" forgot to refresh the index before
 seeing if there is any chang, ("git describe --dirty" correctly did
 so), which has been corrected.
 source: <20240626190801.68472-1-abhijeet.nkt@gmail.com>


* bc/gitfaq-more (2024-07-09) 4 commits
  (merged to 'next' on 2024-07-10 at eeec4009e4)
 + doc: mention that proxies must be completely transparent
 + gitfaq: add entry about syncing working trees
 + gitfaq: give advice on using eol attribute in gitattributes
 + gitfaq: add documentation on proxies

 A handful of entries are added to the GitFAQ document.
 source: <20240709233746.445860-1-sandals@crustytoothpaste.net>


* bc/http-proactive-auth (2024-07-09) 1 commit
  (merged to 'next' on 2024-07-10 at 29b050bf0e)
 + http: allow authenticating proactively

 The http transport can now be told to send request with
 authentication material without first getting a 401 response.
 source: <20240710000155.947377-2-sandals@crustytoothpaste.net>


* cb/send-email-sanitize-trailer-addresses (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-09 at 442a99106a)
 + git-send-email: use sanitized address when reading mbox body

 Address-looking strings found on the trailer are now placed on the
 Cc: list after running through sanitize_address by "git send-email".
 source: <20240701090115.56957-1-csokas.bence@prolan.hu>


* cp/unit-test-reftable-record (2024-07-02) 11 commits
  (merged to 'next' on 2024-07-08 at b534dac338)
 + t-reftable-record: add tests for reftable_log_record_compare_key()
 + t-reftable-record: add tests for reftable_ref_record_compare_name()
 + t-reftable-record: add index tests for reftable_record_is_deletion()
 + t-reftable-record: add obj tests for reftable_record_is_deletion()
 + t-reftable-record: add log tests for reftable_record_is_deletion()
 + t-reftable-record: add ref tests for reftable_record_is_deletion()
 + t-reftable-record: add comparison tests for obj records
 + t-reftable-record: add comparison tests for index records
 + t-reftable-record: add comparison tests for ref records
 + t-reftable-record: add reftable_record_cmp() tests for log records
 + t: move reftable/record_test.c to the unit testing framework

 A test in reftable library has been rewritten using the unit test
 framework.
 cf. <CAOLa=ZT_x1Kf7EopU+RbBFzX3EPU5NWx6f8L9Uw=sM0MbCXDAQ@mail.gmail.com>
 source: <20240702074906.5587-1-chandrapratap3519@gmail.com>


* ds/advice-sparse-index-expansion (2024-07-08) 1 commit
  (merged to 'next' on 2024-07-09 at c821020b13)
 + advice: warn when sparse index expands

 A new warning message is issued when a command has to expand a
 sparse index to handle working tree cruft that are outside of the
 sparse checkout.
 source: <pull.1756.v2.git.1720448038745.gitgitgadget@gmail.com>


* en/ort-inner-merge-error-fix (2024-07-06) 8 commits
  (merged to 'next' on 2024-07-09 at 74bdae0b3b)
 + merge-ort: fix missing early return
  (merged to 'next' on 2024-06-28 at a85fe270e6)
 + merge-ort: convert more error() cases to path_msg()
 + merge-ort: upon merge abort, only show messages causing the abort
 + merge-ort: loosen commented requirements
 + merge-ort: clearer propagation of failure-to-function from merge_submodule
 + merge-ort: fix type of local 'clean' var in handle_content_merge ()
 + merge-ort: maintain expected invariant for priv member
 + merge-ort: extract handling of priv member into reusable function

 The "ort" merge backend saw one bugfix for a crash that happens
 when inner merge gets killed, and assorted code clean-ups.
 source: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>


* gt/unit-test-oidmap (2024-07-03) 1 commit
  (merged to 'next' on 2024-07-08 at 4e7394fc67)
 + t: migrate helper/test-oidmap.c to unit-tests/t-oidmap.c

 An existing test of oidmap API has been rewritten with the
 unit-test framework.
 source: <20240703062958.23262-2-shyamthakkar001@gmail.com>


* jc/disable-push-nego-for-deletion (2024-07-02) 1 commit
  (merged to 'next' on 2024-07-08 at 18411fb8ac)
 + push: avoid showing false negotiation errors

 "git push" that pushes only deletion gave an unnecessary and
 harmless error message when push negotiation is configured, which
 has been corrected.
 source: <xmqqo77fr2h0.fsf@gitster.g>


* jc/where-is-bash-for-ci (2024-07-08) 1 commit
  (merged to 'next' on 2024-07-09 at 14b00e672e)
 + ci: unify bash calling convention

 Shell script clean-up.
 source: <xmqqwmlvcx9g.fsf_-_@gitster.g>


* jk/tests-without-dns (2024-06-26) 3 commits
  (merged to 'next' on 2024-07-08 at 21af592457)
 + t/lib-bundle-uri: use local fake bundle URLs
 + t5551: do not confirm that bogus url cannot be used
 + t5553: use local url for invalid fetch

 Test suite has been taught not to unnecessarily rely on DNS failing
 a bogus external name.
 source: <20240626205355.GA1009060@coredump.intra.peff.net>


* mh/userdiff-typescript (2024-07-15) 1 commit
 - userdiff: add builtin diff driver for TypeScript language

 With known shortcomings.
 cf. <20240716122112.zqauqgxmng2tk2j6@archP14s>
 source: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>


* ri/doc-show-branch-fix (2024-07-08) 1 commit
  (merged to 'next' on 2024-07-08 at efcb154dfe)
 + doc: fix the max number of branches shown by "show-branch"

 Docfix.
 source: <pull.1757.v5.git.1720444080034.gitgitgadget@gmail.com>


* rj/t0612-no-longer-leaks (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-08 at a63b027a20)
 + t0612: mark as leak-free

 A test that no longer leaks has been marked as such.
 source: <86427b9e-9574-4e61-890a-691779a8da82@gmail.com>


* rj/t0613-no-longer-leaks (2024-07-01) 1 commit
  (merged to 'next' on 2024-07-08 at b6149c3032)
 + t0613: mark as leak-free

 A test that no longer leaks has been marked as such.
 source: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>


* rs/clang-format-updates (2024-07-06) 1 commit
  (merged to 'next' on 2024-07-08 at d2b5b41844)
 + clang-format: include kh_foreach* macros in ForEachMacros

 Custom control structures we invented more recently have been
 taught to the clang-format file.
 source: <4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de>


* tb/dev-build-pedantic-fix (2024-07-06) 1 commit
  (merged to 'next' on 2024-07-08 at 7f34cc6c5b)
 + config.mak.dev: fix typo when enabling -Wpedantic

 Developer build procedure fix.
 source: <cbc9446b1b0f2453b96aa9c0d89b9ec086a619bd.1720205457.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

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

 Needs review.
 source: <20240715003519.2671385-1-e@80x24.org>


* jc/document-use-of-local (2024-07-15) 1 commit
 - doc: note that AT&T ksh does not work with our test suite

 Doc update.

 Needs review.
 source: <xmqq1q3u8zmr.fsf@gitster.g>


* jt/doc-post-receive-hook-update (2024-07-15) 1 commit
 - doc: clarify post-receive hook behavior

 Doc update.

 Will merge to 'next'.
 source: <20240714194626.29512-2-jltobler@gmail.com>


* ch/refs-without-the-repository-fix (2024-07-16) 1 commit
 - refs: correct the version numbers in a comment

 Comment fix.

 Will merge to 'next'.
 source: <20240716095544.65931-1-list@eworm.de>


* jc/reflog-expire-lookup-commit-fix (2024-07-16) 1 commit
 - Revert "reflog expire: don't use lookup_commit_reference_gently()"

 "git reflog expire" failed to honor annotated tags when computing
 reachable commits.

 Needs review.
 source: <xmqqv8156rh2.fsf@gitster.g>

--------------------------------------------------
[Stalled]

* cp/unit-test-reftable-tree (2024-07-16) 6 commits
 - SQUASH?????
 - t-reftable-tree: improve the test for infix_walk()
 - t-reftable-tree: add test for non-existent key
 - t-reftable-tree: split test_tree() into two sub-test functions
 - t: move reftable/tree_test.c to the unit testing framework
 - reftable: remove unnecessary curly braces in reftable/tree.c

 A test in reftable library has been rewritten using the unit test
 framework.

 Needs review.
 source: <20240716075641.4264-1-chandrapratap3519@gmail.com>


* sj/ref-fsck (2024-07-15) 10 commits
 - fsck: add ref content check for files backend
 - fsck: add ref name check for files backend
 - files-backend: add unified interface for refs scanning
 - builtin/fsck: add `git-refs verify` child process
 - git refs: add verify subcommand
 - refs: set up ref consistency check infrastructure
 - fsck: add refs-related error report function
 - fsck: rename objects-related fsck error functions
 - fsck: add a unified interface for reporting fsck messages
 - fsck: rename "skiplist" to "skip_oids"

 "git fsck" infrastructure has been taught to also check the sanity
 of the ref database, in addition to the object database.

 Needs review.
 source: <ZpPEdmUN1Z5tqbK3@ArchLinux>


* cp/unit-test-reftable-pq (2024-06-14) 7 commits
 - t-reftable-pq: add tests for merged_iter_pqueue_top()
 - t-reftable-pq: add test for index based comparison
 - t-reftable-pq: make merged_iter_pqueue_check() callable by reference
 - t-reftable-pq: make merged_iter_pqueue_check() static
 - t: move reftable/pq_test.c to the unit testing framework
 - reftable: change the type of array indices to 'size_t' in reftable/pq.c
 - reftable: remove unncessary curly braces in reftable/pq.c

 The tests for "pq" part of reftable library got rewritten to use
 the unit test framework.

 Needs review.
 source: <20240614095136.12052-1-chandrapratap3519@gmail.com>


* tb/incremental-midx-part-1 (2024-06-07) 19 commits
 - midx: implement support for writing incremental MIDX chains
 - t/t5313-pack-bounds-checks.sh: prepare for sub-directories
 - t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - midx: implement verification support for incremental MIDXs
 - midx: support reading incremental MIDX chains
 - midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
 - midx: teach `midx_preferred_pack()` about incremental MIDXs
 - midx: teach `midx_contains_pack()` about incremental MIDXs
 - midx: remove unused `midx_locate_pack()`
 - midx: teach `fill_midx_entry()` about incremental MIDXs
 - midx: teach `nth_midxed_offset()` about incremental MIDXs
 - midx: teach `bsearch_midx()` about incremental MIDXs
 - midx: introduce `bsearch_one_midx()`
 - midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_object_oid()` about incremental MIDXs
 - midx: teach `prepare_midx_pack()` about incremental MIDXs
 - midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 - midx: add new fields for incremental MIDX chains
 - Documentation: describe incremental MIDX format

 Incremental updates of multi-pack index files.

 Needs review.
 source: <cover.1717715060.git.me@ttaylorr.com>


* pp/add-parse-range-unit-test (2024-05-27) 1 commit
 - apply: add unit tests for parse_range

 A unit test for code that parses the hunk offset and length from a
 patch fragment header as been added.

 Expecting a reroll.
 cf. <b7eca313-9ea8-4132-ba1d-ed9236e07095@gmail.com>
 source: <pull.1677.v2.git.git.1716710073910.gitgitgadget@gmail.com>


* cw/git-std-lib (2024-02-28) 4 commits
 . SQUASH??? get rid of apparent debugging crufts
 . test-stdlib: show that git-std-lib is independent
 . git-std-lib: introduce Git Standard Library
 . pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>

--------------------------------------------------
[Cooking]

* es/doc-platform-support-policy (2024-07-12) 1 commit
 - Documentation: add platform support policy

 A policy document that describes platform support levels and
 expectation on platform stakeholders has been introduced.

 Needs review response.
 cf. <xmqqed7ylbna.fsf@gitster.g>
 source: <20240711232413.693444-1-emilyshaffer@google.com>


* js/var-git-shell-path (2024-07-13) 7 commits
  (merged to 'next' on 2024-07-15 at 2e5b0eea39)
 + var(win32): do report the GIT_SHELL_PATH that is actually used
 + run-command: declare the `git_shell_path()` function globally
 + run-command(win32): resolve the path to the Unix shell early
 + mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
 + win32: override `fspathcmp()` with a directory separator-aware version
 + strvec: declare the `strvec_push_nodup()` function globally
 + run-command: refactor getting the Unix shell path into its own function

 "git var GIT_SHELL_PATH" should report the path to the shell used
 to spawn external commands, but it didn't do so on Windows, which
 has been corrected.

 Will merge to 'master'.
 source: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>


* kn/ci-clang-format (2024-07-15) 7 commits
 - check-whitespace: detect if no base_commit is provided
 - ci: run style check on GitHub and GitLab
 - clang-format: formalize some of the spacing rules
 - clang-format: replace deprecated option with 'SpacesInParens'
 - clang-format: ensure files end with newlines
 - clang-format: avoid spacing around bitfield colon
 - clang-format: indent preprocessor directives after hash

 A CI job that use clang-format to check coding style issues in new
 code has been added.

 Needs review response.
 cf. <xmqqle224npf.fsf@gitster.g>
 source: <20240715093047.49321-1-karthik.188@gmail.com>


* ps/doc-http-empty-cookiefile (2024-07-11) 1 commit
  (merged to 'next' on 2024-07-13 at 801dcb5a35)
 + doc: update http.cookieFile with in-memory cookie processing

 What happens when http.cookieFile gets the special value "" has
 been clarified in the documentation..

 Will merge to 'master'.
 source: <pull.1733.v2.git.git.1720687008915.gitgitgadget@gmail.com>


* rj/add-p-pager (2024-07-15) 4 commits
 - add-patch: render hunks through the pager
 - pager: introduce wait_for_pager
 - pager: do not close fd 2 unnecessarily
 - add-patch: test for 'p' command

 A 'P' command to "git add -p" that passes the patch hunk to the
 pager has been added.

 Needs fixing CI breakage.
 cf. <xmqqttgqyzwa.fsf@gitster.g>
 source: <a70bddd4-ef2d-488e-a2cf-48515f5df357@gmail.com>


* js/unit-test-oidtree-cmake-fix (2024-07-12) 1 commit
  (merged to 'next' on 2024-07-15 at d7aac9004c)
 + cmake: fix build of `t-oidtree`

 Build fix.

 Will merge to 'master'.
 source: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>


* kn/push-empty-fix (2024-07-12) 1 commit
  (merged to 'next' on 2024-07-13 at 74598adb55)
 + builtin/push: call set_refspecs after validating remote

 "git push '' HEAD:there" used to hit a BUG(); it has been corrected
 to die with "fatal: bad repository ''".

 Will merge to 'master'.
 source: <20240711093954.20317-1-karthik.188@gmail.com>


* ad/merge-with-diff-algorithm (2024-07-13) 1 commit
  (merged to 'next' on 2024-07-16 at 90fe5aff4d)
 + merge-recursive: honor diff.algorithm

 Many Porcelain commands that internally use the merge machinery
 were taught to consistently honor the diff.algorithm configuration.

 Will merge to 'master'.
 source: <pull.1743.v3.git.git.1720889507066.gitgitgadget@gmail.com>


* jc/http-cookiefile (2024-07-09) 1 commit
  (merged to 'next' on 2024-07-11 at abdd5711d2)
 + http.c: cookie file tightening

 The http.cookieFile and http.saveCookies configuration variables
 have a few values that need to be avoided, which are now ignored
 with warning messages.

 Will merge to 'master'.
 source: <xmqqed82cgmj.fsf@gitster.g>


* jc/checkout-no-op-switch-errors (2024-07-02) 1 commit
 - checkout: special case error messages during noop switching

 "git checkout --ours" (no other arguments) complained that the
 option is incompatible with branch switching, which is technically
 correct, but found confusing by some users.  It now says that the
 user needs to give pathspec to specify what paths to checkout.

 Needs review.
 source: <xmqqikxnqzz4.fsf@gitster.g>


* cp/unit-test-reftable-merged (2024-07-12) 7 commits
 - t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
 - t-reftable-merged: use reftable_ref_record_equal to compare ref records
 - t-reftable-merged: add tests for reftable_merged_table_max_update_index
 - t-reftable-merged: improve the const-correctness of helper functions
 - t-reftable-merged: improve the test t_merged_single_record()
 - t: harmonize t-reftable-merged.c with coding guidelines
 - t: move reftable/merged_test.c to the unit testing framework

 Another reftable test has been ported to use the unit test framework.

 Will merge to 'next'?
 source: <20240712055041.6476-1-chandrapratap3519@gmail.com>


* rs/t-strvec-use-test-msg (2024-07-16) 3 commits
  (merged to 'next' on 2024-07-16 at 3e860b3f12)
 + t-strvec: fix type mismatch in check_strvec
  (merged to 'next' on 2024-07-15 at f26e434515)
 + t-strvec: improve check_strvec() output
  (merged to 'next' on 2024-07-08 at c28c2553de)
 + t-strvec: use test_msg()

 Unit test clean-up.

 Will merge to 'master'.
 source: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 source: <983be396-f47c-4573-8c33-af8367f8ddbe@web.de>
 source: <1521ed89-989e-452b-b7fc-9e73672e0764@web.de>


* gt/unit-test-hashmap (2024-07-12) 1 commit
 - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c

 An existing test of hashmap API has been rewritten with the
 unit-test framework.

 What's the doneness of this one?
 source: <20240711235159.5320-1-shyamthakkar001@gmail.com>


* jk/test-body-in-here-doc (2024-07-10) 10 commits
  (merged to 'next' on 2024-07-11 at 854733cffc)
 + t/.gitattributes: ignore whitespace in chainlint expect files
 + t: convert some here-doc test bodies
 + test-lib: allow test snippets as here-docs
 + chainlint.pl: add tests for test body in heredoc
 + chainlint.pl: recognize test bodies defined via heredoc
 + chainlint.pl: check line numbers in expected output
 + chainlint.pl: force CRLF conversion when opening input files
 + chainlint.pl: do not spawn more threads than we have scripts
 + chainlint.pl: only start threads if jobs > 1
 + chainlint.pl: add test_expect_success call to test snippets

 The test framework learns to take the test body not as a single
 string but as a here-document.

 Will merge to 'master'.
 source: <20240710083416.GA2060328@coredump.intra.peff.net>


* rj/test-sanitize-leak-log-fix (2024-07-11) 2 commits
  (merged to 'next' on 2024-07-11 at 9961f42025)
 + test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
  (merged to 'next' on 2024-07-08 at c7ee7d03e1)
 + test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG

 Tests that use GIT_TEST_SANITIZE_LEAK_LOG feature got their exit
 status inverted, which has been corrected.

 Will merge to 'master'.
 source: <f4ae6e2a-218a-419c-b6c4-59a08be247a0@gmail.com>
 source: <fe8cd0d1-e451-43d0-b033-11bbb6d1ed56@gmail.com>


* rs/unit-tests-test-run (2024-07-01) 6 commits
 - t-strbuf: use TEST_RUN
 - t-strvec: use TEST_RUN
 - t-reftable-basics: use TEST_RUN
 - t-ctype: use TEST_RUN
 - unit-tests: add TEST_RUN
 - t0080: move expected output to a file

 Unit-test framework clean-up.

 Expecting a reroll.
 cf. <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 source: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>


* jc/patch-id (2024-06-21) 5 commits
 - patch-id: tighten code to detect the patch header
 - patch-id: rewrite code that detects the beginning of a patch
 - patch-id: make get_one_patchid() more extensible
 - patch-id: call flush_current_id() only when needed
 - t4204: patch-id supports various input format

 The patch parser in "git patch-id" has been tightened to avoid
 getting confused by lines that look like a patch header in the log
 message.

 Needs review.
 source: <20240621231826.3280338-1-gitster@pobox.com>

--------------------------------------------------
[Discarded]

* jk/add-patch-with-suppress-blank-empty (2024-07-10) 1 commit
  (merged to 'next' on 2024-07-11 at cec8ebb668)
 + add-patch: handle splitting hunks with diff.suppressBlankEmpty

 When the diff.suppressBlankEmpty configuration variable is set,
 "git add -p" failed to process a patch with an unmodified empty
 line, which has been corrected.

 Reverted out of 'next'.
 source: <20240710093610.GA2076910@coredump.intra.peff.net>


* vd/mktree (2024-06-20) 17 commits
 . mktree: remove entries when mode is 0
 . mktree: allow deeper paths in input
 . mktree: optionally add to an existing tree
 . mktree: add directory-file conflict hashmap
 . mktree: use iterator struct to add tree entries to index
 . mktree: create tree using an in-core index
 . mktree: overwrite duplicate entries
 . mktree: validate paths more carefully
 . mktree: add a --literally option
 . mktree.c: do not fail on mismatched submodule type
 . mktree: use read_index_info to read stdin lines
 . index-info.c: parse object type in provided in read_index_info
 . index-info.c: return unrecognized lines to caller
 . update-index: generalize 'read_index_info'
 . mktree: use non-static tree_entry array
 . mktree: rename treeent to tree_entry
 . mktree: use OPT_BOOL

 "git mktree" has been rewritten, taking advantage of the cache-tree
 API.

 Retracted for now.
 cf. <047b889e-fa6d-4c4a-b486-0bc80922c4ca@github.com>
 source: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>


* mh/userdiff-typescript (2024-07-15) 1 commit
 . userdiff: add builtin diff driver for TypeScript language

 Retracted for now.
 cf. <20240716193344.bjb62zsfnrfw3ngf@archP14s>
 source: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>

