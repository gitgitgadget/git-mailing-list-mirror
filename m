From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: only throw away data during memory pressure
Date: Tue, 12 Feb 2008 12:39:39 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802121229570.2732@xanadu.home>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
 <alpine.LFD.1.00.0802110942310.2732@xanadu.home>
 <20080212082211.GE27535@lavos.net>
 <alpine.LFD.1.00.0802120910440.2732@xanadu.home>
 <20080212171403.GG27535@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 18:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOz7Q-00011R-VT
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 18:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYBLRjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 12:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbYBLRjy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 12:39:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27405 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbYBLRjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 12:39:53 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW4005OLZQ30880@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Feb 2008 12:39:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080212171403.GG27535@lavos.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73679>

On Tue, 12 Feb 2008, Brian Downing wrote:

> So that gives four options:
> 
> 1. No memory limit, constant entry depth.  Original Git behavior.
> 2. The above with an additional memory-based depth limit.  This is 
>    what was added with --memory-limit.
> 3. Constant entry depth with a memory-usage limit.  This is what the
>    proposed patch does.

... and it was merged already.

> 4. Dynamic entry depth, with a memory-based limit.  This is I believe
>    what you are proposing above, and what I emulate by setting
>    --window=$bignum --window-memory=x.
> 
> I'm willing to try and make all of those work. (Though frankly I don't
> care much about #3; setting the window entry size to something "large
> enough" seems a simple enough work-around for me, and it prevents what's
> probably some truly ridiculous behavior if you have a gigantic number of
> tiny, say, tree objects.  Having a cap on window depth stops that case
> from taking a truly inordinate amount of time.)
> 
> However, I can't figure out what sensible command-line and/or config
> parameters would be for the cases above.  Any ideas?

I explicitly avoided suggesting something in my previous email exactly 
because I don't have a clear idea myself for a sensible parameter.  ;-)

Maybe using a negative window size could mean it is dynamic, but caped 
to the provided absolute value?  Although a bit strange, this is still a 
specialized mode of operation and having an odd argument for it 
shouldn't rebute those who understands the implication and are willing 
to use it.  The more natural mode of operation with a memory cap is not 
to change the end result but maybe experience a slowdown (what the 
merged patch does), which is why I considered that patch good.


Nicolas
