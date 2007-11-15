From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] send-pack: assign remote errors to each ref
Date: Wed, 14 Nov 2007 23:54:17 -0500
Message-ID: <20071115045414.GC9794@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113113710.GC15880@sigill.intra.peff.net> <7vbq9xpprg.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711140159550.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWkQ-00052G-7X
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbXKOEyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbXKOEyW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:54:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4688 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbXKOEyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:54:21 -0500
Received: (qmail 6078 invoked by uid 111); 15 Nov 2007 04:54:20 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 Nov 2007 23:54:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2007 23:54:17 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711140159550.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65059>

On Wed, Nov 14, 2007 at 02:01:14AM +0000, Johannes Schindelin wrote:

> Since when can refnames contain spaces?  In my copy of git, bad_ref_char() 
> in refs.c returns 1 if ch <= ' '.  It's the first error path, even.

Oops, I'm clearly an idiot. I explicitly looked at bad_ref_char before
writing the original message, and somehow read that as strictly less
than.

So the parsing problem goes away, and I think using the sort order as a
hint takes away the potential performance problem (I don't even know if
it was a problem -- there may be other O(n^2) behavior).

I will take a look at the tests Alex has been working on, maybe add a
few to it, and submit a cleaned-up series.

-Peff
