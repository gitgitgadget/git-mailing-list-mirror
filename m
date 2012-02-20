From: Jeff King <peff@peff.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 14:09:39 -0500
Message-ID: <20120220190939.GA29158@sigill.intra.peff.net>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
 <20120220010617.GB4140@sigill.intra.peff.net>
 <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
 <20120220135639.GA5131@sigill.intra.peff.net>
 <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
 <20120220154452.GA27456@sigill.intra.peff.net>
 <alpine.DEB.2.00.1202202002330.28090@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzYcN-0002Z4-K2
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab2BTTJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:09:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44054
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2BTTJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:09:42 -0500
Received: (qmail 4566 invoked by uid 107); 20 Feb 2012 19:09:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 14:09:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 14:09:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202202002330.28090@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191085>

On Mon, Feb 20, 2012 at 08:06:46PM +0100, Daniel Stenberg wrote:

> > 3. Open a browser and say "Ah, I see. A captive portal".
> >
> >We should already be doing that. Adding more support could make
> >step 3 a little nicer, but like I said, I'd be more interested in
> >seeing a real case first. It may even be a feature that would be
> >more appropriate to curl (which git builds on for http access).
> 
> We're already discussing the 511 in the curl camp as well, but with
> even more sighs and hands in the air. 511 is clearly intended for
> HTML-understanding user agents and curl is not one of those. IMHO,
> curl will remain to simply help users to figure out that it is 511
> and leave it at that.

Thanks for the input. It sounds like our best bet is to just report the
URL from a 511 better, then. Do you have any idea yet how that
information will be available to curl library users?

> As a git user, I would probably be very surprised if using 'git'
> suddenly caused by browser to pop up a captive portal login. I would
> prefer git to instead properly explain to me that is being the victim
> of a 511 and what I should do to fix it.

I agree. Even if the "step 3" in my list is "then the user starts a
browser given the URL from git's error message", that is a huge
improvement over the current state. And it retains the principle of
least surprise.

-Peff
