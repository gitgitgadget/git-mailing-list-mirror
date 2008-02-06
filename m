From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 06 Feb 2008 12:28:22 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802061220590.2732@xanadu.home>
References: <20080203030054.GA18654@coredump.intra.peff.net>
 <20080203043310.GA5984@coredump.intra.peff.net>
 <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
 <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
 <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org>
 <7vir13g9hx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802052228280.8543@racer.site>
 <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
 <20080206164303.GA1255@code-monkey.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Tilman Sauerbeck <tilman@code-monkey.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 18:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMo57-0005W4-HN
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 18:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbYBFR2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 12:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbYBFR2e
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 12:28:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54899 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbYBFR2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 12:28:33 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVT00GIVV7AFBJ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 06 Feb 2008 12:28:23 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080206164303.GA1255@code-monkey.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72821>

On Wed, 6 Feb 2008, Tilman Sauerbeck wrote:

> Linus Torvalds [2008-02-05 15:59]:
> 
> Hi guys,
> thanks for looking into this.
> 
> > On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> > > > 
> > > >  - make commit warn if any parent commit date is in the future from the 
> > > >    current commit date (allow a *small* fudge factor here, say 5 minutes).
> > > 
> > > 5 minutes seems a little narrow to me.  I think we can even go with 86400 
> > > seconds.
> > 
> > Well, notice how I said *warn*. Not abort the commit. Not stop. Just make 
> > people very aware of the fact that clocks are skewed.
> > 
> > In the case that actually triggered this whole discussion, the problem 
> > seems to sadly have been in the original CVS tree (or whatever it was 
> > imported from): the project started in 2006, had lots of regular commits 
> > up to October 2007, and then suddenly it had a commit that had a date in 
> > 2002!
> > 
> > [ For those interested in looking at this, the broken commit in that 
> >   Tilman's repo was commit 3a7340af2bd57488f832d7070b0ce96c4baa6b54, which 
> >   is from October 2002, and which is surrounded by commits from October 
> >   2007, so somebody was literally off by five years ]
> 
> I'm not sure whether this repository was import from another SCM, but I
> doubt it. I'm fairly sure that 3a7340af2bd57488f832d7070b0ce96c4baa6b54
> was created using git commit though. I guess the committer's clock just
> was a little late at that point.

Anyway, the author's date are not necessarily monotonic.

If I pick up patches on a mailing list and apply them in a different 
order than they were posted for whatever sensible reason, I expect Git 
to preserve the original date, even if that means my branch will end up 
with author dates stepping back and forth.  I might even apply a patch 
that was posted last month, or even last year -- that shouldn't matter.


Nicolas
