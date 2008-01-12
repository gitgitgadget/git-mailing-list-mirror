From: Nicolas Pitre <nico@cam.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Sat, 12 Jan 2008 11:09:29 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801121053080.3054@xanadu.home>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net>
 <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net>
 <4785A6DB.3080007@vilain.net> <20080110091607.GA17944@artemis.madism.org>
 <alpine.LFD.1.00.0801101332150.3054@xanadu.home>
 <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
 <478691EB.1080704@vilain.net>
 <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
 <47869C24.3000400@vilain.net>
 <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org>
 <4786BFCD.1000303@vilain.net>
 <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org>
 <47870CDF.4010606@vilain.net>
 <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
 <47881D44.9060105@vilain.net> <alpine.LFD.1.00.0801112125470.3054@xanadu.home>
 <47882EC5.2080406@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDivu-0006mM-PU
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 17:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYALQJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 11:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbYALQJb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 11:09:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15400 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYALQJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 11:09:30 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUJ007C2GVTPKB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 12 Jan 2008 11:09:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <47882EC5.2080406@vilain.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70327>

On Sat, 12 Jan 2008, Sam Vilain wrote:

> Nicolas Pitre wrote:
> > Sorry to rain on your parade, but to me 6-10% time saving is not a clear 
> > win at all, given the equal increase in repository size.  This is simply 
> > not worth it.
> 
> Agree.
> 
> > And a 50% time saving on an operation, such a git log, which takes less 
> > than 2 seconds in absolute time, is not worth the repo size increase 
> > either.
> 
> Disagree.  Going as much as twice as fast for many history operations
> for 10% added space sounds like a clear win to me.

If you can come with a real life scenario, and not simply a simple test 
having little relevance with typical usage, that shows a clear reduction 
in execution time which is human perceptible, then I'll agree with you.  
But doing a full history log taking one second instead of two isn't a 
good enough argument  to me for making the repository many megabytes 
larger.  Again if it was 'git blame' using 5 seconds instead of 10 then 
I would agree that this is a clear win, even if this is also a 50% 
execution time reduction.  But human perception is way more important 
when it is 10 secs down to 5 compared to 2 secs down to 1.

This proposed change isn't free, because you have to introduce a 
regression in one place in order to make a gain somewhere else. The pack 
v4 format that I developed with Shawn, though, was showing _both_ a 
speed gain and a repository size reduction, hence there is no regression 
for the added improvements.  *That* is a clear win.

> We can easily agree
> to disagree though

I suppose we do.


Nicolas
