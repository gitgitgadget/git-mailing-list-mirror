From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Tue, 7 Aug 2012 00:03:26 -0400
Message-ID: <20120807040326.GA18682@sigill.intra.peff.net>
References: <20120807003541.GA18219@sigill.intra.peff.net>
 <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v4nofxt89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org,
	rctay89@gmail.com, schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 06:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syb1D-0004se-BI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 06:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732Ab2HGEDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 00:03:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54084 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab2HGED3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 00:03:29 -0400
Received: (qmail 23973 invoked by uid 107); 7 Aug 2012 04:03:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 00:03:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 00:03:26 -0400
Content-Disposition: inline
In-Reply-To: <7v4nofxt89.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203010>

On Mon, Aug 06, 2012 at 08:43:02PM -0700, Junio C Hamano wrote:

> Ben Walton <bwalton@artsci.utoronto.ca> writes:
> 
> > Now that git_terminal_prompt can cleanly interact with /dev/tty on
> > Solaris, enable HAVE_DEV_TTY so that this code path is used for
> > credential reading instead of relying on the crippled getpass().
> >
> > Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> > ---
> >
> > This is a follow up to Jeff's patch that fixes git_terminal_prompt on
> > Solaris.  I don't have 5.6 or 5.7 for testing but I believe this
> > should be valid for both of those releases as well.
> 
> So which direction do you guys want to go?  Use the "bidirectional
> stdio with fseek()" for now, with the expectation that Tay's other
> series will rewrite it to fd based one?

I think so. The stdio fix is short and obviously correct, and then Tay
can either refactor or not as he sees fit for his topic (although if we
do switch to just a terminal_can_prompt() interface and get rid of the
term_t ugliness, then there is not even any need to do the rewrite).

-Peff
