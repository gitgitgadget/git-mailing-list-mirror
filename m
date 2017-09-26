Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27ED420281
	for <e@80x24.org>; Tue, 26 Sep 2017 14:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030511AbdIZOot (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 10:44:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:50137 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968369AbdIZOos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 10:44:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D5A1D845B6;
        Tue, 26 Sep 2017 10:44:47 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8304E845B5;
        Tue, 26 Sep 2017 10:44:47 -0400 (EDT)
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <1506252671.8678.3.camel@gmail.com>
 <alpine.DEB.2.21.1.1709251816120.40514@virtualbox>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2646e18b-473e-17bc-fa92-1d7ef5f46055@jeffhostetler.com>
Date:   Tue, 26 Sep 2017 10:44:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709251816120.40514@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/25/2017 12:17 PM, Johannes Schindelin wrote:
> Hi Kaartic,
> 
> On Sun, 24 Sep 2017, Kaartic Sivaraam wrote:
> 
>> On Thursday 21 September 2017 10:02 AM, Jeff King wrote:
>>> Some tools like IDEs or fancy editors may periodically run commands
>>> like "git status" in the background to keep track of the state of the
>>> repository.
>>
>> I might be missing something, shouldn't the IDEs be encouraged to use
>> libgit2 instead? I thought it was meant for these use cases.
> 
> There are pros and cons. Visual Studio moved away from libgit2 e.g. to
> support SSH (back then, libgit2 did not support spawning processes, I have
> no idea whether that changed in the meantime).

There were other issues besides feature parity.  The big one for VS
was that it moved the git computations into a separate process and
address space.  You can't easily read/modify/write a 500MB .git/index
file into memory (with however many copies of the data that that
creates) in a 32-bit process.

