Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8831CCCA479
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiGMSdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMSdV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 14:33:21 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A11573F
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:33:20 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10c0d96953fso15159937fac.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+/5w2gLWgGq9NHRQzmyBoEqbh3PYKFqIM6KlMZwKvAQ=;
        b=DhMcDLvXiGU26coPbork2Ot4ex+BvN/7s/cVN5Ta3DbQu5RL0F9PIrOlP9pSAFMjVR
         q58b9x2VxiDZG8hCOLFxGOdZ8q0hXDcTh48d0KvoltW0CQONDVawem53YRyQagypX7c3
         /hogxMdtDvZ6/wRtCixjddsTQgV0aSAP3hBnxak4PIewb9LJIlSYnS6gG4cR28udyjxn
         HItcZEIT46x5bfzP4eL1hGrs4jovgm3z/eZhy14/TYyz1tWoju2FI6rV+I9DsADgTopM
         ilmOxsvJ1XWrV/qMNqCDWcdD1G3f6WllxXuLsqXX54kfc8RphRxXovKJBShIqi+WbNuG
         u4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+/5w2gLWgGq9NHRQzmyBoEqbh3PYKFqIM6KlMZwKvAQ=;
        b=1pJ8Xg+ZkCeDPGbzTzQcyDf76LmQckmhbqf3XQwgiRBUb+syrA+OGt6bmwdQXpNlSs
         L8SD7pd0SvIhQvJ4y1/UpBMTQgzQ0gs1LbXgfbO95BFGbwcxnpCGCkPFIaeg+Wm6RmeT
         rAdsEvua5pRQ35Lq8S/sFYtbaKSkqCZwH1R39ZvqyYaQPkuMkrkj7OjA4DWYaaDRCtBR
         sbyq1o0JXB2Qhhtu0aVSlZuh4Y2hE0Of/HPLNDMwBcpDtdfNc9uN/DVbukHrq/qY6l9L
         oToXlpfNHJBIIRZw3qucHLnukR/LznrjLz19WvjAKhIF/kZ2jIWuSpnwlOcissI8bMZn
         MSZw==
X-Gm-Message-State: AJIora8qOjyy7EqGvF9WXzLzFwFAlbmxawCgP1gSI0rTwdWyQeTZBQ9a
        NiOVlOZCau8VEjPnXAcfEa+j
X-Google-Smtp-Source: AGRyM1v3wXJjlFfLxjsmlUrJ7KsUzhpYo87MajDwZBrA48zmA5Tq83vhkPwGym59lSMQlCTux7j1JQ==
X-Received: by 2002:a05:6871:606:b0:10b:f881:e606 with SMTP id w6-20020a056871060600b0010bf881e606mr5455527oan.293.1657737199835;
        Wed, 13 Jul 2022 11:33:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3507:5998:f07a:ba19? ([2600:1700:e72:80a0:3507:5998:f07a:ba19])
        by smtp.gmail.com with ESMTPSA id s3-20020acadb03000000b0032e442f6a72sm5558493oig.40.2022.07.13.11.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:33:19 -0700 (PDT)
Message-ID: <647a4cf7-ef1f-284b-37e2-4dceb3cfae1d@github.com>
Date:   Wed, 13 Jul 2022 14:33:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Use "allowlist" and "denylist" tree-wide
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <xmqqk08hdm05.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk08hdm05.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2022 12:18 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The terms "allowlist" and "denylist" are self-defining. One "allows" things
>> while the other "denies" things.
>>
>> These are better terms over "whitelist" and "blacklist" which require prior
>> knowledge of the terms or cultural expectations around what each color
>> "means".
> 
> Half Devil's advocate mode on, as I got up on the wrong side of the
> bed this morning.
> 
> I am very much for consistent uses of allow/deny and I think it is a
> good idea to review and apply this series.
> 
> But I'd prefer to see us more honest to ourselves.  Like it or not,
> the code comment and documentation are targetted toward those who
> can read English, and when you say something is whitelisted in
> English, you know exactly what it means, due to shared knowledge of
> historical use of the word.
> 
> We are doing this change in the name of inclusion.  I find it
> intellectually dishonest to avoid saying that true reason, and
> instead say the allow/deny pair is more "precise".  They are not
> more precise.  In fact, the fact why you have to choose between deny
> and block and defend deny over block shows that these words are less
> precise.  People who use white/black do not have to choose between
> black and other colors and say "white/red may be OK but we choose
> black because..." to defend the choice of their words.
> 
> The reason we do this change is because the project thinks that it
> is the right thing to encourage the adoption of these more inclusive
> words, together with other projects that did the same.
> 
> In addition, they are words more widely accepted in today's world,
> and new folks are more likely to be educated with these words.  As
> time goes by, the historical white/black will be less understood, so
> it makes it a future-proofing change, as well.
 
I like how you start by saying you are playing devil's advocate,
but then go on to add more reasons to support the work. It's good
feedback to make the case stronger.

Thanks,
-Stolee
