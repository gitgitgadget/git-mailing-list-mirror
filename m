From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 21:38:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 02:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSkLo-0005UK-EQ
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 02:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbXCRBiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 21:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbXCRBiS
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 21:38:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17370 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbXCRBiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 21:38:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF2002QXSJSD2G0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 17 Mar 2007 21:38:16 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42465>

On Sat, 17 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Sat, 17 Mar 2007, Morten Welinder wrote:
> >
> > >         samples  %        app name                 symbol name
> > >         41527    15.6550  git                      strlen
> > 
> > Almost 16% in strlen?  Ugh!
> > 
> > That's a lot of strings, or perhaps very long strings.  Or a profiling bug.
> 
> It's likely real, and the problem is likely lots of small strings.
> 
> Each git tree entry is:
> 
> 	"<octal mode> name\0" <20-byte sha1>
> 
> so you do have a *lot* of strlen() calls when doing any tree parsing.

This is definitely an area where pack v4 will bring that cost down to 
zero.


Nicolas
