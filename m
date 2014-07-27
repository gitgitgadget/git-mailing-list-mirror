From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.1.0-rc0
Date: Sun, 27 Jul 2014 16:18:27 -0700
Message-ID: <xmqq38dm5r24.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 01:19:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBXiW-0000Ht-8s
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 01:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbaG0XSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jul 2014 19:18:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64516 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbaG0XSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2014 19:18:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8CEBE2B0A7;
	Sun, 27 Jul 2014 19:18:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=3VDs1pVaXKtEWkvkNulqgcNh7
	9o=; b=kI+j9/x9HGZRzk0rThSZKKN0pLeIbaMEzZ3O5MgJZ2UdxcSnI9qmemj5n
	NDAuiYbDK57D0h4hJpu7oOcxhtR7DtknuMjat+vY2kexgOJmiqRygmFAPzpbMiQT
	gUN7bV4p8vhiSOVJmyoO4TOAVdPwuCdG5l4Ak7M54KR6IEbT00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EBXQqFfZ544vAoYYJEM
	47pgPMCtJS39DimWxayblPBYSnKznoR34vpXJJWdCF14dsLYoIi7G5EPXii2KIIT
	IXpeRXHUdpZqZQDClQlYvNEWMENQlpOXoIOG/r6p92+XO8Oi9ZMUGuqJ8Y/0u3ao
	ivAOZjGqu/MucM3BtLrCEV7U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 823FF2B0A6;
	Sun, 27 Jul 2014 19:18:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E00CC2B09D;
	Sun, 27 Jul 2014 19:18:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 515624D6-15E4-11E4-B371-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254284>

An early preview release Git v2.1.0-rc0 is now available for testing
at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.1.0-rc0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.1 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

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

 * "git commit --date=3D<date>" option learned to read from more
   timestamp formats, including "--date=3Dnow".

 * The `core.commentChar` configuration variable is used to specify a
   custom comment character other than the default "#" to be used in
   the commit log editor.  This can be set to `auto` to attempt to
   choose a different character that does not conflict with what
   already starts a line in the message being edited for cases like
   "git commit --amend".

 * "git format-patch" learned --signature-file=3D<file> to take the mai=
l
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
   be used as the default sort order when no --sort=3D<value> the optio=
n
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
   by upstreaming them continues.

 * Patches maintained by msysgit folks for Windows port are being
   upstreamed here a bit by bit.

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
   e.g. "sh t1234-test.sh --run=3D'1-4 6 8-'" to omit test piece 5 and =
7
   and run everything else.


Also contains various documentation updates and code clean-ups.


=46ixes since v2.0
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
   (merge d6c8a05 jk/report-fail-to-read-objects-better later to maint)=
=2E

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
   the repository is set to core.autocrlf=3Dinput and the file used CRL=
=46
   line endings.
   (merge 4d4813a bc/blame-crlf-test later to maint).

 * "git clone -b brefs/tags/bar" would have mistakenly thought we were
   following a single tag, even though it was a name of the branch,
   because it incorrectly used strstr().
   (merge 60a5f5f jc/fix-clone-single-starting-at-a-tag later to maint)=
=2E

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
   (merge 79bc4ef cb/filter-branch-prune-empty-degenerate-merges later =
to maint).

 * "git format-patch" did not enforce the rule that the "--follow"
   option from the log/diff family of commands must be used with
   exactly one pathspec.
   (merge dd63f16 jk/diff-follow-must-take-one-pathspec later to maint)=
=2E

 * "git gc --auto" was recently changed to run in the background to
   give control back early to the end-user sitting in front of the
   terminal, but it forgot that housekeeping involving reflogs should
   be done without other processes competing for accesses to the refs.
   (merge 62aad18 nd/daemonize-gc later to maint).

 * "git grep -O" to show the lines that hit in the pager did not work
   well with case insensitive search.  We now spawn "less" with its
   "-I" option when it is used as the pager (which is the default).
   (merge f7febbe sk/spawn-less-case-insensitively-from-grep-O-i later =
to maint).

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
   (merge fb79947 rs/pack-objects-no-unnecessary-realloc later to maint=
).

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

 * "git log --exclude=3D<glob> --all | git shortlog" worked as expected=
,
   but "git shortlog --exclude=3D<glob> --all", which is supposed to be
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
   (merge ad2f725 mk/show-s-no-extra-blank-line-for-merges later to mai=
nt).

 * "git status", even though it is a read-only operation, tries to
   update the index with refreshed lstat(2) info to optimize future
   accesses to the working tree opportunistically, but this could
   race with a "read-write" operation that modify the index while it
   is running.  Detect such a race and avoid overwriting the index.
   (merge 426ddee ym/fix-opportunistic-index-update-race later to maint=
).

 * "git status" (and "git commit") behaved as if changes in a modified
   submodule are not there if submodule.*.ignore configuration is set,
   which was misleading.  The configuration is only to unclutter diff
   output during the course of development, and should not to hide
   changes in the "status" output to cause the users forget to commit
   them.
   (merge c215d3d jl/status-added-submodule-is-never-ignored later to m=
aint).

 * Documentation for "git submodule sync" forgot to say that the subcom=
