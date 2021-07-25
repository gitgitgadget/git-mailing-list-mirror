Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E515C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B9960EB4
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 13:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGYMZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 08:25:16 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:38580 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhGYMZP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 08:25:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 80CDC40BCA;
        Sun, 25 Jul 2021 15:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1627218340; x=1629032741; bh=lcNNHEh46eVZHfydNVV
        fNHqSKthVws85V6Pvo/kkTdk=; b=KkCWZmvbSCedOaYzzzY1Q45OifzCQvRlZQZ
        9mr7Fp6Oqa/KtIsdcw5zuWwrj4+t4/voVnyHZ2U/hS/XcVy9YYcPBcS5DGcuDFfJ
        bghixZRByJLGxbM5XvbENLHxXT+cJO/TpP8BOnwtauRsuqvRVY9hME7SUBDKFPVn
        XRj1wdRmOlXEXjz2pk+ttjYutMOmkkpDuIrT8uYT+wOJad+fVXtVyu7YfGtKbF7W
        /qkuojzT1n0HGR6GpnkSyVy6mC3+PfBZ5+cqLG8Yix/WYAdJnR1wvMwdu8D/ZF+p
        l3BSVx45dZ4gb/DWjVjWynw86GUENdeacZqjOwcIy28/o1LhU7qbsrluSd/0D5bf
        FMNYNC0babc2h6/HTPF2OI+Af40pqfLK6Jtl9l2I0Mk83UC8hhZTKPx0vHp4zdc3
        TC2sqBBIHAoFxI/RLhUpYF3sYc6nZf9sv6AbDAQBCy/tAlxgQh9PdtvlB3+BOWeD
        gXEI6hkHOILjrcuv598aLQLNkhO2//sZ77F0A/oaV7SAo5mdlYxMnfKS7cfvkah5
        n4y7I6nKVcwpie8i8IrH7wek57pD/UOUqo/ZsIi2fa+6NSDG01UHBpfeyuTTYbyF
        f7Q9n78/qyKwyIxB73h23q09diRAnUAHOEN60Nci5QoZbE9JMZVqMqReHrStuzKh
        vK9jeXHA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0WaEiNOGbzyF; Sun, 25 Jul 2021 15:05:40 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id CF3C9404BD;
        Sun, 25 Jul 2021 15:05:39 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 4E1E73F28;
        Sun, 25 Jul 2021 15:05:38 +0200 (CEST)
Subject: Re: [PATCH 00/12] Fix all leaks in tests t0002-t0099: Part 2
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <CABPp-BG0a0OM7s7cmO8yCeyA5TOCD_yOSJJepQE8MFEHct4EQA@mail.gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <e83899bb-3d49-68b2-b67b-76ab824adfc3@ahunt.org>
Date:   Sun, 25 Jul 2021 15:05:31 +0200
MIME-Version: 1.0
In-Reply-To: <CABPp-BG0a0OM7s7cmO8yCeyA5TOCD_yOSJJepQE8MFEHct4EQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 21/06/2021 23:54, Elijah Newren wrote:
> On Sun, Jun 20, 2021 at 8:14 AM <andrzej@ahunt.org> wrote:
>>
>> From: Andrzej Hunt <andrzej@ahunt.org>
>>
>> This series plugs more of the leaks that were found while running
>> t0002-t0099 with LSAN.
>>
>> See also the first series (already merged) at [1]. I'm currently
>> expecting at least another 2 series before t0002-t0099 run leak free.
>> I'm not being particularly systematic about the order of patches -
>> although I am trying to send out "real" (if mostly small) leaks first,
>> before sending out the more boring patches that add free()/UNLEAK() to
>> cmd_* and direct helpers thereof.
> 
> I've read over the series.  It provides some good clear fixes.  I
> noted on patches 2, 6, and 12 that a some greps suggested that leaks
> similar to the ones being fixed likely also affect other places of the
> codebase.  Those other places don't need to be fixed as part of this
> series, but they might be good items for #leftoverbits or GSoC early
> tasks (cc: Christian in case he wants to record those somewhere).
> 
> I cc'ed Stolee on patch 4 because he suggested he wanted to read it in
> an earlier discussion.
> 
> Phillip noted some issues with patch 11, and I added a couple more.
> The ownership of opts->strategy appears to be pretty messy and in need
> of cleanup.
> 
> All the patches other than 11 look good to me.
> 

Thank you for the careful reviews - and especially for pointing out when 
a given pattern does occur elsewhere in the codebase!

As suggested I will skip the additional locations that you've found 
while reviewing this series - but I'm starting a separate series where I 
can address those. I have been focused on getting tests to pass 
leak-free one-by-one, but spotting and fixing patterns is probably more 
efficient (since author and reviewer already have the right context) and 
in some cases might fix leaks that aren't occurring during the tests.

ATB,

   Andrzej
