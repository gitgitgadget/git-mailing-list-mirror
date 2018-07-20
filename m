Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9901F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbeGTT6x (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:58:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34808 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbeGTT6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:58:53 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so6821985qkj.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=54S6Gyr+nhe+/DbaF62F5os5HbkLLq8yT/+3GoQSsXU=;
        b=EEYVHGrgdqQ784YuX8nUE52qEAktb7QIPp8rukF08ntJ6VLiKBVQlEJvyV5eJmfmME
         bOK7uoCG8JCH1KD9XU47EuwHvviJ9gYc+4Ij2+myFIKLA0nUm0eU3WTV4ynA1lA1cLws
         VwGtY5lNQs6cMM5xNbmX80fc6fQbAj75fOpY5V8qky+8NVVIUH7ZuM6K89QzqTKIWm59
         1e585f+PAPZVR4y6jZPjOOhLwNQ7i8eVuNbnX2P233CjZsQx2vvO7ffFIjR5q0jK1R2V
         BJpSSSA/+sFFwUbz/YxtM9btBhjaIMTeG2EUpnjIbzvDdkSYdAnVLZfH3ucyoq47zeaT
         tbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=54S6Gyr+nhe+/DbaF62F5os5HbkLLq8yT/+3GoQSsXU=;
        b=eoZxSR1G939ajeFd//t9AkTJtuSmD+rQw7+NRlgX9QZEMAVYlRozfzUhRCVvdQ0Yjy
         9YrvKLMkxpM4vsjws/fM8E+8dEXw/SoN9/TpUYnn89GfU7Kus0UqkpiEvifJme989VT6
         PxmegrL1wDonUH0so2eplf9qHkiU24x5YfQjIIjlGz6BfCHeqTq2jzZF8B3X34PfR2Wz
         VHw4hKEt6ZXHCQ466h9UCyRTn6xcCAvfNTj3tP6ibL8Ud9syRemXmcsyjQ6fxNQayFXr
         qH5XpzpZFMf+VJyl0HDIrvDOS6p4/hWZ2DsmLvFbfpTpYLz9csKY+gc0h75GRxvT/zLY
         CrJA==
X-Gm-Message-State: AOUpUlG0Flptz2BWzvgJvYgWRCD5ISJI8DCFw/cvMINy83H/szy8hEZl
        6DrR6BM9YkGS4KlSR8e66Y8=
X-Google-Smtp-Source: AAOMgpenJJQpTuJmcP7l5pDXs43bC6+uo/aGjBkK7epn4XGzVcXH0OQROdy/wKqgeD8AY4D4tWZfJA==
X-Received: by 2002:a37:a0c1:: with SMTP id j184-v6mr2974966qke.126.1532113756901;
        Fri, 20 Jul 2018 12:09:16 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t11-v6sm2094002qkt.28.2018.07.20.12.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 12:09:16 -0700 (PDT)
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <CACsJy8CTPtxLsSoNO8xynHGoPqQ3k6N4mSykWTQ9Ceap3yV1hw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <215c6ad7-a403-9173-5965-70f68e796d7a@gmail.com>
Date:   Fri, 20 Jul 2018 15:09:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CTPtxLsSoNO8xynHGoPqQ3k6N4mSykWTQ9Ceap3yV1hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2018 1:41 PM, Duy Nguyen wrote:
> On Fri, Jul 20, 2018 at 6:35 PM Derrick Stolee <dstolee@microsoft.com> wrote:
>> There are many places in Git that use a commit walk to determine
>> reachability between commits and/or refs. A lot of this logic is
>> duplicated.
>>
>> I wanted to achieve the following:
>>
>> Consolidate several different commit walks into one file
> I'm surprised get_shallow_commits() in shallow.c didn't make the cut.
> It's no problem though if you already considered it and decided it was
> better left alone.

Thanks for pointing this out. I didn't know about it. It would make an 
excellent follow-up series.

>> Reduce duplicate reachability logic
>> Increase testability (correctness and performance)
>> Improve performance of reachability queries
> What's your recommendation on adding new commit reachability code? I
> might have to add one to fix prune_shallow() if I don't find anything
> fit. I guess the code should go to commit-reach.c too?

In my opinion, new commit walks should go into commit-reach.c. Then, you 
can justify why you are using a "new" walk instead of using an existing 
walk. Further, you can probably think of the walk in more generic terms 
than the specific application you need. Finally, you can use the 
'test-tool reach <method>' pattern to test the specific walk you create 
outside of the logic for which you needed it.

I understand that while this patch is under review, you will probably 
want to continue adding your walk where it is, then we can consolidate 
the code after both have settled.

Thanks,

-Stolee

