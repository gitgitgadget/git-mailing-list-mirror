From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 15:54:06 -0500
Message-ID: <20151111205405.GA31494@sigill.intra.peff.net>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
 <56437F3F.7050305@ramsayjones.plus.com>
 <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:54:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwcPF-00033M-BO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbbKKUyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:54:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:56280 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752148AbbKKUyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:54:08 -0500
Received: (qmail 31494 invoked by uid 102); 11 Nov 2015 20:54:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 14:54:08 -0600
Received: (qmail 9035 invoked by uid 107); 11 Nov 2015 20:54:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Nov 2015 15:54:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Nov 2015 15:54:06 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281201>

On Wed, Nov 11, 2015 at 03:31:01PM -0500, Eric Sunshine wrote:

> The fact that 'long' and 'long long' happen to be the same size (in
> this case) is immaterial. What is important is that the code is just
> wrong to be using the "%l" specifier for 'long' when the actual
> datatype is 'long long' (which is what 'off_t' is under-the-hood in
> this case).

Right. We cannot assume anything about what is in off_t, and should be
casting to uintmax_t. So the patch is right, but I agree the commit
message could be better. I started to hack it up myself, but I didn't
want to put too many words in Ramsay's mouth. Do you mind resending with
an updated commit message?

Thanks (and thank you in the first place for finding and fixing the
breakage I introduced in f8117f55).

-Peff
