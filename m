From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 10:46:56 -0400
Message-ID: <20070420144656.GA17480@spearce.org>
References: <11770585393395-git-send-email-junkio@cox.net> <1177058540390-git-send-email-junkio@cox.net> <alpine.LFD.0.98.0704200900460.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 20 16:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeuOW-0004uY-9X
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 16:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767114AbXDTOrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767115AbXDTOrE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 10:47:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40316 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767114AbXDTOrB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 10:47:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HeuNw-00073e-Sb; Fri, 20 Apr 2007 10:46:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 518EF20FBAE; Fri, 20 Apr 2007 10:46:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704200900460.4504@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45109>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 20 Apr 2007, Junio C Hamano wrote:
> 
> > Originally I thought it would take too long to check out many
> > files and to prevent people from getting bored, I added progress
> > meter.  But it feels a bit too noisy; let's disable it.
...
> What about looking at the number of files checked out after say 2 
> seconds, and if it is still below 50% of the total then turn on the 
> progress display?

I agree completely with Nico, and everyone else.

Nico's approach is the right way to handle that particular progress
meter.  It should also be enabled the same way in git-checkout.sh
and git-merge.sh (for the fast-forward case).

On Windows, with a cheap+slow 5400 RPM IDE drive, a slow processor
and a virus scanner that has higher priority than the mouse driver,
a simple branch switch that updates only 500 files (out of almost
10,000) can take 30 seconds.  Ok, sure, maybe I shouldn't switch
branches on such horrid hardware[*1*], but a progress meter would
be very nice for when I do.

On the other hand, the one I removed from merge-recursive was
braindamaged.  It only knew the amount of work remaining once it
had finished it.  That meant the meter was completely useless.
Though maybe something based on a 2 second timer like Nico is
proposing for read-tree might still be useful in merge-recursive.


*1*: Of course my Solaris 9 system does that switch so fast it makes
     my head spin.  Ahh, what a good system modern UNIXes are...

-- 
Shawn.
