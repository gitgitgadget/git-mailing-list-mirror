From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 16:03:46 -0500
Message-ID: <20160215210345.GA31008@sigill.intra.peff.net>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <CAPig+cS=TtVGTxo0oHny4GpAAaej93T2kP93upfHtPMkAd7V0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:04:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQJH-0000fM-P8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbcBOVDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:03:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:42399 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754036AbcBOVDs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:03:48 -0500
Received: (qmail 32458 invoked by uid 102); 15 Feb 2016 21:03:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:03:48 -0500
Received: (qmail 11436 invoked by uid 107); 15 Feb 2016 21:03:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 16:03:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:03:46 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cS=TtVGTxo0oHny4GpAAaej93T2kP93upfHtPMkAd7V0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286240>

On Mon, Feb 15, 2016 at 03:58:12PM -0500, Eric Sunshine wrote:

> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -27,6 +28,7 @@ static int actions, types;
> >  static const char *get_color_slot, *get_colorbool_slot;
> >  static int end_null;
> 
> Not related to your changes, but I just realized that this variable
> really ought to be named 'end_nul' since we're talking about the
> character NUL, not a NULL pointer.

Yeah, I noticed that, too. We just went through a round of related fixes
here, and the "usual" name is now "nul_term_line". I don't especially
like that one either, but at least it is correct and consistent. :)

> >  static int respect_includes = -1;
> > +static int show_origin;
> > @@ -81,6 +83,7 @@ static struct option builtin_config_options[] = {
> >         OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> 
> Likewise, the long option name should be --nul rather than --null, or
> the long name could be dropped altogether since some other commands
> just recognize short option -z.
> 
> There is no need for this patch series to address this anomaly; it's
> perhaps low-hanging fruit for someone wanting to join the project. The
> only very minor wrinkle is that we'd still need to recognize --null as
> a deprecated (and undocumented) alias for --nul.

I think that would be OK as long as we keep the compatible option.

-Peff
