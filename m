Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472EEC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2624160FEB
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhFJPev (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:34:51 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:5748 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhFJPev (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:34:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C72DF4067D;
        Thu, 10 Jun 2021 17:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1623339172; x=1625153573; bh=fFLGaqVD7m1/g1AUVpv
        8r9EnWUUkGr3PGRm4t3D8lhQ=; b=p57/ru2+NmzNVKzvmXKdDRNSOoFILMjvBKh
        yti9R3wco9iaS5lgxsO8aPBb+M2RsDToTA2qZa9Ms7cHN4RDmIlz0PylSyP1Bqkr
        ZCnfnODspv4AAGjVVKHAXghJNIF4MPCk6XZn1ZlTFkqYsgQD1QlvifzabvTKOZLx
        01vzpHU4r5fTQAKvDrPFmLisHu/MJCKzmtdQ3iclsy790wnO5526jFMgXQvOVX0h
        3S//+6TmDZ2TQ5nsYSCP6PZnZjFiSX+3ZlSnm+TTG/OaJmtsHCTZg5Eyn7WAzM3S
        BJfjS/Mg1G1PBOopWvK7rPChluK34v9Aqu1bgoInhzbrv6Oab0g0KJISVaOcSh2t
        ZWBMcKQxkUk5HHB9H/hv8LmHN1stB61hnwI8B2q+TK1x0hjLSC3q2fsWGdTDAe9C
        0qnCFJ7R4JGTNXSYBpb84agxE//50oqIFpmyx0r5XEMU1bJpAS9Z5Nbd4doBiasM
        sh9lFFjfMGti8aIZN0GPDWs0r34C7R6tnxAdJnRBWaAb3PJBSCyAlTIdqJxs6S5T
        m7/4ZrT6hNeY7OWBJEyVDObSy0vVuWIJbtFP3ig+0MoEJWVcj7hsCVJvrmt7K1Qj
        byvX6n1NRbaO8Pu64konurZaokStvr5jMWy4M9dl0DqdcjVXKZucBZIz0QTwkbSK
        E2e8fZxk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cwRnDvvycjD8; Thu, 10 Jun 2021 17:32:52 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id DD5C8404BD;
        Thu, 10 Jun 2021 17:32:51 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 12A7518F;
        Thu, 10 Jun 2021 17:32:46 +0200 (CEST)
Subject: Re: UNLEAK(), leak checking in the default tests etc.
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
 <87y2bi0vvl.fsf@evledraar.gmail.com>
 <YMIVzYgNddsR4FSd@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <bd212451-d8f0-e041-3460-bbbff57542d8@ahunt.org>
Date:   Thu, 10 Jun 2021 17:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <YMIVzYgNddsR4FSd@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/06/2021 15:38, Jeff King wrote:
>> I ran it, noted the failing tests, produced a giant GIT_SKIP_TESTS list
>> and hacked ci/ to run that as a new linux-clang-SANITIZE job. That messy
>> WIP code is currently running at:
>> https://github.com/avar/git/runs/2793150092
>>
>> Wouldn't it be a good idea to have such a job and slowly work on the
>> exclusion list?
>>
>> E.g. I saw that t0004 failed, which was trivially fixed with a single
>> strbuf_release(), and we could guard against regressions.
> 
> I don't mind that. My intent was to get the whole suite clean
> eventually, and then start worrying about regressions. But that may take
> a while.
> 
> I do think it would be worth splitting out ASan from leak-checking. The
> whole suite should run clean with regular ASan already, and we'd want to
> find regressions there even in the tests that aren't leak-clean. I do
> periodic ASan runs already; the main argument against doing it for every
> CI run is just that's a lot more CPU. But maybe not enough to be
> prohibitive? It's probably still way cheaper than running the test suite
> on Windows.

I've been running tests with ASAN in the Github Actions environment, and 
a single run takes just over 30 minutes [1] - which I believe is similar 
to the normal test jobs (they do run the test suite twice in that time I 
think).

I've been doing the same with UBSAN, and that's even faster at 15-20 
minutes [2]. However I get the impression that ASAN issues are both more 
common (at least on seen), and more impactful - so I would argue that 
ASAN should be prioritised if there's spare capacity. (I have no idea if 
ASAN+UBSAN can be combined, but I suspect that doing so would make the 
tests slower?)

I'm also running LSAN tests in CI to try and catch regressions, but I've 
only enabled a handful of tests so far. My much simpler approach was to 
specify the range of tests to run as 0-X, and as we make progress on 
fixing leaks, X will slowly approach 9999 (currently we're at something 
like X~=5, although I'm not too far off sending out some patches to 
boost that to 99). The skip-tests approach seems much more useful!

ATB,

   Andrzej

[1] https://github.com/ahunt/git/runs/2789921851?check_suite_focus=true
[2] https://github.com/ahunt/git/runs/2760632000?check_suite_focus=true

