Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF01C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 14:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354222AbiDOOD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 10:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbiDOOD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 10:03:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4628DB714B
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 07:00:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so10752253wrr.9
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B2lhbzRa0RyMT4X1PHspHqsvNT0zqgEoOPskZJggGZ0=;
        b=gQ3I1TZYbn8bZ0sj2VEqg5ZUEDsCFYg7/Zg6FulEpOXzwvYVizEsw5WeWkUrIjmj2b
         7M1/OYBLWWlLHtOXANv0Kq+mPptCVV7KpcmsTAA9wRGXYdjD8epV3cVmVf8pJUhKJXzq
         Wrj6GZ1jJlAK3JgaMqtm7n4I1B+ZljOnf3TTxbduhdtdOe9AsWrPPN60bysIaYZdCzyG
         ehhAnloBelUcOkkdIHEVyzItyaiSntsGILDGyiDiChWDFhvaSh3Y7VFioivqZv6mBglr
         qPcsaIG5+voyIjKfxOUZBg1j7NG18NWYGaDhILK8TZSDBR76XMUuIJCIuXpv2mko3FSs
         1uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B2lhbzRa0RyMT4X1PHspHqsvNT0zqgEoOPskZJggGZ0=;
        b=Zchexl0ulYr9ICYfBA4usauH4t8ZbcnFuzfGtbOQXC7GiN95wpEGEreywHCxHqxAGt
         2cUC7roHP6vjzUWZFKJnNW8SdcQpSvCMI1LKXsmbmCkBZ75PgUGvQymTiDfd68yxNaZE
         mzL7C92I/85Sjlhia6wFKTOJvOMp5Doqix/pZcOaeNvquIlCofs0Z5gdz0SHyr+knfiS
         +Z5WnZqKhxeR8VwGC1xqs8rHnoSfQv8XI/pe/1QaAK24xFn3kX2Vd2EmtlX8bCyBVmoT
         hVXkVQr68hHnA0Gex5tqz1igaHHeeTySD61ABMHSzDf8TAjcFJ+ve6EvA97/XB6JhcBm
         9jCA==
X-Gm-Message-State: AOAM532zpLgBV+yKOTlHXe87YeJ1tDAXgtXcYJbuqN78SrA02h7am6oD
        h2c9GSabvdWwLcMQOwrOCRDVHIJ3Ri0=
X-Google-Smtp-Source: ABdhPJxbLQ8vYAGSTHJw1QHS3y6+ZYzpYN8S4HpZo2J8VcC4G+GX5fgIDj81+RKr4f8M4iWpIEs/ng==
X-Received: by 2002:adf:f00d:0:b0:207:a6a6:a0c9 with SMTP id j13-20020adff00d000000b00207a6a6a0c9mr5424919wro.459.1650031256713;
        Fri, 15 Apr 2022 07:00:56 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id u5-20020adfed45000000b00207a480e6aasm4250131wro.116.2022.04.15.07.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 07:00:56 -0700 (PDT)
Message-ID: <cde32b70-2f01-925c-2456-8f45fa8c5188@gmail.com>
Date:   Fri, 15 Apr 2022 15:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/7] rebase --merge: fix reflog when continuing
Content-Language: en-GB-large
To:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
 <493254ffbb8b11f325f5995790341d70198b5c97.1645441854.git.gitgitgadget@gmail.com>
 <CAP8UFD0+V38FC8HZenFVRUputH+eD5cfXAQUZug3RWWMv==LBw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAP8UFD0+V38FC8HZenFVRUputH+eD5cfXAQUZug3RWWMv==LBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chirstian

Thanks for taking a look at this series

On 07/04/2022 14:49, Christian Couder wrote:
> On Tue, Feb 22, 2022 at 6:12 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The reflog message for a conflict resolution committed by "rebase
>> --continue" looks like
>>
>>          rebase (continue): commit subject line
>>
>> Unfortunately the reflog message each subsequent pick look like
>>
>>          rebase (continue) (pick): commit subject line
>>
>> Fix this by setting the reflog message for "rebase --continue" in
>> sequencer_continue() so it does not affect subsequent commits. This
>> introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
>> in pick_commits(). Both of these will be fixed in a future series that
>> stops the sequencer calling setenv().
> 
> Yeah, it looks like we will leak only a small string.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/rebase.c          |   2 -
>>   sequencer.c               |   5 ++
>>   t/t3406-rebase-message.sh | 120 +++++++++++++++++++++++++-------------
> 
> The changes to the test script look a bit involved and aren't
> explained in the commit message. I wonder if some of those changes
> could have been made in a preparatory commit.

That's a good point. For some reason when I put the series together I 
thought it would be tricky to do that without the fixes in this commit 
but that is not actually the case so I'll split the test changes out.

Best Wishes

Phillip

> 
>>   3 files changed, 86 insertions(+), 41 deletions(-)
