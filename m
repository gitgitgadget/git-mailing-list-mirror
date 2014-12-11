From: Jeff King <peff@peff.net>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Thu, 11 Dec 2014 17:13:39 -0500
Message-ID: <20141211221339.GA9478@peff.net>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
 <20141206053434.GF31301@peff.net>
 <CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
 <20141206063245.GA5966@peff.net>
 <CAO2U3QgDMpKwqsjzPNECpJw4z+WbboX5ug7Shu5v5ZCuPsKuGQ@mail.gmail.com>
 <20141206071234.GA6850@peff.net>
 <xmqq1to5et1j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzBzZ-00042p-EC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 23:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934490AbaLKWNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 17:13:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:51871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933877AbaLKWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 17:13:42 -0500
Received: (qmail 26008 invoked by uid 102); 11 Dec 2014 22:13:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Dec 2014 16:13:41 -0600
Received: (qmail 6187 invoked by uid 107); 11 Dec 2014 22:13:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Dec 2014 17:13:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2014 17:13:39 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1to5et1j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261297>

On Thu, Dec 11, 2014 at 02:11:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Dec 05, 2014 at 11:07:37PM -0800, Michael Blume wrote:
> >
> >> > Ah, right, we might be looking for 0 sometimes. The right way to do it
> >> > without destroying the &&-chaining is:
> >> >
> >> >   { grep ^X-Mailer: out || true } &&
> >> >   test_line_count = $expected mailer
> >> 
> >> Hmm, it doesn't look like that helper is &&-chained though? So it
> >> seems like we could just do without the &&
> >
> > You're right, but that is IMHO a bug. We would not notice if send-email
> > or format-patch barfed, and we are expecting to find no X-Mailer (we
> > wouldn't, but for the wrong reason).
> 
> Let me patch this up further by amending the SQUASH??? at the tip.
> 
>  t/t9001-send-email.sh | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> [...]

Yeah, looks good to me.

-Peff
