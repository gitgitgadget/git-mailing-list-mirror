Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD0C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLGPyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLGPyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:54:35 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F210FEF
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:54:34 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id n188so12008678iof.8
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wm+aHfETGcsjYKq+Cg55LGC1PvDrFb4SnBMDGk3JBRs=;
        b=KGspLhG6xR1EOg8ROQ3z+4QyOLONLhHUDykNdpq0F1ieQ/5ku5cjo5bXsMvw0p4qRP
         7zrc6sGeFV/eWq+KgrKg3B+MjLKfjonGoB5JfjzX4Ui1PFOqINE11tRP/5IZX37tonlo
         umzdVmOyw0BB9UFO28c0CNq39KwAhwfqE1fOpDPdPWnbef6Z/ILGtMlR9YPArvqtzssK
         wJ8r0yjrflNkLMz2wdosErRGH7mdflhtMK/rI+y5kwyuX+ZaiFmwQG7wBmwuVYM0nnvM
         Ow5jWg5Vy3MkiXCgVU4sYKam9nRIzGlir0RZvftVHiEV2nh7/aG1tNACiA7dJJOWW56t
         zRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm+aHfETGcsjYKq+Cg55LGC1PvDrFb4SnBMDGk3JBRs=;
        b=0IbDmmoTc6p5UrRef7ko2W9tKQ6ju1Selg2dG0Q7MiqsCh45HX0sFQMoGBqDANGdnV
         g9lwT/zfgacPPQpXOfK2MVEqmAXFjDAf8FZdq+ti5Pevr8vjXFVl5oxFEZFxXmol7iQu
         lT9fuyc20ir2TJ6ayNw+N7CWMukPGS07adTR3raUInO2MjDKl9jnbL112jsN0DnaK5tF
         OlJzBhMCmxbh3bjvWLxv1P4/SeWCjq0GGceIuWYsIPrRo7O3Q69M9TbK9A7WDMV1jVv5
         zESW6KUG6fGcu6Q9nJi0XGe5gfsSf83Y1tKKhohTYtimAFKswwxAaklhWMNqRbLflJKC
         MXDQ==
X-Gm-Message-State: ANoB5plcUAAepHSzbCsH2XKaFcFoVffZKux2IlJjDC/pYgWUH60L7s4f
        1c5lQF3aFydkCTpX1H//SdMD
X-Google-Smtp-Source: AA0mqf7AP0n8vF7Pu5Uu/LlwThgRxo45Viu8UjYyS6wUn5Mie09h0SZ2RTjABCwlCTqg7om+wTZzmA==
X-Received: by 2002:a6b:d314:0:b0:6bc:2a47:a874 with SMTP id s20-20020a6bd314000000b006bc2a47a874mr33847155iob.126.1670428474319;
        Wed, 07 Dec 2022 07:54:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:30a0:a841:72ac:2559? ([2600:1700:e72:80a0:30a0:a841:72ac:2559])
        by smtp.gmail.com with ESMTPSA id c1-20020a92c8c1000000b00302e09e0bb2sm7042084ilq.50.2022.12.07.07.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:54:33 -0800 (PST)
Message-ID: <4d4e02c3-89dc-8372-7e8a-7ec76fdd6f4e@github.com>
Date:   Wed, 7 Dec 2022 10:54:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 10/11] bundle-uri: download bundles from an advertised
 list
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
 <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
 <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
In-Reply-To: <affbc458-d4f5-525f-d431-5ec1d489afc8@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 10:27 AM, Derrick Stolee wrote:
> On 12/7/2022 7:57 AM, Jeff King wrote:

>> There are a couple other unused parameters in this series, too, but they
>> are all in virtual functions and must be kept. I'll add them to my list
>> of annotations.
> 
> Your UNUSED annotations exist in my tree, so I'll try my best to update
> them in the next version.

One of these showed an example where I should have been using
repo_config_...() instead of git_config_...(). Thanks!

-Stolee
