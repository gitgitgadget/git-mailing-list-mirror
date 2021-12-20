Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5EDC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhLTRj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhLTRj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:39:58 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69933C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:39:58 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id be32so16824437oib.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IQPJi3dfw4pq7/3KDP4kYfu7l0Pg/t5uQw0dRTa8YnY=;
        b=fi2oORs5VRHai75FY8+O7mc6Tm6kJd6kEbCSMUMAl1C+oH+nuXR+c3K+wFuUHolwUC
         grfRiEKwPGny1wI+HeNu8bF3bbJ+xYRFT0GGMfCGluMCnNJ5BgLVoQVBqQ+HyLjQ99eB
         kZ0U5NqKTgxiDh4NlNbCNkuDxRgzrOtQMLznBvCkQiV8MNzb9zk7aX9H8Xnl1eXq+zr0
         Qy8UvsK0L+XiW8SZ+mCqJOfJvaOzPtECNxs4XaOEsITBHaqEaH1t2+mBVS+XYxz43qmL
         lRGmNfxomXBOpngsV36z6qYKhFLJwv9i0w7ouwUUq4Ef2CPJiy1iKxGFpcaTfolEpvi/
         sppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IQPJi3dfw4pq7/3KDP4kYfu7l0Pg/t5uQw0dRTa8YnY=;
        b=l9HC77VXwrgK+sjzkodp6YFM6KZA/mHSdZknQbCaEH+HEmdF4Uw53l8mH43UBXkAp2
         mdvbIBRfYsU18twV13Ohwmce8RADyLGFiM/X0a3izRu6uEF+aG5HjaqT/KGx2izYU51a
         q3nSaQFYQv8vHoO3mThABsX+WxELQTTLn0/FcJ0Pkf6PM1KwyY7KhfAXyDd19yhnpIaw
         t/skrr0wFJX9hpXHbMROPgvf4iNoRvNAIqKucYOStw/XLOu4F5j/6dvARysXZsZlsuAu
         rc/uR8wmjhwjyBmVip2Z0aNUXN3bHfLzmtFemtQI1Tl3k3bNCQRSHGGk1q0oqCFQnJWL
         dagQ==
X-Gm-Message-State: AOAM531URZbBiH7UENB1Dbgt6ldLij3KEAlbLuK8ITkZ8fhtwfPHY6mD
        mpAyxck1Qf+AjNtTea82kfWSfNipnPA=
X-Google-Smtp-Source: ABdhPJyGlHGnc3KagzzSvHWx2GFTX8GDj0gyDVauxE+lKNU/zt+cHP8DtnXJagCaW0I63xz8TBptkQ==
X-Received: by 2002:a54:4e0c:: with SMTP id a12mr53093oiy.12.1640021997653;
        Mon, 20 Dec 2021 09:39:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id m6sm3117610ooe.24.2021.12.20.09.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:39:57 -0800 (PST)
Message-ID: <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
Date:   Mon, 20 Dec 2021 12:39:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
 <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
 <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 11:13 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Derrick Stolee wrote:
> 
>> On 12/12/2021 3:13 PM, Ævar Arnfjörð Bjarmason wrote:
>>> But we've also grown a hard dependency on this directory within git
>>> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
>>> subcommand, 2019-11-21) released with v2.25.0 the "git
>>> sparse-checkout" command has wanted to add exclusions to
>>> "info/sparse-checkout". It didn't check or create the leading
>>> directory, so if it's omitted the command will die.
>>
>>> Even if that behavior were fixed we'd be left with older versions of
>>> "git" dying if that was attempted if they used a repository
>>> initialized without a template.
>>
>> This, I don't understand. Why can't we add a
>> safe_create_leading_directories() to any place where we try to
>> create a sparse-checkout file?
>>
>> This would fix situations where older versions were init'd with a
>> different template or if the user deleted the info dir. The change
>> you've made here doesn't fix those cases, which is what you are
>> claiming is the reason to not do the other fix that seems like it
>> would.
>>
>> What am I misunderstanding here?
> 
> I'll clarify that a bit in any re-roll.
> 
> Pedantically nothing changes, i.e. you can create a repository with an
> empty template now, and it'll break on both the sparse-checkout on that
> version, and any previous version that had that un-noticed issue.

You continue after this with more motivations for adding 'init' 
unconditionally, which I am not fighting.

What I _am_ saying is important is that if we are trying to write
a file to a known location and its parent directory doesn't exist,
then we should create it. Not doing so is a bug and should be
fixed, no matter how rare such a thing is to occur. As you've
shown, it is not required to have an info directory until we need
one (e.g. for sparse-checkout or an excludes file).

If you're not planning to add that to this series, then I'll add it
to my list. I do think it would fit well into this one, though.

Thanks,
-Stolee
