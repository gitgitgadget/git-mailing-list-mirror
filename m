Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B3158D6E
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705496; cv=none; b=qwmBaR0O4cAknfl3bjUs4/aHdLfq4Kzym6/BSRHrir0YEqlWTAedOz7pYHCxE3CDsIG7DJrhlPsyBXLrava3CAokwJ7LWuj6UstdKM9G1272BSMs1sdADSHLxQmevdKRGQ6L+QW6fPfwwu5GpQzLJIN4LbRuWFnkMA7KVYHcbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705496; c=relaxed/simple;
	bh=1lMGd3Wjs2ANsExUz2CeQ/18cSmbkAiQYgp9InJTWYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pS0/MelMKlwuESPyxduW1Aa+WCMJEUEmNPZLVD9rszSK+ulvzIftCz+6pFEg+k0wE16V6eAGD1YzDWpd2XZ7Y0SFdVsAIytaHSy+cp1ooD+H6qTFJJRRGr3AP67CQYs0RtI9fpEMlWjKxl8n/xvAU0UZMFCZByw2wGZ1g4/z+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ozBFU/V4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozBFU/V4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87A951E74CF;
	Tue,  9 Apr 2024 19:31:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	lMGd3Wjs2ANsExUz2CeQ/18cSmbkAiQYgp9InJTWYM=; b=ozBFU/V4JuaFfs0cI
	O2eGtppOLzKC8d/4MzhFqJ/6Wp44EswHIyErfEw8a1EzI2dXnPqtL1ioDILgkI4n
	1Swc/D4sQ6miPffQ5/+/mpBnzoVq32FW3YMm4EKuguvjEfAuNyE5ZDLZ+8uJZg6m
	kKLJhCkJ3xAzmyM322x59ywPl8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FCBE1E74CC;
	Tue,  9 Apr 2024 19:31:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62FCE1E74CB;
	Tue,  9 Apr 2024 19:31:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2024, #04; Tue, 9)
X-master-at: 91ec36f2cca02d33ab0ed6e87195c6fe801debae
X-next-at: 1a5e3faff75d1d3622627d3820bc57b4c2728bc5
Date: Tue, 09 Apr 2024 16:31:30 -0700
Message-ID: <xmqqttkayuy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4BB77766-F6C9-11EE-853B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

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

* dg/myfirstobjectwalk-updates (2024-03-27) 5 commits
  (merged to 'next' on 2024-04-02 at effa6a98a6)
 + MyFirstObjectWalk: add stderr to pipe processing
 + MyFirstObjectWalk: fix description for counting omitted objects
 + MyFirstObjectWalk: fix filtered object walk
 + MyFirstObjectWalk: fix misspelled "builtins/"
 + MyFirstObjectWalk: use additional arg in config_fn_t

 Update a more recent tutorial doc.
 source: <cover.1711537370.git.dirk@gouders.net>


* es/test-cron-safety (2024-03-31) 1 commit
  (merged to 'next' on 2024-04-02 at e383c8cfb2)
 + test-lib: fix non-functioning GIT_TEST_MAINT_SCHEDULER fallback

 The test script had an incomplete and ineffective attempt to avoid
 clobbering the testing user's real crontab (and its equivalents),
 which has been completed.
 source: <20240329222703.9343-1-ericsunshine@charter.net>


* ja/doc-markup-updates (2024-03-29) 5 commits
  (merged to 'next' on 2024-04-02 at 69b015d7ce)
 + doc: git-clone: do not autoreference the manpage in itself
 + doc: git-clone: apply new documentation formatting guidelines
 + doc: git-init: apply new documentation formatting guidelines
 + doc: allow literal and emphasis format in doc vs help tests
 + doc: rework CodingGuidelines with new formatting rules

 Documentation rules has been explicitly described how to mark-up
 literal parts and a few manual pages have been updated as examples.
 source: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>


* jc/advice-sans-trailing-whitespace (2024-03-29) 1 commit
  (merged to 'next' on 2024-04-02 at 3cb0fda1bf)
 + advice: omit trailing whitespace

 The "hint:" messages given by the advice mechanism, when given a
 message with a blank line, left a line with trailing whitespace,
 which has been cleansed.
 source: <xmqq4jcooddp.fsf@gitster.g>


