Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C087C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2D611BF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFVDSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFVDSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:18:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE0C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:15:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u11so17101476ljh.2
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2f8mOEw/1uQn0tbX/jPfTx1K7YflidRGkZ1sonphU8=;
        b=cOANKq6dwvz9/1I7zOn0I7iPfbDiGyBWlG3vKxEWAljVCzF1WMdAOZci4vObotLRhs
         TdwVS0ZlaWmkZDlbI9gTjhgDkEQUPGMGGAowEblHYyeUUL+gQcAE1VKQhdQlV9d3xbgP
         uIiCNCj4Iv1Q4/X8jpv+ISto29xk2OyQiMfE4pWiX4mhGgujAXEgTmQol6u0YnC3CCGB
         3xUpgflF0Q0/nY44Opk2N3Mkkk1GCYb23JY77g+jwiv/+EO2MS6CDG4Ug+5glhUzVsKx
         k+PC8aVZoOuvU2C2uAmIn5e3GiWKYOUIv1J8L68oYotNautfcwIJAuTVRat8Er3mkaE1
         lzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2f8mOEw/1uQn0tbX/jPfTx1K7YflidRGkZ1sonphU8=;
        b=BuKiDPkso46YP9DhD0wPtTxOzJYfBXQkzdsdDvg/dGCI6L9wCnbLBWUUgrxxhGnayr
         RRDu7aYZoZZCcw4akvLUtpJwgE2R2GzdfiHEOLU09YIv0Prjn76gKjQWxaQS8KEDc7AH
         5xHC6pHDjbMc1AIA3wFz0m5nVFn0sxT8qxozfwDLtzIvMWD15Q6/fr7UeLY7a5jpIRZe
         PHnZOEYfAb8XAqPpQ+ZaReSs6XKLTBCGsXxTAQXDneCsT8fslNufCFvtAB/Fx2GglXpY
         2jA4rn+O24f3sSNa9sW8HRrn77aIAUslvrUNTIqPRpuoo7o5Vw6GxA6W/IZQkLyQ8dvv
         RxuQ==
X-Gm-Message-State: AOAM530fbPpav2JrSMGBLIMTSPmlpQ5wOVSl3C3qgbtQy6YkqN4G50qa
        N6T9dPFlVYfdrA+FynWS/0Mum2L6y9NA0dOjat8=
X-Google-Smtp-Source: ABdhPJwc3H1E3tsZ0ll3lkLlWkr+CVX8T5ac3MIva+1iH98PFXSJn+OJm6/E/XOtt1j0iTK//M2Z19KPddNjuScN8XQ=
X-Received: by 2002:a2e:a0c2:: with SMTP id f2mr1200122ljm.36.1624331743127;
 Mon, 21 Jun 2021 20:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
In-Reply-To: <60d10ebd99d86_113139208cd@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 21 Jun 2021 21:15:31 -0600
Message-ID: <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 4:12 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Alex Henrie wrote:
> > On Mon, Jun 21, 2021 at 12:51 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > Alex Henrie wrote:
> > > > The eventual goal is to get rid of the default here and make the user
> > > > make an educated choice, which does imply some work on the user's
> > > > part, but it avoids the massive headaches created by users merging
> > > > without understanding what they're doing.
> > >
> > > Indeed, but any minute change in git's UI is a gargantuan task that
> > > takes several years--or even decades--to accomplish, if it ever happens.
> > > I started this patch in 2013, and here we are.
> >
> > Although what needs to be done had been envisioned by some as early as
> > 2013, the warning has only been around since Git 2.27 (released in
> > June 2020), and it was only restricted to pulls where fast-forwarding
> > is impossible in Git 2.31 (released in March 2021). The good news is
> > that (unless I'm mistaken) there are no more changes that need to be
> > made prior to changing the message from from "advise" to "die".
>
> There is *a lot* that needs to be done.
>
>  1. Update the documentation
>  2. Add a --merge option (instead of the ackward --no-rebase)
>  3. Fix all the wrong behavior with --ff, --no-ff, and -ff-only
>  4. Add a pull.mode configuration
>  5. Add a configuration for the mode in which we want to die
>  6. Fix inconsistencies in the UI

I agree with you that the documentation should be updated when the
change is made (#1), and maybe there should be a config option to go
back to the behavior of warning but doing the merge anyway (#5). The
rest I think are things that would be nice to have but don't preclude
making the switch because aborting instead of merging would not
introduce any new UI limitations or inconsistencies. Of course, it's
ultimately up to Junio and the wider Git community, and I would love
to hear their thoughts about it.

> In the meantime there's no reason to have subpar documentation.

My only serious objection to this patch is the instruction to merge if
you don't know what to do instead of asking the repository maintainer
what to do or reading the Git documentation. I don't have a strong
opinion on the rest of the patch.

-Alex
