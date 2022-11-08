Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF0AC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiKHOtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiKHOt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:49:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB08FB04
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:49:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so1010417wmi.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpLh0BhXneSeF+LEL71PQzfvlU4/UyX5anJeCZ2c1I8=;
        b=VuvHUhUlnXYPhOkgqYRVutgIym/83RV/ZBymcSCTY9HRHwO804NwGfFI0ebRGYKpbf
         MYK308h3KO7PjSMURyVJckUuCekw37gO0uJgN6JuQq/L5RXRMZodFRm3XQz0z2t6WxUA
         +Xr+2+Jb4JcyrRfgGmGt4HNWNvc3vKNYH+5WcH6Cg2+ykmlKNuexJi8GkzHJ1othJfX3
         IVKH97BCHQU0k5W3GScgQO2MuRRIo4zcN2XrclCHvP3+UTZipOIzKhhQANljavdg/0z7
         5s9d/PCyVgMDjmdyDnTdQFiaHQhtJPtguo22IuvUkg76FRgxaa1OTz0fa9tvug0o+0sV
         CBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpLh0BhXneSeF+LEL71PQzfvlU4/UyX5anJeCZ2c1I8=;
        b=APqNiO1A5+BYIYcgMo3mN7XIk40XXipw4IDDMJ7iLKw3xicbI3VsOsfw66cw+5plWZ
         sMblvLbz8hZ4gq383OhaTlK9SSPyuDm2T0uPwwi5Fz0MqI6vLQpNrFWe4n0S53mI15YZ
         2n78mf/yHL38L3kA6OES3oGejUzZ8H005qUVvOMzzjGkFXXV1D95gv4gCVH0Vmd+dG6s
         8YiuMF6QwVsT9ZJBk4VN0S71OIdkivZ8qKtne8wPBUbwRjnoR17R4z5Q7HzriEPnO+uu
         50ELlUi7yDkx7tktHaVWho1shOXZt3utG4WceR8PUGCvJKFxsKe6+ZIERYemXMFMDajE
         MiqA==
X-Gm-Message-State: ACrzQf2KrhjugjlrTjCZh96FNpOexgkKfKETNs5ymSJvz+QLcheu9ZMp
        Pez+XzCnZoKNwyE7TSS5QbbQQtdrpj0=
X-Google-Smtp-Source: AMsMyM7ERFwMGJZBU7xbC2rbzFi6MpY7uW9sbY/98+SfGsZT75JDLJCIqyweNql678bp5JTRWlHfKw==
X-Received: by 2002:a05:600c:414b:b0:3cf:94a5:6564 with SMTP id h11-20020a05600c414b00b003cf94a56564mr16810245wmm.65.1667918966294;
        Tue, 08 Nov 2022 06:49:26 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe590000000b002365cd93d05sm10383867wrm.102.2022.11.08.06.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 06:49:25 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <64b91b29-bbcd-e946-1f20-c0a5be63d9b7@dunelm.org.uk>
Date:   Tue, 8 Nov 2022 14:49:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ab/cmake-nix-and-ci (was: What's cooking in git.git (Nov 2022,
 #01; Thu, 3))
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <Y2RldUHTwNzmez73@nand.local>
 <221108.86cz9xsf1w.gmgdl@evledraar.gmail.com>
In-Reply-To: <221108.86cz9xsf1w.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/11/2022 14:14, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Nov 03 2022, Taylor Blau wrote:
> 
>> * ab/cmake-nix-and-ci (2022-11-02) 12 commits
>>   - CI: add a "linux-cmake-test" to run cmake & ctest on linux
>>   - cmake: copy over git-p4.py for t983[56] perforce test
>>   - cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>>   - Makefile + cmake: use environment, not GIT-BUILD-DIR
>>   - test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>>   - cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>>   - cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>>   - cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>>   - cmake: don't copy chainlint.pl to build directory
>>   - cmake: update instructions for portable CMakeLists.txt
>>   - cmake: don't "mkdir -p" and "cd" in build instructions
>>   - cmake: increase test timeout on Windows only
>>
>>   Fix assorted issues with CTest on *nix machines.
>>
>>   Waiting for review.
>>   source: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
> 
> I think the v4[1] you've since picked up should be ready, and I think
> addressed the outstanding comments, except as noted in "let's pursue
> that separately" in [2].

I think we need to wait for someone with windows experience to look at 
this as that is the primary use of the cmake build. Without that I think 
  patches 4(?), 5 and 7 are still could go forward as a separate series 
but the rest of the patches including the documentation and test changes 
need to have buy-in from their primary audience.

Best Wishes

Phillip


> 1. https://lore.kernel.org/git/cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/221103.86a6581129.gmgdl@evledraar.gmail.com/