mand
   can take the "--recursive" option.
   (merge 9393ae7 mc/doc-submodule-sync-recurse later to maint).

 * "git update-index --cacheinfo" in 2.0 release crashed on a
   malformed command line.
   (merge c8e1ee4 jc/rev-parse-argh-dashed-multi-words later to maint).

 * The mode to run tests with HTTP server tests disabled was broken.
   (merge afa53fe na/no-http-test-in-the-middle later to maint).

----------------------------------------------------------------

Changes since v2.0.0, 643 non-merge changes from 80 contributors,
are as follows:

Abbaad Haider (1):
      http-push.c: make CURLOPT_IOCTLDATA a usable pointer

Alexey Shumkin (5):
      t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outp=
uts
      t4041, t4205, t6006, t7102: don't hardcode tested encoding value
      t4205 (log-pretty-format): use `tformat` rather than `format`
      t4205, t6006: add tests that fail with i18n.logOutputEncoding set
      pretty.c: format string with truncate respects logOutputEncoding

Anders Kaseorg (1):
      gitk: Allow displaying time zones from author and commit dates ti=
mestamps

Andi Kleen (4):
      Use BASIC_FLAGS for profile feedback
      Don't define away __attribute__ on gcc
      Run the perf test suite for profile feedback too
      Fix profile feedback with -jN and add profile-fast

Andreas Schwab (1):
      grep: add grep.fullName config variable

Ben Walton (1):
      compat/bswap.h: fix endianness detection

Brian Gesiak (14):
      strbuf: use _rtrim and _ltrim in strbuf_trim
      api-strbuf.txt: add docs for _trim and _ltrim
      builtin/ls-remote.c: rearrange xcalloc arguments
      builtin/remote.c: rearrange xcalloc arguments
      commit.c: rearrange xcalloc arguments
      config.c: rearrange xcalloc arguments
      diff.c: rearrange xcalloc arguments
      http-push.c: rearrange xcalloc arguments
      imap-send.c: rearrange xcalloc arguments
      notes.c: rearrange xcalloc arguments
      pack-revindex.c: rearrange xcalloc arguments
      reflog-walk.c: rearrange xcalloc arguments
      remote.c: rearrange xcalloc arguments
      transport-helper.c: rearrange xcalloc arguments

Cezary Zawadka (1):
      Windows: allow using UNC path for git repository

Charles Bailey (3):
      compat/bswap.h: detect endianness on more platforms that don't us=
e BYTE_ORDER
      filter-branch: eliminate duplicate mapped parents
      Fix contrib/subtree Makefile to patch #! line

Christian Couder (16):
      replace: make sure --edit results in a different object
      replace: refactor checking ref validity
      replace: die early if replace ref already exists
      replace: add tests for --edit
      replace: add --edit to usage string
      Documentation: replace: describe new --edit option
      commit: add for_each_mergetag()
      replace: cleanup redirection style in tests
      replace: add --graft option
      replace: add test for --graft
      Documentation: replace: add --graft option
      contrib: add convert-grafts-to-replace-refs.sh
      replace: remove signature when using --graft
      replace: add test for --graft with signed commit
      replace: check mergetags when using --graft
      replace: add test for --graft with a mergetag

Dan Albert (1):
      imap-send: use git-credential

David Aguilar (3):
      gitk: Honor TMPDIR when viewing external diffs
      gitk: Use mktemp -d to avoid predictable temporary directories
      gitk: Catch mkdtemp errors

David Kastrup (2):
      blame: large-scale performance rewrite
      Bump core.deltaBaseCacheLimit to 96m

David Turner (7):
      docs: document RUN_SETUP_GENTLY and clarify RUN_SETUP
      merge-recursive.c: fix case-changing merge bug
      mv: allow renaming to fix case on case insensitive filesystems
      refs.c: optimize check_refname_component()
      refs.c: SSE2 optimizations for check_refname_component
      refs.c: handle REFNAME_REFSPEC_PATTERN at end of page
      refs: fix valgrind suppression file

Elia Pinto (62):
      t9365-continuing-queries.sh: use the $( ... ) construct for comma=
nd substitution
      test-gitmw-lib.sh: use the $( ... ) construct for command substit=
ution
      t7900-subtree.sh: use the $( ... ) construct for command substitu=
tion
      appp.sh: use the $( ... ) construct for command substitution
      git-pull.sh: use the $( ... ) construct for command substitution
      git-rebase--merge.sh: use the $( ... ) construct for command subs=
titution
      git-rebase.sh: use the $( ... ) construct for command substitutio=
n
      git-stash.sh: use the $( ... ) construct for command substitution
      git-web--browse.sh: use the $( ... ) construct for command substi=
tution
      lib-credential.sh: use the $( ... ) construct for command substit=
ution
      lib-cvs.sh: use the $( ... ) construct for command substitution
      lib-gpg.sh: use the $( ... ) construct for command substitution
      p5302-pack-index.sh: use the $( ... ) construct for command subst=
itution
      t0001-init.sh: use the $( ... ) construct for command substitutio=
n
      t0010-racy-git.sh: use the $( ... ) construct for command substit=
ution
      t0020-crlf.sh: use the $( ... ) construct for command substitutio=
n
      t0025-crlf-auto.sh: use the $( ... ) construct for command substi=
tution
      t0026-eol-config.sh: use the $( ... ) construct for command subst=
itution
      t0030-stripspace.sh: use the $( ... ) construct for command subst=
