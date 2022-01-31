Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72243C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381218AbiAaVsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345541AbiAaVrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:47:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A998C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:47:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id o12so47227769eju.13
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vCTGs1bRteaWSpQ5GhWC1+kJqbiGlhadV5T+V0k3I5w=;
        b=TaWgtyoIgC6VejUZyIMkVCB9gaPHSRUNj1oV3o8898FXfQklCy2KqB+W+dJZGS7DYE
         bk89ZpQiyZBva+j1QMPrGDO2y6FZpHpMwQ8QUldczntUfIWpCJZ7lEAfedkgl2NKiP3e
         Gxt9flmWumzdwknwchCTAkLnpeUN5WMqbvSwRf2myHEr4W1WztjFG2WQqv3XQbyWajVb
         4pzHnmIy5b1jNx22EmbD/xIhe+B+VxtUpOvszio9NVJUsz2ZXUiNJOlV4ALW5gDHX74j
         Hg+mQyHsejCyeZBNBiAbdUP5cOH25W7Y92KHoIbv68nrS2JCZozd9xhwpqownDZ9AP7c
         RbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vCTGs1bRteaWSpQ5GhWC1+kJqbiGlhadV5T+V0k3I5w=;
        b=LjqtQjThuiJ6V3y0GI1YMhPoK2JyGMp032sdhIXFEAmXrIUetJRK5V+wIf61uMNo4S
         qOEBugYYz7JXiTJYKt4yQoesHuCW93lcMTUpzkIsVx/tp4/bRo6cs3qSAQ5xSSK2JF2G
         kBihJPtK7O6S+uL/Gnjx9QUSnwbVNoOYHYsNPQ0LHu0b5AyA8W8ivb1ELQBgf/sz4T2s
         g0h//QiXAzMOgwvpazFZjUlPK270a9x1hdrozxPCGYXJlxKdEdu//u8kwAV2akpuyJuC
         JuhmuMgjPv+zECUcKz4Ng0BjrPHiQmpXUGgEbChHPxnCK7W8tTbIEiG0khk5oOIpfDCD
         nWog==
X-Gm-Message-State: AOAM533m4p+fGJorAzjl1sK1iAv+1nTUZjk1GtctJfm3gstkEZpMh+L8
        kKUN1D/M44weS/nhATRG7q8Q1VXu/jbsBrsR+VU=
X-Google-Smtp-Source: ABdhPJyiPnSjIiGy8s1c8rRb4okVhoyRmn3FwYdJBLXpL3YX6V6Ehdz+yFi8cXO8yIkr1qTUDSXdLcwf6ulKbe1AKqI=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr18649717ejc.493.1643665657595;
 Mon, 31 Jan 2022 13:47:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
 <220128.86ee4scn2s.gmgdl@evledraar.gmail.com> <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
 <xmqqfsp3kfm0.fsf@gitster.g> <CABPp-BHcS3nwupJSORUuVeVhGzrL3VqPm4YQSr7G-JuyLaqBpQ@mail.gmail.com>
 <220131.864k5jbo5h.gmgdl@evledraar.gmail.com>
In-Reply-To: <220131.864k5jbo5h.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Jan 2022 13:47:26 -0800
Message-ID: <CABPp-BGRPOdhqV0uXGR2YfroB5Q3K2C6DiQqCdAbG4Xoi2-d9A@mail.gmail.com>
Subject: Re: [PATCH] repo-settings: fix checking for fetch.negotiationAlgorithm=default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 1:17 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jan 31 2022, Elijah Newren wrote:
>
> > On Mon, Jan 31, 2022 at 8:57 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
> >>
> >> >> I.e. =3Ddefault should always be equivalent to not declaring that c=
onfig
> >> >> at all anywhere, and not drift to being a reference to some name th=
at
> >> >> happens to be "default", as in the GNOME case.
> >> >
> >> > No, we have the same problem as the Gnome case.  See this part of th=
e
> >> > documentation for fetch.negotiationAlgorithm:
> >> >
> >> > """
> >> >     The default is "default" which instructs Git to use the
> >> >     default algorithm that never skips commits (unless the server ha=
s
> >> >     acknowledged it or one of its descendants).
> >> > """
> >>
> >> That looks more like one of the bugs introduced when skipping was
> >> turned on for the "experimental" folks.  To fix this, without
> >> turning skipping into the default too hastily, there needs two and
> >> half things to happen:
> >>
> >>  * Give a new name for the non-skipping algorithm, and describe the
> >>    algorithm like the above.
> >>
> >>  * Describe "default" is "non-skipping" but "feature.experimental"
> >>    makes "skipping" the default.
> >>
> >>  * Support "non-skipping" in the configuration parser, so that even
> >>    when something else becomes the default, people can choose it.
> >>
> >> I would think.
> >
> > Sounds good to me.  I'm not very creative, so I think I'd just use
> > "non-skipping" as the new name.
>
> I can't think of a better one either (aside from my already-suggested
> "exhaustive"), but that's naming it in terms of the only other
> negotiator.
>
> Is it the case that the only thing anyone would want to tweak about the
> default one is its skipping behavior?
>
> E.g. if we were to make one called "smart-topology" or something (would
> skip sending some OIDs by assuming things about branch/tag topology,
> i.e. if you have X that probably includes Y) having negotiators "A",
> "non-A", and "C" would be odd :)
>
> We're unlikely to change the "default" negotiatior behavior at this
> point, so maybe some label that communicates "the old one" without
> implying deprecation? Perhaps "classic"?

Oh, sorry for forgetting your "exhaustive" suggestion; sometimes
weekends do that to you.  I actually like that suggestion of yours a
bit better.  classic could also work.

Maybe Jonathan also has ideas/preferences, since he wrote the "skipping" co=
de?
