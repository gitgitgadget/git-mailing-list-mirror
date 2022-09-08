Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED53C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 13:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiIHNV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiIHNVU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 09:21:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B125F22D
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 06:21:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bz13so22621793wrb.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=6+D8KRdie2BYRltsNnQvGLClgJibomX43hEQxgNZ4x0=;
        b=WKazoEtRlp0pMA/7Lxu9VJ1Bn+E+J9Gj97imVTmRFwloLPLb7ywHI+3IEWUytYbyoc
         C+4OgUw4LiwHkT2hcB4vkK/K4nF8zQMb/Ub/LFRPBQmp/j6ohV11GMLC3OEziaGyZFdR
         jqWdvr7EL4eKH9QrqePf8g+HqMRVyV6ErO/dzDBcE7p0Z6lJSMlScF0oTYGUZJAQRnzk
         pEg/D/GLwFQOApPGj2eNB7NhO9UrDurq8rnwg9SrdAYleYiLnQxoetlZkwviEzRcyW4t
         twohXPT/UB85jgGM47MidIJzmTEsUFo/2Wn56nwIyR86evfaMyAwpO+MnKWiCj+qpPdC
         49Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=6+D8KRdie2BYRltsNnQvGLClgJibomX43hEQxgNZ4x0=;
        b=5CybmxENdQ/mFW1U0M+MDRSkcZUEcD1YW3oqkSGf2mSRmScGjDEv3dlqyd7n8VofNE
         3xX1tw3OEi45/RUDQggG+nnNpE/0XhoSfcXZFhk7I8flv39uQ2ABI7Gb2IhTAGv+F04h
         q8V876TF3xaWsBtqr8GOv/ZAJ1+/o3RCFiuZjJ6ntVq3GsZLSXnXsNcF/FbUEAQpDSu/
         0Kxd5fre5kJDEPB6NbCGunI1TRI2EmGh2R78aUMjXi9aofrtp50nxUG/BrFcXZS7nFmM
         qd5raS5rR8N/LkQqqF8X8APDVQAfIYskLj07j/8eU9cpxzZDgi9D9IEQ4FDbAHnuIYBq
         FZ2g==
X-Gm-Message-State: ACgBeo3OelUvStMzlRgaaIYJqXC1UOXvyxbcYDmumlEsHadQMWm+4Yix
        hER/tLKU8wfCBAatQDkWlV8=
X-Google-Smtp-Source: AA6agR7OgPP/9Sa3v+wJE1ZcolS3SV18IilWBBc7jv+3//mH0P1FtlYC6LczXgigBZ5MA6PPjA/nLw==
X-Received: by 2002:a05:6000:15c5:b0:220:727a:24bf with SMTP id y5-20020a05600015c500b00220727a24bfmr5358722wry.621.1662643274818;
        Thu, 08 Sep 2022 06:21:14 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c06d300b003a61306d79dsm2804796wmn.41.2022.09.08.06.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:21:14 -0700 (PDT)
Message-ID: <c85bba88-4ff1-8569-e9b3-c3cd46c6047e@gmail.com>
Date:   Thu, 8 Sep 2022 14:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 7/7] rebase --keep-base: imply --no-fork-point
Content-Language: en-US
To:     Denton Liu <liu.denton@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <6410b101d7f4ad97f87faec93703370a0493aa4a.1662561470.git.gitgitgadget@gmail.com>
 <YxlW9EGzMPZDOJPF@generichostname>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YxlW9EGzMPZDOJPF@generichostname>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 08/09/2022 03:44, Denton Liu wrote:
> Hi Phillip,
> 
> Sorry I haven't been active in Git development lately. I've been busy
> with other stuff. I was skimming my emails and this patch caught my eye.

Thanks for taking a look

> On Wed, Sep 07, 2022 at 02:37:50PM +0000, Phillip Wood via GitGitGadget wrote:
>> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
>> index 1d0b15380ed..70e81363569 100755
>> --- a/t/t3431-rebase-fork-point.sh
>> +++ b/t/t3431-rebase-fork-point.sh
>> @@ -50,7 +50,7 @@ test_rebase () {
>>   
>>   test_rebase 'G F E D B A'
>>   test_rebase 'G F D B A' --onto D
>> -test_rebase 'G F B A' --keep-base
>> +test_rebase 'G F C B A' --keep-base
> 
> We should add a test here for explicit --fork-point just to ensure that
> the behaviour stays the same in case anyone relies on it here.

There is an existing test, it does not show up in the patch because it 
is unchanged.

Best Wishes

Phillip
