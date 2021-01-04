Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F357BC433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 00:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22632080D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 00:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbhADA4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 19:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbhADA4z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 19:56:55 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33CC061574
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 16:56:14 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id w124so30379085oia.6
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 16:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mykILou47wYaEfTO95Ekp1kS75M5WXM7gnnqYFJZTnU=;
        b=NVP1UMZmD9dFe/7IS0FQoZWtKs9td09pfpUJq0uWgaFyHdSCGbCMuFZIp4rqi4DTd/
         i35rw+jMCnxFCKt9cU8yl1BVqEtBv2Z1v1di3KlS5kQG1s1aaVhMSQeG/6Pw/0noEFdH
         KOh4OqSmZD9swelCVtVu5kuN5TjsSK8wKXEU1uhoQ7pf6mPtx7oPgZGR1vRuM5ww6jnB
         hyrq6+p5j66yyCBN3YWmYIouqs5Umc24Z7h6mikdvIibZEoNXr86wqNTsEPn5P7WBP5r
         CglB7RDrCKP7TVNnmxBs6TfvwtQn7i7s17yhuUmwzcRCBlSLsU2jKUz0Y/qrFAvVJXfR
         zZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mykILou47wYaEfTO95Ekp1kS75M5WXM7gnnqYFJZTnU=;
        b=Pl3BUwZwHoKSDjII2E+86wEbEJO/8YY3GNusjwHZp/w2l8e/L3xdRiMIEthImITCC4
         YBsCYHFFz43k7pfmMjXtWPKDQTO66Uy13R8GlV46TfnDfjT0lxxdjLs7Y+lRzkIoVi0F
         X8dxZ+PEQiV6EgJKzZir6C8LPNxOvWEG1fCeJExDivXGAEEwn1m09yBrPuxJKYIbT7h/
         sJ3mvo0nu31W177mRjMAeam2CYWMLnjvknlbQ/uOd/prENTbXYdweEo31bHh7EndbKn3
         +9hQfiYX6kIUaV6BMiMjLP639y8cegHrMZI5Tvev7NLUMVoozWd1z4Ph0+Uoy3O+pmPe
         V6/Q==
X-Gm-Message-State: AOAM531oKapwRFakcR+Ue6w1zk8znFq1vwML9GkURljEgNyMdoPCaFbh
        +WyzE9HucOEsIfsb4sU5tHE=
X-Google-Smtp-Source: ABdhPJyUOTT0kRxKGrgd3kcDPux5vMqeHi2FGns5op36rrstBHPpODWF2HFkl1RWYrPamo310f9sxQ==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr16463033oij.107.1609721773595;
        Sun, 03 Jan 2021 16:56:13 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id s24sm10006192oij.20.2021.01.03.16.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 16:56:12 -0800 (PST)
Subject: Re: [PATCH 04/12] update-index: drop the_index, the_repository
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <77f6510bb680aaf119526f75daadf8c40d22793e.1609506428.git.gitgitgadget@gmail.com>
 <CABPp-BEboS3OG0dMi6kzaXkJ3vELKgpV1Km0m3ZjACA2nGa5QA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b124600-9e3a-9bce-a1e8-49ceef0d595f@gmail.com>
Date:   Sun, 3 Jan 2021 19:56:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEboS3OG0dMi6kzaXkJ3vELKgpV1Km0m3ZjACA2nGa5QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/1/2021 4:05 PM, Elijah Newren wrote:
> On Fri, Jan 1, 2021 at 5:10 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> To reduce the need for the index compatibility macros, we will replace
>> their uses in update-index mechanically. This is the most interesting
>> change, which creates global "repo" and "istate" pointers. The macros
>> can then be mechanically replaced by instances that use the istate
>> pointer instead of the version that autocompletes to use the_index.
> 
> autocompletes seems a bit weird to me here.  Perhaps s/autocompletes
> to use/implicitly uses/ ?

My intention was "instead of the macro expansion that uses the_index".
The preprocessor is really just an early version of autocomplete, right?
Thanks.

> Also, it seems like in the last few patches you just used
> the_repository whereas here you're trying to avoid it.  Is that
> because there are more uses here and only one in the other patches?

My goal isn't to remove the_repository, but the earlier patches also
avoided static globals in favor of method parameters. I needed to
change the strategy for update-index because of the vast number of
methods needing an update. Since I was making a static global for
the current index, it was not a huge step to also add one for the
current repository.

Further, the cmd_update_index() already had a local pointer that
replaced using the_repository, giving me some reason to include
the_repository in these updates.

> Otherwise, all the changes in this patch (and the other ones I've read
> so far; going through them in order) seem like the obvious mechanical
> changes necessary to update to avoid the index compatibility macros.
> So, looking good so far.

Thanks,
-Stolee

