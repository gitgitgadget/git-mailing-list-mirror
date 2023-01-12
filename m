Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF4BC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbjALPcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjALPbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:31:55 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303B5587F
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:23:57 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v19so13174134ybv.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybg5lUZPxxRyzG4OFNLUcwFk+oPCBtN+Af0ni12od5o=;
        b=TTQwp4UWgVwY6ycnghWSMRSpE0tVgK3TD58t0KjvxjOv99JhwdS2A3MDFSHsb3IKhY
         JPmiqdgFIFlGkTvB7yib8fQbTEs9peim3B8xARsrssC2xWA+SY35pQBitsPnAUH585dT
         V9IBNPrSMfqAP3h8zMV9Cp2tkwKT3IKgPrnintnFqCCYHB/P/kE3EcM9RuGfc40FlnTX
         IZjOE7+JhYdhs9++CBAxZ7fUaB/Aq2dd9D0cWYzELduEiDNueJUtTzBeenDS6xmpPO0o
         KcaxkDoGmHi2TxQYZm3V5eZioPDiP/LLLvPwh6O1oWRaPk4paAmWwNAw7kGK6a3BuenY
         flGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybg5lUZPxxRyzG4OFNLUcwFk+oPCBtN+Af0ni12od5o=;
        b=gQmKLHpms4aAxTpt2h24mVC5ui5vELR93/HqEUaD0zajr97vP6KFvd9a2Gf2a0qc+l
         PX/8zikLh+jYVC/IkLjftebCwDpoiKjPNQcYtG6VTlyS7vglI991BgfkMEeFFYlAe+Wd
         4xYWX3M0U4/Z844fQ8Xn8RZkBMVulhZq2OTSgYWFB6V+Ib/0MiStIsN2MWMR7D+cRATK
         fIRLZT0VoT4lrflVu0hrtQOmhrwAiwQ9qg8/uPj+lnS+QdSsxmaq69E4ojBOlDbqmRFd
         sOrCraoiSrPqyDiXMdRkp5CXuiS2EI7wyJPhsUahpK+cQX3ToTZ4cH61YOgU2gIBAt6O
         MnIQ==
X-Gm-Message-State: AFqh2kq+UHDZyMJaxubojeJK2LCcAqShNNUH2lIT0UeEKsjjzfj2GYBT
        FSBM8Aht7S3f2RKhQAb8sXyPNSYqVJlthq0=
X-Google-Smtp-Source: AMrXdXuHYcRQvziYirrIMnums9dxm9udoaPVtQ5CYQbz0Th/DvIjY3yKfRzBg1a10pv3naBGPPeQJg==
X-Received: by 2002:a25:8811:0:b0:712:b4e4:f6d6 with SMTP id c17-20020a258811000000b00712b4e4f6d6mr64301409ybl.14.1673537036875;
        Thu, 12 Jan 2023 07:23:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:58df:ae78:2cd7:f615? ([2600:1700:e72:80a0:58df:ae78:2cd7:f615])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b007055dce4cecsm11159790qkn.97.2023.01.12.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:23:56 -0800 (PST)
Message-ID: <26708e4a-93bf-5dec-2b3e-da8f4ce37571@github.com>
Date:   Thu, 12 Jan 2023 10:23:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] cache API: always have a "istate->repo"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/12/2023 7:55 AM, Ævar Arnfjörð Bjarmason wrote:

>  * Derrick suggested in
>    https://lore.kernel.org/git/6b92fad2-6b74-fddb-679c-8c8735e7103d@github.com/
>    that things might be nicer if we had an explicit initializer, which
>    was also the subject of the previous discussion at
>    https://lore.kernel.org/git/xmqqmt6vqo2w.fsf@gitster.g/; but
>    concluded that it was probably best to leave it for now.
> 
>    I tried it out, and I think it's worth just doing that now, which
>    is why there's a new 5/6 here: We start by adding an
>    INDEX_STATE_INIT macro, and corresponding function.
> 
>    There's a bit of churn in 6/6 as all of those now will take a
>    "repo" argument, but I think the end result is worth it, because
>    even if "repo" remains the only thing that we need to initialize
>    we're now able to use ALLOC_ARRAY() instead of CALLOC_ARRAY().
> 
>    We'll thus be helped by analysis tools (which would show access to
>    un-init'd memory) if we miss properly init-ing not just the "repo"
>    field, but anything in the structure, so our test coverage will be
>    better.
> 
>    It also makes the code easier to follow and change, as it's now
>    more obvious where we initialize this, and it'll be easier to
>    change it in the future if e.g. we add a new member that has
>    mandatory initialization (e.g. a "struct strbuf").

I wasn't expecting the initializer idea to work as well as it has.
Now, Patch 5 does all the heavy lifting and Patch 6 is an easy read.

Outside of one question about the istate->initialized member (which
might not need any change) I'm happy with this version.

Thanks,
-Stolee
