Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA43C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5308961158
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbhIHSFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhIHSFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:05:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B640C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 11:04:08 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l24so2653019qtj.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=scUkg5OvEqlWJJ/bkjg/WdV0vXKu7/BEUkiMCFrVr04=;
        b=boedHx2EfbdC7fma4xvAC4Fsc4gGA43b7OwDkn1fOPoSmrz2+RgHInkVSplDWEGDAB
         04moFx86z0+SKiErVzw7FxIgiq9EG3C/9O8NSfl7uiu1VYFvFp1bcIMPulkxM1cDNGWV
         y6y1QfgVCMvJfkbXm/ny4KiJ0T8YalGdn9ymprxk0CMFnOULxdw7YiP3UchiuvWJCMut
         JPbsrSST6U986cl0lzz6vF4KbupC+wsHh296NkY0CqPgFacH5n7EQXIJ/Es9yZVl+Ngb
         CiB96S+46YNCwT4gPk6vmyuH6QUh/fBsAPE4adpWwFZ4h7xZpdMhPp7M45dUmrX0pZCX
         ffIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scUkg5OvEqlWJJ/bkjg/WdV0vXKu7/BEUkiMCFrVr04=;
        b=04xMrVedMBMgWAmwNj+j0odc56MZSB9XPwSVdAha+/tWjRghcS9gs/3qw93rIwH4op
         Wu9JE2Cw+wGwkXBm4mlxdeH2FyGVZNiIozypdh/Ij61+Ru3zba+kfH6EV5Xw1/0lPeIc
         BNURWoY19BMBPrgvoBZYmY7VlzXVCcYYkVJYFTyxHB2o3KdUALly8ejXpYNboA0Lw1HY
         GNoARYbLQsDBgGlK6m9JIbW54qKn/xO+MxucrQIfL5N7f+5WTF+R/dfaz9nJa40jqo2G
         Ji47/aDAPRQZrYvMPfm1Is49Cp+e+BeDJjefVDH2E+4gQe1dd87Sma+fECkah77xZXhj
         NHZw==
X-Gm-Message-State: AOAM532xsiYiefPDB4f+EqhH8UZbQcGIcYM25UYn/N+jtWH+fkVbzU10
        VsxZqSXhs8L3jVfXMElWQSczXQYgxOLgMVnR
X-Google-Smtp-Source: ABdhPJxDVqbIb1J5X+YgAYvz+RncE7AAUb2IhqTjJ08SzvXx7kiT6ZwPLM9N3TSoIG/rLnlv6ZZGMQ==
X-Received: by 2002:ac8:740a:: with SMTP id p10mr4836642qtq.37.1631124247694;
        Wed, 08 Sep 2021 11:04:07 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id w185sm2330631qkd.30.2021.09.08.11.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:04:07 -0700 (PDT)
Subject: Re: [PATCH 09/13] rm: add --sparse option
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <6c9c986ff43fe7f065c27e61468534007e70d2a7.1629842085.git.gitgitgadget@gmail.com>
 <CAHd-oW5JD56UerW6N18Ap9Dmt9eVyd7dZKUhJR6-hSjzzM0s5A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb7881d7-754e-05fe-16c3-bf2afac4fb3f@gmail.com>
Date:   Wed, 8 Sep 2021 14:04:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW5JD56UerW6N18Ap9Dmt9eVyd7dZKUhJR6-hSjzzM0s5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 5:17 PM, Matheus Tavares Bernardino wrote:
> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Subject: [PATCH 09/12] rm: add --sparse option
> 
> Maybe mention in the commit message that, for now, rm's --sparse only
> affects entries with the skip_worktree bit set? (Which will be changed
> in the following patch.)

I will expand with these details.
 
>>  test_expect_success 'recursive rm does not remove sparse entries' '
>>         git reset --hard &&
>> -       git sparse-checkout set sub/dir &&
>> +       git sparse-checkout set sub/dir/ &&
> 
> Is this change necessary?

No, it is not. Thanks.

-Stolee
