From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1.2
Date: Thu, 29 Jan 2009 02:16:25 -0800
Message-ID: <7vtz7ifmdi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 11:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSTyD-0004rV-G9
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 11:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbZA2KQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jan 2009 05:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbZA2KQf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 05:16:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZA2KQe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 05:16:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 341D295F75;
	Thu, 29 Jan 2009 05:16:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A882395F74; Thu,
 29 Jan 2009 05:16:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7257C48-EDED-11DD-AF4E-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107652>

The latest maintenance release GIT 1.6.1.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.1.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.1.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.1.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.1.2-1.fc9.$arch.rpm	(RPM)

People with 1.6.1 or 1.6.1.1, who push into a repository that borrows
objects from other repositories via "alternates" mechanism (most of the
linux kernel subsystems hosted on k.org, and "forks" on various public
hosting site such as repo.or.cz and github fall into this category), ma=
y
want to upgrade to this version, as these two versions have a buggy "gi=
t
push" that does not like such a repository served by git 1.6.1 or newer=
=2E


GIT v1.6.1.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.1.1
--------------------

* The logic for rename detectin in internal diff used by commands like
  "git diff" and "git blame" have been optimized to avoid loading the s=
ame
  blob repeatedly.

* We did not allow writing out a blob that is larger than 2GB for no go=
od
  reason.

* "git format-patch -o $dir", when $dir is a relative directory, used i=
t
  as relative to the root of the work tree, not relative to the current
  directory.

* v1.6.1 introduced an optimization for "git push" into a repository (A=
)
  that borrows its objects from another repository (B) to avoid sending
  objects that are available in repository B, when they are not yet use=
d
  by repository A.  However the code on the "git push" sender side was
  buggy and did not work when repository B had new objects that are not
  known by the sender.  This caused pushing into a "forked" repository
  served by v1.6.1 software using "git push" from v1.6.1 sometimes did =
not
  work.  The bug was purely on the "git push" sender side, and has been
  corrected.

* "git status -v" did not paint its diff output in colour even when
  color.ui configuration was set.

* "git ls-tree" learned --full-tree option to help Porcelain scripts th=
at
  want to always see the full path regardless of the current working
  directory.

* "git grep" incorrectly searched in work tree paths even when they are
  marked as assume-unchanged.  It now searches in the index entries.

* "git gc" with no grace period needlessly ejected packed but unreachab=
le
  objects in their loose form, only to delete them right away.

----------------------------------------------------------------

Changes since v1.6.1.1 are as follows:

Bj=C3=B6rn Steinbrink (1):
      Rename detection: Avoid repeated filespec population

Jeff King (1):
      avoid 31-bit truncation in write_loose_object

Johannes Schindelin (2):
      get_sha1_basic(): fix invalid memory access, found by valgrind
      test-path-utils: Fix off by one, found by valgrind

Junio C Hamano (4):
      ls-tree: add --full-tree option
      Teach format-patch to handle output directory relative to cwd
      send-pack: do not send unknown object name from ".have" to pack-o=
bjects
      GIT 1.6.1.2

Marcel M. Cary (1):
      git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on=
 OS X

Markus Heidelberg (2):
      git-commit: color status output when color.ui is set
      git-status -v: color diff output when color.ui is set

Nanako Shiraishi (1):
      Document git-ls-tree --full-tree

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      grep: support --no-ext-grep to test builtin grep
      grep: grep cache entries if they are "assume unchanged"

Nicolas Pitre (1):
      objects to be pruned immediately don't have to be loosened
