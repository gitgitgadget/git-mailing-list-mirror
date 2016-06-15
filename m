From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.1.0-rc1
Date: Mon, 04 Aug 2014 15:31:20 -0700
Message-ID: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Aug 05 00:31:47 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1XEQnB-0001rz-SO
	for glk-linux-kernel-3@plane.gmane.org; Tue, 05 Aug 2014 00:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbaHDWbc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 4 Aug 2014 18:31:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50109 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbaHDWb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2014 18:31:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39E182F326;
	Mon,  4 Aug 2014 18:31:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	6whxsi3hKpk/sZzYWS0/nf8Ta4=; b=Qy0CRhmRw/AgJRwPP417MwLqMUGSBr1V4
	1Yy9lG/fWJzUqQOCKcescue4UZKvP5t6TxbxlofXAbPkf6OPE8FngIqKO7cab4sB
	qs55iYoK3jLsbkRof/wzloVOaM+YkcRlq+NC+1JGmnAcLvDftfDMunPQMsV0KexU
	CNJTZpLLws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=h/kvym/JnUZXhbzy6FSBK4a96i6OU14zfXHXvb5RxlFad9h4sGjYpsXy
	Uf0bBFI0Wac9+hi8lQQyZDkBEnFqrLzjhZdFTcOuqLkyrvt0ZD4TXgVEpOWa7uLo
	lDtchqXFaudpnEFRV3N+rWvEB0Sf3Bm9a2ShlwZEoCh04RxAo0U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E9062F324;
	Mon,  4 Aug 2014 18:31:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 536D92F31B;
	Mon,  4 Aug 2014 18:31:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0FDF0920-1C27-11E4-AF22-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254791>

v2.1.0-rc1, the first release candidate Git for v2.1, is now
available for testing at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.1.0-rc1'
tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v2.1 Release Notes (draft)
==============================

Backward compatibility notes
----------------------------

 * The default value we give to the environment variable LESS has been
   changed from "FRSX" to "FRX", losing "S" (chop long lines instead
   of wrapping).  Existing users who prefer not to see line-wrapped
   output may want to set

     $ git config core.pager "less -S"

   to restore the traditional behaviour.  It is expected that people
   find output from the most subcommands easier to read with the new
   default, except for "blame" which tends to produce really long
   lines.  To override the new default only for "git blame", you can
   do this:

     $ git config pager.blame "less -S"

 * A few disused directories in contrib/ have been retired.


Updates since v2.0
------------------