itution
      t0300-credentials.sh: use the $( ... ) construct for command subs=
titution
      t1000-read-tree-m-3way.sh: use the $( ... ) construct for command=
 substitution
      t1001-read-tree-m-2way.sh: use the $( ... ) construct for command=
 substitution
      t1002-read-tree-m-u-2way.sh: use the $( ... ) construct for comma=
nd substitution
      t1003-read-tree-prefix.sh: use the $( ... ) construct for command=
 substitution
      t1004-read-tree-m-u-wf.sh: use the $( ... ) construct for command=
 substitution
      t1020-subdirectory.sh: use the $( ... ) construct for command sub=
stitution
      t1050-large.sh: use the $( ... ) construct for command substituti=
on
      t3905-stash-include-untracked.sh: use the $( ... ) construct for =
command substitution
      t3910-mac-os-precompose.sh: use the $( ... ) construct for comman=
d substitution
      t4006-diff-mode.sh: use the $( ... ) construct for command substi=
tution
      t4010-diff-pathspec.sh: use the $( ... ) construct for command su=
bstitution
      t4012-diff-binary.sh: use the $( ... ) construct for command subs=
titution
      t4013-diff-various.sh: use the $( ... ) construct for command sub=
stitution
      t4014-format-patch.sh: use the $( ... ) construct for command sub=
stitution
      t4036-format-patch-signer-mime.sh: use the $( ... ) construct for=
 command substitution
      t4038-diff-combined.sh: use the $( ... ) construct for command su=
bstitution
      t4057-diff-combined-paths.sh: use the $( ... ) construct for comm=
and substitution
      t4116-apply-reverse.sh: use the $( ... ) construct for command su=
bstitution
      t4119-apply-config.sh: use the $( ... ) construct for command sub=
stitution
      t4204-patch-id.sh: use the $( ... ) construct for command substit=
ution
      t5000-tar-tree.sh: use the $( ... ) construct for command substit=
ution
      scripts: "export VAR=3DVALUE" construct is not portable
      check_bindir: avoid "test <cond> -a/-o <cond>"
      contrib/examples/git-clone.sh: avoid "test <cond> -a/-o <cond>"
      contrib/examples/git-commit.sh: avoid "test <cond> -a/-o <cond>"
      contrib/examples/git-merge.sh: avoid "test <cond> -a/-o <cond>"
      contrib/examples/git-repack.sh: avoid "test <cond> -a/-o <cond>"
      contrib/examples/git-resolve.sh: avoid "test <cond> -a/-o <cond>"
      git-bisect.sh: avoid "test <cond> -a/-o <cond>"
      git-mergetool.sh: avoid "test <cond> -a/-o <cond>"
      git-rebase--interactive.sh: avoid "test <cond> -a/-o <cond>"
      t/lib-httpd.sh: avoid "test <cond> -a/-o <cond>"
      t/t0025-crlf-auto.sh: avoid "test <cond> -a/-o <cond>"
      t/t0026-eol-config.sh: avoid "test <cond> -a/-o <cond>"
      t/t4102-apply-rename.sh: avoid "test <cond> -a/-o <cond>"
      t/t5000-tar-tree.sh: avoid "test <cond> -a/-o <cond>"
      t/t5403-post-checkout-hook.sh: avoid "test <cond> -a/-o <cond>"
      t/t5538-push-shallow.sh: avoid "test <cond> -a/-o <cond>"
      t/t9814-git-p4-rename.sh: avoid "test <cond> -a/-o <cond>"
      t/test-lib-functions.sh: avoid "test <cond> -a/-o <cond>"
      git-submodule.sh: avoid "test <cond> -a/-o <cond>"
      submodule.c: use the ARRAY_SIZE macro

Ephrim Khong (1):
      sha1_file: do not add own object directory as alternate

Eric Wong (1):
      config: preserve config file permissions on edits

Erik Faye-Lund (1):
      send-email: recognize absolute path on Windows

=46abian Ruch (1):
      sequencer: signal failed ff as an aborted, not a conflicted merge

=46elipe Contreras (13):
      fast-export: improve argument parsing
      fast-export: add new --refspec option
      transport-helper: add support for old:new refspec
      transport-helper: add support to push symbolic refs
      fast-import: add support to delete refs
      fast-export: add support to delete refs
      transport-helper: add support to delete branches
      transport-helper: remove unnecessary strbuf resets
      mergetools: add vimdiff3 mode
      mergetool: run prompt only if guessed tool
      merge: enable defaulttoupstream by default
      rerere: fix for merge.conflictstyle
      silence a bunch of format-zero-length warnings

Ilya Bobyr (4):
      test-lib: document short options in t/README
      test-lib: tests skipped by GIT_SKIP_TESTS say so
      test-lib: '--run' to run only specific tests
      gitk: Replace SHA1 entry field on keyboard paste

Jacek Konieczny (1):
      pull: do not abuse 'break' inside a shell 'case'

Jacob Keller (2):
      tag: fix --sort tests to use cat<<-\EOF format
      tag: support configuring --sort via .gitconfig

James Denholm (6):
      contrib/subtree/Makefile: scrap unused $(gitdir)
      contrib/subtree/Makefile: use GIT-VERSION-FILE
      contrib/subtree/Makefile: s/libexecdir/gitexecdir/
      contrib/subtree/Makefile: clean up rules to generate documentatio=
