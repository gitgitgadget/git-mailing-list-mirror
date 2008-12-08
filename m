From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0.5
Date: Sun, 07 Dec 2008 18:13:56 -0800
Message-ID: <7vabb7ct23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 03:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9Vel-0003dh-La
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbYLHCOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2008 21:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYLHCOH
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:14:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYLHCOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2008 21:14:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25F1D182B2;
	Sun,  7 Dec 2008 21:14:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9BB517F4C; Sun, 
 7 Dec 2008 21:13:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2163894-C4CD-11DD-B8DC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102515>

The latest maintenance release GIT 1.6.0.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.5.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.5.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.0.5-1.fc9.$arch.rpm	(RPM)

Although we are into 1.6.1-rc cycle, we have accumulated enough fixes t=
o
warrant a new maintenance release, so here it is.

----------------------------------------------------------------

GIT v1.6.0.5 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.0.4
--------------------

* "git checkout" used to crash when your HEAD was pointing at a deleted
  branch.

* "git checkout" from an un-checked-out state did not allow switching o=
ut
  of the current branch.

* "git diff" always allowed GIT_EXTERNAL_DIFF and --no-ext-diff was no-=
op for
  the command.

* Giving 3 or more tree-ish to "git diff" is supposed to show the combi=
ned
  diff from second and subsequent trees to the first one, but the order=
 was
  screwed up.

* "git fast-export" did not export all tags.

* "git ls-files --with-tree=3D<tree>" did not work with options other
  than -c, most notably with -m.

* "git pack-objects" did not make its best effort to honor --max-pack-s=
ize
  option when a single first object already busted the given limit and
  placed many objects in a single pack.

* "git-p4" fast import frontend was too eager to trigger its keyword ex=
pansion
  logic, even on a keyword-looking string that does not have closing '$=
' on the
  same line.

* "git push $there" when the remote $there is defined in $GIT_DIR/branc=
hes/$there
  behaves more like what cg-push from Cogito used to work.

* when giving up resolving a conflicted merge, "git reset --hard" faile=
d
  to remove new paths from the working tree.

* "git tag" did not complain when given mutually incompatible set of op=
tions.

* The message constructed in the internal editor was discarded when "gi=
t
  tag -s" failed to sign the message, which was often caused by the use=
r
  not configuring GPG correctly.

* "make check" cannot be run without sparse; people may have meant to s=
ay
  "make test" instead, so suggest that.

* Internal diff machinery had a corner case performance bug that choked=
 on
  a large file with many repeated contents.

* "git repack" used to grab objects out of packs marked with .keep
  into a new pack.

* Many unsafe call to sprintf() style varargs functions are corrected.

* Also contains quite a few documentation updates.


----------------------------------------------------------------

Changes since v1.6.0.4 are as follows:

Alexandre Julliard (2):
      checkout: Don't crash when switching away from an invalid branch.
      git-submodule: Avoid printing a spurious message.

Brandon Casey (12):
      t7700: demonstrate mishandling of objects in packs with a .keep f=
ile
      packed_git: convert pack_local flag into a bitfield and add pack_=
keep
      pack-objects: new option --honor-pack-keep
      repack: don't repack local objects in packs with .keep file
      repack: do not fall back to incremental repacking with [-a|-A]
      builtin-gc.c: use new pack_keep bitfield to detect .keep file exi=
stence
      t7700: demonstrate mishandling of loose objects in an alternate O=
DB
      sha1_file.c: split has_loose_object() into local and non-local co=
unterparts
      pack-objects: extend --local to mean ignore non-local loose objec=
ts too
      t7700: test that 'repack -a' packs alternate packed objects
      repack: only unpack-unreachable if we are deleting redundant pack=
s
      revision.c: use proper data type in call to sizeof() within xreal=
loc

Bryan Drewery (1):
      Fix misleading wording for git-cherry-pick

Christian Couder (3):
      Documentation: rev-list: change a few instances of "git-cmd" to "=
git cmd"
      Documentation: bisect: change a few instances of "git-cmd" to "gi=
t cmd"
      Documentation: fix links to "everyday.html"

Daniel Lowe (1):
      Fix non-literal format in printf-style calls

Davide Libenzi (1):
      xdiff: give up scanning similar lines early

Jakub Narebski (1):
      gitweb: Make project specific override for 'grep' feature work

Jan Kr=C3=BCger (1):
      Documentation: git-svn: fix example for centralized SVN clone

Jeff King (2):
      commit: Fix stripping of patch in verbose mode.
      tag: delete TAG_EDITMSG only on successful tag

Joey Hess (1):
      sha1_file: avoid bogus "file exists" error message

Johannes Schindelin (1):
      fast-export: use an unsorted string list for extra_refs

Johannes Sixt (1):
      compat/mingw.c: Teach mingw_rename() to replace read-only files

Junio C Hamano (8):
      Makefile: help people who run 'make check' by mistake
      checkout: Fix "initial checkout" detection
      Start 1.6.0.5 cycle
      builtin-ls-files.c: coding style fix.
      Teach ls-files --with-tree=3D<tree> to work with options other th=
an -c
      Teach "git diff" to honour --[no-]ext-diff
      Update draft release notes to 1.6.0.5
      GIT 1.6.0.5

Linus Torvalds (1):
      date/time: do not get confused by fractional seconds

Martin Koegler (1):
      git push: Interpret $GIT_DIR/branches in a Cogito compatible way

Matt Kraai (1):
      Remove the period after the git-check-attr summary

Matt McCutchen (3):
      config.txt: alphabetize configuration sections
      git checkout: don't warn about unborn branch if -f is already pas=
sed
      "git diff <tree>{3,}": do not reverse order of arguments

Miklos Vajna (3):
      Add new testcase to show fast-export does not always exports all =
tags
      User's Manual: remove duplicated url at the end of Appendix B
      http.c: use 'git_config_string' to get 'curl_http_proxy'

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      generate-cmdlist.sh: avoid selecting synopsis at wrong place

Nicolas Pitre (1):
      Fix pack.packSizeLimit and --max-pack-size handling

Pete Wyckoff (1):
      git-p4: fix keyword-expansion regex

Ralf Wildenhues (1):
      Fix typos in the documentation.

SZEDER G=C3=A1bor (2):
      bash: remove dashed command leftovers
      bash: offer refs instead of filenames for 'git revert'

Sam Vilain (1):
      sha1_file.c: resolve confusion EACCES vs EPERM

Samuel Tardieu (2):
      tag: Check that options are only allowed in the appropriate mode
      tag: Add more tests about mixing incompatible modes and options

Stefan Naewe (2):
      git ls-remote: make usage string match manpage
      request-pull: make usage string match manpage

Thomas Rast (1):
      fetch-pack: Avoid memcpy() with src=3D=3Ddst
