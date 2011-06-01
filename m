From: Junio C Hamano <gitster@pobox.com>
Subject: Git 1.7.6-rc0
Date: Wed, 01 Jun 2011 16:03:13 -0700
Message-ID: <7v39jtf93i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 01:03:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRuRj-0007Yk-Lp
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 01:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab1FAXDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 19:03:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932620Ab1FAXDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 19:03:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8B4B4BFC;
	Wed,  1 Jun 2011 19:05:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=X
	OqqPzZ7kyd0c3r8b1Cr03MU6Wc=; b=XxquObqXKd5ikaTdMJlW/r8WZiIouP8Dz
	roPyj62ePrKGMNEBqhgxDn6OJuWKlp8ks2nim+Qz4QWU/Cdv0A2iK4J1VSAlfDjy
	zDpezbFr2CC9M+wyk6ixs5x6NsCxwzlnl0Lg1uMiPrpF4ilyQsLx2ZaDcG5c8AjQ
	jEdfKqJatg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KGn
	EBvdIlT+N/u3au9TxBfGhoJ/mZP1JINcU/T4spZ+bYnTH46qB1D3MGhJoolCmE4V
	BAJPvkGr9mKQSK3y03XcaW9TqUtFuZdi5ClTcvipNi6m4q2JAO3PhmFzopp9YLoX
	7c3KTQWjVE2Vu8CRxyx0E/x+Zh25uTuXT5pKGjZ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 950A54BFA;
	Wed,  1 Jun 2011 19:05:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CEBE4BF9; Wed,  1 Jun 2011
 19:05:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A28299CA-8CA3-11E0-B5D9-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174919>

I just tagged and pushed out the rc0 for this cycle.

It is likely that we would merge a few more topics (namely, "'status -z'
defaults to the porcelain format and "'diff -q --diff-filter=A' should not
stop too early"), but other than that, from here on, I'd like to stop
merging anything to "master" that is not a fix to regressions since 1.7.5
until the final release.

Please switch to the tip of 'master' for your daily use so that we can
ship 1.7.6 without regressions and bugs in new features.

Thanks.

----------------------------------------------------------------

Git v1.7.6 Release Notes (draft)
========================

Updates since v1.7.5
--------------------

 * Various git-svn updates.

 * Updates the way content tags are handled in gitweb.  Also adds
   a UI to choose common timezone for displaying the dates.

 * Similar to branch names, tagnames that begin with "-" are now
   disallowed.

 * Clean-up of the C part of i18n (but not l10n---please wait)
   continues.

 * The scripting part of the codebase is getting prepared for i18n/l10n.

 * Pushing and pulling from a repository with large number of refs that
   point to identical commits are optimized by not listing the same commit
   during the common ancestor negotiation exchange with the other side.

 * Adding a file larger than core.bigfilethreshold (defaults to 1/2 Gig)
   using "git add" will send the contents straight to a packfile without
   having to hold it and its compressed representation both at the same
   time in memory.

 * Processes spawned by "[alias] <name> = !process" in the configuration
   can inspect GIT_PREFIX environment variable to learn where in the
   working tree the original command was invoked.

 * A magic pathspec ":/" tells a command that limits its operation to
   the current directory when ran from a subdirectory to work on the
   entire working tree. In general, ":/path/to/file" would be relative
   to the root of the working tree hierarchy.

   After "git reset --hard; edit Makefile; cd t/", "git add -u" would
   be a no-op, but "git add -u :/" would add the updated contents of
   the Makefile at the top level. If you want to name a path in the
   current subdirectory whose unusual name begins with ":/", you can
   name it by "./:/that/path" or by "\:/that/path".

 * "git blame" learned "--abbrev[=<n>]" option to control the minimum
   number of hexdigits shown for commit object names.

 * "git blame" learned "--line-porcelain" that is less efficient but is
   easier to parse.

 * Aborting "git commit --interactive" discards updates to the index
   made during the interctive session.

 * "git commit" learned a "--patch" option to directly jump to the
   per-hunk selection UI of the interactive mode.

 * "git diff" and its family of commands learned --dirstat=0 to show
   directories that contribute less than 0.1% of changes.

 * "git diff" and its family of commands learned --dirstat=lines mode to
   assess damage to the directory based on number of lines in the patch
   output, not based on the similarity numbers.

 * "git format-patch" learned "--quiet" option to suppress the output of
   the names of generated files.

 * "git format-patch" quotes people's names when it has RFC822 special
   characters in it, e.g. "Junio C. Hamano" <jch@example.com>.  Earlier
   it was up to the user to do this when using its output.

 * "git format-patch" can take an empty --subject-prefix now.

 * "git log" and friends learned a new "--notes" option to replace the
   "--show-notes" option.  Unlike "--show-notes", "--notes=<ref>" does
   not imply showing the default notes.

 * They also learned a log.abbrevCommit configuration variable to augment
   the --abbrev-commit command line option.

 * "git ls-remote" learned "--exit-code" option to consider it a
   different kind of error when no remote ref to be shown.

 * "git merge" learned "-" as a short-hand for "the previous branch", just
   like the way "git checkout -" works.

 * "git merge" uses "merge.ff" configuration variable to decide to always
   create a merge commit (i.e. --no-ff, aka merge.ff=no), refuse to create
   a merge commit (i.e. --ff-only, aka merge.ff=only). Setting merge.ff=yes
   (or not setting it at all) restores the default behaviour of allowing
   fast-forward to happen when possible.

 * p4-import (from contrib) learned a new option --preserve-user.

 * "git read-tree -m" learned "--dry-run" option that reports if a merge
   would fail without touching the index nor the working tree.

 * "git rebase" that does not specify on top of which branch to rebase
   the current branch now uses @{upstream} of the current branch.

 * "git rebase" finished either normally or with --abort did not
   update the reflog for HEAD to record the event to come back to
   where it started from.

 * "git remote add -t only-this-branch --mirror=fetch" is now allowed. Earlier
   a fetch-mode mirror meant mirror everything, but now it only means refs are
   not renamed.

 * "git rev-list --count" used with "--cherry-mark" counts the cherry-picked
   commits separately, producing more a useful output.

 * "git submodule update" learned "--force" option to get rid of local
   changes in submodules and replace them with the up-to-date version.

 * "git status" and friends ignore .gitmodules file while the file is
   still in a conflicted state during a merge, to avoid using information
   that is not final and possibly corrupt with conflict markers.

Also contains various documentation updates and minor miscellaneous
changes.


Fixes since v1.7.5
------------------

Unless otherwise noted, all the fixes in 1.7.5.X maintenance track are
included in this release.

 * "git config" used to choke with an insanely long line.
   (merge ef/maint-strbuf-init later)

---
exec >/var/tmp/1
echo O=$(git describe master)
O=v1.7.5.3-365-g7eacc2b
git shortlog --no-merges ^maint ^$O master
