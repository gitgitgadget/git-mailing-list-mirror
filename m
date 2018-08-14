Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9779D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeHNVH4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:07:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:62458 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeHNVH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:07:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BF0373F409F;
        Tue, 14 Aug 2018 14:19:32 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 67D553F4094;
        Tue, 14 Aug 2018 14:19:32 -0400 (EDT)
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben.Peart@microsoft.com, git@vger.kernel.org,
        peartben@gmail.com, Elijah Newren <newren@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
 <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
Date:   Tue, 14 Aug 2018 14:19:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/13/2018 6:41 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I can buy the argument that it's nice to have some form of profiling
>> that works everywhere, even if it's lowest-common-denominator. I just
>> wonder if we could be investing effort into tooling around existing
>> solutions that will end up more powerful and flexible in the long run.
> 
> Another thing I noticed is that the codepaths we would find
> interesting to annotate with trace_performance_* stuff often
> overlaps with the "slog" thing.  If the latter aims to eventually
> replace GIT_TRACE (and if not, I suspect there is not much point
> adding it in the first place), perhaps we can extend it to also
> cover the need of these trace_performance_* calls, so that we do not
> have to carry three different tracing mechanisms.
> 

I'm looking at adding code to my SLOG (better name suggestions welcome)
patch series to eventually replace the existing git_trace facility.
And I would like to have a set of nested messages like Duy has proposed
be a part of that.

In an independent effort I've found the nested messages being very
helpful in certain contexts.  They are not a replacement for the
various platform tools, like PerfView and friends as discussed earlier
on this thread, but then again I can ask a customer to turn a knob and
run it again and send me the output and hopefully get a rough idea of
the problem -- without having them install a bunch of perf tools.

Jeff

