From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4.4
Date: Sun, 09 Mar 2008 03:46:12 -0700
Message-ID: <7vr6eknpjf.fsf@gitster.siamese.dyndns.org>
References: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 11:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYJ3e-0003xw-Nm
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 11:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYCIKq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2008 06:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYCIKq2
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 06:46:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbYCIKq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2008 06:46:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DEA7524BF;
	Sun,  9 Mar 2008 06:46:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8BC5624BE; Sun,  9 Mar 2008 06:46:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76649>

The latest maintenance release GIT 1.5.4.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.4-1.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.5.4.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.4.3
--------------------

 * Building and installing with an overtight umask such as 077 made
   installed templates unreadable by others, while the rest of the inst=
all
   are done in a way that is friendly to umask 022.

 * "git cvsexportcommit -w $cvsdir" misbehaved when GIT_DIR is set to a
   relative directory.

 * "git http-push" had an invalid memory access that could lead it to
   segfault.

 * When "git rebase -i" gave control back to the user for a commit that=
 is
   marked to be edited, it just said "modify it with commit --amend",
   without saying what to do to continue after modifying it.  Give an
   explicit instruction to run "rebase --continue" to be more helpful.

 * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply-To: header=
=2E

 * "git bisect" showed mysterious "won't bisect on seeked tree" error m=
essage.
   This was leftover from Cogito days to prevent "bisect" starting from=
 a
   cg-seeked state.  We still keep the Cogito safety, but running "git =
bisect
   start" when another bisect was in effect will clean up and start ove=
r.

 * "git push" with an explicit PATH to receive-pack did not quite work =
if
   receive-pack was not on usual PATH.  We earlier fixed the same issue
   with "git fetch" and upload-pack, but somehow forgot to do so in the
   other direction.

 * git-gui's info dialog was not displayed correctly when the user trie=
s
   to commit nothing (i.e. without staging anything).

 * "git revert" did not properly fail when attempting to run with a
   dirty index.

 * "git merge --no-commit --no-ff <other>" incorrectly made commits.

 * "git merge --squash --no-ff <other>", which is a nonsense combinatio=
n
   of options, was not rejected.

 * "git ls-remote" and "git remote show" against an empty repository
   failed, instead of just giving an empty result (regression).

 * "git fast-import" did not handle a renamed path whose name needs to =
be
   quoted, due to a bug in unquote_c_style() function.

 * "git cvsexportcommit" was confused when multiple files with the same
   basename needed to be pushed out in the same commit.

 * "git daemon" did not send early errors to syslog.

 * "git log --merge" did not work well with --left-right option.

 * "git svn" promprted for client cert password every time it accessed =
the
   server.

 * The reset command in "git fast-import" data stream was documented to
   end with an optional LF, but it actually required one.

 * "git svn dcommit/rebase" did not honor --rewrite-root option.

Also included are a handful documentation updates.

----------------------------------------------------------------

Changes since v1.5.4.3 are as follows:

Adeodato Sim=C3=B3 (1):
      Really make the LF after reset in fast-import optional

Bj=C3=B6rn Steinbrink (1):
      receive-pack: Initialize PATH to include exec-dir.

Brandon Casey (1):
      builtin-reflog.c: don't install new reflog on write failure

Bryan Donlan (1):
      Documentation/git-am.txt: Pass -r in the example invocation of rm=
 -f .dotest

Caio Marcelo de Oliveira Filho (1):
      filter-branch documentation: non-zero exit status in command abor=
t the filter

Carl Worth (1):
      Eliminate confusing "won't bisect on seeked tree" failure

Daniel Barkalow (3):
      Use a single implementation and API for copy_file()
      Don't use GIT_CONFIG in t5505-remote
      Correct name of diff_flush() in API documentation

Gerrit Pape (2):
      templates/Makefile: don't depend on local umask setting
      git-merge.sh: better handling of combined --squash,--no-ff,--no-c=
ommit options

Jay Soffian (2):
      rev-parse: fix potential bus error with --parseopt option spec ha=
ndling
      send-email: fix In-Reply-To regression

Jeff King (1):
      revert: actually check for a dirty index

Johan Herland (2):
      Add testcase for 'git cvsexportcommit -w $cvsdir ...' with relati=
ve $GIT_DIR
      Fix 'git cvsexportcommit -w $cvsdir ...' when used with relative =
$GIT_DIR

Johannes Schindelin (4):
      http-push: avoid invalid memory accesses
      http-push: do not get confused by submodules
      http-push: avoid a needless goto
      cvsexportcommit: be graceful when "cvs status" reorders the argum=
ents

Johannes Sixt (2):
      daemon: send more error messages to the syslog
      daemon: ensure that base-path is an existing directory

John Goerzen (1):
      Fix dcommit, rebase when rewriteRoot is in use

Jonathan del Strother (1):
      Prompt to continue when editing during rebase --interactive

Junio C Hamano (6):
      Fix "git log --merge --left-right"
      Start preparing for 1.5.4.4
      tests: introduce test_must_fail
      Update draft release notes for 1.5.4.4
      test-lib: fix TERM to dumb for test repeatability
      GIT 1.5.4.4

Matthieu Moy (1):
      Fix incorrect wording in git-merge.txt.

Mike Hommey (2):
      Set proxy override with http_init()
      Fix random crashes in http_cleanup()

Mike Ralphson (1):
      Documentation cherry-pick: Fix cut-and-paste error

Miklos Vajna (2):
      Documentation/git-filter-branch: add a new msg-filter example
      Documentation/git svn log: add a note about timezones.

Pierre Habouzit (1):
      unquote_c_style: fix off-by-one.

Ping Yin (1):
      git-submodule: Fix typo 'url' which should be '$url'

R=C3=A9mi Vanicat (1):
      git.el: find the git-status buffer whatever its name is

Santi B=C3=A9jar (1):
      ident.c: reword error message when the user name cannot be determ=
ined

Sebastian Noack (1):
      git-svn: Don't prompt for client cert password everytime.

Shawn O. Pearce (6):
      Ensure 'make dist' compiles git-archive.exe on Cygwin
      Protect peel_ref fallback case from NULL parse_object result
      Correct fast-export file mode strings to match fast-import standa=
rd
      git-gui: Paper bag fix info dialog when no files are staged at co=
mmit
      Fix 'git remote show' regression on empty repository in 1.5.4
      git-gui: Gracefully fall back to po2msg.sh if msgfmt --tcl fails

Steven Drake (1):
      timezone_names[]: fixed the tz offset for New Zealand.

Uwe Kleine-K=C3=B6nig (1):
      config.txt: refer to --upload-pack and --receive-pack instead of =
--exec


