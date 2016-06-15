From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.1-rc0
Date: Mon, 03 Dec 2012 13:09:11 -0800
Message-ID: <7vip8iq1vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Dec 03 22:09:42 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TfdGl-0001Hf-BA
	for glk-linux-kernel-3@plane.gmane.org; Mon, 03 Dec 2012 22:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab2LCVJT (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 3 Dec 2012 16:09:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab2LCVJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Dec 2012 16:09:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BECA9729;
	Mon,  3 Dec 2012 16:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	5l1wQOBkdewUPkvgQmsnSj1vLo=; b=hGSdO488WLYnF7h9Z7wtzQdFeBefYkeeB
	vi0DHZ3ph++e5S/pW3FXGiVkS9x+rIbSv3lIvB8h8Nm3SMORwB+b8hRsw05dK14r
	veZ3F85H1qO7xD5kxhRbrWhUcOejOMyHUOrbEIPoaHFH0N49IdxFHwkxikWYw+Te
	du7KIiScPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=d5SkcYX3va993T0JaJubeZy/GKgYUib+bxbeVa8KvIyPnKqD/6CA5pT5
	vIx3F/1ZJX0FXtK94g8obRNB6e6AgkXexqwpuDIMy1bIwq02jx7QPu/+n33OkUXy
	A1Rj2MXp8uOUCFRA8vPN4NQYgDFopupRA85ylPDTbgmnBtKLH80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 085AD9728;
	Mon,  3 Dec 2012 16:09:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7FFA9723; Mon,  3 Dec 2012
 16:09:12 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0274174-3D8D-11E2-AE31-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211059>

A release candidate preview, Git v1.8.1-rc0, is now available for
testing at the usual places.

This cycle has been a bit slow (perhaps because it had a major US
holiday to slow people down) but we seem to have managed to apply
reasonably large number of usability improvement changes, with a
handful of new features.  There are several new and large-ish topics
that are cooking in 'next', but I think we would better keep them
cooking there without merging them to 'master' before the upcoming
release to happen before the year end.  So as far as features goes,
this preview release is pretty much *it*.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

39faaa15bc71f8eb52048e77ea564cecf78c7adf  git-1.8.1.rc0.tar.gz
2eeba24488337de02b58dc442258d58b79e2b8f4  git-htmldocs-1.8.1.rc0.tar.gz
b28d1f8e8b9268b712b33fbdfb67dd6f14afb499  git-manpages-1.8.1.rc0.tar.gz

Also the following public repositories all have a copy of the v1.8.1-rc0
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.8.1 Release Notes (draft)
========================

Backward compatibility notes
----------------------------

In the next major release (not *this* one), we will change the
behavior of the "git push" command.

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  We will use the "simple" semantics that pushes the
current branch to the branch with the same name, only when the current
branch is set to integrate with that remote branch.  There is a user
preference configuration variable "push.default" to change this, and
"git push" will warn about the upcoming change until you set this
variable in this release.

"git branch --set-upstream" is deprecated and may be removed in a
relatively distant future.  "git branch [-u|--set-upstream-to]" has
been introduced with a saner order of arguments to replace it.


Updates since v1.8.0
--------------------

UI, Workflows & Features

 * Command-line completion scripts for tcsh and zsh have been added.

 * A new remote-helper interface for Mercurial has been added to
   contrib/remote-helpers.

 * We used to have a workaround for a bug in ancient "less" that
   causes it to exit without any output when the terminal is resized.
   The bug has been fixed in "less" version 406 (June 2007), and the
   workaround has been removed in this release.

 * Some documentation pages that used to ship only in the plain text
   format are now formatted in HTML as well.

 * "git-prompt" scriptlet (in contrib/completion) can be told to paint
   pieces of the hints in the prompt string in colors.

 * A new configuration variable "diff.context" can be used to
   give the default number of context lines in the patch output, to
   override the hardcoded default of 3 lines.

 * When "git checkout" checks out a branch, it tells the user how far
   behind (or ahead) the new branch is relative to the remote tracking
   branch it builds upon.  The message now also advises how to sync
   them up by pushing or pulling.  This can be disabled with the
   advice.statusHints configuration variable.

 * "git config --get" used to diagnose presence of multiple
   definitions of the same variable in the same configuration file as
   an error, but it now applies the "last one wins" rule used by the
   internal configuration logic.  Strictly speaking, this may be an
   API regression but it is expected that nobody will notice it in
   practice.

 * "git log -p -S<string>" now looks for the <string> after applying
   the textconv filter (if defined); earlier it inspected the contents
   of the blobs without filtering.

 * "git format-patch" learned the "--notes=<ref>" option to give
   notes for the commit after the three-dash lines in its output.

 * "git log --grep=<pcre>" learned to honor the "grep.patterntype"
   configuration set to "perl".

 * "git replace -d <object>" now interprets <object> as an extended
   SHA-1 (e.g. HEAD~4 is allowed), instead of only accepting full hex
   object name.

 * "git rm $submodule" used to punt on removing a submodule working
   tree to avoid losing the repository embedded in it.  Because
   recent git uses a mechanism to separate the submodule repository
   from the submodule working tree, "git rm" learned to detect this
   case and removes the submodule working tree when it is safe to do so.

 * "git send-email" used to prompt for the sender address, even when
   the committer identity is well specified (e.g. via user.name and
   user.email configuration variables).  The command no longer gives
   this prompt when not necessary.

 * "git send-email" did not allow non-address garbage strings to
   appear after addresses on Cc: lines in the patch files (and when
   told to pick them up to find more recipients), e.g.

     Cc: Stable Kernel <stable@k.org> # for v3.2 and up

   The command now strips " # for v3.2 and up" part before adding the
   remainder of this line to the list of recipients.

 * "git submodule add" learned to add a new submodule at the same
   path as the path where an unrelated submodule was bound to in an
   existing revision via the "--name" option.

 * "git submodule sync" learned the "--recursive" option.

 * "diff.submodule" configuration variable can be used to give custom
   default value to the "git diff --submodule" option.

 * "git symbolic-ref" learned the "-d $symref" option to delete the
   named symbolic ref, which is more intuitive way to spell it than
   "update-ref -d --no-deref $symref".


Foreign Interface

 * "git cvsimport" can be told to record timezones (other than GMT)
   per-author via its author info file.

 * The remote helper interface to interact with subversion
   repositories (one of the GSoC 2012 projects) has been merged.


Performance, Internal Implementation, etc.

 * Compilation on Cygwin with newer header files are supported now.

 * The logic to generate the initial advertisement from "upload-pack"
   (i.e. what is invoked by "git fetch" on the other side of the
   connection) to list what refs are available in the repository has
   been optimized.

 * The logic to find set of attributes that match a given path has
   been optimized.

 * Use preloadindex in "git diff-index" and "git update-index", which
   has a nice speedup on systems with slow stat calls (and even on
   Linux).


Also contains minor documentation updates and code clean-ups.


Fixes since v1.8.0
------------------

Unless otherwise noted, all the fixes since v1.8.0 in the maintenance
track are contained in this release (see release notes to them for
details).

 * The configuration parser had an unnecessary hardcoded limit on
   variable names that was not checked consistently.
   (merge 0971e99 bw/config-lift-variable-name-length-limit later to maint).

 * The "say" function in the test scaffolding incorrectly allowed
   "echo" to interpret "\a" as if it were a C-string asking for a
   BEL output.
   (merge 7bc0911 jc/test-say-color-avoid-echo-escape later to maint).

 * "git mergetool" feeds /dev/null as a common ancestor when dealing
   with an add/add conflict, but p4merge backend cannot handle
   it. Work it around by passing a temporary empty file.
   (merge 3facc60 da/mergetools-p4 later to maint).

 * "git log -F -E --grep='<ere>'" failed to use the given <ere>
   pattern as extended regular expression, and instead looked for the
   string literally.
   (merge 727b6fc jc/grep-pcre-loose-ends~1 later to maint).

 * "git grep -e pattern <tree>" asked the attribute system to read
   "<tree>:.gitattributes" file in the working tree, which was
   nonsense.
   (merge 55c6168 nd/grep-true-path later to maint).

 * A symbolic ref refs/heads/SYM was not correctly removed with "git
   branch -d SYM"; the command removed the ref pointed by SYM
   instead.
   (merge 13baa9f rs/branch-del-symref later to maint).

 * Update "remote tracking branch" in the documentation to
   "remote-tracking branch".
   (merge a6d3bde mm/maint-doc-remote-tracking later to maint).

 * "git pull --rebase" run while the HEAD is detached tried to find
   the upstream branch of the detached HEAD (which by definition
   does not exist) and emitted unnecessary error messages.
   (merge e980765 ph/pull-rebase-detached later to maint).

 * The refs/replace hierarchy was not mentioned in the
   repository-layout docs.
   (merge 11fbe18 po/maint-refs-replace-docs later to maint).

 * Various rfc2047 quoting issues around a non-ASCII name on the
   From: line in the output from format-patch have been corrected.
   (merge 25dc8da js/format-2047 later to maint).

 * Sometimes curl_multi_timeout() function suggested a wrong timeout
   value when there is no file descriptor to wait on and the http
   transport ended up sleeping for minutes in select(2) system call.
   A workaround has been added for this.
   (merge 7202b81 sz/maint-curl-multi-timeout later to maint).

 * For a fetch refspec (or the result of applying wildcard on one),
   we always want the RHS to map to something inside "refs/"
   hierarchy, but the logic to check it was not exactly right.
   (merge 5c08c1f jc/maint-fetch-tighten-refname-check later to maint).

 * "git diff -G<pattern>" did not honor textconv filter when looking
   for changes.
   (merge b1c2f57 jk/maint-diff-grep-textconv later to maint).

 * Some HTTP servers ask for auth only during the actual packing phase
   (not in ls-remote phase); this is not really a recommended
   configuration, but the clients used to fail to authenticate with
   such servers.
   (merge 2e736fd jk/maint-http-half-auth-fetch later to maint).

 * "git p4" used to try expanding malformed "$keyword$" that spans
   across multiple lines.
   (merge 6b2bf41 pw/maint-p4-rcs-expansion-newline later to maint).

 * Syntax highlighting in "gitweb" was not quite working.
   (merge 048b399 rh/maint-gitweb-highlight-ext later to maint).

 * RSS feed from "gitweb" had a xss hole in its title output.
   (merge 0f0ecf6 jk/maint-gitweb-xss later to maint).

 * "git config --path $key" segfaulted on "[section] key" (a boolean
   "true" spelled without "=", not "[section] key = true").
   (merge 962c38e cn/config-missing-path later to maint).

 * "git checkout -b foo" while on an unborn branch did not say
   "Switched to a new branch 'foo'" like other cases.
   (merge afa8c07 jk/checkout-out-of-unborn later to maint).

 * We failed to mention a file without any content change but whose
   permission bit was modified, or (worse yet) a new file without any
   content in the "git diff --stat" output.
   (merge de9095955 lt/diff-stat-show-0-lines later to maint).

 * When "--stat-count" hides a diffstat for binary contents, the total
   number of added and removed lines at the bottom was computed
   incorrectly.
   (merge de9095955 lt/diff-stat-show-0-lines later to maint).

 * When "--stat-count" hides a diffstat for unmerged paths, the total
   number of affected files at the bottom of the "diff --stat" output
   was computed incorrectly.
   (merge de9095955 lt/diff-stat-show-0-lines later to maint).

 * "diff --shortstat" miscounted the total number of affected files
   when there were unmerged paths.
   (merge de9095955 lt/diff-stat-show-0-lines later to maint).

 * "update-ref -d --deref SYM" to delete a ref through a symbolic ref
   that points to it did not remove it correctly.
   (merge b274a71 jh/update-ref-d-through-symref later to maint).
