From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid gcc compiler warning
Date: Tue, 9 Dec 2014 03:47:28 -0500
Message-ID: <20141209084728.GA13123@peff.net>
References: <cover.1418056722.git.johannes.schindelin@gmx.de>
 <b9e1cb1f858e71b964be4f752fcebc22cd944ebc.1418056722.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyGSF-0001ff-EC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 09:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbaLIIrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 03:47:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:50427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752001AbaLIIrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 03:47:31 -0500
Received: (qmail 12896 invoked by uid 102); 9 Dec 2014 08:47:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 02:47:31 -0600
Received: (qmail 30761 invoked by uid 107); 9 Dec 2014 08:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 03:47:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 03:47:28 -0500
Content-Disposition: inline
In-Reply-To: <b9e1cb1f858e71b964be4f752fcebc22cd944ebc.1418056722.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261115>

On Mon, Dec 08, 2014 at 05:38:59PM +0100, Johannes Schindelin wrote:

> At least on this developer's MacOSX (Snow Leopard, gcc-4.2.1), GCC prints
> a warning that 'hash' may be used uninitialized when compiling
> test-hashmap that 'hash' may be used uninitialized (but GCC 4.6.3 on this
> developer's Ubuntu server does not report this problem).
> 
> Since hash() is called from perf_hashmap() which accepts an unchecked
> integer value from the command line, the warning appears to be legitimate,
> even if the test-hashmap command is only called from the test suite.

I think the older gcc is wrong; we are switching on "method & 3", which
must be in the range 0-3 (and we cover all cases).

I do not mind silencing the warning anyway, but see this discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/258186

The thread seems very broken in gmane, but it continues here:

  http://article.gmane.org/gmane.comp.version-control.git/258232

  http://thread.gmane.org/gmane.comp.version-control.git/258245

  http://article.gmane.org/gmane.comp.version-control.git/258264

-Peff
