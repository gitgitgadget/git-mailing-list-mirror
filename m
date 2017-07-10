Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4BC20357
	for <e@80x24.org>; Mon, 10 Jul 2017 19:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbdGJT5o (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 15:57:44 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:43975 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754183AbdGJT5n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 15:57:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x5wx12KjQz5tlD;
        Mon, 10 Jul 2017 21:57:41 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AE694139;
        Mon, 10 Jul 2017 21:57:40 +0200 (CEST)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
Date:   Mon, 10 Jul 2017 21:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.07.2017 um 09:03 schrieb Jeff King:
> On Sun, Jul 09, 2017 at 10:05:49AM -0700, Junio C Hamano wrote:
> 
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> I wonder when we can begin to target C99 in git's source, though. :)
>>
>> Let's get the ball rolling...

Good to know that you do not resist moving to a more modern build 
environment.

>> by starting to use some of the useful
>> features like designated initializers,

It's a pity, though, that you do not suggest something even more useful, 
such as C++14.

> Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT

> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }

While this may serve as a test balloon, changing STRBUF_INIT, or any of 
those _INIT macros, is actually the least interesting. The interesting 
instances are initializations for which we do *not* have a macro.

-- Hannes
