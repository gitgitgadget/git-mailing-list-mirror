Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CBBC433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 12:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92EB229C4
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 12:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbhAEMSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbhAEMSj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 07:18:39 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2FDC061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 04:17:59 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 4so14545042qvh.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 04:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5URYIPXZhVTGyBt+6/Ji8L8lI7Pg4xcIR2yJfBJjxY=;
        b=s0BfgkD0bT6nnOsii/Y7f/aAfYUh145m2zzKzh8Rf2pDvihCZ8MZkJY+iaYQEncmsr
         dzrOt4aX/PpV+f2nlSlCh6ZBwdtdSNCxR3KQ5RKdOeJUg9nkjZ6RcbNySdgtjCoXR6FB
         X/X8f6SG+TXGce635ol2wPrjjv52RyzZtthc0ateEUHt0LBIH1kZaIATbEdlct8HVQ8Q
         S3zFz4Z7dgHuFZwTADqcO+vKruZpm8uSLRYWbd8wvgUao7HOgJFiZWS/H9oXzMH38C5Q
         2a89nQTJhJiP8zXjPH+odejFaBciZ2DzjEI7HrdIxYKYU14LW0sKCreiRqjuima58RXs
         q9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5URYIPXZhVTGyBt+6/Ji8L8lI7Pg4xcIR2yJfBJjxY=;
        b=Skh22ZaRYCnbiaultes0yXdYOkR9XhgxBUd/ITzZSvSdvlAzZfsAFI7fwbxYPw5Fsg
         p62ZwspeDyrSsosJoGe1Ks/Hy4auyeBRUgpt4wcuq9/qk25O5YYbdpremvYYTq3qVv4+
         PLqJ17eCMJ+I1BCIDWK4lUY6yUbqvHpKprhr2G8qFtqRLJo6U0OHngzCJTUsfNZghHVV
         CmusSc/dn2Xx+O8gxRCjuetd9uzcqBMX9Ak3bpsAODne7e1J49qlSMLoyLXYg9QGX3ON
         UXU0BrHTkT0sQAfYzhJHbIuRwRK5rI5gmYy18YB/z4SHF44iGgT5To21J+f7KpIvqJDc
         WQAA==
X-Gm-Message-State: AOAM531RACna5JFtalN8ijGYCy84vo3HSHBBDiqy9IhUd+EU2fsDmfSj
        yHFT6SigmPyg1nOTXw9QU1s=
X-Google-Smtp-Source: ABdhPJwy2H7/JGTE/++n5vsKI9yYi6cMtKPQeAbOI/GMjH91jCZ3ukjhiReV9puEUGGHQyWeiYcNzw==
X-Received: by 2002:a0c:e84c:: with SMTP id l12mr81976530qvo.0.1609849078760;
        Tue, 05 Jan 2021 04:17:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 198sm38081468qkk.4.2021.01.05.04.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 04:17:57 -0800 (PST)
Subject: Re: [PATCH v6 0/4] Maintenance IV: Platform-specific background
 maintenance
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
 <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
 <xmqqpn3izeit.fsf@gitster.c.googlers.com>
 <CAPig+cSciupmmupdgynfBO98EFke5fneC5W+k2vCo9Zkh3KF5w@mail.gmail.com>
 <xmqq5z5azd2r.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73383c58-6b78-bded-da7b-fc44c8b9c02b@gmail.com>
Date:   Tue, 5 Jan 2021 07:17:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z5azd2r.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2020 8:04 PM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Wed, Dec 9, 2020 at 7:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>> Update in V6
>>>> ============
>>>>
>>>>  * The Windows platform uses the tempfile API a bit better, including using
>>>>    the frequency in the filename to make the test simpler.
>>>
>>> Are two fix-up patches from Eric that have been queued near the top
>>> of ds/maintenance-part-4 still relevant?
>>
>> Both of the patches from Sunshine are still relevant atop Stolee's
>> latest (v6), and they should apply cleanly (I would think) since v6
>> didn't change anything related to those patches.
> 
> Yup, I tried rebasing these two and they applied cleanly, so I'll
> include them in today's pushout (which I haven't finished yet).
> 
> I probably would not notice if the updated 4-patch series already
> solved the issue in another way without causing the textual conflict
> with your two fix-up patches, though ;-)

I noticed a subtle issue with the v6 series, so I _will_ reroll the
series squashing in Eric's patches. He will remain a co-author and
I'll add the Helped-by: Ævar along with the details for that patch.

Thanks,
-Stolee

