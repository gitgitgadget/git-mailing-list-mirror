Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD5C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CB460FF4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOTPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFOTPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 15:15:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7FC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:13:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b11so52566442edy.4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JFqo+jkQ8iKiQPy2ShFMhBFlKajzWzTzehfSao7DMoA=;
        b=tbyFc/1iCzYUeulFvdMHA7SrHf7aYb6xizzqCfx0w/MU8CyudQAgRd+cl4zFHUtolE
         Clrmm1jdw4ZNaxpsggZNQqOXnUFhNwDJYmpHQSYRbKKh6ZzelVwGUMsbLrMwuvrcX4HI
         h2bUZC8g2MJ4xglOCfUiIMwLD+aZCR0cOM8PLLBkOk3K57rmc9X/AVHeYo46VAsu2rqT
         q5hcdPtgr/6ZFBrx+D8aAlm5fGvAZ3uxk74VI8iFUYA57JyRMvNdgzRtPsueUFX1o3ns
         Hgu4+thB/g30ihaznxEoHGyMTRcOBLZ81mrbPChSt2+eloDuhDjaWBHM0ibaQwsQzIWf
         nqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JFqo+jkQ8iKiQPy2ShFMhBFlKajzWzTzehfSao7DMoA=;
        b=MWqS113D3XvZEbaUsFFh5X8G9rgjJQV+OZUVpkOCLFmY/Xq7k+eyp1oWdP73pf+rPx
         5qIVQqqRul1DO9ZHTS+9pcD2WK5Aol/iqs2xmxbe7cjv8SfckTRURmnjv6uAJnH1Jwrk
         fZfw5bZVZOumAi34E69rRgZw9pedSx029/mAtf1HpQjfzytUmovba23/joFpr4wm+rfz
         NrCUzTdX0TDZ7cUvWheQYJ1uVxptMNVIxPxTMRQUmlrRzmPKFL9tMkvZ91tsbsPw6GI/
         Gqs9/De3V2XJxQ2qkvqspT06xuohZdDqxRPW07ncjaeA0fK9cUBTvYOfNt9uYAPCstv7
         eWSA==
X-Gm-Message-State: AOAM532zkQGyscJGbOK2iOpdNouPGFoq8ke5xyZxGvFFA2469dMppYop
        LTjhvKC++5LyWBeqalxca8d6nJK7bZSQ7Q==
X-Google-Smtp-Source: ABdhPJzrHFG+CHtKeahrBZE9RCm2AFL1xVhJxk6WitUPUAN9tYF2lE9qAZx9Y1dc+eO0eIxUpNUmBg==
X-Received: by 2002:aa7:c705:: with SMTP id i5mr1394246edq.222.1623784422320;
        Tue, 15 Jun 2021 12:13:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f10sm12786877edx.60.2021.06.15.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:13:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Date:   Tue, 15 Jun 2021 21:09:13 +0200
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <60c8db3558fb8_1296f208ac@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60c8db3558fb8_1296f208ac@natae.notmuch>
Message-ID: <871r93ym8q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I suggested in [1] that the "alice" and "bob" examples in our
>> documentation would be better written without a reference to such
>> fictional characters, for reasons that have nothing to do with trying
>> to bend over backwards to avoid any reference to people's gender. It
>> just makes for better documentation.
>
> I'm fond of Alice and Bob, and I'm saddened they are the latest casualty
> of the culture war, but if we are avoiding gender of examples, it makes
> sense to let them go.
>
> However, I want to defend this usage a little.
>
>   1. Alice and Bob are familiar, so it requires less cogntive load from
>      the user.
>   2. Alice and Bob promote the usage of git as a distributed VCS, where
>      unlike centralized VCS, you directly use the repositories of your
>      colleagues.
>   3. They provide some relief to an otherwise sterile landscape.
>
> I don't think these changes make for a necessarily better documentation,
> just a more sterile one.

Fair enough, for what it's worth I wouldn't recommend against using
these names in general, I would think you'd actively seek out those
actors in e.g. cryptography documentation.

But as I argue in 1/6 I think these references go over the head of most
of our users, and those users are better served by more succinct
documentation.

The diffstat for the series as a whole increases line count, but it's
because of e.g. 3/6 elaborating on the function of the --user-path
switch, in the case of 1/6 we've got a reduction in lines and number of
words.

And as argued in 1/6 for those users who /are/ aware of "Alice and Bob"
it's needless distraction. Maybe it's just me, but whenever I read
references to them I keep waiting for the cryptography angle to be
introduced. None of the uses in our documentation reflect that canonical
usage.

There's also just weird things in our documentation fixed by this
series, such as referring to a random file tracked by git as "bob"
instead of the more obvious "file.txt".
