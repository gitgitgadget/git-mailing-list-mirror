From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.4.0-rc2
Date: Tue, 14 Apr 2015 14:48:44 -0700
Message-ID: <xmqqlhhu1iv7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Apr 14 23:49:28 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Yi8hd-00015r-Rq
	for glk-linux-kernel-3@plane.gmane.org; Tue, 14 Apr 2015 23:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbbDNVs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 14 Apr 2015 17:48:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753893AbbDNVsr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Apr 2015 17:48:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 733474A634;
	Tue, 14 Apr 2015 17:48:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=V0DJ2sr1PQUnepNh8jnVBu4cy
	v8=; b=uicdIN13WTsw60QQA+AYIdVvk8cPuQejEP3KwMBiDmHa7xNhkY2VRM8hU
	EJHBNzFlwNdM+W+ZcOg5ZY0B3/6wFyyAxoqoEUD7MtYm2du8l9xTNBW6VcCNMaXq
	m/Xwi0LpBg3LZqhvFTPesPTCmq4Se/r/PTM/oZRlYgChxFkKGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=yL608kKGbn2wGh/Brgb
	LfyCzeo71+AQbZr2nRJGbKK3NWwp/1iMSXXYeo0UKFigYxEwea6wT0WHBuwNU4vd
	oXSqeaTzmHNILIyLM0fUvPsjqqISRe4ubJ/kDL08PoCDZvpndghj3bGUZ1LsRKTv
	QIqjv9Gv411Y/841Qs08NwRs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AE184A632;
	Tue, 14 Apr 2015 17:48:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EDB04A631;
	Tue, 14 Apr 2015 17:48:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 067A4832-E2F0-11E4-B8E1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267164>

A release candidate Git v2.4.0-rc2 is now available for testing at
the usual places.  The difference since -rc1 is mostly l10n and a
handful of documentation clean-ups.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.4.0-rc2'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.4 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backward compatibility warning(s)
---------------------------------

This release has a few changes in the user-visible output from
Porcelain commands. These are not meant to be parsed by scripts, but
the users still may want to be aware of the changes:

 * Output from "git log --decorate" (and "%d" format specifier used in
   the userformat "--format=3D<string>" parameter "git log" family of
   command takes) used to list "HEAD" just like other tips of branch
   names, separated with a comma in between.  E.g.

     $ git log --decorate -1 master
     commit bdb0f6788fa5e3cacc4315e9ff318a27b2676ff4 (HEAD, master)
     ...

   This release updates the output slightly when HEAD refers to the tip
   of a branch whose name is also shown in the output.  The above is
   shown as:

     $ git log --decorate -1 master
     commit bdb0f6788fa5e3cacc4315e9ff318a27b2676ff4 (HEAD -> master)
     ...

 * The phrasing "git branch" uses to describe a detached HEAD has been
   updated to match that of "git status":

    - When the HEAD is at the same commit as it was originally
      detached, they now both show "detached at <commit object name>".

    - When the HEAD has moved since it was originally detached,
      they now both show "detached from <commit object name>".

    Earlier "git branch" always used "from"


Updates since v2.3
------------------

Ports

 * Our default I/O size (8 MiB) for large files was too large for some
   platforms with smaller SSIZE_MAX, leading to read(2)/write(2)
   failures.

 * We did not check the curl library version before using
   CURLOPT_PROXYAUTH feature that may not exist.

 * We now detect number of CPUs on older BSD-derived systems.

 * Portability fixes and workarounds for shell scripts have been added
   to help BSD-derived systems.


