Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F28F1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 19:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcHLTz4 convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 15:55:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751577AbcHLTzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 15:55:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C78863489A;
	Fri, 12 Aug 2016 15:55:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=SlfuvaMTXDdLaz4r+We0J0mnK
	js=; b=hycqF1PS+oRjSA5QkPF9celGer6FwjsZKqcuAIwg/CtQh/E+eJO/W6S9d
	XvfVMKbQQS6bl77Nm1Cgi0MMuSyZcefVZMZj/pKI3eddK5Y17SMs5G/At/Qww72u
	Pg9bs72vIUtLVdLZIhzsJPUw9nwdfmEepQNYzPf7IG3o+MX9jA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=XeogXlbCkDy325ZYsPd
	7KHezsYnFj8xSyj4cCMEUX71eKydb+vO7c31LviJEwCp/+rV9jbZoCbyRjYQO19v
	ybYiAtLsv+OwaLuwaeuoYTwlAsNDc7tpmMZARcOWO6johZ4zFUb4oktmGkVy1ewh
	j5KH02RWqHorJm6NWD+FaWJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C061234895;
	Fri, 12 Aug 2016 15:55:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 110D434894;
	Fri, 12 Aug 2016 15:55:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.9.3
Date:	Fri, 12 Aug 2016 12:55:20 -0700
Message-ID: <xmqq37m9wymv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B494D202-60C6-11E6-9215-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


The latest maintenance release Git v2.9.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.9.3'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.9.3 Release Notes
========================

