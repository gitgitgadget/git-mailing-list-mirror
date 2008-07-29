From: Jeff King <peff@peff.net>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Tue, 29 Jul 2008 08:36:30 -0400
Message-ID: <20080729123629.GA12069@sigill.intra.peff.net>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net> <alpine.DEB.1.00.0807282008470.8986@racer> <20080728192651.GA26677@sigill.intra.peff.net> <alpine.DEB.1.00.0807290123300.2725@eeepc-johanness> <20080729043839.GC26997@sigill.intra.peff.net> <alpine.DEB.1.00.0807291301060.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoSJ-0001jA-V4
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbYG2Mgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbYG2Mgc
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:36:32 -0400
Received: from peff.net ([208.65.91.99]:4553 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbYG2Mgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:36:31 -0400
Received: (qmail 8761 invoked by uid 111); 29 Jul 2008 12:36:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 08:36:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 08:36:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807291301060.4631@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90626>

On Tue, Jul 29, 2008 at 01:05:11PM +0200, Johannes Schindelin wrote:

> > Perhaps. But I see this as an operation on the production branch: "pull
> > in master's changes, forgetting ours".
> 
> First of all, I cannot say how wrong it is to forget any changes in a 
> production branch without proper explanation.  I.e. without a commit 
> message explaining _why_ the change was wrong to begin with.

Of course; I even mentioned the same in another part of the thread. But
that isn't a difference between "ours" and "theirs"; any time you are
discarding some changes, you should mention why.

> > In your workflow (git checkout master && git merge -s ours production && 
> > git push origin master:production) we perform an operation on master, 
> > which doesn't seem as intuitive to me.
> 
> But why?  Isn't the _content_ of "master" what we want?

Sure, which means we must _read_ from master. But you are _changing_
master. Whereas I view this as an operation on the production branch.

Please don't misunderstand me. I am not saying your way of thinking
about it is wrong (or even less right than mine). What I have been
trying to say this whole thread is that it is reasonable for a user to
model the goal as I have described, and that git can easily support the
direct implementation of achieving that goal (which is what Sverre asked
originally -- is this useful to people?).

> > Not to mention that we might not _control_ master.
> 
> This is Git.  We control all local branches.

Sort of. Consider the kernel example I gave. A "linus" branch represents
"this is where Linus is."  But that _isn't_ where Linus is if you have
added an extra merge commit to it. So either we throw away the change
made to the "linus" branch, or we forever have extra merges that Linus
does not have.

So yes, obviously you can do whatever you like with your local branches.
But you complained in my example that the "production" branch was
unnecessarily being treated as "dominant". My example was meant to
indicate that the "thrown away" branch is dominant for a reason (in this
case, it is my work branch, while the other is a tracking branch).

> No, this workflow almost _dictates_ a plain "pull" into your local branch.  
> The fact that a few commits were applied to upstream usually only means 
> that your merge succeeds trivially, since the merged branches contain the 
> _same_ changes.

I don't see the point in talking about "usually".  In the scenario in
which I used it, the merge _didn't_ succeed trivially. Of course,
usually you would not use "-s theirs". But the question was "is this
ever useful?" and my answer was "rarely, but here is an example of when
I wanted it."

If you are using "-s theirs" frequently, you are probably doing
something wrong. But that doesn't mean it is wrong for it to exist.

-Peff
