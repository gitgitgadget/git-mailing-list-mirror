From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/6] give "nbuf" strbuf a more meaningful name
Date: Sun, 31 Jan 2016 13:01:02 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601311300400.2964@virtualbox>
References: <20160131112215.GA4589@sigill.intra.peff.net> <20160131112526.GA5116@sigill.intra.peff.net> <alpine.DEB.2.20.1601311245170.2964@virtualbox> <20160131115947.GA5438@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 13:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqgw-0003af-5A
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 13:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbcAaMBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 07:01:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:52845 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757303AbcAaMBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 07:01:14 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lymoh-1a2lBJ47CJ-016BIj; Sun, 31 Jan 2016 13:01:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160131115947.GA5438@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qbNEix3m5GwCy7zkMBBSJCnwbw0gLT/C8VE2tT3TsSAPrrGU04F
 tnI9ODCIS0LYqEFkk6xeuVAd2riqq0LtFMkLEkObaQxRQ/ERuwaHFEIwmIT4gQXYEicvViK
 bPDgMeZMFXz6Xc3BFxWXJmxCtGwXUZ+UL2uiY6DG0TsqZJRM6lvzseNTXErPMgx2OYjsSbo
 0Gwd7o3IfVm+DlPpn5u0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pctw3lzUwoI=:dA2ti/x0HhqjP2igICL5GX
 MtiWeeo1qSSPKP/rda/TlxY+3/ojVFNJD1mH6Fx3vDOtMT0/0f9TlkWbUyg4n93VjpOlLIUEQ
 FsRytqCnpwJsoIb/WuFbteBuc8A2d1VQsGUwcC9xexf0UijdgqvpmCmTROefsXl1UElg0H13+
 n/NsUhTnmIMoWxXutNhEo+x4LqdkRZX2VAIMZF2lIDFmOoCq3greACbBSJQdPpOqRx+XAhvBz
 rNA2l1+3oClVks7I5TnFZcHgFUc46ZS0ggv/kD7Jq/oh6/cf/Hkb5p+ll4SEYS/Y8AJaJtrfZ
 tsC6EE2ML/y/onkuuNvgLk11ixwAEyaqmR6Doj2GGkQBNR3HE6+21EgHwn0GVAVf6H/A3Y4+u
 kr30yYzwDYtvSCPFVgp5InemAjpETZT3glMQRs0qR0YqTZspBXqVqIcZzWXKHTHHswaxDVdDX
 Xsn5AIOcC63PfQfbyXPc+MyKcWyM+0XRdaU4ffbyFadCRoVrA9iAtlvuccaojhB0MiQPdh+vE
 MyGZOGOIw+M0OwGfnMODa0JD91p4WOca57ilYV8A3OmTj6h+txJLuorEaH5DonWmCuLL4eABr
 NgQgn8hBo6jE9wjK9W+YTyTefoRrrzk9b1ciwFylbJrYIlfuwMEjRzvIYnKMEW1e394So6XO/
 EixXLxRcB7bRfbr3dQRCS93TM6MkgbCqie/RTsuvjap1tZ9V82bBWVluoUIzVWwPZJTlu2lGI
 pmLnyQkuaRLK9zUAy2/bc1ymabjG/Cc6iPwQj3kaEIBwLGuzQXAY3QiQCpPnzvu45YJMNHHN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285145>

Hi Peff,

On Sun, 31 Jan 2016, Jeff King wrote:

> On Sun, Jan 31, 2016 at 12:54:29PM +0100, Johannes Schindelin wrote:
> 
> > On Sun, 31 Jan 2016, Jeff King wrote:
> > 
> > > > It's a shame that we can't just factor out this common
> > > > code, but I don't think it's quite long enough to merit
> > > > the boilerplate. The interesting part of each function
> > > > happens inside the loop. If C had lambdas, we could do
> > > > something like:
> > > > 
> > > >   foreach_path_from(stdin, nul_term_line) {
> > > >         /* now do something interesting with "buf"
> > > >            and some other local variables */
> > > >   }
> > 
> > Technically, we do not have to do lambdas for that paradigm, we could
> > introduce a new data type and a reader, i.e. something like this:
> > [...]
> > And then the repeated code could be replaced by something like this:
> > 
> > 	struct path_reader path_reader = PATH_READER_INIT;
> > 
> > 	while (read_next_path(&reader, stdin, 1)) {
> > 		... [work with reader->path.buf] ...
> > 	}
> > 
> > 	cleanup_path_reader();
> 
> Yeah, you're right. I was thinking of lifting the loop completely out of
> the call-sites, but simplifying it to a single line loop condition is
> just as good.
> 
> I still think this crosses my line of "too much boilerplate to be worth
> it", though.

Oh, I totally agree. Just wanted to point out that there are other
options.

Ciao,
Dscho
