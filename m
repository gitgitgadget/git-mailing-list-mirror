Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8167C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37CC2070A
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA3HOjnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgFZOkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:40:08 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C2C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:40:08 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so4561426qvx.11
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6WUvJT2oBaN4ned/W3cVz6NmL7NwGCOJ4KPxcIA3Pw=;
        b=DA3HOjnf15tkvS73XkGGXpOpDCvCeqj7d6VTrE7b+x0olE+1D/Isgm+gG/aba8plNu
         iGc6Xp9hxHcrPIQ7qJLxRKx8k0YvwmyBU/rDTbk4vpmhbVLbwrw2QTD3BMX6mefsE5+a
         vhGw5iMkE3MY9BSSrM7oqtHvAdsK6FTAS3lTCrZYAXaNr8Fu8AendiqiUgRQgGcbagOA
         ucihAKpw5/KvElOHyZeIFUVqY0xlHLjKwmqQzh7GC2V5zAvUZVwSZ9PjH+Xvg1X+19S4
         ZoVvRL9jFT+CqBHnYxTUCEfu90S4D2oDfjPHZqvpyJw9wDT5ajTwEQ6rtBpoUFILf/U0
         Z8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6WUvJT2oBaN4ned/W3cVz6NmL7NwGCOJ4KPxcIA3Pw=;
        b=NYwkFmqOBZf1DY6xWNodeDNebf+NFK7sit8tJ/UHIDEuvPEohrOTYnAUnf9sqkCZCP
         mAUfekXRmrbBbRrzNY3cJqjWHG+rugLh0MV26sjgzEvX/v14K9DU8gAbpkL/3BYt1T7S
         IYG0y6QjMO5FciexlGJ2elS1CkGuTi/RfYy/BTCKP4TNZ1rM0TT4r1J4dmYPtD7fyr9b
         tyh/W1T8nwzSSdy4G604XHJHrECtqoxidFb8z1KxTNPeFxu26pMuUZsh2JW8QuJbcyI1
         QHkk0Z4MARNb+Is0wzpJH2gYLvrDDBPQW6DiaNTjdiEHd903LhN/q05JYW9fCCAPZNl9
         bBgA==
X-Gm-Message-State: AOAM5309NCiSlJvs7PZ5Jm+5xakPV+KvlsVtS/aR+f8gmTgjqtL/ZfkQ
        YfO+z5SYgaCzDzOsYKG+z4y9XTJM92M=
X-Google-Smtp-Source: ABdhPJyDAb1dmLVDEk5ORpgGe9wCKWDDQoo59zOeziILlgiYNZqULXXLh0vH+i/R8F+BDeWOElDv5Q==
X-Received: by 2002:a0c:8284:: with SMTP id i4mr3337506qva.77.1593182407224;
        Fri, 26 Jun 2020 07:40:07 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w1sm8661176qto.0.2020.06.26.07.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 07:40:06 -0700 (PDT)
Subject: Re: [RFC] Metadata vs Generation Data Chunk
To:     10d99e37-8870-6401-d9aa-21a359b30835@gmail.com, jnareb@gmail.com
Cc:     git@vger.kernel.org
References: <20200626134422.GA17537@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3bdbf490-a7ae-2351-9c82-6b19a577b641@gmail.com>
Date:   Fri, 26 Jun 2020 10:40:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200626134422.GA17537@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2020 9:44 AM, Abhishek Kumar wrote:
> On 22.06.2020 at 13:40, Jakub Narębski wrote:
>> On 22.06.2020 at 11:34, Abhishek Kumar wrote:
>>
>>> One of the remaining pre-requisites for implementing generation number
>>> v2 was distinguishing between corrected commit dates with monotonically
>>> increasing offsets and topological level without incrementing generation
>>> number version.
>>>
>>> Two approaches were proposed [1]:
>>> 1. New chunk for commit data (generation data chunk, "GDAT")
>>> 2. Metadata/versioning chunk
>>
>> Actually in [1] there was also proposed another distinct approach,
>> namely to 'rename' the "CDAT" chunk to something else, like "CDA2"
>> (or proposed here "GDAT").
>>
>> If I read the code correctly, with old Git if one of required chunks
>> is missing then Git would continue work as if commit-graph was not
>> present -- as opposed to current handling of unknown commit-graph
>> file format version number, where Git would stop working with an
>> error message.
>>
> 
> Actually, v2.21.0 (and possibly others) segfault when they encounter a
> commit-graph without CDAT chunk.

Yes, the CDAT chunk is absolutely necessary. It also includes data such as
the commit-date, root tree id, and parent information.

> With this, I presume "CDAT Chunk Replaced With Another Chunk" is no
> longer feasible?

"Replace" was never on the table (in my mind). Instead, we can
consider _adding_ a new chunk that contains the generation number
v2 data.


Thanks,
-Stolee
