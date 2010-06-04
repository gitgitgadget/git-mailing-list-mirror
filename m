From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Fri, 4 Jun 2010 11:25:19 -0400
Message-ID: <20100604152519.GA22844@sigill.intra.peff.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <vpq1vco41go.fsf@bauges.imag.fr>
 <4C07C2E8.508@drmicha.warpmail.net>
 <20100603170724.GB22779@coredump.intra.peff.net>
 <4C090A84.20209@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 04 17:25:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKYm1-000812-Tz
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 17:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab0FDPZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 11:25:25 -0400
Received: from peff.net ([208.65.91.99]:56642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0FDPZY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 11:25:24 -0400
Received: (qmail 14431 invoked by uid 107); 4 Jun 2010 15:25:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 04 Jun 2010 11:25:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jun 2010 11:25:19 -0400
Content-Disposition: inline
In-Reply-To: <4C090A84.20209@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148424>

On Fri, Jun 04, 2010 at 04:15:32PM +0200, Johannes Sixt wrote:

> Am 03.06.2010 19:07, schrieb Jeff King:
> >I don't think "but they should be using plumbing to generate patches"
> >is the right answer, either. Yes, we expect the diff porcelain to behave
> >differently depending on configuration, but with the exception of
> >textconv, it always produces an actual applicable patch.
> 
> I don't by into that argument: You have to give --binary if you have
> changes in binary files. With Michael's patch, you have to give
> --no-textonv (too). I'm in favor of the patch.

OK, I'll accept that "git diff | git apply" does have some special
cases which need to be considered. But every special case is a possible
place for users to make a mistake. So we have to consider whether adding
another one is worthwhile. Specifically:

  1. Are symlinks as unusual an occurrence as binary files? Do users
     perceive them as different enough from regular text files that they
     will remember to use special command line options?

  2. Traditionally, symlinks have not been such a special case. Is a
     behavior change between versions worth it?

I am not necessarily against the patch. I'm just trying to think through
all of the possible negative ramifications. I think I would prefer the
approach to treat it like color (do it only when requested explicitly,
or when outputting to a terminal or pager).

-Peff
