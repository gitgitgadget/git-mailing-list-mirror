From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 04 Mar 2006 20:22:57 -0800
Message-ID: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Mar 05 05:23:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFkls-0003P7-Hd
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 05:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWCEEW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Mar 2006 23:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWCEEW7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 23:22:59 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64652 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751452AbWCEEW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Mar 2006 23:22:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305042013.HZPO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 23:20:13 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17201>

I've merged up a lot for people to have fun over the weekend
;-).

The most notable core-ish change is that rev-list split and new
git-log implementation by Linus.  I've been using this myself
for a while without problems, but there might still be some
corner cases that I (and Linus perhaps) do not exercise where
git-log command behaves slightly differently.  rev-list is not
supposed to have *any* regression other than removal of
--merge-order.  Please report regressions.

A new killer application is git-cvsserver.  It now talks pserver
protocol for anonymous CVS access.  Helping Martin to audit the
code for any issues, security or otherwise, is greatly
appreciated.

=46redrik's git-blame still has -Wdeclaration-after-statement
issues, but deserves to be beaten harder alongside Ryan's
git-annotate for two reasons.  It should be a good example
program to use the new revision traversal infrastructure, and it
is always good to have competing two implementations ;-).


* The 'master' branch has these since the last announcement.

 - Cygwin portability for test (Alex Riesen)
   workaround fat/ntfs deficiencies for t3600-rm.sh (git-rm)

 - Emacs interface (Alexandre Julliard)
   contrib/emacs: Add an Emacs VC backend.
   git.el: Added customize support for all parameters.
   git.el: Added support for Signed-off-by.
   git.el: Automatically update .gitignore status.
   git.el: Portability fixes for XEmacs and Emacs CVS.
   git.el: Set default directory before running the status mode setup h=
ooks.

 - gitview updates (Aneesh Kumar K.V)
   gitview: Use horizontal scroll bar in the tree view
   gitview: pass the missing argument _show_clicked_cb.

 - git-svn updates (Eric Wong)
   contrib/git-svn: add --id/-i=3D$GIT_SVN_ID command-line switch
   contrib/git-svn: add -b/--branch switch for branch detection
   contrib/git-svn: allow --authors-file to be specified
   contrib/git-svn: avoid re-reading the repository uuid, it never chan=
ges
   contrib/git-svn: better documenting of CLI switches
   contrib/git-svn: cleanup option parsing
   contrib/git-svn: create a more recent master if one does not exist
   contrib/git-svn: fix a copied-tree bug in an overzealous assertion
   contrib/git-svn: several small bug fixes and changes
   contrib/git-svn: strip 'git-svn-id:' when commiting to SVN
   contrib/git-svn: use refs/remotes/git-svn instead of git-svn-HEAD
   git-branch: add -r switch to list refs/remotes/*

 - send-email fix (Eric Wong)
   send-email: accept --no-signed-off-by-cc as the documentation states

 - checkout-index --stdin (Shawn Pearce)
   Teach git-checkout-index to read filenames from stdin.

 - git-blame (Fredrik Kuivinen)
   Add git-blame, a tool for assigning blame.
   git-blame, take 2

 - git-mv updates (Josef Weidendorfer)
   git-mv: Allow -h without repo & fix error message
   git-mv: fixes for path handling
   git-mv: fix moves into a subdir from outside

 - split rev-list implementation and git-log (Linus and me)
   First cut at libifying revlist generation
   Splitting rev-list into revisions lib, end of beginning.
   git-rev-list libification: rev-list walking
   Introduce trivial new pager.c helper infrastructure
   Tie it all together: "git log"
   Rip out merge-order and make "git log <paths>..." work again.
   rev-list split: minimum fixup.
   git-log (internal): add approxidate.
   git-log (internal): more options.
   setup_revisions(): handle -n<n> and -<n> internally.

 - git-verify-tag update (me)
   Pretty-print tagger dates.

 - git-commit --amend (me)=20

 - show-branch --topics (me)

 - git-svnimport update (Karl  Hasselstr=F6m)
   Save username -> Full Name <email@addr.es> map file

 - git tool survey documentation (Marco Costalba)
   Add a Documentation/git-tools.txt

 - git-cvsserver updates (Martin Langhoff)
   cvsserver: Checkout correctly on Eclipse
   annotate: fix -S parameter to take a string
   cvsserver: Eclipse compat -- now "compare with latest from HEAD" wor=
ks
   cvsserver: checkout faster by sending files in a sensible order
   cvsserver: fix checkouts with -d <somedir>
   cvsserver: nested directory creation fixups for Eclipse clients
   cvsserver: better error messages
   cvsserver: anonymous cvs via pserver support

 - delta cleanup (Nicolas Pitre)
   relax delta selection filtering in pack-objects
   diff-delta: fold two special tests into one plus cleanups
   diff-delta: big code simplification

 - git-annotate updates (Ryan Anderson)
   annotate: handle \No newline at end of file.
   annotate: Add a basic set of test cases.

 - misc fixes and docs (Francis Daly, Johannes Schindelin, Jonas Fonsec=
a,
   Mark Wooding, Shawn Pearce, Tony Luck, Martin Langhoff, me)
   AsciiDoc fix for tutorial
   Documentation: read-tree --aggressive
   Documentation: rev-list --objects-edge
   Fix test case for some sed
   GIT-VERSION-GEN: squelch unneeded error from "cat version"
   Prevent --index-info from ignoring -z.
   Pull GIT 1.2.4 fixes from master
   Re-fix compilation warnings.
   Warn about invalid refs
   annotate should number lines starting with 1
   annotate: fix -S parameter to take a string
   annotate: resurrect raw timestamps.
   combine-diff: Honour --full-index.
   combine-diff: Honour -z option correctly.
   git-commit: make sure we protect against races.
   manpages: insert two missing [verse] markers for multi-line SYNOPSIS
   read-tree --aggressive: remove deleted entry from the working tree.
   tar-tree: file/dirmode fix.
   war on whitespaces: documentation.

* The 'next' branch, in addition, has these.

 - diffcore-rename/break and similarity estimator tweaks (me)
   count-delta: no need for this anymore.
   diffcore-break: similarity estimator fix.
   diffcore-delta: make change counter to byte oriented again.
   diffcore-rename: similarity estimator fix.

* The 'pu' branch, in addition, has these.

 - checkout-index --temp --stage=3Dall (Shawn Pearce)
