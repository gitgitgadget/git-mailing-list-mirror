From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 01:08:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508260101390.23242@iabervon.org>
References: <46a038f905082420323b025e3b@mail.gmail.com>
 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org> <46a038f905082518306e9d7d2a@mail.gmail.com>
 <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org> <46a038f90508252115415acc04@mail.gmail.com>
 <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 07:51:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8WOd-00060b-Q3
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 07:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbVHZFEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 01:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVHZFEi
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 01:04:38 -0400
Received: from iabervon.org ([66.92.72.58]:39432 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751509AbVHZFEi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 01:04:38 -0400
Received: (qmail 21656 invoked by uid 1000); 26 Aug 2005 01:08:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2005 01:08:14 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3boxl3o1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7789>

On Thu, 25 Aug 2005, Junio C Hamano wrote:

> Now, among the existing object types, there are only two kinds
> of objects you can use for this.  If the only thing you need to
> record is some textual information with one pointer to git
> branch head, then you can use tag that points at the git head,
> and store everything else as the tag comment.  This is doable
> but unwieldy.

I don't think this buys you anything, because then the tag needs to be
accessible from something, which is the same problem you were trying to
solve for the commit.

> You could abuse a commit object as well; you store commit
> objects (such as the corresponding git branch head) as parent
> commits, and put everything else in a tree that is associated
> with that commit.

If you want to go that way, you could add a new field to commits with
minimal effort: you just need to parse it in commit.c, generate it in
git-commit-tree (with an option), and pull it in pull.c, and everything
should work as far as making the git portion follow the metadata around.

	-Daniel
*This .sig left intentionally blank*
