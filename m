From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Tue, 19 Apr 2016 21:17:40 -0400
Message-ID: <20160420011740.GA29839@sigill.intra.peff.net>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
 <1460747949-3514-5-git-send-email-dturner@twopensource.com>
 <xmqqa8kq69i5.fsf@gitster.mtv.corp.google.com>
 <20160419071403.GA22577@sigill.intra.peff.net>
 <1461102001.5540.125.camel@twopensource.com>
 <20160419232243.GF18255@sigill.intra.peff.net>
 <1461109391.5540.138.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 03:17:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asgm5-00077Q-9U
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 03:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbcDTBRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 21:17:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:52577 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932150AbcDTBRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 21:17:44 -0400
Received: (qmail 4950 invoked by uid 102); 20 Apr 2016 01:17:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 21:17:43 -0400
Received: (qmail 22745 invoked by uid 107); 20 Apr 2016 01:17:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 21:17:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 21:17:40 -0400
Content-Disposition: inline
In-Reply-To: <1461109391.5540.138.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291977>

On Tue, Apr 19, 2016 at 07:43:11PM -0400, David Turner wrote:

> On Tue, 2016-04-19 at 19:22 -0400, Jeff King wrote:
> > You can find previous discussion on the list, but I think the options
> > basically are:
> > 
> >   1. Something like v2, where the client gets a chance to speak
> > before
> >      the advertisement.
> > 
> >   2. Some out-of-band way of getting values from the client to the
> >      server (so maybe extra command-line arguments for git-over-ssh,
> > and
> >      maybe shoving something after the "\0" for git-daemon, and of
> >      course extra parameters for HTTP).
> > 
> >   3. The client saying "stop spewing refs at me, I want to give you a
> >      ref filter" asynchronously, and accepting a little spew at the
> >      beginning of each conversation. That obviously only works for
> > the
> >      full-duplex transports, so you'd probably fall back to (2) for
> >      http.
> 
> OK, so (2) seems like what I'm doing -- it just happens that I only
> implemented it for one protocol.

Right. And I don't mind that approach _if_ we can figure out a way to do
it for all protocols. But I think there are some complications with the
other ones, which means that HTTP will have the ability to grow features
the other protocols do not.

-Peff
