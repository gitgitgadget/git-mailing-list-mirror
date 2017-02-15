Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14FD22013A
	for <e@80x24.org>; Wed, 15 Feb 2017 14:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbdBOO14 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 09:27:56 -0500
Received: from siwi.pair.com ([209.68.5.199]:59879 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751328AbdBOO1z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 09:27:55 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C2C3E845F6;
        Wed, 15 Feb 2017 09:27:53 -0500 (EST)
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
 <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
Date:   Wed, 15 Feb 2017 09:27:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/14/2017 5:03 PM, Jeff King wrote:
> On Tue, Feb 14, 2017 at 12:31:46PM +0100, Johannes Schindelin wrote:
>
>> On Windows, calls to memihash() and maintaining the istate.name_hash and
>> istate.dir_hash HashMaps take significant time on very large
>> repositories. This series of changes reduces the overall time taken for
>> various operations by reducing the number calls to memihash(), moving
>> some of them into multi-threaded code, and etc.
>>
>> Note: one commenter in https://github.com/git-for-windows/git/pull/964
>> pointed out that memihash() only handles ASCII correctly. That is true.
>> And fixing this is outside the purview of this patch series.
> Out of curiosity, do you have numbers? Bonus points if the speedup can
> be shown via a t/perf script.
>
> We have a read-cache perf-test already, but I suspect you'd want
> something more like "git status" or "ls-files -o" that calls into
> read_directory().

I have some informal numbers in a spreadsheet.  I was seeing
a 8-9% speed up on a status on my gigantic repo.

I'll try to put together a before/after perf-test to better demonstrate 
this.

Jeff

