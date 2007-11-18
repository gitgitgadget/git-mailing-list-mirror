From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] send-pack: track errors for each ref
Date: Sat, 17 Nov 2007 22:12:16 -0500
Message-ID: <20071118031215.GB4560@sigill.intra.peff.net>
References: <20071117125323.GA23125@sigill.intra.peff.net> <20071117125426.GA23186@sigill.intra.peff.net> <Pine.LNX.4.64.0711171217200.12193@iabervon.org> <20071118001312.GB4000@sigill.intra.peff.net> <7v6400z6tk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 04:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItaaM-0006cw-Tk
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 04:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbXKRDMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 22:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbXKRDMV
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 22:12:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4161 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407AbXKRDMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 22:12:20 -0500
Received: (qmail 7369 invoked by uid 111); 18 Nov 2007 03:12:18 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 22:12:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 22:12:16 -0500
Content-Disposition: inline
In-Reply-To: <7v6400z6tk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65335>

On Sat, Nov 17, 2007 at 05:21:59PM -0800, Junio C Hamano wrote:

> > Sorry, I don't see the style nit you're mentioning here.
> 
> I think Daniel is referring to "Put 'else' on the same line as
> the brace that closes the corresponding 'if' opened", iow:
> 
> 	if (...) {
>         	...
> 	} else {
> 		...
> 	}

Ah. We are really inconsistent about that (I count about 333 non-cuddled
(but possible to cuddle) versus 499 cuddled). Should we put something in
the CodingGuidelines? I am also happy to roll this change into a style
patch.

For reference, I counted with:

# cuddled:
grep '} *else' *.c | wc -l

# possible but non-cuddled
# when we find an 'else', if the previous line had a '}'
# on it, then it is a hit. There are a few false positives
# when the "} else" is from an outer block scope
# And no, this sed invocation probably isn't totally portable. :)
sed -n '/else/{x; /}/{x;p}}; h' *.c | wc -l
# or to check the accuracy
sed -n '/else/{x; /}/{p;x;p}}; h' *.c

-Peff
