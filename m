From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 13:33:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161331440.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <2EA3BEC9-5B13-44D3-B190-CA77499F642C@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Eli Zaretskii <eliz@gnu.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>, tsuna@lrde.epita.fr,
	Andreas Ericsson <ae@op5.se>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:33:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhlcC-0003Yh-J8
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbXJPMda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757698AbXJPMda
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:33:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:50025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755916AbXJPMd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 08:33:29 -0400
Received: (qmail invoked by alias); 16 Oct 2007 12:33:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 16 Oct 2007 14:33:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SGoJxojFSVsc6b+UdUKeLY7N6s4Z2NDTwHMYCzM
	lfv4FmI+RYFLEF
X-X-Sender: gene099@racer.site
In-Reply-To: <2EA3BEC9-5B13-44D3-B190-CA77499F642C@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61154>

Hi,

[culled make-w32 list by explicit request]

On Tue, 16 Oct 2007, Steffen Prohaska wrote:

> On Oct 16, 2007, at 7:14 AM, Andreas Ericsson wrote:
> 
> > Eli Zaretskii wrote:
> > > > Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
> > > > From: Daniel Barkalow <barkalow@iabervon.org>
> > > > cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de,
> > > > ae@op5.se,     tsuna@lrde.epita.fr, git@vger.kernel.org,
> > > > make-w32@gnu.org
> > > > 
> > > > I believe the hassle is that readdir doesn't necessarily report a 
> > > > README in a directory which is supposed to have a README, when it 
> > > > has a readme instead.
> > > Sorry I'm asking potentially stupid questions out of ignorance: why 
> > > would you want readdir to return `README' when you have `readme'?
> > 
> > Because it might have been checked in as README, and since git is case 
> > sensitive that is what it'll think should be there when it reads the 
> > directories. If it's not, users get to see
> > 
> > 	removed: README
> > 	untracked: readme
> > 
> > and there's really no easy way out of this one, since users on a case- 
> > sensitive filesystem might be involved in this project too, so it 
> > could be an intentional rename, but we don't know for sure. Just 
> > clobbering the in-git file is wrong, but overwriting a file on disk is 
> > wrong too. git tries hard to not ever lose any data for the user.
> 
> Maybe we need a configuration similar to core.autocrlf (which controls 
> newline conversion) to control filename comparison and normalization?
> 
> Most obviously for the case (in-)sensitivity on Windows, but I also 
> remember the unicode normalization happening on Mac's HFS filesystem 
> that caused trouble in the past.

Robin Rosenberg has some preliminary code for that.  The idea is to wrap 
all filesystem operations in cache.h, and do a filename normalisation 
first.

Ciao,
Dscho
