Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86213C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD9207A5
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgL3UY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 15:24:59 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AACC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:24:19 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id o5so3925659oop.12
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOQSLW3GJcDPQ9bhj7A/kjJkswIsXsOD1h0SS6Wk998=;
        b=akMtx4r4eMh/LRscJRbHXCooX1CzyJf9gcLqWJcRW12CZImMMKayKVk6qwXIKTfNbU
         HZEy78R2sX5sDB2nZr6ptTMntaenTZLUEAxGIESLwEhPMGPLOkege5+QvgJZUxpznI3F
         nPIRsgprt/nskOmnRkSxtCDczfyDrgbJQ0Cf6yY2tiQb2hAodkPtMBi5tDmmjUeKCG/3
         n9pZtiui9M9mumu6fVXpMPZuzQI5KbLgWQjNfPh4iRPEIpcqaDqgBI04Rk0MU1t3Vjv/
         8A/ZUHCH+Khqon0nqElEz8Vuh3TFgXqMtEDll5659BSnyhsYbOcv2NBnH4cY9J+uq0/F
         XzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOQSLW3GJcDPQ9bhj7A/kjJkswIsXsOD1h0SS6Wk998=;
        b=KsOwADqH9+9NIaJXq4h2nATcssZffVJWhFC8w1AsMe1KR21yQn9fMpwZxeZ4yx67mL
         l0nninR0KcmJVRgaWGnLNjwpCkKTqVUApK6Wx1K5K2DZPu1/7snKJFX7N5/3gag66O5s
         mR2Z5iJ0fYNu6/E7JObS6gjTBQAxTZ3hUWut84G/rupoLW2dDmQXNoslgf9+W8avJ2T8
         v4EnRMc/F+8WCaMWlxErrGOtXZbXuhTdvU+PpoX6l0M5shNIpaUwib1bA1Gjl87hJL6d
         yPu6ISaBpVG9YpOhVmD+b+lzVTLfvrrUut1XOy/W25Ka3xbuPkelXEVJ1AzVKJamWUb0
         tfOg==
X-Gm-Message-State: AOAM531HTahHPTqQ7ZojLMZK0NdZSb6FIJ4K9M21wE4fQo86egGAVS2d
        XnU1TLhKzTWQ+ltVz4b48q1VIsmzLa0=
X-Google-Smtp-Source: ABdhPJz3dJqi4L9nH3eLVlciXmr1s2TMX3ynxQFwsTUVCUXJnnTKe7v9TAaFn25F6PXkeWeKjml8qw==
X-Received: by 2002:a4a:d118:: with SMTP id k24mr37412823oor.8.1609359858389;
        Wed, 30 Dec 2020 12:24:18 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id f14sm10506470oib.40.2020.12.30.12.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 12:24:17 -0800 (PST)
Subject: Re: [PATCH 0/8] Cleanups around index operations
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <CABPp-BG6iiQ=_SvGEFCGnYe+z57op+b6vWfJmw=w_0eikzpvCA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <11b79eab-6a4d-ee80-3761-e5ff3dac08cd@gmail.com>
Date:   Wed, 30 Dec 2020 15:24:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG6iiQ=_SvGEFCGnYe+z57op+b6vWfJmw=w_0eikzpvCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 3:19 PM, Elijah Newren wrote:
> On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> I've taken a professional interest in the index lately, and I've been trying
>> mostly to learn about it and measure different operations. Along the way,
>> I've seen some possible improvements in documentation, behavior, and
>> tracing.
>>
>> This series collects most of my thoughts so far, including:
>>
>>  1. Adding extra trace2 regions and statistics (similar to [1]) (Patches
>>     1-5).
>>  2. Update documentation about the cached tree extension (Patches 6-7).
>>  3. Removing an unnecessary loop from verify_cache() (Patch 8).
> 
> The series seems pretty simple and clean to me.  As I mentioned on
> patch 6, though, I don't know much about the cache-tree extension
> myself (I show up in blame/log due to moving a function there with
> just some slight tweaks), so it'd be nice if someone who does can take
> a look at the documentation added in patch 6.

Thanks for the quick review. And I've CC'd Junio since I forgot that
GitGitGadget no longer auto-CCs him.

Thanks,
-Stolee

