Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ECAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851BC61245
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhHXVtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhHXVtN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:49:13 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED791C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:48:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so41525587otg.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V8NMUYNm6xvwxT7T03NZtDy8CZ65MjYkR1qL6aKa744=;
        b=Pz4/mI8/W+ZL7R8b7aea3AAsy3ET4m28yWOctsPfHj9dp1tD0rAIhskMYsPWzWYShd
         8LQ/eIAqhuhA3CH4vZyUjN+gdWZvWwXWsnQKECOEcbnsC2eTp40auhOt3qeYkjombSQh
         gTg17AISwyvOORhNIgoqT5Hbby30cNcSDuTHlnbUIetHggo6/iMQ22sci4Y+lBUgWuAz
         oVax17jCnXScMdMJ7dApIYjeeiFFQs5HKOLQx/kCnZdgqewyhOQ/Z+UIpdonwBO9ZyF6
         ovZd+/8lc+/x3ndrpHfKywfYMU3BeyiTufv5PoSXywC9WD/qHDMtatMZHjzoP5V/c3CO
         En/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8NMUYNm6xvwxT7T03NZtDy8CZ65MjYkR1qL6aKa744=;
        b=s38Apc6H5+/UFfvDbC6ZNNhzSmDiwBj3fKW3WLTE2H1fpZ9Jltnxo6HWZxeYRJC/vC
         IhCDxYpujrZQ0C6TJp2V+uIuxB2wb0tPllOVTYdruddYRFayvWO1HjHMHkyeC+W5eCOp
         DrpX8sIuC6WjfDaGL+4QQKE2VF4sVsQUJsbmdTjzPIH9qQkUvWWK/eknB/IVBWQTVlPC
         6NORtbv2JAnRtgLbMNZH583hNnZQP9A39RGWJXM6XmeTLvS9Ro7CZINRwuUD4dvD7HWZ
         tLRfnUlNKYbEtCYxmnOVk0g4y3rUV0Rz2W1CwY9EZdK9t0+eQ9a5wjMnlaIbyqIhilwA
         VINA==
X-Gm-Message-State: AOAM532RR3qr/+Cz8LpNU2wB0bjRUhc2AgDKo4jWVR/nQwmdTFlLpghQ
        NswqiE6KaVRsc/ZzVatFSsc=
X-Google-Smtp-Source: ABdhPJyZWECvkwkpSBE4G1Wv3rqP3lvn8LNyQYfQ6p/tP6VVwk88zESFTl93M7PZCE5v5McK9SmziA==
X-Received: by 2002:a05:6830:438d:: with SMTP id s13mr11749398otv.308.1629841708306;
        Tue, 24 Aug 2021 14:48:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id j2sm4711294oia.21.2021.08.24.14.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 14:48:27 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] bundle API: change "flags" to be
 "extra_index_pack_args"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-2.4-3d7bd9c33be-20210823T110136Z-avarab@gmail.com>
 <30620e13-4509-1905-7644-9962b6adf9c5@gmail.com>
 <877dgaecum.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a70b7c7a-ecd7-b4f8-c253-65c4bf5de4a4@gmail.com>
Date:   Tue, 24 Aug 2021 17:48:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <877dgaecum.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 5:41 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Aug 24 2021, Derrick Stolee wrote:
> 
>> On 8/23/2021 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
>>> +		strvec_clear(extra_index_pack_args);
>>
>> Why is it the responsibility of this method to clear these args?
>> I suppose it is convenient. It just seems a bit wrong to me.
> 
> Because of...
> 
>>>  /**
>>>   * Unbundle after reading the header with read_bundle_header().
>>>   *
>>>   * We'll invoke "git index-pack --stdin --fix-thin" for you on the
>>>   * provided `bundle_fd` from read_bundle_header().
>>> + *
>>> + * Provide extra_index_pack_args to pass any extra arguments
>>> + * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
>>> + * extra_index_pack_args (if any) will be strvec_clear()'d for you
>>> + * (like the run-command.h API itself does).
> 
> ... this, i.e. it's how the run-command.[ch] API already works for the
> same sort of thing elsewhere, I figured making them consistent was
> better than having them differ.
> 
> I think that while in general the rule of having each function allocate
> & clear its own memory is a good one, that a notable good exception in
> our codebase is various "one-shot" functions such as the run-command
> API, i.e. APIs where the vast majority of callers just want to set
> things up for a one-off run. Having those common cases not require a
> that_api_release(&ctx) afterwards seems like a good idea in general.

Makes sense to me. Thanks for explaining it.

-Stolee
