From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/5] Add some functions for commit lists
Date: Sat, 23 Apr 2005 22:40:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232230080.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504231916300.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 04:36:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPWyl-0000As-GL
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVDXCko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 22:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVDXCko
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 22:40:44 -0400
Received: from iabervon.org ([66.92.72.58]:8452 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262232AbVDXCki (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 22:40:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPX32-0005NB-00; Sat, 23 Apr 2005 22:40:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504231916300.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Linus Torvalds wrote:

> 
> 
> On Sat, 23 Apr 2005, Linus Torvalds wrote:
> > 
> > Ok. This is more in like with what I was hoping for, looks good.
> 
> Oh, Daniel, I notice that you have the same old bug: it will happily add 
> the same parent to the list several times. You need to prune them out, and 
> ignore things you've seen.
>
> I pushed out the fix (don't parse and add parents to the list that were 
> already parsed).

This won't actually work for merge-base, which wants to run two of these,
one for each head, in parallel, and find the first commit on both lists. I
think making insert_by_date() ignore items already in the list is a better
solution, although that might run into problems if there's a complicated
graph of commits all with the same time.

Another option is to specify a object.flags bit to mark for each commit
and ignore commits that are already marked.

	-Daniel
*This .sig left intentionally blank*