n
      contrib/subtree/Makefile: clean up rule for "clean"
      contrib/subtree: allow adding an annotated tag

Jason St. John (1):
      Documentation: use "command-line" when used as a compound adjecti=
ve, and fix other minor grammatical issues

Jean-Jacques Lafay (1):
      git tag --contains: avoid stack overflow

Jeff King (131):
      run_external_diff: use an argv_array for the environment
      run_external_diff: clean up error handling
      run_external_diff: drop fflush(NULL)
      run_external_diff: hoist common bits out of conditional
      run_external_diff: refactor cmdline setup logic
      commit: do not complain of empty messages from -C
      t3910: show failure of core.precomposeunicode with decomposed fil=
enames
      replace: refactor command-mode determination
      replace: use OPT_CMDMODE to handle modes
      replace: factor object resolution out of replace_object
      replace: add --edit option
      commit: use split_ident_line to compare author/committer
      pretty: make show_ident_date public
      commit: print "Date" line when the user has set date
      commit: accept more date formats for "--date"
      inline constant return from error() function
      let clang use the constant-return error() macro
      grep: use run-command's "dir" option for --open-files-in-pager
      t/lib-httpd: require SANITY prereq
      index-pack: distinguish missing objects from type errors
      run_diff_files: do not look at uninitialized stat data
      run-command: store an optional argv_array
      run_column_filter: use argv_array
      git_connect: use argv_array
      get_helper: use run-command's internal argv_array
      get_exporter: use argv_array
      get_importer: use run-command's internal argv_array
      argv-array: drop "detach" code
      open_sha1_file: report "most interesting" errno
      move "--follow needs one pathspec" rule to diff_setup_done
      format-patch: make newline after signature conditional
      daemon/config: factor out duplicate xstrdup_tolower
      test-lib: preserve GIT_CURL_VERBOSE from the environment
      t/lib-httpd: use write_script to copy CGI scripts
      t5550: test display of remote http error messages
      strbuf: add strbuf_tolower function
      http: extract type/subtype portion of content-type
      http: optionally extract charset parameter from content-type
      strbuf: add strbuf_reencode helper
      remote-curl: reencode http error messages
      http: default text charset to iso-8859-1
      t5537: re-drop http tests
      error_resolve_conflict: rewrap advice message
      error_resolve_conflict: drop quotations around operation
      update-index: fix segfault with missing --cacheinfo argument
      repack: do not accidentally pack kept objects by default
      repack: respect pack.writebitmaps
      repack: s/write_bitmap/&s/ in code
      pack-objects: stop respecting pack.writebitmaps
      repack: simplify handling of --write-bitmap-index
      repack: introduce repack.writeBitmaps config option
      commit_tree: take a pointer/len pair rather than a const strbuf
      replace dangerous uses of strbuf_attach
      alloc: include any-object allocations in alloc_report
      commit: push commit_index update into alloc_commit_node
      do not create "struct commit" with xcalloc
      logmsg_reencode: return const buffer
      sequencer: use logmsg_reencode in get_message
      t7700: drop explicit --no-pack-kept-objects from .keep test
      provide a helper to free commit buffer
      provide a helper to set the commit buffer
      provide helpers to access the commit buffer
      use get_cached_commit_buffer where appropriate
      use get_commit_buffer to avoid duplicate code
      convert logmsg_reencode to get_commit_buffer
      use get_commit_buffer everywhere
      commit-slab: provide a static initializer
      commit: convert commit->buffer to a slab
      commit: record buffer length in cache
      reuse cached commit buffer when parsing signatures
      t7510: stop referring to master in later tests
      t7510: test a commit signed by an unknown key
      t7510: check %G* pretty-format output
      pretty: avoid reading past end-of-string with "%G"
      parse_diff_color_slot: drop ofs parameter
      daemon: mark some strings as const
      avoid using skip_prefix as a boolean
      strbuf: add xstrfmt helper
      use xstrfmt in favor of manual size calculations
      use xstrdup instead of xmalloc + strcpy
      use xstrfmt to replace xmalloc + sprintf
      use xstrfmt to replace xmalloc + strcpy/strcat
      setup_git_env: use git_pathdup instead of xmalloc + sprintf
      sequencer: use argv_array_pushf
      merge: use argv_array when spawning merge strategy
      walker_fetch: fix minor memory leak
      unique_path: fix unlikely heap overflow
      refactor skip_prefix to return a boolean
      apply: use skip_prefix instead of raw addition
      fast-import: fix read of uninitialized argv memory
      transport-helper: avoid reading past end-of-string
      use skip_prefix to avoid magic numbers
      use skip_prefix to avoid repeating strings
      fast-import: use skip_prefix for parsing input
      daemon: use skip_prefix to avoid magic numbers
      stat_opt: check extra strlen call
      fast-import: refactor parsing of spaces
      fetch-pack: refactor parsing in get_ack
      git: avoid magic number with skip_prefix
      use skip_prefix to avoid repeated calculations
      http-push: refactor parsing of remote object names
      setup_git_env(): introduce git_path_from_env() helper
      move "%G" format test from t7510 to t6006
      replace: replace spaces with tabs in indentation
      avoid double close of descriptors handed to run_command
      replace: use argv_array in export_object
      replace: add a --raw mode for --edit
      add strip_suffix function
      implement ends_with via strip_suffix
      replace has_extension with ends_with
      use strip_suffix instead of ends_with in simple cases
      index-pack: use strip_suffix to avoid magic numbers
      strbuf: implement strbuf_strip_suffix
      verify-pack: use strbuf_strip_suffix
      prepare_packed_git_one: refactor duplicate-pack check
      t7300: repair filesystem permissions with test_when_finished
      remote-curl: do not complain on EOF from parent git
      remote-curl: use error instead of fprintf(stderr)
      remote-curl: mark helper-protocol errors more clearly
      tag: use skip_prefix instead of magic numbers
      alloc: write out allocator definitions
      move setting of object->type to alloc_* functions
      parse_object_buffer: do not set object type
      add object_as_type helper for casting objects
      alloc: factor out commit index
      object_as_type: set commit index
      diff-tree: avoid lookup_unknown_object
      prio-queue: factor out compare and swap operations
      prio-queue: make output stable with respect to insertion
      paint_down_to_common: use prio_queue
      t5539: update a flaky test

