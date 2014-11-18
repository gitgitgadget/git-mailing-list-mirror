From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0090: mark add-interactive test with PERL prerequisite
Date: Tue, 18 Nov 2014 13:44:02 -0500
Message-ID: <20141118184402.GA13479@peff.net>
References: <20141118172231.GA16387@peff.net>
 <20141118174309.GB31672@peff.net>
 <20141118183838.GD6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:44:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqnl4-0000Iq-HM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbaKRSoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:44:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:41842 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753932AbaKRSoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:44:05 -0500
Received: (qmail 24396 invoked by uid 102); 18 Nov 2014 18:44:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:44:04 -0600
Received: (qmail 19216 invoked by uid 107); 18 Nov 2014 18:44:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 13:44:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 13:44:02 -0500
Content-Disposition: inline
In-Reply-To: <20141118183838.GD6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 10:38:38AM -0800, Jonathan Nieder wrote:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> > +# This makes sure we depend on the NO_PERL setting itself.
> > +$(patsubst %.perl,%,$(SCRIPT_PERL)): GIT-BUILD-OPTIONS
> > +
> >  ifndef NO_PERL
> >  $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
> 
> Why do these repeat the 'patsubst ...' expression instead of using
> SCRIPT_PERL_GEN, by the way?

Dunno. I just cargo-culted from the context lines.

> -- >8 --
> Subject: Makefile: simplify by using SCRIPT_{PERL,SH}_GEN macros
> 
> SCRIPT_PERL_GEN is defined as $(patsubst %.perl,%,$(SCRIPT_PERL)) for
> use in targets like build-perl-script used by makefiles in
> subdirectories that override SCRIPT_PERL (see v1.8.2-rc0~17^2,
> "git-remote-mediawiki: use toplevel's Makefile", 2013-02-08).
> 
> The same expression is used in the rules that actually write the
> generated perl scripts, and since this rules were introduced before
> SCRIPT_PERL_GEN, they use the longhand instead of that macro.  Use the
> macro to make reading easier.
> 
> Likewise for SCRIPT_SH_GEN.  The Python rules already got the same
> simplification in v1.8.4-rc0~162^2~8 (2013-05-24).

This makes sense, and looking over the Makefile, I don't see how it
could cause any bad side effects.

Minor nit:

  s/this rules/these rules/

in your commit message. Otherwise:

  Reviewed-by: Jeff King <peff@peff.net>

-Peff