UI, Workflows & Features

 * The command usage info strings given by "git cmd -h" and in
   documentation have been tweaked for consistency.

 * The "sync" subcommand of "git p4" now allows users to exclude
   subdirectories like its "clone" subcommand does.

 * "git log --invert-grep --grep=3DWIP" will show only commits that do
   not have the string "WIP" in their messages.

 * "git push" has been taught a "--atomic" option that makes push to
   update more than one ref an "all-or-none" affair.

 * Extending the "push to deploy" added in 2.3, the behaviour of "git
   push" when updating the branch that is checked out can now be
   tweaked by push-to-checkout hook.

 * Using environment variable LANGUAGE and friends on the client side,
   HTTP-based transports now send Accept-Language when making requests.

 * "git send-email" used to accept a mistaken "y" (or "yes") as an
   answer to "What encoding do you want to use [UTF-8]? " without
   questioning.  Now it asks for confirmation when the answer looks
   too short to be a valid encoding name.

 * When "git apply --whitespace=3Dfix" fixed whitespace errors in the
   common context lines, the command reports that it did so.

 * "git status" now allows the "-v" to be given twice to show the
   differences that are left in the working tree not to be committed.

 * "git cherry-pick" used to clean-up the log message even when it is
   merely replaying an existing commit.  It now replays the message
   verbatim unless you are editing the message of resulting commits.

 * "git archive" can now be told to set the 'text' attribute in the
   resulting zip archive.

 * Output from "git log --decorate" mentions HEAD when it points at a
   tip of an branch differently from a detached HEAD.

   This is a potentially backward-incompatible change.

 * "git branch" on a detached HEAD always said "(detached from xyz)",
   even when "git status" would report "detached at xyz".  The HEAD is
   actually at xyz and haven't been moved since it was detached in
   such a case, but the user cannot read what the current value of
   HEAD is when "detached from" is used.

 * "git -C '' subcmd" refused to work in the current directory, unlike
   "cd ''" which silently behaves as a no-op.
   (merge 6a536e2 kn/git-cd-to-empty later to maint).

 * The versionsort.prerelease configuration variable can be used to
   specify that v1.0-pre1 comes before v1.0.

 * A new "push.followTags" configuration turns the "--follow-tags"
   option on by default for the "git push" command.

 * "git log --graph --no-walk A B..." is a conflicting request that
   asks nonsense; no-walk tells us show discrete points in the
   history, while graph asks to draw connections between these
   discrete points. Forbid the combination.

 * "git rev-list --bisect --first-parent" does not work (yet) and can
   even cause SEGV; forbid it.  "git log --bisect --first-parent"
   would not be useful until "git bisect --first-parent" materializes,
   so it is also forbidden for now.


Performance, Internal Implementation, Development Support etc.

 * Implementation of N_() macro has been updated slightly to help us
   detect mistakes.

 * Implementation of "reflog expire" has been restructured to fit the
   reflogs better with the recently updated ref API.

 * The transport-helper did not give transport options such as
   verbosity, progress, cloning, etc. to import and export based
   helpers, like it did for fetch and push based helpers, robbing them
   the chance to honor the wish of the end-users better.

 * The tests that wanted to see that file becomes unreadable after
   running "chmod a-r file", and the tests that wanted to make sure it
   is not run as root, we used "can we write into the / directory?" as
   a cheap substitute, but on some platforms that is not a good
   heuristics.  The tests and their prerequisites have been updated to
   check what they really require.
   (merge f400e51 jk/sanity later to maint).

 * Various issues around "reflog expire", e.g. using --updateref when
   expiring a reflog for a symbolic reference, have been corrected
   and/or made saner.

 * The strbuf API was explained between the API documentation and in
   the header file.  Move missing bits to strbuf.h so that programmers
   can check only one place for all necessary information.

 * The error handling functions and conventions are now documented in
   the API manual.

 * Optimize attribute look-up, mostly useful in "git grep" on a
   project that does not use many attributes, by avoiding it when we
   (should) know that the attributes are not defined in the first
   place.

 * Typofix in comments.
   (merge ef2956a ak/git-pm-typofix later to maint).

 * Code clean-up.
   (merge 0b868f0 sb/hex-object-name-is-at-most-41-bytes-long later to =
maint).
   (merge 5d30851 dp/remove-duplicated-header-inclusion later to maint)=
=2E

 * Simplify the ref transaction API around how "the ref should be
   pointing at this object" is specified.

 * Code in "git daemon" to parse out and hold hostnames used in
   request interpolation has been simplified.

 * "git push" codepath has been restructured to make it easier to add
   new configuration bits.

 * The run-command interface was easy to abuse and make a pipe for us
   to read from the process, wait for the process to finish and then
   attempt to read its output, which is a pattern that lead to a
   deadlock.  Fix such uses by introducing a helper to do this
   correctly (i.e. we need to read first and then wait the process to
   finish) and also add code to prevent such abuse in the run-command
   helper.

 * People often forget to chain the commands in their test together
   with &&, leaving a failure from an earlier command in the test go
   unnoticed.  The new GIT_TEST_CHAIN_LINT mechanism allows you to
   catch such a mistake more easily.


