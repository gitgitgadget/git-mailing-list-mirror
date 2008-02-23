From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Question about your git habits
Date: Fri, 22 Feb 2008 23:10:48 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802222249480.19024@iabervon.org>
References: <200802221837.37680.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Chase Venters <chase.venters@clientec.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 05:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSljq-00048w-NI
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 05:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbYBWEKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 23:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbYBWEKv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 23:10:51 -0500
Received: from iabervon.org ([66.92.72.58]:41185 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbYBWEKu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 23:10:50 -0500
Received: (qmail 29399 invoked by uid 1000); 23 Feb 2008 04:10:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Feb 2008 04:10:48 -0000
In-Reply-To: <200802221837.37680.chase.venters@clientec.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74793>

On Fri, 22 Feb 2008, Chase Venters wrote:

> I've been making myself more familiar with git lately and I'm curious what 
> habits others have adopted. (I know there are a few documents in circulation 
> that deal with using git to work on the kernel but I don't think this has 
> been specifically covered).
> 
> My question is: If you're working on multiple things at once, do you tend to 
> clone the entire repository repeatedly into a series of separate working 
> directories and do your work there, then pull that work (possibly comprising 
> a series of "temporary" commits) back into a separate local master 
> respository with --squash, either into "master" or into a branch containing 
> the new feature?
> 
> Or perhaps you create a temporary topical branch for each thing you are 
> working on, and commit arbitrary changes then checkout another branch when 
> you need to change gears, finally --squashing the intermediate commits when a 
> particular piece of work is done?

I find that the sequence of changes I make is pretty much unrelated to the 
sequence of changes that end up in the project's history, because my 
changes as I make them involve writing a lot of stubs (so I can build) and 
then filling them out. It's beneficial to have version control on this so 
that, if I screw up filling out a stub, I can get back to where I was.

Having made a complete series, I then generate a new series of commits, 
each of which does one thing, without any bugs that I've resolved, such 
that the net result is the end of the messy history, except with any 
debugging or useless stuff skipped. It's this series that gets merged into 
the project history, and I discard the other history.

The real trick is that the early patches in a lot of series often refactor 
existing code in ways that are generally good and necessary for your 
eventual outcome, but which you'd never think of until you've written more 
of the series. Generating a new commit sequence is necessary to end up 
with a history where it looks from the start like you know where you're 
going and have everything done that needs to be done when you get to the 
point of needing it. Furthermore, you want to be able to test these 
commits in isolation, without the distraction of the changes that actually 
prompted them, which means that you want to have your working tree is a 
state that you never actually had it in as you were developing the end 
result.

This means that you'll usually want to rewrite commits for any series that 
isn't a single obvious patch, so it's not a big deal to commit any time 
you want to work on some different branch.

	-Daniel
*This .sig left intentionally blank*
