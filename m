From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.2
Date: Wed, 04 Mar 2009 01:23:55 -0800
Message-ID: <7veixd7iac.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 10:26:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LenMU-0007ut-Oy
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 10:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbZCDJYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 04:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZCDJYL
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 04:24:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756093AbZCDJYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 04:24:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7528E3985;
	Wed,  4 Mar 2009 04:24:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CA363984; Wed, 
 4 Mar 2009 04:23:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3466DAEA-089E-11DE-B7FC-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112192>

The latest feature release GIT 1.6.2 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS//git-*-1.6.2-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------
GIT v1.6.2 Release Notes
========================

With the next major release, "git push" into a branch that is
currently checked out will be refused by default.  You can choose
what should happen upon such a push by setting the configuration
variable receive.denyCurrentBranch in the receiving repository.

To ease the transition plan, the receiving repository of such a
push running this release will issue a big warning when the
configuration variable is missing.  Please refer to:

  http://git.or.cz/gitwiki/GitFaq#non-bare
  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

for more details on the reason why this change is needed and the
transition plan.

For a similar reason, "git push $there :$killed" to delete the branch
$killed in a remote repository $there, if $killed branch is the current
branch pointed at by its HEAD, gets a large warning.  You can choose what
should happen upon such a push by setting the configuration variable
receive.denyDeleteCurrent in the receiving repository.


Updates since v1.6.1
--------------------

(subsystems)

* git-svn updates.

* gitweb updates, including a new patch view and RSS/Atom feed
  improvements.

* (contrib/emacs) git.el now has commands for checking out a branch,
  creating a branch, cherry-picking and reverting commits; vc-git.el
  is not shipped with git anymore (it is part of official Emacs).

(performance)

* pack-objects autodetects the number of CPUs available and uses threaded
  version.

(usability, bells and whistles)

* automatic typo correction works on aliases as well

* @{-1} is a way to refer to the last branch you were on.  This is
  accepted not only where an object name is expected, but anywhere
  a branch name is expected and acts as if you typed the branch name.
  E.g. "git branch --track mybranch @{-1}", "git merge @{-1}", and
  "git rev-parse --symbolic-full-name @{-1}" would work as expected.

* When refs/remotes/origin/HEAD points at a remote tracking branch that
  has been pruned away, many git operations issued warning when they
  internally enumerated the refs.  We now warn only when you say "origin"
  to refer to that pruned branch.

* The location of .mailmap file can be configured, and its file format was
  enhanced to allow mapping an incorrect e-mail field as well.

* "git add -p" learned 'g'oto action to jump directly to a hunk.

* "git add -p" learned to find a hunk with given text with '/'.

* "git add -p" optionally can be told to work with just the command letter
  without Enter.

* when "git am" stops upon a patch that does not apply, it shows the
  title of the offending patch.

* "git am --directory=<dir>" and "git am --reject" passes these options
  to underlying "git apply".

* "git am" learned --ignore-date option.

* "git blame" aligns author names better when they are spelled in
  non US-ASCII encoding.

* "git clone" now makes its best effort when cloning from an empty
  repository to set up configuration variables to refer to the remote
  repository.

* "git checkout -" is a shorthand for "git checkout @{-1}".

* "git cherry" defaults to whatever the current branch is tracking (if
  exists) when the <upstream> argument is not given.

* "git cvsserver" can be told not to add extra "via git-CVS emulator" to
  the commit log message it serves via gitcvs.commitmsgannotation
  configuration.

* "git cvsserver" learned to handle 'noop' command some CVS clients seem
  to expect to work.

* "git diff" learned a new option --inter-hunk-context to coalesce close
  hunks together and show context between them.

* The definition of what constitutes a word for "git diff --color-words"
  can be customized via gitattributes, command line or a configuration.

* "git diff" learned --patience to run "patience diff" algorithm.

* "git filter-branch" learned --prune-empty option that discards commits
  that do not change the contents.

* "git fsck" now checks loose objects in alternate object stores, instead
  of misreporting them as missing.

* "git gc --prune" was resurrected to allow "git gc --no-prune" and
  giving non-default expiration period e.g. "git gc --prune=now".

* "git grep -w" and "git grep" for fixed strings have been optimized.

* "git mergetool" learned -y(--no-prompt) option to disable prompting.

* "git rebase -i" can transplant a history down to root to elsewhere
  with --root option.

* "git reset --merge" is a new mode that works similar to the way
  "git checkout" switches branches, taking the local changes while
  switching to another commit.

* "git submodule update" learned --no-fetch option.

* "git tag" learned --contains that works the same way as the same option
  from "git branch".


Fixes since v1.6.1
------------------

All of the fixes in v1.6.1.X maintenance series are included in this
release, unless otherwise noted.

Here are fixes that this release has, but have not been backported to
v1.6.1.X series.

* "git-add sub/file" when sub is a submodule incorrectly added the path to
  the superproject.

* "git bundle" did not exclude annotated tags even when a range given
  from the command line wanted to.

* "git filter-branch" unnecessarily refused to work when you had
  checked out a different commit from what is recorded in the superproject
  index in a submodule.

* "git filter-branch" incorrectly tried to update a nonexistent work tree
  at the end when it is run in a bare repository.

* "git gc" did not work if your repository was created with an ancient git
  and never had any pack files in it before.

* "git mergetool" used to ignore autocrlf and other attributes
  based content rewriting.

* branch switching and merges had a silly bug that did not validate
  the correct directory when making sure an existing subdirectory is
  clean.

* "git -p cmd" when cmd is not a built-in one left the display in funny state
  when killed in the middle.
