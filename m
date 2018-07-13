Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9761F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeGMUYK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:24:10 -0400
Received: from avasout08.plus.net ([212.159.14.20]:54840 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGMUYK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:24:10 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id e4MEfMmW04FpAe4MFfuhKJ; Fri, 13 Jul 2018 21:08:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GpFsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=W0CA8DBOmzruFVnzrjoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
 <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
 <20180707013239.GA4687@sigill.intra.peff.net>
 <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
 <6b323eff-a0a6-d8d3-1e40-70af8299db5f@ramsayjones.plus.com>
 <20180713194119.GC10354@sigill.intra.peff.net>
 <20180713194609.GA16745@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6e3ed7b0-105f-f527-65af-6fc217bc826d@ramsayjones.plus.com>
Date:   Fri, 13 Jul 2018 21:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713194609.GA16745@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAIORrYSZAEgtHuUIW9Q0uuCkJBwwUO3Gm5zHPiErqXqeJeqDGlFqfZpmsob5oeDgXfGa0o92LeNW5XO8x2rumc02d0DKrbEpCbdypq13bNmycRnywn7
 QeZR2r5d2q7q15CPmOf/vujURCzt6P+xDFwcy6pgaHhVZQrK3jWjrHuF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/07/18 20:46, Jeff King wrote:
> On Fri, Jul 13, 2018 at 03:41:19PM -0400, Jeff King wrote:
> 
>>>   not ok 18 - push rejects corrupt .gitmodules (policy)
>>>   #	
>>>   #		rm -rf dst.git &&
>>>   #		git init --bare dst.git &&
>>>   #		git -C dst.git config transfer.fsckObjects true &&
>>>   #		git -C dst.git config fsck.gitmodulesParse error &&
>>>   #		test_must_fail git -C corrupt push ../dst.git HEAD 2>output &&
>>>   #		grep gitmodulesParse output &&
>>>   #		test_i18ngrep ! "bad config" output
>>
>> There are separate config slots for local fsck versus receiving objects.
>> So I think you need to be setting receive.fsck.gitmodulesParse.
> 
> I confirmed that s/fsck/receive.fsck/ in your patch makes the tests
> pass.

Doh! Thanks for catching my stupid mistake! I was rushing a bit
just before going out (yes, I'm going to be late now!).

> I didn't bother adding extra push tests in the patch I just sent, since
> upgrading of config error classes is already covered elsewhere in t5504.

yeah, I like to 'test' by adding tests if I can (makes repeating
the steps less effort ...). So, I was just 'showing my working',
as it were.

> That said, I'm not opposed to adding more tests on top even if they are
> slightly redundant (well, not redundant if you're into black-box
> testing, but our current tests are usually written with an assumption of
> where the module boundaries are, and what is likely to be a problem).

I don't mind either way. I will let you and Junio decide.

Thanks!

ATB,
Ramsay Jones


