From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git -> SVN importing
Date: Tue, 3 Feb 2009 12:29:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902031213540.19665@iabervon.org>
References: <c115fd3c0902030717u6a8f3bbck3027cf74715c79a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:31:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUP6m-0004xt-6G
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbZBCR3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbZBCR3V
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:29:21 -0500
Received: from iabervon.org ([66.92.72.58]:48312 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbZBCR3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:29:20 -0500
Received: (qmail 10677 invoked by uid 1000); 3 Feb 2009 17:29:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Feb 2009 17:29:16 -0000
In-Reply-To: <c115fd3c0902030717u6a8f3bbck3027cf74715c79a4@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108223>

On Tue, 3 Feb 2009, Tim Visher wrote:

> Hello Everyone,
> 
> In light of company decisions that are yet to be known, we may in the
> future be stuck using svn.  My team and I really want to experiment
> with Git, but one of the concerns that my supervisor brought up was
> that in the future we want to be sure that we can relatively
> painlessly bring the history into svn if required.  Obviously, it's
> expected that we would loose the local branching history, but we would
> want at least the published information to be sucked back into svn
> without change, if that's possible.
> 
> I figured that someone would have to have done this before since
> git-svn is so magical.  However, I thought I'd ask.
> 
> What's the story?

What other people have done in similar situations is use git on their 
workstations as an extra-nice svn client, keeping the official history 
svn-compatible (and actually stored in svn) until relevant management is 
convinced that git is the way to go. I don't think anybody's written code 
to import a general git history as well as possible into svn.

The fundamental issue is that svn doesn't have any way to represent that a 
branch's history includes two sets of commits which were done in parallel, 
and it's impossible to automatically distribute merge conflict resolutions 
over the series that led to the merge, which means that you can't really 
produce a reasonable representation of the intermediate steps on the 
second branch.

That is, you'd not only lose the local branching history, but some of the 
middle commits in the resulting linear history would be bogus, with 
content which is not like what the author actually did.

	-Daniel
*This .sig left intentionally blank*
