Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3993C433FE
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhK2XR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhK2XRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:15 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6201C04CBE3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:01:57 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so23481679iol.13
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QzoF8DQ0B1eWDvTMjztB6U3C+0s4/dzM/uXGEAw1eNI=;
        b=eNrGvHmK9xelCOunZYBtkboOEbb0rrrPJJCFUEwmmf8yInFodhjhvFNV2ZyUdwDZP9
         II75miDwA19Sxvy/YqCQYYR2d8Y3Wukrjt8F1VX+60apaEsNZUkgIU9oCJyNQWY2T61X
         fLI/0dNwrPfuAyc7uLZ1+gYBjEBHqgv7TvMAVcy4YqmKtfhtACxy5Ks4G+ztOjVtvNfa
         LA7nHRbXXYYrdrAKMaYGuf6vIebgkPrMmaR35uoCJsIKCKMHJy29+tNMbcr3v3zpJs5I
         LvSTvDeSgaCo8gXryZwl4gVDBZ8gU80lyFjHmCyE+Dhm0tB15Qa05gJeah8SI8DzJz3f
         jvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QzoF8DQ0B1eWDvTMjztB6U3C+0s4/dzM/uXGEAw1eNI=;
        b=xgvLJEDdktDsux8EqBVPoT2fgKtuGHN61b67ctYJtbWxY9doQKSEoSQpfFTnzBYtRO
         3s1aKlxd2U0/jLBbFDQKAbA2uco62zu9FEpeiGZ00tpLFYcKmK+8Id03TN5DHJGXlhFQ
         Ge0BUxRGrPy8fXu+FOSmV6iYm1X7BSM6pbaeVXrA6/h1HJ2GKpM69j32ItZRZag7G2cR
         QjQNkwX6oNbcAm7tLl5+BSQECCdql+g3Bpr4mXiLYdhN94K4Cv98R4gmWEoDxWOYO9Zm
         ECfwAwO7xyyKoqotou8khYBHiFpgTJG637SqjRpGTnjr60LKmbsgG2Xdon+Sv0Uw1xiH
         yBcQ==
X-Gm-Message-State: AOAM531JvtsRb2QxaLfuvKCYP2+GEgWeQIlcp658nKaTwJylTEqwRKSt
        OvGog2ttczp4WzXE7O5dSko=
X-Google-Smtp-Source: ABdhPJxzW3ZOf9rdALfMe+0PsIeQfmar12bIkStP+e7gef7VZsRE6UZP1+nbrKT/Uow2S7KkHerqSg==
X-Received: by 2002:a6b:f70e:: with SMTP id k14mr56677305iog.173.1638226917190;
        Mon, 29 Nov 2021 15:01:57 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id x2sm8572954ilv.65.2021.11.29.15.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 15:01:56 -0800 (PST)
Message-ID: <eef31466-e574-1f0e-91c5-efaa78ad8880@gmail.com>
Date:   Mon, 29 Nov 2021 15:01:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 2/4] test-read-cache: set up repo after git directory
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <5bc5e8465ab5fe871965e6c6d578efc51e55b505.1637620958.git.gitgitgadget@gmail.com>
 <xmqq4k82781w.fsf@gitster.g> <0372ee0b-8dda-c505-2b83-30da74e4fb36@gmail.com>
 <xmqqtug12yga.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqtug12yga.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/24/21 10:36 AM, Junio C Hamano wrote:
> Lessley Dennington <lessleydennington@gmail.com> writes:
> 
>> On 11/23/21 3:42 PM, Junio C Hamano wrote:
>>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>>> writes:
>>>
>>>> From: Lessley Dennington <lessleydennington@gmail.com>
>>>>
>>>> Move repo setup to occur after git directory is set up. This will ensure
>>>> enabling the sparse index for `diff` (and guarding against the nongit
>>>> scenario) will not cause tests to start failing, since that change will include
>>>> adding a check to prepare_repo_settings() with the new BUG.
> 
>>> This looks obviously the right thing to do.  Would anything break
>>> because of the "wrong" ordering of events in the original code?
>>> IOW, can this "bugfix" be protected with a new test against
>>> regression?
>>>
>> Yep! Tests 2, 3, 28, and 34 in t1092-sparse-checkout-compatibility.sh
>> will fail without this change.
> 
> I do not understand.  When 1/4 and 2/4 are applied, no tests in
> t1092 fail for me.
> 
> I think the presentation order of this series is not reviewer
> friendly; "the new BUG" is introduced in a separate step and
> obscures the reason why this step is needed.  It is better than
> adding "the new BUG" first and let some tests fail and then fix the
> breakage the series caused in later steps, though.
> 
> 
> 
> 
What I meant was that those tests fail with the first patch in the
series. Once this patch is applied they no longer fail.

That being said, I agree with this feedback - I have reorganized the
changes for v5 in a way in which I hope will make more sense and will
improve the reviewer experience.

Lessley
