From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 19:10:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de> <20100214024259.GB9704@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 19:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngip4-0003TY-CV
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 19:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab0BNSDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 13:03:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:53075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751494Ab0BNSD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 13:03:29 -0500
Received: (qmail invoked by alias); 14 Feb 2010 18:03:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 14 Feb 2010 19:03:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+C7JhjJZqCFDzdBTcS//eYgKB0r52+zqyqzQhT+g
	3VcfeAIIVXCIS3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100214024259.GB9704@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139928>

Hi,

On Sun, 14 Feb 2010, Dmitry Potapov wrote:

> On Sun, Feb 14, 2010 at 02:53:58AM +0100, Johannes Schindelin wrote:
> > On Sun, 14 Feb 2010, Dmitry Potapov wrote:
> > 
> > > +	if (strbuf_read(&sbuf, fd, 4096) >= 0)
> > 
> > How certain are you at this point that all of fd's contents fit into 
> > your memory?
> 
> You can't be sure... In fact, we know mmap() also may fail for huge
> files, so can strbuf_read().

That's comparing oranges to apples. In one case, the address space runs 
out, in the other the available memory. The latter is much more likely.

> > And even if you could be certain, a hint is missing that 
> > strbuf_read(), its name notwithstanding, does not read NUL-terminated 
> > strings. Oh, and the size is just a hint for the initial size, and it 
> > reads until EOF. That has to be said in the commit message.
> 
> I did not add _any_ new code, including the above line. It was there
> before my patch.

But that explanation does not answer my question, does it? And my question 
was not unreasonable to ask, was it?

Ciao,
Dscho
