Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA2520248
	for <e@80x24.org>; Tue, 26 Mar 2019 05:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCZFpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 01:45:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:36084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725497AbfCZFpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 01:45:43 -0400
Received: (qmail 8773 invoked by uid 109); 26 Mar 2019 05:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 05:45:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15078 invoked by uid 111); 26 Mar 2019 05:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 01:46:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 01:45:41 -0400
Date:   Tue, 26 Mar 2019 01:45:41 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/5] progress: assemble percentage and counters in a
 strbuf before printing
Message-ID: <20190326054541.GD1933@sigill.intra.peff.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325103844.26749-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 11:38:42AM +0100, SZEDER Gábor wrote:

> The following patches in this series want to handle the progress bar's
> title and changing parts (i.e. the counter and the optional percentage
> and throughput combined) differently.
> 
> To prepare for those changes assemble the changing parts in a separate
> strbuf before printing.

Makes sense. Unlike the previous patch, we're already in the "slow path"
of the function here, so we don't need to worry about adding an extra
buffer (though do still think it's worth reusing the same buffer each
time, as you do here).

-Peff