* jc/apply-parse-diff-git-header-names-fix (2024-03-29) 3 commits
  (merged to 'next' on 2024-04-02 at d1fa726c41)
 + t4126: fix "funny directory name" test on Windows (again)
  (merged to 'next' on 2024-03-28 at a35de15836)
 + t4126: make sure a directory with SP at the end is usable
  (merged to 'next' on 2024-03-27 at d586367985)
 + apply: parse names out of "diff --git" more carefully

 "git apply" failed to extract the filename the patch applied to,
 when the change was about an empty file created in or deleted from
 a directory whose name ends with a SP, which has been corrected.
 source: <xmqqfrwlltjn.fsf@gitster.g>
 source: <xmqqh6gqt674.fsf_-_@gitster.g>
 source: <xmqq5xx50x8p.fsf_-_@gitster.g>


* mg/editorconfig-makefile (2024-03-23) 1 commit
  (merged to 'next' on 2024-04-02 at 907b55579e)
 + editorconfig: add Makefiles to "text files"

 The .editorconfig file has been taught that a Makefile uses HT
 indentation.
 source: <20240322221813.13019-1-mg@max.gautier.name>


* ps/pack-refs-auto (2024-03-25) 16 commits
  (merged to 'next' on 2024-04-02 at 1d76dc3648)
 + builtin/gc: pack refs when using `git maintenance run --auto`
 + builtin/gc: forward git-gc(1)'s `--auto` flag when packing refs
 + t6500: extract objects with "17" prefix
 + builtin/gc: move `struct maintenance_run_opts`
 + builtin/pack-refs: introduce new "--auto" flag
 + builtin/pack-refs: release allocated memory
 + refs/reftable: expose auto compaction via new flag
 + refs: remove `PACK_REFS_ALL` flag
 + refs: move `struct pack_refs_opts` to where it's used
 + t/helper: drop pack-refs wrapper
 + refs/reftable: print errors on compaction failure
 + reftable/stack: gracefully handle failed auto-compaction due to locks
 + reftable/stack: use error codes when locking fails during compaction
 + reftable/error: discern locked/outdated errors
 + reftable/stack: fix error handling in `reftable_stack_init_addition()`
 + Merge branch 'ps/reftable-stack-tempfile' into ps/pack-refs-auto
 (this branch is used by jt/reftable-geometric-compaction.)

 "git pack-refs" learned the "--auto" option, which is a useful
 addition to be triggered from "git gc --auto".

 Acked-by: Karthik Nayak <karthik.188@gmail.com>
 cf. <CAOLa=ZRAEA7rSUoYL0h-2qfEELdbPHbeGpgBJRqesyhHi9Q6WQ@mail.gmail.com>
 source: <cover.1711360631.git.ps@pks.im>


* rj/add-p-explicit-reshow (2024-03-29) 2 commits
  (merged to 'next' on 2024-04-02 at 05c7e930af)
 + add-patch: do not print hunks repeatedly
 + add-patch: introduce 'p' in interactive-patch

 "git add -p" and other "interactive hunk selection" UI has learned to
 skip showing the hunk immediately after it has already been shown, and
 an additional action to explicitly ask to reshow the current hunk.
 source: <a9c515fe-6664-4b5d-abca-d88fdd32a883@gmail.com>


* rj/use-adv-if-enabled (2024-03-30) 3 commits
  (merged to 'next' on 2024-04-02 at 31d4453035)
 + add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO
 + add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
 + add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE

 Use advice_if_enabled() API to rewrite a simple pattern to
 call advise() after checking advice_enabled().
 source: <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>

--------------------------------------------------
[New Topics]

* rs/date-mode-pass-by-value (2024-04-05) 1 commit
 - date: make DATE_MODE thread-safe

 The codepaths that reach date_mode_from_type() have been updated to
 pass "struct date_mode" by value to make them thread safe.

 Will merge to 'next'.
 source: <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>


