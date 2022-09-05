Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBBCECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 13:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiIENyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 09:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIENye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 09:54:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E979CE01A
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 06:54:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n17so11492137wrm.4
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=g7r6AA4YbqD2dXdeg0kM4ikVt+IkNoPny7rIRH4ZT2c=;
        b=iWj1Bn6Z0FZobvWOZUDNmlDuYznw17A6mweVgofNhq/sZmve7g24IwU3ml7QUxytTJ
         w1Pt69YijWdg1d/+X5kpPesN2YB/DM/GjVRIchEWfEn013BcWJKCBJPovzTXwy1pLoKB
         F4L+m/2B3rWJo7faWrLEPVib+xV8edsFxhNkMgBGvmd29xcYuQ8PqlgkmyTi/6/lRic0
         gNMIbhCh0YqdAsszr3a1bMgX0BumMqbh5y8JbCYSe6RlGenWxzCggMTbJZauZde32Xn9
         Hi7HiSPs2EudqZwjwgkfxMQ7Qcdl/gCMJr34qdLfOh0uUSIJitz583mig6Xeb1k6JpGj
         VIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=g7r6AA4YbqD2dXdeg0kM4ikVt+IkNoPny7rIRH4ZT2c=;
        b=Lsyijf5gbDt3bllOBwWHCUS3NXMeoLLVeOyxQunjHQXAdMHhMlnJjAbyDGlq5UmRVG
         u4ZrzZGC1H1H8Gqm2VjzLflsEPktGYirzpM2E1/fiisb9hNalnPk/kV2D9gUZ4tq8dk6
         kxk6V1s7FrA51dCRH6ZMbyAV8+Ua7PTXWxChM4w0hLyX3papjk+ZWSdShpuHqDk0AuR5
         3zA4La5yQSt8TvLTauB3OaNvTFyMHipmAytXpc5lSZ2jJJMOqIjgLt0ck4hcsodATxUi
         8DE8eC1C9ibumNHu1+mfaT8QhRWwYrDaZRYQOINb3XJiw7DgD5uoLtx8tvaRPvoKEMTQ
         h11g==
X-Gm-Message-State: ACgBeo0senzvKKyxxea4CkiAyPFdzFLJslcuwDobwqy/gOC4CQ8F3Th0
        tsRtcciLOkDGgHsAhQSr230=
X-Google-Smtp-Source: AA6agR6F4KQq7rIHpzDxJKoMYbg0ERfy7YKem36NGrBc6fNygx1DF3svLmi/+5jqLaILZfMxBmfujw==
X-Received: by 2002:adf:f5d0:0:b0:228:6ca8:21f2 with SMTP id k16-20020adff5d0000000b002286ca821f2mr3864973wrp.271.1662386071400;
        Mon, 05 Sep 2022 06:54:31 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id d11-20020adfe84b000000b0021f131de6aesm9156974wrn.34.2022.09.05.06.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 06:54:31 -0700 (PDT)
Message-ID: <84ecdf96-3fdd-ae2a-39a0-f5098a8fa2e5@gmail.com>
Date:   Mon, 5 Sep 2022 14:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] rebase --keep-base: imply --reapply-cherry-picks
Content-Language: en-US
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <9cd4c372ee4b3e5ba45c66a43ad0edaf52f0eed9.1660576283.git.gitgitgadget@gmail.com>
 <53130a55-8bae-0414-64c2-bb577a1ae02d@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <53130a55-8bae-0414-64c2-bb577a1ae02d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe

On 25/08/2022 01:29, Philippe Blain wrote:
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 080658c8710..dc0c6c54e27 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -218,7 +218,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>>   	merge base of `<upstream>` and `<branch>`. Running
>>   	`git rebase --keep-base <upstream> <branch>` is equivalent to
>>   	running
>> -	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
>> +	`git rebase --reapply-cherry-picks --onto <upstream>...<branch> <upstream> <branch>`.
>>   +
>>   This option is useful in the case where one is developing a feature on
>>   top of an upstream branch. While the feature is being worked on, the
> 
> I think the doc should explicitely mention "This implies `--reapply-cherry-picks`",
> in addition to your changes.

That's a good idea, I've already extended the documentation to mention 
the effect of --keep-base in the discussion of --reapply-cherry-picks, 
I'll add an extra sentence to the discussion of --keep-base as well.

Thanks

Phillip
