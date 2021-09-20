Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC9CC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A2861166
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 21:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhITVSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhITVQl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 17:16:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08835C0A0ADF
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:25:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i13so19556090ilm.4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R/fxmn7O5NBtWeTURuNloVcqabIATiCyh2rt5yv5f7Q=;
        b=fXju+empf1ZML+DHmOuo7X8jWSHPd0GS/5+WZ4a/RT45O3K3s3Oj47wXRfNRjrt4Fp
         czsO6kWqyA6fEcIgCXxYJSJ4MDg5/vQUiO2phZEQFlJrdzCNstINh45lbniJ+m8QbQm6
         2QZ+JTiY7f1TOazeQ5fvdm/JF8tM5VEW+YGh9gPO+hZJw/bowJRh2MQ5z4TknJ46Br40
         zfoaBD2xqlMeTD1G9/UBiGT+jN+jLNcwQcCS3KA8yitc2BI/gaVR3r95/oKW2Z4DMMbj
         k7NCi0TP7V6NE7hROwGLsN5Q7Yz4J42/jhbCmt2LlmDVAK8uHVflu9ZNWKdJnmEckW/z
         H1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R/fxmn7O5NBtWeTURuNloVcqabIATiCyh2rt5yv5f7Q=;
        b=7ZpNZFhW7HHrXWqE4og0MS9eFGGwo7bmokhGqBYE3dXeR/QR8xdqhDv+zTZPDXtsHN
         LstBuszSkdn/b9KVdBmq4Hym4PU3HBQE6SBZhXMHGBRl5Mwl/A+1cmPghl48KJYNZHDq
         SjZmX1U9N1hJre+xGbUvOnUdM10Y6NSvZv6vqIEn9d9Fy5Ck3j9+1MSrorljn3L4e7dS
         RVqpk7Z06ob1c9G4kW8Vi9xcA8DJjavoQ01Y/rbcVP5iFpMOK9P4nMsR9m5gkHyS/kYW
         0/wlJDUIhKzOVZK++7ePf2LM4zCygQg8pGwTRnIlsfToPZuiFrKVcYElmzYBuYwjiD6t
         riGw==
X-Gm-Message-State: AOAM5317AepE3PFje0uen8cTSVavYLTDjb9GZuVQTVcOy8+UPHkaGXd4
        cVZ1+6l+vAAP8Rw7JWAhZNee/Ntx+6XQBw==
X-Google-Smtp-Source: ABdhPJxqysd6d8j+rMqA8eTulUeDStHI8NYJfrRSRy4WGJeZjwbjgibfmkVlkTW6bDTI3XtadSf07A==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr18163730ilh.181.1632158733078;
        Mon, 20 Sep 2021 10:25:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3dd4:10d2:c651:2ba0? ([2600:1700:e72:80a0:3dd4:10d2:c651:2ba0])
        by smtp.gmail.com with ESMTPSA id o23sm3567557iob.15.2021.09.20.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:25:32 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
Date:   Mon, 20 Sep 2021 13:25:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUi55/3L9nizTVyA@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2021 12:42 PM, Taylor Blau wrote:
> On Mon, Sep 20, 2021 at 12:29:36PM -0400, Derrick Stolee wrote:
>>> So I think the problem really is that we need to drop existing patterns
>>> when re-initializing the sparse-checkout in cone mode. We could try to
>>> recognize that existing patterns may already constitute a cone (and/or
>>> create a cone that covers the existing patterns).
>>>
>>> But I think the easiest thing (if a little unfriendly) would be to just
>>> drop them and start afresh when re-initializing the sparse-checkout in
>>> cone mode.
>>
>> This isn't sufficient, as a user can modify their .git/info/sparse-checkout
>> file whenever they want, so we should fix this bug regardless. We could add
>> a "Your existing patterns are not in cone mode" error.
>>
>> It might still be a good idea to let "git sparse-checkout init --cone"
>> overwrite the sparse-checkout file _if the file is not already in cone
>> mode_.
> 
> I'm not sure how helpful such an error message might be to a user in
> this scenario without extra information. After seeing just "this isn't a
> cone", it's not clear what they should do other than drop their
> sparse-checkout configuration and start over.
> 
> It would be nice to have an intermediate step between seeing realizing
> that the existing patterns don't form a cone and dropping them.
> 
> Perhaps we could include an error message and say something like:
> 
>     warning: your sparse-checkout patterns do not from a cone
>        hint: to reinitialize your sparse-checkout configuration
>        hint: try running:
>        hint:
>        hint:   git sparse-checkout init --cone --reinitialize
> 
> Where `--reinitialize` means to drop existing patterns. I suppose it
> could be the default when transitioning from non-cone to cone mode, but
> that would defeat the purpose of the warning.

I've got an initial set of commits in a GGG pull request [1], and I'm
waiting build validation as a double-check before sending them to the
list.

[1] https://github.com/gitgitgadget/git/pull/1043

There, I think the best thing to do is have 'init --cone' overwrite the
old, non-cone-mode patterns. This essentially makes your --reinitialize
suggestion on permanently in that case. Note that it doesn't reinitialize
when the patterns are already in cone mode.

Note that 'git sparse-checkout set' (with no other arguments) initializes
the sparse-checkout file with the default set of cone mode patterns, so
we have a way to do that now.
 
> We would probably want to perform this check both during initialization,
> and when adding patterns in cone mode. It may also be worthwhile to
> check the validity of the cone before running 'list' or 'reapply', too.

'list' definitely seems like a good idea, since it is expecting different
output than the literal patterns when cone mode is enabled.

'reapply' should work in both cases, it will just use the old pattern
matching algorithm when in cone mode. It will present a warning when the
patterns don't match as expected.

One thing that is very interesting about the example here is that a
pattern "dir" is not recognized as a non-cone-mode pattern, but it
should be. The fix is to look for a '/' at the start of the pattern and
reject it otherwise. This is fixed in my series.

Thanks,
-Stolee
