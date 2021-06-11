Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC798C48BE5
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB275613E9
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhFKPqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:46:16 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:39528 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhFKPqP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 11:46:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 9586C40D74;
        Fri, 11 Jun 2021 17:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1623426255; x=1625240656; bh=oasZrkLuY3Z88clanYi
        YitWcoZYoQ6WgbM7MMvo1adE=; b=voKhgY0dEQNJDp9xfoZQFWS7at1FKaS/L2A
        DyhUzJ5aIal9CnY7EbMQyyK87gvN2F283OVXeyfxlAVOVC3zf3TjrD8yPOUBM3Fg
        4gM+R1bXdgRBouzN92MAael8jBzNnRDRUwly9N8RQp/RpqnuF35vJb4vhX1Bgsqf
        x1pJDkKk3WKSvyy1UrNzVQH02jhjNosZ87j0hHDkl7HBrc19gAmUgGszxPyztkLn
        sMgH2/7keda8Q6bNc3klW+Bbgt5KYbcbxGC9VB8IFEH3uV7eqrfyGDxCf1WeDE6G
        mcsWYNcZ/Du8HaVszCoZ/n4u3QISvJMTD2BCZl2KTgF2VMDqqHvjlKoJQ+4MDlJj
        H+KOvJcTGCh9kjOQ1AGsCFoSv+voNt0ebR9yQ/qAfMpsn3PnW/UzSsjRXt5qQjOR
        fxIogKa3b4GcbufmcW7dkBf7HJnmVkbDVq7s+vgzwDzlaGwYxnPq6WOpuCBgXaFo
        LhpVgcIZG5ycRVSqOrN0rPuRmNzjnjAb7kLm1tssnNAahrUuuRow6DatnYFfq2Ck
        P9AOhyD5c/IteqsY4IxGYwgWCL4/ZN8zk5fIwWR6OQ3vCXQ1vXXY4CC7MgSeTCgK
        AkBQeFiR6OR5yHwd7BuP6vDGFvsYKaebzKIsCaugw87nfgt/4IkRlRmIkGLQWcQ1
        GVWqV1bk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WQqoClnnJn9V; Fri, 11 Jun 2021 17:44:15 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id D818940C0B;
        Fri, 11 Jun 2021 17:44:14 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id DFCA35232;
        Fri, 11 Jun 2021 17:44:11 +0200 (CEST)
Subject: Re: UNLEAK(), leak checking in the default tests etc.
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
 <87y2bi0vvl.fsf@evledraar.gmail.com>
 <YMIVzYgNddsR4FSd@coredump.intra.peff.net>
 <bd212451-d8f0-e041-3460-bbbff57542d8@ahunt.org>
 <YMI/g1sHxJgb8/YD@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <18238547-0fbb-a9c4-a769-7e6d865b171a@ahunt.org>
Date:   Fri, 11 Jun 2021 17:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <YMI/g1sHxJgb8/YD@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/06/2021 18:36, Jeff King wrote:
> On Thu, Jun 10, 2021 at 05:32:41PM +0200, Andrzej Hunt wrote:
> 
>>> I do think it would be worth splitting out ASan from leak-checking. The
>>> whole suite should run clean with regular ASan already, and we'd want to
>>> find regressions there even in the tests that aren't leak-clean. I do
>>> periodic ASan runs already; the main argument against doing it for every
>>> CI run is just that's a lot more CPU. But maybe not enough to be
>>> prohibitive? It's probably still way cheaper than running the test suite
>>> on Windows.
>>
>> I've been running tests with ASAN in the Github Actions environment, and a
>> single run takes just over 30 minutes [1] - which I believe is similar to
>> the normal test jobs (they do run the test suite twice in that time I
>> think).
>>
>> I've been doing the same with UBSAN, and that's even faster at 15-20 minutes
>> [2]. However I get the impression that ASAN issues are both more common (at
>> least on seen), and more impactful - so I would argue that ASAN should be
>> prioritised if there's spare capacity. (I have no idea if ASAN+UBSAN can be
>> combined, but I suspect that doing so would make the tests slower?)
> 
> I routinely do SANITIZE=address,undefined since they are both useful
> (and we do not trigger either in the current test suite). I never
> measured the time of their combined use versus just one, but surely it's
> faster the two-at-once approach is faster than running the test suite
> twice.

I'm seeing 33 minutes for SANITIZE=address,undefined - which is no 
slower than SANITIZE=address by itself (disclaimer: it's only one 
measurement):
https://github.com/ahunt/git/runs/2795642716?check_suite_focus=true
(The job's name is wrong but if you look in the logs you can confirm 
that it's using address+undefined.)

The usual linux and mac test-jobs are actually from 24 to 30 minutes 
(the numbers seem a bit variable) - with the exception of one faster 10 
minute job:
https://github.com/git/git/actions/runs/925771097
vs
https://github.com/git/git/actions/runs/927729395

So to summarise: adding an ASAN+UBSAN job would make things a bit 
slower, but not a huge amount slower.
