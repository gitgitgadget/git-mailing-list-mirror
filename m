Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BB360
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710548893; cv=none; b=uVTKBpOazID9aTRFKwgWomjFDo0vspx4kLcesl6Cd/6pBuAnLBO/Eq9WgJi/d4b/kPhKYUVCLq5dDp/mGzq/jSGO0ld2581SMxbM2RgafFzCQiOwYw5tmzNNq7tAgzSKhqxmhBRY+AKM//lyqIb0qnLjR96Jl+vfnfnSk0twmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710548893; c=relaxed/simple;
	bh=uY/RPa2ty/+KWAVHUSzxsFHf8lF+7I1l21nm8lh9BgU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLXy3YsgoqYIQSmVTfnyjMubHaFWtXecScVgGG+XhwjeiiumlJtTCwqKw4CH4x9V3euyivF0TkRmK2D/S4ccFN1RFjT3+sPh3aNKpxGrW2vNGTKLWTRQfU4RJBhTiQapJKzMhCNNSfsrqcL4qZbjkEgelB9/Zkyti/aIDrm4PbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lYbdVzdU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lYbdVzdU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 229621E6299;
	Fri, 15 Mar 2024 20:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	Y/RPa2ty/+KWAVHUSzxsFHf8lF+7I1l21nm8lh9BgU=; b=lYbdVzdU9RaGfX8v/
	FQyGRuC6Lw9pcmy+fGp9iRR4xn2w+FT9PKi+7z/7vC0D8ONy86+rqAhO2Ov0njxV
	hzsgZapry4VxpM6TJ0w+tsfgCoB0MHsjPPBmuuBcm15oR2ZCjmJUMaS5+dr1MC9O
	P9FHm0PK05DPRrFoJxlLxKKivE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B0DB1E6298;
	Fri, 15 Mar 2024 20:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49D1C1E6297;
	Fri, 15 Mar 2024 20:26:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2024, #04; Fri, 15)
X-master-at: 2953d95d402b6bff1a59c4712f4d46f1b9ea137f
X-next-at: cdc2e80fe5f5dd8f872f21cdcd608126da6ccc7e
Date: Fri, 15 Mar 2024 17:26:13 -0700
Message-ID: <xmqqedcbnhsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CC25D4C6-E32B-11EE-AE30-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

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

* ag/t0010-modernize (2024-03-05) 1 commit
  (merged to 'next' on 2024-03-07 at 38339abc2d)
 + tests: modernize the test script t0010-racy-git.sh

 GSoC practice to modernize a test script.
 source: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>


* as/option-names-in-messages (2024-03-05) 4 commits
  (merged to 'next' on 2024-03-07 at 73ab51faba)
 + revision.c: trivial fix to message
 + builtin/clone.c: trivial fix of message
 + builtin/remote.c: trivial fix of error message
 + transport-helper.c: trivial fix of error message

 Error message updates.
 source: <20240216101647.28837-1-ash@kambanaria.org>


* gt/core-bare-in-templates (2024-03-04) 1 commit
  (merged to 'next' on 2024-03-06 at e54ac5acf9)
 + setup: remove unnecessary variable

 Code simplification.
 source: <20240304151811.511780-1-shyamthakkar001@gmail.com>


* hd/config-mak-os390 (2024-03-06) 1 commit
  (merged to 'next' on 2024-03-07 at 289d3ab691)
 + build: support z/OS (OS/390).

 Platform specific tweaks for OS/390 has been added to
 config.mak.uname.
 source: <pull.1663.v4.git.git.1709703857881.gitgitgadget@gmail.com>


* jc/test-i18ngrep (2024-03-02) 1 commit
  (merged to 'next' on 2024-03-06 at 2c57ebc706)
 + test_i18ngrep: hard deprecate and forbid its use

 With release 2.44 we got rid of all uses of test_i18ngrep and there
 is no in-flight topic that adds a new use of it.  Make a call to
 test_i18ngrep a hard failure, so that we can remove it at the end
 of this release cycle.
 source: <xmqq5xy4zhdc.fsf@gitster.g>


* jc/xwrite-cleanup (2024-03-02) 3 commits
  (merged to 'next' on 2024-03-07 at 43e66f7e4d)
 + repack: check error writing to pack-objects subprocess
 + sideband: avoid short write(2)
 + unpack: replace xwrite() loop with write_in_full()

 Uses of xwrite() helper have been audited and updated for better
 error checking and simpler code.
 source: <20240302190348.3946569-1-gitster@pobox.com>


