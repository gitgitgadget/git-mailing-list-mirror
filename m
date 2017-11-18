Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116A5202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 09:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161154AbdKRJBu (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 04:01:50 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:12208 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753070AbdKRJBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 04:01:49 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yf89k49jzz5tlF;
        Sat, 18 Nov 2017 10:01:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C8037211E;
        Sat, 18 Nov 2017 10:01:45 +0100 (CET)
Subject: Re: Improved error handling (Was: [PATCH 1/2] sequencer: factor out
 rewrite_file())
To:     Jeff King <peff@peff.net>, Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Schar?= =?UTF-8?Q?fe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <20171104183643.akaazwswysphzuoq@ruderich.org>
 <20171105020700.2p4nguemzdrwiila@sigill.intra.peff.net>
 <20171106161315.dmftp6ktk6bu7cah@ruderich.org>
 <20171117223345.s3ihubgda3qdb2j6@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c50ac174-15bd-60bc-490c-d231e3eb501d@kdbg.org>
Date:   Sat, 18 Nov 2017 10:01:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171117223345.s3ihubgda3qdb2j6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.2017 um 23:33 schrieb Jeff King:
> On Mon, Nov 06, 2017 at 05:13:15PM +0100, Simon Ruderich wrote:
>> On Sat, Nov 04, 2017 at 10:07:00PM -0400, Jeff King wrote:
>>> Yes, I think what you've written here (and below) is quite close to the
>>> error_context patches I linked elsewhere in the thread. In other
>>> words, I think it's a sane approach.
>>
>> In contrast to error_context I'd like to keep all exiting
>> behavior (die, ignore, etc.) in the hand of the caller and not
>> use any callbacks as that makes the control flow much harder to
>> follow.
> 
> Yeah, I have mixed feelings on that. I think it does make the control
> flow less clear. At the same time, what I found was that handlers like
> die/ignore/warn were the thing that gave the most reduction in
> complexity in the callers.

Would you not consider switching over to C++? With exceptions, you get 
the error context without cluttering the API. (Did I mention that 
librarification would become a breeze? Do not die in library routines: 
not a problem anymore, just catch the exception. die_on_error 
parameters? Not needed anymore. Not to mention that resource leaks would 
be much, MUCH simpler to treat.)

-- Hannes
