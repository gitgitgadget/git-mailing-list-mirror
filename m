From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: counting the number of connections?
Date: Thu, 5 Mar 2009 18:00:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051758440.6524@intel-tinevez-2-302>
References: <be6fef0d0902272244q468b1fa4sacdc15afa9a65f15@mail.gmail.com> <87ab80j649.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1659875432-1236272418=:6524"
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: =?ISO-8859-15?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Mar 05 18:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGxH-0003bp-CP
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 18:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbZCERAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 12:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755049AbZCERAW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 12:00:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754672AbZCERAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 12:00:21 -0500
Received: (qmail invoked by alias); 05 Mar 2009 17:00:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 05 Mar 2009 18:00:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ULllZnn1UBjrXHXojHZBD7TAUx+3Kg2jJGk9ggR
	HV02xxIAnXJ7kw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <87ab80j649.fsf@krank.kagedal.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112321>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1659875432-1236272418=:6524
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Mar 2009, David Kågedal wrote:

> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> > some time ago I noticed curl doesn't remember your credentials (apart 
> > from those it can get from ~/.netrc), and very recently there was an 
> > thread on repeated prompting for credentials while pushing to https.
> >
> > I've written a simple patch series, which allows git to play nice
> > without curl_multi. That is, git uses a single persistent connection
> > throughout.
> >
> > However, I'm at a loss at how to test for this. How does one count the
> > number of connections made during the lifespan of a program's
> > execution? So far, I've been relying on my firewall log (Comodo on
> > windows). Perhaps there a more operating system/software-agnostic
> > method to do this?
> 
> You could set up a single-use tcp forwarder which will make any second
> connection fail. Using socat, for instance:
> 
>   $ socat tcp-listen:2222,bind=localhost tcp:my.server:22 &
>   $ nc localhost 2222
>   SSH-2.0-OpenSSH_5.1p1 Debian-3ubuntu1
>   ^C
>   $ nc localhost 2222
>   localhost [127.0.0.1] 2222 (?) : Connection refused

AFAICT Ray wants to provide tests for Git's test suite, and introducing 
socat as a dependency for our tests does not really fly all that well.

But IIRC somebody convinced Ray that it is better to require a new-enough 
cURL version so that the patch becomes moot itself.

Ciao,
Dscho

--8323329-1659875432-1236272418=:6524--
