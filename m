Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA81C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B8220E65
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 18:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxy+MuAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgJESRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgJESRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 14:17:17 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72184C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 11:17:17 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u17so3449502oie.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3l1hrUlYrSF44OnQbzg+BFShzI/AiQdn4T/C8wMLfIE=;
        b=hxy+MuAcFRQbO6kuEc7+XMZTKiO28nzs5BYAR0sur4P2WgOp1QdUsgM7Gn/mXmHPrH
         0xiW3gG1V0diJABawsYbMd1v2ziNOV5n1qaTYFenIAQq1cekpGDMod327DuIX42OvmI4
         TJfkCM8NHM8WkjJu3NnoEmtEuPbJYWum2HdOSa8FOz64CPdKmdPX+poaVJgjiVGDR91l
         8f/sLQmWocSEqC+h9TDl9LF1eRQDqjtIgoO/M5RNRwcrkJyMueXu3bNJEPOgW4dIJQB+
         rd9A8Y0cGEQYO+Uw2qSAA8ofIykocAfXrdstaI5/xprRUK2nzpK6VHgj6ItTqN4ax2YN
         hqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3l1hrUlYrSF44OnQbzg+BFShzI/AiQdn4T/C8wMLfIE=;
        b=TtNKjWHhTDnpJAl9zg5vZZOEJA4lYcYxpmL7xNgQ73VlAbF0JrdxRvTJey3TkhKmqM
         a4BiROKWwzSHqPhft4c9SH8UxqMoj113pNEvh6HZGfwHOXu0o+c6GyBgYzGSWCag9m07
         wU2jEQyJ+qKypcAuS9Jo6tmSehFRZkomx8IfsZSFJH+7bGyW0YISJMp3quLRb2xcJ/8x
         0bOglD5LJ+55vDTuQ9ercxqW8oil/ue1Flk4Q4DDvDs/gxAQlEJbIWChiy7GD+z9up9Q
         Ntg8eNade1WIUiPOH+H24EWYu3j2YEowsSvotCOwiHEa2ovJ7kuCDHC2ZECQZPTimlTH
         9Ylg==
X-Gm-Message-State: AOAM531dFqfbBQrPDGmWJkvTUv4xnR18HVwF8NS7/lluJkC9Rigz7b+Y
        4pKqeZtAIt9HK5L85tX0J0eL+vdXmJFo+A==
X-Google-Smtp-Source: ABdhPJwFeWTu0NL7kb+n6tAw4duZUYJdpcZyzxjW2mZ237yg6qcx+zqznxfv4znrp2IjkYCYHVSS8g==
X-Received: by 2002:aca:3907:: with SMTP id g7mr363615oia.37.1601921836711;
        Mon, 05 Oct 2020 11:17:16 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:105d:cea9:560c:9755? ([2600:1700:e72:80a0:105d:cea9:560c:9755])
        by smtp.gmail.com with UTF8SMTPSA id c61sm129100otb.38.2020.10.05.11.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 11:17:15 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in
 register/start
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
 <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
 <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
 <3e18199a-1dcb-057d-4753-03d5acfcc036@gmail.com>
 <20201002003844.GA28643@danh.dev>
 <2198ba04-e73a-cfd5-960c-909a4f3ef0d2@gmail.com>
 <20201005131647.GA20195@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a47fafec-345f-f675-18d1-98cefc455ecb@gmail.com>
Date:   Mon, 5 Oct 2020 14:17:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201005131647.GA20195@danh.dev>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2020 9:16 AM, Đoàn Trần Công Danh wrote:
> On 2020-10-01 21:55:40-0400, Derrick Stolee <stolee@gmail.com> wrote:
>> On 10/1/2020 8:38 PM, Đoàn Trần Công Danh wrote:
>>> I don't mind about using a default schedule (but someone else might).
>>> I think some distributions will be paranoia with this change and shiped
>>> with disable by default in system config.
>>
>> If a user wants to prevent this schedule, then they can simply change
>> any one of the `.schedule` or `.enabled` configs in their --global config
>> and these defaults will not be used.
>>
>> Of course, perhaps you are missing the fact that "git maintenance run
>> --schedule=<frequency>" is only run as a cron job if a user chose to
>> start background maintenance using "git maintenance start" (or "git
>> maintenance register" after running the 'start' subcommand in another
>> repo). So this is _not_ starting by default without some amount of
>> choosing to opt in.
> 
> Yes, I missed that fact. Sorry for the noise I generated.

Thanks for confirming. And thank you for the interest in the
feature! It's my fault for not including the context properly.

Thanks,
-Stolee
