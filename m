Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BE51F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 10:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeC0KYh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 06:24:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:37944 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbeC0KYg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 06:24:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 49E473F4090;
        Tue, 27 Mar 2018 06:24:36 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 22C113F4015;
        Tue, 27 Mar 2018 06:24:36 -0400 (EDT)
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
References: <cover.1521868951.git.wink@saville.com>
 <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
 <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
 <c8628770-71d7-42f4-4bc5-444ea0160d26@ramsayjones.plus.com>
 <xmqqr2o6dayt.fsf@gitster-ct.c.googlers.com>
 <9512a1eb-2b9d-fda5-f2a5-c9f59dff972c@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d3fc60d1-2d8f-ec8c-cafe-f96547eff9ca@jeffhostetler.com>
Date:   Tue, 27 Mar 2018 06:24:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <9512a1eb-2b9d-fda5-f2a5-c9f59dff972c@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/26/2018 11:26 PM, Ramsay Jones wrote:
> On 26/03/18 18:04, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
[...]
> I must confess to not having given any thought to the wider
> implications of the code. I don't really know what this code
> is going to be used for. [Although I did shudder when I read
> some mention of a 'universal interchange format' - I still
> have nightmares about XML :-D ]
[...]

My current goals are to add telemetry in a friendly way and
have events written in JSON to some audit destination.
Something like:

     { "argv":["./git","status"],
       "pid":84941,
       "exit-code":0,
       "elapsed-time":0.011121,
       "version":"2.16.2.5.g71445db.dirty",
       ... }

Later, we could add a JSON formatter to a command like "status"
and then do things like:

     $ git status --json | python '... json.load ...'

and eliminate the need to write custom parsers for normal
or porcelain formats.  There are other commands that could
be similarly adapted and save callers a lot of screen-scraping
code.  But that is later.

Thanks,
Jeff
