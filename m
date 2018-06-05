Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679FA1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 02:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFECa2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 22:30:28 -0400
Received: from avasout01.plus.net ([84.93.230.227]:59421 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFECa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 22:30:27 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id Q1jsfsz9oeLIJQ1jtfQsXz; Tue, 05 Jun 2018 03:30:26 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Y6bWTCWN c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=xwstyAmMAAAA:8 a=M-DojWnYSevVZkpubWsA:9
 a=85rKl49-GmcWHjJt:21 a=UyKsEMn6gheuNY0f:21 a=QEXdDO2ut3YA:10
 a=LlgVSj9pQ0SBo81MGDdQ:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
To:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
 <xmqqefhn5g01.fsf@gitster-ct.c.googlers.com>
 <20180604170640.GB27650@jessie.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ff9215cb-6f38-90df-3073-c0592751249d@ramsayjones.plus.com>
Date:   Tue, 5 Jun 2018 03:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604170640.GB27650@jessie.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBYeKJ4wB4I7y1CZUCDPZsX6MbT1nw3bJJEc/BfzapC3JnX+07Zpi8R4MxUjJDwE2Dl+OuoNPhkReFpU22dgSFkIIxJUtX9fTINMyHtkjyKq2LUiwxNd
 VrwFsC50hWaErjtMzvVaaaBvE+Wb7kUme4dJfXQv/ERLHYkymhIawygc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/06/18 18:06, Max Kirillov wrote:
> On Mon, Jun 04, 2018 at 01:31:58PM +0900, Junio C Hamano wrote:
>> Max Kirillov <max@max630.net> writes:
>>> +		size_t n = xread(0, buf, chunk_length);
>>> +		if (n < 0)
>>> +			die_errno("Reading request failed");
>>
>> n that is of type size_t is unsigned and cannot be negative here.
> 

Hmm, xread() returns an ssize_t, which is a signed type ...

> Thanks, fixing it
> Do you think sanity check for n <= chunk_length (the code
> will go mad in this case) is needed? As far as I can see n
> returns straight from system's read()

ATB,
Ramsay Jones

