From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 13:26:12 -0400
Message-ID: <20080623172612.GD27265@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <alpine.DEB.1.00.0806231756340.6440@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApot-00021l-8z
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYFWR0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbYFWR0P
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:26:15 -0400
Received: from peff.net ([208.65.91.99]:1127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYFWR0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:26:14 -0400
Received: (qmail 27595 invoked by uid 111); 23 Jun 2008 17:26:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 13:26:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 13:26:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806231756340.6440@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85891>

On Mon, Jun 23, 2008 at 06:04:48PM +0100, Johannes Schindelin wrote:

> > > Thinking about the recursive approach again, I came up with this POC:
> > 
> > "recursive" is pointless.
> 
> Nope, it is not.

AIUI, one difference between your approach and Pierre's is that he is
suggesting (and I have suggested this in the past, too) a big
DIFF_OPTIONS macro that you stick in the options table for each command.
Whereas you are allowing for subtables accessible via pointers.

Your approach should yield a much leaner text size (which was what
started this whole thing) since we don't end up with the same repeated
subsets of options tables, and in particular the one-liner help text
(yes, compilers can sometimes point share the string literal components,
but most of our options tables are declared as static, so unless the
linker is very smart, I think we will end up with duplicates).

> Heck, we could just as easily introduce PARSE_OPT_IGNORE_UNKNOWN.

We could even send it to the list with message-id

  http://mid.gmane.org/1213758236-979-2-git-send-email-shawn.bohrer@gmail.com

and then Junio and I could complain that the concept is broken.

-Peff