Jens Lehmann (21):
      status/commit: show staged submodules regardless of ignore config
      commit -m: commit staged submodules regardless of ignore config
      git-gui: show staged submodules regardless of ignore config
      git-gui: tolerate major version changes when comparing the git ve=
rsion
      gitk: Show staged submodules regardless of ignore config
      test-lib: add test_dir_is_empty()
      t/Makefile: check helper scripts for non-portable shell commands =
too
      t/Makefile: always test all lint targets when running tests
      submodules: add the lib-submodule-update.sh test library
      checkout: call the new submodule update test framework
      apply: add t4137 for submodule updates
      read-tree: add t1013 for submodule updates
      reset: add t7112 for submodule updates
      bisect: add t6041 for submodule updates
      merge: add t7613 for submodule updates
      rebase: add t3426 for submodule updates
      pull: add t5572 for submodule updates
      cherry-pick: add t3512 for submodule updates
      am: add t4255 for submodule updates
      stash: add t3906 for submodule updates
      revert: add t3513 for submodule updates

Jens Lindstr=C3=B6m (3):
      remote rm: delete remote configuration as the last
      remote: repack packed-refs once when deleting multiple refs
      remote prune: optimize "dangling symref" check/warning

Jeremiah Mahler (7):
      format-patch: add "--signature-file=3D<file>" option
      t9138-git-svn-authors-prog.sh fixups
      Documentation: wording fixes in the user manual and glossary
      t/t7810-grep.sh: remove duplicate test_config()
      api-strbuf.txt minor typos
      name-hash.c: replace cache_name_compare() with memcmp(3)
      cleanup duplicate name_compare() functions

Jiang Xin (2):
      blame: fix broken time_buf paddings in relative timestamp
      blame: dynamic blame_date_width for different locales

Johannes Schindelin (2):
      git grep -O -i: if the pager is 'less', pass the '-I' option
      Win32: let mingw_execve() return an int

Johannes Sixt (1):
      fix brown paper bag breakage in t5150-request-pull.sh

John Keeping (4):
      completion: add a note that merge options are shared
      completion: add missing options for git-merge
      rebase--am: use --cherry-pick instead of --ignore-if-in-upstream
      rebase: omit patch-identical commits with --fork-point

Jonathan McCrohan (1):
      git-instaweb: add support for Apache 2.4

Jonathan Nieder (4):
      contrib: remove vim support instructions
      contrib: remove git-diffall
      test-lint: find unportable sed, echo, test, and export usage afte=
r &&
      test doc: test_write_lines does not split its arguments

Junio C Hamano (49):
      apply --ignore-space-change: lines with and without leading white=
spaces do not match
      send-email: windows drive prefix (e.g. C:) appears only at the be=
ginning
      mergetool: document the default for --[no-]prompt
      compat/bswap.h: restore preference __BIG_ENDIAN over BIG_ENDIAN
      CodingGuidelines: once it is in, it is not worth the code churn
      CodingGuidelines: give an example for case/esac statement
      CodingGuidelines: give an example for redirection
      CodingGuidelines: give an example for control statements
      CodingGuidelines: give an example for shell function preamble
      CodingGuidelines: do not call the conditional statement "if()"
      CodingGuidelines: on comparison
      CodingGuidelines: on splitting a long line
      CodingGuidelines: avoid "test <cond> -a/-o <cond>"
      scripts: more "export VAR=3DVALUE" fixes
      Git 1.9.4
      fetch doc: update introductory part for clarity
      fetch doc: update note on '+' in front of the refspec
      fetch doc: remove notes on outdated "mixed layout"
      First batch for 2.1
      shortlog: allow --exclude=3D<glob> to be passed
      fetch doc: on pulling multiple refspecs
      fetch doc: update refspec format description
      fetch doc: remove "short-cut" section
      fetch doc: add a section on configured remote-tracking branches
      fetch: allow explicit --refmap to override configuration
      Second batch for 2.1
      Update draft release notes to 2.1
      test: turn EXPENSIVE into a lazy prerequisite
      test: turn USR_BIN_TIME into a lazy prerequisite
      t3302: coding style updates
      t3302: do not chdir around in the primary test process
      t3302: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
      t3419: drop unnecessary NOT_EXPENSIVE pseudo-prerequisite
      revision: parse "git log -<count>" more carefully
      t0008: do not depend on 'echo' handling backslashes specially
      Third batch for 2.1
      git-submodule.sh: avoid "echo" path-like values
      Fourth batch for 2.1
      builtin/clone.c: detect a clone starting at a tag correctly
      Git 2.0.1
      Fifth batch for 2.1
      Sixth batch for 2.1
      Start preparing for 2.0.2
      Seventh batch for 2.1
      Git 2.0.2
      Eighth batch for 2.1
      Ninth batch for 2.1
      Git 2.0.3
      Git 2.1.0-rc0

