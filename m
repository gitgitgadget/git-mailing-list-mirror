From: Jeff King <peff@peff.net>
Subject: Re: Test failures with GNU grep 2.23
Date: Fri, 19 Feb 2016 14:11:25 -0500
Message-ID: <20160219191125.GB777@sigill.intra.peff.net>
References: <20160207162540.GK29880@serenity.lan>
 <20160219115928.GA10204@sigill.intra.peff.net>
 <xmqqmvqwd2ie.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:11:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqSi-0000DB-Bq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427977AbcBSTL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:11:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:45680 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030273AbcBSTL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:11:27 -0500
Received: (qmail 8985 invoked by uid 102); 19 Feb 2016 19:11:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:11:27 -0500
Received: (qmail 31504 invoked by uid 107); 19 Feb 2016 19:11:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:11:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 14:11:25 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmvqwd2ie.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286743>

On Fri, Feb 19, 2016 at 09:38:17AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I'd worry that "-a" is not portable. OTOH, BSD grep seems to have
> > it, so between that and GNU, I think most systems are covered. We could
> > do:
> >
> >   test_lazy_prereq GREP_A '
> > 	echo foo | grep -a foo
> >   '
> >
> > and mark these tests with it. I'd also be happy to skip that step and
> > just do it if and when somebody actually complains about a system
> > without it (I wouldn't be surprised if most people on antique systems
> > end up installing GNU grep anyway).
> >
> > Another option might be using "sed -ne '/^author/p'" or similar. But
> > that may very well just be trading one portability problem for another.
> 
> Would $PERL help, I wonder?

It would, though I think you would need to call `binmode` to make it
reliable. I was hesitant to suggest it, because I seem to recall some
resistance to more perl dependencies in the test suite, but I think we
may be past the point of no return there, anyway.

-Peff
