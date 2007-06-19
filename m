From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 20:47:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706192043310.4059@racer.site>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
 <Pine.LNX.4.64.0706191037590.4059@racer.site> <Pine.LNX.4.64.0706191239260.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:47:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0jfb-0002HM-KP
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 21:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbXFSTrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXFSTrS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 15:47:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:38120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbXFSTrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 15:47:17 -0400
Received: (qmail invoked by alias); 19 Jun 2007 19:47:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 19 Jun 2007 21:47:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+YHxnvj9+CMmSvKAylc0W4ocD6cAYMJwTvlqhbT
	6p/Ey+hgFqCAkA
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706191239260.4740@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50503>

Hi,

On Tue, 19 Jun 2007, Daniel Barkalow wrote:

> On Tue, 19 Jun 2007, Johannes Schindelin wrote:
> 
> > 
> > On Tue, 19 Jun 2007, Daniel Barkalow wrote:
> > 
> > > In my branch at: git://iabervon.org/~barkalow/git builtin-fetch
> > > 
> > > I have a bunch of not-for-merging history leading up to a C version 
> > > of fetch which passes all of the tests except that:
> > > 
> > >  * it might be fetching too much with --depth.
> > 
> > That should be fixable. (If I get more time this week than I expect, 
> > I'll do it myself.)
> 
> I just haven't taken the time to look at what it's supposed to do 
> exactly, since I wasn't paying attention to the discussions there.

Come to think of it, I am not sure that it does the right thing in 
existing code either. There are still a bunch of emails regarding shallow 
clone in my inbox, awaiting calmer weather.

> > >  * bundle isn't implemented.
> > 
> > That's an easy one.
> 
> Yeah, just a section in transport.c about it, but the functions I need 
> aren't available directly and I got distracted until I was looking at my 
> list of what tests I'd disabled.

What I meant is not that it is so easy that you should have done it. I 
meant that this is so easy you should not bother with it, since I'll 
gladly step in once builtin-fetch is otherwise feature complete.

> > >  * when a branch config file section refers to a branches/* remote, the 
> > >    merge setting is used (if one is given), even though this isn't useful 
> > >    either way.
> > 
> > Maybe this is the right time to cut off branches/* and remotes/*?
> 
> It's not actually too difficult to support them, except for some weird 
> combination cases that nobody would do anyway. I just made the remote.c 
> config file parser generate the corresponding configurations from them, 
> and the rest of the code doesn't have to care. The only oddity is that I 
> had to support having a remote always auto-follow tags, even without 
> tracking branches, because that's what branches/* did. But this is 
> probably a reasonable thing to support as an option anyway.

As Junio said, I think in the interest of clean code we should  
deprecate that, and eventually get rid of it. We could do that even before 
builtin-fetch reaches 'next'...

Ciao,
Dscho
