From: Nicolas Pitre <nico@cam.org>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 15:49:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612221539100.18171@xanadu.home>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 21:49:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrKy-00016E-GQ
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661AbWLVUts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbWLVUts
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:49:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54306 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbWLVUtr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:49:47 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAP00GXT0IYK7E0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 15:49:47 -0500 (EST)
In-reply-to: <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35215>

On Thu, 21 Dec 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > $ git pull origin/next
> > fatal: The remote end hung up unexpectedly
> > Cannot get the repository state from git://git.kernel.org/pub/scm/git/git.git/next
> >
> > [ WTF?  Where that ...pub/scm/git/git.git/next comes from?  Hmmm... ]
> 
> This comes from ancient request by Linus to allow:
> 
> 	$ cat .git/remotes/jgarzik
> 	URL: master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/
> 	$ git pull jgarzik/misc-2.6
> 
> See http://article.gmane.org/gmane.comp.version-control.git/6181
> for the full text.
> 
> Personally I thought this was confusing when I implemented it
> the first time, and I still find it confusing.
> 
> I suspect nobody uses it.  I am all for removing this "URL
> prefix shorthand" feature in v1.5.0.

Please do.  I'm sure Linus can find a better way now.

> > $ git pull . remotes/origin/next
> > Already up-to-date.
> >
> > [ Woooh!  But since I always hated this syntax let's try merge instead. ]
> >
> > $ git merge origin/next
> > Already up-to-date.
> 
> Yes, that is one of the reasons that you would prefer 'merge'
> when you are working locally.

Sure.  But why doesn't pull accept "origin/next"?

> > $ git pull origin
> > Warning: No merge candidate found because value of config option
> >          "branch.local_next.merge" does not match any remote branch fetched.
> > No changes.
> >
> > So this means that branch.local_next.merge should be set to origin/next?  
> 
> No, the message says "any REMOTE branch" -- refs/heads/next is
> what it is called at the remote, and that is how the value is
> expected to be spelled; I think somebody added an example to
> config.txt recently to stress this.  The above error messasge
> obviously was not clear enough.  Rewording appreciated.

But wouldn't it be much less confusing if it used the local name for 
that remote branch instead?  After all it is what should be used with 
git-merge if performed manually, it is what diff, log, and al must use 
as well.  Why would this need a remote name for something that is a 
local operation after all?  I think "refs/heads/master" is really 
ambigous since you might be confused between the local and remote 
meaning of it, whereas "origin/master" carries no confusion at all.


Nicolas
