Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A2C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 14:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhLPOYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLPOYk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 09:24:40 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39478C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:24:40 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso29108771otf.12
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LF03jEmiN2UJW2RbkbN67QugpGDUxCY+F2THBBlEN6A=;
        b=DUfH4bcyuF93o/bvt0pP/i5LocKwLl0OMQvbjN3CyeSZBK6NOMN3UzF25qaAcLkd4/
         N/KxiNagFa1rotuMOwh8iRuQm5BXkw1s0XU6dTFXrYoNGbJPt6/8w3qzTrqFwIZjef+P
         6dZQXq4TdYlhsECAmy0QI25DjNN9VBoJ9YwUo9oUcPEl1dahy3o2+h1Kw4NEJXc/x+l2
         O7WWfnMgsnzqMIfYutKxBaEhJv92vGcL/TpI+/LMlDRFrZWxsVtJ4r2+Q+pSgytebja3
         XaF39jVBSsn2hA60YNcf7d8jmM1i9RMfWH93KIfaS6zpHEgFjYaOIJO05LNaIkN5aX0s
         yffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LF03jEmiN2UJW2RbkbN67QugpGDUxCY+F2THBBlEN6A=;
        b=qfFphIwUajIn/lpIGmN8ByfSKkX8kQbHhvrCFA9D5ho8dJjqJ4qG9auTABnMd/eKRl
         Haj3BnkbZi9/0oK9clBDUpI9WhK1XQbEgWUO1VTb6xMOTKq7R7VWIW3FVsFH+C74Gl+w
         l4bT0oaWBmLLTbAK4E3mAWmafWZz/Au7spRrQ0w0JUaPoubip3p7sKcLxNh2cwyKYJW5
         vu2vFlXHGUXPnlg4r8pgO6Ny76YUIJokgV/CRSnQkyLI8sYR6nyEVPlgYJ/CnVX8eGta
         7bMA53DvQlUGD0nrYbZKJroeWld5wpUbSXyE+dU8Q13mlArijYEFLNliVeHeC69u/n7i
         922A==
X-Gm-Message-State: AOAM533VtlBtOBXjlJpmKIMz6FCP3Vq7NBvNfV0r2mJ1SI7yHyOVVwcs
        HqA8JRYbHZsmDaYQQiL2HrgKA25ed4w=
X-Google-Smtp-Source: ABdhPJwGazE8ZwUL43vA9F/naWmw6ET9STiGMtTgEkHlDHc/O4n2ffOh6t5Im0O/lzmC+3Ng58WBAw==
X-Received: by 2002:a05:6830:2681:: with SMTP id l1mr12667731otu.378.1639664678143;
        Thu, 16 Dec 2021 06:24:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f174:15fc:4a5c:9d45? ([2600:1700:e72:80a0:f174:15fc:4a5c:9d45])
        by smtp.gmail.com with ESMTPSA id ay40sm956377oib.1.2021.12.16.06.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:24:37 -0800 (PST)
Message-ID: <e0f90c01-f987-1c9c-cd93-393d0dc6e0dc@gmail.com>
Date:   Thu, 16 Dec 2021 09:24:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 0/3] sparse-checkout: fix segfault on malformed
 patterns
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
 <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
 <xmqq5yrp61lw.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5yrp61lw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/15/2021 3:43 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series fixes some issues with parsing sparse-checkout patterns when
>> core.sparseCheckoutCone is enabled but the sparse-checkout file itself
>> contains patterns that don't match the cone mode format.
>>
>> The first patch fixes a segfault first reported in [1]. The other two
>> patches are from an earlier submission [2] that never got picked up and I
>> lost track of. There was another patch involving 'git sparse-checkout init
>> --cone' that isn't necessary, especially with Elijah doing some work in that
>> space right now.
> 
> Thanks.  The segfault fix matters even more with Elijah's "we can
> flip between modes" feature, right?

Generally, I think segfaults are a higher priority, but this one is hard
to find in the wild, I think. I'll send a v4 today and hopefully it makes
it an easy decision for you.

Thanks,
-Stolee