* rs/usage-fallback-to-show-message-format (2024-04-05) 1 commit
 - usage: report vsnprintf(3) failure

 vreportf(), which is usede by error() and friends, has been taught
 to give the error message printf-format string when its vsnprintf()
 call fails, instead of showing nothing useful to identify the
 nature of the error.

 Will merge to 'next'.
 source: <3da13298-b6a6-4391-b8e8-5dae9a28b860@web.de>


* jc/local-extern-shell-rules (2024-04-05) 8 commits
 - t1016: local VAR="VAL" fix
 - t0610: local VAR="VAL" fix
 - t: teach lint that RHS of 'local VAR=VAL' needs to be quoted
 - t: local VAR="VAL" (quote ${magic-reference})
 - t: local VAR="VAL" (quote command substitution)
 - t: local VAR="VAL" (quote positional parameters)
 - CodingGuidelines: quote assigned value in 'local var=$val'
 - CodingGuidelines: describe "export VAR=VAL" rule

 Document and apply workaround for a buggy version of dash that
 mishandles "local var=val" construct.

 Will merge to 'next'.
 source: <20240406000902.3082301-1-gitster@pobox.com>


* jc/unleak-core-excludesfile (2024-04-08) 1 commit
 - config: do not leak excludes_file

 The variable that holds the value read from the core.excludefile
 configuration variable used to leak, which has been corrected.

 Will merge to 'next'.
 source: <xmqqttkeicov.fsf@gitster.g>


* la/doc-use-of-contacts-when-contributing (2024-04-05) 8 commits
 - SubmittingPatches: demonstrate using git-contacts with git-send-email
 - SubmittingPatches: add heading for format-patch and send-email
 - SubmittingPatches: dedupe discussion of security patches
 - SubmittingPatches: discuss reviewers first
 - SubmittingPatches: quote commands
 - SubmittingPatches: mention GitGitGadget
 - SubmittingPatches: make 'git contacts' grep-friendly
 - MyFirstContribution: mention contrib/contacts/git-contacts

 Advertise "git contacts", a tool for newcomers to find people to
 ask review for their patches, a bit more in our developer
 documentation.

 Expecting a reroll.
 cf. <owlypluzs5qa.fsf@fine.c.googlers.com>
 source: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>


* ps/ci-test-with-jgit (2024-04-08) 12 commits
 - t0612: add tests to exercise Git/JGit reftable compatibility
 - t0610: fix non-portable variable assignment
 - t06xx: always execute backend-specific tests
 - ci: install JGit dependency
 - ci: make Perforce binaries executable for all users
 - ci: merge scripts which install dependencies
 - ci: merge custom PATH directories
 - ci: convert "install-dependencies.sh" to use "/bin/sh"
 - ci: drop duplicate package installation for "linux-gcc-default"
 - ci: allow skipping sudo on dockerized jobs
 - ci: expose distro name in dockerized GitHub jobs
 - ci: rename "runs_on_pool" to "distro"

 Tests to ensure interoperability between reftable written by jgit
 and our code have been added and enabled in CI.

 Comments?
 source: <cover.1712555682.git.ps@pks.im>


* pw/rebase-i-error-message (2024-04-08) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Comments?
 source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>


* tb/make-indent-conditional-with-non-spaces (2024-04-08) 2 commits
 - Makefile(s): do not enforce "all indents must be done with tab"
 - Makefile(s): avoid recipe prefix in conditional statements

 Adjust to an upcoming changes to GNU make that breaks our Makefiles.

 Will merge to 'next'.
 source: <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>


* ps/t0610-umask-fix (2024-04-09) 2 commits
 - t0610: execute git-pack-refs(1) with specified umask
 - t0610: make `--shared=` tests reusable

 The "shared repository" test in the t0610 reftable test failed
 under restrictive umask setting (e.g. 007), which has been
 corrected.

 Will merge to 'next'.
 source: <cover.1712656576.git.ps@pks.im>

--------------------------------------------------
[Cooking]

