Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5C1C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFDC23137
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405704AbgLKN3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393478AbgLKN3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 08:29:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC090C0613D3
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 05:28:36 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id q18so1508287wrn.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eI4OZenneslnl3hixqpe/dbVh5fFTBVrRZgxTIuOyFY=;
        b=IP8qvaYxpxrv1c2s8IiKMcRZJq192f6FAENX+YIrFXLPDYMifOw8Ya6cVcdcwArbIf
         luo//q27DItUdaS0Si3oQ2khrdy2Tdq4ORiFXhOG7xJh7CxtxxTStWsqZC9IJgkJcRSB
         OYSuQaC0YGV06TWfxKPc1mYDww6XTQhG2qY4oVSejRWBeSixP0BAu7AxweJDXYASNTEA
         vwm6N8pEntk1TNeQTNCzEY6ITz0Awbrr+0NfwFXsDwd6ctFZQDADID9sYLT7/4zX9mtr
         IB6afhEl+drTwpoMqgMVzuOjrcr8T5yx4TEdSLaOG18R9RzZ5ddLcHm31Qhc1jOJn1B+
         1kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eI4OZenneslnl3hixqpe/dbVh5fFTBVrRZgxTIuOyFY=;
        b=P87mEKyWp4UUI5J5sAZBKWVQsfdJDbP7B0qRAuA7BAeo1f4MNgXNroBknrESIgmpQN
         ZhmQyivodx9VKx8O1wF08CDOx0z4ayNiznE4lnmhf30nZeJL29fPaGKFo8Lv2niR+/Oo
         cJxuVyjJVmeTXycIMxSQeHx4UhTw7mJf1rbnOAn0+zTjxfKpG3CI82Exm06mUJhObFpL
         +3aeRoIzUljf8JowRZ89vDF4CDFKsLd3w83NyYQGq2L1wN4owD4QZ9DrqHPN5SvJSAMZ
         UiKon6BYruxNePQ6iqT4w8Cdj1mdgqAWq141M0O7rPilLHs2JqsCpK9XpTgjGuBE2UxZ
         R7Qw==
X-Gm-Message-State: AOAM532D5PqoCXSkhNxlEMmFi3XjwBALyyGzX22rZ5LSCemsguwJ2kWc
        HI2eIF502GJ0M4jCPG3Zeuk04uB5rikv5QvkO34=
X-Google-Smtp-Source: ABdhPJxZZz97B6OOnJ1xYeXQ6WzjKZfqQt1ysGkssjdSV8HnN7pAtJL13CQT+w4h2e1rg6uoiojlt+W9Xat3FQpdAEU=
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr7071660wru.84.1607693315627;
 Fri, 11 Dec 2020 05:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20201210100538.696787-1-felipe.contreras@gmail.com> <xmqqo8j0io39.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8j0io39.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 07:28:24 -0600
Message-ID: <CAMP44s0uyxs4p+HJ5ZDrrKJs9wQW4tSCZzPonpvP=FcTGCcxSA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pull: stop warning on every pull
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 5:22 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > The discussion about making fast-forward-only pulls the default is
> > stuck on mud, and there's no agreement about what we should even
> > be warning our users about.
>
> The above perception of yours is mostly due to misunderstanding, I
> would have to say.  We are in agreement on what we should be warning
> about at least, assuming that you are expressing what you want
> clearly in the latest round of responses and I understood them
> correctly [*1*].

I'm not trying to be difficult here, but at every round where you have
stated what it is that I want, it's not actually what I want, and the
last round is no exception, in my option.

Let's assume that I'm not explaining clearly what I want.

In the last round you said you wanted an error, not a warning. That's
not what I want; I'm proposing a warning.

But that's not what I was referring to here.

> I do not know if others on the list agree, though.

This is what I was referring to. Initially there seemed to be some
interest, and suddenly that interest disappeared.

> I do agree that there is no agreement on the behaviour in the
> endgame.

See? I disagree.

I think the endgame is clear. How we get there is where there's no agreement.

> In principle, I am in favor of disabling the more
> dangerous half of the "git pull" command for those who haven't
> configured anything.  But I can understand those who do not want
> that behaviour, as the fallout would be quite big.

And who is that? Did anyone in the list express that they did not want
that behavior?

> > Even my straightforward patches about improving documentation, and
> > the consistency of the UI with --merge and other obvious fixes
> > lost traction.
>
> It may be obvious to you, but may not be to others on the list who
> spoke in the thread and who didn't speak but read the discussion.
>
> I did see potential goodness in the documentation update and that
> was why I offered polishment on top of your patches in a v3 round,
> but seeing the suggestions dismissed without convincing arguments
> before v4 was sent out would have discouraged even the most patient
> reviewers among us.  If you meant by "lost traction" the lack of
> comments on v4, that was my reason for not commenting.

I did not dismiss your suggestions, I replied to your suggestions [1].
You did not reply back.

Moreover, in patch 2 I saw you had some confusion [2], in which you
said you didn't see any value in updating the message without changing
the condition that triggers, to which I replied [3]: "Maybe it will be
clearer when I send all the patches."

That's why I sent v4; not because I thought the review of v3 was done,
but because we were stuck not seeing the evolution of the warning.

In v4 I went through every step of the evolution [4], and I went back
to what I said in v3:

  At this point we can update the warning to mention that we are inside
  a non-fast-forward case. But it's not necessary.

So I did not dismiss the suggestion, I replied to it, and put a pin on it.

You can certainly bring the same suggestion in v4, but I seem to have
convinced Elijah Newren that "fast-forward" can be used as an adverb
perfectly well, and it in fact is, in many places in the documentation
both internal, and external.

> In any case, these three patches in this round looked quite sensible
> to me, except for the tests in 3/3, and minor details of 2/3, both
> of which I gave a more detailed review and suggestion.

Great.

That should improve the situation of most users. And also has the
added benefit that it's 3 less patches I have to carry around on every
round.

Cheers.

[1] https://lore.kernel.org/git/CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqq4kkx9vzx.fsf@gitster.c.googlers.com/
[3] https://lore.kernel.org/git/CAMP44s1aYqzCVvELH8zULaTkOdgLSSAQ0LE8WfgQKLPfU2MHfg@mail.gmail.com/
[4] https://lore.kernel.org/git/CAMP44s2hUCd9qc83LReGyjy8N+u++eK6VjwGhDhrX0f0SbKmig@mail.gmail.com

-- 
Felipe Contreras
