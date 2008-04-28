From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 15:52:17 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804281537260.19665@iabervon.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428114509.240ef4ae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:53:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZPe-00029N-6w
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbYD1TwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934197AbYD1TwX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:52:23 -0400
Received: from iabervon.org ([66.92.72.58]:38532 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934370AbYD1TwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:52:19 -0400
Received: (qmail 7905 invoked by uid 1000); 28 Apr 2008 19:52:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2008 19:52:17 -0000
In-Reply-To: <20080428114509.240ef4ae.akpm@linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80600>

On Mon, 28 Apr 2008, Andrew Morton wrote:

> On Sun, 27 Apr 2008 13:24:08 -0700 (PDT) Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > On Sun, 27 Apr 2008, Andrew Morton wrote:
> > > 
> > > But I'm pretty sure that the simple solutions were found wanting, but I
> > > don't recall why.  I think it was because of a problem when
> > > git-netdev-all is based on git-net which is based on origin.  I want to
> > > extract the git-net -> git-netdev-all diff, but doing that generates
> > > patches which reapply things which are already applied.
> > 
> > Well, if a tree has patches that are already applied up-stream, then yes, 
> > you do actually have to do the merge in order to see that. Because 
> > obviously the diff is in two places, and if they merge cleanly, one of 
> > them has to be made to not count.
> > 
> > So it depends on what you want.
> > 
> > 	git diff a...b
> > 
> > says literally "what has been added to 'b' since it diverged from 'a'". 
> > 
> > That is a useful and valid thing to ask, but it is very fundamentally also 
> > *not* the same thing as actually doing the merge, and asking what the 
> > merge added. Doing
> > 
> > 	git merge --no-commit otherbranch
> > 	git diff HEAD > diff
> > 	git reset --hard
> > 
> > will do that: it will do the merge (which obviously squashes any diffs 
> > that existed in the other tree as different commits), and then diffs the 
> > HEAD against that resulting state.
> > 
> 
> hm, weirdness.
> 
> y:/usr/src/git26> git-diff origin...git-ia64   
> y:/usr/src/git26> git-log origin...git-ia64 | wc -l
> 15574
> 
> I'd have expected git-log to operate on the same patches as git-diff.

I don't think this operation is even well-defined for git-log. What do you 
expect to see if origin contains some of the same changes as ia64, but 
where what changes are in the same patch are different on the two paths? 
Even more so, what if ia64 has some additional changes in a commit that 
had other changes that were left out of the origin version?

For the diff, it doesn't matter, but for log it would.

	-Daniel
*This .sig left intentionally blank*
