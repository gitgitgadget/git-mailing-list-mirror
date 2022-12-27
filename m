Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E26C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 17:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL0RN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 12:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiL0RNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 12:13:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7463BE24
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 09:13:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so9742939wms.4
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdUtnF9FGxxkCePG2AiOhBdwNNdEu0qsnloWHY9mZyw=;
        b=Wx8w3KbxN3Lidd9SZ//jxsh8VX/cJKD1xRzon/xAl98BWgbogQlEVUVRulF7E2WEWi
         BsWqBozFHwKPCrpTyFufBhXrAROijXau2GD+B5YrrdrS5oLLcjArEDwi357puDoYOd09
         UoSJDvM8Mtr8G/s2thYQegzjXgDaQJGa7rKls6HxoLG56CoIzk7YuVOi3az7x/HGLzLk
         uah9DqOEHozma3AjdNurQyYHjsws1Lt6dzc+K4qX0t2Z/rIuftPsBi4a0XutFoL/8ita
         /kHTFwSrilKvuxcMJvR0q//kiZuGrqB+ATFRUNdQ/DBthb9xnjFPWpqHfQYLqFFUmoFS
         Io6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdUtnF9FGxxkCePG2AiOhBdwNNdEu0qsnloWHY9mZyw=;
        b=A6tGBXnpey93iTiFBKLYlZmRTWcSqwL7SHjGNfGXOrcrQob+t6tW1ocPziqM0Atel+
         QMhZDOM6sQVGn/Rr4KgRxVMnknTzquab6XKRmPlK94zk3WJp7ZuxO77CZYmDF8rhNu65
         RmtT8GfMIauF7dYAGCiOAwplrp9ZfQlBHgQ1Yv9Hp0nRNbiKQ0hAjVmyeh4B6KafSgD6
         DZNjmTW3hvDnx3da7BZ1Bv4jv05OygwK3jDWduldnV/0T0eHTWLZikIzA4a1M0+1rrGw
         rHhv6fahXSs+4CTW10ZttTvUH6MyPDvgI6N6yPy3/tQj7BvxOTCShhqzJT1UNUoAdfrB
         8MTQ==
X-Gm-Message-State: AFqh2kpPFb8797Vcqx7Wfz9jQgC82TIbUaitOavGG1T06vfyDGDTsLlW
        Mn/RywkcEPH/P6nBQEXXARM=
X-Google-Smtp-Source: AMrXdXtmoBdmgdXsaGwYipxNFpVstdkSA+4RWQTFmbuam75ALWfT2kKDWSfO2cO9+eRk1ku3SAZnWQ==
X-Received: by 2002:a05:600c:1d0e:b0:3cf:7c8b:a7c7 with SMTP id l14-20020a05600c1d0e00b003cf7c8ba7c7mr15499941wms.39.1672161232282;
        Tue, 27 Dec 2022 09:13:52 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c5453000000b003d2157627a8sm22047547wmi.47.2022.12.27.09.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 09:13:51 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <2f41ce2e-cc6e-815e-9744-ea4e5c659b35@dunelm.org.uk>
Date:   Tue, 27 Dec 2022 17:13:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/6] tests: don't lose "git" exit codes in "! ( git ...
 | grep )"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
 <0825da46-b659-d18c-6e65-ced6ce85bd29@dunelm.org.uk>
In-Reply-To: <0825da46-b659-d18c-6e65-ced6ce85bd29@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/12/2022 16:44, Phillip Wood wrote:
> On 19/12/2022 10:19, Ævar Arnfjörð Bjarmason wrote:
>> - For "t3700-add.sh" use "sed -n" to print the expected "bad" part,
>>    and use "test_must_be_empty" to assert that it's not there. If we used
>>    "grep" we'd get a non-zero exit code.
>>
>>    We could use "test_expect_code 1 grep", but this is more consistent
>>    with existing patterns in the test suite.
> 
> It seems strange to use sed here, you could just keep using grep and 
> check the output is empty if you don't want to use test_expect_code.

Sorry ignore that, using 'sed -n' means we don't have to worry about the 
exit code.

> There is also no need to redirect the input of the sed commands.
> 
> Best Wishes
> 
> Phillip
> 
>>    We can also remove a repeated invocation of "git ls-files" for the
>>    last test that's being modified in that file, and search the
>>    existing "files" output instead.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>   t/t0055-beyond-symlinks.sh | 14 ++++++++++++--
>>   t/t3700-add.sh             | 18 +++++++++++++-----
>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
>> index 6bada370225..c3eb1158ef9 100755
>> --- a/t/t0055-beyond-symlinks.sh
>> +++ b/t/t0055-beyond-symlinks.sh
>> @@ -15,12 +15,22 @@ test_expect_success SYMLINKS setup '
>>   test_expect_success SYMLINKS 'update-index --add beyond symlinks' '
>>       test_must_fail git update-index --add c/d &&
>> -    ! ( git ls-files | grep c/d )
>> +    cat >expect <<-\EOF &&
>> +    a
>> +    b/d
>> +    EOF
>> +    git ls-files >actual &&
>> +    test_cmp expect actual
>>   '
>>   test_expect_success SYMLINKS 'add beyond symlinks' '
>>       test_must_fail git add c/d &&
>> -    ! ( git ls-files | grep c/d )
>> +    cat >expect <<-\EOF &&
>> +    a
>> +    b/d
>> +    EOF
>> +    git ls-files >actual &&
>> +    test_cmp expect actual
>>   '
>>   test_done
>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index 51afbd7b24a..82dd768944f 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -106,24 +106,32 @@ test_expect_success '.gitignore test setup' '
>>   test_expect_success '.gitignore is honored' '
>>       git add . &&
>> -    ! (git ls-files | grep "\\.ig")
>> +    git ls-files >files &&
>> +    sed -n "/\\.ig/p" <files >actual &&
>> +    test_must_be_empty actual
>>   '
>>   test_expect_success 'error out when attempting to add ignored ones 
>> without -f' '
>>       test_must_fail git add a.?? &&
>> -    ! (git ls-files | grep "\\.ig")
>> +    git ls-files >files &&
>> +    sed -n "/\\.ig/p" <files >actual &&
>> +    test_must_be_empty actual
>>   '
>>   test_expect_success 'error out when attempting to add ignored ones 
>> without -f' '
>>       test_must_fail git add d.?? &&
>> -    ! (git ls-files | grep "\\.ig")
>> +    git ls-files >files &&
>> +    sed -n "/\\.ig/p" <files >actual &&
>> +    test_must_be_empty actual
>>   '
>>   test_expect_success 'error out when attempting to add ignored ones 
>> but add others' '
>>       touch a.if &&
>>       test_must_fail git add a.?? &&
>> -    ! (git ls-files | grep "\\.ig") &&
>> -    (git ls-files | grep a.if)
>> +    git ls-files >files &&
>> +    sed -n "/\\.ig/p" <files >actual &&
>> +    test_must_be_empty actual &&
>> +    grep a.if files
>>   '
>>   test_expect_success 'add ignored ones with -f' '
