Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7276AC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B77861166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhIUQAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhIUQAF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:00:05 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FAC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:58:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so12487695ota.6
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3gNtPmfmu21K320rGsPt0FwFyuE8EMazlPeSXAvUhE=;
        b=np6LBJ+nkOfqHhImih7a/FWBYvFDmjvWo2MlnB4idtDFWb1O4RmbdMiLkPHLF9up7M
         hPa7OiAJtRSnszKqHBsmlRhEyF6Bl4GDvBnNgdyRfZM35rhYw9WLJ5ZekXsIznFtXF30
         Kf+rUxwg9YxuBH0o8DwkWcFaYX0YJA/ukjwr9lvyk00qO1khRJGQv0IeThykmfQsXXHW
         ZbIa+FFHg2yVka+zlo4b6DiNKV1DKOGKbRETzURPOH3nmK3aZdpqWCcWlrSwWnsxnRHX
         Rq9fFoFj9KJIkiTWjN9EDslwOC6wSGgVQE4Kd8sT8V8+37SyVArnflDfSzEoIUnok8f2
         ONNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3gNtPmfmu21K320rGsPt0FwFyuE8EMazlPeSXAvUhE=;
        b=FEj5WT1k3SgcgYSD3WaDfr1F/NoTpHci23BcKTemuJ3DdG6Xux8lQE9cD23AJ84lSS
         mtfxI7Nqa9Z2ctdadFkZlC8MX8FweHHwRo32f3qaA5XJz5UWgd+NzYDoDYHtIOAFHegY
         pJgzcjxa21CRtNICQTAIo+MhWyi9wxsqFgbXmkJVPAlC20Sk+qMobFZiRTaynHG9I2gY
         gAX5kuiv0ZOl4hzVDOTd/VsOB2L+6w6kPixbq1eEwY7wcJub5XYauY/M6Uz7YXoMYjoo
         N6zBzRVjJt27v8JhcX4GCLBE1aISyKfkzhRctSw/Nm4+jQ6bpzwerijp6swoI6ya6915
         4I1A==
X-Gm-Message-State: AOAM5311JJZyVegijvsZRBGTsV/Ubvge1WKXTWlf9kNyJkJndYwF5yc1
        ocO6+mJ+r5ec+azU9KJrRVNWfyjsejgikQ==
X-Google-Smtp-Source: ABdhPJzzwLui0X5IANmDR4Er18+IFX5XsWJo8xh7Fe2jlR/EZ8tRD+6VWCn1e3uwuCBsbOu69GLZ6A==
X-Received: by 2002:a9d:7194:: with SMTP id o20mr13276561otj.381.1632239916364;
        Tue, 21 Sep 2021 08:58:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ace4:98aa:c023:6ae9? ([2600:1700:e72:80a0:ace4:98aa:c023:6ae9])
        by smtp.gmail.com with ESMTPSA id y12sm756549otu.11.2021.09.21.08.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:58:35 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] repo-settings.c: refactor for clarity, get rid of
 hacks etc.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d852d412-4d6a-505f-2c4c-52e81ab4e3f4@gmail.com>
Date:   Tue, 21 Sep 2021 11:58:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2021 9:12 AM, Ævar Arnfjörð Bjarmason wrote:
> A hopefully final re-roll addressing Taylor's v3 review, except for
> the suggestion (that I read as) perhaps retaining the test-only code,
> which I've decided not to do per
> http://lore.kernel.org/git/87tuieakms.fsf@evledraar.gmail.com
> 
> The x(un)setenv() now returns void, and the error messages are less
> chatty, I also improved a BUG() message in 4/5 that we end up deleting
> in 5/5 anyway, so it doesn't matter for the end-state, just for
> understanding the patches.
> 
> Ævar Arnfjörð Bjarmason (5):
>   wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
>   environment.c: remove test-specific "ignore_untracked..." variable
>   read-cache & fetch-negotiator: check "enum" values in switch()
>   repo-settings.c: simplify the setup
>   repository.h: don't use a mix of int and bitfields

This version looks good to me.

Thanks,
-Stolee
