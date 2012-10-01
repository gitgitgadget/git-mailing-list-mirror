From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.0-rc0
Date: Mon, 01 Oct 2012 15:44:56 -0700
Message-ID: <7vwqz9ak2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 02 00:45:35 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TIojn-0007Qg-RU
	for glk-linux-kernel-3@plane.gmane.org; Tue, 02 Oct 2012 00:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab2JAWpD (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 1 Oct 2012 18:45:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004Ab2JAWpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Oct 2012 18:45:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FD8E9AC6;
	Mon,  1 Oct 2012 18:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	4xXOnNxEXUX3lqXUNF/IN8kopQ=; b=PHZC79MdxH3aKG/Blovkqonr4IgXU+nLN
	WsL1ZiO+XGN5vOxcew4+0kOkl89DRuEuGtWEJZwQdkXf5CpnmjptcWP3v8kHAIqj
	eqP9EFPZ+Yaw5/PcEGGEU8v+s6pzYTESNSLCoWwwskNQX7xNZotE8jdy8ThAWE0/
	BkRwj9OmPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=MXEcxR1/QULgPOS+EFNIgbmnTilsHJU3N5qyXEBxwQ7gj+kUw8NHV7L3
	HGqkwDljUMx0OY/eTab1+UzDL1O6krcBlI2MFaO2/bgqS1UiKgeLbzbmVZ7loj+I
	9NIXUrx+WoZaSKjFkD7x6QELsciZ27pnLaR+QS6w5Oe8YFs7+8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5309AC5;
	Mon,  1 Oct 2012 18:44:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21C3B9AC2; Mon,  1 Oct 2012
 18:44:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0871942-0C19-11E2-95FF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206776>

A release candidate Git v1.8.0-rc0 is now available for testing at
the usual places.  There are a couple of leftover features we might
merge before the final release, but other than that, this is meant
to be more or less feature-complete preview of the upcoming 1.8.0.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

a5143163b9d17e1afd7e66d7c6e7457c2e09a022  git-1.8.0.rc0.tar.gz
679891dad4b0168ddd618c1de05978e35189c1bf  git-htmldocs-1.8.0.rc0.tar.gz
eab59abd44a941e382eca6ae5e1d357b337328d0  git-manpages-1.8.0.rc0.tar.gz

Also the following public repositories all have a copy of the v1.8.0-rc0
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.8.0 Release Notes (draft)
========================

Backward compatibility notes
----------------------------

In the next major release, we will change the behaviour of the "git
push" command.  When "git push [$there]" does not say what to push, we
have used the traditional "matching" semantics (all your branches were
sent to the remote as long as there already are branches of the same
name over there).  We will use the "simple" semantics, that pushes the
current branch to the branch with the same name only when the current
branch is set to integrate with that remote branch.  There is a user
preference configuration variable "push.default" to change this, and
"git push" will warn about the upcoming change until you set this
variable.

"git branch --set-upstream" is deprecated and may be removed in a
relatively distant future.  "git branch [-u|--set-upstream-to]" has
been introduced with a saner order of arguments.


Updates since v1.7.12
---------------------

UI, Workflows & Features

 * A credential helper for Win32 to allow access to the keychain of
   the logged-in user has been added.

 * An initial port to HP NonStop.

 * A credential helper to allow access to the Gnome keyring has been
   added.

 * When "git am" sanitizes the Subject: line, we strip the prefix from
   "Re: subject" and also from a less common "re: subject", but left
   even less common "RE: subject" intact.

 * It was tempting to say "git branch --set-upstream origin/master",
   but that tells Git to arrange the local branch "origin/master" to
   integrate with the currently checked out branch, which is highly
   unlikely what the user meant.  The option is deprecated; use the
   new "--set-upstream-to" (with a short-and-sweet "-u") option
   instead.

 * "git cherry-pick" learned the "--allow-empty-message" option to
   allow it to replay a commit without any log message.

 * After "git cherry-pick -s" gave control back to the user asking
   help to resolve conflicts, concluding "git commit" used to need to
   be run with "-s" if the user wants to sign it off; now the command
   leaves the sign-off line in the log template.

 * "git daemon" learned the "--access-hook" option to allow an
   external command to decline service based on the client address,
   repository path, etc.

 * "git difftool --dir-diff" learned to use symbolic links to prepare
   temporary copy of the working tree when available.

 * "git grep" learned to use a non-standard pattern type by default if
   a configuration variable tells it to.

 * "git merge-base" learned "--is-ancestor A B" option to tell if A is
   an ancestor of B.  The result is indicated by its exit status code.

 * "git mergetool" allows users to override the actual command used
   with the mergetool.$name.cmd configuration variable even for built-in
   mergetool backends.

 * The "-Xours" backend option to "git merge -s recursive" now takes
   effect even on binary files.

 * "git rebase -i" learned the "--edit-todo" option to open an editor
   to edit the insn sheet.


Foreign Interface

 * "git svn" has been updated to work with SVN 1.7.

 * "git p4" learned "--conflicts" option to specify what to do when
   encountering a conflict during "p4 submit".


Performance, Internal Implementation, etc. (please report possible regressions)

 * Git ships with a fall-back regexp implementation for platforms with
   buggy regexp library, but it was easy for people to keep using their
   platform regexp.  A new test has been added to check this.

 * The "check-docs" build target has been updated and greatly
   simplified.

 * The test suite is run under MALLOC_CHECK_ when running with glibc
   that supports the feature.

 * The documentation in the TeXinfo format was using indented output
   for materials meant to be examples that are better typeset in
   monospace.

 * Compatibility wrapper around some mkdir(2) implementations that
   reject parameter with trailing slash has been introduced.

 * Compatibility wrapper for systems that lack usable setitimer() has
   been added.

 * The option parsing of "git checkout" had error checking, dwim and
   defaulting missing options, all mixed in the code, and issuing an
   appropriate error message with useful context was getting harder.
   The code has been reorganized to allow giving a proper diagnosis
   when the user says "git checkout -b -t foo bar" (e.g. "-t" is not a
   good name for a branch).

 * Many internal uses of "git merge-base" equivalent were only to see
   if one commit fast-forwards to the other, which did not need the
   full set of merge bases to be computed. They have been updated to
   use less expensive checks.

 * The heuristics to detect and silently convert latin1 to utf8 when
   we were told to use utf-8 in the log message has been transplanted
   from "mailinfo" to "commit" and "commit-tree".

 * Messages given by "git <subcommand> -h" from many subcommands have
   been marked for translation.


Also contains minor documentation updates and code clean-ups.


Fixes since v1.7.12
-------------------

Unless otherwise noted, all the fixes since v1.7.12 in the
maintenance track are contained in this release (see release notes
to them for details).

 * The attribute system may be asked for a path that itself or its
   leading directories no longer exists in the working tree, and it is
   fine if we cannot open .gitattribute file in such a case.  Failure
   to open per-directory .gitattributes with error status other than
   ENOENT and ENOTDIR should be diagnosed, but it wasn't.

 * When looking for $HOME/.gitconfig etc., it is OK if we cannot read
   them because they do not exist, but we did not diagnose existing
   files that we cannot read.

 * When "git am" is fed an input that has multiple "Content-type: ..."
   header, it did not grok charset= attribute correctly.

 * "git blame MAKEFILE" run in a history that has "Makefile" but not
   "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
   confused on a case insensitive filesystem and failed to do so.

 * Even during a conflicted merge, "git blame $path" always meant to
   blame uncommitted changes to the "working tree" version; make it
   more useful by showing cleanly merged parts as coming from the other
   branch that is being merged.

 * It was unclear in the documentation for "git blame" that it is
   unnecessary for users to use the "--follow" option.
   (merge e5dce96 jc/blame-follows-renames later to maint).

 * Output from "git branch -v" contains "(no branch)" that could be
   localized, but the code to align it along with the names of
   branches were counting in bytes, not in display columns.

 * "git cherry-pick A C B" used to replay changes in A and then B and
   then C if these three commits had committer timestamps in that
   order, which is not what the user who said "A C B" naturally
   expects.

 * A repository created with "git clone --single" had its fetch
   refspecs set up just like a clone without "--single", leading the
   subsequent "git fetch" to slurp all the other branches, defeating
   the whole point of specifying "only this branch".
   (merge 31b808a rt/maint-clone-single later to maint).

 * Documentation talked about "first line of commit log" when it meant
   the title of the commit.  The description was clarified by defining
   how the title is decided and rewording the casual mention of "first
   line" to "title".

 * "git cvsimport" did not thoroughly cleanse tag names that it
   inferred from the names of the tags it obtained from CVS, which
   caused "git tag" to barf and stop the import in the middle.

 * Earlier we made the diffstat summary line that shows the number of
   lines added/deleted localizable, but it was found irritating having
   to see them in various languages on a list whose discussion language
   is English.

 * "git fetch --all", when passed "--no-tags", did not honor the
   "--no-tags" option while fetching from individual remotes (the same
   issue existed with "--tags", but combination "--all --tags" makes
   much less sense than "--all --no-tags").

 * "git fetch" over http had an old workaround for an unlikely server
   misconfiguration; it turns out that this hurts debuggability of the
   configuration in general, and has been reverted.
   (merge 6ac964a sp/maint-http-info-refs-no-retry later to maint).

 * "git fetch" over http advertised that it supports "deflate", which
   is much less common, and did not advertise more common "gzip" on
   its Accept-Encoding header.
   (merge aa90b96 sp/maint-http-enable-gzip later to maint).

 * After "gitk" showed the contents of a tag, neither "Reread
   references" nor "Reload" did not update what is shown as the
   contents of it, when the user overwrote the tag with "git tag -f".

 * "git log --all-match --grep=A --grep=B" ought to show commits that
   mention both A and B, but when these three options are used with
   --author or --committer, it showed commits that mention either A or
   B (or both) instead.

 * "git p4", when "--use-client-spec" and "--detect-branches" are used
   together, misdetected branches.

 * "git receive-pack" (the counterpart to "git push") did not give
   progress output while processing objects it received to the puser
   when run over the smart-http protocol.
   (merge 74eb32d jk/receive-pack-unpack-error-to-pusher later to maint).

 * When you misspell the command name you give to the "exec" action in
   the "git rebase -i" insn sheet, you are told that 'rebase' is not a
   git subcommand from "git rebase --continue".

 * The subcommand in "git remote" to remove a defined remote was
   "rm" and the command did not take a fully-spelled "remove".

 * The interactive prompt "git send-email" gives was error prone. It
   asked "What e-mail address do you want to use?" with the address it
   guessed (correctly) the user would want to use in its prompt,
   tempting the user to say "y". But the response was taken as "No,
   please use 'y' as the e-mail address instead", which is most
   certainly not what the user meant.

 * "git show --format='%ci'" did not give timestamp correctly for
   commits created without human readable name on "committer" line.

 * "git show --quiet" ought to be a synonym for "git show -s", but
   wasn't.

 * "git submodule frotz" was not diagnosed as "frotz" being an unknown
   subcommand to "git submodule"; the user instead got a complaint
   that "git submodule status" was run with an unknown path "frotz".
   (merge af9c9f9 rr/maint-submodule-unknown-cmd later to maint).

 * "git status" honored the ignore=dirty settings in .gitmodules but
   "git commit" didn't.
   (merge 8f6811e os/commit-submodule-ignore later to maint).
