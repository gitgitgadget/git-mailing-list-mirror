From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_color: fix return value for numeric color values
 0-8
Date: Tue, 20 Jan 2015 19:03:52 -0500
Message-ID: <20150121000352.GA12543@peff.net>
References: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
 <CACBZZX5s1rZ3exktbisseJSjF8-0=8ByMpBpARy6h+=iP7wEyA@mail.gmail.com>
 <20150120221447.GB18778@peff.net>
 <xmqqvbk1ypie.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:04:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDim7-00083J-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 01:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbbAUADz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 19:03:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:36622 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752530AbbAUADy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 19:03:54 -0500
Received: (qmail 25590 invoked by uid 102); 21 Jan 2015 00:03:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 18:03:54 -0600
Received: (qmail 25313 invoked by uid 107); 21 Jan 2015 00:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 19:04:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2015 19:03:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbk1ypie.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262704>

On Tue, Jan 20, 2015 at 03:57:13PM -0800, Junio C Hamano wrote:

> > -- >8 --
> > When commit 695d95d refactored the color parsing, it missed
> > a "return 0" when parsing literal numbers 0-8 (which
> > represent basic ANSI colors), leading us to report these
> > colors as an error.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Thanks; somebody should have caught this before we applied and
> merged to 'master', but the process obviously did not work well.

I am not too surprised. The use of numeric values for colors was
completely undocumented, and we did not have any test coverage for it. I
did not even know it existed until I started refactoring the function,
and wondered what was going on (though I did try to preserve it once I
found it).

So I suspect that almost nobody is using this undocumented "feature",
which is why it was not caught while cooking in 'next'.  The system
cannot always have perfect output, but hopefully the number of people
affected by a bug is proportional to the quickness with which it is
caught.

-Peff

PS All that being said, I think it is a good example of why it is a good
   idea to beef up test coverage in an area before refactoring. A
   trivial test would have caught this.
