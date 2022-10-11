Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E7FC433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 15:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJKPrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJKPrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 11:47:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352091FCCE
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 08:38:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u10so22235697wrq.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ0VZnsPe/3fSun+wOhSbLRg2Zt79nsRV808vB8Y77g=;
        b=SYH7fFuq/yDtImPotuJPlD3ZfiMIYFClWFu1xvGlgrXHbR9ECC4D5zL42rVOG8JjdS
         m0YHynmw1xbiODG8/Se8g4gH7vI8MEaT2OdLo6Zl1lNx4vLI8wlxdKk8NYpXWBbfah1r
         XZ0/EyoMYSvQxTAxq2tNSxsIQ3VfoRVMNjIFdeLtAV4jLPzAlM2m+5qcxRSkYVTSU6PI
         +KYKxTFq9+tMVmmyZDzf49K9MZYvWSpN1HiEHVlcP+Er8lEQGo6S49MjwScd3lyHxcuE
         1Blvt58U+KzH1D+dhcSO42uO/14oSOgJ786VtUdVS2FSDXD+799Jj6UXpvaFP+kCYLr7
         DWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJ0VZnsPe/3fSun+wOhSbLRg2Zt79nsRV808vB8Y77g=;
        b=P2NqvxH7r+XlimcMYQb0Vxz7Xf8zS69GH/IaeVvkbfByW60B5xKH4vzgv3IV/AjJOo
         zYgJKSBpAT6mEuO3MMTpoRDIfU/pzQHuuECh34kXc7U0PG0ofFdfdHqajkiqGD+D6EBn
         pp3mO0ibStWf+nkpB38JDMBXV0qzAtKE5LGl5fCKlF8i8KKistSB8s9X44oWuVfdsEHi
         DvZFRiKeiEQQoKBlwZrBwiJBqjrVB7MEIXcQRPA6uzFVNK3gdTxuqk0cqLaDh3ncHtVv
         fL3hX6WsTRHju1x7Z+cCFNSzBXunhAjyhPC5Xk1pmR9BySPwRT8/GbuBeE4NlJHVN1Ky
         wpJA==
X-Gm-Message-State: ACrzQf3yiuRaEZFyfP645RBVxL/alDJZroZTuEbnuuO0N91Xiyiht4js
        tjDxS3ci+EgeQvXgNhjwBi/GMqXjYIc=
X-Google-Smtp-Source: AMsMyM6GRgCVLfSp6OtNBwoE5WJHAexMUpPgMfcNSB9idM/cgKwUx4FyHHdvXFEsgdfNwz1mdsfaxw==
X-Received: by 2002:a5d:4f10:0:b0:231:1c7b:e42 with SMTP id c16-20020a5d4f10000000b002311c7b0e42mr4717198wru.568.1665502737435;
        Tue, 11 Oct 2022 08:38:57 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id v9-20020adfe4c9000000b0022cc895cc11sm11139235wrm.104.2022.10.11.08.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 08:38:57 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a7d32371-4224-aa2a-4b7c-5631798ff710@dunelm.org.uk>
Date:   Tue, 11 Oct 2022 16:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t3435: remove redundant test case
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1379.git.1665395106351.gitgitgadget@gmail.com>
 <xmqqpmez4no5.fsf@gitster.g>
In-Reply-To: <xmqqpmez4no5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 10/10/2022 18:02, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> rebase --preserve-merges no longer exists so there is no point in
>> carrying this failing test case.
> 
> Looks good.
> 
> I can imagine that you noticed that it was failing for a wrong
> reason, perhaps as part of your test-todo topic?

Yes I noticed it when I was looking for tests to convert to test-todo.

Best Wishes

Phillip

>> diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
>> index 5f8ba2c7399..6aa2aeb628d 100755
>> --- a/t/t3435-rebase-gpg-sign.sh
>> +++ b/t/t3435-rebase-gpg-sign.sh
>> @@ -64,14 +64,6 @@ test_rebase_gpg_sign ! true  -i --no-gpg-sign
>>   test_rebase_gpg_sign ! true  -i --gpg-sign --no-gpg-sign
>>   test_rebase_gpg_sign   false -i --no-gpg-sign --gpg-sign
>>   
>> -test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
>> -	test_when_finished "git clean -f" &&
>> -	git reset --hard merged &&
>> -	git config commit.gpgsign true &&
>> -	git rebase -p --no-gpg-sign --onto=one fork-point main &&
>> -	test_must_fail git verify-commit HEAD
>> -'
>> -
>>   test_expect_success 'rebase -r, merge strategy, --gpg-sign will sign commit' '
>>   	git reset --hard merged &&
>>   	test_unconfig commit.gpgsign &&
>>
>> base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
