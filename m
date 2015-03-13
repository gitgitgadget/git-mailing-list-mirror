From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] fix transfer.hiderefs with smart http
Date: Fri, 13 Mar 2015 00:59:52 -0400
Message-ID: <20150313045952.GA18853@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 06:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHhX-0000yk-El
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbbCME7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:59:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:60830 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750853AbbCME7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:59:54 -0400
Received: (qmail 31299 invoked by uid 102); 13 Mar 2015 04:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:59:54 -0500
Received: (qmail 9650 invoked by uid 107); 13 Mar 2015 05:00:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 01:00:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:59:52 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265399>

On Fri, Mar 13, 2015 at 12:41:01AM -0400, Jeff King wrote:

> I'm experimenting with using transfer.hiderefs on a server, and it's
> rather easy to cause a git client to hang when fetching from such a repo
> over smart http. Details are in the first patch.

A note on this hang. What happens is that upload-pack sees a bogus
"want" line and calls die(). The client then sits there forever, but I'm
not exactly sure what it's waiting for.

This series fixes the bug that caused us to erroneously call die() in
upload-pack, so the hang is "fixed". But there are other reasons to call
die(); it would probably be a good thing if the client side noticed the
problem and aborted.

-Peff
