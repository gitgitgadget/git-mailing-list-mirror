Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2621F453
	for <e@80x24.org>; Thu,  7 Feb 2019 21:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfBGVAM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 16:00:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:36622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726832AbfBGVAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 16:00:11 -0500
Received: (qmail 14401 invoked by uid 109); 7 Feb 2019 21:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Feb 2019 21:00:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19139 invoked by uid 111); 7 Feb 2019 21:00:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Feb 2019 16:00:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2019 16:00:09 -0500
Date:   Thu, 7 Feb 2019 16:00:09 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE check
Message-ID: <20190207210009.GA30825@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
 <20190206104243.GJ10587@szeder.dev>
 <20190207020022.GA29974@sigill.intra.peff.net>
 <20190207041802.ai25fc64sqfg2h66@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190207041802.ai25fc64sqfg2h66@tb-raspi4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 04:18:02AM +0000, Torsten Bögershausen wrote:

> And trying to answer an older question:
> 
> >>>The reason appears to be wrong bit mask usage
> >>>#define ADD_CACHE_IGNORE_ERRORS    4
> >>>and
> >>>#define HASH_RENORMALIZE  4
> 
> What if we had renamed "flags" like this ?
> [...]
> -int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
> +int add_to_index(struct index_state *istate, const char *path, struct stat *st, int add_cache_flags)

Yes, changing the name of the variable in the original patch would have
caught this case. I don't know if it is worth doing now or not (the code
as it is now seems pretty clear to me, but of course I've looked at it a
lot lately).

-Peff