* ma/win32-unix-domain-socket (2024-04-03) 1 commit
  (merged to 'next' on 2024-04-09 at b98021a65c)
 + Win32: detect unix socket support at runtime

 Windows binary used to decide the use of unix-domain socket at
 build time, but it learned to make the decision at runtime instead.

 Will merge to 'master'.
 source: <pull.1708.git.1712158923106.gitgitgadget@gmail.com>


* ps/reftable-write-optim (2024-04-08) 11 commits
 - reftable/block: reuse compressed array
 - reftable/block: reuse zstream when writing log blocks
 - reftable/writer: reset `last_key` instead of releasing it
 - reftable/writer: unify releasing memory
 - reftable/writer: refactorings for `writer_flush_nonempty_block()`
 - reftable/writer: refactorings for `writer_add_record()`
 - refs/reftable: don't recompute committer ident
 - reftable: remove name checks
 - refs/reftable: skip duplicate name checks
 - refs/reftable: perform explicit D/F check when writing symrefs
 - refs/reftable: fix D/F conflict error message on ref copy

 Code to write out reftable has seen some optimization and
 simplification.
 source: <cover.1712578837.git.ps@pks.im>


* ds/send-email-per-message-block (2024-04-08) 3 commits
 - send-email: separate the confirmation prompts from the messages
 - send-email: make it easy to discern the messages for each patch
 - send-email: move newline character out of a translatable string

 "git send-email" learned to separate its reports on each message it
 sends out with an extra blank line in between.

 Comments?
 source: <cover.1712486910.git.dsimic@manjaro.org>


* ds/fetch-config-parse-microfix (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-09 at 585dcadd63)
 + fetch: return when parsing submodule.recurse

 A config parser callback function fell through instead of returning
 after recognising and processing a variable, wasting cycles, which
 has been corrected.

 Will merge to 'master'.
 source: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>


* rs/apply-lift-path-length-limit (2024-04-05) 2 commits
  (merged to 'next' on 2024-04-09 at 3270d194fd)
 + path: remove mksnpath()
 + apply: avoid fixed-size buffer in create_one_file()

 "git apply" has been updated to lift the hardcoded pathname length
 limit, which in turn allowed a mksnpath() function that is no
 longer used.

 Will merge to 'master'.
 source: <df774306-f29b-4a75-a282-59db89812b9a@web.de>


* rs/apply-reject-fd-leakfix (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-09 at 11efa0543c)
 + apply: don't leak fd on fdopen() error

 A file descriptor leak in an error codepath, used when "git apply
 --reject" fails to create the *.rej file, has been corrected.

 Will merge to 'master'.
 source: <5ba55ee4-94c7-4094-a744-584fc623b391@web.de>


* kn/clarify-update-ref-doc (2024-04-02) 2 commits
  (merged to 'next' on 2024-04-02 at d1b9c5aa67)
 + githooks: use {old,new}-oid instead of {old,new}-value
 + update-ref: use {old,new}-oid instead of {old,new}value

 Doc update, as a preparation to enhance "git update-ref --stdin".

 Will merge to 'master'.
 source: <20240402064915.191104-1-knayak@gitlab.com>


* vs/complete-with-set-u-fix (2024-04-01) 2 commits
  (merged to 'next' on 2024-04-02 at d8f6a511e8)
 + completion: protect prompt against unset SHOWUPSTREAM in nounset mode
 + completion: fix prompt with unset SHOWCONFLICTSTATE in nounset mode

 Another "set -u" fix for the bash prompt (in contrib/) script.

 Will merge to 'master'.
 source: <20240401190751.8676-1-ville.skytta@iki.fi>


* ba/osxkeychain-updates (2024-04-01) 4 commits
 - osxkeychain: store new attributes
 - osxkeychain: erase matching passwords only
 - osxkeychain: erase all matching credentials
 - osxkeychain: replace deprecated SecKeychain API

 Update osxkeychain backend with features required for the recent
 credential subsystem.

 Will merge to 'next'?
 source: <pull.1667.git.1708212896.gitgitgadget@gmail.com>


* rs/imap-send-use-xsnprintf (2024-04-02) 1 commit
  (merged to 'next' on 2024-04-04 at 789ad853e1)
 + imap-send: use xsnprintf to format command

 Code clean-up and duplicate reduction.

 Will merge to 'master'.
 source: <f9ad9f41-5b9b-474e-9818-f91fc937daae@web.de>


