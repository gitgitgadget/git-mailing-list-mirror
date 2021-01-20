Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28D2C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879ED2342C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbhATT0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391985AbhATTZT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:25:19 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F79CC061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:24:39 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d1so3953562otl.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=944sQbmYbp5ceW7VTUbV66XBHswtDNuHCd7lPkj2dtY=;
        b=VddtR+HYooIOKIwBI3fXIcihSxkMyVNV4J3H6bbjM9ylpxNxe2jz2tES+7oh7q7foL
         4ad5pqGvMl1/vEMZw3sGYqBC7eum1wcicw1CPu+zuSDXZeWPX3NyV8RqVq866W/sZz3e
         RjSHfE4ac+DDWLRw8cNFNjZQP2yQNLjIKaxw5GFY6WYiNf3SwI2gNGSLOy3s0nNfdi+e
         WNO5tyFSyZtlzT7isIbRjg5P338axkzuPBR0mtXNrfjGY99W7zKkxp+QEvmD1ub6KWRi
         XpFLmkDEII/BADt2fjHusjr6pl9qp62lrjXch5/I6oLPB8HZhj0AYKMgP3dG80KrLE5q
         ag/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=944sQbmYbp5ceW7VTUbV66XBHswtDNuHCd7lPkj2dtY=;
        b=n/cLwUbBejPIQAiBTbwDOLHm0UybkTb6vfPzD8ruAwK+gGdQ3UlPsYWiP/oL3WzKKX
         b9VI4QFjrYUkzCkOst8dbfJk3UE7NMaqfwV3mGxODWKz24uWvZ8vWjMWNJcbT8YfQ6Qc
         NH1zKrlmcP+CKH9EhuyBWDWNXhwnjhIaEMaDkdmbB9urtUoFg9QuExnZvOz3x+m0gXuK
         YAUFlGVV5v8UKCFs1X3y3FT720Cb4ILHx3UKy0wA3HWU7OfYBFLAQvKIU+UAhbLa7JJy
         U3FDSXEF+4tVmi0jV+pnC6fHetYqEBt1SQYDimrwEWmFhAb7FckzZqfM4EsIsH6TQASZ
         /Ehg==
X-Gm-Message-State: AOAM530VLCmMcq2aZGtS8FEyue/zpWmIPJucWoz79oAcs/QQKoa1L9xP
        l0lSYbToBRPPxOaqu5BY7DA=
X-Google-Smtp-Source: ABdhPJxioWXZzzMjdf4ry3PS5MQEZrN81WvHnLnILyBzqvW7HFFrGFby/hXvDpMyx4OuRDB8ntGoFg==
X-Received: by 2002:a9d:6188:: with SMTP id g8mr8001395otk.299.1611170678827;
        Wed, 20 Jan 2021 11:24:38 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id z10sm584063otk.8.2021.01.20.11.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:24:38 -0800 (PST)
Subject: Re: [PATCH 8/9] test-lib: test_region looks for trace2 regions
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <8326a9b5320e1e774caef568fcce2bfd2ec13cb1.1611161639.git.gitgitgadget@gmail.com>
 <CABPp-BGrtcQ1pDCB8_cV77dqxige0v8rk4tqFRXe=HOUsn2DNw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7754da50-10bf-24cf-2fee-e1da93a7c94a@gmail.com>
Date:   Wed, 20 Jan 2021 14:24:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGrtcQ1pDCB8_cV77dqxige0v8rk4tqFRXe=HOUsn2DNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2021 1:20 PM, Elijah Newren wrote:
> On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
...
>>         # t0212/parse_events.perl intentionally omits regions and data.
>> -       grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
>> -       grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
>> +       test_region category progress trace.event &&
> 
> Sidenote: Hmm...about 40% of my region labels in merge-ort.c and 90%
> in diffcore-rename.c have spaces in them.  This function could still
> be used, but I'm curious if I should change the labels (but then
> again, they are testing logical regions rather than individual
> functions, and the spaces instead of underscores kind of convey
> that...)

You should be able to use

	test_region "category with spaces" "progress with spaces" trace

but if not, then the test_region helper could be improved to match.

I do think that it's better to avoid spaces in these identifiers.

Thanks,
-Stolee
