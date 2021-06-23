Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F40AC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CE061289
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFWCW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWCW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 22:22:28 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66258C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:20:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso428934oto.12
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7Y9HcM/Wz4pKvcKX8Wd1kOEd198TEo9Z5VEvlcIpA0=;
        b=NegqGcefjtpFqssiFrAwEKkedUyu1asxrU2sCfJVSku8dzLBqQa/llLfuzwuRW5/J2
         AM7wkYOs7br+gixbmh0YU/2RfK6WvJQisYE2Lql8QiVQGvj5nehPEeJqbUcyP/qpHXiy
         hq0gMVICbJIv6ATQmqy2aW1Gwx6FKbFVaKoU6sIej96fFTlQvknD3wsUmepX+GkzsOkM
         QWpgS64Fz4dltWDjW5K42H2XJANaAyRMuWzFoFxLE7Jhi01BpMNQIqzK+c5DYx2gvtok
         8itcUfolMwT+A6FuSxaO89a4RtXYGx9n/ViYb1DwU3uyica7kdBnop/sCkA19sgXwL7z
         1Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7Y9HcM/Wz4pKvcKX8Wd1kOEd198TEo9Z5VEvlcIpA0=;
        b=Rt7opPz7Zw4lqPEr1aGlyuFPsWwN4ScTfn4+GGYJoLl5Lh3K51xePvzHiN45DBjRCa
         ra9PtN2J+YCFgHFgTc+32k/wz9qfcDDFzfwppgZyrS+wS8SFFCowGT5wCKefZipDyyLU
         lgCTsXOh7QY2qW3+o7HQIwsvmKDt9etYLZkX4f3RXANIRauN+0n7mCLspEoXbh5AvMR/
         XtiU1XKcwhMKGmswa3lXcVpy4XqODfilsFKt8cHLJIBCmj3C6s26F7+7T1/rmhxt+hnR
         jKRIgMJt+g9B/rEsafq2sazOB+goDO1PMEqPX8vYV5F7BVrlIzkLXHGs4E8Z7krFhwW9
         xMEQ==
X-Gm-Message-State: AOAM532KWt9u8cVVTnjAAxU45leVbBoQVZKqHezM4Xv6d4LxrfMGvht2
        zHBrZ4hZMsr56tC3FuumG1zYZliGfwb6q/5Pr0M=
X-Google-Smtp-Source: ABdhPJwOR7+WN1hPTr2HDAvyklASg6h1QcFgIQTY/lcVla7TuRLeEwNx+T/VRvhtJSPkNO2TflTaZz5HFbDA/2VWomk=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr5706807otn.345.1624414811767;
 Tue, 22 Jun 2021 19:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com> <CAMMLpeTmYcJHf1t7VpOBakMZ_vtk+9bmLRTMA9ueghG6WwCRtA@mail.gmail.com>
In-Reply-To: <CAMMLpeTmYcJHf1t7VpOBakMZ_vtk+9bmLRTMA9ueghG6WwCRtA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jun 2021 19:20:00 -0700
Message-ID: <CABPp-BEnPrg_tsqLtmj7Ag6JnR6ku_K3Uv65rdRu-j9_qMYhmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Tue, Jun 22, 2021 at 9:06 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Jun 21, 2021 at 8:15 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > >
> > > My only serious objection to this patch is the instruction to merge if
> > > you don't know what to do instead of asking the repository maintainer
> > > what to do or reading the Git documentation. I don't have a strong
> > > opinion on the rest of the patch.
> >
> > You're not alone, Alex; I objected to that part as well.  (See e.g.
> > https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com/
> > and various other emails in that thread, ending with "agree to
> > disagree" later).  I still object to it as I did then.
>
> Thanks for the link, and sorry for not having followed this
> conversation closely enough to have seen your previous replies. While

No worries, you were trying to be a good citizen by reviewing patches,
and the patches didn't come with links to the old threads (even if you
recursively followed links provided in each email as far as I can
tell), so I wouldn't expect you to know.  But I saw you expressing
similar sentiments as I had previously so I dug out my old email and
linked it.

> we're on the subject, do you have any thoughts on what (if anything)
> more should be done before making the switch to aborting instead of
> merging with a warning in `git pull`?

I think Junio already answered that over here:
https://lore.kernel.org/git/xmqq360h8286.fsf@gitster.c.googlers.com/
(he discussed it multiple times in that thread, but hopefully that's a
good enough example).
