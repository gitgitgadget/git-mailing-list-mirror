From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] send-pack: abort sideband demuxer on pack-objects error
Date: Thu, 14 Apr 2011 23:05:49 +0200
Message-ID: <201104142305.49579.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104142243.33522.j6t@kdbg.org> <20110414205113.GA7451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATji-00068Q-Le
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab1DNVFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:05:53 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:34524 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750926Ab1DNVFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:05:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 587162C4015;
	Thu, 14 Apr 2011 23:05:50 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2F91F19F610;
	Thu, 14 Apr 2011 23:05:50 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20110414205113.GA7451@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171552>

On Donnerstag, 14. April 2011, Jeff King wrote:
> So what do you want to do about the fd that needs closing? The options
> I see are:
>
>   1. Try for a general solution. That probably means the "close every
>      descriptor in the child" hackiness that I mentioned earlier.
>
>   2. Fix this case by having the async code close it if it was forked.
>      It needs to know whether we forked, so we can:
>
>        a. Use NO_PTHREADS. Easy and simple, though it does break
>           start_async's abstraction a bit.
>
>        b. Have start_async pass in a flag telling what happened. This
>           really breaks the abstraction very similarly to (a), but it
>           makes the connection more explicit.
>
> I think I am leaning a bit towards (2a). It's simple, and it's not like
> this is library code with a million unknown callers; fixing it simply
> and cleanly with a nice commit message is probably sufficient.

(2a) would be good enough for my taste, too!

-- Hannes
