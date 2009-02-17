From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Tue, 17 Feb 2009 16:39:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171639060.6185@intel-tinevez-2-302>
References: <20090217060944.488184b0.chriscool@tuxfamily.org>  <alpine.DEB.1.00.0902171542490.6185@intel-tinevez-2-302>  <43d8ce650902170711r1edb1e40udfacce4b9123b0a5@mail.gmail.com>  <alpine.DEB.1.00.0902171630130.6185@intel-tinevez-2-302>
 <43d8ce650902170736h6316f987qc783edeebf488b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZS4u-00028J-1r
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbZBQPj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbZBQPj6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:39:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:44496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753692AbZBQPj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 10:39:57 -0500
Received: (qmail invoked by alias); 17 Feb 2009 15:39:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp001) with SMTP; 17 Feb 2009 16:39:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19umDRn5pJugOXneoccZjiZfWFyl+1L/wYmsF+zYz
	qz6BPqsbsPUxkO
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <43d8ce650902170736h6316f987qc783edeebf488b40@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110404>

Hi,

On Tue, 17 Feb 2009, John Tapsell wrote:

> 2009/2/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Tue, 17 Feb 2009, John Tapsell wrote:
> >
> >> 2009/2/17 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >>
> >> > On Tue, 17 Feb 2009, Christian Couder wrote:
> >> >
> >> >> +static int estimate_bisect_steps(int all)
> >> >> +{
> >> >> +     int log2 = 0;
> >> >> +     int left = (all >> 1) - 1;
> >> >> +
> >> >> +     if (left <= 0)
> >> >> +             return 0;
> >> >> +
> >> >> +     do {
> >> >> +             left = left >> 1;
> >> >> +             log2++;
> >> >> +     } while (left);
> >> >> +
> >> >> +     return log2;
> >> >> +}
> >> >
> >> > How about this instead, calling it from cmd_rev_list directly?
> >> >
> >> >        static int log2(int n)
> >> >        {
> >> >                int log2;
> >> >
> >> >                for (log2 = 0; n > 1; log2++)
> >> >                        n >>= 1;
> >> >
> >> >                return log2;
> >> >        }
> >>
> >> This would work, if you want a non-iterative solution
> >>
> >> unsigned int log2_integer_approximate(unsigned int n){
> >> *((float*)&n) = (float)n;
> >> return ((n & (~((1<<23) - 1))) >> 23) - 127;
> >> }
> >
> > That assumes that your floats are IEEE floats, right?
> 
> Yeah.  Is it a bad assumption? Does git run on any system in which they 
> aren't?

Only when you are porting Git to embedded devices.

Don't moan: there exists a git-daemon for iPhone.  Oh, wait!  /me 
scribbles that down for the UGFWIINI contest.

Ciao,
Dscho