Also contains various documentation updates and code clean-ups.


=46ixes since v2.3
----------------

Unless otherwise noted, all the fixes since v2.3 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git blame HEAD -- missing" failed to correctly say "HEAD" when it
   tried to say "No such path 'missing' in HEAD".
   (merge a46442f jk/blame-commit-label later to maint).

 * "git rerere" (invoked internally from many mergy operations) did
   not correctly signal errors when told to update the working tree
   files and failed to do so for whatever reason.
   (merge 89ea903 jn/rerere-fail-on-auto-update-failure later to maint)=
=2E

 * Setting diff.submodule to 'log' made "git format-patch" produce
   broken patches.
   (merge 339de50 dk/format-patch-ignore-diff-submodule later to maint)=
=2E

 * After attempting and failing a password-less authentication
   (e.g. Kerberos), libcURL refuses to fall back to password based
   Basic authentication without a bit of help/encouragement.
   (merge 4dbe664 bc/http-fallback-to-password-after-krb-fails later to=
 maint).

 * The "git push" documentation made the "--repo=3D<there>" option
   easily misunderstood.
   (merge 57b92a7 mg/push-repo-option-doc later to maint).

 * Code to read branch name from various files in .git/ directory
   would have misbehaved if the code to write them left an empty file.
   (merge 66ec904 jk/status-read-branch-name-fix later to maint).

 * A misspelled conditional that is always true has been fixed.
   (merge 94ee8e2 jk/remote-curl-an-array-in-struct-cannot-be-null late=
r to maint).

 * The documentation incorrectly said that C(opy) and R(ename) are the
   only ones that can be followed by the score number in the output in
   the --raw format.
   (merge ac1c2d9 jc/diff-format-doc later to maint).

 * A broken pack .idx file in the receiving repository prevented the
   dumb http transport from fetching a good copy of it from the other
   side.
   (merge 8b9c2dd jk/dumb-http-idx-fetch-fix later to maint).

 * The error message from "git commit", when a non-existing author
   name was given as value to the "--author=3D" parameter, has been
   reworded to avoid misunderstanding.
   (merge 1044b1f mg/commit-author-no-match-malformed-message later to =
maint).

 * "git log --help" used to show rev-list options that are irrelevant
   to the "log" command.
   (merge 3cab02d jc/doc-log-rev-list-options later to maint).

 * "git apply --whitespace=3Dfix" used to under-allocate the memory whe=
n
   the fix resulted in a longer text than the original patch.
   (merge 407a792 jc/apply-ws-fix-expands later to maint).

 * The interactive "show a list and let the user choose from it"
   interface "add -i" used showed and prompted to the user even when
   the candidate list was empty, against which the only "choice" the
   user could have made was to choose nothing.
   (merge a9c4641 ak/add-i-empty-candidates later to maint).

 * The insn sheet "git rebase -i" creates did not fully honor
   core.abbrev settings.
   (merge edb72d5 ks/rebase-i-abbrev later to maint).

 * "git fetch" over a remote-helper that cannot respond to "list"
   command could not fetch from a symbolic reference e.g. HEAD.
   (merge 33cae54 mh/deref-symref-over-helper-transport later to maint)=
