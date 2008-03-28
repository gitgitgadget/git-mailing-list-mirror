From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4.5
Date: Thu, 27 Mar 2008 23:26:41 -0700
Message-ID: <7vtzir2wke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 07:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf83w-0000hP-T6
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 07:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbYC1G07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 02:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbYC1G07
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 02:26:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYC1G05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 02:26:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 242F02E76;
	Fri, 28 Mar 2008 02:26:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8F38F2E75; Fri, 28 Mar 2008 02:26:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78387>

The latest maintenance release GIT 1.5.4.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.5-1.$arch.rpm	(RPM)

Among many fixes, a notable one is a regression we introduced in 1.5.4
that changed the behaviour of "git fetch there" when you have the URL
information for "there" in .git/branches/there.  Such a fetch should have
updated your local branch "there", but 1.5.4 and later didn't.  This
should fix the breakage.

----------------------------------------------------------------

GIT v1.5.4.5 Release Notes
==========================

Fixes since v1.5.4.4
--------------------

 * "git fetch there" when the URL information came from the Cogito style
   branches/there file did not update refs/heads/there (regression in
   1.5.4).

 * Bogus refspec configuration such as "remote.there.fetch = =" were not
   detected as errors (regressionin 1.5.4).

 * You couldn't specify a custom editor whose path contains a whitespace
   via GIT_EDITOR (and core.editor).

 * The subdirectory filter to "git filter-branch" mishandled a history
   where the subdirectory becomes empty and then later becomes non-empty.

 * "git shortlog" gave an empty line if the original commit message was
   malformed (e.g. a botched import from foreign SCM).  Now it finds the
   first non-empty line and uses it for better information.

 * When the user fails to give a revision parameter to "git svn", an error
   from the Perl interpreter was issued because the script lacked proper
   error checking.

 * After "git rebase" stopped due to conflicts, if the user played with
   "git reset" and friends, "git rebase --abort" failed to go back to the
   correct commit.

 * Additional work trees prepared with git-new-workdir (in contrib/) did
   not share git-svn metadata directory .git/svn with the original.

 * "git-merge-recursive" did not mark addition of the same path with
   different filemodes correctly as a conflict.

 * "gitweb" gave malformed URL when pathinfo stype paths are in use.

 * "-n" stands for "--no-tags" again for "git fetch".

 * "git format-patch" did not detect the need to add 8-bit MIME header
   when the user used format.header configuration.

 * "rev~" revision specifier used to mean "rev", which was inconsistent
   with how "rev^" worked.  Now "rev~" is the same as "rev~1" (hence it
   also is the same as "rev^1"), and "rev~0" is the same as "rev^0"
   (i.e. it has to be a commit).

 * "git quiltimport" did not grok empty lines, lines in "file -pNNN"
   format to specify the prefix levels and lines with trailing comments.

 * "git rebase -m" triggered pre-commit verification, which made
   "rebase --continue" impossible.

As usual, it also comes with many documentation fixes and clarifications.

----------------------------------------------------------------

Changes since v1.5.4.4 are as follows:

Andy Whitcroft (1):
      shortlog: take the first populated line of the description

Bernt Hansen (1):
      git-new-workdir: Share SVN meta data between work dirs and the repository

Brandon Casey (1):
      t/t3800-mktag.sh: use test_must_fail rather than '!'

Clemens Buchacher (1):
      merge-recursive: handle file mode changes

Daniel Barkalow (2):
      Tighten refspec processing
      Fix branches file configuration

Eric Wong (1):
      git-svn: don't blindly append '*' to branch/tags config

Guanqun Lu (1):
      Fix the wrong output of `git-show v1.3.0~155^2~4` in documentation.

Jakub Narebski (1):
      gitweb: Fix bug in href(..., -replay=>1) when using 'pathinfo' form

Jeff King (2):
      t0021: tr portability fix for Solaris
      Documentation: clarify use of .git{ignore,attributes} versus .git/info/*

Johannes Schindelin (3):
      launch_editor(): allow spaces in the filename
      git fetch: Take '-n' to mean '--no-tags'
      merge-file: handle empty files gracefully

Jonas Fonseca (1):
      Make man page building quiet when DOCBOOK_XSL_172 is defined

Junio C Hamano (9):
      filter-branch: handle "disappearing tree" case correctly in subdir filter
      git-pull documentation: warn about the option order
      quiltimport: fix misquoting of parsed -p<num> parameter
      format-patch: generate MIME header as needed even when there is format.header
      rebase -m: do not trigger pre-commit verification
      Start draft ReleaseNotes for 1.5.4.5
      git-fetch test: test tracking fetch results, not just FETCH_HEAD
      Update draft release notes for 1.5.4.5
      GIT 1.5.4.5

Linus Torvalds (1):
      rev-parse: fix meaning of rev~ vs rev~0.

Marc-Andre Lureau (2):
      git-svn: fix find-rev error message when missing arg
      git-cvsimport: fix merging with remote parent branch

Mike Hommey (1):
      git rebase --abort: always restore the right commit

Pierre Habouzit (1):
      git-quiltimport: better parser to grok "enhanced" series files.

Vineet Kumar (1):
      Minor wording changes in the keyboard descriptions in git-add --interactive.
