From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Thu, 2 Apr 2009 07:27:05 -0400
Message-ID: <20090402112705.GD14599@sigill.intra.peff.net>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <200903310859.36035.chriscool@tuxfamily.org> <7vk56565m1.fsf@gitster.siamese.dyndns.org> <200904020557.25058.chriscool@tuxfamily.org> <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 13:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpL6F-00054Z-N8
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 13:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbZDBL1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 07:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbZDBL1K
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 07:27:10 -0400
Received: from peff.net ([208.65.91.99]:45986 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbZDBL1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 07:27:09 -0400
Received: (qmail 24748 invoked by uid 107); 2 Apr 2009 11:27:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 02 Apr 2009 07:27:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2009 07:27:05 -0400
Content-Disposition: inline
In-Reply-To: <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115457>

On Wed, Apr 01, 2009 at 10:25:09PM -0700, Junio C Hamano wrote:

> > - a header file should be included in a C file only if it is needed to 
> > compile the C file (it is not ok to include it only because it includes 
> > many other headers that are needed)
> 
> If that is the rule, perhaps the problem lies not in a .c program that
> includes such a .h header, but in the .h itself that includes many other
> header files.

If this were combined with splitting gigantic .h files (like cache.h)
into smaller logical units, then we could in theory speed up
recompilation times with make (we would also need to correctly track
header dependencies, but gcc -M can do this fairly easily).

But it does come at the price of actually having to consider which
include files are necessary. I can't think of more than half a dozen
times in the last year I have actually had to add a #include while
working on a git .c file, mostly because everything and the kitchen sink
is included by cache.h.

So I don't know if it is worth it.

-Peff
