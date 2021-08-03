Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69250C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2D561050
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhHCXt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhHCXtz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:49:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C4C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 16:49:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u25so815073oiv.5
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YltKOh6Hg7KlL491X9+Z3Trq+TGdy/NdvQDS72kP8Eg=;
        b=SVkr6unSb7RaG9CrW5gppwjD9/QcdG5RY+jm//cN1G4Lic7P/vCe3TLy6lao2ayDEY
         9sJAHg/e3JNlQ9QVo6IMe1KyuP43w5Wi9o6swWbOKKmsWXaGCDwTD0oa1AMQFqiByQ8Z
         DChbzH1EXTekQXRwznXm+RPZ+hLZwwGlcIgIFKENf7DYW87ZMdP78hKhLhqJIxo5r48z
         xjKG2paWXaGBAAWGoEMgkXPt3pcS8MRMLifWC7Z8Dq4YyppQk94xZQw3LO+9ynZ6R0qF
         d519xuBwX47VPhWzj2W8Rg3H1DCIVrytvvEWN/CjaXXp93j5IuxCL2PBMtf/qv7RteJI
         CzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YltKOh6Hg7KlL491X9+Z3Trq+TGdy/NdvQDS72kP8Eg=;
        b=miVBlIkXspmYrqrVE588hnzUVFKY9MLBtEF35dh/hAPDyOIVRIm6siW3OSTuvwMHV8
         klQU9A/Wq61vLa2JQ77gnyyI+7GNu6rK/rSIfrNgTaHfwQ2jjufrtZx3WLkgTF0eGZKa
         x1WT7Mpo0Qbb8sweq4hzW2g20myGbwddP+KcflWvdSJPqLRg2mAiyB70AeTdapXwNMUv
         EqB4FV9RnmTZ5y1oc/xu/1GYlQerq4RJaZQPnDEFFXuZ0FIf9wdqXmc3HWtOWbqkoHI4
         kIUcO/jnkCbAQ60hnEsxqGgcGBD96XUqbZVCNGG7Hl62fzpQueX1D6SfXsqxSWqpQRWZ
         0gkg==
X-Gm-Message-State: AOAM532B1PlWfb+80tkN2bEu1sfdUfY1i5Zmpp3UxGSBEvD42q3y1IXN
        15k8ANocVkK8LsJbtlQKhdxDPLn4M8ItxU4UG6g=
X-Google-Smtp-Source: ABdhPJwxCaYP3/3TLF5os7IgbzwCVBfpwmCBQFnZTEElcmmIXcn/XvDGGrETO34are2X+xMLNaNwv4gLcDRhHo2gV1c=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr4912739oif.39.1628034582305;
 Tue, 03 Aug 2021 16:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <2a7169c8c1be425d4234e414c106ad1278aacdd6.1628004920.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108040104150.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108040104150.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 17:49:31 -0600
Message-ID: <CABPp-BG7tRqPo2pz4ab0LNB3pWT0hZ=PpqC1u-MZKU-_LdUvjw@mail.gmail.com>
Subject: Re: [PATCH 10/10] Update error message and code comment
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 5:05 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > There were two locations in the code that referred to 'merge-recursive'
> > but which were also applicable to 'merge-ort'.  Update them to more
> > general wording.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/merge.c | 2 +-
> >  sequencer.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index a8a843b1f54..24b62a9c532 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -738,7 +738,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
> >
> >               for (x = 0; x < xopts_nr; x++)
> >                       if (parse_merge_opt(&o, xopts[x]))
> > -                             die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
> > +                             die(_("Unknown strategy option: -X%s"), xopts[x]);
>
> Since we updated our rules to start `die()` messages with a lower-case
> letter, we could sneak in this change here, too. That would save
> translators one extra round.

Sure, will do.
