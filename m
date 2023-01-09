Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20BC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjAISCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjAISCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:02:03 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41CE0D
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:00:25 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id l18so5936079qvt.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acskJPzlt9ZB0XtfWc1pDyDG2JBLa+X1jfRNE9VHuPk=;
        b=eldzSHa4xJwrqB/SCOy/gASl7GyOFbjkvJhMZtvUwxqu51cRLBsrIl9dobR/69q2Iq
         KceyqZfvNJeFRykLTzsgSdcbo7k1qHfPaF4w/vVt2NIXH0lgb4V4vKZFNpsCs/XyNND6
         uxxqXMUK33brUHSQcJt5GPxPsQfU998IpJbrEEki1DO56+fAHBcb70+hhgRiv6B65ak4
         w0Tmt2W4PZ7n6txDsPIzvSDju4PqLEiZDNwFcM+1+9rjPp9EEVtlONzmqrwOhprmJI10
         8pAbmD3p3IBMAn9bVJwLcVt7EEiPZPxrrwDPXy48PeQKYng3Jy8jOLHAZBWyOClEwBZN
         3/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acskJPzlt9ZB0XtfWc1pDyDG2JBLa+X1jfRNE9VHuPk=;
        b=H25LUnLg9MST7ekaSBcMs9s2eZvu0TLqJmOcPNZAtEVFdX3E+xeQz5cKtaxwy1EQhm
         CHcNZsj8DOvFE9PVf2Hv4OekJEFOTtv+lARycDoWc8ewmAIBkfhh/xJ/MZtS0fJ8/n1u
         qzBGxrQWpO+3d74m95r9JXeRHTJoFn4eiE5dfzxMeOXGK9dgyRlBzNEJvjsXHEa9oPzl
         mGj51+jppC5p6IFzRAZppvLb8S8e0lAwkmFI97mYvzJiOM32iBUyulLJSutU7d1FgC7w
         Ne4K7wqLfaJmHuH7EnYtt1gztO5jelv4EVwaF98hz93RTh15tUto6kpu9pcu4tci6wi6
         RdBQ==
X-Gm-Message-State: AFqh2kouVaR2KrsJOp3uJltI75HtOV1+Bua7c/AQV3KwZidky3g+nHN/
        Tc2Cv8E0Kf1QKE5I32hpBmwg
X-Google-Smtp-Source: AMrXdXuz2YTyLv+ZtqQzuE7Epj5ofnWtQVNJZfuizOdINXt7XKuP/iPIoH16wfW8TqaZCHnQ0RWDrg==
X-Received: by 2002:a05:6214:2b8f:b0:531:e6dd:8aad with SMTP id kr15-20020a0562142b8f00b00531e6dd8aadmr26508736qvb.26.1673287225001;
        Mon, 09 Jan 2023 10:00:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9803:bdc5:6740:d9fa? ([2600:1700:e72:80a0:9803:bdc5:6740:d9fa])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006eef13ef4c8sm5773920qkp.94.2023.01.09.10.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:00:24 -0800 (PST)
Message-ID: <8bb310ff-5dd1-1470-18ac-68b81d2f488c@github.com>
Date:   Mon, 9 Jan 2023 13:00:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, newren@gmail.com,
        Jacob Keller <jacob.keller@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
 <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
 <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com>
 <xmqqmt6vqo2w.fsf@gitster.g>
 <bb48b1e2-819f-8bf3-ef4a-b9e4d23080b2@github.com>
 <230109.86mt6r1v6d.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230109.86mt6r1v6d.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/9/2023 12:15 PM, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Jan 06 2023, Derrick Stolee wrote:
>> On 1/6/2023 5:45 PM, Junio C Hamano wrote:

>>> We probably should start paying down such technical debts.  We've
>>> punted on them too many times, saying "yes this is klunky but what
>>> we have is good enough for adding this feature", I suspect?
>>
>> Yes, I'll make note to prioritize this soon.
> 
> I noted in passing in [1] that I had those patches locally, if I'm
> understanding you correctly and you're planning to work on changes
> that'll make "istate->repo" always non-NULL.
> 
> I've rebased those on top of your "ds/omit-trailing-hash-in-index". I'm
> CI-ing those now & hoping to submit them soon (I've had it working for a
> while, but there was some interaction with your patches). Preview at
> [2].
> 
> 1. https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.com/
> 2. https://github.com/avar/git/compare/avar-ds/omit-trailing-hash-in-index...avar/do-not-lazy-populate-istate-repo

Thanks for doing this so I don't need to.

Some quick pre-submission feedback: your "treewide" patch [1] is far
too big and doing too much all at once. It's difficult to know why
you're doing things when you're doing them, especially the choices
for the validate_cache_repo() calls.

In particular, I noticed that you used "the_repository" in some cases
where a local "struct repository *" would be better (even if it is
currently pointing to the_repository as in builtin/sparse-checkout.c
in update_working_directory()). These would be easier to catch in
smaller diffs.

[1] https://github.com/avar/git/commit/7732a41800dfc8f5dbf909560615d6048d583ed9

Looking forward to your series.

-Stolee
