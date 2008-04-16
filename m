From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Friendly refspecs
Date: Wed, 16 Apr 2008 11:42:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804161126280.19665@iabervon.org>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:01:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm9nL-0001uP-DE
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 17:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759132AbYDPPmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759569AbYDPPmt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 11:42:49 -0400
Received: from iabervon.org ([66.92.72.58]:55430 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759132AbYDPPmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 11:42:49 -0400
Received: (qmail 10433 invoked by uid 1000); 16 Apr 2008 15:42:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Apr 2008 15:42:42 -0000
In-Reply-To: <20080416034823.GA11727@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79714>

On Tue, 15 Apr 2008, Jeff King wrote:

> On Sun, Apr 13, 2008 at 12:31:02PM +0300, Teemu Likonen wrote:
> 
> > There is still one thing (at least) that I don't quite understand. It's
> > about "git push". When I do
> > 
> >   $ git push <remote> <branch>
> > 
> > the refs/heads/<branch> is updated or created on the remote side. But if
> > I do
> > 
> >   $ git push <remote> <branch1>:<branch2>
> > 
> > the refs/heads/<branch2> is not automatically created. Why there is need
> > to say "<branch1>:refs/heads/<branch2>" to make it work if <branch2>
> > does not exist? The 'git push' manual says something vague about branch
> > not matching (?). What does it mean?
> 
> This happens because "git push <remote> <branch>" is expanded locally to
> "git push <remote> <branch>:<branch>", but <branch> is first expanded
> into refs/heads/<branch>.
> 
> The latter uses the explicit refspec <branch2> which doesn't get
> expanded, since it doesn't exist at all, and so we can't deduce the type
> (e.g., refs/heads versus refs/tags).
> 
> ISTR some discussion in the past few months about using the type of
> <branch1> to guess the type of <branch2>, but it seems not to have gone
> anywhere.
> 
> Daniel, were you working on this?

I was only working on making "HEAD" expand to HEAD:<current branch>. I 
think that the matching type is only most likely what you want, not 
certainly enough to just do it. I'd say that push should suggest it, but 
not actually do it automatically, or possibly require -f to do it without 
the full name.

	-Daniel
*This .sig left intentionally blank*
