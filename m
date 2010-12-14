From: Maaartin <grajcar1@seznam.cz>
Subject: Referring to other repositories
Date: Tue, 14 Dec 2010 01:03:20 +0000 (UTC)
Message-ID: <loom.20101214T011043-268@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 14 02:03:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSJIo-0003yz-K1
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 02:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772Ab0LNBDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 20:03:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:35472 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758743Ab0LNBDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 20:03:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PSJIg-0003wj-RQ
	for git@vger.kernel.org; Tue, 14 Dec 2010 02:03:30 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 02:03:30 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 02:03:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163607>

I'm using multiple repositories corresponding to different projects. Currently, 
all the projects reside in different subdirectories of the same directory, like
work/A
work/B
work/C
There are some dependencies like B and C depending on A. Until now, my git 
knows nothing about it and it works fine, since most changes of A are 
unimportant for B and C (as A is my general purpose code which doesn't change 
much). There are three kinds of changes in A:
- unrelated changes completely irrelevant to the other projects (vast majority)
- changes made because of either B or C (sometimes)
- unrelated changes forcing updating B and/or C (very seldom)
Not keeping track about A in the other projects would be a problem if I was to 
use git bisect. Having to checkout the corresponding version of A when checking 
out an old version of B or C manually, is just an inconvenience, no real 
problem.

I know about git submodule, however IIUIC it needs the other project to become 
a subdirectory of the master, but I can hardly make A to subdirectory of both B 
and C (I'm a poor Windows user, so no symlinks). I could make copies of A as 
subdirectories, but having A thrice would be very impractical:
- I'd have to avoid modifying the copies instead of the master.
- All three versions would show up in my IDE.
- I'd have to keep them in sync.
So it looks like using submodules is no option, but I hope you tell me that I'm 
wrong.

What other possibilities are there? For the normal use, I'd be happy with git 
tracking the commit id of A somehow. I think I could do it by saving the output 
of
GIT_DIR=/e/work/A git log --max-count=1 --format=format:%H
in a file using a pre-commit hook. Or is there a better way?

For git bisect (which I haven't used yet but I'm going to), I'd need a way to 
check out the right version of A automatically, this could be done as part of 
the command given to git bisect run, right?
