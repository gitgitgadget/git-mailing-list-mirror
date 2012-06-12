From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 15:09:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1206121507120.23555@xanadu.home>
References: <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <CAJo=hJvMtfVhadYowvVE0zUhDpbViXqGsvkmHpJpuynySLwb3A@mail.gmail.com>
 <20120612175046.GA16522@sigill.intra.peff.net> <m2fwa0fk0y.fsf@igel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeWT5-0000gM-B4
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 21:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab2FLTJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 15:09:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57631 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab2FLTJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 15:09:26 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M5I00AQ7QJPTMI0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 12 Jun 2012 15:09:26 -0400 (EDT)
In-reply-to: <m2fwa0fk0y.fsf@igel.home>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199834>

On Tue, 12 Jun 2012, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We could close it in both cases by tweaking the mtime of the file
> > containing the object when we decide not to write because the object
> > already exists.
> 
> Though there is always the window between the existence check and the
> mtime update where pruning can hit you.

This is a tiny window compared to 2 weeks.

This could be avoided entirely with:

1. check presence of object X

2. update its mtime

3. check presence of object X again

4. create if doesn't exist


Nicolas
