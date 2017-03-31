Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FACF1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbdCaNVj (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:21:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:61104 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754666AbdCaNUk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:20:40 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC590845E9;
        Fri, 31 Mar 2017 09:20:38 -0400 (EDT)
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
 <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
 <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
 <xmqqtw6a35qc.fsf@gitster.mtv.corp.google.com>
 <20170330195820.kexvl44x7ncthlcx@sigill.intra.peff.net>
 <xmqqa882336t.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cf8baa5b-34ca-658e-0de5-03b69ab86521@jeffhostetler.com>
Date:   Fri, 31 Mar 2017 09:20:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa882336t.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/30/2017 4:44 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> Still, I'm not sure the extra layer of cache is all that valuable. It
>> should be a single hash lookup in the config cache (in an operation that
>> otherwise reads the entire index).
>
> OK, let's drop that part, then.
>

Yes, let's omit the caching there.  That way perf tests can run it
multiple times with it on or off as they see fit.  And in the normal
case it will only be executed once anyway.
