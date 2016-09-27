Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0071C20986
	for <e@80x24.org>; Tue, 27 Sep 2016 12:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbcI0MNl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 08:13:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:48753 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932916AbcI0MNk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 08:13:40 -0400
Received: (qmail 9578 invoked by uid 109); 27 Sep 2016 12:13:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 12:13:39 +0000
Received: (qmail 15457 invoked by uid 111); 27 Sep 2016 12:13:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 08:13:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 08:13:36 -0400
Date:   Tue, 27 Sep 2016 08:13:36 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 07/11] pkt-line: add functions to read/write flush
 terminated packet streams
Message-ID: <20160927121336.7ftrqw2242tetcf3@sigill.intra.peff.net>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-8-larsxschneider@gmail.com>
 <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com>
 <77315FC2-47F3-433A-8D70-5497FB04CBBE@gmail.com>
 <6D8B988C-8E54-4AA6-980C-A6BA40983D88@gmail.com>
 <20160927090031.jjb3dmhspbbnizja@sigill.intra.peff.net>
 <AF15F1E5-4DA0-459F-84EE-EDCB5FA23EF7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AF15F1E5-4DA0-459F-84EE-EDCB5FA23EF7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 02:10:50PM +0200, Lars Schneider wrote:

> > That being said, why don't you just use LARGE_PACKET_MAX here? It is
> > already the accepted size for feeding to packet_read(), and we know it
> > has enough space to hold a NUL terminator. Yes, we may over-allocate by
> > 4 bytes, but that isn't really relevant. Strbufs over-allocate anyway.
> 
> TBH in that case I would prefer the "PKTLINE_DATA_MAXLEN+1" solution with
> an additional comment explaining "+1".
> 
> Would that be OK for you?
> 
> I am not worried about the extra 4 bytes. I am worried that we make it harder
> to see what is going on if we use LARGE_PACKET_MAX.

I guess I don't feel to strongly either way. My interest in
LARGE_PACKET_MAX is mostly that this is how all the rest of the
packet_read() callers behave.

-Peff
