From: Jeff King <peff@peff.net>
Subject: Re: git filter-branch not removing commits when it should in 2.7.0
Date: Tue, 19 Jan 2016 16:37:05 -0500
Message-ID: <20160119213705.GA28656@sigill.intra.peff.net>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
 <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
 <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLdxg-00045q-UT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbcASVhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:37:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:56473 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757156AbcASVhI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:37:08 -0500
Received: (qmail 9634 invoked by uid 102); 19 Jan 2016 21:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 16:37:07 -0500
Received: (qmail 26949 invoked by uid 107); 19 Jan 2016 21:37:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 16:37:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 16:37:05 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284381>

On Tue, Jan 19, 2016 at 01:35:25PM -0800, Junio C Hamano wrote:

> In other words, would the fix be a one-liner like this?
> [...]
> -		tree="$commit^{tree}"
> +		tree=$(git rev-parse "$commit^{tree}")

Yes, I was just writing up the commit message for it. :-/

It _is_ slower, though, because it introduces an extra rev-parse. When
we could in fact be getting rid of one. Give me a moment to complete a
few timing tests and post the results.

-Peff
