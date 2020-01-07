Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B997C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3235220656
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLNbAfTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgAGSr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:47:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45147 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgAGSr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 13:47:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id l12so572407qtq.12
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LNAaBV91bzHBV+yBepfkdXHpp72tyP3aG/rsKQt5fU0=;
        b=PLNbAfTqAYiKTcvJz4CowVlV/UvjZ5yxmdRTddL+kstd4n5Xh5DaTo5sdceKM2q4Ql
         2s1OCP0VZ+4SCERBGT/IUly9AO6K3qlXbXJ5rBVQhn5D50BduN1rwDmZtE2iRTg28ag3
         q/CdUZs5ZydM8OnkRhqg2HVKtV1cGcyo6226ttxEsuzd39413JYujyiSi5jFJZUMW8uD
         ZzFa94WKOk75bzVu6eDbONe7djE66RX2Li5tZcG12SLqnJ4O5rfS8ku1CWnsac60ZA0b
         n2yP2yj1TbgnIyhYywlfONVQKpTarHPHc2K3MXFWjXPrjU9RyhO59FCxRpWkr9EZu8+t
         kGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNAaBV91bzHBV+yBepfkdXHpp72tyP3aG/rsKQt5fU0=;
        b=q2LBhODbaIp2apihuCiRgAEcQQjIoJ5X6sElAuohedINtEdi4YD+UxMGLlck8eP0er
         IQpz+0AukucVLoI+/NKunS1OJ43gNBR9rtorZZUUkem1qzpxB9MuzbZs2I7z1V4+o5RA
         Zu4H51HUE7ogHN/KzwD/AAj+deXwABh7QedAma0/WwWASWSDQavzESSiS1KnrsfZCwYt
         O+KC6WvIU1KJKo9RD6ZrAS2IuIdIyD/ndkEnGjVqOvDMkfL6PpGBHn789K+OFF+/aiSg
         b7puqtKlUI7q9C4rH4QLN4qcJIpoAMVfNu6ZQZN7Qc+aT0MkJBuXTKNSQzSz4MDNprnB
         7+ww==
X-Gm-Message-State: APjAAAVsw1fRXQfmBc7nTy9H/9FQeHx7+xWPRYZJwUGT2ItJsdpkcwl5
        jkaJVHjVCO8y8+WmDhpy4Zs=
X-Google-Smtp-Source: APXvYqwLL10GcMl7Fcuf/vn4IMxziXn63KE/AuAB5qltDqesTk5JI3CZDTV10ngqhGgm5+nKp6Z48g==
X-Received: by 2002:ac8:958:: with SMTP id z24mr372432qth.40.1578422875120;
        Tue, 07 Jan 2020 10:47:55 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:4018:daf7:6551:6995? ([2001:4898:a800:1010:f14d:daf7:6551:6995])
        by smtp.gmail.com with ESMTPSA id x6sm218347qkh.20.2020.01.07.10.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:47:54 -0800 (PST)
Subject: Re: [PATCH 1/3] graph: fix case that hit assert()
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
 <20200107153006.GA20591@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7a2e725-9866-61be-10ea-a21f16b88c2d@gmail.com>
Date:   Tue, 7 Jan 2020 13:47:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200107153006.GA20591@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2020 10:30 AM, Jeff King wrote:
> On Tue, Jan 07, 2020 at 02:55:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> A failure was reported in "git log --graph --all" with the new
>> graph-rendering logic. Create a test case that matches the
>> topology of that example and uses an explicit ref ordering instead
>> of the "--all" option. The test would fail with the following error:
>>
>> 	graph.c:1228: graph_output_collapsing_line: Assertion
>> 		      `graph->mapping[i - 3] == target' failed.
>>
>> The situation is a little complicated, so let's break it down.
> 
> First off, thanks for digging into this so promptly. Your solution looks
> correct to me. Everything else I'll mention here are nits. :)
> 
> Your commit message starts off talking about the test, but without
> describing what's interesting about it. I think the answer is that we
> have two "skewed" merge parents for the same merge; maybe it would make
> sense to lead with that. I.e.:
> 
>   Subject: graph: drop assert() for merge with two collapsing parents
> 
>   When "git log --graph" shows a merge commit that has two collapsing
>   lines, like:
> 
>     [your diagram]
> 
>   we trigger an assert():
> 
>     graph.c:1228: graph_output_collapsing_line: Assertion
>                   `graph->mapping[i - 3] == target' failed.
> 
>   ...and so on...

Good points.

>> The assert was introduced by eaf158f8 ("graph API: Use horizontal
>> lines for more compact graphs", 2009-04-21), which is quite old.
>> This assert is trying to say that when we complete a horizontal
>> line with a single slash, it is because we have reached our target.
> 
> Thanks for this final sentence; writing that out in English made the
> purpose of the assert() much clearer.
> 
> That could perhaps be an argument in favor of writing it as a BUG()
> with a similar human-readable explanation. I guess there was already a
> comment in the code, but it didn't quite click with me as much as what
> you wrote above.
> 
>> It is actually the _second_ collapsing line that hits this assert.
>> The reason we are in this code path is because we are collapsing
>> the first line, and it in that case we are hitting our target now
> 
> s/it//
> 
>> that the horizontal line is complete. However, the second line
>> cannot be a horizontal line, so it will collapse without horizontal
>> lines. In this case, it is inappropriate to assert that we have
>> reached our target, as we need to continue for another column
>> before reaching the target. Dropping the assert is safe here.
> 
> I think that makes sense. My big concern here is that the assert() was
> preventing us from looking out of bounds in the graph->mapping array,
> but I don't think that's the case here.
> 
> Worth mentioning that this was due to 0f0f389f12 (graph: tidy up display
> of left-skewed merges, 2019-10-15), in case somebody has to later dig
> deeper?

Can do.

>> Second, the horizontal lines in that first line drop their coloring.
>> This is due to a use of graph_line_addch() instead of
>> graph_line_write_column(). Using a ternary operator to pick the
>> character is nice for compact code, but we actually need a column
>> to provide the color.
> 
> It seems like this is a totally separate bug, and could be its own
> commit?
>
> I think it's also caused by 0f0f389f12, which actually introduced the
> seen_parent mechanism that you're correcting here.

You're right. These are better split. Any idea how to test the color?
(I'm pretty sure we have some tests for this... I can dig around.)
 
>> Helped-by: Jeff King <peff@peff.net>
>> Reported-by: Bradley Smith <brad@brad-smith.co.uk>
> 
> I don't know that I did much, but OK. :)
> 
> Thanks once again Bradley for the reproducible case.
> 
>> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
>> index 18709a723e..ddf6f6f5d3 100755
>> --- a/t/t4215-log-skewed-merges.sh
>> +++ b/t/t4215-log-skewed-merges.sh
>> @@ -240,4 +240,46 @@ test_expect_success 'log --graph with octopus merge with column joining its penu
>>  	EOF
>>  '
>>  
>> +test_expect_success 'log --graph with multiple tips' '
> 
> This nicely covers the assert() problem. Could we check the same case
> with "--color" and test_decode_color to check the coloring issue (see
> t4214 for some prior art)?

Thanks for pointing me to existing color tests. I'll add one to my v2.

-Stolee
