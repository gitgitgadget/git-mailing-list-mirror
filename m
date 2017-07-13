Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B258D2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 22:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdGMWYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 18:24:48 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:2608 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbdGMWYr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 18:24:47 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x7r3K0fZWz5tlC;
        Fri, 14 Jul 2017 00:24:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 345C8135;
        Fri, 14 Jul 2017 00:24:44 +0200 (CEST)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
 <xmqqeftn3s7t.fsf@gitster.mtv.corp.google.com> <87d195zcy0.fsf@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2f7f7af2-585c-9374-34e3-e34680678935@kdbg.org>
Date:   Fri, 14 Jul 2017 00:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <87d195zcy0.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.2017 um 21:12 schrieb Ævar Arnfjörð Bjarmason:
> I think in the context of this desire Johannes Sixt's "Actually, I'm
> serious [about let's compile with c++]"[1] should be given some more
> consideration.

Thank you for your support.

> I've just compiled Git with it and it passes all tests. I think the
> endeavor is worthwhile in itself as C++ source-level compatibility for
> git.git is clearly easy to achieve, and would effectively give us access
> to more compilers (albeit in different modes, but they may discover
> novel bugs that also apply to the C mode code).

Please keep in mind that my patches only show that it can be done. 
Nevertheless, the result is far, far away from valid C++ code. It can be 
compiled by GCC (thanks to its -fpermissive flag) and happens to produce 
something that works. But that does not mean that other compilers would 
grok it.

Source-level compatibility is only necessary as a stop gap in the 
transition to C++. If the transition is not going to happen, I doubt 
that there is any value. It is simply too much code churn for too little 
gain. The real gains are in the features of C++(11,14).

> But why do it? Aside from the "more compilers" argument, we may find
> that it's going to be much easier to use some C99 features we want by
> having C++ source-level compatibility, and on compilers like that may
> not support those features in C use the C++ mode that may support those.

I would be happy to learn about a C99 feature where C++ mode of some 
compiler would help.

The only C99 feature mentioned so far was designated initializers. 
Unfortunately, that actually widens the gap between C and C++, not 
lessens it. (C++ does not have designated initializers, and they are not 
on the agenda.)

> If not C++ support would be interesting for other reasons. Johannes
> Sixt: It would be very nice to get those patches on-list.

I don't think it's worth to swamp the list with the patches at this 
time. Interested parties can find them here:

https://github.com/j6t/git.git c-plus-plus

I may continue the work, slowly and as long as I find it funny. It's 
just mental exercise, unless the Git community copies the GCC Steering 
Committee's mindeset with regard to C++ in the code base 
(https://gcc.gnu.org/ml/gcc/2010-05/msg00705.html).

-- Hannes
