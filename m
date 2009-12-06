From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: clang static analyzer
Date: Sun, 06 Dec 2009 10:39:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912061032380.31174@xanadu.home>
References: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
 <20091206145744.GA6725@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tomas Carnecky <tom@dbservice.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 16:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJDX-0006KM-Pa
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 16:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933867AbZLFPju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 10:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933832AbZLFPju
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 10:39:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55953 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933828AbZLFPju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 10:39:50 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KU8003F5M6K7X20@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 Dec 2009 10:39:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091206145744.GA6725@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134666>

On Sun, 6 Dec 2009, Jeff King wrote:

> On Sun, Dec 06, 2009 at 07:11:24AM +0100, Tomas Carnecky wrote:
> 
> > Clang again found many dead assignments/increments, but in the earlier
> > discussions you concluded that you want to keep those around. So I
> > focussed on another class of potential bugs: Argument with 'nonnull'
> > attribute passed null. There were a total of seven such issues. I then
> > tried to look through the code and see if they are valid or false
> > positives:
> 
> Thanks, I think you are moving in the right direction to manually
> investigate the output of clang, since it obviously does generate some
> false positives.
> 
> I think the next step for each site you found would be:
> 
>   1. If it really is a problem, then it should be easy to show a simple
>      case that can trigger the issue. Submit a patch fixing that site,
>      either describing the test case in the commit message, or adding a
>      case to the test suite.
> 
>   2. If it is a false positive, see what it would take to silence clang
>      and submit a patch.  I don't think we are opposed to annotations
>      that help analysis tools as long as those annotations aren't too
>      intrusive or make the code less readable.

I'm a bit skeptical here.  Going down that route might mean that we'll 
eventually have to add all sort of crap to accommodate everyone's 
preferred static analysis tool of the day.  Would be far nicer to try to 
make those tools more intelligent instead, or at least make them 
understand an out-of-line annotation format that does not clutter the 
code itself.


Nicolas
