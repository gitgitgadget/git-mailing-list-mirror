Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA15C1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 21:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965782AbdDSVAd (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 17:00:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:36302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938270AbdDSVAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 17:00:33 -0400
Received: (qmail 22244 invoked by uid 109); 19 Apr 2017 21:00:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 21:00:30 +0000
Received: (qmail 26754 invoked by uid 111); 19 Apr 2017 21:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 17:00:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Apr 2017 17:00:28 -0400
Date:   Wed, 19 Apr 2017 17:00:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC PATCH] parse-options: disallow double-negations of options
 starting with no-
Message-ID: <20170419210028.sky24qda7kp4pl5y@sigill.intra.peff.net>
References: <20170419090820.20279-1-jacob.e.keller@intel.com>
 <20170419151005.wolvxiacjqxoqrq3@sigill.intra.peff.net>
 <CA+P7+xqo6BJ8LXy8EVvq0JXPD4r-jZ6boOGT=2XY8SVnWfVMcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqo6BJ8LXy8EVvq0JXPD4r-jZ6boOGT=2XY8SVnWfVMcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 01:54:06PM -0700, Jacob Keller wrote:

> This is why it's an RFC. I don't really feel that it's too much of a
> problem. As for the reason why I thought it might want a flag itself
> is because of concerns raised earlier that we might have something
> liek
> 
> OPT_BOOL( ... "no-stage" ...)
> OPT_INT(... "stage" ....)
> 
> or something already which might be broken and the only proper way to
> disable no-stage is no-no-stage?
> 
> Is this actually a concern? I thought this was a comment raised by you
> earlier as an objection to a change unless we specifically flagged
> them as OPT_NEGBOOL()

I think the breakage in that case would be caused by "--no-stage" taking
over "--stage" as well. And your patch doesn't change that; it happened
already in 2012.

Your patch only affects the --no-no- form, which I think we would never
want. I don't think it needs callers to trigger it explicitly.

-Peff
