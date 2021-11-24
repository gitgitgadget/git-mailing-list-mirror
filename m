Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF432C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhKXPNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhKXPNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 10:13:46 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE86C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 07:10:37 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n66so5912589oia.9
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 07:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VgtB2HX9ILURgM/qSpzCtCgJqZvyFaAGXXA114kE2Z4=;
        b=mQzaFTeaZSXtYY2Vqdd9umAfQj2M51ibNoG0J59Zlq6+dZi0lXlKV4VaCGihIGpVB6
         xkBXjhe9QZCyj8SuBXkqoBS6R/9F1CgjPaEHMLe1xny9+zFWZpfJ1I/gEtXxlSudbwFb
         /OUS8iKO+lyW5GYbzEd46CzW7ju/BVCbIYkqyhtdo9CP7YnElz80LGinYwKhrVpaF7Jz
         tk9UOEBZiRdujYj5ixGNAXedbX2UC3nN40ALgobvdQ0w2fVFS7qmd9wzNP3YuYdrSCiv
         WjJIp+TP8EG5fLM1K0NrNdyYjJpIcgZ2ftCHvHivh3fKIocMK5Lwnd/DVcHqUZka5XAT
         MdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VgtB2HX9ILURgM/qSpzCtCgJqZvyFaAGXXA114kE2Z4=;
        b=7T62dXocz3CGi4jr2HsL+QiaHupdnUTbFZVec4HKK0dcP2Aj8f5h9EGT//oV8MmOCb
         TJ3xWVvq7Ycpq9gI5NUlFNfJ0AzLy6UZTb5Vfgty1fMwcMiTmq1iXFwxFxQEKnwiYupq
         0cYbGveIzE7JbZG26tDejPChyFkNLDQiPLbbsfxd1JPjFp9XS3N45j9h64KzZKsbts01
         hpdzwwN8P8wrjGAilbNOWYWBHfpz4SPatgdquiHxpz3PhXhF3ICJDh13DWLWm9kOsuMM
         CcyAdX9/XrdiHP34dqPMAdDHK5sAt1EqydbzYOiBCV5qpizYTRXsc0Gp6DLx+4xv1rq9
         Gw6w==
X-Gm-Message-State: AOAM5320L53uu13gX64xVvev6MXX8JJ68F+be9lmty9FTYtp3nytyLEt
        w4Td4ckfwyUpK7WfiRR9H+s=
X-Google-Smtp-Source: ABdhPJwrNIL7tJDcw/fiQ/CSvNCe8HzRbhjakp6/JjtHuHc6EWqW46Uwi51j9xPnRHPKN1pIWUHiMA==
X-Received: by 2002:aca:eb02:: with SMTP id j2mr6712201oih.3.1637766635170;
        Wed, 24 Nov 2021 07:10:35 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id v20sm8895otj.27.2021.11.24.07.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 07:10:34 -0800 (PST)
Message-ID: <0372ee0b-8dda-c505-2b83-30da74e4fb36@gmail.com>
Date:   Wed, 24 Nov 2021 07:10:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 2/4] test-read-cache: set up repo after git directory
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <5bc5e8465ab5fe871965e6c6d578efc51e55b505.1637620958.git.gitgitgadget@gmail.com>
 <xmqq4k82781w.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqq4k82781w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/23/21 3:42 PM, Junio C Hamano wrote:
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Move repo setup to occur after git directory is set up. This will ensure
>> enabling the sparse index for `diff` (and guarding against the nongit
>> scenario) will not cause tests to start failing, since that change will include
>> adding a check to prepare_repo_settings() with the new BUG.
> 
> This looks obviously the right thing to do.  Would anything break
> because of the "wrong" ordering of events in the original code?
> 
> IOW, can this "bugfix" be protected with a new test against
> regression?
> 
Yep! Tests 2, 3, 28, and 34 in t1092-sparse-checkout-compatibility.sh
will fail without this change.
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   t/helper/test-read-cache.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
>> index b52c174acc7..0d9f08931a1 100644
>> --- a/t/helper/test-read-cache.c
>> +++ b/t/helper/test-read-cache.c
>> @@ -39,8 +39,6 @@ int cmd__read_cache(int argc, const char **argv)
>>   	int table = 0, expand = 0;
>>   
>>   	initialize_the_repository();
>> -	prepare_repo_settings(r);
>> -	r->settings.command_requires_full_index = 0;
>>   
>>   	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
>>   		if (skip_prefix(*argv, "--print-and-refresh=", &name))
>> @@ -56,6 +54,9 @@ int cmd__read_cache(int argc, const char **argv)
>>   	setup_git_directory();
>>   	git_config(git_default_config, NULL);
>>   
>> +	prepare_repo_settings(r);
>> +	r->settings.command_requires_full_index = 0;
>> +
>>   	for (i = 0; i < cnt; i++) {
>>   		repo_read_index(r);
