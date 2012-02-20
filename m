From: Jeff King <peff@peff.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 14:15:00 -0500
Message-ID: <20120220191500.GA29228@sigill.intra.peff.net>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
 <20120220010617.GB4140@sigill.intra.peff.net>
 <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
 <20120220135639.GA5131@sigill.intra.peff.net>
 <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
 <20120220154452.GA27456@sigill.intra.peff.net>
 <cb81840f853a1d43a7da03ea24c86445.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzYhd-0005GM-EN
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab2BTTPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:15:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab2BTTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:15:04 -0500
Received: (qmail 4641 invoked by uid 107); 20 Feb 2012 19:15:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 14:15:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 14:15:00 -0500
Content-Disposition: inline
In-Reply-To: <cb81840f853a1d43a7da03ea24c86445.squirrel@arekh.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191086>

On Mon, Feb 20, 2012 at 07:27:08PM +0100, Nicolas Mailhot wrote:

> Step 3 is a quite less obvious on a corporate network, where Internet access
> is gated by a filtering proxy, that will let some sites pass transparently but
> require credentials to let you access others. Worst case, there are several
> load-balanced gateways on different physical sites (to avoid spofs in case of
> planes falling on the wrong place), that do not share authentication (because
> propagating auth across physical sites is hard). So no, just launching a
> browser is not sufficient to find the captive portal, you need to actually
> access the URL returned by error 511 in meta information. Git should at
> minimum report this URL.
> 
> (and no this is not an hypothetical scenario and yes there are git users
> trying to pass the gateways there)

This is exactly the sort of information I wanted to get from a
real-world scenario. From your initial messages, it sounded like a
purely hypothetical thing.

I think a good first step would be improving the error message for a
511, then. Unfortunately, it seems from the rfc draft you sent that
callers are expected to parse the link out of the HTML given in the body
of the response. It seems silly that there is not a Location field
associated with a 511, similar to redirects.

-Peff
