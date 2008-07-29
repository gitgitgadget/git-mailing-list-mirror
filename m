From: Jeff King <peff@peff.net>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 08:52:47 -0400
Message-ID: <20080729125247.GC12069@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNoi6-0007vM-Hx
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 14:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYG2Mwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 08:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYG2Mwu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 08:52:50 -0400
Received: from peff.net ([208.65.91.99]:4743 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbYG2Mwu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 08:52:50 -0400
Received: (qmail 8945 invoked by uid 111); 29 Jul 2008 12:52:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 29 Jul 2008 08:52:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2008 08:52:47 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90631>

On Tue, Jul 29, 2008 at 02:32:14PM +0200, Roman Zippel wrote:

> > Perhaps I am just slow, but I haven't been able to figure out what that
> > history is, or what the "correct" output should be. Can you try to state
> > more clearly what it is you are looking for?
> 
> Most frequently this involves changes where the same change is merged 
> twice. Another interesting example is kernel/printk.c where a change is 
> added and later removed again before it's merged.

I glanced briefly over "gitk kernel/printk.c" and it looks pretty sane.
I was really hoping for you to make your case as something like:

  1. here is an ascii diagram of an actual history graph (or a recipe of
     git commands for making one)
  2. here is what git-log (or gitk) produces for this history by
     default; and here is why it is not optimal (presumably some
     information it fails to convey)
  3. here is what git-log (or gitk) with --full-history produces; and
     here is why it is not optimal (presumably because it is too messy)
  4. here is what output I would like to see. Bonus points for "and here
     is an algorithm that accomplishes it."

> The point is now that I think the problem is solvable even within Linus' 
> constraints, so that git-log produces the right output by default and a 
> workaround like --full-history isn't needed anymore.

I think this is a separate issue. Even if you came up with some great
new history simplification, it likely wouldn't become the _default_
right away anyway. So you need to:

  1. produce a new simplification algorithm that is at least useful in
     _some_ contexts. Then this can be used when desired for those
     contexts. It almost doesn't matter how efficient it is, if it is
     providing results that are otherwise unavailable. A user can choose
     to take the performance hit to get those results.

  2. If that algorithm doesn't provide worse output in any other
     contexts _and_ it has similar performance to the current default,
     then it can be considered for the default.

But I haven't seen convincing evidence leading to step '1', so arguing
about step '2' seems pointless.

-Peff