=2E

 * "git push --signed" gave an incorrectly worded error message when
   the other side did not support the capability.
   (merge 45917f0 jc/push-cert later to maint).

 * We didn't format an integer that wouldn't fit in "int" but in
   "uintmax_t" correctly.
   (merge d306f3d jk/decimal-width-for-uintmax later to maint).

 * Reading configuration from a blob object, when it ends with a lone
   CR, use to confuse the configuration parser.
   (merge 1d0655c jk/config-no-ungetc-eof later to maint).

 * The pack bitmap support did not build with older versions of GCC.
   (merge bd4e882 jk/pack-bitmap later to maint).

 * The documentation wasn't clear that "remote.<nick>.pushURL" and
   "remote.<nick>.URL" are there to name the same repository accessed
   via different transports, not two separate repositories.
   (merge 697f652 jc/remote-set-url-doc later to maint).

 * Older GnuPG implementations may not correctly import the keyring
   material we prepare for the tests to use.
   (merge 1f985d6 ch/new-gpg-drops-rfc-1991 later to maint).

 * The credential helper for Windows (in contrib/) used to mishandle
   a user name with an at-sign in it.
   (merge 13d261e av/wincred-with-at-in-username-fix later to maint).

 * "diff-highlight" (in contrib/) used to show byte-by-byte
   differences, which meant that multi-byte characters can be chopped
   in the middle.  It learned to pay attention to character boundaries
   (assuming the UTF-8 payload).
   (merge 8d00662 jk/colors later to maint).

 * "git merge --quiet" did not squelch messages from the underlying
   merge-recursive strategy.
   (merge 2bf15a3 jk/merge-quiet later to maint).

 * Longstanding configuration variable naming rules has been added to
   the documentation.
   (merge 35840a3 jc/conf-var-doc later to maint).

 * An earlier workaround to squelch unhelpful deprecation warnings
   from the compiler on Mac OSX unnecessarily set minimum required
   version of the OS, which the user might want to raise (or lower)
   for other reasons.
   (merge 88c03eb es/squelch-openssl-warnings-on-macosx later to maint)=
=2E

 * Certain older vintages of cURL give irregular output from
   "curl-config --vernum", which confused our build system.
   (merge 3af6792 tc/curl-vernum-output-broken-in-7.11 later to maint).

 * In v2.2.0, we broke "git prune" that runs in a repository that
   borrows from an alternate object store.
   (merge b0a4264 jk/prune-mtime later to maint).

 * "git submodule add" failed to squash "path/to/././submodule" to
   "path/to/submodule".
   (merge 8196e72 ps/submodule-sanitize-path-upon-add later to maint).

 * "git merge-file" did not work correctly in a subdirectory.
   (merge 204a8ff ab/merge-file-prefix later to maint).

 * "git blame" died, trying to free an uninitialized piece of memory.
   (merge e600592 es/blame-commit-info-fix later to maint).

 * "git fast-import" used to crash when it could not close and
   conclude the resulting packfile cleanly.
   (merge 5e915f3 jk/fast-import-die-nicely-fix later to maint).

 * "update-index --refresh" used to leak when an entry cannot be
   refreshed for whatever reason.
   (merge bc1c2ca sb/plug-leak-in-make-cache-entry later to maint).

 * The "interpolated-path" option of "git daemon" inserted any string
   client declared on the "host=3D" capability request without checking=
=2E
   Sanitize and limit %H and %CH to a saner and a valid DNS name.
   (merge b485373 jk/daemon-interpolate later to maint).

 * "git daemon" looked up the hostname even when "%CH" and "%IP"
   interpolations are not requested, which was unnecessary.
   (merge dc8edc8 rs/daemon-interpolate later to maint).

 * Even though we officially haven't dropped Perl 5.8 support, the
   Getopt::Long package that came with it does not support "--no-"
   prefix to negate a boolean option; manually add support to help
   people with older Getopt::Long package.
   (merge f471494 km/send-email-getopt-long-workarounds later to maint)=
