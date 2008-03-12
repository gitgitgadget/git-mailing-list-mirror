From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Wed, 12 Mar 2008 14:11:17 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803121410090.1656@racer.site>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com> <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain> <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com> <20080311173536.GA14687@sigill.intra.peff.net>
 <20080311174045.GB14687@sigill.intra.peff.net> <7vhcfc8tu7.fsf@gitster.siamese.dyndns.org> <20080312124336.GA7873@coredump.intra.peff.net> <20080312124825.GA8447@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Whit Armstrong <armstrong.whit@gmail.com>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 14:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZQkK-0005Z8-Nj
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 14:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbYCLNLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 09:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYCLNLN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 09:11:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:35959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751591AbYCLNLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 09:11:13 -0400
Received: (qmail invoked by alias); 12 Mar 2008 13:11:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 12 Mar 2008 14:11:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LfGoxWkhLKFdrHsNmx0ofMCoEU6otoG2LWZeZdE
	5e8H1QdaHUSfzC
X-X-Sender: gene099@racer.site
In-Reply-To: <20080312124825.GA8447@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76949>

Hi,

On Wed, 12 Mar 2008, Jeff King wrote:

> On Wed, Mar 12, 2008 at 08:43:36AM -0400, Jeff King wrote:
> 
> > It seems that /usr/bin/tr silently removes NULs from the input stream:
> > 
> >   $ printf 'foo\000bar' | xxd
> >   0000000: 666f 6f00 6261 72                        foo.bar
> >   $ printf 'foo\000bar' | /usr/bin/tr '\000' 'Q' | xxd
> >   0000000: 666f 6f62 6172                           foobar
> > 
> > I don't think there is an easy way around this; we might have to switch
> > to using perl.
> 
> Even more exciting, /usr/bin/tr actually works going the opposite
> direction, but /usr/ucb/tr doesn't:
> 
>   $ echo x | /usr/bin/tr x '\000' | xxd
>   0000000: 000a                                     ..
>   $ echo x | /usr/ucb/tr x '\000' | xxd
>   0000000: 780a                                     x.
> 
> but other characters seem to work:
> 
>   $ echo x | /usr/ucb/tr x '\012' | xxd
>   0000000: 0a0a                                     ..

All the more reson to make more things builtin.  (I agree that for tests, 
we should stay with tr, though.)

Ciao,
Dscho
