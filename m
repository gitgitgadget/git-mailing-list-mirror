From: Jeff King <peff@peff.net>
Subject: Re: t9700-perl-git.sh is broken on some configurations
Date: Fri, 4 Mar 2016 06:45:42 -0500
Message-ID: <20160304114542.GB569@sigill.intra.peff.net>
References: <CAP8UFD1z9H=SygaMVzpc__mXTbnFc2XiW0LZ+sfzdCPmrnXW6g@mail.gmail.com>
 <20160304085649.GA29752@sigill.intra.peff.net>
 <CAP8UFD3jZ2b8jgw8dR0U=AkPTTm5nO1F92UVjyeAMsfiOaJ_5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:45:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aboB7-0002gi-9f
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 12:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbcCDLpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 06:45:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:54669 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751065AbcCDLps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 06:45:48 -0500
Received: (qmail 30433 invoked by uid 102); 4 Mar 2016 11:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:45:44 -0500
Received: (qmail 14510 invoked by uid 107); 4 Mar 2016 11:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:45:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 06:45:42 -0500
Content-Disposition: inline
In-Reply-To: <CAP8UFD3jZ2b8jgw8dR0U=AkPTTm5nO1F92UVjyeAMsfiOaJ_5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288247>

On Fri, Mar 04, 2016 at 11:30:36AM +0100, Christian Couder wrote:

> > Those are just guesses, but if we are tickling a bug in perl's parser,
> > this might avoid them. I also wondered when "/r" appeared. It was in
> > 5.14, so you're presumably good there.
> 
> If I just remove the "r" at the end of "s/\\/\//gr", I get with both
> Perl versions:
> 
> Can't modify non-lvalue subroutine call at t/t9700/test.pl line 36.

Right, because the string being operated on is the return value of a
function, so we can't do substitution on it (unless with "r", whose
purpose is to allow exactly such a thing).

> > The "use" statement at the top of
> > the script says "5.008", so perhaps we should be writing it out longhand
> > anyway (that version is "only" 5 years old, so I suspect there are still
> > systems around with 5.12 or older).
> 
> Yeah, it would work.

Thanks for confirming the longhand does work; I think the patch I just
posted elsewhere in the thread should be good for you, then.

-Peff
