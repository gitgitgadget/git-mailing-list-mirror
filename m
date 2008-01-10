From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 16:30:59 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801101613050.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
 <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org>
 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
 <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:31:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD50H-00087I-PJ
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbYAJVb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYAJVb1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:31:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35818 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbYAJVb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:31:26 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUG00E3R6FNGK60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jan 2008 16:31:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70095>

On Thu, 10 Jan 2008, Linus Torvalds wrote:

> 
> 
> On Thu, 10 Jan 2008, Nicolas Pitre wrote:
> > 
> > Here's my rather surprising results:
> > 
> > My kernel repo pack size without the patch:	184275401 bytes
> > Same repo with the above patch applied:		205204930 bytes
> > 
> > So it is only 11% larger.  I was expecting much more.
> 
> It's probably worth doing those statistics on some other projects.
> 
> Maybe the difference to other repositories isn't huge, and maybe the 
> kernel *is* a good test-case, but I just wouldn't take that for granted. 

Obviously.

This was a really crud test, and my initial goal was to quickly dismiss 
Pierre's assertion.  Turns out that he wasn't that wrong after all, and 
if a significant increase in access speed by avoiding zlib for 82% of 
object accesses can also be demonstrated for the kernel, then we have an 
opportunity for some optimization tradeoff with no backward 
compatibility concerns.

> Yes, delta's are bound to compress much less well than non-deltas, and 
> especially for tree objects (which is a large chunk of them) they probably 
> compress even less (because a big part of the delta is actually just the 
> SHA1 changes), but if it's 11% on the kernel, it could easily be 25% on 
> something else.

Right.  But again this is not worth pursuing if a significant speed 
increase in repo access is not demonstrated at least with the kernel.


Nicolas