=2E

 * "git apply" was not very careful about reading from, removing,
   updating and creating paths outside the working tree (under
   --index/--cached) or the current directory (when used as a
   replacement for GNU patch).
   (merge e0d201b jc/apply-beyond-symlink later to maint).

 * A breakage to git-svn around v2.2 era that triggers premature
   closing of FileHandle has been corrected.
   (merge e426311 ew/svn-maint-fixes later to maint).

 * We did not parse username followed by literal IPv6 address in SSH
   transport URLs, e.g. ssh://user@[2001:db8::1]:22/repo.git
   correctly.
   (merge 6b6c5f7 tb/connect-ipv6-parse-fix later to maint).

 * The configuration variable 'mailinfo.scissors' was hard to
   discover in the documentation.
   (merge afb5de7 mm/am-c-doc later to maint).

 * The interaction between "git submodule update" and the
   submodule.*.update configuration was not clearly documented.
   (merge 5c31acf ms/submodule-update-config-doc later to maint).

 * "git diff --shortstat --dirstat=3Dchanges" showed a dirstat based on
   lines that was never asked by the end user in addition to the
   dirstat that the user asked for.
   (merge ab27389 mk/diff-shortstat-dirstat-fix later to maint).

 * "git remote add" mentioned "--tags" and "--no-tags" and was not
   clear that fetch from the remote in the future will use the default
   behaviour when neither is given to override it.
   (merge aaba0ab mg/doc-remote-tags-or-not later to maint).

 * Description given by "grep -h" for its --exclude-standard option
   was phrased poorly.
   (merge 77fdb8a nd/grep-exclude-standard-help-fix later to maint).

 * "git rebase -i" recently started to include the number of
   commits in the insn sheet to be processed, but on a platform
   that prepends leading whitespaces to "wc -l" output, the numbers
   are shown with extra whitespaces that aren't necessary.
   (merge 2185d3b es/rebase-i-count-todo later to maint).

 * The borrowed code in kwset API did not follow our usual convention
   to use "unsigned char" to store values that range from 0-255.
   (merge 189c860 bw/kwset-use-unsigned later to maint).

 * A corrupt input to "git diff -M" used to cause it to segfault.
   (merge 4d6be03 jk/diffcore-rename-duplicate later to maint).

 * Certain builds of GPG triggered false breakages in a test.
   (merge 3f88c1b mg/verify-commit later to maint).

 * "git imap-send" learned to optionally talk with an IMAP server via
   libcURL; because there is no other option when Git is built with
   NO_OPENSSL option, use that codepath by default under such
   configuration.
   (merge dcd01ea km/imap-send-libcurl-options later to maint).

 * "git log --decorate" did not reset colors correctly around the
   branch names.
   (merge 5ee8758 jc/decorate-leaky-separator-color later to maint).

 * The code that reads from the ctags file in the completion script
   (in contrib/) did not spell ${param/pattern/string} substitution
   correctly, which happened to work with bash but not with zsh.
   (merge db8d750 js/completion-ctags-pattern-substitution-fix later to=
 maint).

 * The transfer.hiderefs support did not quite work for smart-http
   transport.
   (merge 8ddf3ca jk/smart-http-hide-refs later to maint).

 * "git tag -h" used to show the "--column" and "--sort" options
   that are about listing in a wrong section.
   (merge dd059c6 jk/tag-h-column-is-a-listing-option later to maint).

 * "git prune" used to largely ignore broken refs when deciding which
   objects are still being used, which could spread an existing small
   damage and make it a larger one.
   (merge ea56c4e jk/prune-with-corrupt-refs later to maint).

 * The split-index mode introduced at v2.3.0-rc0~41 was broken in the
   codepath to protect us against a broken reimplementation of Git
   that writes an invalid index with duplicated index entries, etc.
   (merge 03f15a7 tg/fix-check-order-with-split-index later to maint).

 * "git fetch" that fetches a commit using the allow-tip-sha1-in-want
   extension could have failed to fetch all the requested refs.
   (merge 32d0462 jk/fetch-pack later to maint).

 * An failure early in the "git clone" that started creating the
   working tree and repository could have resulted in some directories
   and files left without getting cleaned up.
   (merge 16eff6c jk/cleanup-failed-clone later to maint).

 * Recommend format-patch and send-email for those who want to submit
   patches to this project.
   (merge b25c469 jc/submitting-patches-mention-send-email later to mai=
nt).

 * Even though "git grep --quiet" is run merely to ask for the exit
   status, we spawned the pager regardless.  Stop doing that.
   (merge c2048f0 ws/grep-quiet-no-pager later to maint).

 * The prompt script (in contrib/) did not show the untracked sign
   when working in a subdirectory without any untracked files.
   (merge 9bdc517 ct/prompt-untracked-fix later to maint).

 * Code cleanups and documentation updates.
   (merge 2ce63e9 rs/simple-cleanups later to maint).
   (merge 33baa69 rj/no-xopen-source-for-cygwin later to maint).
   (merge 817d03e jc/diff-test-updates later to maint).
   (merge eb32c66 ak/t5516-typofix later to maint).
   (merge bcd57cb mr/doc-clean-f-f later to maint).
   (merge 0d6accc mg/doc-status-color-slot later to maint).
   (merge 53e53c7 sg/completion-remote later to maint).
   (merge 8fa7975 ak/git-done-help-cleanup later to maint).
   (merge 9a6f128 rs/deflate-init-cleanup later to maint).
   (merge 6f75d45 rs/use-isxdigit later to maint).
   (merge 376e4b3 jk/test-annoyances later to maint).
   (merge 7032054 nd/doc-git-index-version later to maint).
   (merge e869c5e tg/test-index-v4 later to maint).
   (merge 599d223 jk/simplify-csum-file-sha1fd-check later to maint).
   (merge 260d585 sg/completion-gitcomp-nl-for-refs later to maint).
   (merge 777c55a jc/report-path-error-to-dir later to maint).
   (merge fddfaf8 ph/push-doc-cas later to maint).
   (merge d50d31e ss/pull-rebase-preserve later to maint).
   (merge c8c3f1d pt/enter-repo-comment-fix later to maint).
   (merge d7bfb9e jz/gitweb-conf-doc-fix later to maint).
   (merge f907282 jk/cherry-pick-docfix later to maint).
   (merge d3c0811 iu/fix-parse-options-h-comment later to maint).
   (merge 6c3b2af jg/cguide-we-cannot-count later to maint).
   (merge 2b8bd44 jk/pack-corruption-post-mortem later to maint).
   (merge 9585cb8 jn/doc-fast-import-no-16-octopus-limit later to maint=
).

