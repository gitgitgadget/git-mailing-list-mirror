Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BA5EB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 12:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHIMRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMRk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 08:17:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E95FDF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 05:17:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583d702129cso72616617b3.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691583458; x=1692188258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+PC2z0Bkm76im1f2gxnNu5tqX71PPNc3CjNUmzyvyU=;
        b=OF7TgDsLIlnlFTyaU1X65hoBa+Q0gBJVb5HRsXy/HzliEfyBmlfSbRtP4i0rfPzvjl
         nTN4Tv+WAbdyaZf4/cKkq4n6GO3xF6Sr7D7A9uO9pose9xyYfNtwvc8AymmiFDhF/DZ7
         x6VyGGIK8phMkl/M5rP4Teh5Gh/fLyiA0zq/XcTSkiVBRfFplP5PGbV/PDB5GZIID7ur
         YtVVZ856pNRhqIXB4TQ9ki7gTNZ/JjP7BnAGzxzNSN0+vJfjIRvZadiqcnIdH1uWHJeW
         TJFzrsiuO2JjG2hFT34qZ5Bktu4fiDhrQC69pR8lZeTaucaENatabvwmbR2ew1/M7tt6
         au1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691583458; x=1692188258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+PC2z0Bkm76im1f2gxnNu5tqX71PPNc3CjNUmzyvyU=;
        b=c/G578K9Le9ASKrC8up3r2WGwC4+wHv9llqLsDbOw2PyX6FWr23m/7yoGX8UhaJjO6
         IyWONDzyW9nriOEZVO2+fBzHX/ZJF5iEw1ax1qxILRED8JZD1u2qVGCIdH72MvVXm68T
         vWtxHwdYsQkgg3d6gLe1fbPdmsGNzR6KJvWp3Z5HOzir5iAkPrpDkSbRgbS7gekiJO3X
         EuqHarbJVTfXfdgSHcMd+6pgTyrTWjjSznU/zWFy8uiyw5IVysq8y+8PCSskcrEIEctE
         q50iH2JoIH3vAf961ueGHF+p0YJIM+sT98cELgGYKaX+YNiTjNLuAjA/e66BHnWBAXQI
         FgJQ==
X-Gm-Message-State: AOJu0Yw9iERNzAMkXd/6uYclwpIl6BEH0IwWIgggOgFewMEIXwlWqplQ
        m4b3PbMQL3ZpFd/3vBtBDC04
X-Google-Smtp-Source: AGHT+IEfhCvGNhBJcbXsL1w6U4wDevz5tJQkfToocNZT7ULaBZaHbHyTXrPTSMsnDAYXWYfLLoNEhw==
X-Received: by 2002:a81:9481:0:b0:586:ddc:eabf with SMTP id l123-20020a819481000000b005860ddceabfmr3038550ywg.37.1691583458590;
        Wed, 09 Aug 2023 05:17:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b106:e8c9:2e06:a80e? ([2600:1700:e72:80a0:b106:e8c9:2e06:a80e])
        by smtp.gmail.com with ESMTPSA id l2-20020a0de202000000b00583d1fa1fccsm3947550ywe.0.2023.08.09.05.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:17:38 -0700 (PDT)
Message-ID: <a1e7d730-e220-48ec-8393-2d3538b80163@github.com>
Date:   Wed, 9 Aug 2023 08:17:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
 <ZNFgIyuhlNd8I9Y2@nand.local>
 <8854e369-fabb-4044-a06c-eaf5b9fbde4a@github.com>
 <ZNKfxOWJAuJ5DxAN@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZNKfxOWJAuJ5DxAN@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2023 4:04 PM, Taylor Blau wrote:
> On Tue, Aug 08, 2023 at 01:28:50PM -0400, Derrick Stolee wrote:

>> I see you're moving ahead with removing the srand() from the lockfile code,
 
> That thread may have progressed a little since you last looked at it.

I think this part of my summary is still correct.

>> so I'll focus on creating a `git_rand()` that centralizes the use of
>> srand(), but won't touch the code in the lockfile so your patch applies
>> independently.
 
> Instead of using srand() and rand() (which would make sense to wrap with
> git_rand() as you propose), we can simplify our lives by using a CSPRNG,
> which only gets initialized once, as is already the case with
> csprng_bytes().

So the idea is to use csprng_bytes() everywhere instead of srand()/rand().

I can adjust my local patch to still create git_rand(), but base it on
csprng_bytes() and not collide with your patch. Mimicking rand()'s behavior
is a simpler interface to consume.

Thanks,
-Stolee