* jh/fsmonitor-icase-corner-case-fix (2024-03-06) 14 commits
  (merged to 'next' on 2024-03-06 at 356eafea7e)
 + fsmonitor: support case-insensitive events
 + fsmonitor: refactor bit invalidation in refresh callback
 + fsmonitor: trace the new invalidated cache-entry count
 + fsmonitor: return invalidated cache-entry count on non-directory event
 + fsmonitor: remove custom loop from non-directory path handler
 + fsmonitor: return invalidated cache-entry count on directory event
 + fsmonitor: move untracked-cache invalidation into helper functions
 + fsmonitor: refactor untracked-cache invalidation
 + dir: create untracked_cache_invalidate_trimmed_path()
 + fsmonitor: refactor refresh callback for non-directory events
 + fsmonitor: clarify handling of directory events in callback helper
 + fsmonitor: refactor refresh callback on directory events
 + t7527: add case-insensitve test for FSMonitor
 + name-hash: add index_dir_find()

 FSMonitor client code was confused when FSEvents were given in a
 different case on a case-insensitive filesystem, which has been
 corrected.

 Acked-by: Patrick Steinhardt <ps@pks.im>
 cf. <ZehofMaSZyUq8S1N@tanuki>
 source: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>


* kh/branch-ref-syntax-advice (2024-03-05) 5 commits
  (merged to 'next' on 2024-03-07 at 914f01967b)
 + branch: advise about ref syntax rules
 + advice: use double quotes for regular quoting
 + advice: use backticks for verbatim
 + advice: make all entries stylistically consistent
 + t3200: improve test style

 When git refuses to create a branch because the proposed branch
 name is not a valid refname, an advice message is given to refer
 the user to exact naming rules.
 source: <cover.1709670287.git.code@khaugsbakk.name>


* kh/doc-commentchar-is-a-byte (2024-03-05) 1 commit
  (merged to 'next' on 2024-03-06 at 5941655c04)
 + config: document `core.commentChar` as ASCII-only

 The "core.commentChar" configuration variable only allows an ASCII
 character, which was not clearly documented, which has been
 corrected.
 source: <9633f9be5ddd9ab3df4b79ee934e1ed47e90bd1d.1709656683.git.code@khaugsbakk.name>


* la/trailer-api (2024-03-01) 9 commits
  (merged to 'next' on 2024-03-06 at f119923ff6)
 + format_trailers_from_commit(): indirectly call trailer_info_get()
 + format_trailer_info(): move "fast path" to caller
 + format_trailers(): use strbuf instead of FILE
 + trailer_info_get(): reorder parameters
 + trailer: move interpret_trailers() to interpret-trailers.c
 + trailer: reorder format_trailers_from_commit() parameters
 + trailer: rename functions to use 'trailer'
 + shortlog: add test for de-duplicating folded trailers
 + trailer: free trailer_info _after_ all related usage

 Trailer API updates.

 Acked-by: Christian Couder <christian.couder@gmail.com>
 cf. <CAP8UFD1Zd+9q0z1JmfOf60S2vn5-sD3SafDvAJUzRFwHJKcb8A@mail.gmail.com>
 source: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>


* ps/reftable-iteration-perf-part2 (2024-03-04) 13 commits
  (merged to 'next' on 2024-03-06 at e8ba314585)
 + refs/reftable: precompute prefix length
 + reftable: allow inlining of a few functions
 + reftable/record: decode keys in place
 + reftable/record: reuse refname when copying
 + reftable/record: reuse refname when decoding
 + reftable/merged: avoid duplicate pqueue emptiness check
 + reftable/merged: circumvent pqueue with single subiter
 + reftable/merged: handle subiter cleanup on close only
 + reftable/merged: remove unnecessary null check for subiters
 + reftable/merged: make subiters own their records
 + reftable/merged: advance subiter on subsequent iteration
 + reftable/merged: make `merged_iter` structure private
 + reftable/pq: use `size_t` to track iterator index
 (this branch is used by ps/reftable-reflog-iteration-perf.)

 The code to iterate over refs with the reftable backend has seen
 some optimization.
 source: <cover.1709548907.git.ps@pks.im>


