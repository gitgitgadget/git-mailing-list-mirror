From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git branch bug
Date: Sat, 5 May 2007 13:05:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705051253380.28708@iabervon.org>
References: <Pine.LNX.4.64.0705051823300.13988@bianca.dialin.t-online.de>
 <Pine.LNX.4.64.0705051841200.4015@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 05 19:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkNhl-00017n-Gt
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbXEERFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933630AbXEERFy
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:05:54 -0400
Received: from iabervon.org ([66.92.72.58]:1104 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933629AbXEERFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:05:53 -0400
Received: (qmail 1238 invoked by uid 1000); 5 May 2007 17:05:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 May 2007 17:05:52 -0000
In-Reply-To: <Pine.LNX.4.64.0705051841200.4015@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46266>

On Sat, 5 May 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 5 May 2007, Guido Ostkamp wrote:
> 
> > $ mkdir test
> > $ cd test
> > $ git init
> > Initialized empty Git repository in .git/
> > $ git branch experimental
> > fatal: Not a valid object name: 'master'.
> > 
> > So, it seems it is not possible to create a named branch on an empty
> > repository.
> 
> Actually, it is not possible to branch from a non-existing branch. So, 
> this is somewhat expected from my POV.

This leaves open the question of how you make your initial commit in a 
branch that isn't master. I think the answer should be:

 $ git checkout -b experimental
 warning: You appear to be on a branch yet to be born.
 warning: Forcing checkout of HEAD.
 fatal: just how do you expect me to merge 0 trees?

Which should probably be:

 $ git checkout -b experimental
 warning: You appear to be on a branch yet to be born.
 warning: Putting you on a new branch yet to be born.

And leaving .git/HEAD pointing to refs/heads/experimental instead of 
refs/heads/master, with refs/heads/ still empty.

 $ git branch experimental

Should probably give a more informative error message, but branches with 
no commits that aren't the current branch has no existance at all, so it 
can't work to create them without switching to them.

	-Daniel
*This .sig left intentionally blank*
