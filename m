Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB37C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjCOQOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjCOQON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:14:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2265746CD
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:13:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c18so16769193qte.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678896803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Osw1wxMkvffzg2nyvw2LFvKPgKdaADrSKCSVSk7EflM=;
        b=N61mOPqDOC8ZR+zyGnT9JyIXi/LlU/ONFPRKDr9vYi+Zq6aZO4ioxCJNpUppXbL0SZ
         pXAQFN8E023af+PZBvXDEwhkSg3MVS/JYlEp9qBmn31Xu5ImxTQgmIkM6hZaRceibYuz
         RJZKQYHfdy4yUkRs3/lofq5Mje2vfaT/plUnLp9TSKxXdI58FV6jNVs+ZE8clUGXs1s6
         I5zrzYX2IdbTNCpgzjth/5SpzaxwJsliZW4VfrrzIEhPYX/hhD1np5xFYtFXBcxTVgh9
         PZeYHI6U/Nt08JtyQ2BeKwjIyD7M9RhB4Hk2XQ4xMfzsxxPdImLxFVE3DSESnd9I4UNE
         RaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Osw1wxMkvffzg2nyvw2LFvKPgKdaADrSKCSVSk7EflM=;
        b=vo2gJbrrA6X9wNj1EBnkdMOzViQ0M7Sch8ndsbB4ciZR58WShszhzpqsVrDkNXUUb4
         OtBZYAkvYwSGhON0dLAKEj/+5S6JrzRxOFo9Kz0IcASMxcReTslHoGZlAbNpn3we2ocp
         PhrDiWMCAp88cTaHlBwLPKVlVbCDGoo3FS9a7lT9tZ2+aEm7XyOeOEly0LqhR1/n+7z+
         9uLB3mNYTxtPKW7pCWt15EazUGzpps6wmoqyt7tFgILH1roDs2aCK2OXU/AKBR8z6GRb
         1zEnl82H0Agu587ONGM9NbM8lo4KY3b51ipkkXAK2qom2qKTB+h4Yx+RTEs2gLmq1ooT
         K6Ew==
X-Gm-Message-State: AO0yUKW5kKqP9ZbXpmks5Eyhg7KNTaNBO4s9cpIVsDEMjQhXYBMI3Epe
        JRypUaYcfq7OFOOZe5n5wDMa
X-Google-Smtp-Source: AK7set/PWWJM82beqQO8VhhukgY8cVY8jv6zbb44agH31Eioh1K9O3rHw/ORtWRRqG6Bs8vzzalNeA==
X-Received: by 2002:ac8:5c02:0:b0:3a8:fdf:8ff8 with SMTP id i2-20020ac85c02000000b003a80fdf8ff8mr617811qti.36.1678896803653;
        Wed, 15 Mar 2023 09:13:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b00743049c2b15sm3967889qkj.66.2023.03.15.09.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:13:23 -0700 (PDT)
Message-ID: <4d8f63c4-2e8c-fd60-f857-4e7971e8c0c0@github.com>
Date:   Wed, 15 Mar 2023 12:13:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 6/8] commit-reach: implement ahead_behind() logic
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <9831c23eadbcd990ca09628e5846056e4879ee3d.1678468864.git.gitgitgadget@gmail.com>
 <230315.86cz5axgny.gmgdl@evledraar.gmail.com> <xmqqcz5aovc6.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqcz5aovc6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 12:03 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>>> +	/**
>>> +	 * These values store the computed counts for each side of the
>>> +	 * symmetric difference:
>>> +	 *
>>> +	 * 'ahead' stores the number of commits reachable from the tip
>>> +	 * and not reachable from the base.
>>> +	 *
>>> +	 * 'behind' stores the number of commits reachable from the base
>>> +	 * and not reachable from the tip.
>>> +	 */
>>> +	unsigned int ahead;
>>> +	unsigned int behind;
>>
>> Even though this is the tip of the iceberg in terms of our codebase
>> overall, can't we just use "size_t" for counts in new APIs?
> 
> I personally do not see a point in becoming so dogmatic.  Plain
> (possibly) 32-bit integers have their places in the code.

In particular, we have 32-bit limits on the commit-graph due
to it being unreasonable to have billions of commits in a
repository.

Thanks,
-Stolee
