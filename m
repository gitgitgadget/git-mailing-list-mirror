Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6DC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66032396F
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgLGWPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 17:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLGWPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 17:15:02 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4ADC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 14:14:22 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d3so593050wmb.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxpNbSFwCjItQPP3PwnMaUGAyU9eFdDU4Dq5dBKgI4s=;
        b=ig/xoYfMIfkZt80PSupCxxQazHLSiuToissf6LaiL8eFYAtjhYCa/JVvvsAOcC4cPI
         uRSM/Uy/0Vm7nf9U1t3ip3nhx3qC6L8vK9jHvXLjQk++hjB3ehjXRr3Ky73AEf9vCnWh
         Uww0bF3MrucUTsx/23pQrPYWUx01j0L/Y8YfY9m/xU3xvxZbNoBHDpektyOOOQ9CLEdb
         QmDrgpH6AGnX7pOsm1rhhojmEtf9C/6j/SYYgPReOQV5iIBEOVJq1s4L/ufZfeshcE/B
         B01AtnhOn5DI8qLrXQzirdjK814rrviC1flz30tUCg8KSKd/2xececHA1uRbQzdLAaYx
         mAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxpNbSFwCjItQPP3PwnMaUGAyU9eFdDU4Dq5dBKgI4s=;
        b=rWowIWRNEeLw7WKyE3nsevrotMPDYpsk3IN1GFcfi+mJ8QWM/opmltfMKQ5976oqN6
         TokPBy99VahxyFcmpsdTann4zHK7MRSzTgt2k/f+oJIYrNaMw3oXI8XuXs0lyRtX7g/E
         8qTkLHc49YnnSkInyJ/AWR9yPmVZq2tXqY6/5+wYEnccoDxMmx/tPG8v5mIagvu9OimB
         sE4UquXv3i/edvrSCjautui/9Xvr+Z+Qye5nGl43yfdm16+8pu7O5r+wXVDT8qZNHNkO
         E4ZzBsIZzp9jU2lU9zOaIPpXo83wLgGc2OvQozTmrzEeAiNhHTJPL/AylfBKVKNeej0b
         VguQ==
X-Gm-Message-State: AOAM532gx2WAQgBPGv55DEZCzK9ApPnfQL85dgik1sy1eA8FF/GwtvFo
        i2Vtus0JYwqIf7ZwsKg4lOKGtLjTm4SBTUFyitoK6HIuKMRnLb45
X-Google-Smtp-Source: ABdhPJwwu9ve2VixhzMQOP28ZM1a3c1mKLwcOdeAxsi49XXxuEQhF+JeXD5TmwdfoGpV9c+m0u76AroIf3DA2EPiQ1M=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr890290wmc.55.1607379261206;
 Mon, 07 Dec 2020 14:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 16:14:10 -0600
Message-ID: <CAMP44s3FRkdS9j=B0ht0Uviy4XE43PbObjXRk7hekRGPyoVCpg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 1:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > They start by saying the same thing. But one errors out and says the
> > user must choose, and the other warns that in the future the user must
> > choose.
>
> Then I do not see the point in giving the warning---even in the
> future they do not have to choose as long as they are merely
> following along.

They don't. With my patch series they see the warning only when the
pull is non-fast-forward.

> >> > Just to put this series in context: it's only part 1; it does not
> >> > introduce pull.mode, and it doesn't make --ff-only the default.
> >>
> >> I'd view the "in a non-fast-forward situation, the warning kicks in
> >> to those who haven't chosen between merge and rebase (i.e. no
> >> pull.rebase set to either true or false, and pull.ff not set to
> >> only), which is a bit more gentle than the current situtation" a
> >> good stopping point.  That state is already making ff-only the
> >> default for unconfigured users, or you can view it as shipping "git
> >> pull" in a shape that has the more dangerous half of its feature
> >> disabled to avoid hurting users.  So I am not sure why you keep
> >> saying you do not have --ff-only as the default.
> >
> > The warning doesn't make the pull fail, ff-only does.
>
> Then probably you are giving an error and a warning at a wrong
> place.
>
>  - When history fast-forwards, and the user hasn't chosen between
>    rebase or merge, there is no need to give any warning.  Just
>    succeed by fast-forwarding.

Yes. That's what my patch [1] in this series does.

>  - When history does not fast-forward and the user hasn't chosen
>    between rebase or merge, whether pull.ff is set to "only" or not,
>    we should fail and the error message can instruct the user to
>    choose between rebase and merge; there is no "ff-only" option
>    that is useful in the situation.

Yes. *Eventually*, that's part 3.

> And that essentially makes the "ff-only" mode the safe default that
> castrates one half of the feature (the more dangerous half) of "git
> pull".  Why do we make it more complicated than that by warning that
> the user must choose in the future?  They will see an error tell
> them that when they start pulling while on their own work, and I do
> not see a need to bother them before that point.

Because the amount of time users have seen the correct error message
telling them about this upcoming change is *zero*.

No one is aware of this backwards-incompatible change that is
upcoming, since the current warning message doesn't specify any such
future change.

Moreover, no one has configured their pull.mode, because no one has
seen the message that tells them to do so.

And no one has had time to try out the upcoming "pull.mode=ff-only".
They haven't had time to find bugs on it, or weird interactions, or
suggestions how to improve it. Because the code has not been deployed,
and no warning has told them to tentatively enable that mode.

When the default for push.default was changed, it was a good thing
that we gave users (and ourselves) a grace period to try it out before
permanently flipping the switch. The transition went smoothly.

I think the progression of the warning is hard to see from all the
patch series. I'm sending all my patches and I will explain in a
timeline how it progresses until eventually we reach the desired end
goal.

Cheers.

[1] https://lore.kernel.org/git/20201204061623.1170745-8-felipe.contreras@gmail.com/

-- 
Felipe Contreras
