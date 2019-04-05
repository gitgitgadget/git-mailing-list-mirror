Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5200020248
	for <e@80x24.org>; Fri,  5 Apr 2019 19:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfDETTi (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 15:19:38 -0400
Received: from avasout03.plus.net ([84.93.230.244]:51873 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDETTh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 15:19:37 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id CUNAheVS0R9LaCUNBh8QDQ; Fri, 05 Apr 2019 20:19:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Qa0YQfTv c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=yPgU91rKgUPtIPI7QRkA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 01/13] packfile.h: drop extern from function
 declarations
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190405180306.GA21113@sigill.intra.peff.net>
 <20190405180340.GA32243@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c21b923f-54aa-defa-ecfd-11ecd6f8a664@ramsayjones.plus.com>
Date:   Fri, 5 Apr 2019 20:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405180340.GA32243@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLbEQhTLSIbptcUQgJZQXrzgZv0crOoD3CpxnQkJkBAu7DC9dt1pehOBGjeUUnlCGCvTPeOEcF9nzv32YxiDwgwUlo0X+UXdwRiELhaPLONvdOwp7yL2
 6AWKZlWTgvu+vfj0RhXZ38J8yNxHydZGPmeTejVSlh/U3r+8kod8peedOFs0q8JAhE49t6m5M8WwIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/04/2019 19:03, Jeff King wrote:
> As CodingGuidelines recommends, we do not need an "extern" when
> declaring a public function. Let's drop these. Note that we leave the
> extern on report_garbage(), as that is actually a function pointer, not
> a function itself.

Hmm, perhaps we need to edit CodingGuidelines to make it clear
that the 'extern' keyword is not needed on _function_ declarations
only. ;-)

Because, ...

[snip]

>  /* global flag to enable extra checks when accessing packed objects */
> -extern int do_check_packed_object_crc;
> +int do_check_packed_object_crc;

... removing this 'extern' on an int variable sends 'sparse'
into a frenzy of warnings! :-D

[You didn't use a global s/extern// by any chance?]

ATB,
Ramsay Jones
