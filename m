Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B77C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 07:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiKTHmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 02:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTHmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 02:42:15 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD094A41
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:42:13 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 130so8585744pgc.5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0TfRfeirfm9K7UNZ21w1yzW8mNWcd8oLr+lF/8wLzI=;
        b=RxZV2lm4zgb9xamKr4KeN5eCpmuWE/q8iu4lMq+kKN6Zlrz2peaQojjXPcID8JG5Yl
         G8x/NeaTJTLCrGjLqnpbJATlo5/zJPJUhEAKVF5dVD13hvOUqpTVi8GLVOCMZ4pJPcKg
         1qJaZy3FaFBYaljOW1F8yDRa3dlVg5dkx0SIo3w9kdh7HTQa3Tkpt6Utoyubols8qlzA
         d0WMt3SU8tU5aVn/TekGOGRE5PSLAgpROsoqyWLI1AzuWax5u7yvRy+BdFmFS2J2aorF
         XmRRD/HuS1hgEyqaxPIRmG2KkYG68l3eYmIrNUEpCNbugclY8FJDmaD0JlljmyugXXfy
         HcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0TfRfeirfm9K7UNZ21w1yzW8mNWcd8oLr+lF/8wLzI=;
        b=TLtE7sZC35hLM3eK6h3LTYRg3mG6bfzx1cHe88dcWOAOv0Hx/kew6u0t3xopUtXUtD
         Pcs3bZXron1p1lngZnmzil6cDilCtfSW/mytlZ2hXTbarwHmy9boFxOkF5VK7ooypcsc
         GqI4ruFarkqjdSJvwEIp0l2TjzNh80P7bWRsAHEkF+tlsf8ZTrAmKV7yoQ8hZjbEXucs
         uaoSzyg3zYX6h/4mT35pBxRytoyuxPXF0xHAgPIAG12xQUMIH3pOe9SqZVjwQlJcRkWP
         gYORLqufHRTv/20zPN7C10eBqZkMIy8LMNkc0OsFrZR09t1Bf1Chr1aaCCoMd9P9Ir/y
         tIOw==
X-Gm-Message-State: ANoB5pkpBlUVIXdTrT4V2TBT7AMIgL94tpLRGzV6mFPA+Rap1ueW9COm
        hKWUaqD1sjVEdd86/NIcT91r1G6hPxDLRQ==
X-Google-Smtp-Source: AA0mqf6evNaDcjXmzpOsm6rcxClfOZKPrDnsDI6rWl5MxNrNPmnUQQG/T7oSqbgt9FXzesjXKi7LSA==
X-Received: by 2002:a63:1e49:0:b0:46b:1590:2625 with SMTP id p9-20020a631e49000000b0046b15902625mr12932544pgm.569.1668930132744;
        Sat, 19 Nov 2022 23:42:12 -0800 (PST)
Received: from ?IPV6:2409:4081:9e01:f9e1:b435:9ad:e08d:a7fb? ([2409:4081:9e01:f9e1:b435:9ad:e08d:a7fb])
        by smtp.gmail.com with ESMTPSA id w15-20020a63d74f000000b0044046aec036sm5362820pgi.81.2022.11.19.23.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 23:42:12 -0800 (PST)
Message-ID: <42aa5823-36d7-8860-90ab-953eb6d2f2b4@gmail.com>
Date:   Sun, 20 Nov 2022 13:12:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 0/3] Add mailmap mechanism in cat-file options
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-1-siddharthasthana31@gmail.com>
 <CAP8UFD1nhXnYUj9zsXwvf2tjeK1yimY3AwomU30wor1Vf-QPbA@mail.gmail.com>
Content-Language: en-US
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAP8UFD1nhXnYUj9zsXwvf2tjeK1yimY3AwomU30wor1Vf-QPbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/11/22 23:18, Christian Couder wrote:
> On Sun, Nov 13, 2022 at 10:28 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
> 
>> In this patch series we didn't want to change that '%(objectsize)'
>> always shows the size of the original object even when `--use-mailmap`
>> is set because first we have the long term plan to unify how the formats
>> for `git cat-file` and other commands works. And second existing formats
>> like the "pretty formats" used bt `git log` have different options for
> 
> s/used bt/used by/
> 
>> fields respecting mailmap or not respecting it (%an is for author name
>> while %aN for author name respecting mailmap).
> 
> [...]
> 
>> = Patch Organization
>>
>> - The first patch makes `-s` option to return updated size of the
>>    <commit/tag> object, when combined with `--use-mailmap` option, after
>>    replacing the idents using the mailmap mechanism.
>> - The second patch makes `--batch-check` option to return updated size of
>>    the <commit/tag> object, when combined with `--use-mailmap` option,
>>    after replacing the idents using the mailmap mechanism.
>> - The third patch improves the documentation of `-s`, `--batch`,
>>    `--batch-check` and `--batch-command` options by adding they can be
>>    combined with `--use-mailmap` options.
> 
> So the documentation patch is now part of this small series again.
> 
> Even if this documentation patch is a bug fix, it might be better at
> this point to squash this patch into the patches 1/3 and 2/3. At least
> I think that would better follow Junio's last comments about this. If
> you go this way, you might want to squash the documentation parts
> about -s from patch 3/3 into patch 1/3 and the rest of patch 3/3 into
> patch 2/3.
> 
>> = Changes in v4
>>
>> - Improve the documentation patch to clearly state that the `-s`,
>>    `--batch-check`, `--batch-command` and `--batch` options can be only
>>    be used with `--textconv`, `--filters` or `--use-mailmap`.
> 
> Here I think you should say that the documentation patch is part of
> this series again and explain a bit why.
> 
> Anyway I took a look at the actual patches in this series and they
> look good to me now. So I would be Ok to merge it either as is or with
> patch 3/3 squashed into patches 1/3 and 2/3 as discussed above.
> 
> Thanks!

Thanks a lot for the review Christian :) I have made the suggested 
changes in v5.