Fixes since v2.9.2
------------------

 * A helper function that takes the contents of a commit object and
   finds its subject line did not ignore leading blank lines, as is
   commonly done by other codepaths.  Make it ignore leading blank
   lines to match.

 * Git does not know what the contents in the index should be for a
   path added with "git add -N" yet, so "git grep --cached" should not
   show hits (or show lack of hits, with -L) in such a path, but that
   logic does not apply to "git grep", i.e. searching in the working
   tree files.  But we did so by mistake, which has been corrected.

 * "git rebase -i --autostash" did not restore the auto-stashed change
   when the operation was aborted.

 * "git commit --amend --allow-empty-message -S" for a commit without
   any message body could have misidentified where the header of the
   commit object ends.

 * More mark-up updates to typeset strings that are expected to
   literally typed by the end user in fixed-width font.

 * For a long time, we carried an in-code comment that said our
   colored output would work only when we use fprintf/fputs on
   Windows, which no longer is the case for the past few years.

 * "gc.autoPackLimit" when set to 1 should not trigger a repacking
   when there is only one pack, but the code counted poorly and did
   so.

 * One part of "git am" had an oddball helper function that called
   stuff from outside "his" as opposed to calling what we have "ours",
   which was not gender-neutral and also inconsistent with the rest of
   the system where outside stuff is usuall called "theirs" in
   contrast to "ours".

 * The test framework learned a new helper test_match_signal to
   check an exit code from getting killed by an expected signal.

 * "git blame -M" missed a single line that was moved within the file.

 * Fix recently introduced codepaths that are involved in parallel
   submodule operations, which gave up on reading too early, and
   could have wasted CPU while attempting to write under a corner
   case condition.

 * "git grep -i" has been taught to fold case in non-ascii locales
   correctly.

 * A test that unconditionally used "mktemp" learned that the command
   is not necessarily available everywhere.

 * "git blame file" allowed the lineage of lines in the uncommitted,
   unadded contents of "file" to be inspected, but it refused when
   "file" did not appear in the current commit.  When "file" was
   created by renaming an existing file (but the change has not been
   committed), this restriction was unnecessarily tight.

 * "git add -N dir/file && git write-tree" produced an incorrect tree
   when there are other paths in the same directory that sorts after
   "file".

 * "git fetch http://user:pass@host/repo..." scrubbed the userinfo
   part, but "git push" didn't.

 * An age old bug that caused "git diff --ignore-space-at-eol"
   misbehave has been fixed.

 * "git notes merge" had a code to see if a path exists (and fails if
   it does) and then open the path for writing (when it doesn't).
   Replace it with open with O_EXCL.

 * "git pack-objects" and "git index-pack" mostly operate with off_t
   when talking about the offset of objects in a packfile, but there
   were a handful of places that used "unsigned long" to hold that
   value, leading to an unintended truncation.

 * Recent update to "git daemon" tries to enable the socket-level
   KEEPALIVE, but when it is spawned via inetd, the standard input
   file descriptor may not necessarily be connected to a socket.
   Suppress an ENOTSOCK error from setsockopt().

 * Recent FreeBSD stopped making perl available at /usr/bin/perl;
   switch the default the built-in path to /usr/local/bin/perl on not
   too ancient FreeBSD releases.

 * "git status" learned to suggest "merge --abort" during a conflicted
   merge, just like it already suggests "rebase --abort" during a
   conflicted rebase.

 * The .c/.h sources are marked as such in our .gitattributes file so
   that "git diff -W" and friends would work better.

 * Existing autoconf generated test for the need to link with pthread
   library did not check all the functions from pthread libraries;
   recent FreeBSD has some functions in libc but not others, and we
   mistakenly thought linking with libc is enough when it is not.

 * Allow http daemon tests in Travis CI tests.

 * Users of the parse_options_concat() API function need to allocate
   extra slots in advance and fill them with OPT_END() when they want
   to decide the set of supported options dynamically, which makes the
   code error-prone and hard to read.  This has been corrected by tweaking
   the API to allocate and return a new copy of "struct option" array.

 * The use of strbuf in "git rm" to build filename to remove was a bit
   suboptimal, which has been fixed.

 * "git commit --help" said "--no-verify" is only about skipping the
   pre-commit hook, and failed to say that it also skipped the
   commit-msg hook.

 * "git merge" in Git v2.9 was taught to forbid merging an unrelated
   lines of history by default, but that is exactly the kind of thing
   the "--rejoin" mode of "git subtree" (in contrib/) wants to do.
   "git subtree" has been taught to use the "--allow-unrelated-histories"
   option to override the default.

 * The build procedure for "git persistent-https" helper (in contrib/)
   has been updated so that it can be built with more recent versions
   of Go.

 * There is an optimization used in "git diff $treeA $treeB" to borrow
   an already checked-out copy in the working tree when it is known to
   be the same as the blob being compared, expecting that open/mmap of
   such a file is faster than reading it from the object store, which
   involves inflating and applying delta.  This however kicked in even
   when the checked-out copy needs to go through the convert-to-git
   conversion (including the clean filter), which defeats the whole
   point of the optimization.  The optimization has been disabled when
   the conversion is necessary.

 * "git -c grep.patternType=extended log --basic-regexp" misbehaved
   because the internal API to access the grep machinery was not
   designed well.

 * Windows port was failing some tests in t4130, due to the lack of
   inum in the returned values by its lstat(2) emulation.

 * The characters in the label shown for tags/refs for commits in
   "gitweb" output are now properly escaped for proper HTML output.

 * FreeBSD can lie when asked mtime of a directory, which made the
   untracked cache code to fall back to a slow-path, which in turn
   caused tests in t7063 to fail because it wanted to verify the
   behaviour of the fast-path.

 * Squelch compiler warnings for netmalloc (in compat/) library.

 * The API documentation for hashmap was unclear if hashmap_entry
   can be safely discarded without any other consideration.  State
   that it is safe to do so.

 * Not-so-recent rewrite of "git am" that started making internal
   calls into the commit machinery had an unintended regression, in
   that no matter how many seconds it took to apply many patches, the
   resulting committer timestamp for the resulting commits were all
   the same.

 * "git difftool <paths>..." started in a subdirectory failed to
   interpret the paths relative to that directory, which has been
   fixed.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.9.2 are as follows:

Alex Henrie (1):
      unpack-trees: fix English grammar in do-this-before-that messages

Andreas Brauchli (1):
      gitweb: escape link body in format_ref_marker

Armin Kunaschik (1):
      t7610: test for mktemp before test execution

Charles Bailey (3):
      t7810-grep.sh: fix duplicated test name
      t7810-grep.sh: fix a whitespace inconsistency
      grep: fix grepping for "intent to add" files

Chris Packham (1):
      completion: add option '--recurse-submodules' to 'git clone'

David A. Greene (1):
      contrib/subtree: Add a test for subtree rebase that loses commits

David Aguilar (4):
      t7900-subtree.sh: fix quoting and broken && chains
      subtree: fix "git subtree split --rejoin"
      difftool: avoid $GIT_DIR and $GIT_WORK_TREE
      difftool: use Git::* functions instead of passing around state

David Kastrup (1):
      blame: require 0 context lines while finding moved lines with -M

Eric Wong (6):
      gc: fix off-by-one error with gc.autoPackLimit
      xread: retry after poll on EAGAIN/EWOULDBLOCK
      xwrite: poll on non-blocking FDs
      hoist out handle_nonblock function for xread and xwrite
      daemon: ignore ENOTSOCK from setsockopt
      configure.ac: stronger test for pthread linkage

Heiko Voigt (3):
      submodule-config: passing name reference for .gitmodule blobs
      submodule-config: combine early return code into one goto
      submodule-config: fix test binary crashing when no arguments given

Jeff King (14):
      send-pack: use buffered I/O to talk to pack-objects
      tests: factor portable signal check out of t0005
      t0005: use test_match_signal as appropriate
      test_must_fail: use test_match_signal
      t/lib-git-daemon: use test_match_signal
      parse_options: allocate a new array when concatenating
      Makefile: drop extra dependencies for test helpers
      Makefile: use VCSSVN_LIB to refer to svn library
      push: anonymize URL in status output
      t5541: fix url scrubbing test when GPG is not set
      diff: do not reuse worktree files that need "clean" conversion
      t4205: drop top-level &&-chaining
      t4205: indent here documents
      am: reset cached ident date for each patch

Joey Hess (1):
      clarify %f documentation

Johannes Schindelin (13):
      pretty: make the skip_blank_lines() function public
      commit.c: make find_commit_subject() more robust
      color.h: remove obsolete comment about limitations on Windows
      t3404: fix a grammo (commands are ran -> commands are run)
      commit -C: skip blank lines at the beginning of the message
      sequencer: use skip_blank_lines() to find the commit subject
      reset --hard: skip blank lines when reporting the commit subject
      commit -S: avoid invalid pointer with empty message
      am: counteract gender bias
      diff: demonstrate a bug with --patience and --ignore-space-at-eol
      diff: fix a double off-by-one with --ignore-space-at-eol
      t/test-lib.sh: fix running tests with --valgrind
      nedmalloc: fix misleading indentation

Johannes Sixt (2):
      Windows: add missing definition of ENOTSOCK
      t4130: work around Windows limitation

John Keeping (1):
      difftool: fix argument handling in subdirs

Junio C Hamano (7):
      diff: document diff-filter exclusion
      grep: further simplify setting the pattern type
      Some fixes for 2.9.3
      hashmap: clarify that hashmap_entry can safely be discarded
      Hopefully final batch for 2.9.3
      Yet another batch for 2.9.3
      Git 2.9.3

Lars Schneider (1):
      travis-ci: enable web server tests t55xx on Linux

Lukas Fleischer (3):
      sideband.c: make send_sideband() return void
      upload-pack.c: make send_client_data() return void
      sideband.c: refactor recv_sideband()

Matthieu Moy (8):
      Documentation/git-mv.txt: fix whitespace indentation
      doc: typeset short command-line options as literal
      doc: typeset long command-line options as literal
      doc: typeset '--' as literal
      doc: typeset long options with argument as literal
      CodingGuidelines: formatting HEAD in documentation
      doc: typeset HEAD and variants as literal
      status: suggest 'git merge --abort' when appropriate

Mike Hommey (2):
      blame: allow to blame paths freshly added to the index
      t/t8003-blame-corner-cases.sh: Use here documents

Nguyễn Thái Ngọc Duy (26):
      new-command.txt: correct the command description file
      grep: break down an "if" stmt in preparation for next changes
      test-regex: isolate the bug test code
      test-regex: expose full regcomp() to the command line
      grep/icase: avoid kwsset on literal non-ascii strings
      grep/icase: avoid kwsset when -F is specified
      grep: rewrite an if/else condition to avoid duplicate expression
      grep/pcre: prepare locale-dependent tables for icase matching
      gettext: add is_utf8_locale()
      grep/pcre: support utf-8
      diffcore-pickaxe: Add regcomp_or_die()
      diffcore-pickaxe: support case insensitive match on non-ascii
      grep.c: reuse "icase" variable
      pack-objects: pass length to check_pack_crc() without truncation
      sha1_file.c: use type off_t* for object_info->disk_sizep
      index-pack: correct "len" type in unpack_data()
      index-pack: report correct bad object offsets even if they are large
      index-pack: correct "offset" type in unpack_entry_data()
      pack-objects: do not truncate result in-pack object size on 32-bit systems
      fsck: use streaming interface for large blobs in pack
      test-lib.sh: introduce and use $EMPTY_TREE
      test-lib.sh: introduce and use $EMPTY_BLOB
      cache-tree.c: fix i-t-a entry skipping directory updates sometimes
      cache-tree: do not generate empty trees as a result of all i-t-a subentries
      config.mak.uname: correct perl path on FreeBSD
      t7063: work around FreeBSD's lazy mtime update feature

Nicolas Pitre (1):
      sideband.c: small optimization of strbuf usage

Orgad Shaneh (1):
      commit: describe that --no-verify skips the commit-msg hook in the help text

Parker Moore (2):
      contrib/persistent-https: update ldflags syntax for Go 1.7+
      contrib/persistent-https: use Git version for build label

Patrick Steinhardt (1):
      rebase -i: restore autostash on abort

Pranit Bauva (1):
      builtin/commit.c: memoize git-path for COMMIT_EDITMSG

Ramsay Jones (1):
      write_or_die: remove the unused write_or_whine() function

René Scharfe (10):
      .gitattributes: set file type for C files
      notes-merge: use O_EXCL to avoid overwriting existing files
      rm: reuse strbuf for all remove_dir_recursively() calls
      worktree: use strbuf_add_absolute_path() directly
      use strbuf_addbuf() for appending a strbuf to another
      submodule-config: use explicit empty string instead of strbuf in config_from()
      strbuf: avoid calling strbuf_grow() twice in strbuf_addbuf()
      use strbuf_addstr() for adding constant strings to a strbuf
      use strbuf_addstr() instead of strbuf_addf() with "%s"
      nedmalloc: work around overzealous GCC 6 warning

Stefan Beller (2):
      Documentation: pack-protocol correct NAK response
      submodule deinit: remove outdated comment

