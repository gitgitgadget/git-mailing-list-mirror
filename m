Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB018C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 06:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiCGGSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiCGGSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 01:18:35 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4531615A2E
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 22:17:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gb39so29517551ejc.1
        for <git@vger.kernel.org>; Sun, 06 Mar 2022 22:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/mZ8c/+m/lJkP+WcMl8ClyxjjyVPPrxbQtD0ctAgAU=;
        b=agZ8mAg3gIV3lQaYYUkp0hBUFB5gLMvImmmBIZ0+YmiUSV8ucYzgxOuXlC77kpQQNG
         DqFTDK24i25FjtxJhDgI64lqqYeogyDvyXQ6UlALkG/OHpZW59gVcI+O2Nh2c4hRvCAK
         uU2OaOH71OWiFU7OP5T1nBccNtj/NquDiadXiCgNqtQszjPG3kdMUy4Ie7HwzYr41YD3
         H5LHr20YU30z9PKrLlMVxsOc6qGxLS5IbFrANoFmGfApXGRfUasOTMWfXU7/eO2fIlQp
         00aievessYpM0YXlfuYvDJAmLvYkpH/pJMWrZGIjU64mu2nbN7rYZDolcW98jFm+0kUS
         gL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/mZ8c/+m/lJkP+WcMl8ClyxjjyVPPrxbQtD0ctAgAU=;
        b=WDW1Rz/I8zdSXweR4HZaxmx/DJhqd3yUQf8a3y2uQNFiK0KkX4IwKsHKlg+uB562I8
         DceWoXP+Qlz1qbd+bwuRd4LIa3cHmpiScnrJIlKD2bbcW8pcfFOm6R0LToIHvh0Mkbcb
         yDsiHAnvCgRzpZEx3bpVaL1Kc21MV4kN4DI8fvDDfqw+DJ2sABS0Dvg4RKsP/SKj9rX5
         X2g3Htr5KbyYXJwL+Zg/adk7qGndAImUsOYQERdq1R7buoqldLYPn0LPOHpc+SifrtL9
         lpNYooPyOpYdFG+3TGye+x3pv75Bj1Uf63j7XKD7hXEmvcDUl46Sw0l1JjT1Ai9vB16g
         P18Q==
X-Gm-Message-State: AOAM531yUROD8Z9eG08Cn2ZK9S90yf1ox9PSNVXI6kFU6+UJXbzph9Pi
        szhUFa2oWPgonTmDcA031AcHWurgniKDNkwJxBpj6A==
X-Google-Smtp-Source: ABdhPJzVLr4csFh/ck3M+yHF5VFJvrPgglt/2OqLYRk1mNmCO0vArYQ2YSETnYTHJc/rBEMy8AVEyv+6F2xHrZ6tSgI=
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id
 i8-20020a1709064fc800b006d85059f998mr7918590ejw.487.1646633859807; Sun, 06
 Mar 2022 22:17:39 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com> <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqzgm2vjab.fsf@gitster.g>
In-Reply-To: <xmqqzgm2vjab.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 7 Mar 2022 07:17:27 +0100
Message-ID: <CAPMMpoh38fm-jNi=GD+uf6O+JLiJz-ue2zh5ceWpwmTYBRKzvw@mail.gmail.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 6, 2022 at 10:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Glen Choo <chooglen@google.com> writes:
>
> > Not that I would ever _recommend_ someone to work like this though.
> > Junio also wondered whether anyone uses this [1].
> >
> > [1] https://lore.kernel.org/git/xmqqbl2hw10h.fsf@gitster.g
>
> I actually think the current octopus behaviour is a sensible one
> (after all, that was what we envisioned how it would be used when we
> did the mechanism long time ago).  If you have mutliple, say source
> and docs, groups working for you and you are taking their work from
> time to time, something like this:
>
>     [branch "main"]
>         remote = central-repo
>         merge = sources
>         merge = docs
>
> would let your folks push into the central-repo, and a "git pull"
> will help you advance your main branch that you'll publish later.
>
> You can explain multiple .merge entries for such an integration
> branch like I just did and I think such an explanation makes perfect
> sense, but these are quite different from what we view as "upstream"
> in the traditional sense.  In the setting illustrated here, yours is
> the main integration repository, the center of the universe, and
> those folks working in the 'sources' and 'docs' groups view yours as
> their "upstream".
>
> So, "what does it mean to have multiple branch.*.merge entries" has
> a good answer: you are integrating from these contributors and these
> entries are not your "upstream" in the usual sense---you do not even
> push back to them.  Asking "what does it mean to have multiple
> upstream" makes little sense, I would think.
>
> Now, with the 'main' branch used in such a manner, if you did
>
>    $ git branch --track=inherit topic main
>
> and worked on the "topic" branch, you do not push back to either the
> sources or docs of the central-repo, of course, but it is unclear if
> you even want to "pull" to create octopus from these two branches at
> the central-repo, which essentially duplicates the pull's you would
> do on your 'main' branch.  I suspect that you'd rather want to merge
> updates 'main' accumulated (or rebase on them).
>
> The reason why I asked what Josh's plans are for the multiple .merge
> entries in that thread [1] when the "--inherit" feature was being
> invented was exactly about this point.  I wondered if last-one-wins
> may make sense (and as the above octopus set-up tells us, it may
> not), but if we want to keep "multiple .merge entries means an
> integrator making octpus merges", then it may make sense not to copy
> them when there are multiple with "--track=inherit", to avoid
> spreading the "curious" nature of the branch like 'main' depicted
> above.

Given that the notion of "inherit"ing the tracking configuration is a
(relatively) new one anyway, and given the slightly esoteric nature of
the "multiple branch merge entries lead to octopus merges"
functionality, I would argue that it makes more sense to die when
branching under this specific configuration, saying something like
"inheriting the tracking configuration of a branch with multiple
branch merge entries is not supported - we think you're making a
mistake".

Skipping the creation of tracking entries in this case, even with a
warning/explanation output to stdout, would be a "slightly hidden
surprise", in that git command output is often not read by, or even
visible to users when a command is successful, eg in a GUI.

If we think this will basically never happen and really makes no sense
anyway, as Junio seems to suggest, then I would argue the extra
complexity in the codebase to support the "inheriting multiple branch
merge entries" is unwarranted.

Either way, I will happily drop this topic as it does not appear to
require follow-up in direct relation to my "--track=simple"
work/proposal. On the other hand, I'd be happy to work on a patch to
eliminate this multi-tracking-branch-inheritance path/support (undoing
some of Josh's work here) if the team believes this makes sense.
