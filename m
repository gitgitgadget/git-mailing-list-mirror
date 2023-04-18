Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609BEC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjDRO5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjDRO52 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:57:28 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED666CC3B
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:57:16 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fb615ac3dso248157307b3.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681829836; x=1684421836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrtqyIiodZMndcrO8cO7cby6t9s5QX/+2KjxjdolzQ4=;
        b=eButQnv1lH1qXQi8i21JprCU3GxxYlqZeHuh88ufFesj2tcH23LrO+DXjLC8zzCAGZ
         /0h+cU6HwcuixhPv8brfAHTjD6SDuDGzoZB603QgHerPVU8KNblZ2D4N1nKhx68TNNmA
         a/yJiYB6eZm2ZIJli/zCyLcaOY2mOkNuNO29iIJf8UHFsznw9EP35syhvVXu8LeCpOxv
         l2RREUSAwpKqte1To5uWTPgGYYCyCd4Hs2/QjoHwxXVKkIoBMp0u1tvN4uyr4K5UIYYn
         ICKrRBh6sOwZ2edolpduguIkZtYeb2JnrlfTl3FqkgK8lGREoLVKCTY7LaBz73Qzrjn2
         5lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829836; x=1684421836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrtqyIiodZMndcrO8cO7cby6t9s5QX/+2KjxjdolzQ4=;
        b=dENZevUx+CQWmVH7EHZeMSr6NENezuD7OHYP+wDxhxSXNM+M5RZQKFSXVvxyCyxBxc
         45HZcm85Qu88HX/ppRiS3FXuesEs2ery0meGKG2tbZoMn1Bf1wwpCj5n9Wq9Q60lfeIg
         qKdkCJXtGwT53Q8Yogt3A35pUUhlRHiBf7n284VKVFGt6oDGBD9l3i8Yp0c1JCICtPvg
         zyuo6DO3CS7DZm+q47nDMZn8q/00ppu5+1WZ034zFDP227xec2W8FS8VSRoiU0o9Ve4f
         phHo7+ZWR7z4EefiIoCTeR/i6kwXG7S5wtjibZQQpG8W2l0dNnaMUflI8c4ApReHnCJG
         G0/A==
X-Gm-Message-State: AAQBX9dT393F9CDZJtSFAPYluRJi/dBh/mMfvml5qdVcX0/lKR/xst9n
        3JUwrgf1cpRmVwJOSp7MY3IAWSczJxlJUt+GUA==
X-Google-Smtp-Source: AKy350YxRy3C5T9DhHXeMiclVEsSaSR4r+/T3+jYM6wxZDBXLhBtg/p9b2OGnK2qggAiIY4XGc5reg==
X-Received: by 2002:a81:6507:0:b0:54f:b974:e444 with SMTP id z7-20020a816507000000b0054fb974e444mr165465ywb.3.1681829835998;
        Tue, 18 Apr 2023 07:57:15 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l31-20020a81ad5f000000b00545a0818483sm3881235ywk.19.2023.04.18.07.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:57:15 -0700 (PDT)
Message-ID: <fe72e184-a252-dab4-e9aa-cf53e1499976@github.com>
Date:   Tue, 18 Apr 2023 10:57:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] fsck: check rev-index checksums
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
 <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
 <ZD3HI/LIXVv6Pacn@nand.local>
 <2628249e-fe9a-d15c-5414-33d815b35cd1@github.com>
 <ZD6ua4dSynRWmW2a@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZD6ua4dSynRWmW2a@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2023 10:51 AM, Taylor Blau wrote:
> On Tue, Apr 18, 2023 at 10:27:57AM -0400, Derrick Stolee wrote:
>>>> +test_expect_success 'fsck catches invalid checksum' '
>>>> +	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&
>>>
>>> Would this test be tighter if we introduced a sub-shell and cd'd into
>>> "corrupt" here?
>>
>> corrupt_rev_and_verify does the subshell thing. Why should we do that
>> here in the test?
> 
> I was thinking that it might be more concise if you moved the subshell
> to the test and out of corrupt_rev_and_verify. In addition to making
> corrupt_rev_and_verify work in other instances where the repository
> isn't required to be in a directory named "corrupt", I think it
> simplifies the result.

I don't think there is a good reason to allow using a different repo
name. This is the only test that requires doing anything but calling
corrupt_rev_and_verify with different parameters, so I think this
makes the test script at the end of the series noisier.

Thanks,
-Stolee
