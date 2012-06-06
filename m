From: Jeff King <peff@peff.net>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to
 remote-helper.
Date: Wed, 6 Jun 2012 09:43:21 -0400
Message-ID: <20120606134320.GC2597@sigill.intra.peff.net>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <CAFfmPPP1koMnYBFbgHt0MGr77okjL5OdAh-TMxFTevj+mDbOZQ@mail.gmail.com>
 <20120605081402.GF25809@sigill.intra.peff.net>
 <5801019.gWQEmI8V81@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 15:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGWG-0005OH-3p
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 15:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673Ab2FFNnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 09:43:24 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:44981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab2FFNnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 09:43:23 -0400
Received: (qmail 2118 invoked by uid 107); 6 Jun 2012 13:43:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jun 2012 09:43:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2012 09:43:21 -0400
Content-Disposition: inline
In-Reply-To: <5801019.gWQEmI8V81@flobuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199331>

On Wed, Jun 06, 2012 at 12:16:25AM +0200, Florian Achleitner wrote:

> On Tuesday 05 June 2012 04:14:02 Jeff King wrote:
> > Is there a reason that the patch unconditionally creates the pipe in
> > get_helper? I.e., isn't it specific to the get_importer code path? It
> > feels a little hacky to have it infect the other code paths.
> 
> I agree, it's a bit hacky. For me as a newbee, it was just a way to make fast-
> import have the pipe it needs. I didn't know about the history of the 
> preexec_cb as a fix for a bug in less.
> 
> The pipe is created unconditionally, because at the fork-time of the remote-
> helper it is not known whether the import command will be used later together 
> with fast-import, or not. (and later, there's no way, I think).
> Helpers that don't use the pipe could simply ignore it.

Good point. I think we really are stuck with doing it in every case,
unless we want to turn to something that can be opened after the fact
(like a fifo).

-Peff
