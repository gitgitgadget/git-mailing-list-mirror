Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEEF1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeCZSdJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:33:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:15884 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbeCZSdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:33:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 308EF3F4097;
        Mon, 26 Mar 2018 14:33:05 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DA7C73F4053;
        Mon, 26 Mar 2018 14:33:04 -0400 (EDT)
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1521779249.git.wink@saville.com>
 <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
 <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
 <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
 <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
 <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
 <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
 <xmqqd0zqd8dw.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3d845e99-e392-a62f-b83e-33b58482fc54@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 14:33:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0zqd8dw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 2:00 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> I am concerned that the above compiler error message says that uintmax_t
>> is defined as an "unsigned long" (which is defined as *at least* 32 bits,
>> but not necessarily 64.  But a uint64_t is defined as a "unsigned long long"
>> and guaranteed as a 64 bit value.
> 
> On a platform whose uintmax_t is u32, is it realistic to expect that
> we would be able to use u64, even if we explicitly ask for it, in
> the first place?
> 
> In other words, on a platform that handles uint64_t, I would expect
> uintmax_t to be wide enough to hold an uint64_t value without
> truncation.
> 

I was just going by what the reported compiler error message was.
It said that "unsigned long" didn't match the uint64_t variable.
And that made me nervous.

If all of the platforms we build on define uintmax_t >= 64 bits,
then it doesn't matter.

If we do have a platform where uintmax_t is u32, then we'll have a
lot more breakage than in just the new function I added.

Thanks,
Jeff
