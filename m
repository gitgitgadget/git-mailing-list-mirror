Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6651F517
	for <e@80x24.org>; Mon, 11 Jun 2018 11:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeFKLvT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 07:51:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:49925 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932889AbeFKLvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 07:51:19 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D13A93F4083;
        Mon, 11 Jun 2018 07:51:18 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AC1C43F4046;
        Mon, 11 Jun 2018 07:51:18 -0400 (EDT)
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
 <0690b5a8-6c1c-e664-bb89-5d4e48258ddb@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <eafb73e5-31f0-d34a-2179-6c4fef78656e@jeffhostetler.com>
Date:   Mon, 11 Jun 2018 07:51:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0690b5a8-6c1c-e664-bb89-5d4e48258ddb@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/8/2018 4:07 PM, René Scharfe wrote:
> Am 07.06.2018 um 16:12 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
[...]
>> +	if (jw->first_stack.buf[jw->first_stack.len - 1] == '1')
>> +		jw->first_stack.buf[jw->first_stack.len - 1] = '0';
>> +	else
>> +		strbuf_addch(&jw->json, ',');
> 
> You only need a binary flag to indicate if a comma is needed, not a
> stack.  We need a comma at the current level if and only if we already
> wrote a child item.  If we finish a level then we do need a comma at the
> previous level because we just wrote a sub-object or sub-array there.
> And that should cover all cases.  Am I missing something?
> 
> I get a sense of déjà vu, by the way. :)
[...]

Yes, your way is simpler.  I'll update and re-roll.
(And yes, we did discuss this earlier.  I found a problem with
my first version where it wouldn't handle empty sub-items, but
you found the missing piece.)

Thanks
Jeff