----------------------------------------------------------------

Changes since v2.4.0-rc1 are as follows:

Alex Henrie (2):
      l10n: ca.po: update translation
      l10n: ca.po: update translation

Alexander Shopov (1):
      l10n: Updated Bulgarian translation of git (2305t,0f,0u)

Dimitriy Ryazantcev (3):
      l10n: ru: added Russian translation
      l10n: ru: updated Russian translation
      l10n: ru: updated Russian translation

Ivan Ukhov (1):
      parse-options.h: OPTION_{BIT,SET_INT} do not store pointer to def=
val

Jean-Noel Avila (2):
      l10n: fr.po v2.4.0-rc0 round 1
      l10n: fr.po v2.4.0 round 2

Jeff King (3):
      cherry-pick: fix docs describing handling of empty commits
      howto: document more tools for recovery corruption
      merge: pass verbosity flag down to merge-recursive

Jiang Xin (5):
      l10n: git.pot: v2.4.0 round 1 (99 new, 92 removed)
      l10n: zh_CN: translations for git v2.4.0-rc0
      l10n: git.pot: v2.4.0 round 2 (1 update)
      l10n: zh_CN: for git v2.4.0 l10n round 2
      l10n: TEAMS: Change repository URL of zh_CN

John Keeping (1):
      streaming.c: fix a memleak

Jonathan Nieder (1):
      fast-import doc: remove suggested 16-parent limit

Julian Gindi (1):
      CodingGuidelines: update 'rough' rule count

Junio C Hamano (2):
      push-to-deploy: allow pushing into an unborn branch and updating =
it
      Git 2.4.0-rc2

J=C3=A9r=C3=B4me Zago (1):
      gitweb.conf.txt: say "build-time", not "built-time"

Kyle J. McKay (1):
      diff-highlight: do not split multibyte characters

Matthias R=C3=BCster (1):
      l10n: de.po: translate 'symbolic link' as 'symbolische Verkn=C3=BC=
pfung'

Michael J Gruber (1):
      l10n: de.po: fix negation for commit -a with paths

Paul Tan (1):
      enter_repo(): fix docs to match code

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (2305t0f0u)
      l10n: sv.po: Update Swedish translation (2305t0f0u)

Phillip Sz (1):
      l10n: de.po: add space before ellipsis

Ralf Thielow (3):
      l10n: de.po: fix messages with abbreviated hashs
      l10n: de.po: translate 99 new messages
      l10n: de.po: translate one message

Stefan Beller (1):
      wt-status.c: fix a memleak

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po: Updated Vietnamese translation
      l10n: vi.po(2305t): Updated 1 new string
