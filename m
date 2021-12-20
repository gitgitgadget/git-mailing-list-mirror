Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D13C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhLTUZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLTUZy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:25:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6BC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 12:25:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j1-20020a17090a694100b001b1044f134aso7086871pjm.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dn7Zdh0a7bD7jiL7HY2XT+CdZAKtiwAnfHnFvhqiD6o=;
        b=FZDfsvg5qTKonSjwvAlYG/Lj+Ldw4dZ+6oLvrqLIemq6g0kbZDwp+Banu30B1lCr7B
         KGqisyQNu/sDYdK6XldiOkiUWZ+CX2krIF9KEDCquOpLvbCixEA5xUKZ8JNbxhVyWbdK
         DdBeyIfw+qfoNII3wZBfNL6QoGMk9NUmXZxDa+wBPLTTzd7AuNhifA3uGiIs2/XzKwqq
         MNiA1rvfkuq+WTbnebxZWOTPUJo5zfTTA2mO44dWJD98uXzzdwGKgGufsxmWBHq2T16H
         Ztpm2gPpXRRvFBTkZVkIt/zBeuVxSst2RHZxeWb6Ag9yoKnyU7ovtIxCZpwK221dOVoV
         8s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dn7Zdh0a7bD7jiL7HY2XT+CdZAKtiwAnfHnFvhqiD6o=;
        b=1aLpQEiSyh4pl2dMk3iL1+X2JPa66CcGv5l+N2j3xVJa50KddcSWx9qcBQmCfv203T
         04cB9HJfgIy0MHcOeW3OMgnBk+5R5/ceiM/ETUOWEHFp0GgSTGaPfRLmQDqgZGem8XwV
         JwiNASqjKKirEIGaOgjtlED6pOgSsdCqkiky3rk1Vw8nYjXxw3Nk9olt9SPBeoGvF1oK
         TtaGhzpTgriSH74Xk3glC79UaY214sK8dL0WY7r1Nw3gPkwYAMapkMA87MEtPhE53EPR
         r9d69N8HJrqYfNIz/yMNSX/tj27nzpehLEIv0uHm+IkJDXHv3vO0mhY+Lq01JxAMWlBK
         HO8Q==
X-Gm-Message-State: AOAM530xVPCGngt74sfkxjwqhgQNChOfgqWBvf6Q0jzDZvZdGsgS4xYU
        Oceh0u+rW71k7oFC9rjNUHQRGVDMqZdsNQ==
X-Google-Smtp-Source: ABdhPJwNKmoDBZUV9b+QQIpNry+9RfoM8CLOxAJ0UKamiwwwRgUMIVYSiYhEUM+CaqXmUaYIqxKMFfzkAREXzQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ecc1:b0:148:a2e8:2761 with SMTP
 id a1-20020a170902ecc100b00148a2e82761mr18518959plh.104.1640031953359; Mon,
 20 Dec 2021 12:25:53 -0800 (PST)
Date:   Mon, 20 Dec 2021 12:25:44 -0800
In-Reply-To: <xmqq8rwfvyxf.fsf@gitster.g>
Message-Id: <kl6lr1a7yqev.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
 <xmqq35ms6pd3.fsf@gitster.g> <xmqqwnk45aah.fsf@gitster.g> <kl6lwnjzytyl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq8rwfvyxf.fsf@gitster.g>
Subject: Re: [PATCH v5 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> What happened was that I got confused by [1], where it reads:
>>
>>   [...]
>>   find the tip of js/branch-track-inherit from 'seen' [*]
>>   [...]
>>
>>   [Footnote]
>>
>>   * One way to do so would be:
>>
>>     $ git fetch
>>     $ git show 'remote/origin/seen^{/^Merge branch .js/branch-track-inherit.}'
>>
>> The commit that I got was the "merge of js/branch-track-inherit into
>> 'seen'", but what you intended was the "merge of js/branch-track-inherit
>> into gc/branch-recurse-submodules"; I didn't realize that there might
>> have been more than commit matching that regex.
>
> Yeah, that was not quite clearly written.  The way it was showing
> was to find the tip of the other branch.  The instruction was to
> prepare you (and others reading from the sidelines) for a case where
> your branch depends on somebody else's work that is *not* even in
> 'seen' (e.g. I may have an older version of 'seen' but there is a
> newer and clearly improved version on the list that is likely to
> replace).  In such a case, you'd 
>
>  (1) "find" the tip of the other branch, either by traversing from
>      the tip of 'seen' to find the merge and taking its second
>      parent, or applying the latest from the list to a locally
>      created topic branch forked off of 'main',
>
>  (2) create your topic branch, forked off of 'main', and merge (1)
>      into it, and
>
>  (3) build your series on it.
>
> If I have your previous round, and if the other topic you depend on
> hasn't changed, you can omit (2) and instead find the equivalent of
> (2) I created for your topic the last time I queued it.
>
>> I made some commit message changes. Unless you think it's a good idea, I
>> won't re-roll this to fix the issue.
>
> Let's not waste your message changes to clarify the patches.
>
>> So if my branch were not in 'seen', I should have based my changes on
>> 'origin/js/branch-track-inherit'. If my branch is in 'seen', I should
>> base it off the merge of js/branch-track-inherit' into my my branch?
>
> Hopefully the above is clear now?  Sorry for the trouble.
>
> Thanks.

It's no trouble for me. I should be thanking you for taking the time to
make it clear :) I really appreciate it.
