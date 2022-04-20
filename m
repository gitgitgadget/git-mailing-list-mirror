Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE511C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354943AbiDTRov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiDTRot (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:44:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A147068
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:42:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq30so4303192lfb.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMvxgZ2Q+CXZ1CYwvSC1pmidW/Q1pfW1t36p5XcaBT0=;
        b=BQatZhr7eCsOEpeFLICBnNS2PCaaQ5gL8ISKHd8Ztz8KttgGP1dkfNGFCucrqwCyFz
         DfR3DFAxDuBxa6UGmxIlBs9VIUp5zn1fJLa3FVVS3pUwFQ/Jxx/llSyvuNulFYpfSMEb
         WD9gKffmemOUILbCvFR95NA6NMNGO2ED0E7GsSmNPKqWXvC1LgoTnqcKv3Fm9a6h+0IX
         Z6TOxWV0JNdLR4gH/LFcNilPF29c2FbVbRKBiZU0HES+M8y5wKMqbsqWIZs2PWV5fn9+
         C44ZkSzkd7BMqo/1cTh7iljQPNmxP5Qb7O9HhcK/DtIsr4jM5cRr+EZnsKWNPCdWJHyT
         gTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMvxgZ2Q+CXZ1CYwvSC1pmidW/Q1pfW1t36p5XcaBT0=;
        b=sEPNZc72Ot5z9E5Swyt5+HvAOwhEAfaCtvOdTTVZ4d3bMif5uEDSScTWsrXPws0St5
         YIQ8ylTtnXWxVo8upxFzVHD4nyb5E6vF04mVaZMMDeZJMryQxTb8Wd4lNV/Qfv9CONNS
         oNUAbc5vZtBYt2CAVJtSd1FeRC46jIPn0D20Mjaz3fpaUA8LUVNCKK5GE3vHl5ULiOzc
         gEAIFDuBbHy3uPfgyAUf4HijMFDN4iY/WA4wM/lEOQxjeduE6lMInnp9MCdIRSTQPkTb
         vehQXsP8vkclv7wKA0Gjk6nX826ep853QmyfwxprMqX40M5nNqtNgUcm5IXhvoUNgYdA
         I+NQ==
X-Gm-Message-State: AOAM5314au7Eor6opOHmzqF0AR0Kiriv1fNSRBkbnRFouCvBcy3IiM87
        /ml+hC0FqmUELUTRvaVDaSMz9mOpEHLBfie4Zton2A==
X-Google-Smtp-Source: ABdhPJyPhUGeMjMJQ7QbcDSXGSZuE7g9oOGH5JiP9Cqf4eYtALwApgAYueJS6W/FsMtZiqek6skWj0meItw7j+G+WVw=
X-Received: by 2002:a05:6512:1287:b0:471:a86d:7b0d with SMTP id
 u7-20020a056512128700b00471a86d7b0dmr6465513lfs.361.1650476520343; Wed, 20
 Apr 2022 10:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <Yl9Hn0C0TwalASC0@google.com> <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
 <xmqqr15rr9k6.fsf@gitster.g> <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
 <xmqqilr3r7ki.fsf@gitster.g>
In-Reply-To: <xmqqilr3r7ki.fsf@gitster.g>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 20 Apr 2022 10:41:49 -0700
Message-ID: <CAJoAoZnw6cNBwWpa5w-rhQ4p_zw6w6Q-NHzNeRKrrqPpDCjY2A@mail.gmail.com>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 10:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> >> In the longer term, there are multiple possible action items.
> >> ...
> >>
> >>  * We should teach hooks API to make it _optional_ to use the
> >>    parallel subprocess API.  If we are not spawning hooks in
> >>    parallel today, there is no reason to incur this regression by
> >>    using the parallel subprocess API---this was a needress bug, and
> >>    I am angry.
> >
> > To counter, I think that having hooks invoked via two different
> > mechanisms depending on how many are provided or whether they are
> > parallelized is a mess to debug and maintain. I still stand by the
> > decision to use the parallel subprocess API, which I think was
> > reasonable to expect to do the same thing when jobs=3D1, and I think we
> > should continue to do so. It simplifies the hook code significantly.
>
> A simple code that does not behave as it should and causes end-user
> regression is not a code worth defending.  Admitting it was a bad
> move we made in the past is the first step to make it better.

I am also sorry that this use case was broken. However, I don't see
that it's documented in 'git help githooks' or elsewhere that we
guarantee isatty() (or similar) of hooks matches that of the parent
process. I think it is an accident that this worked before, and not
something that was guaranteed by Git documentation - for example, we
also do not have regression tests ensuring that behavior for hooks
today, either, or else we would not be having this conversation. (If I
simply missed the documentation promising that behavior, then I am
sorry, and please point me to it.)

>
> The use of the parallel subprocess API in the hooks was prematurely
> done, before we had clear use cases for running multiple hooks in
> parallel, and due to the lack of use cases, we didn't have chance to
> think about the issues that need to be addressed before we can start
> using the parallel subprocess API.  The message you are responding to
> was written with an explicit purpose of starting to list them.
>
> >>  * the hooks API should learn a mechanism for multiple hooks to
> >>    coordinate their executions.  Perhaps they indicate their
> >>    preference if they are OK to be run in parallel, and those that
> >>    want isolation will be run one-at-a-time before or after others
> >>    run in parallel, or something.
> >
> > There is such a mechanism for hooks overall, but not yet for
> > individual hooks. I know we discussed it at length[1] before, and
>
> This...
>
> > decided it would be okay to figure this out later on. I suppose "later
> > on" may have come :)
>
> Yes, besides patching up this regression for short term, I listed it
> as a possible ation item for the longer term.
>
> >>  * The hooks API should learn a mechanism for us to tell what
> >>    execution environment they are in.  Ideally, the hooks, if it is
> >>    sane to run under the parallel subprocess API, shouldn't have
> >>    been learning if they are talking to an interactive human user by
> >>    looking at isatty(), but we should have been explicitly telling
> >>    them that they are, perhaps by exporting an environment
> >>    variable.  There may probably be more clue hooks writers want
> >>    other than "am I talking to human user?" that we would want to
> >>    enumerate before going this route.
> >
> > Hm. I was going to mention that =C3=86var and I discussed the possibili=
ty
> > of setting an environment variable for hook child processes, telling
>
> That...
>
> > them which hook they are being run as - e.g.
> > "GIT_HOOK=3Dprepare-commit-msg" - but I suppose that relying on that
> > alone doesn't tell us anything about whether the parent is being run
> > in tty. I agree it could be very useful to simply pass
> > GIT_PARENT_ISATTY to hooks (and I suppose other child processes).
> > Could we simply do that from start_command() or something else deep in
> > run-command.h machinery? Then Anthony's use case becomes
> >
> > if [-t 1|| GIT_PARENT_ISATTY]
> >  ...
> >
> > and no need to examine Git version.
>
> But DO NOT call it ISATTY.  "Are we showing the output to human
> end-users" is the question it is answering to, and isatty() happens
> to be an implementation detail on POSIXy system.
>
> "This" and "That" above make it smell like discussion was done, but
> everybody got tired of discussing and the topic was shipped without
> necessary polishment?  That sounds like a process failure, which we
> may want to address in the new development cycle, not limited to this
> particular topic.

I think, rather, during discussion we said "without knowing how real
users want to use hooks, it's not possible for us to make a good
design for individual hooks to state whether they need to be
parallelized or not." Perhaps that means this body of work should have
stayed in 'next' longer, rather than making it to a release?

For what it's worth, Google internally has been using multiple hooks
via config for something like a year, with this design, from a
combination of 'next' and pending hooks patches. But we haven't
imagined the need to color hook output for users and check isatty() or
similar. I think there are not many other consumers of 'next' besides
the Google internal release. So I'm not sure that longer time in
'next' would have allowed us to see this issue, either.

 - Emily
