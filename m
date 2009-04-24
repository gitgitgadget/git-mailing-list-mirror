From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Is there a way to lock branches in GIT?
Date: Thu, 23 Apr 2009 23:23:22 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0904232300360.2147@iabervon.org>
References: <23204641.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: ask4thunder <ask4thunder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 05:25:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxC2h-0001Mh-Rt
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 05:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbZDXDXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 23:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZDXDXY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 23:23:24 -0400
Received: from iabervon.org ([66.92.72.58]:39435 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbZDXDXX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 23:23:23 -0400
Received: (qmail 25227 invoked by uid 1000); 24 Apr 2009 03:23:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2009 03:23:22 -0000
In-Reply-To: <23204641.post@talk.nabble.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117404>

On Thu, 23 Apr 2009, ask4thunder wrote:

> 1. If there are 2 user are working and having their own clone and branches
> (not master, other branches). and there is another parent clone with a
> branch (not master). Can these 2 users merge to the parent clone branch at
> the same time? or only one user will be able to merge first and then the
> other. in other words, will the target branch be checkedout to that user
> alone and other user cant checkout that branch or use the checked out
> branch. 

You can't merge into a remote repository; you can only move the remote 
repository forward. That is, when you "push" to the remote repository, you 
replace what it currently there with a commit you supply that's based on 
the commit that's there.

Two people can't both push to the same remote repository at the same time, 
because each of them will be sending something that the other hasn't based 
their commit on. Whoever's second will be refused, and will have to fetch 
the other commit and make a merge commit, which is based on both the 
commits. Git makes sure, in updating the remote repository, to do the 
necessary locking to have one side or the other lose the race cleanly.

> 2. Is there a way to lock branches, so that if a user want to merge his
> changes to a parent branch of another clone, it can be unlocked for him
> alone? Hope you can help me on this. 

Not with git program support. Of course, you can use Unix permissions to 
get exclusive write access to the branch and prevent another else from 
updating it. And, of course, you can have a branch that's always your own 
(Linux kernel development works primarily by every developer having one or 
many private branches, and it's rare for multiple people to have write 
access to the same branch). But there turns out not to be much benefit to 
branches that people can sometimes but not always write to, in a system 
where everybody has local branches they can always write to regardless of 
what other people do.

	-Daniel
*This .sig left intentionally blank*
