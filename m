From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 16:00:11 -0400
Message-ID: <20070613200011.GA17360@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site> <20070613184109.GG10941@coredump.intra.peff.net> <Pine.LNX.4.64.0706131953370.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZ2E-0005eh-Rr
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbXFMUAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbXFMUAR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:00:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1459 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755AbXFMUAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:00:15 -0400
Received: (qmail 14890 invoked from network); 13 Jun 2007 20:00:26 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 13 Jun 2007 20:00:26 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 16:00:11 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706131953370.4059@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50123>

On Wed, Jun 13, 2007 at 07:54:59PM +0100, Johannes Schindelin wrote:

> :-) Since you seem comfortable with regular expressions, maybe you can 
> help me: I am looking for a pattern which matches _any_ character, and one 
> which matches only non-newlines, both with and without REG_NEWLINE. Hmm?

Without REG_NEWLINE, any character is just '.', but I think you are
stuck with '[^
]' for non-newlines, since POSIX makes no provisions for quoting the
newline (I just skimmed through POSIX chapter 9, and I didn't see
anything useful).

With REG_NEWLINE, non-newlines is of course '.'. Matching both is tricky
without using extended regular expressions (where you could just do '.|
'). In fact, I have been playing with it for a few minutes and I can't
seem to find a good way, since you really want to represent '.' _inside_
a bracketed alternation sequence. But I don't think there's a character
class for "everything".

I think this would be much easier with pcre, but ISTR some opposition to
that a few months back.

So that's probably not very helpful to you, but at least you have
confirmation from one other person that the answer isn't totally
obvious. :)

-Peff
