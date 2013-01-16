From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 19:01:37 +0000
Message-ID: <20130116190137.GD2476@farnsworth.metanate.com>
References: <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
 <20130116181203.GB2476@farnsworth.metanate.com>
 <20130116181558.GA4426@sigill.intra.peff.net>
 <20130116182240.GC2476@farnsworth.metanate.com>
 <20130116182449.GA4881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvYFQ-0002KT-A1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 20:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab3APTBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 14:01:44 -0500
Received: from dougal.metanate.com ([90.155.101.14]:49323 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756132Ab3APTBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 14:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Uc0TZ/D85LZvQ4H6xi4T459Mbp5z/OMv1MFHbnaIH+E=;
	b=VgXxkua+hFgt8HPVzLWB4nnaKG0ZGugvV7B1bODjC1WxOKvR43rGUAhMlezolnH2d4Eg+AFBL0lr010kK2PEr6SXBb6QaCG7Csoa5GhhLI0aP3xnd/QbR0XYmL9NGH4RVRrmxkP6D30RmPQW3r9d38qQMKuwpMS3PetHNGA0G2D1wpT5hdJoA/zpGux+Hn7NQkFbB3moNFsZnktks3+3Ak3nCiFD8Ts+kOcCjnVBWkpVx8M2bebMlOqYRaJogZEdh48Mp7pcZY4d4w48IRmYQcfJ8Skp2/69KSfFpNilaStMwTPcoxq0mw6mGWrsuHJsSJL8edYSrxGQHxWvAuw/Sg==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1TvYF0-0005Op-52; Wed, 16 Jan 2013 19:01:38 +0000
Content-Disposition: inline
In-Reply-To: <20130116182449.GA4881@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213799>

On Wed, Jan 16, 2013 at 10:24:49AM -0800, Jeff King wrote:
> On Wed, Jan 16, 2013 at 06:22:40PM +0000, John Keeping wrote:
> 
> > > > [1] http://llvm.org/bugs/show_bug.cgi?id=13747
> > > 
> > > Yeah, I think it is exactly the same issue, and the fix they mention
> > > there would apply to us, too.
> > > 
> > > Is it worth applying this at all, then? Or should we apply it but limit
> > > it with a clang version macro (they mention r163034, but I do not know
> > > if it is in a released version yet, nor what macros are available to
> > > inspect the version)?
> > 
> > That maps to revision 06b3a06007 in their git repository [1], which is
> > contained in remotes/origin/release_32 so I think that change should be
> > in release 3.2, where I still see the warning (although that's not using
> > a clang built from that source), so I don't think that the fix for that
> > bug removes the warning in this case.
> > 
> > [1] http://llvm.org/git/clang.git
> 
> Thanks for checking. I'd rather squelch the warning completely (as in my
> re-post of Max's patch from a few minutes ago), and we can loosen it
> (possibly with a version check) later when a fix is widely disseminated.

I checked again with a trunk build of clang and the warning's still
there, so I've created a clang bug [1] to see if they will change the
behaviour.

I agree that we should squelch the warning for now, it can be changed
into a version check if it's accepted as a bug and once we know what
version it's fixed in.

[1] http://llvm.org/bugs/show_bug.cgi?id=14968