* tb/midx-write (2024-04-01) 5 commits
  (merged to 'next' on 2024-04-05 at b4870116f7)
 + midx-write.c: use `--stdin-packs` when repacking
 + midx-write.c: check count of packs to repack after grouping
 + midx-write.c: factor out common want_included_pack() routine
 + midx-write: move writing-related functions from midx.c
 + Merge branch 'rs/midx-use-strvec-pushf' into tb/midx-write

 Code clean-up by splitting code responsible for writing midx files
 into its own file.

 Will merge to 'master'.
 source: <cover.1712006190.git.me@ttaylorr.com>


* jc/t2104-style-update (2024-04-02) 1 commit
  (merged to 'next' on 2024-04-03 at 0449835479)
 + t2104: style fixes

 Coding style fixes.

 Will merge to 'master'.
 source: <xmqqmsqb4ngg.fsf@gitster.g>


* rs/t-prio-queue-cleanup (2024-04-02) 1 commit
  (merged to 'next' on 2024-04-04 at 7961c838ac)
 + t-prio-queue: simplify using compound literals

 t-prio-queue test has been cleaned up by using C99 compound
 literals; this is meant to also serve as a weather-balloon to smoke
 out folks with compilers who have trouble compiling code that uses
 the feature.

 Will merge to 'master'.
 source: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>


* jk/libcurl-8.7-regression-workaround (2024-04-05) 3 commits
 - remote-curl: add Transfer-Encoding header only for older curl
 - INSTALL: bump libcurl version to 7.21.3
 - http: reset POSTFIELDSIZE when clearing curl handle

 Fix was added to work around a regression in libcURL 8.7.0 (which has
 already been fixed in their tip of the tree).

 Will merge to 'next'.
 source: <20240402200254.GA874754@coredump.intra.peff.net>


* tb/t7700-fixup (2024-04-03) 1 commit
 - t/t7700-repack.sh: fix test breakages with `GIT_TEST_MULTI_PACK_INDEX=1 `

 Test fix.

 Will merge to 'next'.
 source: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>


* gt/add-u-commit-i-pathspec-check (2024-04-03) 3 commits
  (merged to 'next' on 2024-04-09 at 1a0c757907)
 + builtin/add: error out when passing untracked path with -u
 + builtin/commit: error out when passing untracked path with -i
 + revision: optionally record matches with pathspec elements

 "git add -u <pathspec>" and "git commit [-i] <pathspec>" did not
 diagnose a pathspec element that did not match any files in certain
 situations, unlike "git add <pathspec>" did.

 Will merge to 'master'.
 source: <20240402213640.139682-2-shyamthakkar001@gmail.com>


* jt/reftable-geometric-compaction (2024-04-08) 4 commits
 - reftable/stack: use geometric table compaction
 - reftable/stack: add env to disable autocompaction
 - reftable/stack: expose option to disable auto-compaction
 - Merge branch 'ps/pack-refs-auto' into jt/reftable-geometric-compaction

 The strategy to compact multiple tables of reftables after many
 operations accumulate many entries has been improved to avoid
 accumulating too many tables uncollected.

 Comments?
 source: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>


* ds/typofix-core-config-doc (2024-03-31) 1 commit
  (merged to 'next' on 2024-04-02 at 79496fcfc4)
 + config: fix some small capitalization issues, as spotted

 Typofix.

 Will merge to 'master'.
 source: <26135b06c48565ee8ac6dcfc1ef5431511e6202c.1711918168.git.dsimic@manjaro.org>


* jc/checkout-detach-wo-tracking-report (2024-03-30) 1 commit
  (merged to 'next' on 2024-04-04 at 161eca247d)
 + checkout: omit "tracking" information on a detached HEAD

 "git checkout/switch --detach foo", after switching to the detached
 HEAD state, gave the tracking information for the 'foo' branch,
 which was pointless.

 Tested-by: M Hickford <mirth.hickford@gmail.com>
 cf. <CAGJzqsmE9FDEBn=u3ge4LA3ha4fDbm4OWiuUbMaztwjELBd7ug@mail.gmail.com>

 Will merge to 'master'.
 source: <xmqqa5mfl7ud.fsf@gitster.g>


