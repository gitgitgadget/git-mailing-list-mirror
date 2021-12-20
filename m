Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE9C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 13:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhLTNia (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 08:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhLTNi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 08:38:29 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B2C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:38:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v22so9684362qtx.8
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5snqJJTymDZUmb1Xz1NNJHPJ99uq7rjMb429YF6IG8Y=;
        b=Rxt6DoPm9dbiiP2GYZkj8u6TOSfbHZUaWqm7Ac8XBI1Q5oFNOeoysv/i0bkMSOk3bf
         NSriKxSOrNJ+3U6F44uDMnGfjPUKyypbj5YAYYwFk3bQcwlZ7NiIbv9404kvSAZm/QcD
         X700Zr4iYRWjNgIIcK4hAzIo1arxhz61DMI5GoKHYOXz5za217w0q+TVDZg4Gwa4/tpJ
         lSUCuAq8golc8pgewzNBtuvNRy8RyZiR0YVAFtnTfAU1eJTSSO5KYWo2TtEdoWHxqoKr
         cUuevrMwRWO6MQwqnpdvW5ZTkzDYaTB3mJTnvo/3iwtsaPsFvSKRrEizF/fBPi0c8+aW
         w15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5snqJJTymDZUmb1Xz1NNJHPJ99uq7rjMb429YF6IG8Y=;
        b=zlGoZd9w2CQvbeBZmb0ELdAQBNaCm59txtM4JhSR8o/Ts96P7CW2zlReXL3qiDM8cD
         OcdLGaqYSweuK03QcegT5HnTaYiSZwrd1vS6kMmAppZGuYy5GP2Jn5/MY7NdB3ViHDO3
         oSYM6O3Crad+/jdzJRH4X+On/dxWdzL2pZPDCp9YjHnGeCgZ5KSIOWQeeeCxy8mdIs7I
         8LFJmQkteI+WZqGA1Y+UwrgaqsVGHbp3VJtagj26YFz+HJkF3wnFbXlcPWRkbNQfYRd4
         ofucdCgB1pYOG46MpClP6ZrlfOQMEQzcO4J7lMMmZEiYP6IVYY/xwXX/siTftVqHmalG
         fEKQ==
X-Gm-Message-State: AOAM5322K19rrO5FHz03IPh+LhQxtIiZfJi7Wia8s1NEumaKi9MJog8Y
        LSPnELnnjV1qQfGOU2A+zMkPl6zswL0=
X-Google-Smtp-Source: ABdhPJw0pYWer/dmcn3+QTeI/NAvBJ6PgQNiWMlN0esdw1DdbirGcoCooacEv6EXKeREJUPOCtPr7Q==
X-Received: by 2002:ac8:5e12:: with SMTP id h18mr12316993qtx.143.1640007508676;
        Mon, 20 Dec 2021 05:38:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id g5sm11803197qko.12.2021.12.20.05.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:38:28 -0800 (PST)
Message-ID: <27588da0-b47b-1cd3-8485-e9b8a4131e38@gmail.com>
Date:   Mon, 20 Dec 2021 08:38:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] repack: make '--quiet' disable progress
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
 <211218.861r2axmk3.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211218.861r2axmk3.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18/2021 4:55 AM, Ævar Arnfjörð Bjarmason wrote:
> This seems like a good change, but the documentation could really use an
> update (also before this change). It just says about -q:
> 
>     Pass the -q option to git pack-objects. See git-pack-objects(1).
> 
> But do various things in "git-repack" itself differently if it's
> supplied.

Good point. I will update the docs.

Thanks,
-Stolee
