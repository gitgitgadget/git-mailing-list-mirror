From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: store format option as an int
Date: Sat, 16 Apr 2011 02:22:33 -0400
Message-ID: <20110416062233.GA28853@sigill.intra.peff.net>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
 <20110416004544.GA5628@elie>
 <20110416013723.GA23105@sigill.intra.peff.net>
 <20110416052704.GA10807@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 08:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAyu2-0003Km-BC
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 08:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab1DPGWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 02:22:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33007
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab1DPGWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 02:22:36 -0400
Received: (qmail 18210 invoked by uid 107); 16 Apr 2011 06:23:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Apr 2011 02:23:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Apr 2011 02:22:33 -0400
Content-Disposition: inline
In-Reply-To: <20110416052704.GA10807@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171661>

On Sat, Apr 16, 2011 at 12:27:04AM -0500, Jonathan Nieder wrote:

> It is unsafe to pass a pointer to a value of enumerated type to
> OPT_SET_INT (as v1.7.0-rc0~137^2~14, 2009-0905) does, since it might
> have the wrong alignment or width (C99 only says "Each enumerated type
> shall be compatible with char, a signed integer type, or an unsigned
> integer type.  The choice of type is implementation-defined, but shall
> be capable of representing the values of all the members of the
> enumeration.)
> 
> Probably this didn't come up in practice because by default GCC uses
> an 'int' to represent small enums unless passed -fshort-enums (except
> on certain architectures where -fshort-enums is the default).
> 
> Noticed-by: Jeff King <peff@peff.net>

If by "noticed by" you mean "mentioned but was completely unaware of the
significance of what he was saying", then yes. :)

Now that you mention it, though, I was reminded that we had run across
something similar before. And I think it was this:

  http://article.gmane.org/gmane.comp.version-control.git/144858

Your fix looks sane. I don't think we can do anything more clever on the
parse-options side.

-Peff
