From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 17 Feb 2008 19:27:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802171925330.30505@racer.site>
References: <200802102007.38838.lenb@kernel.org> <7vd4r4clnb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802162239090.5496@iabervon.org> <alpine.LSU.1.00.0802171449230.30505@racer.site> <7vhcg71n9u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 20:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpBD-0003ck-EN
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbYBQT12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbYBQT12
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:27:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:46484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbYBQT11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:27:27 -0500
Received: (qmail invoked by alias); 17 Feb 2008 19:27:25 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 17 Feb 2008 20:27:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yJN1j4HTyEEtoXvE8q9VCDrcHYOopOq+yrKk/Ty
	GbO0QNDxv6ZXXk
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcg71n9u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74170>

Hi,

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 16 Feb 2008, Daniel Barkalow wrote:
> >
> >> I wonder if the problem is that something isn't getting reinitialized 
> >> for the second connection. It's not a separate invocation of 
> >> fetch-pack, and I can't say for sure that it's sending the right info 
> >> to the server when the statics in builtin-fetch-pack.c are left over 
> >> from the earlier call. This would particularly explain the 
> >> information that hitting ctrl-c and trying again fixes it.
> >
> > Oh, that should be it!  After all, the code in get_rev() in 
> > builtin-fetch-pack.c marks commits as SEEN and COMMON and POPPED.
> 
> I seem to be slow today, but how does that explain that the problem is 
> reported only by Len so far?

Hmm.  The code I was referencing is only in "next" so far, right?  And 
AFAICT it only occurs when you are fetching something which autofetches 
tags, right?

But thinking about this again: do we reuse the connection also for 
automatic tag fetching?  If not, my whole reasoning is wrong.

Ciao,
Dscho