UI, Workflows & Features

 * Since the very beginning of Git, we gave the LESS environment a
   default value "FRSX" when we spawn "less" as the pager.  "S" (chop
   long lines instead of wrapping) has been removed from this default
   set of options, because it is more or less a personal taste thing,
   as opposed to others that have good justifications (i.e. "R" is
   very much justified because many kinds of output we produce are
   colored and "FX" is justified because output we produce is often
   shorter than a page).

 * The logic and data used to compute the display width needed for
   UTF-8 strings have been updated to match Unicode 7.0 better.

 * HTTP-based transports learned to propagate the error messages from
   the webserver better to the client coming over the HTTP transport.

 * The completion script for bash (in contrib/) has been updated to
   handle aliases that define complex sequence of commands better.

 * The "core.preloadindex" configuration variable is by default
   enabled, allowing modern platforms to take advantage of the
   multiple cores they have.

 * "git clone" applies the "if cloning from a local disk, physically
   copy repository using hardlinks, unless otherwise told not to with
   --no-local" optimization when url.*.insteadOf mechanism rewrites a
   "git clone $URL" that refers to a repository over the network to a
   clone from a local disk.

 * "git commit --date=<date>" option learned to read from more
   timestamp formats, including "--date=now".

 * The `core.commentChar` configuration variable is used to specify a
   custom comment character other than the default "#" to be used in
   the commit log editor.  This can be set to `auto` to attempt to
   choose a different character that does not conflict with what
   already starts a line in the message being edited for cases like
   "git commit --amend".

 * "git format-patch" learned --signature-file=<file> to take the mail
   signature from.

 * "git grep" learned grep.fullname configuration variable to force
   "--full-name" to be default.  This may cause regressions on
   scripted users that do not expect this new behaviour.

 * "git imap-send" learned to ask the credential helper for auth
   material.

 * "git log" and friends now understand the value "auto" set to the
   "log.decorate" configuration variable to enable the "--decorate"
   option automatically when the output is sent to tty.

 * "git merge" without argument, even when there is an upstream
   defined for the current branch, refused to run until
   merge.defaultToUpstream is set to true.  Flip the default of that
   configuration variable to true.

 * "git mergetool" learned to drive the vimdiff3 backend.

 * mergetool.prompt used to default to 'true', always asking "do you
   really want to run the tool on this path?".  Among the two
   purposes this prompt serves, ignore the use case to confirm that
   the user wants to view particular path with the named tool, and
   redefine the meaning of the prompt only to confirm the choice of
   the tool made by the autodetection (for those who configured the
   tool explicitly, the prompt shown for the latter purpose is
   simply annoying).

   Strictly speaking, this is a backward incompatible change and the
   users need to explicitly set the variable to 'true' if they want
   to resurrect the now-ignored use case.

 * "git replace" learned the "--edit" subcommand to create a
   replacement by editing an existing object.

 * "git replace" learned a "--graft" option to rewrite parents of a
   commit.

 * "git send-email" learned "--to-cover" and "--cc-cover" options, to
   tell it to copy To: and Cc: headers found in the first input file
   when emitting later input files.

 * "git svn" learned to cope with malformed timestamps with only one
   digit in the hour part, e.g. 2014-01-07T5:01:02.048176Z, emitted
   by some broken subversion server implementations.

 * "git tag" when editing the tag message shows the name of the tag
   being edited as a comment in the editor.

 * "git tag" learned to pay attention to "tag.sort" configuration, to
   be used as the default sort order when no --sort=<value> the option
   is given.

 * "git verify-commit" command to check GPG signature in signed
   commits, in a way similar to "git verify-tag" is used to check
   signed tags, was added.


Performance, Internal Implementation, etc.

 * Build procedure for 'subtree' (in contrib/) has been cleaned up.

 * The support for the profile-feedback build, which has been left
   bit-rotten for quite a while, has been updated.

 * An experimental format to use two files (the base file and
   incremental changes relative to it) to represent the index has been
   introduced; this may reduce I/O cost of rewriting a large index
   when only small part of the working tree changes.

 * Effort to shrink the size of patches Windows folks maintain on top
   by upstreaming them continues.  More tests that are not applicable
   to the Windows environment are identified and either skipped or
   made more portable.

 * Eradication of "test $condition -a $condition" from our scripts
   continues.

 * The leaf function to check validity of a refname format has been
   micro-optimized, using SSE2 instructions when available.  A few
   breakages during its development have been caught and fixed already
   but there might remain some more still; please test and report if
   you find any.

 * The `core.deltabasecachelimit` used to default to 16 MiB , but this
   proved to be too small, and has been bumped to 96 MiB.

 * "git blame" has been optimized greatly by reorganising the data
   structure that is used to keep track of the work to be done.

 * "git diff" that compares 3-or-more trees (e.g. parents and the
   result of a merge) have been optimized.

 * The API to update/delete references are being converted to handle
   updates to multiple references in a transactional way.  As an
   example, "update-ref --stdin [-z]" has been updated to use this
   API.

 * skip_prefix() and strip_suffix() API functions are used a lot more
   widely throughout the codebase now.

 * Parts of the test scripts can be skipped by using a range notation,
   e.g. "sh t1234-test.sh --run='1-4 6 8-'" to omit test piece 5 and 7
   and run everything else.


Also contains various documentation updates and code clean-ups.


Fixes since v2.0
----------------

