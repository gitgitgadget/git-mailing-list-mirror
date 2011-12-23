From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Fri, 23 Dec 2011 05:35:11 -0500
Message-ID: <20111223103511.GA10029@sigill.intra.peff.net>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <20111221043843.GA20714@sigill.intra.peff.net>
 <20111221145112.GA13097@llunet.cs.wisc.edu>
 <20111223100957.GA1247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 23 11:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re2TA-0002hn-Eh
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 11:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606Ab1LWKfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 05:35:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51723
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab1LWKfO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 05:35:14 -0500
Received: (qmail 32314 invoked by uid 107); 23 Dec 2011 10:41:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Dec 2011 05:41:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2011 05:35:11 -0500
Content-Disposition: inline
In-Reply-To: <20111223100957.GA1247@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187624>

On Fri, Dec 23, 2011 at 05:09:58AM -0500, Jeff King wrote:

> > The ones that make sense to limit are all those that depend on the subject, as the
> > above; it does not make sense to limit other fields that don't depend on the
> > subject, as they are fixed width, or have small variance. And it does not make
> > sense to me to limit the length of the body.
> 
> I agree the subject is the most likely place. I was thinking one might
> want to do it with the body, too. But whether it would be "I want N
> bytes of the body" or "truncate each body line at N bytes without
> wrapping", I don't know.

Another place that might want it is %N (commit notes).

Here's how I would have done it. Not involving %w at all, but applying
equally to all placeholders.

  [1/2]: pretty: refactor --format "magic" placeholders
  [2/2]: pretty: allow "max-size" magic for all placeholders

I'm not personally interested in this topic, so I won't be pushing for
this to be included in git. But if it feels like the right direction for
you, feel free to be build on it and post it as part of your series (or
just take it as inspiration and make your own commits). Off the top of
my head, it needs:

  - documentation updates
  - tests
  - userformat_want_item should also respect the same magic (it already
    duplicates some of the "-/+/ " magic. It might be nice to factor
    that part out).

-Peff
