From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t5540: test DAV push with authentication
Date: Tue, 13 Dec 2011 18:16:30 -0500
Message-ID: <20111213231630.GB12432@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <CAHGBnuO1CFGacMQb+Md_uGsLu=V9bGDpcFLd9Lb4C5jSN+uUiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Naewe <stefan.naewe@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RabaT-0007tj-NI
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab1LMXQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:16:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49819
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105Ab1LMXQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:16:33 -0500
Received: (qmail 25142 invoked by uid 107); 13 Dec 2011 23:23:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 18:23:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 18:16:30 -0500
Content-Disposition: inline
In-Reply-To: <CAHGBnuO1CFGacMQb+Md_uGsLu=V9bGDpcFLd9Lb4C5jSN+uUiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187073>

On Tue, Dec 13, 2011 at 10:28:07PM +0100, Sebastian Schuberth wrote:

> On Tue, Dec 13, 2011 at 21:17, Jeff King <peff@peff.net> wrote:
> 
> > We don't currently test this case at all, and instead just
> > test the DAV mechanism over an unauthenticated push. That
> > isn't very realistic, as most people will want to
> > authenticate pushes.
> 
> Thanks for adding this, Peff!

You're welcome. Thank you for forwarding the bug report. I would never
have seen it on the msysgit list, and for some reason it seems that
msysgit people are more likely to use DAV.

Having looked a lot at the http code the past month or two, I knew it
was pretty flaky and I was nervous when we added Stefan's patch (and no,
I don't blame Stefan; his patch was completely reasonable, but just
happened to trigger a problem in a seldom-looked-at corner of the code).

But I hadn't looked at http-push at all until yesterday, and it didn't
even occur to me that there was another whole area of code relying in a
very obscure way on the http.c auth code. I'll take a look at some of
the refactoring I've done in http.c (both for the credentials topic as
well as the bundle topic) and see if we can't integrate http-push.c a
little more smoothly.

-Peff
