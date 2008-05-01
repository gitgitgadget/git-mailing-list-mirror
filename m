From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 18:42:16 -0400
Message-ID: <20080501224215.GB21731@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com> <20080501153457.GB11469@sigill.intra.peff.net> <32541b130805010850q165fe1d6me05e670ca93b0892@mail.gmail.com> <20080501164829.GA11636@sigill.intra.peff.net> <32541b130805011245j76421635me55947cf7869f31f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 00:43:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrhUY-0004b8-3N
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 00:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYEAWmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 18:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbYEAWmR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 18:42:17 -0400
Received: from peff.net ([208.65.91.99]:1779 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbYEAWmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 18:42:16 -0400
Received: (qmail 9503 invoked by uid 111); 1 May 2008 22:42:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 18:42:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 18:42:16 -0400
Content-Disposition: inline
In-Reply-To: <32541b130805011245j76421635me55947cf7869f31f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80944>

On Thu, May 01, 2008 at 03:45:07PM -0400, Avery Pennarun wrote:

> In your example above, we compare the merge-base to the new version;
> in that case, the new file is in an *existing* directory which
> definitely corresponds to src/ in #1, because the the new version has
> never even heard about src/ being deleted.  Thus, the file must be
> intended to be part of the original src/, wherever it may now be.

I disagree with the final statement of the quoted paragraph above.

Just because you didn't build on the commit that moved src/* doesn't
mean the thing you put in src/ was intended to be moved along with src/.
For example:

  - it might have been a new work unrelated to the existing work in src/
    that got moved

  - it might have been a replacement for the work in src/ that was
    started before the movement. E.g., developer1 begins the replacement
    work. developer2 moves the old work out of the way. When the
    branches are merged, you don't want developer1's work moved.

And yes, I think those are probably less common than "it should be moved
along with src/*". My point isn't that this isn't a valuable construct,
but that we should stop short of mind-reading, and focus on making it
_easy_ to see what happened and to concisely specify the choice and
proceed.

-Peff
