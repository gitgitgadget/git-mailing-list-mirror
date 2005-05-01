From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 15:29:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505011508270.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 01 21:23:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSK2P-00081P-NJ
	for gcvg-git@gmane.org; Sun, 01 May 2005 21:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVEAT3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 15:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVEAT3R
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 15:29:17 -0400
Received: from iabervon.org ([66.92.72.58]:49159 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262653AbVEAT3N (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 15:29:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DSK7p-0005vI-00; Sun, 1 May 2005 15:29:09 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've been working on http-pull, and I've made it able to download the
target commit from ...git/refs/<dir>/<name> (instead of making you figure
it out yourself), and also write the target it looks up to your local
.git/refs/<w-d>/<w-n> (which doesn't have to be at all related to the
source one. In fact, I just got the latest Linus tree with:

git-http-pull -t -w heads/linus heads/master \
  http://www.kernel.org/pub/scm/git/git.git/
git-read-tree $(cat .git/refs/heads/linus)
git-checkout-cache -a
git-update-cache --refresh

(and I didn't get any of the history, although I could have if I wanted
to; and I could get it now if I decided I needed it).

My question is, where does this belong? It's based on adding to the core
as it has been the knowledge that .git/refs/*/* consists of hex-format
hash files, both locally and on remote servers. I think this level of
information belongs in the plumbing; at least, if people are to be able to
use different git-based systems to access the same repositories, they have
to agree. And there seems to be that much agreement, and so it makes sense
to make it part of the core.

(For that matter, people seem to agree that refs/heads/ has heads, and
refs/heads/master is the one you want to pull if you don't know
otherwise; I didn't include this information at all)

	-Daniel
*This .sig left intentionally blank*

