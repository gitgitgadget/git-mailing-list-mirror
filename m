From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Fri, 26 Feb 2016 22:29:08 -0500
Message-ID: <20160227032907.GB10313@sigill.intra.peff.net>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
 <56D078F3.9070905@web.de>
 <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
 <56D0D2DF.1040807@web.de>
 <xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 04:29:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZVZF-0000cB-9T
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 04:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953AbcB0D3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 22:29:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:50510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755933AbcB0D3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 22:29:11 -0500
Received: (qmail 20497 invoked by uid 102); 27 Feb 2016 03:29:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 22:29:10 -0500
Received: (qmail 10024 invoked by uid 107); 27 Feb 2016 03:29:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 22:29:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 22:29:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287654>

On Fri, Feb 26, 2016 at 03:35:10PM -0800, Junio C Hamano wrote:

> > Digging means:
> > run git bisect and report the commit.
> > And this makes the compiler happy:
> >   Revert "tree-diff: catch integer overflow in combine_diff_path allocation"
> 
> So?
> 
> Identifying two versions of the same C file, for one of which the
> Apple compiler does not give you "internal compiler error" and for
> the other it does, may help Apple engineers to debug their compiler.
> 
> But we cannot and will not revert any of our code only because some
> vendor compiler is broken.  It would be a different story if we were
> throwing an invalid C at compilers and relying on a bug in GCC that
> accepts an invalid code, but I do not think that is the case here.

I think knowing the commit that causes the problem is interesting for
us, because it lets us see whether we are throwing invalid C at the
compiler or not (the compiler should never segfault, obviously, but I
can believe that it is more likely to if you throw garbage at it).

But that commit is one of the tamest, I think; it just seems like a
boring compiler bug.  I'd be curious to reduce it to a minimal change
that causes the bug, just to be sure.

Torsten, what is the compiler version (I don't have Apple compilers, but
it seems plausible that older clang might have the same problem).

-Peff
