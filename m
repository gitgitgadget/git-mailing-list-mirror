From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Makefile: introduce SANE_TOOL_PATH for prepending
	required elements to PATH
Date: Thu, 28 May 2009 15:13:43 -0400
Message-ID: <20090528191342.GF13499@coredump.intra.peff.net>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG-BSSbTCg9PE0lVG9rBAr5BVQibQYcIzXrxDf4S0P9Pb6AZO5MBuasg@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrGxTLa3Dlq25WDqK5xSJyY6cvQv4mphIUXvRu59EA7ewVS-vbi5IZUc4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 21:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9l37-0004ZQ-LH
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbZE1TNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbZE1TNt
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:13:49 -0400
Received: from peff.net ([208.65.91.99]:45276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbZE1TNt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:13:49 -0400
Received: (qmail 22439 invoked by uid 107); 28 May 2009 19:13:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 15:13:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 15:13:43 -0400
Content-Disposition: inline
In-Reply-To: <8D9Pn2N3FZLQcyxrPABrGxTLa3Dlq25WDqK5xSJyY6cvQv4mphIUXvRu59EA7ewVS-vbi5IZUc4@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120212>

On Wed, May 27, 2009 at 09:17:08PM -0500, Brandon Casey wrote:

> Some platforms (like SunOS and family) have kept their common binaries at
> some historical moment in time, and introduced new binaries with modern
> features in a special location like /usr/xpg4/bin or /usr/ucb.  Some of the
> features provided by these modern binaries are expected and required by git.
> If the featureful binaries are not in the users path, then git could end up
> using the less featureful binary and fail.
> 
> So provide a mechanism to prepend elements to the users PATH at runtime so
> the modern binaries will be found.

My concern with this is that the PATH bleeds over into things we execute
on behalf of the user, like GIT_EDITOR or snippets in git-filter-branch.
So we can end up surprising users that way.

On the other hand, I don't know how big a problem that is in practice. I
feel like any sane Solaris user is going to have xpg4 in their PATH
these days.

-Peff
