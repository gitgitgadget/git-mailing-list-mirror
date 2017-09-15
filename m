Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6AA20281
	for <e@80x24.org>; Fri, 15 Sep 2017 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbdIOPPS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 11:15:18 -0400
Received: from avasout07.plus.net ([84.93.230.235]:60122 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdIOPPR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 11:15:17 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 9rFE1w00F0M91Ur01rFGvN; Fri, 15 Sep 2017 16:15:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=0qaRyC5sG-QpRDiLfV8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
 <20170913182431.GE27425@aiede.mtv.corp.google.com>
 <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
 <ef20628e-b7c0-8909-31a0-cc126d0c40ba@ramsayjones.plus.com>
 <1012b31b-7bdd-ea20-f004-1c9f80de733c@ramsayjones.plus.com>
 <20170915003754.wlckhuwcftyc32de@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0aa64f62-4acc-4235-d7c4-efb5986699fc@ramsayjones.plus.com>
Date:   Fri, 15 Sep 2017 16:15:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170915003754.wlckhuwcftyc32de@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/09/17 01:37, Jeff King wrote:
> On Thu, Sep 14, 2017 at 12:31:38AM +0100, Ramsay Jones wrote:
> 
>> I just tried it again tonight; the current master branch has 3532
>> warnings when compiled with -Wextra, 1409 of which are -Wsign-compare
>> warnings. After applying the patch below, those numbers are reduced
>> by 344 to 3188/1065.
> 
> I'd love it if we were clean on -Wextra. My big question is many
> contortions we'd have to go through in the code. I don't mind at all if
> we're actually cleaning as we go (e.g., using types of the correct
> signedness, or preventing possible funny interactions). I'm just worried
> it will turn into a bunch of noisy casts.

Hmm, my memory is not what it was, ... ;-) However, I seem to recall
that most of the changes were "improvements", with only a (relatively)
few scattering of casts (behind existing macros - namely the OPTION
macros). (Oh, wait, I think 'unused' parameters etc., was another
problem area).

> The patch you showed seems like an improvement to the code, but I don't
> know if that would be the case for all of them. :)

Yes, I've had that patch (and others like it) hanging around for
years! (perhaps it's time to dig through all those old branches)

ATB,
Ramsay Jones


