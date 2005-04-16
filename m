From: Christopher Li <git@chrisli.org>
Subject: Re: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 11:44:41 -0400
Message-ID: <20050416154441.GA30392@64m.dyndns.org>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <20050416174327.GG19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsOI-0004Ro-3f
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVDPSzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVDPSzP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:55:15 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:41909 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262727AbVDPSzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:55:05 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005041618550401600hrfj5e>; Sat, 16 Apr 2005 18:55:04 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 10CBC3F1EF; Sat, 16 Apr 2005 11:44:42 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050416174327.GG19099@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 07:43:27PM +0200, Petr Baudis wrote:
> Dear diary, on Sat, Apr 16, 2005 at 07:04:31PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
> > So I'd _almost_ suggest just starting from a clean slate after all.  
> > Keeping the old history around, of course, but not necessarily putting it
> > into git now. It would just force everybody who is getting used to git in 
> > the first place to work with a 3GB archive from day one, rather than 
> > getting into it a bit more gradually.
> > 
> > Comments?
> 
> FWIW, it looks pretty reasonable to me. Perhaps we should have a
> separate GIT repository with the previous history though, and in the
> first new commit the parent could point to the last commit from the
> other repository.
> 
> Just if it isn't too much work, though. :-)

I think we can make the git using stackable repository. When it fail
to find an object, it will try it's to read from parent repository.
It is useful to slice the history.

I can have local repository that all the new object create by me will
store in my tree instead of the official one. Clean up the object in the
my local tree will be much easier it only need to work on a much smaller
repository. If all my change is merge to official tree, I just simply
empty my local repository.

About the kernel git repository. I think it is much easier just put
them in one tree.  So I don't need to worry about "if I need to see
pre 2.6.12, I need to do this". And the full repository  need to
store in the server some where any way.

However I totally agree that people should not deal with unnecessary the history
when they start using the git tools. We should just make the tools
by default don't download all the histories. Only get it when user specific 
ask for it.

Why 2.6.12-rc2? When kernel grows to 2.6.15, a new user might not even need
pre 2.6.13 most of the time. If we make it very easier for people to get
history if they need, it will make them less motivate to store unnecessary
history locally (just in case I need it).

I think we should not advise using rsync to sync the whole git tree as
way to get update. We need to get use to only have a slice of the history
and get more if we needed.
The server should should provide some small metadata file like the
the rev-tool cache, so the SCM tools can download it to figure out what file
is needed to download to get to certain revision. Instead of download the
whole repository to figure out what is new.

We can even slice that metadata information to smaller pieces base on major release point.

Chris
 
