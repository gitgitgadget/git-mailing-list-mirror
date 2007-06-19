From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 12:49:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706191239260.4740@iabervon.org>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
 <Pine.LNX.4.64.0706191037590.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 18:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0gug-0005kY-T4
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 18:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667AbXFSQtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 12:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757903AbXFSQtm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 12:49:42 -0400
Received: from iabervon.org ([66.92.72.58]:2844 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760283AbXFSQtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 12:49:41 -0400
Received: (qmail 17835 invoked by uid 1000); 19 Jun 2007 16:49:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2007 16:49:40 -0000
In-Reply-To: <Pine.LNX.4.64.0706191037590.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50495>

On Tue, 19 Jun 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 19 Jun 2007, Daniel Barkalow wrote:
> 
> > In my branch at: git://iabervon.org/~barkalow/git builtin-fetch
> > 
> > I have a bunch of not-for-merging history leading up to a C version of 
> > fetch which passes all of the tests except that:
> > 
> >  * it might be fetching too much with --depth.
> 
> That should be fixable. (If I get more time this week than I expect, I'll 
> do it myself.)

I just haven't taken the time to look at what it's supposed to do exactly, 
since I wasn't paying attention to the discussions there.

> >  * bundle isn't implemented.
> 
> That's an easy one.

Yeah, just a section in transport.c about it, but the functions I need 
aren't available directly and I got distracted until I was looking at my 
list of what tests I'd disabled.

> >  * when a branch config file section refers to a branches/* remote, the 
> >    merge setting is used (if one is given), even though this isn't useful 
> >    either way.
> 
> Maybe this is the right time to cut off branches/* and remotes/*?

It's not actually too difficult to support them, except for some weird 
combination cases that nobody would do anyway. I just made the remote.c 
config file parser generate the corresponding configurations from them, 
and the rest of the code doesn't have to care. The only oddity is that I 
had to support having a remote always auto-follow tags, even without 
tracking branches, because that's what branches/* did. But this is 
probably a reasonable thing to support as an option anyway.

	-Daniel
*This .sig left intentionally blank*
