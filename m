From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Sun, 24 Feb 2008 11:06:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0802241100350.6881@eeepc-johanness>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>  <87skznhqk6.fsf@rho.meyering.net>  <7vzlts9ag8.fsf@gitster.siamese.dyndns.org>  <87ir0gx5bn.fsf@rho.meyering.net>  <7vskzk99fd.fsf@gitster.siamese.dyndns.org>  <87tzk0tzjz.fsf@rho.meyering.net>
 <118833cc0802230530l104acc72k20ceb4b5adcff937@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTDky-0000vf-90
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYBXKGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 05:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYBXKGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:06:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:54730 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751219AbYBXKGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 05:06:16 -0500
Received: (qmail invoked by alias); 24 Feb 2008 10:06:13 -0000
Received: from R3f77.r.pppool.de (EHLO eeepc-johanness.samsung.router) [89.54.63.119]
  by mail.gmx.net (mp046) with SMTP; 24 Feb 2008 11:06:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RdCdYOPKR1MmT4myW0jzGt6NyMikTczUu9z95pq
	c7cmaX5xT+sdjH
X-X-Sender: user@eeepc-johanness
In-Reply-To: <118833cc0802230530l104acc72k20ceb4b5adcff937@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74918>

Hi,

On Sat, 23 Feb 2008, Morten Welinder wrote:

> > +inline void gitfree(void *ptr)
> >  +{
> >  +       if (ptr)
> >  +               free(ptr);
> >  +}
> >  +#define free gitfree
> >  +#endif
> 
> I am wondering why you do it this way.  "#define free gitfree" is just
> not valid in a C program that includes the relevant standard header.
> "free" is a reserved symbol.
> 
> To stay within the standard, do the define the other way and use
> gitfree everywhere.

We do it this way for other things like fopen, too.

Besides, I think that there should be at least one _real_ case where it 
actually _breaks_ before we have a big, ugly, change where it is easy to 
overlook a non-converted "free()", instead of a nice, clean and short 
patch.

Ciao,
Dscho
