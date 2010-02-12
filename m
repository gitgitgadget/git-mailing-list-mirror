From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Thu, 11 Feb 2010 19:03:02 -0500
Message-ID: <20100212000302.GB21930@coredump.intra.peff.net>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7vmxzj8hca.fsf@alter.siamese.dyndns.org>
 <20100210054957.GG28526@coredump.intra.peff.net>
 <7vwryjpdb6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 01:04:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfj0p-0000rb-Fj
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 01:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab0BLADG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 19:03:06 -0500
Received: from peff.net ([208.65.91.99]:55388 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757535Ab0BLADA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 19:03:00 -0500
Received: (qmail 23928 invoked by uid 107); 12 Feb 2010 00:03:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 19:03:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 19:03:02 -0500
Content-Disposition: inline
In-Reply-To: <7vwryjpdb6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139645>

On Thu, Feb 11, 2010 at 03:23:09PM -0800, Junio C Hamano wrote:

> > I would say yes. The advice output should all be on stderr, and the
> > porcelain output should all be on stdout. So there is no parsing
> > conflict. And stderr either goes to /dev/null (because the porcelain is
> > not terminal-based, or doesn't want the terminal screwed up), in which
> > case the advice does nothing, or stderr goes to the terminal (because
> > the porcelain is some simple script), in which case the message is
> > probably something the user would want to see.
> 
> Hmm, if we make it a rule to send all the advice messages to the standard
> error stream, wouldn't the logical conclusion be that the hunk you are
> commenting is unnecessary?  "push --porcelain" should give advice just as
> usual (but we would simply send the advice to the standard error stream).

Yes and no. The advice it is giving is specifically related to things
you can't see, so it is not really as helpful as it could be. And in
that sense, squelching may be positive.

But it seems that the thread has come to the conclusion that we're still
going to have messages on stderr. There is not much point in suppressing
one particular message if there is a bunch of other cruft. Either the
user should see stuff on stderr, or they shouldn't, and the caller can
decide by redirecting stderr. So yes, squelching that advice probably
should just be dropped.

-Peff
