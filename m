Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5002F1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeKVAn3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:43:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:47370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726671AbeKVAn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:43:29 -0500
Received: (qmail 20751 invoked by uid 109); 21 Nov 2018 14:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Nov 2018 14:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9552 invoked by uid 111); 21 Nov 2018 14:08:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Nov 2018 09:08:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2018 09:08:54 -0500
Date:   Wed, 21 Nov 2018 09:08:54 -0500
From:   Jeff King <peff@peff.net>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ref-filter: add worktree atom
Message-ID: <20181121140853.GA10210@sigill.intra.peff.net>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-2-nbelakovski@gmail.com>
 <xmqqsh061u7o.fsf@gitster-ct.c.googlers.com>
 <20181112122245.GB3956@sigill.intra.peff.net>
 <xmqqd0r9zri6.fsf@gitster-ct.c.googlers.com>
 <CAC05387v6odwx3JTfJUR8tCxyqEEf7Z13ROgrLthc4rVLy3bJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC05387v6odwx3JTfJUR8tCxyqEEf7Z13ROgrLthc4rVLy3bJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 03:05:04PM +0100, Nickolai Belakovski wrote:

> I think if we move to making this atom just store worktree path, that
> needs to be implemented as a hashmap of refname->wtpath, which would
> also solve this string_list issue, correct? Just making sure I'm not
> missing something before I submit another patch.

string_list has a "util" field, so you actually _can_ use it to create
a mapping. I do think a hashmap is a little more obvious.

OTOH, the hashmap API is a little tricky; if we are going to add a
"strmap" API soon, it may be simpler to just use a string_list now and
convert to strmap when it is a available.

-Peff