* rj/complete-reflog (2024-03-03) 5 commits
  (merged to 'next' on 2024-03-06 at 0f1a25debc)
 + completion: reflog subcommands and options
 + completion: factor out __git_resolve_builtins
 + completion: introduce __git_find_subcommand
 + completion: reflog show <log-options>
 + completion: reflog with implicit "show"

 The command line completion script (in contrib/) learned to
 complete "git reflog" better.
 source: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>


* rj/complete-worktree-paths-fix (2024-02-27) 1 commit
  (merged to 'next' on 2024-03-06 at b6ba949383)
 + completion: fix __git_complete_worktree_paths

 The logic to complete the command line arguments to "git worktree"
 subcommand (in contrib/) has been updated to correctly honor things
 like "git -C dir" etc.
 source: <b8f09e20-d0d3-4e0b-afe2-31affeb61052@gmail.com>


* so/clean-dry-run-without-force (2024-03-04) 2 commits
  (merged to 'next' on 2024-03-06 at ccf2e123be)
 + clean: further clean-up of implementation around "--force"
 + clean: improve -n and -f implementation and documentation

 The implementation in "git clean" that makes "-n" and "-i" ignore
 clean.requireForce has been simplified, together with the
 documentation.
 source: <87le6ziqzb.fsf_-_@osv.gnss.ru>
 source: <20240303220600.2491792-1-gitster@pobox.com>


* vm/t7301-use-test-path-helpers (2024-03-06) 1 commit
  (merged to 'next' on 2024-03-07 at e638654635)
 + t7301: use test_path_is_(missing|file)

 GSoC practice to replace "test -f" with "test_path_is_file".
 source: <20240304171732.64457-2-vincenzo.mezzela@gmail.com>

--------------------------------------------------
[New Topics]

* bb/iso-strict-utc (2024-03-13) 1 commit
  (merged to 'next' on 2024-03-14 at d2ac616873)
 + date: make "iso-strict" conforming for the UTC timezone

 The output format for dates "iso-strict" has been tweaked to show
 a time in the Zulu timezone with "Z" suffix, instead of "+00:00".

 Will merge to 'master'.
 source: <20240313225423.11373-1-dev+git@drbeat.li>


* dg/user-manual-hash-example (2024-03-12) 1 commit
  (merged to 'next' on 2024-03-14 at 767800d3a7)
 + Documentation/user-manual.txt: example for generating object hashes

 User manual (the original one) update.

 Will merge to 'master'.
 source: <20240312104238.4920-2-dirk@gouders.net>


* jc/show-untracked-false (2024-03-13) 2 commits
 - status: allow --untracked=false and friends
 - status: unify parsing of --untracked= and status.showUntrackedFiles

 The status.showUntrackedFiles configuration variable had a name
 that tempts users to set a Boolean value expressed in our usual
 "false", "off", and "0", but it only took "no".  This has been
 corrected so "true" and its synonyms are taken as "normal", while
 "false" and its synonyms are taken as "no".

 Will merge to 'next'?
 source: <20240313173214.962532-1-gitster@pobox.com>


* js/bugreport-no-suffix-fix (2024-03-14) 1 commit
 - bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option

 "git bugreport --no-suffix" was not supported and instead
 segfaulted, which has been corrected.

 Will merge to 'next'?
 source: <9c6f3f5203ae26c501a5711e2610573130bfd550.1710388817.git.gitgitgadget@gmail.com>


* jw/doc-show-untracked-files-fix (2024-03-13) 1 commit
  (merged to 'next' on 2024-03-14 at 091f64ad6c)
 + doc: status.showUntrackedFiles does not take "false"

 The status.showUntrackedFiles configuration variable was
 incorrectly documented to accept "false", which has been corrected.

 Will merge to 'master'.
 source: <pull.1686.git.git.1710279251901.gitgitgadget@gmail.com>


* ph/diff-src-dst-prefix-config (2024-03-15) 1 commit
 - diff: add diff.srcPrefix and diff.dstPrefix configuration variables

 "git diff" and friends learned two extra configuration variables.

 What's the status of this thing?
 source: <20240315010310.GA1901653@quokka>


