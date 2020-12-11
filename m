Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B6C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7739023EF4
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394995AbgLKLfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbgLKLe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:34:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA418C0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:33:47 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so7260405wmc.5
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONla1w1XZD63dT0qNuOWsLzAwuxTLUqq4oK0IUE3TXs=;
        b=fRf8wBtdkMkB25Tm0U00xdsaKdVjSdTl4oLpsXvTp62F7+RxW8+vcpcyh27n9X16FX
         o2jQg8D13WQhupGbYxr8jYlkGcrHEnRJrtNd/WKm9gAYnuF30MbKlvIP6CHd60yidx52
         13/1Ko4AODm/iLw99bRmgpvBy3fP/E6RigcpgvH1sl7QFJ2zbQtQAHbVU2hNjRQOQpG4
         7sbYVySAXSdU9d2XjAiDfpNp89IL/FkrS1hclWr2BUqZX2wYiNQ8XqKOqSsTUPa8jnVS
         8of+wHy+rAvuDaHC66IfYiwfCeH9VXdUdbFbqD48oR177n2fTxhqU6EeCosDXaZClRZ0
         KVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONla1w1XZD63dT0qNuOWsLzAwuxTLUqq4oK0IUE3TXs=;
        b=KgAk1trwGW8Gu0ad21VcjbgTLyFs+vUO4mEwDmEDegNSm6UEZ31gulylDkdcg7WSiA
         DXjPi0trsajHqTTf8BX7AiY97fw0FizzSkBK33N+pLCBKx3X1AaQDwWKOL1S2NZMwJzb
         0kyLimkTx82XCVMm7OmbL1SrhlYzWO9zaysc0k2C/scYFvRV4+iFKao0P158BEi/yQfg
         59FsE7WIL4kYT7ngdqNJLB3NzeoMwkfCmxgfNYdJOtWPwaRAV1dW4YibgOoA8kkrbXqW
         F8qcnPDL8xIIVGxgGhqIX51Q5duL16FiCkMewOS6CWNdE3fI2NAF8An4sgYv1+IUASng
         lCWg==
X-Gm-Message-State: AOAM531+SlqB3ikj3NWIKJyoVmRWmRMweFuFuzmhDGtAR7nv2xndyPTr
        p2xrRM1/zuFmOc/PPVP7SdU5SLnxxn2D2XLoRTo=
X-Google-Smtp-Source: ABdhPJxF/QWzIatW/xuwJ9TuC3KXKQXjivcZvROtfelUrgsN7HsHnbxRgbIDPqeH/jh2THbbICOsizF11vlF/B8mOyQ=
X-Received: by 2002:a1c:6008:: with SMTP id u8mr12676100wmb.173.1607686426412;
 Fri, 11 Dec 2020 03:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
 <xmqqeek2cc14.fsf@gitster.c.googlers.com> <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
 <xmqqpn3lbhxn.fsf@gitster.c.googlers.com> <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
 <xmqqlfe99yvy.fsf@gitster.c.googlers.com> <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com> <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com> <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com> <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
 <xmqqtussirsl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtussirsl.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 05:33:35 -0600
Message-ID: <CAMP44s3CcNAT4dFogyo61zV+D1pZ-0K+1rDBk_BUk-RYVUW0RQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 4:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> And when we stop in such a manner, it is sensible to give an error
> >> message telling them
> >>
> >>  - why we are stopping,
> >>
> >>  - what they can do to move the immediate situation forward
> >>    (i.e. command line option that lets them choose), and
> >>
> >>  - what they can do to make their choice permanent so that they
> >>    would never see the command stop when facing a non-ff history
> >>    (i.e. the configuration variables).
> >>
> >> Up to this point, I think both of us agree with the above.
> >
> > I don't agree with the above.
> >
> > The error I propose is just:
> >
> >   The pull was not fast-forward, please either merge or rebase.
> >
> > That's it. Nothing more.
>
> It says "why we are stopping." quite well.  It would be a good
> message to use as the first part of the three-part message I
> mentioned above.

The two key parts of the message are:

1. It is an *error*
2. It is *permanent*

> > I explained that was the final end goal in my list of steps [1]. I do
> > not think any suggestion for commands or configurations belongs in a
> > *permanent* error message.
>
> In the design I have in mind in the message you are responding to,
> the users who haven't told their choice to Git would be the only
> folks who get all three.

What would that error message look like? And do you have any other
example of the current user interface where such a condescending long
error message is displayed?

> You want to let the user express: "I do not want to choose either
> rebase or merge.  I want 'pull' to fail when it needs to deal with
> non-ff history.  But I do not need to be told about command line
> option and configuration every time."

That's right.

> I said I don't (I view that disabling half the "git pull" just a
> safe fallback behaviour until the user chooses between merge and
> rebase), but if we wanted to offer it as a valid choice to users, we
> can do so.  We just make it possible to squelch the latter two parts
> of the three-part message---you leave pull.rebase unconfigured and
> squelch the latter two parts of the message, and you got the "stop
> me, I do not merge or rebase, but don't even tell me how to further
> configure" already.
>
> I agree the latter two should not be part of *permanent* error
> message.  And my suggestion did not intend to make them so---it
> should have been quite obvious to who read the message you are
> responding to through to the end and understood what it said.

It doesn't matter (much) if it's temporary or permanent, it's still an
*error* message.

Currently it's a warning, and people are complaining, even though the
pull still works.

And you want to make it an error, and *always* fail? Even though the
user has not been warned that such a change was coming and how to
evade it?

I'm against that. I would rather do nothing than intentionally break
user experience without warning.

Johannes said he didn't mind the warning. I want the warning to
remain, just make it a different warning. You want to break his
experience without a grace period and suddenly make it an error.

> Now, how would we make it possible to squelch the latter two parts?

...

This is irrelevant.

As long as it's an error I don't care if it's short or long. I'm
against turning on an error from one version to the next.

> > The reason "pull.mode=ff-only" needs to be introduced is that
> > --ff-only doesn't work. Otherwise there's no way the user cannot
> > select the "safe default" mode. It has absolutely nothing to do with
> > what we present the user with.
>
> I too initially thought that pull.mode may be needed, but probably I
> was wrong.  I do think this can be done without pull.mode at all, at
> least in two ways, without adding different ways to do the same
> thing.
>
>  - When pull.rebase is set to 'no' and pull.ff is set to 'only',
>    "git pull" that sees a non-ff history should error out safely.
>    The user is telling that their preference is to merge, but the
>    difference between merge and rebase does not really matter
>    because pull.ff=only would mean we forbid merges of non-ff
>    history anyway.  The message you'd get would be "fatal: Not
>    possible to fast-forward, aborting." though.
>
>  - Or with the advice that hides the latter two points, a user can
>    unset pull.rebase and set the advice.pullNonFF to false to get
>    the same behaviour (i.e. disable the more dangerous half of
>    "pull") with just the "we stopped" error message.

So, after your hypothetical patch, there would be no difference between:

  git -c pull.rebase=no -c pull.ff=only pull

and:

  git -c advice.pullnonff=false pull

?

> I think either of these are close enough to what you want, and I
> think the latter gives us more flexibility in how we tone down the
> message with advice.pullNonFF.

You are missing at least two things.

I'll wait for your response.

Cheers.

-- 
Felipe Contreras
