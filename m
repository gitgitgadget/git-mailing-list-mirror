Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD237C004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 19:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjAUT0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 14:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjAUTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 14:25:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C22A147
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 11:25:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id rl14so18300099ejb.2
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 11:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2pfQ0neOD1hSfd0H5qKdT9J51tgZunPaKyPRIoew+A=;
        b=EidYaeIkTxcdLQWBVCcwiFEyCpJcw/yCJx/wK8+RENWJmDOqna+0JTvtdRazqo5o9+
         Zc0Ko1yevE1EPpV7xiya7qDlZIkOgYtcx9R/Q+ZL06Bwna6fJDjjX9usUD7PITM0TPf0
         N+ZiNqcAD1maGPxw30CwL43GnA1WtLvAOEkvoamCNa1hrcGljcdhXYTr0i0l83oOdKFM
         75ec8YpaqHau0dvS028+FaX2zkQWlwCSguf3RCi/0nwKrzqxyqXaKxjCrdW5xX0dhgzT
         EfJKAYhGxiX2aHdRvSj835dULcA2m2Q7AdpGpJ8DOsDLl5F/Y/EzpIkEUbbdh+c3laVg
         gFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2pfQ0neOD1hSfd0H5qKdT9J51tgZunPaKyPRIoew+A=;
        b=CefVpBIi6ToJa1Ra5dm7I4TkdJF6ySrE0bjDdRpNm/Nj+dH3AOZ+LIMRQW/0tyM7IN
         lvPuHvNVApM2ib477FNg8oviNR9sUTPifxTfVvITyuGk1XZrrNGXO7Xtao4vZblLvmIj
         MLYSakrNn7pjkt8KxlCzu45csY0gD9DNhyCt6tDQa+DzFkU+b9JRhINTB+WbFL7nu3Ni
         +oQBYe41pg4C6u/OTJggbcHeEqSjJyMMKYH8bdj/SBM8K2ddPwqfdoN1EzAiwGApJJV2
         H2W7LAzsryr8jubwquUAONq4XkDHhlTM0LQVqtt3ZdTg5V2PLDfbfL3mOKj9Wbc60xxG
         oV4g==
X-Gm-Message-State: AFqh2kq930sxuqTfjUfoxAQZnYLrnmW2fGrfBmDMAXMCOkchKYeUaql+
        FGRwyLbYcCzsgCoUW2tA/Yo=
X-Google-Smtp-Source: AMrXdXuq01AB/4rMCt/AWbtJkguzqpZdX6nLg3OpDBtU7bBThnunhiQFFDBLZ6t2IL9Lv7jcsjbavg==
X-Received: by 2002:a17:906:7e1a:b0:86d:30ca:ec27 with SMTP id e26-20020a1709067e1a00b0086d30caec27mr18399673ejr.13.1674329152799;
        Sat, 21 Jan 2023 11:25:52 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906314f00b007bd1ef2cccasm19533963eje.48.2023.01.21.11.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 11:25:52 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <20e759bd-7d13-b7ba-c0df-69b4f827c5bd@dunelm.org.uk>
Date:   Sat, 21 Jan 2023 19:25:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/7] rebase: add coverage of other incompatible options
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
 <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <48c40c0dda00eeb8b9bdc5ba9372b46964eea14a.1674266126.git.gitgitgadget@gmail.com>
 <d5ef5870-baac-14d4-65a5-deb94a848011@dunelm.org.uk>
In-Reply-To: <d5ef5870-baac-14d4-65a5-deb94a848011@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/01/2023 15:20, Phillip Wood wrote:
>> @@ -1238,6 +1238,17 @@ int cmd_rebase(int argc, const char **argv, 
>> const char *prefix)
>>           if (options.fork_point < 0)
>>               options.fork_point = 0;
>>       }
>> +    /*
>> +     * reapply_cherry_picks is slightly weird.  It starts out with a
>> +     * value of -1.  It will be assigned a value of keep_base below and
>> +     * then handled specially.  The apply backend is hardcoded to
>> +     * behave like reapply_cherry_picks==1,
> 
> I think it is hard coded to 0 not 1. We generate the patches with
> 
>      git format-patch --right-only $upstream...$head

Sorry I somhow managed to omit --cherry-pick from that, it should have been

	git format-patch --right-only --cherry-pick $upstream...$head

Phillip


> so cherry-picks will not be reapplied. I'm hardly an impartial observer 
> but I think the current check is correct. We support
> 
>      --whitespace=fix --no-reapply-cherry-picks
>      --whitespace=fix --keep-base --reapply-cherry-picks
> 
> but not
> 
>      --whitespace=fix --reapply-cherry-picks
> 
>> @@ -1525,6 +1529,9 @@ int cmd_rebase(int argc, const char **argv, 
>> const char *prefix)
>>       if (options.update_refs)
>>           imply_merge(&options, "--update-refs");
>> +    if (options.autosquash)
>> +        imply_merge(&options, "--autosquash");
> 
> Thanks for adding this, it maybe merits a mention in the commit message 
> though as it is a change in behavior for users who have 
> rebase.autosquash set and try to use the apply backend.
> 
> Best Wishes
> 
> Phillip
> 
>>       if (options.type == REBASE_UNSPECIFIED) {
>>           if (!strcmp(options.default_backend, "merge"))
>>               imply_merge(&options, "--merge");
>> diff --git a/t/t3422-rebase-incompatible-options.sh 
>> b/t/t3422-rebase-incompatible-options.sh
>> index f86274990b0..c830025470f 100755
>> --- a/t/t3422-rebase-incompatible-options.sh
>> +++ b/t/t3422-rebase-incompatible-options.sh
>> @@ -50,6 +50,11 @@ test_rebase_am_only () {
>>           test_must_fail git rebase $opt --strategy-option=ours A
>>       "
>> +    test_expect_success "$opt incompatible with --autosquash" "
>> +        git checkout B^0 &&
>> +        test_must_fail git rebase $opt --autosquash A
>> +    "
>> +
>>       test_expect_success "$opt incompatible with --interactive" "
>>           git checkout B^0 &&
>>           test_must_fail git rebase $opt --interactive A
>> @@ -60,6 +65,21 @@ test_rebase_am_only () {
>>           test_must_fail git rebase $opt --exec 'true' A
>>       "
>> +    test_expect_success "$opt incompatible with --keep-empty" "
>> +        git checkout B^0 &&
>> +        test_must_fail git rebase $opt --keep-empty A
>> +    "
>> +
>> +    test_expect_success "$opt incompatible with --empty=..." "
>> +        git checkout B^0 &&
>> +        test_must_fail git rebase $opt --empty=ask A
>> +    "
>> +
>> +    test_expect_success "$opt incompatible with 
>> --no-reapply-cherry-picks" "
>> +        git checkout B^0 &&
>> +        test_must_fail git rebase $opt --no-reapply-cherry-picks A
>> +    "
>> +
>>       test_expect_success "$opt incompatible with --update-refs" "
>>           git checkout B^0 &&
>>           test_must_fail git rebase $opt --update-refs A
