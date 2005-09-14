From: Peter Eriksen <s022018@student.dtu.dk>
Subject: [PATCH] According to the man page on Solaris the install command takes the -d option before all others
Date: 14 Sep 2005 12:41:52 +0200
Message-ID: <vhpwtlkorrj.fsf@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 14 12:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFUkn-0005CY-1L
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 12:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbVINKoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 06:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbVINKoe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 06:44:34 -0400
Received: from main.gmane.org ([80.91.229.2]:63201 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932710AbVINKod (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 06:44:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFUjL-0004u2-8c
	for git@vger.kernel.org; Wed, 14 Sep 2005 12:43:07 +0200
Received: from bohr.gbar.dtu.dk ([192.38.95.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Sep 2005 12:43:07 +0200
Received: from s022018 by bohr.gbar.dtu.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Sep 2005 12:43:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bohr.gbar.dtu.dk
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8515>

Hello,

I'm new to this whole way of developing, and I'm still a bit confused
about the tools and the workflow.  I'm trying to port Git to Solaris, and
it seems that others are working on this as well, so this post is mostly
a request to share those Solaris patches with me.  The patch below
doesn't port git to Solaris, but fixes a small problem for me on the way.
I tested it on GNU install and it seems to work.  If this patch doesn't
apply at all feel free to edit the two lines by hand.

Regards,

Peter

=================

 /usr/sbin/install -d | -i [-m mode] [-u user] [-g group]  [-
     o] [-s] dirx...

Fix the Makefile accordingly.

---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

27ee13ef78c0a25acc1b8dce508b49c0fc729e41
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -293,12 +293,12 @@ check:
 ### Installation rules
 
 install: $(PROGRAMS) $(SCRIPTS)
-       $(INSTALL) -m755 -d $(DESTDIR)$(bindir)
+       $(INSTALL) -d -m755 $(DESTDIR)$(bindir)
        $(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
        $(INSTALL) git-revert $(DESTDIR)$(bindir)/git-cherry-pick
        sh ./cmd-rename.sh $(DESTDIR)$(bindir)
        $(MAKE) -C templates install
-       $(INSTALL) -m755 -d $(DESTDIR)$(GIT_PYTHON_DIR)
+       $(INSTALL) -d -m755 $(DESTDIR)$(GIT_PYTHON_DIR)
        $(INSTALL) $(PYMODULES) $(DESTDIR)$(GIT_PYTHON_DIR)
 
 install-doc:
