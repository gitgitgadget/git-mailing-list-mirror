From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Mon, 4 Apr 2016 09:41:43 -0400
Message-ID: <20160404134143.GC25404@sigill.intra.peff.net>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-3-git-send-email-santiago@nyu.edu>
 <20160403044054.GB1519@sigill.intra.peff.net>
 <CAPig+cQp2t0y7imR5tTHdLdMO6w13ia-GxZXxq4c2NGaZTjErw@mail.gmail.com>
 <20160403130724.GA16206@sigill.intra.peff.net>
 <20160403215847.GD28933@LykOS>
 <CAPig+cTccb8nr7sV1PKkEf30nRz123TTgeZXkac01RaRwqvTZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santiago Torres <santiago@nyu.edu>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 15:42:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an4lQ-000742-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 15:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbcDDNls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 09:41:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:43640 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbcDDNlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 09:41:47 -0400
Received: (qmail 3367 invoked by uid 102); 4 Apr 2016 13:41:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 09:41:46 -0400
Received: (qmail 24423 invoked by uid 107); 4 Apr 2016 13:41:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Apr 2016 09:41:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Apr 2016 09:41:43 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTccb8nr7sV1PKkEf30nRz123TTgeZXkac01RaRwqvTZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290691>

On Sun, Apr 03, 2016 at 09:38:34PM -0400, Eric Sunshine wrote:

> I think Peff meant that a simple grep would suffice; no need for
> test_i18ngrep. In other words (reproducing Peff's example), something
> like this:
> 
>     tags="fourth-signed sixth-signed seventh-signed" &&
>     for i in $tags; do
>         git verify-tag -v --raw $i || return 1
>     done >expect.stdout 2>expect.stderr.1 &&
>     grep GOODSIG <expect.stderr.1 >expect.stderr &&
>     git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
>     grep GOODSIG <actual.stderr.1 >actual.stderr &&
>     test_cmp expect.stdout actual.stdout &&
>     test_cmp expect.stderr actual.stderr

Yep, though I think I would actually have done:

   grep '^.GNUPG:.' ...

or something to just catch all of the gnupg output.

-Peff
