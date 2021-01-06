Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A9C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 02:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494B522CE3
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 02:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbhAFCVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 21:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbhAFCVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 21:21:04 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BDC061387
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 18:20:24 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id f132so1861218oib.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 18:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l72tD0nYTkpvIqhl5dBqfzQzdzbZZBWXybEpcpnVUH0=;
        b=R4/woDBo3C6cgKxImmOsghWfQxgeP1GdspNtl8SgZWeQw/4FUnW9pt48pMM6cbk3+f
         V6uT0AIl8VRqTJYt0DHvcIxs94HOgVDT6h79+6p2boxJIl1bUgQYhE0nMwRwi1u4z/CR
         4rM5ffeHAj948vQfvMRqb6qRM5V/oZOmUFdnR34dSRUJImY3GZxZsnysmk5nIqqK91Yc
         O2A7zwAa9QcIzF4SYC/IJMUaqm5yxovN3LMCKOlySjlBAbXCJKOL0reMgWSUAyyun/Ee
         zSLt8pmm/IMBr+XYXLYGHXLdZsYsXa6awxWrymHEYVTUOLVF5PGcZOOXKGGgta5LdbW4
         EeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l72tD0nYTkpvIqhl5dBqfzQzdzbZZBWXybEpcpnVUH0=;
        b=KXk/6nBUP6Jf0qS23DQvlcEPVmq1DR410H9cGa4m2AtTGCKe7XyMKdiLaLWdb/nAx/
         WHm7TktCeP4zfgX67ep9VgKKjH+/RNsg/CmSv4Rtz/g7VnrqC7LExEvWfbbclJuH2tfo
         mcoEAUXvjfOfPRa4XHpI+RrrINaL9QYPSZ336ZXIwpfokbxUCVL3ohP6D7nerjMnCwhz
         boJKaH89uba29akCW/R4evwAwG8acJLwnPiy/aW5edN32ksIfGM6cf0tJuSmwYj3YL7T
         F+DomvE3pnZKCwcdA8z/Bp9hjwsUV9djxYCr9j4z6hFG22dZNTmhG4uUt61p2EpOyNdq
         JxPg==
X-Gm-Message-State: AOAM5328c8ghuMNE1ArXV+ybEN1P2x7B/PAhnFTZjcvg96EKysXQWlmk
        mDRbN50w/xERtFVaG/cf9QuOnaXqnqo=
X-Google-Smtp-Source: ABdhPJxkzG4a0pji0O9/YpbNQJw/N4WJDn9lXfy+UYtKIQeSxXkeByvQxvw56rbQmcqMp3bwCzfrWA==
X-Received: by 2002:aca:5493:: with SMTP id i141mr1823738oib.82.1609899623294;
        Tue, 05 Jan 2021 18:20:23 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t26sm244816otm.17.2021.01.05.18.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 18:20:22 -0800 (PST)
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
Date:   Tue, 5 Jan 2021 21:20:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/5/2021 12:55 PM, Eric Sunshine wrote:
> On Tue, Jan 5, 2021 at 9:44 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> 'git for-each-repo --config=X' should return success without calling any
>> subcommands when the config key 'X' has no value. The current
>> implementation instead segfaults.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
>> @@ -51,6 +51,9 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>>         values = repo_config_get_value_multi(the_repository,
>>                                              config_key);
>> +       if (!values)
>> +               return result;
> 
> Probably not worth a re-roll, but the above has higher cognitive load than:
> 
>     if (!value)
>         return 0;
>
> which indicates clearly that the command succeeded, whereas `return
> result` makes the reader scan all the code above the conditional to
> figure out what values `result` could possibly hold.

True. Looking at this again, it might be better to just update the
loop to be

	for (i = 0; values && i < values->nr; i++) {

which would run the loop zero times when there are zero results.
 
>> diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
>> @@ -27,4 +27,8 @@ test_expect_success 'run based on configured value' '
>> +test_expect_success 'do nothing on empty config' '
>> +       git for-each-repo --config=bogus.config -- these args would fail
>> +'
> 
> The `these args would fail` arguments add mystery to the test,
> prompting the reader to wonder what exactly is going on: "Fail how?",
> "Is it supposed to fail?". It might be less confusing to use something
> more direct like `nonexistent` or `does not exist`.

I guess the point is that if we actually did try running a subcommand
on a repo (for instance, accidentally running it on the current repo)
then the command would fail when running "git these args would fail".

To me, "nonexistent" or "does not exist" doesn't adequately describe
this (hypothetical) situation.

Perhaps "fail-subcommand" might be better?

-Stolee

