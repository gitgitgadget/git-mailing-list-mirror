From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 01:23:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907260123090.8306@pacific.mpi-cbg.de>
References: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de> <20090725004122.GA28477@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
 <20090725215739.d074e947.tihirvon@gmail.com> <20090725203130.GB1640@glandium.org> <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain> <alpine.LFD.2.01.0907251406390.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Timo Hirvonen <tihirvon@gmail.com>,
	git@vger.kernel.org, "Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqaz-0002hw-Rc
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZGYXX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 19:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbZGYXX6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:23:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:43009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752213AbZGYXX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 19:23:58 -0400
Received: (qmail invoked by alias); 25 Jul 2009 23:23:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 26 Jul 2009 01:23:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qA7gmpucqD4qjgjvlclzynv8tCba4Of+bWekLuC
	0fiHcS32LqyEOx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0907251406390.3960@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124095>

Hi,

On Sat, 25 Jul 2009, Linus Torvalds wrote:

> On Sat, 25 Jul 2009, Linus Torvalds wrote:
> >
> > The fact that apparently sometimes it's less bloated than other times 
> > doesn't really change anything fundamental, does it?
> 
> Btw, does anybody know how/why libdl seems to get linked in too?
> 
> We're not doing -ldl, and I'm not seeing any need for it, but it's 
> definitely there on fedora, at least.
> 
> It seems to come from libcrypto. I can get rid of it with NO_OPENSSL, and 
> that cuts down on the number of system calls in my startup by 16 (getting 
> rid of both libcrypto and libdl). I wonder if there is some way to get the 
> optimized openssl sha1 routines _without_ that silly ldl thing.

OpenSSL allows for so-called engines implementing certain algorithms.  
These engines are dynamic libraries, loaded via dlopen().

Ciao,
Dscho
