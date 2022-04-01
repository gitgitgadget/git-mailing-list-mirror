Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A4C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiDARA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiDARAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 13:00:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9C90258
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 09:59:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w14-20020a1709027b8e00b0015386056d2bso1749142pll.5
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=59s6pIMubItMXqW2/ZG0eLoNrpxPQNK9q+y6Mz0NNzo=;
        b=YK53TReWeovahqS1DGkUcClW7PYDMAoVTRL7oTsi0ts7l1hrjaE2N0HozVFSkQ7oRA
         tynZJqrifkABuSAvBMJdjtk2vmkfwNbuPwgSZwxO79p/pqf3idBxtbi4ZpncIt+O4SDf
         h46jdY/YSqijYciSyRem9FLu1dSaRn/zUGFQM3+J1lCf8Ho8FhEkGORqGOJ7TJ0QXaQh
         HlrET1ac++sN+7cnzDF0HGR+ttfZia64R5PiXn19OO5w/knRDHHQfBwWtO4eSyNbP5bw
         qEaSnNzVnXl9wMUF+QjH8wfpfCVn9FCYxhja53d70z2G/wVcd5ZyiZAqWiHmVh6AKqZz
         cfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=59s6pIMubItMXqW2/ZG0eLoNrpxPQNK9q+y6Mz0NNzo=;
        b=b6IrsI30WgnzTiPEOMQdTh2q6AZma8k1LFoH+CMu/ixkAJp6gBm9otUzQeGeSUG6vm
         8iWuQ/vT5pqo7rIY97W5nV/AhkLFzslLY/M9tRq6Sgtvh/oOiVt67mZfoUT+F3hWLdQS
         ZPQk4mw2qAV0YwATbMdo1j/pQTlDqB+pb/begkrF7274d3JZ8/Zqc21Eer4eKV9qp9l3
         PZb9pDerU+TKQ5c5lGfhHpbiXA12i7R4Hj8U0WE+KZX2nqJXX/xjUvyOFhg+B0kFt5UI
         BcngSVWt97t2Jijj9Vh0+dsFKwsbamQGH+EaPe2nlRjTlYS0UUDgQBB5ZoErEIM7hlnr
         k9JA==
X-Gm-Message-State: AOAM533ZqX7slqDHmRwm9DMqYuKg/x/ygZ+bQKoqR0PGARsz+dMASXZH
        8iLamFYaoXWWgtKitzqld4Mz+5y6GC8udQ==
X-Google-Smtp-Source: ABdhPJx674WRtb01ygjvz2TfVl5K1s24fGlCDPfZTlehe4bxSqQfQ3Dg3AV7sFA8/EMmCbC1+jZX0planL2akw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:88c2:0:b0:4fa:ba98:4f6f with SMTP id
 k2-20020aa788c2000000b004faba984f6fmr11866152pff.41.1648832345689; Fri, 01
 Apr 2022 09:59:05 -0700 (PDT)
Date:   Fri, 01 Apr 2022 09:59:03 -0700
In-Reply-To: <xmqq7d89zqys.fsf@gitster.g>
Message-Id: <kl6lk0c8spt4.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
 <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com> <xmqq7d89zqys.fsf@gitster.g>
Subject: Re: [PATCH v2 0/4] branch --recurse-submodules: Bug fixes and clean ups
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Thanks for the feedback, all. This version incorporates most of the
>> suggestions (which were pretty small anyway).
>>
>> == Patch organization
>>
>> Patches 1-2 are bugfixes, 3-4 are clean ups.
>>
>> Patch 1 fixes a bug where "git branch --recurse-submodules" would not
>> propagate the "--track" option if its value was "--no-track" or
>> "--track=inherit".
>>
>> Patch 2 fixes a bug where "git branch --recurse-submodules" would give
>> advice before telling the user what the problem is (instead of the other way
>> around).
>>
>> Patch 3 fixes some old inconsistencies when "git branch --set-upstream-to"
>> gives advice and when it doesn't.
>>
>> Patch 4 replaces exit(-1) with exit(1).
>>
>> == Changes
>>
>> Since v1:
>>
>>  * Patch 1: reword the --track comments to be prescriptive
>>  * Patch 3: remove a now-unnecessary die(). I didn't include a suggestion to
>>    inline the advice string to save reviewers the trouble of proofreading
>>    (and the format string has no placeholders anyway, so I don't think we'd
>>    get much benefit out of typechecking). We can inline it in another
>>    series.
>
> Thanks, but sorry that I've already merged the previous round.  Let
> me turn them into incrementals.

Ah whoops, sorry I didn't send them out sooner.

Thanks for that :)
