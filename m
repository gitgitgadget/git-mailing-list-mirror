Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE95C1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 14:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbdLUOSY (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 09:18:24 -0500
Received: from siwi.pair.com ([209.68.5.199]:10790 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752052AbdLUOSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 09:18:18 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 54E9D844DE;
        Thu, 21 Dec 2017 09:18:18 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E39BC844C5;
        Thu, 21 Dec 2017 09:18:17 -0500 (EST)
Subject: Re: [PATCH 3/4] status: update short status to use --no-ahead-behind
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-4-git@jeffhostetler.com>
 <20171220162637.GC31149@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1c019725-7715-496e-bad6-9d47d2bae834@jeffhostetler.com>
Date:   Thu, 21 Dec 2017 09:18:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171220162637.GC31149@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/2017 11:26 AM, Jeff King wrote:
> On Wed, Dec 20, 2017 at 02:42:44PM +0000, Jeff Hostetler wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach "git status --short --branch" to use "--no-ahead-behind"
>> flag to skip computing ahead/behind counts for the branch and
>> its upstream and just report '[different]'.
> 
> How come "--short" and "--long" get this smaller bit of data, but
> "--porcelain=v2" just omits the line entirely?
> 
> I don't have a real preference for or against the "[different]" message
> myself, but if we can get the information cheaply, it seems odd not to
> provide it in all cases.

I was only thinking of VS usage.  But you're right, I can include an
alternate line with eq|neq since we already have the data on hand.


[...]
>> +test_expect_success 'status -s -b --no-ahead-behind (diverged from upstream)' '
> 
> This patch will affect "git status --porcelain", too. That's not
> supposed to change in incompatible ways. I guess it's up for debate
> whether callers are meant to handle any arbitrary string inside the []
> (we already show "[gone]" for some cases), since AFAICT the format of
> the tracking info is left completely vague in the documentation.
> 
> (I'd also hope that everybody is using --porcelain=v2 if they can, but
> we should still avoid breaking v1).

I hadn't intended to alter V1 output.  I'll disable the new feature
when V1 is selected.

Thanks
Jeff

