From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 05:24:22 +0200
Message-ID: <20050426032422.GQ13467@pasky.ji.cz>
Reply-To: pasky@ucw.cz, git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 05:20:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQGcA-00056p-BW
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 05:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDZDYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 23:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVDZDYu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 23:24:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22764 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261263AbVDZDYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 23:24:25 -0400
Received: (qmail 5507 invoked by uid 2001); 26 Apr 2005 03:24:23 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  here goes Cogito-0.8, my SCMish layer over Linus Torvald's git tree
history tracker. This package was formerly called git-pasky, however
this release brings big changes. The usage is significantly different,
as well as some basic concepts; the history changed again (hopefully the
last time?) because of fixing dates of some old commits. The .git/
directory layout changed too.

  Upgrading through pull is possible, but rather difficult and requires
some intimacy with both git, git-pasky and Cogito. So probably the best
way to go is to just get cogito-0.8 tarball at

	http://www.kernel.org/pub/software/scm/cogito/

or

	ftp://ftp.kernel.org/pub/software/scm/cogito/

build and install it, and do

	cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git



  Yes, this is a huge change. No, I don't expect any further changes of
similar scale. I think the new interface is significantly simpler _and_
cleaner than the old one.

  First for the concept changes. There is no concept of tracking
anymore; you just do either cg-pull to just fetch the changes, or
cg-update to fetch them as well as merge them to your working tree.
Even more significant change is that Cogito does not directly support
local branches anymore - git fork is gone, you just go to new directory
and do

	cg-init ~/path/to/your/original/repository

(or cg-clone, which will try to create a new subdirectory for itself).
This now acts as a separate repository, except that it is hardlinked
with the original one; therefore you get no additional disk usage.  To
get new changes to it from the original repository, you have to
cg-update origin. If you decide you want to merge back, go to the
original repository, add your new one as a branch and pull/update from
it.

  As for the interface changes, you will probably find out on your own;
cg-help should be of some help. All the scripts now start with 'cg-',
and you should ignore the 'cg-X*' ones. The non-trivial mapping is:

	git addremote -> cg-branch-add
	git lsremote -> cg-branch-ls
	git patch -> cg-mkpatch
	git apply -> cg-patch
	git lsobj -> cg-admin-lsobj

  Commands that are gone:

	git fork
	git track

  New commands:

	cg-clone
	cg-update



  Of course other changes include various bugfixes, and latest Linus'
stuff (although we do not make use of Linus' tags yet).

  Note that I don't know how many time will I have for hacking Cogito
until the next Sunday/Monday. I hope I will get some time to at least
apply bugfixes etc, but I don't know how much more will I be able to do.
You would make me a happy man if you could please port your pending
patches from git-pasky to Cogito; I promise to apply them and I hope
there isn't going to be another so big change in the foreseeable future,
which would cause major conflicts for your patches etc.


  Note that I cc'd LKML since it is going to break stuff for anyone
using git-pasky now (apologies for that; it won't happen another time).
Please try not to keep it in the cc' list unless it is really relevant.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
