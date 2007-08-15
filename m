From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.2.5
Date: Wed, 15 Aug 2007 16:24:16 -0700
Message-ID: <7vr6m4mlen.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 01:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILSDz-00008W-By
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 01:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759501AbXHOXYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 19:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760620AbXHOXYX
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 19:24:23 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759438AbXHOXYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 19:24:22 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E728C122042;
	Wed, 15 Aug 2007 19:24:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55968>

The latest maintenance release GIT 1.5.2.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.2.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.2.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.2.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.2.5-1.$arch.rpm	(RPM)

Although 1.5.3 has been in -rc cycle for quite some time, there
was a rather nasty data corruption bug discovered, so here is
primarily to push that fix out.

When "git add -u $paths" records ONLY removes in a directory,
your next "git write-tree" will write out a bogus tree object
and cause your commit not to match the reality.


GIT v1.5.2.5 Release Notes
==========================

Fixes since v1.5.2.4
--------------------

 * Bugfixes

   - "git add -u" had a serious data corruption problem in one
     special case (when the changes to a subdirectory's files
     consist only deletion of files).

   - "git add -u <path>" did not work from a subdirectory.

   - "git apply" left an empty directory after all its files are
     renamed away.

   - "git $anycmd foo/bar", when there is a file 'foo' in the
     working tree, complained that "git $anycmd foo/bar --" form
     should be used to disambiguate between revs and files,
     which was completely bogus.

   - "git checkout-index" and other commands that checks out
     files to the work tree tried unlink(2) on directories,
     which is a sane thing to do on sane systems, but not on
     Solaris when you are root.

 * Documentation Fixes and Updates

   - A handful documentation fixes.

----------------------------------------------------------------

Changes since v1.5.2.4 are as follows:

Christian Couder (1):
      rev-list --bisect: fix allocation of "int*" instead of "int".

Julian Phillips (1):
      Force listingblocks to be monospaced in manpages

Junio C Hamano (4):
      Do not expect unlink(2) to fail on a directory.
      setup.c:verify_non_filename(): don't die unnecessarily while disambiguating
      Fix "git add -u" data corruption.
      GIT 1.5.2.5

Linus Torvalds (1):
      apply: remove directory that becomes empty by renaming the last file away

Salikh Zakirov (1):
      git-add -u paths... now works from subdirectory
