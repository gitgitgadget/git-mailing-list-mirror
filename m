Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC20C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 17:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiEXRig (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiEXRie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 13:38:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812A1FCE5
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:38:33 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s23so19025669iog.13
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mb1YTOGugU1Aa/WjC/9HH0hnMG3YlkHI/zbJRGMvSQY=;
        b=VfvUsEQLg/GysWMrEKCv2xvITrjKLLRbMAiD8qNoMuEpngyhCN/Wd/8wRx9acBYpIr
         IP3xVhmH52m/yVyNiDng6ccQnvL2oUCuzN7rmI15uUbTKH12pHUYLYEAqTMAlf26wt2r
         pAPTvJT4zjRdsUxYLSe50tn4elIN6LgogmEN/J5+WairBTebbAteARDeuVimgOlPrkhm
         YzZBShLqNVnG5VUYVSgR3Z2mgcAhzDcnR8KPW8ppR/DNH9D5yU55PHsZRGRl1r9ddVPu
         ricjPVY592pEbhbCczyR9Vka6NIDIPykbFUlu168tsvjd4laLYxA3MpGEeE0lHTNbzAc
         O1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mb1YTOGugU1Aa/WjC/9HH0hnMG3YlkHI/zbJRGMvSQY=;
        b=LreWK4TQ7CcNgyKzjBPRUHaP18e8foPG2F7EIgf8bzlUUwKOfjPav0bIVujj6LEAYx
         cr300FiytRwlhN4BgxScls8fZpZZsWAo32M4PVpDfNXzcrwvXyIfDRtuMaAM/vzx35ME
         kQsTs882Y9aAM57NbHgS6mRr5fbFRU/0HBnurOl9spLFR9SOaiuCo8dZjTAC0n68D0v6
         eU47tEzwCkK6Xl/EYebWBddAylTtmn3M9DG21wqrLaaN/B0EFe9CaVsAECQfwaVJDns6
         GIt2Ux1Ru3labqRVh0L2HvvPuZtWYCAk0GTTvbC3HuuAEclJLhdTqFAA/RlfcohwGf9q
         cHSQ==
X-Gm-Message-State: AOAM532sYfUrNoMXks+B4CGBv/slxctC8663WMRP8nOKcenmTO1IaTEk
        urGx12UayoxnTkZ2NQI9GAD/
X-Google-Smtp-Source: ABdhPJxskxBuB7fJwM6KKVV+0UoexpQatVERJx0ba9uPZ9KbT/jvBhs0V2R79YhbuC4DqZcewv84Vg==
X-Received: by 2002:a05:6602:881:b0:665:1ebf:51c4 with SMTP id f1-20020a056602088100b006651ebf51c4mr380101ioz.104.1653413913146;
        Tue, 24 May 2022 10:38:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e? ([2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e])
        by smtp.gmail.com with ESMTPSA id z28-20020a05663822bc00b0032e30453802sm3613741jas.47.2022.05.24.10.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:38:31 -0700 (PDT)
Message-ID: <563606bd-551f-39b2-74f0-40547b7a0113@github.com>
Date:   Tue, 24 May 2022 13:38:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] setup: don't die if realpath(3) fails on getcwd(3)
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Kevin Locke <kevin@kevinlocke.name>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
 <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <1580ad10-43f6-bc73-901a-b65b1aea73ff@github.com>
 <YozlZ9DPrRLPBTBP@kevinlocke.name>
 <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGZTDKorz+CFScfTfx47c+TuJaAD_Zyyo1Jj_tymYkVXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 11:20 AM, Elijah Newren wrote:
> On Tue, May 24, 2022 at 7:02 AM Kevin Locke <kevin@kevinlocke.name> wrote:
>>
>> On Mon, 2022-05-23 at 14:57 -0400, Derrick Stolee wrote:
>>> On 5/21/22 9:53 AM, Kevin Locke wrote:
>>>> +           free((char*)tmp_original_cwd);
>>>
>>> Hm. I'm never a fan of this casting, but it existed before. It's
>>> because tmp_original_cwd is exposed globally in cache.h, which
>>> is _really widely_. However, there are only two uses: setup.c,
>>> which defines it, and common-main.c, which initializes it during
>>> process startup.
...>> This approach seems reasonable to me, as does casting to free().  It's
>> not clear to me which is preferable in this case.  How to balance the
>> trade-offs between exposing const interfaces, limiting (internal)
>> interfaces to headers, and avoiding casts might be worth discussing
>> and documenting a matter of project coding style.  `grep -rF 'free(('`
>> lists about 100 casts to free, suggesting the discussion may be
>> worthwhile.  Introducing a free_const() macro could be another option
>> to consider.
> 
> I'd prefer either a free_const() as you suggest (though as a separate
> patch from what you are submitting here), or leaving the code as-is.
> free() could have been written to take a const void* instead of just
> void*, since it's not going to modify what the pointer points at.  The
> reason we call free() is because the variable isn't needed anymore,
> and using a non-const value after freeing is just as wrong as using a
> const one after freeing, so casting away the constness cannot really
> cause any new problems.  So, I think the signature of free() is just
> wrong: it should have taken a const void* all along.  Unfortunately,
> the wrong type signature sadly makes people feel like they have to
> choose between (a) dropping the added safety of const that the
> compiler can enforce for you during the lifetime of the variable, or
> (b) leaking memory you no longer need.  I think it's a bad choice and
> you should just typecast when free'ing, but clearly others just don't
> want to see any typecasts and are willing to dispense with const on
> constant variables.

I mostly agree with you: if free() didn't have the const, then the
answer would be simple. We probably wouldn't also have the convention
of "const pointers are for memory we don't own".

Specifically with 'const char *' this can sometimes point to a
compiled string literal, so I tend to be more careful than usual
around these kinds of casts.

I'm willing to concede this point as it is much messier than just
the goals of this patch.

Thanks,
-Stolee