J=C3=B6rn Engel (1):
      pager: do allow spawning pager recursively

Karsten Blees (46):
      MSVC: link dynamically to the CRT
      Win32 dirent: remove unused dirent.d_ino member
      Win32 dirent: remove unused dirent.d_reclen member
      Win32 dirent: change FILENAME_MAX to MAX_PATH
      Win32 dirent: clarify #include directives
      Win32 dirent: improve dirent implementation
      Win32: move main macro to a function
      Win32: support Unicode console output
      Win32: detect console streams more reliably
      Win32: warn if the console font doesn't support Unicode
      Win32: add Unicode conversion functions
      Win32: Thread-safe windows console output
      Win32: fix broken pipe detection
      Win32: reliably detect console pipe handles
      Win32: simplify internal mingw_spawn* APIs
      Win32: fix potential multi-threading issue
      MinGW: disable CRT command line globbing
      Win32: Unicode arguments (outgoing)
      Win32: Unicode arguments (incoming)
      trace: move trace declarations from cache.h to new trace.h
      trace: consistently name the format parameter
      trace: remove redundant printf format attribute
      symlinks: remove PATH_MAX limitation
      hashmap: factor out getting a hash code from a SHA1
      hashmap: improve struct hashmap member documentation
      hashmap: add simplified hashmap_get_from_hash() API
      hashmap: add string interning API
      cache.h: rename cache_def_free to cache_def_clear
      trace: improve trace performance
      Documentation/git.txt: improve documentation of 'GIT_TRACE*' vari=
ables
      sha1_file: change GIT_TRACE_PACK_ACCESS logging to use trace API
      trace: add infrastructure to augment trace output with additional=
 info
      trace: disable additional trace output for unit tests
      trace: add current timestamp to all trace output
      trace: move code around, in preparation to file:line output
      trace: add 'file:line' to all trace output
      trace: add high resolution timer function to debug performance is=
sues
      trace: add trace_performance facility to debug performance issues
      git: add performance tracing for git's main() function to debug s=
cripts
      wt-status: simplify performance measurement by using getnanotime(=
)
      progress: simplify performance measurement by using getnanotime()
      api-trace.txt: add trace API documentation
      Win32: Unicode file name support (except dirent)
      Win32: Unicode file name support (dirent)
      MinGW: fix compile error due to missing ELOOP
      config: use chmod() instead of fchmod()

Kirill Smelkov (20):
      combine-diff: move show_log_first logic/action out of paths scann=
ing
      combine-diff: move changed-paths scanning logic into its own func=
tion
      tree-diff: no need to manually verify that there is no mode chang=
e for a path
      tree-diff: no need to pass match to skip_uninteresting()
      tree-diff: show_tree() is not needed
      tree-diff: consolidate code for emitting diffs and recursion in o=
ne place
      tree-diff: don't assume compare_tree_entry() returns -1,0,1
      tree-diff: move all action-taking code out of compare_tree_entry(=
)
      tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
      tree-diff: show_path prototype is not needed anymore
      tree-diff: simplify tree_entry_pathcmp
      tree-diff: remove special-case diff-emitting code for empty-tree =
cases
      tree-diff: diff_tree() should now be static
      tree-diff: rework diff_tree interface to be sha1 based
      tree-diff: no need to call "full" diff_tree_sha1 from show_path()
      tree-diff: reuse base str(buf) memory on sub-tree recursion
      Portable alloca for Git
      tree-diff: rework diff_tree() to generate diffs for multiparent c=
ases as well
      combine-diff: speed it up, by using multiparent diff tree-walker =
directly
      mingw: activate alloca

Linus Torvalds (1):
      git log: support "auto" decorations

Luis R. Rodriguez (1):
      git.c: treat RUN_SETUP_GENTLY and RUN_SETUP as mutually exclusive

Marc Branchaud (2):
      fetch doc: move FETCH_HEAD material lower and add an example
      docs: Explain the purpose of fetch's and pull's <refspec> paramet=
er.

Matthew Chen (1):
      submodule: document "sync --recursive"

Matthieu Moy (4):
      git-remote-mediawiki: allow stop/start-ing the test server
      git-remote-mediawiki: fix encoding issue for UTF-8 media files
      pager: remove 'S' from $LESS by default
      rebase -i: test "Nothing to do" case with autostash

Max Kirillov (5):
      git-show: fix 'git show -s' to not add extra terminator after mer=
ge commit
      gitk: Switch to patch mode when searching for line origin
      gitk: Add visiblerefs option, which lists always-shown branches
      t6023-merge-file.sh: fix and mark as broken invalid tests
      git-merge-file: do not add LF at EOF while applying unrelated cha=
nge

Maxime Coste (2):
      git-p4: Do not include diff in spec file when just preparing p4
      git-p4: fix submit in non --prepare-p4-only mode

