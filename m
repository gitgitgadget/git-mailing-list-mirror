From: Jeff King <peff@peff.net>
Subject: Re: [RCF/PATCH] Makefile: move 'ifdef DEVELOPER' after config.mak*
 inclusion
Date: Wed, 1 Jun 2016 03:30:37 -0400
Message-ID: <20160601073037.GA14096@sigill.intra.peff.net>
References: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 09:30:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b80c8-0006Mm-9V
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 09:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbcFAHar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 03:30:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:47026 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750697AbcFAHaq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 03:30:46 -0400
Received: (qmail 24104 invoked by uid 102); 1 Jun 2016 07:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 03:30:41 -0400
Received: (qmail 30913 invoked by uid 107); 1 Jun 2016 07:30:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 03:30:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 03:30:37 -0400
Content-Disposition: inline
In-Reply-To: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296062>

On Tue, May 31, 2016 at 03:24:43PM +0200, Matthieu Moy wrote:

> The DEVELOPER knob was introduced in 658df95 (add DEVELOPER makefile
> knob to check for acknowledged warnings, 2016-02-25), and works well
> when used as "make DEVELOPER=1", and when the configure script was not
> used.
> 
> However, the advice given in CodingGuidelines to add DEVELOPER=1 to
> config.mak does not: config.mak is included after testing for
> DEVELOPER in the Makefile, and at least GNU Make's manual specifies
> "Conditional directives are parsed immediately", hence the config.mak
> declaration is not visible at the time the conditional is evaluated.
> 
> Also, when using the configure script to generate a
> config.mak.autogen, the later file contained a "CFLAGS = <flags>"
> initialization, which overrode the "CFLAGS += -W..." triggered by
> DEVELOPER.
> 
> This patch fixes both issues.

Hmm. So I think this does fix some issues, but it also means that one's
config.mak cannot use DEVELOPER as a base and then override particular
flags.

I dunno if people want to do that or not. I do not use DEVELOPER myself
because I have my own detailed config.mak that is a superset.

-Peff
