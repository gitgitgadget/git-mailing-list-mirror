From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 18:33:26 -0500
Message-ID: <4aca3dc20712071533k3189d25dp901c5941e5326ead@mail.gmail.com>
References: <20071206.193121.40404287.davem@davemloft.net>
	 <20071207063848.GA13101@coredump.intra.peff.net>
	 <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
	 <20071207.045329.204650714.davem@davemloft.net>
	 <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org>
	 <4759AC8E.3070102@develer.com> <m3hciutaoq.fsf@roke.D-201>
	 <1197069298.6118.1.camel@ozzu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"David Miller" <davem@davemloft.net>, jonsmirl@gmail.com,
	peff@peff.net, nico@cam.org, harvey.harrison@gmail.com,
	ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "Giovanni Bajo" <rasky@develer.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 00:33:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0mha-00025u-E2
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 00:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXLGXd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbXLGXd2
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 18:33:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:40260 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbXLGXd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 18:33:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so863522rvb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 15:33:26 -0800 (PST)
Received: by 10.142.100.1 with SMTP id x1mr2492118wfb.1197070406100;
        Fri, 07 Dec 2007 15:33:26 -0800 (PST)
Received: by 10.142.199.2 with HTTP; Fri, 7 Dec 2007 15:33:26 -0800 (PST)
In-Reply-To: <1197069298.6118.1.camel@ozzu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67487>

On 12/7/07, Giovanni Bajo <rasky@develer.com> wrote:
> On Fri, 2007-12-07 at 14:14 -0800, Jakub Narebski wrote:
>
> > > >> Is SHA a significant portion of the compute during these repacks?
> > > >> I should run oprofile...
> > > > SHA1 is almost totally insignificant on x86. It hardly shows up. But
> > > > we have a good optimized version there.
> > > > zlib tends to be a lot more noticeable (especially the
> > > > *uncompression*: it may be faster than compression, but it's done _so_
> > > > much more that it totally dominates).
> > >
> > > Have you considered alternatives, like:
> > > http://www.oberhumer.com/opensource/ucl/
> >
> > <quote>
> >   As compared to LZO, the UCL algorithms achieve a better compression
> >   ratio but *decompression* is a little bit slower. See below for some
> >   rough timings.
> > </quote>
> >
> > It is uncompression speed that is more important, because it is used
> > much more often.
>
> I know, but the point is not what is the fastestest, but if it's fast
> enough to get off the profiles. I think UCL is fast enough since it's
> still times faster than zlib. Anyway, LZO is GPL too, so why not
> considering it too. They are good libraries.


At worst, you could also use fastlz (www.fastlz.org), which is faster
than all of these by a factor of 4 (and compression wise, is actually
sometimes better, sometimes worse, than LZO).
