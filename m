Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A01C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D4D64F33
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhCQTqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhCQTqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:46:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E8C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:46:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so2950318otk.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o4OIJHQhJ0u9Nt2QaHtahkkQ+QfVIOO42DS1Uk2CqrY=;
        b=bKupUnNAHroCIj21QROufqyG2GGt02xL48Cmp6SAnkRiVPOnJOANjMSQQ7imr7x+xi
         AyHwXOc2HVb5Tj8nXpGxjc2xZof/Kix5MDsOD6OcQbZfo6viYtFJ7pwUa0a2S64ZQyw9
         WTKBzlWW1GskaDQuq0kyg73JSuwtxMo9uYQJ/w7W+2Xk2/zYxvy9j84MVKiBOqfk7lNT
         4Ax2Nuk+/dvWRStMWN17KO8IPNJI1XvbVV8y5bVB3ENhYFCmS6yr5mNnEj53/KTPhGuY
         yxulwYDVSC0v9ExMpHy/7rVwI3w7ycZGF3O0a9zpQifHLi7pNdhAqlyFHwOPKKeizK7f
         ZFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o4OIJHQhJ0u9Nt2QaHtahkkQ+QfVIOO42DS1Uk2CqrY=;
        b=geMZ2iraJpu+cUCrBOCgkyXkSYMig4dlJ/axUiojxpHVN/nMYsEnleAPjPMTpHa2rQ
         gHmsW3ubnMT4CIF2dhp/JXRZhdc5RBsZlk8QPaIvjOwc4cl6mUqefJUWaJERPU4887ww
         ybA/Jjy6lq2wq7akat4PcLfP+xfqg++CEQnI2VglzK7on26qnSdyGcLX2b/CEofRb7j5
         Lvvt1UMBV3reXKCNxawGNooWqeaZTy8u3QFhWAUOZ36mE7ckr5MZLyYVCovD9EV/hhFC
         WUCFTHL9oHf+I+dHK7eu2hFy48j3/fXLs4JGMKKop9n1SGjljdlT1nR3Os+sI3CUz3L5
         k4yQ==
X-Gm-Message-State: AOAM531DuFr69VTJPzdozHyzij5scruCco5IBz+3UVgptDO9MzIUMLmo
        j9kdo1bLMmSZI0ARZPzYSrI=
X-Google-Smtp-Source: ABdhPJwEFQ6hba+CMguGifZqCYvPX9b0ZSBMSHqNqBEBWi9gP39edXEqpaA8txmbiZtAkHFKaKnCZg==
X-Received: by 2002:a05:6830:22c5:: with SMTP id q5mr4707731otc.359.1616010400970;
        Wed, 17 Mar 2021 12:46:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id r22sm9072091otg.4.2021.03.17.12.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 12:46:40 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/5] Re: [PATCH v3 07/20] test-read-cache: print cache
 entries with --table
To:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-1-avarab@gmail.com>
 <CABPp-BGS7BxbxiPvk7zoO1XdbZSkpyrfYLuyiNnR+d6orPn+rw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d93300ad-9a3b-6de4-c497-acd56eff30dc@gmail.com>
Date:   Wed, 17 Mar 2021 15:46:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGS7BxbxiPvk7zoO1XdbZSkpyrfYLuyiNnR+d6orPn+rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 2:28 PM, Elijah Newren wrote:
> On Wed, Mar 17, 2021 at 6:28 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>

>>
>> So we have a test tool that's mostly ls-files but mocks the output
>> ls-tree would emit, won't these tests eventually care about what stage
>> things are in?
>>
>> What follows is an RFC series on top that's the result of me wondering
>> why if we're adding new index constructs we aren't updating our
>> plumbing to emit that data, can we just add this to ls-files and drop
>> this test helper?
>>
>> Turns out: Yes we can.
> 
> I like the idea of having ls-files be usable to show the entries that
> are in the index; that seems great to me.  I very much dislike the
> --sparse flag to ls-files, as noted on that commit.

I don't like this idea. I don't think exposing internal structures
like this is something we want to do so quickly. Further, I intend
to use this test tool in the future to _also_ show the stored stat()
data, which would be inappropriate here in ls-files.

I would prefer to continue using the test helper here and leave
functional changes to ls-files be considered independently.

Thanks,
-Stolee
