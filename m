From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Sat, 08 Dec 2007 00:12:53 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712080004490.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
 <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
 <alpine.LFD.0.99999.0712072124160.555@xanadu.home>
 <9e4733910712071929h17a7d88dv37686ec7cd858c63@mail.gmail.com>
 <20071208033722.GA27776@old.davidb.org>
 <9e4733910712072022na3369caob48d4b26a56224ea@mail.gmail.com>
 <alpine.LFD.0.99999.0712072328420.555@xanadu.home>
 <9e4733910712072101k4583c0afsea368253fe1cf706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 06:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0s04-00006e-G8
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 06:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbXLHFMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 00:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbXLHFMz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 00:12:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31398 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbXLHFMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 00:12:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP00BF1T5HZ1A0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 08 Dec 2007 00:12:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712072101k4583c0afsea368253fe1cf706@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67515>

On Sat, 8 Dec 2007, Jon Smirl wrote:

> On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 7 Dec 2007, Jon Smirl wrote:
> >
> > > Does the gcc repo contain some giant objects? Why wasn't the memory
> > > freed after their chain was processed?
> >
> > It should be.
> >
> > > Most of the last 10% is being done on a single CPU. There must be a
> > > chain of giant objects that is unbalancing everything.
> >
> > I'm about to send a patch to fix the thread balancing for real this
> > time.
> 
> Something is really broken in the last 5% of that repo. I have been
> processing at 97% for 30 minutes without moving to 98%.

This is a clear sign of a problem, indeed.

I'll be away for the weekend, so here's a few things to try out if you 
feel like it:

1) Make sure the problem occurs with the thread code disabled.  That 
   would eliminate one variable, and will help for #2.

2) Try bissecting the issue.  If you can find an old Git version where 
   the issue doesn't appear then simply run "git bissect" to find the 
   exact commit causing the problem.  Best with a repo that doesn't take
   ages to repack.

3) Compile Git against the dmalloc library in order to identify where
   the huge memory leak is happening.


Nicolas
