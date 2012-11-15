From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/8] test-lib: allow negation of prerequisites
Date: Thu, 15 Nov 2012 08:42:30 -0800
Message-ID: <20121115164228.GA18108@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003325.GA17819@sigill.intra.peff.net>
 <20121115074658.GA8429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:42:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2Wf-0001Pu-Te
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768415Ab2KOQmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:42:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49552 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768379Ab2KOQmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:42:35 -0500
Received: (qmail 17986 invoked by uid 107); 15 Nov 2012 16:43:24 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 11:43:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 08:42:30 -0800
Content-Disposition: inline
In-Reply-To: <20121115074658.GA8429@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209828>

On Wed, Nov 14, 2012 at 11:46:58PM -0800, Jonathan Nieder wrote:

> > +test_expect_success !LAZY_TRUE 'missing lazy prereqs skip tests' '
> 
> I have a visceral nervousness when reading this code, from too much
> unpleasant experience of bash's csh-style !history expansion.  Luckily
> bash does not treat ! specially in the '-o sh' mode used by tests.

I can understand, having been bitten by it many times myself (not only
is it counter-intuitively expanded inside double quotes, and not only
does it not do what you wanted, but it does not insert the command into
the history, so you cannot even go back to fix it easily).

> Does this feature work when running a test explicitly using
> "bash <name of test>"?  That's something I do from time to time to
> figure out whether a weird behavior is shell-specific.

Yes. You can test it yourself with "bash t0000-basic.sh". The reason is
that the "!" is part of history expansion, which is only enabled by
default for interactive shells.

> If it works everywhere, this patch would help me conquer my fear of
> exclamation points in git's tests, which would be a comfort to me and
> a very good thing.

As far as I know, "!" should be safe in a non-interactive shell script.

-Peff