Michael Barabanov (1):
      use local cloning if insteadOf makes a local URL

Michael Haggerty (27):
      t1400: fix name and expected result of one test
      t1400: provide more usual input to the command
      parse_arg(): really test that argument is properly terminated
      t1400: add some more tests involving quoted arguments
      refs.h: rename the action_on_err constants
      update_refs(): fix constness
      update-ref --stdin: read the whole input at once
      parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue=
> twice
      update-ref.c: extract a new function, parse_refname()
      update-ref --stdin: improve error messages for invalid values
      update-ref --stdin: make error messages more consistent
      update-ref --stdin: simplify error messages for missing oldvalues
      t1400: test that stdin -z update treats empty <newvalue> as zeros
      update-ref.c: extract a new function, parse_next_sha1()
      update-ref --stdin -z: deprecate interpreting the empty string as=
 zeros
      t1400: test one mistake at a time
      update-ref --stdin: improve the error message for unexpected EOF
      update-ref --stdin: harmonize error messages
      refs: add a concept of a reference transaction
      update-ref --stdin: reimplement using reference transactions
      refs: remove API function update_refs()
      struct ref_update: rename field "ref_name" to "refname"
      struct ref_update: store refname as a FLEX_ARRAY
      ref_transaction_commit(): simplify code using temporary variables
      struct ref_update: add a lock field
      struct ref_update: add a type field
      ref_transaction_commit(): work with transaction->updates in place

Michael J Gruber (7):
      t7510: use consistent &&-chains in loop
      gpg-interface: provide clear helper for struct signature_check
      gpg-interface: provide access to the payload
      verify-commit: scriptable commit signature verification
      t7510: exit for loop with test result
      t7510: test verify-commit
      log: correctly identify mergetag signature verification status

Michael Naumov (1):
      sideband.c: do not use ANSI control sequence on non-terminal

Michael S. Tsirkin (6):
      git-send-email: two new options: to-cover, cc-cover
      test/send-email: to-cover, cc-cover tests
      rebase --keep-empty -i: add test
      test: add test_write_lines helper
      patch-id: make it stable against hunk reordering
      patch-id-test: test stable and unstable behaviour

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (40):
      index-pack: work around thread-unsafe pread()
      ewah: fix constness of ewah_read_mmap
      ewah: delete unused ewah_read_mmap_native declaration
      sequencer: do not update/refresh index if the lock cannot be held
      config: be strict on core.commentChar
      commit: allow core.commentChar=3Dauto for character auto selectio=
n
      gc --auto: do not lock refs in the background
      git potty: restore environments after alias expansion
      read-cache: new API write_locked_index instead of write_index/wri=
te_cache
      read-cache: relocate and unexport commit_locked_index()
      read-cache: store in-memory flags in the first 12 bits of ce_flag=
s
      read-cache: be strict about "changed" in remove_marked_cache_entr=
ies()
      read-cache: be specific what part of the index has changed
      update-index: be specific what part of the index has changed
      resolve-undo: be specific what part of the index has changed
      unpack-trees: be specific what part of the index has changed
      cache-tree: mark istate->cache_changed on cache tree invalidation
      cache-tree: mark istate->cache_changed on cache tree update
      cache-tree: mark istate->cache_changed on prime_cache_tree()
      entry.c: update cache_changed if refresh_cache is set in checkout=
_entry()
      read-cache: save index SHA-1 after reading
      read-cache: split-index mode
      read-cache: mark new entries for split index
      read-cache: save deleted entries in split index
      read-cache: mark updated entries for split index
      split-index: the writing part
      split-index: the reading part
      split-index: do not invalidate cache-tree at read time
      split-index: strip pathname of on-disk replaced entries
      update-index: new options to enable/disable split index mode
      update-index --split-index: do not split if $GIT_DIR is read only
      rev-parse: add --shared-index-path to get shared index path
      read-tree: force split-index mode off on --index-output
      read-tree: note about dropping split-index mode or index version
      read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
      t2104: make sure split index mode is off for the version test
      t1700: new tests for split-index mode
      dir.c: coding style fix
      dir.h: move struct exclude declaration to top level
      prep_exclude: remove the artificial PATH_MAX limit

Nick Alcock (1):
      t5538: move http push tests out to t5542

Pasha Bolokhov (1):
      dir.c:trim_trailing_spaces(): fix for " \ " sequence

Pat Thoyts (2):
      wincred: add install target
      wincred: avoid overwriting configured variables

Philip Oakley (1):
      doc: give some guidelines for error messages

Ramkumar Ramachandra (1):
      rebase -i: handle "Nothing to do" case with autostash

Ramsay Allan Jones (2):
      t0000-*.sh: fix the GIT_SKIP_TESTS sub-tests
      alloc.c: remove the alloc_raw_commit_node() function

Ren=C3=A9 Scharfe (28):
      mailinfo: use strcmp() for string comparison
      pack-objects: use free()+xcalloc() instead of xrealloc()+memset()
      Use starts_with() for C strings instead of memcmp()
      blame: factor out get_next_line()
      blame: simplify prepare_lines()
      wt-status: use argv_array for environment
      wt-status: simplify building of summary limit argument
      sha1_file: replace PATH_MAX buffer with strbuf in prepare_packed_=
