Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446AEC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243291AbiCBS6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiCBS6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 13:58:49 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689630F4B
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:58:05 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so2455398otp.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t9EbSoZnvePvBLNgQDR1RAzCDSf6nAXQQzdPPW/4XMU=;
        b=KoR9zw863BadaDd28J41ZzUJcXEuAkG9k1J77iyNX0R4XD/n+Oen8UrnfCzkrPTpF/
         Ocmx5Q4vtqbVzWaaagJpprSmAEq5k9DoEpss2Udkgr22GWm6d0sXXsn6cxPa4mvIm/xs
         IRLWu+sJXJ65VpFUTMi9zE3NjN/Te719lB1FPWX+ceiHMCoulBEMY5qid4SBdMSWv+Ze
         y6rjHyLrPC2hlFC77BuwvA3/2+Xn/m3JrtTOpkzNsAXnYwi7ZrqogyAcZdglcwrjLO4t
         5duOmOmIrYR6ylMeOUJ6PAJ07G7NlkPbPCMjIhoYqVDg+5DaSI5h3FTDw+0V5aIGN3HG
         mXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t9EbSoZnvePvBLNgQDR1RAzCDSf6nAXQQzdPPW/4XMU=;
        b=AjY2J9CT24cG96FI/ugEGP8S0DFLGa2pSf9ucqmp0JBCeModCHRMgQM5ejtQzkf8Dx
         A2uAzkzWeCaoemIG+DfaIwOy5BwXdZpzX6hwDGH1T+9PxJt3PEucxV7rgHDJAkwjYtSR
         dpMRAi+HknWKN2qeQ/HXC7CKcv10usFkRs7MR8Ll+EVMC4PtNdNjzDxQkWCO3y0/DSyB
         JzLhTFjQeN2rAOJop6SxcrTUT4qfAcs0PCvl0h+7IgRDBT++pBNPvIyoQsiUqEUogg5n
         jMZiFt+yArPN0CnrNn2pHgVO07AhT/Zsb5q8RFXjN7oe/E+Lk3Oal8a2kHQhYg8M3jh/
         ORrQ==
X-Gm-Message-State: AOAM531t8zRO/zyHGAdXVn8U66me3mGhvODbTw5dFitgCELGn4e8vguN
        fPRASohDzuEWTnLlpuBQmklE
X-Google-Smtp-Source: ABdhPJwBnf29qhHuzXF90Zp5jtNGSmoY9/avBrWuMFyBHVFJSt4Ftl2TVywuX/wCfMdNNxpJwXqGqg==
X-Received: by 2002:a05:6830:1682:b0:5ad:1538:1a0a with SMTP id k2-20020a056830168200b005ad15381a0amr16850695otr.301.1646247484622;
        Wed, 02 Mar 2022 10:58:04 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l8-20020a05683016c800b005af12a7a52csm8143915otr.14.2022.03.02.10.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 10:58:04 -0800 (PST)
Message-ID: <31bfb179-59b9-c68e-1389-44da376ef12f@github.com>
Date:   Wed, 2 Mar 2022 13:58:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] builtin/remote.c: show progress when renaming remote
 references
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com
References: <70a0325ca8ab0492a9b0873ee3fba576c5ab90b9.1646173186.git.me@ttaylorr.com>
 <06ef2e2c-7048-1101-870a-4774a2dcd988@github.com>
 <Yh+Sp5BxqxYhBv0M@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh+Sp5BxqxYhBv0M@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 10:52 AM, Taylor Blau wrote:
> On Wed, Mar 02, 2022 at 09:32:48AM -0500, Derrick Stolee wrote:
>>> Instead of a more complex modification to the ref transaction code,
>>> display a progress meter when running verbosely in order to convince the
>>> user that Git is doing work while renaming a remote.
>>
>> Thanks for this patch. It improves the user experience through
>> useful feedback.
> 
> Admittedly, it feels like a little bit of a shortcut to avoid modifying
> the ref transaction code, but I think it's an OK short-term solution.
> Thanks for reviewing.

Absolutely. Help the user first. Think about the harder fix on
another timescale.

>>> @@ -682,7 +686,8 @@ static int mv(int argc, const char **argv)
>>>  		old_remote_context = STRBUF_INIT;
>>>  	struct string_list remote_branches = STRING_LIST_INIT_DUP;
>>>  	struct rename_info rename;
>>> -	int i, refspec_updated = 0;
>>> +	int i, j = 0, refspec_updated = 0;
>>
>> My only complaint is that 'j' is not informative enough here.
>>
>> 'j' as a loop iterator is good, but we aren't looping "on" j,
>> but instead tracking a progress_count across multiple loops.
> 
> How about s/j/refs_renamed_nr ?

Even better!

Thanks,
-Stolee
