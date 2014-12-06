From: Jeff King <peff@peff.net>
Subject: Re: no-xmailer tests fail under Mac OS
Date: Sat, 6 Dec 2014 02:12:34 -0500
Message-ID: <20141206071234.GA6850@peff.net>
References: <CAO2U3Qg3KsjvWJFza4MfiQDa2LbCpOy1Nxf9Vt3NSgXc7Bee9g@mail.gmail.com>
 <20141206053434.GF31301@peff.net>
 <CAO2U3QjkJRPrFvapK=LDU_GG5Ne6_zVD+S61JP+iV_Xi-gk5JQ@mail.gmail.com>
 <20141206063245.GA5966@peff.net>
 <CAO2U3QgDMpKwqsjzPNECpJw4z+WbboX5ug7Shu5v5ZCuPsKuGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Luis Henriques <henrix@camandro.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 08:13:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx9Y6-0000Yn-1p
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 08:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbaLFHMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 02:12:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:49335 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750977AbaLFHMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 02:12:36 -0500
Received: (qmail 10749 invoked by uid 102); 6 Dec 2014 07:12:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 01:12:36 -0600
Received: (qmail 10194 invoked by uid 107); 6 Dec 2014 07:12:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 06 Dec 2014 02:12:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2014 02:12:34 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3QgDMpKwqsjzPNECpJw4z+WbboX5ug7Shu5v5ZCuPsKuGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260943>

On Fri, Dec 05, 2014 at 11:07:37PM -0800, Michael Blume wrote:

> > Ah, right, we might be looking for 0 sometimes. The right way to do it
> > without destroying the &&-chaining is:
> >
> >   { grep ^X-Mailer: out || true } &&
> >   test_line_count = $expected mailer
> 
> Hmm, it doesn't look like that helper is &&-chained though? So it
> seems like we could just do without the &&

You're right, but that is IMHO a bug. We would not notice if send-email
or format-patch barfed, and we are expecting to find no X-Mailer (we
wouldn't, but for the wrong reason).

It should also be using test_config in the last two tests.

-Peff