* ps/clone-with-includeif-onbranch (2024-03-12) 1 commit
 - t5601: exercise clones with "includeIf.*.onbranch"

 An additional test to demonstrate something I am not sure what.

 Waiting for a review response.
 cf. <xmqqo7bjjid9.fsf@gitster.g>
 source: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>


* bb/t0006-negative-tz-offset (2024-03-14) 1 commit
  (merged to 'next' on 2024-03-14 at 3f4751b6b2)
 + t0006: add more tests with a negative TZ offset

 More tests on showing time with negative TZ offset.

 Will merge to 'master'.
 source: <20240314085512.1827031-1-dev+git@drbeat.li>


* rj/restore-plug-leaks (2024-03-14) 1 commit
  (merged to 'next' on 2024-03-15 at ac10ae7892)
 + checkout: plug some leaks in git-restore

 Leaks from "git restore" have been plugged.

 Will merge to 'master'.
 source: <64c1c3cc-51d7-4168-9731-4389889e1449@gmail.com>


* bt/fuzz-config-parse (2024-03-15) 1 commit
 - fuzz: add fuzzer for config parsing

 A new fuzz target that exercises config parsing code.

 Will merge to 'next'?
 source: <pull.1692.v2.git.1710481652130.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Comments?
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* jc/index-pack-fsck-levels (2024-03-15) 1 commit
 - t5300: fix test_with_bad_commit()

 Test fix.

 Will merge to 'next'.
 source: <pull.1688.git.git.1710478646776.gitgitgadget@gmail.com>


* la/format-trailer-info (2024-03-15) 5 commits
 - trailer: finish formatting unification
 - trailer: begin formatting unification
 - format_trailer_info(): append newline for non-trailer lines
 - format_trailer_info(): drop redundant unfold_value()
 - format_trailer_info(): use trailer_item objects

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

--------------------------------------------------
[Cooking]

* jc/safe-implicit-bare (2024-03-11) 1 commit
  (merged to 'next' on 2024-03-14 at e8bdbed1a4)
 + setup: notice more types of implicit bare repositories

 Users with safe.bareRepository=explicit can still work from within
 $GIT_DIR of a seconary worktree (which resides at .git/worktrees/$name/)
 of the primary worktree without explicitly specifying the $GIT_DIR
 environment variable or the --git-dir=<path> option.

 Will merge to 'master'.
 source: <xmqq5xxv0ywi.fsf_-_@gitster.g>


* pw/checkout-conflict-errorfix (2024-03-14) 5 commits
 - checkout: fix interaction between --conflict and --merge
 - checkout: cleanup --conflict=<style> parsing
 - merge options: add a conflict style member
 - merge-ll: introduce LL_MERGE_OPTIONS_INIT
 - xdiff-interface: refactor parsing of merge.conflictstyle

 "git checkout --conflict=bad" reported a bad conflictStyle as if it
 were given to a configuration variable; it has been corrected to
 report that the command line option is bad.

 Will merge to 'next'?
 source: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>


* bl/cherry-pick-empty (2024-03-11) 7 commits
 - cherry-pick: add `--empty` for more robust redundant commit handling
 - cherry-pick: enforce `--keep-redundant-commits` incompatibility
 - sequencer: do not require `allow_empty` for redundant commit options
 - sequencer: treat error reading HEAD as unborn branch
 - rebase: update `--empty=ask` to `--empty=stop`
 - docs: clean up `--empty` formatting in git-rebase(1) and git-am (1)
 - docs: address inaccurate `--empty` default with `--exec`

 "cherry-pick" told to keep redundant commits needs to be allowed to
 create empty commits to do its job, but it required the user to
 give the --allow-empty option, which was unnecessary.  Its UI has
 also been tweaked a bit.

 Comments?
 source: <20240119060721.3734775-2-brianmlyles@gmail.com>


* ie/config-includeif-hostname (2024-03-10) 1 commit
 - config: learn the "hostname:" includeIf condition

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <fda3e8f4-fd9e-4a43-a307-c6607d982436@iencinas.com>
 source: <20240309181828.45496-2-ignacio@iencinas.com>


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

 Will merge to 'master'.
 source: <pull.1687.git.1710097830.gitgitgadget@gmail.com>