git_one()
      sha1_file: avoid overrunning alternate object base string
      t5000, t5003: simplify commit
      diff-tree: call free_commit_list() instead of duplicating its cod=
e
      line-log: use commit_list_append() instead of duplicating its cod=
e
      use strbuf_addbuf for adding strbufs
      use strbuf_addch for adding single characters
      merge: simplify merge_trivial() by using commit_list_append()
      commit: use commit_list_append() instead of duplicating its code
      fsck: simplify fsck_commit_buffer() by using commit_list_count()
      annotate: use argv_array
      strbuf: use strbuf_addstr() for adding C strings
      use commit_list_count() to count the members of commit_lists
      run-command: use internal argv_array of struct child_process in r=
un_hook_ve()
      transport: simplify fetch_objs_via_rsync() using argv_array
      fast-import: use hashcmp() for SHA1 hash comparison
      bundle: use internal argv_array of struct child_process in create=
_bundle()
      remote-testsvn: use internal argv_array of struct child_process i=
n cmd_import()
      unix-socket: remove stale socket before calling chdir()
      use xcalloc() to allocate zero-initialized memory
      use xmemdupz() to allocate copies of strings given by start and l=
ength

RomanBelinsky (1):
      SVN.pm::parse_svn_date: allow timestamps with a single-digit hour

Ronnie Sahlberg (27):
      sequencer.c: check for lock failure and bail early in fast_forwar=
d_to
      commit.c: check for lock error and return early
      refs.c: add new functions reflog_exists and delete_reflog
      checkout.c: use ref_exists instead of file_exist
      refs.c: change read_ref_at to use the reflog iterators
      enums: remove trailing ',' after last item in enum
      enums: remove trailing ',' after last item in enum
      refs.c: remove ref_transaction_rollback
      refs.c: ref_transaction_commit should not free the transaction
      refs.c: constify the sha arguments for ref_transaction_create|del=
ete|update
      refs.c: allow passing NULL to ref_transaction_free
      refs.c: add a strbuf argument to ref_transaction_commit for error=
 logging
      lockfile.c: add a new public function unable_to_lock_message
      lockfile.c: make lock_file return a meaningful errno on failurei
      refs.c: add an err argument to repack_without_refs
      refs.c: make sure log_ref_setup returns a meaningful errno
      refs.c: verify_lock should set errno to something meaningful
      refs.c: make remove_empty_directories always set errno to somethi=
ng sane
      refs.c: commit_packed_refs to return a meaningful errno on failur=
e
      refs.c: make resolve_ref_unsafe set errno to something meaningful=
 on error
      refs.c: log_ref_write should try to return meaningful errno
      refs.c: make ref_update_reject_duplicates take a strbuf argument =
for errors
      refs.c: make update_ref_write update a strbuf on failure
      update-ref: use err argument to get error from ref_transaction_co=
mmit
      refs.c: remove the onerr argument to ref_transaction_commit
      refs.c: change ref_transaction_update() to do error checking and =
return status
      refs.c: add a public is_branch function

Stefan Beller (3):
      .mailmap: map different names with the same email address togethe=
r
      git.1: switch homepage for stats
      .mailmap: combine Stefan Beller's emails

Steffen Prohaska (1):
      completion: handle '!f() { ... }; f' and "!sh -c '...' -" aliases

Stepan Kasal (3):
      Revert "submodules: fix ambiguous absolute paths under Windows"
      t5000, t5003: do not use test_cmp to compare binary files
      mingw: avoid const warning

Stephen P. Smith (1):
      How to keep a project's canonical history correct.

Steve Hoelzer (1):
      environment.c: enable core.preloadindex by default

Tanay Abhra (4):
      string-list: spell all values out that are given to a string_list=
 initializer
      imap-send: use skip_prefix instead of using magic numbers
      string-list: add string_list initializer helper function
      replace memset with string-list initializers

Theodore Leblond (1):
      compat/poll: sleep 1 millisecond to avoid busy wait

Thorsten Glaser (1):
      builtin/tag.c: show tag name to hint in the message editor

Torsten B=C3=B6gershausen (7):
      utf8.c: use a table for double_width
      utf8: make it easier to auto-update git_wcwidth()
      t5551: fix the 50,000 tag test
      t9001: avoid non-portable '\n' with sed
      Update of unicode_width.h to Unicode Version 7.0
      t0025: rename the test files
      t0027: combinations of core.autocrlf, core.eol and text

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: Init Vietnamese translation

W. Trevor King (1):
      Documentation: mention config sources for @{upstream}

William Giokas (1):
      svn-fe: conform to pep8

Yi EungJun (2):
      http-protocol.txt: Basic Auth is defined in RFC 2617, not RFC 261=
6
      http: fix charset detection of extract_content_type()

Yiannis Marangos (2):
      wrapper.c: add xpread() similar to xread()
      read-cache.c: verify index file before we opportunistically updat=
e it

Zoltan Klinger (1):
      log: fix indentation for --graph --show-signature

brian m. carlson (3):
      blame: correctly handle files regardless of autocrlf
      rebase--merge: fix --skip with two conflicts in a row
      Documentation: fix missing text for rev-parse --verify

=C3=98ystein Walle (1):
      config: respect '~' and '~user' in mailmap.file

=C3=98yvind A. Holm (1):
      .gitignore: "git-verify-commit" is a generated file
