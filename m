From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sat, 24 Jan 2009 01:33:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901240131570.3586@pacific.mpi-cbg.de>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
 <20090123230520.GL21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQWTZ-0007vJ-OV
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 01:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbZAXAcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 19:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbZAXAcy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 19:32:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:47624 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752797AbZAXAcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 19:32:54 -0500
Received: (qmail invoked by alias); 24 Jan 2009 00:32:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 24 Jan 2009 01:32:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18v84YBI2wvL41JI2u826H8CbUN8vmc9Coxq6FHCR
	gh5idmLmfOhHkI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090123230520.GL21473@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106934>

Hi,

On Sat, 24 Jan 2009, Miklos Vajna wrote:

> On Fri, Jan 23, 2009 at 03:42:24AM +0100, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> > > > I am mostly worried about a failure case (connected but couldn't 
> > > > get the refs, or perhaps connection failed to start).  If you get 
> > > > a NULL in such a case you may end up saying "oh you cloned a void" 
> > > > when you should say "nah, such a remote repository does not 
> > > > exist".
> > > 
> > > Yes, this was my concern as well.
> > 
> > From what I can see in get_remote_heads(), the native protocols would 
> > die(), as would rsync().
> > 
> > HTTP transport, however, would not die() on connection errors, from my 
> > cursory look.
> 
> I'm not familiar with the HTTP code, either, but here is the call stack 
> I see:
> 
> - builtin-clone calls transport_get_remote_refs()
> - that will call transport->get_refs_list()
> - that will call get_refs_via_curl()
> - that die()s on error, does not use return error()
> 
> Have I missed something?

Not really.

Only after writing my email (and just before sending) did I remember that 
I have Mike's HTTP cleanups applied in my Git checkout.  So I was 
analyzing the wrong code.

Thanks for analyzing the right code.

Ciao,
Dscho
