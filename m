Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FACC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiB1Spl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbiB1SpR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:45:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585B9DF3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:44:04 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso10230797oti.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FvPNDWb414tGa1OYuy1sINnk37ovIyFR3bPx5BKswdI=;
        b=Yqy5dLZNwSBg5t5MFBT+dYH41uHLHuingyrWHPwVzFi3S8DoMJf5UFPrwc2qx6LbFU
         Pz2rHttXT7teOdy5H47vx1/ke2i9TYrEoIRNcoy5BBkZM/pvAdGbA73Q7H37Pn89E2S4
         n+PLzbNVrcKFTdUXUXe/zsidxSZSlCOEOFvOpL+kUydvVUKDblFsiR56GcsTmGjJOOcU
         rLYNzBDyCC8u6SUd413mDIfSAi4v0GuhsSnJkHr2zCO1furUTYOLVK7lRAB5IlhSKe/i
         QvFwZqCWQtNepnuVRAml0leKqvd4fmW+35mPSeZsl9g1ushiaFLyi68qXDi7DNigGoSY
         Rl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FvPNDWb414tGa1OYuy1sINnk37ovIyFR3bPx5BKswdI=;
        b=brP9tiYoZqHGh/k3Ay2zmVLU3t7q4IWERE+bouG6EydGaogN44dZK4fvchdjCoLv7l
         Oi+SqYPmtkBwnXyhErMWuyiMlkNHr4/bt/g0wc8NQe6yC22qtI6JArIPqX4yyQYhEIvh
         pfCQofAO6iKj4E8MqRujYd53oOES6S7Qqa1LoEQqnxJEZ+yQ2+1Kl9w3k9uVZ3BT77V1
         BkluFT8NIczR8wDoNqmqJfNF5w2jYL81P7fq8KPe8JZv6wgofw8iU5iVEB0DZNIusNCI
         bDrjKEMgndGt7eD7tDit29ICyPgCnd4nvHjppuNAXiwodVBWTVBr8jagFRClgUfoNl+9
         gCeA==
X-Gm-Message-State: AOAM530z1Uj/OcWL4wf0e22pA/dtlzD3nSAHhbGQZENTcrTf/0LUgxr5
        8dCfnpo4jlRwtebZU1FVCB2S
X-Google-Smtp-Source: ABdhPJyHb9aKbTQ7uSnkmFkwQp/sDWsQ9o2OMtc+jbHHSzL0maFfofjRQmY+Q8M1OQ/1SiTOMRxDiA==
X-Received: by 2002:a05:6830:3110:b0:5af:faf7:6b10 with SMTP id b16-20020a056830311000b005affaf76b10mr5367567ots.221.1646073843660;
        Mon, 28 Feb 2022 10:44:03 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm5154696oao.3.2022.02.28.10.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:44:03 -0800 (PST)
Message-ID: <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
Date:   Mon, 28 Feb 2022 13:44:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase> <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yhz/hsDDGNVjt64R@xps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
> On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
>> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
>>> I haven't yet found the time to dig deeper into why this is happening.
>>> While the repository is publicly accessible at [1], unfortunately the
>>> bug seems to be triggered by a commit that's only kept alive by an
>>> internal reference.
>>>
>>> Patrick
>>>
>>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
>>
>> Thanks for including this information. Just to be clear: did you
>> include patch 4 in your tests, or not? Patch 4 includes a fix
>> related to overflow values, so it would be helpful to know if you
>> found a _different_ bug or if it is the same one.
>>
>> Thanks,
>> -Stolee
> 
> I initially only applied the first three patches, but after having hit
> the fatal error I also applied the rest of this series to have a look at
> whether it is indeed fixed already by one of your later patches. The
> error remains the same though.

Thanks for this extra context. Is this a commit-graph that you wrote
with the first three patches and then you get an error when reading it?

Do you get the same error when deleting that file and rewriting it with
all patches included?

Thanks,
-Stolee
