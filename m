From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt v0.22
Date: Sun, 11 Mar 2007 15:30:54 -0400
Message-ID: <20070311193054.GA26766@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 20:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQTlD-0006Xn-0F
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 20:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbXCKTa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 15:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbXCKTa6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 15:30:58 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46357 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964802AbXCKTa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 15:30:56 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l2BJUsZV028951;
	Sun, 11 Mar 2007 15:30:54 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l2BJUssn028948;
	Sun, 11 Mar 2007 15:30:54 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41964>

Guilt v0.22 is available for download (once it mirrors out on kernel.org).

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like functionality and interface to git.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The changes to Guilt could be divided into three categories:

1) Documentation: Quite a bit of documentation was added.

2) Bugfixes:
    - guilt-patchbomb did not actually do the right action based on user's
      answer to the question about removal of the temporary patch directory.

    - Many places in the code used variables in an unsafe way - a whitespace
      in a path could have caused very bad things to happen.

    - Guilt 0.21 did not allow the user to be in a subdirectory and run
      guilt commands.

    - guilt-files did not recurse into subdirectories.

3) Features: Autotagging:

    Automatically creates unannotated tags for top, bottom, and base of the
    stack

    On every push or pop operation (refresh is a pop followed by a push),
    update the stack top (${branch}_top), stack bottom (${branch}_bottom),
    and stack base (${branch}_base) tags.

    Top:	Topmost applied patch/commit
    Bottom:	Bottommost applied patch/commit
    Base:	Commit on top of which the bottom most patch is applied

    Having these three tags, one can easily get the log/diff/other information
    only for commits that are (or are not!) part of the patch stack.

    Autotagging can be disabled by setting guilt.autotag=0 in your git
    config file.

    Additionally, guilt-init now accepts a new parameter '-n' to
    automatically set guilt.autotag=0 in the current repository.


As always, patches, and other feedback is welcome.

Josef "Jeff" Sipek.

------------
Changes since v0.21:

Josef 'Jeff' Sipek (19):
      Inform git-sh-setup that we can work from within a subdirectory
      Docs: guilt-new manpage
      files: Recurse into subdirectories when using git-diff-tree
      Docs: guilt-files manpage
      Docs: Formatting fixes
      Docs: prev, refresh, top, and unapplied manpages
      new: Make sure the requested patchname would not create unnecessary problems
      Quote variables as frequently as possible to prevent whitespace problems
      Remove find_git_dir as git-sh-setup already provides such functionality
      Makefile's clean target should be .PHONY as well
      Docs: Fix links/references between pages
      Docs: Mention the fact that guilt can be used to develop guilt
      Docs: Fix command examples in new & next manpage
      Docs: Remove stray reference
      Automatically create unannotated tags for top, bottom, and base of the stack
      Autotag: Read guilt.autotag config var and tag commits only if this feature is enabled
      Docs: Added install-html makefile rule to Documentation/Makefile
      Makefile: Replace hard-coded script list with a wildcard
      Guilt v0.22

Nur Hussein (3):
      Guilt: Fixed guilt-patchbomb temporary mbox deletion bug
      Guilt: Added an uninstall target
      Guilt: Makefile tab fix
