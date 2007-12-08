From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and GCC
Date: Sat, 8 Dec 2007 12:00:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712081156450.27959@racer.site>
References: <20071206.193121.40404287.davem@davemloft.net> 
 <20071207063848.GA13101@coredump.intra.peff.net> 
 <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com> 
 <20071207.045329.204650714.davem@davemloft.net> 
 <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org> 
 <4759AC8E.3070102@develer.com> <m3hciutaoq.fsf@roke.D-201> 
 <1197069298.6118.1.camel@ozzu> <4aca3dc20712071533k3189d25dp901c5941e5326ead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giovanni Bajo <rasky@develer.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, jonsmirl@gmail.com,
	peff@peff.net, nico@cam.org, harvey.harrison@gmail.com,
	ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 13:01:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0yNK-0008JI-V7
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 13:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXLHMBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 07:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXLHMBW
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 07:01:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:54113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751704AbXLHMBV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 07:01:21 -0500
Received: (qmail invoked by alias); 08 Dec 2007 12:01:19 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 08 Dec 2007 13:01:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mHjBn+gNmRufhhHjDAy3Zx/6DrPcdVgyZUnka0o
	VAdEKKznJgzTNn
X-X-Sender: gene099@racer.site
In-Reply-To: <4aca3dc20712071533k3189d25dp901c5941e5326ead@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67548>

Hi,

On Fri, 7 Dec 2007, Daniel Berlin wrote:

> On 12/7/07, Giovanni Bajo <rasky@develer.com> wrote:
> > On Fri, 2007-12-07 at 14:14 -0800, Jakub Narebski wrote:
> >
> > > > >> Is SHA a significant portion of the compute during these 
> > > > >> repacks? I should run oprofile...
> > > > > SHA1 is almost totally insignificant on x86. It hardly shows up. 
> > > > > But we have a good optimized version there. zlib tends to be a 
> > > > > lot more noticeable (especially the *uncompression*: it may be 
> > > > > faster than compression, but it's done _so_ much more that it 
> > > > > totally dominates).
> > > >
> > > > Have you considered alternatives, like: 
> > > > http://www.oberhumer.com/opensource/ucl/
> > >
> > > <quote>
> > >   As compared to LZO, the UCL algorithms achieve a better 
> > >   compression ratio but *decompression* is a little bit slower. See 
> > >   below for some rough timings.
> > > </quote>
> > >
> > > It is uncompression speed that is more important, because it is used 
> > > much more often.
> >
> > I know, but the point is not what is the fastestest, but if it's fast 
> > enough to get off the profiles. I think UCL is fast enough since it's 
> > still times faster than zlib. Anyway, LZO is GPL too, so why not 
> > considering it too. They are good libraries.
> 
> 
> At worst, you could also use fastlz (www.fastlz.org), which is faster 
> than all of these by a factor of 4 (and compression wise, is actually 
> sometimes better, sometimes worse, than LZO).

fastLZ is awfully short on details when it comes to a comparison of the 
resulting file sizes.

The only result I saw was that for the (single) example they chose, 
compressed size was 470MB as opposed to 361MB for zip's _fastest_ mode.

Really, that's not acceptable for me in the context of git.

Besides, if you change the compression algorithm you will have to add 
support for legacy clients to _recompress_ with libz.  Which most likely 
would make Sisyphos grin watching them servers.

Ciao,
Dscho