* jk/doc-remote-helper-object-format-option (2024-03-10) 2 commits
 - doc/gitremote-helpers: match object-format option docs to code
 - t5801: fix object-format handling in git-remote-testgit

 The implementation and documentation of "object-format" option
 exchange between the Git itself and its remote helpers did not
 quite match.

 What's the conclusion of this one???
 cf. <20240312074513.GA47852@coredump.intra.peff.net>
 cf. <87ttl99e0b.fsf@gmail.froward.int.ebiederm.org>
 source: <20240307084735.GA2072130@coredump.intra.peff.net>


* pb/ci-win-artifact-names-fix (2024-03-11) 1 commit
  (merged to 'next' on 2024-03-14 at 5076389536)
 + ci(github): make Windows test artifacts name unique

 CI update.

 Will merge to 'master'.
 source: <pull.1688.git.1710101097072.gitgitgadget@gmail.com>


* fs/find-end-of-log-message-fix (2024-03-07) 1 commit
  (merged to 'next' on 2024-03-13 at 2bed63caaf)
 + wt-status: don't find scissors line beyond buf len

 The code to find the effective end of log message can fall into an
 endless loop, which has been corrected.

 Will merge to 'master'.
 cf. <08b9b37d-f0f8-4c1a-b72e-194202ff3d9f@nutanix.com>
 source: <20240307183743.219951-1-flosch@nutanix.com>


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


* jk/doc-remote-helpers-markup-fix (2024-03-07) 1 commit
  (merged to 'next' on 2024-03-08 at 2cded1c696)
 + doc/gitremote-helpers: fix missing single-quote

 Doc mark-up fix.

 Will merge to 'master'.
 source: <20240307084313.GA2072022@coredump.intra.peff.net>


* js/build-fuzz-more-often (2024-03-05) 3 commits
 - SQUASH???
 - fuzz: link fuzz programs with `make all` on Linux
 - ci: also define CXX environment variable

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.

 Comments?
 source: <cover.1709673020.git.steadmon@google.com>


* ps/reftable-block-search-fix (2024-03-07) 2 commits
  (merged to 'next' on 2024-03-13 at 34938e24ab)
 + reftable/block: fix binary search over restart counter
 + reftable/record: fix memory leak when decoding object records

 The reftable code has its own custom binary search function whose
 comparison callback has an unusual interface, which caused the
 binary search to degenerate into a linear search, which has been
 corrected.

 Will merge to 'master'.
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

 Will merge to 'master'.
 source: <cover.1709640322.git.ps@pks.im>


* sj/userdiff-c-sharp (2024-03-06) 1 commit
 - userdiff: better method/property matching for C#

 The userdiff patterns for C# has been updated.

 Needs review.
 source: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>


* jh/trace2-missing-def-param-fix (2024-03-07) 3 commits
  (merged to 'next' on 2024-03-08 at a797cfea3c)
 + trace2: emit 'def_param' set with 'cmd_name' event
 + trace2: avoid emitting 'def_param' set more than once
 + t0211: demonstrate missing 'def_param' events for certain commands

 Some trace2 events that lacked def_param have learned to show it,
 enriching the output.

 Reviewed-by: Josh Steadmon <steadmon@google.com>
 cf. <ZejkVOVQBZhLVfHW@google.com>

 Will merge to 'master'.
 source: <pull.1679.v2.git.1709824949.gitgitgadget@gmail.com>


* ps/reftable-stack-tempfile (2024-03-07) 4 commits
  (merged to 'next' on 2024-03-13 at dcfb0cde8c)
 + reftable/stack: register compacted tables as tempfiles
 + reftable/stack: register lockfiles during compaction
 + reftable/stack: register new tables as tempfiles
 + lockfile: report when rollback fails

 The code in reftable backend that creates new table files works
 better with the tempfile framework to avoid leaving cruft after a
 failure.

 Will merge to 'master'.
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

 Will merge to 'master'.
 source: <20240303121944.20627-1-l.s.r@web.de>


* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* pw/rebase-i-ignore-cherry-pick-help-environment (2024-02-27) 1 commit
  (merged to 'next' on 2024-03-08 at e806ee9493)
 + rebase -i: stop setting GIT_CHERRY_PICK_HELP

 Code simplification by getting rid of code that sets an environment
 variable that is no longer used.

 Will merge to 'master'.
 source: <pull.1678.git.1709042783847.gitgitgadget@gmail.com>


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

 Will cook in 'next'.
 cf. <xmqqv86z5359.fsf@gitster.g>
 source: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
