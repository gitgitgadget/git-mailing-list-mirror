From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 13:39:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161335260.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <Pine.LNX.4.64.0710160032020.7638@iabervon.org> <E1IhgT2-0000bg-O6@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com,
	ae@op5.se, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihlhz-0004tx-TB
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758669AbXJPMjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758728AbXJPMjU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:39:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:37823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757698AbXJPMjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 08:39:19 -0400
Received: (qmail invoked by alias); 16 Oct 2007 12:39:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 16 Oct 2007 14:39:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+34uVfze23goOXKvrjaLatvYkYMUu6l+hvgedcAa
	mr8V/D52/lYOtE
X-X-Sender: gene099@racer.site
In-Reply-To: <E1IhgT2-0000bg-O6@fencepost.gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61157>

Hi,

[culled make-w32, as per explicit request]

On Tue, 16 Oct 2007, Eli Zaretskii wrote:

> > Date: Tue, 16 Oct 2007 01:56:46 -0400 (EDT)
> > From: Daniel Barkalow <barkalow@iabervon.org>
> > cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se, 
> >     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
> > 
> > Ah, that's helpful. We don't actually care too much about the 
> > particular info in stat; we just want to know quickly if the file has 
> > changed, so we can hash only the ones that have been touched and get 
> > the actual content changes.
> 
> As I wrote in my other message, using native APIs improves performance 
> by at least a factor of two.

Somehow this does not appeal to my "portability is good" side.  You know, 
if we had to do such trickeries for every platform we support, we'd soon 
be as big as Subversion *cough*.

For me, this is the most annoying part about programming Win32.  They went 
out of their way to make it incompatible with everything else, and as a 
consequence it is a PITA to maintain crossplatform programs.

> > The tricky thing is that, while the optimization process is running, 
> > other programs may be reading the database, so (1) the files that are 
> > no longer needed, because better-optimized versions are in place, may 
> > be open in another task
> 
> Is this because another user might be accessing the database, or are 
> there other popular use cases that cause this?  If the former, then this 
> is not terribly important on Windows, since the situation when more than 
> one user is logged and actively works is quite rare, basically limited 
> to some scheduled task (the equivalent of a cron job) running for some 
> user while another one is logged in interactively.

Quite to the contrary.  Explorer often accesses files it should not lock.  
On the machine I test msysGit on, this is the most common reason for a 
test case to fail: it cannot delete the temporary directory, which 
_should_ be unused.  Indeed, a second after that, it _is_ unused.

Ciao,
Dscho
