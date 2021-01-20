Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23C0C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653C3233EB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbhATTXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbhATTXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:23:20 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00CC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:22:36 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id bd6so11441555qvb.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N4BZ0FrhUsgJkBDJwCR/n7JtCBEAGeuvhAj/MwJTYFM=;
        b=AOic/p/34k/vZn8QRmSQrvXcwHtIIfLgJIjJDYkvMI5wtUPx3aabBhwc8BgtNWsEI+
         nTvimraHSkvZc7GEMowg5V8FJVSIxh29jYx+oeD10CPC6iLmzWKzLj7k7HUDjHJU5gvb
         LDlwtQhaMLHM1uwPBJHQhlqsxxVKjzNrb1Nq0Yy3soC4zkWgUISXOJV8zzSRy0RkjdjD
         tiXuYuAwHO/5b8pGLo4R3WItppqPW9iHGa1HI4C5qbkr4yhLbTQehDY/6HRTcyX/gkC/
         gWo5pwONbQ1ERfffs8v7heg+CnMfKKFUAHG3YoGt1dtQ0AZRSaB4q7hYbXMncHSPhwbJ
         klpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N4BZ0FrhUsgJkBDJwCR/n7JtCBEAGeuvhAj/MwJTYFM=;
        b=m/Hb9UC4ImBDuxVLGWmWkrCODWp7Zw+YAlz8Az7jDRqeoZ+eiIt/y2MOBx3zW24X0j
         hGE6tjZl9PKpP6zBB1/pvkmi6J5KPBqpXDQkl840UvpBnZWUnm5rH5tJM68rjXAKN4iM
         GHJAo/qhTmmAeeEKeZnsiaNoh+XIh4cx23CDcYjvSF5jIbJZk4R42PY3ITkvj6SuBY2s
         fkA9BK4p1dzrOiK7pPOKntJ89+YhNiHrECrQSwp6YuRQG2hmadx11DcyRTQ7Nn9Z+g3k
         oDNB83EhuVq1Di8ERSItLY1TVHiK8DBgQUMO/v++QOqs60ZwCDgo/e37JsajHJ2vEugd
         pedw==
X-Gm-Message-State: AOAM533mOJykWlWi5KMII+FhkxhqWRG1Kj627XLBsMRSuBaK95zJwk1a
        TS7yw2IMk0JnPPR4afwdYfM=
X-Google-Smtp-Source: ABdhPJz30caDWfjzSDre/JF55Wep+W1CsbThIKrJMzjf530oganw6UL0fom4M2ixjOJk0apaKIC9rQ==
X-Received: by 2002:a0c:ac43:: with SMTP id m3mr10722461qvb.37.1611170554827;
        Wed, 20 Jan 2021 11:22:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id y15sm1781467qto.51.2021.01.20.11.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:22:34 -0800 (PST)
Subject: Re: [PATCH 7/9] sparse-checkout: hold pattern list in index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <91344f5108c835a48b2460b9de75c489045b9cce.1611161639.git.gitgitgadget@gmail.com>
 <CABPp-BEeDj4v4t8w6giy-yo8ET0mnD3es95aGQJvw7g8_jkjzA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fb1800fb-474a-e20b-5596-6bb3bc22fe99@gmail.com>
Date:   Wed, 20 Jan 2021 14:22:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEeDj4v4t8w6giy-yo8ET0mnD3es95aGQJvw7g8_jkjzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2021 1:03 PM, Elijah Newren wrote:
> On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> As we modify the sparse-checkout definition, we perform index operations
>> on a pattern_list that only exists in-memory. This allows easy backing
>> out in case the index update fails.
>>
>> However, if the index write itself cares about the sparse-checkout
>> pattern set, we need access to that in-memory copy. Place a pointer to
>> a 'struct pattern_list' in the index so we can access this on-demand.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  builtin/sparse-checkout.c | 17 ++++++++++-------
>>  cache.h                   |  2 ++
>>  2 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 2306a9ad98e..e00b82af727 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -110,6 +110,8 @@ static int update_working_directory(struct pattern_list *pl)
>>         if (is_index_unborn(r->index))
>>                 return UPDATE_SPARSITY_SUCCESS;
>>
>> +       r->index->sparse_checkout_patterns = pl;
>> +
>>         memset(&o, 0, sizeof(o));
>>         o.verbose_update = isatty(2);
>>         o.update = 1;
>> @@ -138,6 +140,7 @@ static int update_working_directory(struct pattern_list *pl)
>>         else
>>                 rollback_lock_file(&lock_file);
>>
>> +       r->index->sparse_checkout_patterns = NULL;
>>         return result;
> 
> The setting back to NULL made me curious; we don't want this
> information to remain available later?  Is it only going to be used
> for the updating of the working directory?
> 
> I dug a bit into the callers, and didn't find the answer to my
> question...but I did notice that modify_pattern_list() will correctly
> free the patterns after write_patterns_and_update() via calling
> clear_pattern_list(&pl), but sparse_checkout_init() appears to leak
> the patterns it allocates.  That's a separate issue from this patch,
> but do you want to fix that up while working in this area (so I avoid
> stepping on your toes with all your other patches)?

The thing that caught me here is that update_working_directory() uses
an in-memory pattern_list that hasn't been committed to the
sparse-checkout file yet. This means we need to (temporarily) point
to this pattern_list.

Perhaps this patch is premature, since nothing actually _uses_
sparse_checkout_patterns yet. When we do add such a use, it will
initialize a NULL value with the patterns in the sparse-checkout
file. In that case, we definitely want to inject our in-memory
patterns instead.

Thanks,
-Stolee