Unless otherwise noted, all the fixes since v2.0 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * We used to unconditionally disable the pager in the pager process
   we spawn to feed out output, but that prevented people who want to
   run "less" within "less" from doing so.
   (merge c0459ca je/pager-do-not-recurse later to maint).

 * Tools that read diagnostic output in our standard error stream do
   not want to see terminal control sequence (e.g. erase-to-eol).
   Detect them by checking if the standard error stream is connected
   to a tty.
   (merge 38de156 mn/sideband-no-ansi later to maint).

 * Mishandling of patterns in .gitignore that has trailing SPs quoted
   with backslashes (e.g. ones that end with "\ ") have been
   corrected.
   (merge 97c1364be6b pb/trim-trailing-spaces later to maint).

 * Reworded the error message given upon a failure to open an existing
   loose object file due to e.g. permission issues; it was reported as
   the object being corrupt, but that is not quite true.
   (merge d6c8a05 jk/report-fail-to-read-objects-better later to maint).

 * "git log -2master" is a common typo that shows two commits starting
   from whichever random branch that is not 'master' that happens to
   be checked out currently.
   (merge e3fa568 jc/revision-dash-count-parsing later to maint).

 * Code to avoid adding the same alternate object store twice was
   subtly broken for a long time, but nobody seems to have noticed.
   (merge 80b4785 rs/fix-alt-odb-path-comparison later to maint).
   (merge 539e750 ek/alt-odb-entry-fix later to maint).

 * The "%<(10,trunc)%s" pretty format specifier in the log family of
   commands is used to truncate the string to a given length (e.g. 10
   in the example) with padding to column-align the output, but did
   not take into account that number of bytes and number of display
   columns are different.
   (merge 7d50987 as/pretty-truncate later to maint).

 * "%G" (nothing after G) is an invalid pretty format specifier, but
   the parser did not notice it as garbage.
   (merge 958b2eb jk/pretty-G-format-fixes later to maint).

 * A handful of code paths had to read the commit object more than
   once when showing header fields that are usually not parsed.  The
   internal data structure to keep track of the contents of the commit
   object has been updated to reduce the need for this double-reading,
   and to allow the caller find the length of the object.
   (merge 218aa3a jk/commit-buffer-length later to maint).

 * The "mailmap.file" configuration option did not support the tilde
   expansion (i.e. ~user/path and ~/path).
   (merge 9352fd5 ow/config-mailmap-pathname later to maint).

 * The completion scripts (in contrib/) did not know about quite a few
   options that are common between "git merge" and "git pull", and a
   couple of options unique to "git merge".
   (merge 8fee872 jk/complete-merge-pull later to maint).

 * The unix-domain socket used by the sample credential cache daemon
   tried to unlink an existing stale one at a wrong path, if the path
   to the socket was given as an overlong path that does not fit in
   sun_path member of the sockaddr_un structure.
   (merge 2869b3e rs/fix-unlink-unix-socket later to maint).

 * An ancient rewrite passed a wrong pointer to a curl library
   function in a rarely used code path.
   (merge 479eaa8 ah/fix-http-push later to maint).

 * "--ignore-space-change" option of "git apply" ignored the spaces
   at the beginning of line too aggressively, which is inconsistent
   with the option of the same name "diff" and "git diff" have.
   (merge 14d3bb4 jc/apply-ignore-whitespace later to maint).

 * "git blame" miscounted number of columns needed to show localized
   timestamps, resulting in jaggy left-side-edge of the source code
   lines in its output.
   (merge dd75553 jx/blame-align-relative-time later to maint).

 * "git blame" assigned the blame to the copy in the working-tree if
   the repository is set to core.autocrlf=input and the file used CRLF
   line endings.
   (merge 4d4813a bc/blame-crlf-test later to maint).

 * "git clone -b brefs/tags/bar" would have mistakenly thought we were
   following a single tag, even though it was a name of the branch,
   because it incorrectly used strstr().
   (merge 60a5f5f jc/fix-clone-single-starting-at-a-tag later to maint).

 * "git commit --allow-empty-messag -C $commit" did not work when the
   commit did not have any log message.
   (merge 076cbd6 jk/commit-C-pick-empty later to maint).

 * "git diff --find-copies-harder" sometimes pretended as if the mode
   bits have changed for paths that are marked with assume-unchanged
   bit.
   (merge 5304810 jk/diff-files-assume-unchanged later to maint).

 * "filter-branch" left an empty single-parent commit that results when
   all parents of a merge commit gets mapped to the same commit, even
   under "--prune-empty".
   (merge 79bc4ef cb/filter-branch-prune-empty-degenerate-merges later to maint).

 * "git format-patch" did not enforce the rule that the "--follow"
   option from the log/diff family of commands must be used with
   exactly one pathspec.
   (merge dd63f16 jk/diff-follow-must-take-one-pathspec later to maint).

 * "git gc --auto" was recently changed to run in the background to
   give control back early to the end-user sitting in front of the
   terminal, but it forgot that housekeeping involving reflogs should
   be done without other processes competing for accesses to the refs.
   (merge 62aad18 nd/daemonize-gc later to maint).

 * "git grep -O" to show the lines that hit in the pager did not work
   well with case insensitive search.  We now spawn "less" with its
   "-I" option when it is used as the pager (which is the default).
   (merge f7febbe sk/spawn-less-case-insensitively-from-grep-O-i later to maint).

 * We used to disable threaded "git index-pack" on platforms without
   thread-safe pread(); use a different workaround for such
   platforms to allow threaded "git index-pack".
   (merge 3953949 nd/index-pack-one-fd-per-thread later to maint).

 * The error reporting from "git index-pack" has been improved to
   distinguish missing objects from type errors.
   (merge 77583e7 jk/index-pack-report-missing later to maint).

 * "log --show-signature" incorrectly decided the color to paint a
   mergetag that was and was not correctly validated.
   (merge 42c55ce mg/fix-log-mergetag-color later to maint).

 * "log --show-signature" did not pay attention to "--graph" option.
   (merge cf3983d zk/log-graph-showsig later to maint).

 * "git mailinfo" used to read beyond the end of header string while
   parsing an incoming e-mail message to extract the patch.
   (merge b1a013d rs/mailinfo-header-cmp later to maint).

 * On a case insensitive filesystem, merge-recursive incorrectly
   deleted the file that is to be renamed to a name that is the same
   except for case differences.
   (merge baa37bf dt/merge-recursive-case-insensitive later to maint).

 * Merging changes into a file that ends in an incomplete line made the
   last line into a complete one, even when the other branch did not
   change anything around the end of file.
   (merge ba31180 mk/merge-incomplete-files later to maint).

 * "git pack-objects" unnecessarily copied the previous contents when
   extending the hashtable, even though it will populate the table
   from scratch anyway.
   (merge fb79947 rs/pack-objects-no-unnecessary-realloc later to maint).

 * Recent updates to "git repack" started to duplicate objects that
   are in packfiles marked with .keep flag into the new packfile by
   mistake.
   (merge d078d85 jk/repack-pack-keep-objects later to maint).

 * "git rerere forget" did not work well when merge.conflictstyle
   was set to a non-default value.
   (merge de3d8bb fc/rerere-conflict-style later to maint).

 * "git remote rm" and "git remote prune" can involve removing many
   refs at once, which is not a very efficient thing to do when very
   many refs exist in the packed-refs file.
   (merge e6bea66 jl/remote-rm-prune later to maint).

 * "git log --exclude=<glob> --all | git shortlog" worked as expected,
   but "git shortlog --exclude=<glob> --all", which is supposed to be
   identical to the above pipeline, was not accepted at the command
   line argument parser level.
   (merge eb07774 jc/shortlog-ref-exclude later to maint).

 * The autostash mode of "git rebase -i" did not restore the dirty
   working tree state if the user aborted the interactive rebase by
   emptying the insn sheet.
   (merge ddb5432 rr/rebase-autostash-fix later to maint).

 * "git rebase --fork-point" did not filter out patch-identical
   commits correctly.

 * During "git rebase --merge", a conflicted patch could not be
   skipped with "--skip" if the next one also conflicted.
   (merge 95104c7 bc/fix-rebase-merge-skip later to maint).

 * "git show -s" (i.e. show log message only) used to incorrectly emit
   an extra blank line after a merge commit.
   (merge ad2f725 mk/show-s-no-extra-blank-line-for-merges later to maint).

 * "git status", even though it is a read-only operation, tries to
   update the index with refreshed lstat(2) info to optimize future
   accesses to the working tree opportunistically, but this could
   race with a "read-write" operation that modify the index while it
   is running.  Detect such a race and avoid overwriting the index.
   (merge 426ddee ym/fix-opportunistic-index-update-race later to maint).

 * "git status" (and "git commit") behaved as if changes in a modified
   submodule are not there if submodule.*.ignore configuration is set,
   which was misleading.  The configuration is only to unclutter diff
   output during the course of development, and should not to hide
   changes in the "status" output to cause the users forget to commit
   them.
   (merge c215d3d jl/status-added-submodule-is-never-ignored later to maint).

 * Documentation for "git submodule sync" forgot to say that the subcommand
   can take the "--recursive" option.
   (merge 9393ae7 mc/doc-submodule-sync-recurse later to maint).

 * "git update-index --cacheinfo" in 2.0 release crashed on a
   malformed command line.
   (merge c8e1ee4 jc/rev-parse-argh-dashed-multi-words later to maint).

 * The mode to run tests with HTTP server tests disabled was broken.
   (merge afa53fe na/no-http-test-in-the-middle later to maint).

