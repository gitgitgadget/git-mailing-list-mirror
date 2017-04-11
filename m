Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4820420970
	for <e@80x24.org>; Tue, 11 Apr 2017 21:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753895AbdDKVch (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 17:32:37 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:60413 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbdDKVcf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 17:32:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w2gJ039Pdz5tl9;
        Tue, 11 Apr 2017 23:32:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CDB22F9D;
        Tue, 11 Apr 2017 23:32:31 +0200 (CEST)
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170410125911.6800-1-szeder.dev@gmail.com>
 <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net>
 <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
Date:   Tue, 11 Apr 2017 23:32:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2017 um 19:01 schrieb Jeff King:
> I wonder if you could make it a general test-lib function, like:
>
>   run_and_wait () {
> 	# we read stdout from the child only for the side effect
> 	# of waiting until all child sub-processes exit, closing their
> 	# fd 9.
> 	does_not_matter=$("$@" 9>&1)

I'm afraid this won't work on Windows when the invoked command is git. 
FD inheritance between MSYS (bash) and non-MSYS programs (git) is only 
implemented for FDs 0,1,2. That's a deficiency of MSYS, and I don't 
think that was improved in MSYS2.

>   }

-- Hannes

