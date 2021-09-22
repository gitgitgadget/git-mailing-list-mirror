Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594EE60F9D
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhIVTRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbhIVTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:17:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB557C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:16:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c7so13694199qka.2
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+OOr4ua7UFsA1pvLqjIjuBd49/DEZxqp8dvLqftvjNY=;
        b=VPqu+qPYRs/Uro4JKQEEULTrR3rOqiE2slZ7legpR80swfTzaQh4wpln1bpGr/J31N
         zADPnO1TylZbmzDJq6bDWKcVKiwgGnX3MYUoeoezQnRs0CcMLWKIuIZjYg4VxK0XoZQA
         pBwXxwSx1n1knaIC6m/i3sgKu7Qwi01NOuvzGPg0qP+/wd1Qj3bnWA94KbNBiFg/iSwk
         2sT4w8yZ6nqsmdZHR+H1DNzr0ECt3NF9HygbuOvPkz9sciil4NaCOQJgt41JjKEtRxaN
         RRgspa6L+qYvOBCIqKAfDR/2NIyuWYQLZ/d55ftjCvxMmEnl9REgpv7YnhVh17rSqMl1
         zkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+OOr4ua7UFsA1pvLqjIjuBd49/DEZxqp8dvLqftvjNY=;
        b=LFKMChH4mSt9z14px7ZLbgzeceKi3l3ZKuX+nWmxKnlkdiIdIy3UoCoAbmDxDJ7Deg
         2zHH7UnC8/inQygXKYqWMmU2XYRnfMKtgbtzpPxNJRHozZGqYhuHt/3rRTNB0KsxR4Rh
         kWjJ8D5syQx0B7Aef4r98z6edIC5ZTQVNXS79A+SpRsTiw70XnSkU5luMrgV0ufizt7v
         RV85oqCimcqslntYJAGF6kaSCDrORcNtGFOmExQN6bPrTdyJed6wEHaL+AlUC95Hd907
         DzleMtCYTs1rUUxRrKFChjVbQfnMxTxeZi9S0qx5mSaKQCTNbKoGKPYnDrsoSbS4Db7B
         ToVQ==
X-Gm-Message-State: AOAM5307rIKPO7Xnp9c9x2e+tyRZuFIEivca3jm0aOp2Cj9eDAz/cYG3
        ZHqNhR5snY77zMvDLGxJzMuB6VvpH9192Q==
X-Google-Smtp-Source: ABdhPJxWPKnv2rVehDakTCgn36Xm82+qljyHxzSAUjEKtuIAduHCmzTjfEMqzGbHlg7nkjv2IJBD7w==
X-Received: by 2002:a37:9bd2:: with SMTP id d201mr928477qke.456.1632338183622;
        Wed, 22 Sep 2021 12:16:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1050:2d75:332d:7141? ([2600:1700:e72:80a0:1050:2d75:332d:7141])
        by smtp.gmail.com with ESMTPSA id y11sm2095682qtm.27.2021.09.22.12.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 12:16:23 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
References: <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
 <YUj7GN/qWhw67jyk@nand.local>
 <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
 <YUoJGV0wj0ba7n8X@nand.local>
 <3c9af4e9-f3db-99af-d875-fb11bc8a643e@gmail.com>
 <YUpEX7mmZ0WPvbYK@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98bd3b94-eb8d-b074-b89d-d86dcefaa995@gmail.com>
Date:   Wed, 22 Sep 2021 15:16:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUpEX7mmZ0WPvbYK@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2021 4:45 PM, Taylor Blau wrote:
> On Tue, Sep 21, 2021 at 02:56:01PM -0400, Derrick Stolee wrote:
>>> I thought that it might have been related to your third patch to change
>>> how bad patterns are detected. But I ran the following script after
>>> applying each of your three patches individually:
>>>
>>>     rm -fr repo
>>>     git init repo
>>>     cd repo
>>>
>>>     git sparse-checkout init
>>>     git sparse-checkout add foo
>>>     git sparse-checkout init --cone
>>>     git sparse-checkout add foo
>>>
>>> and the only difference is that we started silently dropping the bad
>>> "foo" pattern after re-adding foo in cone-mode starting with the second
>>> patch.
>>
>> In patch 2, we "detect" that the old patterns were not in cone mode
>> because the core.sparseCheckoutCone config is false when parsing the
>> patterns, so use_cone_patterns is 0.
> 
> I fear that we're talking about different things. With your patches, if
> I munge my .git/info/sparse-checkout file, I can easily get something
> like:
> 
>   $ git.compile sparse-checkout list
>   warning: unrecognized pattern: 'foo'
>   warning: disabling cone pattern matching
> 
> to appear. But I'm wondering why the same doesn't happen when running
> `git sparse-checkout init --cone` while the existing sparse-checkout
> definition contains non-cone mode entries.

You don't get that warning because it's not trying to parse the
previous patterns using cone mode. Before my series, you would get
the warning in a _second_ run of "git sparse-checkout init --cone".

We should add a different warning for overwriting the existing
patterns.

Thanks,
-Stolee
