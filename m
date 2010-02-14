From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 20:28:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>  <20100213133951.GA14352@Knoppix>  <201002131539.54142.trast@student.ethz.ch>  <20100213162924.GA14623@Knoppix>  <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> 
 <20100213223733.GP24809@gibbs.hungrycats.org>  <20100214011812.GA2175@dpotapov.dyndns.org>  <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>  <20100214024259.GB9704@dpotapov.dyndns.org>  <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com> <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 20:22:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngk2e-0000EG-0H
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 20:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab0BNTV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 14:21:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:58552 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752944Ab0BNTV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 14:21:58 -0500
Received: (qmail invoked by alias); 14 Feb 2010 19:21:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 14 Feb 2010 20:21:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19n4Nd2JE5nnF01J1SamrYv/sywbSfunghvBROBH9
	rNV5uKIwnKnkSI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139931>

Hi,

On Sun, 14 Feb 2010, Johannes Schindelin wrote:

> On Sun, 14 Feb 2010, Dmitry Potapov wrote:
> 
> > On Sun, Feb 14, 2010 at 9:10 PM, Johannes Schindelin 
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Sun, 14 Feb 2010, Dmitry Potapov wrote:
> > >
> > >> On Sun, Feb 14, 2010 at 02:53:58AM +0100, Johannes Schindelin 
> > >> wrote:
> > >> > On Sun, 14 Feb 2010, Dmitry Potapov wrote:
> > >> >
> > >> > > + if (strbuf_read(&sbuf, fd, 4096) >= 0)
> > >> >
> > >> > How certain are you at this point that all of fd's contents fit 
> > >> > into your memory?
> > >>
> > >> You can't be sure... In fact, we know mmap() also may fail for huge 
> > >> files, so can strbuf_read().
> > >
> > > That's comparing oranges to apples. In one case, the address space 
> > > runs out, in the other the available memory. The latter is much more 
> > > likely.
> > 
> > "much more likely" is not a very qualitative characteristic...
> 
> Git was touted as a "content tracker". So I use it as such.
> 
> Concrete example: in one of my repositories, the average file size is 
> well over 2 gigabytes.

Just to make extremely sure that you undertand the issue: adding these 
files on a computer with 512 megabyte RAM works at the moment. Can you 
guarantee that there is no regression in that respect _with_ your patch?

Git is in wide use. If you provide a patch, it is not good enough anymore 
if it Works For You(tm), when it Does Not Work Somewhere Else Anymore(tm).

Ciao,
Dscho