* rs/mem-pool-size-t-safety (2024-03-31) 1 commit
  (merged to 'next' on 2024-04-02 at 3517d48210)
 + mem-pool: use st_add() in mem_pool_strvfmt()

 size_t arithmetic safety.

 Will merge to 'master'.
 source: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 source: <20240328101356.300374-1-e@80x24.org>


* ps/reftable-block-iteration-optim (2024-03-27) 9 commits
 - reftable/block: reuse `zstream` state on inflation
 - reftable/block: open-code call to `uncompress2()`
 - reftable/block: reuse uncompressed blocks
 - reftable/reader: iterate to next block in place
 - reftable/block: move ownership of block reader into `struct table_iter`
 - reftable/block: introduce `block_reader_release()`
 - reftable/block: better grouping of functions
 - reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
 - reftable/block: rename `block_reader_start()`

 The code to iterate over reftable blocks has seen some optimization
 to reduce memory allocation and deallocation.

 Needs review.
 source: <cover.1711519925.git.ps@pks.im>


* bc/credential-scheme-enhancement (2024-03-27) 12 commits
 . credential: add support for multistage credential rounds
 . t5563: refactor for multi-stage authentication
 . docs: set a limit on credential line length
 . credential: enable state capability
 . credential: add an argument to keep state
 . http: add support for authtype and credential
 . docs: indicate new credential protocol fields
 . credential: gate new fields on capability
 . credential: add a field for pre-encoded credentials
 . http: use new headers for each object request
 . remote-curl: reset headers on new request
 . credential: add an authtype field

 The credential helper protocol, together with the HTTP layer, have
 been enhanced to support authentication schemes different from
 username & password pair, like Bearer and NTLM.

 Expecting a reroll.
 cf. <ZgSQ5o_KyqDaxz1m@tapette.crustytoothpaste.net>
 source: <20240324011301.1553072-1-sandals@crustytoothpaste.net>


* ps/reftable-binsearch-updates (2024-04-03) 7 commits
  (merged to 'next' on 2024-04-04 at 40e6d5a36b)
 + reftable/block: avoid decoding keys when searching restart points
 + reftable/record: extract function to decode key lengths
 + reftable/block: fix error handling when searching restart points
 + reftable/block: refactor binary search over restart points
 + reftable/refname: refactor binary search over refnames
 + reftable/basics: improve `binsearch()` test
 + reftable/basics: fix return type of `binsearch()` to be `size_t`

 Reftable code clean-up and some bugfixes.

 Will merge to 'master'.
 source: <cover.1712123093.git.ps@pks.im>


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

 The pack-bitmap machinery learned to write pseudo-merge bitmaps,
 which act as imaginary octopus merges covering un-bitmapped
 reference tips. This enhances bitmap coverage, and thus,
 performance, for repositories with many references using bitmaps.

 Expecting a reroll.
 cf. <ZfyxCLpjbaScIdWA@nand.local>
 source: <cover.1710972293.git.me@ttaylorr.com>


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

 Needs review.
 source: <pull.1696.git.1710570428.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


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


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* js/build-fuzz-more-often (2024-03-05) 3 commits
 - SQUASH???
 - fuzz: link fuzz programs with `make all` on Linux
 - ci: also define CXX environment variable

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.

 Stalled.
 cf. <xmqq1q7w8xx6.fsf@gitster.g>
 source: <cover.1709673020.git.steadmon@google.com>


* sj/userdiff-c-sharp (2024-04-05) 1 commit
 - userdiff: better method/property matching for C#

 The userdiff patterns for C# has been updated.

 Acked-by: Johannes Sixt <j6t@kdbg.org>
 cf. <c2154457-3f2f-496e-9b8b-c8ea7257027b@kdbg.org>

 Will merge to 'next'.
 source: <pull.1682.v5.git.git.1712180564927.gitgitgadget@gmail.com>


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


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
