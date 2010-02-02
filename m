From: Jeff King <peff@peff.net>
Subject: Re: Fix signal handler
Date: Tue, 2 Feb 2010 17:32:08 -0500
Message-ID: <20100202223208.GB18781@sigill.intra.peff.net>
References: <4B684F5F.7020409@web.de>
 <20100202205849.GA14385@sigill.intra.peff.net>
 <4B689CC5.3000400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRI8-0004HQ-B6
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757048Ab0BBWcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 17:32:12 -0500
Received: from peff.net ([208.65.91.99]:51614 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713Ab0BBWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 17:32:10 -0500
Received: (qmail 18277 invoked by uid 107); 2 Feb 2010 22:32:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 02 Feb 2010 17:32:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Feb 2010 17:32:08 -0500
Content-Disposition: inline
In-Reply-To: <4B689CC5.3000400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138773>

On Tue, Feb 02, 2010 at 10:44:37PM +0100, Markus Elfring wrote:

> > No, it's not a sig_atomic_t, but it is assignment of a single function
> > pointer that is properly declared as volatile. Is this actually a
> > problem on any known system?
> 
> Is it guaranteed to work on all supported software environments that an
> address can be atomically set?

I think you are missing my point. We are not coding to a set of
standards that provide guarantees. We are coding to a practical set of
real-world implementations that people try to run git on and produce bug
reports for. I do not think anyone on this list could even enumerate a
complete a list of the "supported software environments" of git.

We try to be conservative about portability issues. Some things are
obviously wrong. But other things may violate the letter of some
standards, and yet work in practice on all of the platforms people are
interested in running git on.

I don't think anyone here is much interested in whether there is any
sort of guarantee on a particular construct working. What we do care
about is whether there is an actual problem on some platform that enough
people care about to justify rewriting the code to handle it.

So to answer your question, I honestly don't know. The code may well be
broken on common platforms and it is simply a race condition that has
never come up. But I do know that it has not been a common source of bug
reports, which makes me not want to spend time investigating it when
nobody has demonstrated its incorrectness beyond mentioning a standards
document.  Especially when that time could be better spent fixing other
bugs.

-Peff
