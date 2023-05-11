Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A487C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 15:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjEKPXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbjEKPXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 11:23:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4C1BF8
        for <git@vger.kernel.org>; Thu, 11 May 2023 08:23:41 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so41902561276.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683818620; x=1686410620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/92ZNtjUv0WH/yeGmdSjOmQUNhMis5l6+WGZ5i8Cqc=;
        b=NKxFCiKfbA+ItqyVTxhJnyahjYRpBHa1a/QuViOMSKfBoBROMACzU2cW9vJXlqmJ2Z
         3QdfL4AWQm2smgHkkZ5edQQB/bmF5mW6+4iIdzTRChY4c1DCu4Y0P/NSoE84BuJ+wMWP
         QcFvJuwT5ukPl1bWpdjT0wohV2uRWrQ3bNwFOxi2i62MfQyp52RA1v49qPUJS0KekDEV
         1sHzqtzaCxUsxTUpWXyV797RDFdLD1rf3ADIaKkwX/3Zi5Altgn9EJqZbGzmz3wiXAwr
         CFSb+C6TEjD9WeqYm0FBFFAYxThtrLYbu4MO+saFo4gJ+iyUqe88Ue1A3fibbQiVtUrQ
         ilbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683818620; x=1686410620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/92ZNtjUv0WH/yeGmdSjOmQUNhMis5l6+WGZ5i8Cqc=;
        b=l3wxsJcw+1ul19kIrtw7kIjyT5MYYm7eW0Ta3hUvuWyiNo8JIwQF9JcweUOOXsjneR
         5Xmz6CviPvhD+eiqD+EmQQZCEk9YhIk8FdsG2uj5rxUYNJx3BKFKO55bzDkqtY15Mgrq
         DDqRsgUNT+KPeya5BshFhFJtuS5ESbtu26utb3AsSyWY0ZCwfGKAzpfzsorNzx2ehxyJ
         VaAv6NhFP1PnMFphK1nRCWrlwLgxSeadZwSeAddOv/YtdyIP/GPTo06hl1RCxx8dClZu
         dMGk3aoi/7h6zN/0rnoLFtdZZbRHchVxDixR3VwmN55FBH5iLmGTBvG2J/6vzIwh138X
         nrXQ==
X-Gm-Message-State: AC+VfDzEFZkNOQhZRL0/HY1TNzwQwKmWsPJzzR9rSi3rktkv/ZY6gX8T
        fc0e5PPEM0T8NS40ppQaWSIq
X-Google-Smtp-Source: ACHHUZ4gIg+rtgOAJH2OhzHvPgeFOK0D/lmZiFGGe0KP/M/Gifcm4UrdERJo31VQ4AJZGZfgsrT5cQ==
X-Received: by 2002:a0d:e690:0:b0:559:d78f:db64 with SMTP id p138-20020a0de690000000b00559d78fdb64mr20453570ywe.3.1683818620191;
        Thu, 11 May 2023 08:23:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c583:6563:bc4f:3e20? ([2600:1700:e72:80a0:c583:6563:bc4f:3e20])
        by smtp.gmail.com with ESMTPSA id z141-20020a0dd793000000b0055a446a9e71sm4941399ywd.40.2023.05.11.08.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:23:39 -0700 (PDT)
Message-ID: <7c4425fe-c1e9-0410-2b14-a33fcf89b428@github.com>
Date:   Thu, 11 May 2023 11:23:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] pack-bitmap: boundary-based bitmap traversal
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683567065.git.me@ttaylorr.com> <xmqqmt2b23ut.fsf@gitster.g>
 <ZFwkXtkAau4MNtKv@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZFwkXtkAau4MNtKv@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2023 7:10 PM, Taylor Blau wrote:
> On Wed, May 10, 2023 at 03:55:54PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>> Here is another small reroll of my series to implement a boundary-based
>>> bitmap traversal algorithm that I worked on towards the end of 2021 with
>>> Peff.
>>>
>>> The algorithm is the same as in the last round, though I cleaned up a
>>> few things throughout thanks to another very helpful review from Stolee.
>>>
>>> One significant change from last time is that the new algorithm is
>>> opt-in behind feature.experimental, giving users a way to try out the
>>> new implementation while still being able to switch back to the
>>> known-good traversal in case anything goes wrong.
>>
>> It seems that the comments the topic received on the previous round
>> have all been addressed adequately?  Does everybody feel comfortable
>> merging this topic to 'next'?
> 
> Thanks. I agree and think that this is ready to merge down. Even though
> it is changing the traversal algorithm, it should be relatively safe to
> merge since the new behavior is hidden behind an opt-in configuration
> option.

Yes, I'm happy with this version.

Thanks,
-Stolee
