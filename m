Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E3BC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5923C6127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhHXVsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhHXVsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:48:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714FC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:47:17 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso35182506ota.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tMbpaPpb1k49CglnLir0SFFuPLfEGUKptNUjFPeWpiU=;
        b=WvUTy8cpz/IFiEyZIrJN9+dN8aaj3O5t+nSY8MRQTBgNCJ/CYBBltZHIfYvyi3Sllf
         IhWOr3j9vjGaOsh4yDoUOsj4ffRKy6zx39hRlR3/SnVDAt9yrfq1pDLJOSlrOVbFMBn8
         MoWP+n40VOPmzpFYcedE6ZAStMVO0FTaG8PoqIxx/vrwEq0cGo4LBeVeG3IMPx1v0Ow/
         vOOzVKbS5ZojH948JUbU+eJCCD9MI4yJqN7WS35lH+WZMoIZ34XrKolrXkLUvHQAGMZS
         fKuofF9DPtbhf+HAk4jv4vHBs6bOFcgzv5a6UQbbEEUuAraP+5mVpli4aXINzGI41moU
         DN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tMbpaPpb1k49CglnLir0SFFuPLfEGUKptNUjFPeWpiU=;
        b=jiuq4alGO+Y4e2WDGwt0Sab4X1flmBWGO0nMw4XptDzgBQNkOeDDOsq0isZ6VWchNP
         f04yFNDcBYUbZb9Kwlq1f2q+EQzC1PdhD8IBPn/K7tAe5c1yRtOu0qSuCuZCzu9vDvvG
         ISqVks5/Z5VdhSLsIidJbtYuc1TNaa1eLmgB21TA4PRoDs3peIQtoeBKSMGgxyaiLj8c
         3dc/FS1cn3AN2kSw5ib6T/XV2gMd9ikCRqmV/iVp9u+E+kc+gaYVeAKkL41DxV4iZf38
         rn5JVrWS9aYMS2JEZVKir4b7cS4RUt4Yd1j7ol15/2x+HjbaiR10vfKmQdapsZzmVD2Z
         SUlw==
X-Gm-Message-State: AOAM533jR+DJ4RzIyiUdOZoeR27N9MC8Xifzw82OOYp+FVq9KkdtSuHC
        RjawlOOC5K26GKZzh5KT01o=
X-Google-Smtp-Source: ABdhPJzQxE4XFt4WhvNc80ZbX9aGdwX6RshYfMQW2Sdrbreov4he/rX80FjiQGmlnytM9XZK1vQTxQ==
X-Received: by 2002:a9d:4590:: with SMTP id x16mr33972135ote.94.1629841637020;
        Tue, 24 Aug 2021 14:47:17 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id s10sm4249830oog.14.2021.08.24.14.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 14:47:16 -0700 (PDT)
Subject: Re: [PATCH] gitk: new option to hide prefetch refs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tal Kelrich via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Tal Kelrich <hasturkun@gmail.com>
References: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
 <0004f758-759b-f523-fa3d-dd7759d6eec7@gmail.com> <xmqq4kbeptnv.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f11f6920-aec2-ba5c-85ec-5b0cc5a2e880@gmail.com>
Date:   Tue, 24 Aug 2021 17:47:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kbeptnv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 2:46 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 8/24/2021 8:18 AM, Tal Kelrich via GitGitGadget wrote:
>>> From: Tal Kelrich <hasturkun@gmail.com>
>>>
>>> The maintenance 'prefetch' task creates refs that mirror remote refs,
>>> and in repositories with many branches this can clutter the commit list.
>>>
>>> Add a new option to ignore any prefetch refs, enabled by default.
>>
>> This seems like a sensible feature to add. Thank you for contributing!
...> I would usually say that defaulting this to 'on' would be a biased
> choice [*1*], but in this case I tend to think it is a good idea to
> hide these by default, as 'prefetch' came way after people started
> using Git, and users did not ask for 'prefetch' refs.  The prefetching
> may help users but the refs used to anchor the prefetched objects are
> implementation detail that the users would rather not to see.
...
> *1* Whenever the inventor of a feature says "I expect users would
> want this!", it needs to be taken with a moderate amount of salt, as
> the inventor is self selected specimen who wanted it (after all, the
> feature motivated the inventor enough to write the patch).

I agree with both points. As the inventor of prefetch refs, my opinion
should also be taken with similar salt.

I do want to add at least that Git itself hides these refs by modifying
log.excludeDecoration during 'git maintenance start', so there is
precedent. Git is hiding them, but user can become confused when they
appear in gitk.

Thanks,
-Stolee
