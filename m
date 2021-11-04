Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2471FC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068EA60FED
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhKDNKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhKDNKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 09:10:41 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09548C06127A
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 06:08:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id bu11so5226362qvb.0
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qd2L5nyYYYUmoHEoy7ORvjbvvWdwIujFupj9c8Eg460=;
        b=ggOWJGHAeNtTDg3wbw8VCaAF81JSgR8G3KDdk/ppjwhXkdAiWP9KvwkNKBB2z52Fus
         LqVE+59dn7e3GHDLfcFleUv+kuBKRqS+JjFkpv3TRur/XpgLq7uuXE2AwRTQ/Xy/l43F
         Oay9CEPx6cQskxbydzu5n7hAJAKdZcIaCH11yO9XyIUGiSPC8uiKDfkcFENHv/xEJdq/
         EUme19u1MfEADqC/VyxiPVAcqR+Z7pFvOqFhxU3/IuQKdoSsGfCMWljcGW+e4dqp966R
         ZfAr5b82BwDv/I8+i9am6kuTeoLF/4HmNHQ3QZc6GAcGk6TKviYC2H3mhjyHn7qasf5y
         fwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qd2L5nyYYYUmoHEoy7ORvjbvvWdwIujFupj9c8Eg460=;
        b=zivSkZciAf6k0+6+N/BaKEgAwQTpgLqFvBQr27GUNo5vY0cISwo9SzlMilXgbiX5Sy
         IgigpuhXDnjb2hR8FYaZ2Bt4+rtVAAPEsVlULWkoMtMS5ycD47G/twF7dqxCf2phaSxx
         BDGnxjHajJotmEZQtIfM+0yBJ1CnmjmjTIPB3dIIeCgKft3BPV1N6poHE/F4TbYjXD9/
         rkgw9xBlv9LEKuAO0rOyG1/HZ2os4VRf/5jx6/MPznaiyfy4o4BMY6VyS+AsK69a5XXe
         Mz5RvjhN3SI2YJ0F/R2SDdkeIiBcFQKm2CbkqStm1DnnDXwKrs6h19t4fjpdXOnVLpu5
         9yVA==
X-Gm-Message-State: AOAM530hyrnGO/4zyg5mJfMzB8AdG/0QWUEkJJoGDejOzoN0amZ6Ow/I
        9UvCpAmc78mwEknnUfzvogo=
X-Google-Smtp-Source: ABdhPJwfayUr2E+D3byvjUacWlDlYorYa3oCtBEAp/2nqko8lkHpf9aibCUpnO4+a+dHrDc2aOY4yg==
X-Received: by 2002:a05:6214:da9:: with SMTP id h9mr23188078qvh.2.1636031281892;
        Thu, 04 Nov 2021 06:08:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4fb:2d12:6454:4b36? ([2600:1700:e72:80a0:e4fb:2d12:6454:4b36])
        by smtp.gmail.com with ESMTPSA id j15sm3962074qtx.67.2021.11.04.06.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 06:08:01 -0700 (PDT)
Message-ID: <29114bd7-1c81-7580-c8c0-88904dd013db@gmail.com>
Date:   Thu, 4 Nov 2021 09:08:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue on
 Fedora
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
 <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
 <xmqqzgqk2zsl.fsf@gitster.g> <211104.86v918i78r.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211104.86v918i78r.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/2021 5:42 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Nov 03 2021, Junio C Hamano wrote:
> 
>> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> This fix corrects an issue found in the `dockerized(pedantic, fedora)` CI
>>> build, first appearing after the introduction of a new version of the Fedora
>>> docker image version. This image includes a version of `glibc` with the
>>> attribute `__attr_access_none` added to `pthread_setspecific` [1], the
>>> implementation of which only exists for GCC 11.X - the version included in
>>> the Fedora image. The attribute requires that the pointer provided in the
>>> second argument of `pthread_getspecific` must, if not NULL, be a pointer to
>>> a valid object. In the usage in `async_die_is_recursing`, `(void *)1` is not
>>> valid, causing the error.
>>>
>>> This fix imitates a workaround added in SELinux [2] by using the pointer to
>>> the static `async_die_counter` itself as the second argument to
>>> `pthread_setspecific`. This guaranteed non-NULL, valid pointer matches the
>>> intent of the current usage while not triggering the build error.
>>>
>>> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
>>> [2] https://lore.kernel.org/all/20211021140519.6593-1-cgzones@googlemail.com/
>>>
>>> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Signed-off-by: Victoria Dye <vdye@github.com>
>>> ---
>>
>> Looks like they timed their update to disrupt us most effectively,
>> but we are gifted with watchful eyes and competent hands ;-).
>>
>> Thanks for coming up with a clearly written description and a clean
>> fix so quickly.
>>
>> Will apply.
> 
> I don't know what this would be for the "fedora" and other images, but
> it seems to me like the below is something we should do. This replaces
> "latest" with whatever "latest" currently maps onto.
> 
> I.e. I don't think it's a good thing that the carpet gets swept from
> under you as far as these CI images go. We could subscribe to some feed
> of when these images are bumped to see when to update, but having our
> base change from under us just leads to a waste of time for a bunch of
> people wondering why their CI is failing, which now they'll need to
> rebase on some on-list or only-in-upstream-master patch to have it
> "pass".
Having our CI go red because the 'latest' feed changed something is
probably the best "feed" to subscribe to, since we only get notified
if it matters.

Better to have automation go red than for us to not realize our code
doesn't work on newer platforms because our CI hasn't been updated.

Thanks,
-Stolee
