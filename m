From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Thu, 15 Sep 2005 12:42:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509151219590.23242@iabervon.org>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
 <7vd5naah1m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 18:42:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFwkW-0006BF-CC
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 18:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbVIOQiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 12:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbVIOQiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 12:38:09 -0400
Received: from iabervon.org ([66.92.72.58]:6917 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030524AbVIOQiI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 12:38:08 -0400
Received: (qmail 14021 invoked by uid 1000); 15 Sep 2005 12:42:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Sep 2005 12:42:17 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5naah1m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8615>

On Thu, 15 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Don't assume that any commit we have is complete; assume that any ref
> > we have is complete.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> >
> > ---
> > Only lightly tested, but it seems to work. Marks all of the commits in 
> > refs, and their ancestors back as far as the date of the commit it's 
> > processing. If the commit it's processing is marked, it doesn't recurse 
> > into it.
> 
> First I thought you were using the date for the cutting-off
> decision and was going to object to the patch because of it, but
> re-reading the code made me realize that you are using date only
> to better the heuristics that limits how many commits reachable
> from existing refs we would tangle to see if the newly seen
> commit is reachable from our refs -- the logic looks correct.
> 
> The "complete" commit_list is a clever piece of code; I like it.

It's actually just the core loop of rev-list's original behavior. It's 
equivalent to putting the commit we're looking for in the list and popping 
the list until it comes back out, except that it saves a bit of 
list-fiddling. It's worth knowing that you can do rev-list (minus some of 
the features for human-readability) integrated into your program with just 
a couple of lines.

	-Daniel
*This .sig left intentionally blank*
