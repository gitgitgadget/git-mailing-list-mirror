Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D896CC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A429C6121F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhJGPHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 11:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbhJGPHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 11:07:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367BC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 08:05:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so20115605wrg.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7e4HGdhv9gjjg/fyLBaP/p6tQvz9AZkKdtqZwMEOEr4=;
        b=EUt4ZWbJfvsgdEhrdlDsKZ4RSEeezVW7LCZDsALCKS2vxM53R6couXpomRyg01D8pV
         zdMrJa8vVTjEOCLN/e+FzDH0cXS7zG+CIV5leMeU6s7Be2LEOFhNqQ1LRkwmUdnV20uL
         N9aGRx4iz6LrvpzB1F0oOxlYbNCWySqVs/DkOER57kTEDRLDQjzA8GfiHD1Qo5VbYIAI
         ovh1OcmMwneTYxNcW+O2u2vwl3yYKCyU+u47nJoNre1f8kuhIIv2lYl/gqurvaOPjfxj
         qm5fE7+88vqKYO4ELFDaZpEZMLws66mEZRj3QoXY16gBpaw1NtSDDosYPcNHf0sEY+1E
         5Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7e4HGdhv9gjjg/fyLBaP/p6tQvz9AZkKdtqZwMEOEr4=;
        b=7UGUfVav+l9Iw1uarCpaLCRZ344YIYtftZRdIqRjVKOUqjE+/aa4MK6kdAE1BmvCWU
         Xzx5omCyl4NXRLPE5YLZbZSz3L6Sd6P/V8Yr22nmvblkhQiyYQ/cYXtKiOA/BzHmFaej
         cfyaNUDmhNYB/AVE3YdQGQEFtFMTiSDnVqoBaO4cHDWj4O/OpsN0BLpRDWQYQXYDIwgl
         n/aSDPkWwpDyqtXgoWWRGUa2JC2ExHL7IdNa206x1eDRUX8Ad3F0vtf8TL6R7uHIPb5l
         UG2cnKUXFhCZs2Xwfk0aGEOxa60d3fCvWHjU915vm8Y59Oqu/dk3PZeTQwx1D87FCwUV
         UHCw==
X-Gm-Message-State: AOAM530IgW7KUDr35A7tqvDSUZ8HF1tbp7Ts9xXr50U/JZ/52wf0XW9K
        3yEJHt4RBQbqu5wBqrmeEak=
X-Google-Smtp-Source: ABdhPJxohKi8phGO+KMLELfkGjFAUix6lHqVb1xUGylt+eTCLYYDq4kiulfXs+f4pNouIHLFI1xe0w==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr6492354wrr.354.1633619155240;
        Thu, 07 Oct 2021 08:05:55 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id c7sm12606915wmq.13.2021.10.07.08.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 08:05:54 -0700 (PDT)
Message-ID: <028aef79-d4cd-5202-f657-4b5045f85d0f@gmail.com>
Date:   Thu, 7 Oct 2021 16:05:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sparse index: fix use-after-free bug in
 cache_tree_verify()
Content-Language: en-GB-large
To:     Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
 <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <3bf4e767-294e-0f30-f0bc-ffa706a86835@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3bf4e767-294e-0f30-f0bc-ffa706a86835@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 07/10/2021 14:53, Derrick Stolee wrote:
> On 10/7/2021 5:50 AM, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> ...
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 886e78715fe..85d5279b33c 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>>   test_expect_success 'merge, cherry-pick, and rebase' '
>>   	init_repos &&
>>   
>> -	for OPERATION in "merge -m merge" cherry-pick rebase
>> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
> 
> I spoke too soon. On my machine, the 'git rebase --apply' tests fail
> because of some verbose output that does not match across the full
> and sparse cases. Using "rebase -q --apply" works for me.

Oh, that's strange, the CI tests pass on gitgitgadget and that script 
passes locally for me. Do you know what the output is that does not match?

Best Wishes

Phillip

> Thanks,
> -Stolee
> 
