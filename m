Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D575C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 14:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjA0Oqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 09:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjA0Oqv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 09:46:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E8782427
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 06:46:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5584879wmq.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJml04ZqNG95JVc8dedZTN2kTgbpYUtpCVWa9zgQZPI=;
        b=EsyvQ8sJmKJNT0RIFm5A/s+SZmrwBtvkg19uAf9AL7zuDEPOkyn6bJL0CU2LlMUOS1
         Z2MbQeMcWU2q19UPq7sgSIgmxOzgkvIDvd5/RCGqjwlmdQ45qNvkUpgj5netZxbvbWcz
         EvLAcgy6Lj5BNWHIdGTGfnc9NpSQ7k/XtROgKLZ12UCb8LDOXlKpwGsJV4BWMFl+znww
         kxdDqXhl0QGCYag/AaIiWLGS4DS/mnoKOp36vOPA3diyWXHJzzE9XXtLGhFMTUgNIDrK
         xMSB+HLSqaW9b5zXteAVrS4qrYikD979VDXrIvxgbFWh+nLcGj78GMJZBxBF0k8EvSVs
         CSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJml04ZqNG95JVc8dedZTN2kTgbpYUtpCVWa9zgQZPI=;
        b=rCTxoUchB89rEIhj3jJ+Xyl1eEp+ieUbKFHa+eeZNVn+tfZEb3fQKO9qSncDZ4WADN
         mVeNvhrGAMoTHk9DxF6eISV0uuMpyKSvr+LK47VxEgN6CcM7w27ZpT/M3hP/GoOeSlxy
         ZAGxaK66czT7vGmUHfWdWkR8na3Q3opFVXcRkEasnGIdQID/V6sc6ZubGcoGy7RXZxAr
         MW4jxh1vw3/rX/y8g/xVgrNel/RozjOQgHBmSmutH9Sxtg1SDkL5YE8uMWmw1viUa8eY
         zOyaQZe/zu0FsM0cT06ZBJL5O4/hYmZK1BED61HEhzFD+D3hJOXLxPhZ1DNDnjYtHRNQ
         LiyQ==
X-Gm-Message-State: AFqh2krzCiBXo8BXW8VZmT4YtDRcn8BMIG8v2wm9/5LL9Z6gKMa2XnfR
        AF8Ft2MjLPEaplT2RN+AzsE=
X-Google-Smtp-Source: AMrXdXvXCfsYYLVOYpew2k5NINnrhI4Rfq7Usjamtrwi8DBBoLwelx+2zUrqBZiRFtxOzpVgTe9BzA==
X-Received: by 2002:a05:600c:3c86:b0:3da:2a59:8a4f with SMTP id bg6-20020a05600c3c8600b003da2a598a4fmr40431709wmb.38.1674830807128;
        Fri, 27 Jan 2023 06:46:47 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003daf7721bb3sm7475443wmi.12.2023.01.27.06.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 06:46:46 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a848b7d5-fd40-b043-7ed9-1672f65312e6@dunelm.org.uk>
Date:   Fri, 27 Jan 2023 14:46:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch in
 multiple worktrees
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20230119055325.1013-1-carenas@gmail.com>
 <20230120113553.24655-1-carenas@gmail.com>
 <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk>
 <CAPUEspjuXSncRxo5DMj1pA5zcYvn4Y6epdijYL6HJRGhk_6q7g@mail.gmail.com>
