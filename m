From: Jeff King <peff@peff.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 14:30:06 -0500
Message-ID: <20120220193006.GA30904@sigill.intra.peff.net>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
 <20120220010617.GB4140@sigill.intra.peff.net>
 <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
 <20120220135639.GA5131@sigill.intra.peff.net>
 <e1d3ddd965eb32717163aaa87fa71e17.squirrel@arekh.dyndns.org>
 <20120220154452.GA27456@sigill.intra.peff.net>
 <cb81840f853a1d43a7da03ea24c86445.squirrel@arekh.dyndns.org>
 <20120220191500.GA29228@sigill.intra.peff.net>
 <72fbd4155349723da1c3c503c1c9c620.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 20:30:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzYwD-0003xH-I9
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 20:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2BTTaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 14:30:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44075
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab2BTTaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 14:30:09 -0500
Received: (qmail 5670 invoked by uid 107); 20 Feb 2012 19:30:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 14:30:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 14:30:06 -0500
Content-Disposition: inline
In-Reply-To: <72fbd4155349723da1c3c503c1c9c620.squirrel@arekh.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191089>

On Mon, Feb 20, 2012 at 08:24:15PM +0100, Nicolas Mailhot wrote:

> > I think a good first step would be improving the error message for a
> > 511, then. Unfortunately, it seems from the rfc draft you sent that
> > callers are expected to parse the link out of the HTML given in the body
> > of the response. It seems silly that there is not a Location field
> > associated with a 511, similar to redirects.
> 
> The URL is not lost in the HTML text, it's in the url meta field
> 
> <meta http-equiv="refresh"
>        content="0; url=https://login.example.net/">

Sorry, but

  1. That is in the HTML in the body of the response (by body I don't
     mean the HTML <body>, but the body of the http request).

  2. I don't see anything in the rfc indicating that there must be a
     meta tag in the response. They use it in the example of the rfc,
     but they also have human-readable text with an <a> link.  Do we yet
     know what will be common among captive portals?

You said you have a non-hypothetical case. Can you show us the response?

> As for while there is no Location field, I think it's because otherwise it
> could behave like a redirect, and browser people made it plain they didn't
> want redirects of https accesses (but I wasn't there when the spec was
> written, and only skimmed the workgroup archives, so there may have been other
> reasons for this choice. I'm pretty sure it's deliberate anyway).

Even if they didn't call it Location, it would be nice to have some
machine-readable format that is understood by non-browser agents that
don't know how to parse HTML. But I recognize that is not your decision,
so don't feel obligated to defend it.

-Peff
