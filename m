From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CR codes from git commands
Date: Wed, 21 Jan 2009 16:38:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901211636340.3586@pacific.mpi-cbg.de>
References: <18805.64312.289059.660023@hungover.brentg.com> <alpine.DEB.1.00.0901201757520.5159@intel-tinevez-2-302> <18806.44057.477379.215492@hungover.brentg.com> <alpine.DEB.1.00.0901210930370.7929@racer> <18807.13411.984420.252378@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 16:40:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfBg-0006so-9k
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 16:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbZAUPiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 10:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbZAUPiv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 10:38:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:50068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750705AbZAUPiv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 10:38:51 -0500
Received: (qmail invoked by alias); 21 Jan 2009 15:38:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 21 Jan 2009 16:38:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dB+1OB13dK9t1SggXQ9+0fLS3jOEk6BTpIJ0wVL
	tjdF12AENkNXuI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <18807.13411.984420.252378@hungover.brentg.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106617>

Hi,

On Wed, 21 Jan 2009, Brent Goodrick wrote:

> Johannes Schindelin writes:
> 
>  > On Tue, 20 Jan 2009, Brent Goodrick wrote:
>  > 
>  > > Johannes Schindelin writes:
>  > > 
>  > >  > On Tue, 20 Jan 2009, Brent Goodrick wrote:
>  > >  > 
>  > >  > > I am considering converting from CVS over to using git. I'm 
>  > >  > > currently using git version 1.5.6.5 on Debian Linux "testing".
>  > >  > 
>  > >  > First of all, 1.5.6.5 is from last August, so chances are that 
>  > >  > the behavior you complain about was fixed in the meantime.  
>  > >  > We're at 1.6.1 at the moment.
>  > > 
>  > > Yes, I thought that was a good point, so I rebuilt from the source 
>  > > tarball git version 1.6.1 and retried my script and got the same 
>  > > behavior.
>  > > 
>  > >  > The only place I can think about where a CR is output is when 
>  > >  > showing the progress of downloading.
>  > >  > 
>  > >  > Usually, our code checks if stdout is a tty, and does not show 
>  > >  > progress.
>  > >  >
>  > >  > As a work-around, piping into cat should work, though.
>  > > 
>  > > Actually only redirecting stderr and then piping to cat seems to work, 
>  > > e.g.,:
>  > > 
>  > >   get pull 2>&1 | cat

In my test I performed one minute ago, "git pull | cat" did not show any 
CR.  Maybe it is the "git" instead of "get" :-)

>  > > I don't mind seeing the progress lines, I just don't want git to 
>  > > emit any CR codes at all.
>  > > 
>  > > How about a config option to just turn off any tty-detecting logic 
>  > > entirely, so that I don't have to wrap git with a lot of silly 
>  > > scripts that set environment variables and redirect stdout and 
>  > > stderr and piped into "cat"?
>  > 
>  > Nope, the config option is not needed.  This is just a Plain Old Bug 
>  > which needs fixing, that's all.
>  > 
>  > Let's see what I can do today.
> 
> Thanks.  The fix should be to arrange it so that I can set something so 
> that a bare call such as (but just "git pull"):
> 
>   git pull
> 
> will emit no CR codes at all, ever, regardless of if there is a tty. 
> Even if it is an env var, but a config setting would be ok too.

I would actually think that it should not be an env var or config setting 
if piping it to "cat" does what you want: if the output is a tty, I think 
it is safe to assume that you want to see the progress, and if you don't, 
"| cat" is not an unreasonable thing to ask for.

Ciao,
Dscho