In-Reply-To: <CAPUEspjuXSncRxo5DMj1pA5zcYvn4Y6epdijYL6HJRGhk_6q7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 20/01/2023 22:12, Carlo Arenas wrote:
> On Fri, Jan 20, 2023 at 7:08 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 20/01/2023 11:35, Carlo Marcelo Arenas Belón wrote:
>>> Commands `git switch -C` and `git checkout -B` neglect to check whether
>>> the provided branch is already checked out in some other worktree, as
>>> shown by the following:
>>>
>>>     $ git worktree list
>>>     .../foo    beefb00f [main]
>>>     $ git worktree add ../other
>>>     Preparing worktree (new branch 'other')
>>>     HEAD is now at beefb00f first
>>>     $ cd ../other
>>>     $ git switch -C main
>>>     Switched to and reset branch 'main'
>>>     $ git worktree list
>>>     .../foo    beefb00f [main]
>>>     .../other  beefb00f [main]
>>>
>>> Fix this problem by teaching `git switch -C` and `git checkout -B` to
>>> check whether the branch in question is already checked out elsewhere.
>>>
>>> Unlike what it is done for `git switch` and `git checkout`, that have
>>> an historical exception to ignore other worktrees if the branch to
>>> check is the current one (as required when called as part of other
>>> tools), the logic implemented is more strict and will require the user
>>> to invoke the command with `--ignore-other-worktrees` to explicitly
>>> indicate they want the risky behaviour.
>>>
>>> This matches the current behaviour of `git branch -f` and is safer; for
>>> more details see the tests in t2400.
>>
>> As I said before, it would be much easier for everyone else to
>> understand the changes if you wrote out what they were rather than
>> saying "look at the tests". I do appreciate the improved test
>> descriptions though - thanks for that.
> 
> Apologies on that, I tried to come up with something that would
> describe the change of behaviour other than the paragraph above and
> couldn't come out with a better explanation except reading the tests
> (which I know is complicated by the fact they are interlinked).
> 
> The behaviour I am changing is also not documented (other than by the
> test) and might have been added as a quirk to keep the scripted rebase
> and bisect going when confronted with branches that were checked out
> in multiple worktrees, and as such might had not be intended for
> `switch`, and might not be needed anymore either.
> 
> Using`checkout` for simplicity, but also applies to `switch`,
> 
>    % git worktree list
>    .../base  6a45aba [main]
>    % git worktree add -f ../other main
>    Preparing worktree (checking out 'main')
>    HEAD is now at 6a45aba init
>    % cd ../other
>    % git checkout main
>    Already on 'main'
>    % git checkout -B main
>    fatal: 'main' is already checked out at '.../base'

Thanks for explaining that. If there is no <start-point> given we don't 
reset the branch so it seems a bit harsh to error out here. For "git 
checkout -B <branch> <start-point>" when <branch> is checked out in 
another worktree requiring --ignore-other-worktrees makes sense.

>    % git checkout --ignore-other-worktrees -B main
>    Already on 'main'
> 
> The change of behaviour only applies to -B and it actually matches the
> documentation better.
> 
>>> @@ -1533,13 +1534,13 @@ static int checkout_branch(struct checkout_opts *opts,
>>>        if (!opts->can_switch_when_in_progress)
>>>                die_if_some_operation_in_progress();
>>>
>>> -     if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
>>> -         !opts->ignore_other_worktrees) {
>>> +     if (!opts->ignore_other_worktrees && !opts->force_detach &&
>>> +         check_branch_path && ref_exists(check_branch_path)) {
>>
>> I think check_branch_path is NULL if opts->ignore_other_worktrees is set
>> so we could maybe lose "!opts->ignore_other_worktrees" here (or possibly
>> below where you set check_branch_path).
> 
> opts->ignore_other_worktrees was kept from the original expression;
> you are correct that is not needed anymore, but I thought it didn't
> hurt and made the code intention clearer (meaning it is obvious to
> anyone new to the code that this code will be skipped if that flag is
> set), would using an assert or a comment be a better option?

It's a good point that it makes the intention clearer, maybe we should 
just leave it as it is.

>>>        /*
>>>         * Extract branch name from command line arguments, so
>>>         * all that is left is pathspecs.
>>> @@ -1741,6 +1751,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>>>                                             new_branch_info, opts, &rev);
>>>                argv += n;
>>>                argc -= n;
>>> +
>>> +             if (!opts->ignore_other_worktrees && !check_branch_path && new_branch_info->path)
>>> +                     check_branch_path = xstrdup(new_branch_info->path);
>>
>> I'm a bit confused what this is doing.
> 
> The branch we are interested in might come from 2 places, either it is
> a parameter to -b, which was picked up before, or it is the argument
> to the command itself, which was detected above.

Oh, of course. I was so focused on the -b that I'd forgotten we need the 
same check when we're checking out an existing branch - thanks for 
putting me right.

> If both are provided, we want to make sure to use the one from -b, or
> will have the bug you sharply spotted before, which was frankly
> embarrassing.
> 
>>> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
>>> index d587e0b20d..7ab7e87440 100755
>>> @@ -133,17 +136,34 @@ test_expect_success SYMLINKS 'die the same branch is already checked out (symlin
>>>        test_must_fail git -C here checkout newmain
>>>    '
>>>
>>> -test_expect_success 'not die the same branch is already checked out' '
>>> +test_expect_success 'allow creating multiple worktrees for same branch with force' '
>>> +     git worktree add --force anothernewmain newmain
>>> +'
>>> +
>>> +test_expect_success 'allow checkout/reset from the conflicted branch' '
>>
>> I'm not sure what "the conflicted branch" means (it reminds we of merge
>> conflicts).
> 
> by "conflicted" I meant one that is checked out in more than one worktree

I think it would be clearer so say that rather than "conflicted" which 
has a strong association with merge conflicts.

Best Wishes

Phillip
