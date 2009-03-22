From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Sun, 22 Mar 2009 02:19:46 -0400
Message-ID: <20090322061946.GC14765@coredump.intra.peff.net>
References: <1237603220-22897-1-git-send-email-bwalton@artsci.utoronto.ca> <20090321032240.GA31547@coredump.intra.peff.net> <1237635198-sup-2111@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Mar 22 07:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlH4b-00049a-JT
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 07:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbZCVGTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 02:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbZCVGTv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 02:19:51 -0400
Received: from peff.net ([208.65.91.99]:52926 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbZCVGTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 02:19:51 -0400
Received: (qmail 9737 invoked by uid 107); 22 Mar 2009 06:20:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 02:20:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 02:19:46 -0400
Content-Disposition: inline
In-Reply-To: <1237635198-sup-2111@ntdws12.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114124>

On Sat, Mar 21, 2009 at 07:38:35AM -0400, Ben Walton wrote:

> I used the ifndef/endif setup becuase that's how the PERL_PATH was set
> and also becuase I think it's slightly more explicit.  I'm ok with ?=

I can't think of any reason why the two would not be equivalent
functionally. I would generally use ?= because it is more portable, but
we are inextricably bound to gmake at this point, so I don't think that
matters. So I don't have a strong preference.

> > but maybe it is not worth caring about (since it may complicate building
> > Documentation if you _haven't_ build the actual code).
> 
> In my case, I'm using the configure script and then running make,
> which sees the Documentation/Makefile source in the ../config.mak
> files, so there may be some variance between pure make and make +
> autoconf in this respect.  I hadn't looked at it in that light.
> Should this be reconciled too?

Oh, right, I forgot that it pulls in config.mak. So it is really a
non-issue if you are putting SHELL_PATH in your config.mak (or defining
it via autoconf). So nevermind my ramblings in that direction.

I think it should be fine to just resend your patch with:

  1. default to $(SHELL)

  2. quote $(SHELL_PATH) as appropriate

-Peff
