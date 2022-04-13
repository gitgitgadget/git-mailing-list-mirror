Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3141C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiDMT4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbiDMTzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:16 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB257C788
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:31 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-de3eda6b5dso3166266fac.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+ZanESfOidvmtBtvm8xDYOQCg4i5tAoD3br9e1XKSmE=;
        b=GGkn9X+U7VhqagiooXvm0VZxuScXGKTXO67MbzKaIL6R5Scrvfp5NxQfY4ZkFyADEx
         CBbkYL8/ZtcfpGWvDRfTAADAuGRay+oXc2H+gm1PoIm8jwQaS4cGJAKA9Z/eKziE4YZa
         t8980aJ7qfJEABZnDfLOq8j7cYhOZjVaGkzhe3cXxrGGv+HQZ7B+mp6xs0lvk8g5mXC2
         fEqTPb266jQ0fpLY+iZYI2+PwcmZstDhJrtri+tjYbCTPTgcK1VewxKvvW9S6f/Wf9Am
         Zk837SK1vgwGJ3Qm3AzA18rtna16MY8xI0UUV9a1jtxny0zkXRWYNYeM4KcSRZww+MHg
         rEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ZanESfOidvmtBtvm8xDYOQCg4i5tAoD3br9e1XKSmE=;
        b=Budh2gfPBHceX0bVaknXwALOS/X1V4Ie3jHHjeMOU6CeT7a4mnbbqYKZZHADfWvcu/
         byhROSh5zvF473RB/YtUNzXT8bxskoFngDsFb7S61RP8QfCoN/3Ogr8zki4/QSeIMBwp
         h/q+CoapvwLp/3PFoF6z/3Jcg3wIM/rX47GRoQfrCqONA1ZM4oB3tluSLfmQJlzL72qg
         ibGVPcsS2kJxEs9rBwK2+jzcXwkkRheWikeOvjdyKYrUrgd9+ZPtMIFX6KsDJbn6i/dD
         Jlu4lqT6HiW78gXW10ALRpB3SEP0l0aBYeOHuvJpHrXpcydXFIzajmC3xXV/nHF3MTWB
         SIdA==
X-Gm-Message-State: AOAM532EIM948EHuHCXSThvRXAW0zOplb6k0dJLjWnQ/G/7zOAYeg0CN
        cUXHcfUD5VQ8VmJGGwPWtjXV
X-Google-Smtp-Source: ABdhPJy1dYj4SjVb2c+/Sl6IXb8TjDryKLTGisCwcWSQRibscSJMM/ucFKI0PPdXUlxiVeBIK8BPlw==
X-Received: by 2002:a05:6870:3112:b0:ce:c0c9:62b with SMTP id v18-20020a056870311200b000cec0c9062bmr149056oaa.125.1649879550763;
        Wed, 13 Apr 2022 12:52:30 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d2903000000b005cda765f578sm14819674otb.0.2022.04.13.12.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 12:52:30 -0700 (PDT)
Message-ID: <6b778cfe-2549-854a-7b77-58f815412ca1@github.com>
Date:   Wed, 13 Apr 2022 15:52:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] t0033: add tests for safe.directory
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        johannes.schindelin@gmx.de
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
 <220413.86k0bseqq8.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220413.86k0bseqq8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2022 3:16 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 13 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> It is difficult to change the ownership on a directory in our test
>> suite, so insert a new GIT_TEST_ASSUME_DIFFERENT_OWNER environment
>> variable to trick Git into thinking we are in a differently-owned
>> directory. This allows us to test that the config is parsed correctly.
> 
> I think this is a good trade-off, but FWIW I'd think we could test also
> without the git_env_bool() by having the test depend on !NOT_ROOT, then
> check the owner of t/test-lib.sh, and chown to that user (i.e. the
> "real" user).
> 
> But that's all sorts of more fragile than just this test variable..
>> +test_description='verify safe.directory checks'
>> +
>> +. ./test-lib.sh
>> +
>> +GIT_TEST_ASSUME_DIFFERENT_OWNER=1
>> +export GIT_TEST_ASSUME_DIFFERENT_OWNER
> 
> Instead of this "export" perhaps just add it in front of the "git
> status"?

If the only runs were in this helper below, then yes.

>> +expect_rejected_dir () {
>> +	test_must_fail git status 2>err &&
>> +	grep "safe.directory" err
>> +}

Later patches add more success cases that run 'git status'
as its verification that the match works. I didn't think it
was good to have this environment variable set for each of
those invocations.

This script has one purpose, and this environment variable
is required to make any of the checks work. Setting it
globally seems the best way to do that.

>> +test_expect_success 'safe.directory matches' '
>> +	git config --global --add safe.directory "$(pwd)" &&
> 
> nit: $PWD instead of $(pwd)

Historically, $PWD doesn't work properly across platforms,
so I have used $(pwd) consistently across many contributions.

Thanks,
-Stolee