----------------------------------------------------------------

Changes since v2.1.0-rc0 are as follows:

Fabian Ruch (1):
      commit --amend: test specifies authorship but forgets to check

Jeff King (14):
      receive-pack: don't copy "dir" parameter
      free ref string returned by dwim_ref
      transport: fix leaks in refs_from_alternate_cb
      fix memory leak parsing core.commentchar
      apply: avoid possible bogus pointer
      alloc: write out allocator definitions
      move setting of object->type to alloc_* functions
      parse_object_buffer: do not set object type
      add object_as_type helper for casting objects
      alloc: factor out commit index
      object_as_type: set commit index
      diff-tree: avoid lookup_unknown_object
      t1402: check for refs ending with a dot
      t4013: test diff-tree's --stdin commit formatting

Johannes Schindelin (1):
      MinGW: Skip test redirecting to fd 4

John Keeping (3):
      completion: complete "unstuck" `git push --recurse-submodules`
      completion: add some missing options to `git push`
      completion: complete `git push --force-with-lease=`

Junio C Hamano (6):
      t9814: fix misconversion from test $a -o $b to test $a || test $b
      Revert "Merge branch 'dt/refs-check-refname-component-sse-fix'"
      Revert "Merge branch 'dt/refs-check-refname-component-sse'"
      Git 2.0.4
      Update draft release notes to 2.1
      Git 2.1.0-rc1

Karsten Blees (16):
      Revert "Windows: teach getenv to do a case-sensitive search"
      Win32: Unicode environment (outgoing)
      Win32: Unicode environment (incoming)
      Win32: fix environment memory leaks
      Win32: unify environment case-sensitivity
      Win32: unify environment function names
      Win32: factor out environment block creation
      Win32: don't copy the environment twice when spawning child processes
      Win32: reduce environment array reallocations
      Win32: use low-level memory allocation during initialization
      Win32: keep the environment sorted
      Win32: patch Windows environment on startup
      Win32: enable color output in Windows cmd.exe
      t0110/MinGW: skip tests that pass arbitrary bytes on the command line
      MinGW: disable legacy encoding tests
      t800[12]: work around MSys limitation

Pat Thoyts (3):
      tests: do not pass iso8859-1 encoded parameter
      t4210: skip command-line encoding tests on mingw
      t9902: mingw-specific fix for gitfile link files

Ramsay Allan Jones (1):
      alloc.c: remove the alloc_raw_commit_node() function

Tanay Abhra (1):
      add documentation for writing config files

Tony Finch (1):
      git-push: fix link in man page
