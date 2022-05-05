Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA257C433FE
	for <git@archiver.kernel.org>; Thu,  5 May 2022 15:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381055AbiEEPIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381034AbiEEPIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 11:08:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F5B5B8BB
        for <git@vger.kernel.org>; Thu,  5 May 2022 08:05:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so9305831ejb.4
        for <git@vger.kernel.org>; Thu, 05 May 2022 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgoY0jiV+79M1m/c+5/eYLNZGa9VAZyHXFqvCw/HOgw=;
        b=OMPTDsT16xgyCbK9sJfl+F5VFnCn8ZwfahYgudmo0o7Qvjcb/xtCoDQHwiAutgREJh
         aMsKr2+yIIZnawpp7jRbsKRRdUqeGR+BR6Zxc1qSn9BK8x3+WnY6ekd6w5txLCkJnmY4
         St3XN+Grg1lorXnx2MYw9EqlEtuGrSd9dcTdIvDEaz32VFUzOpLG9G2AWprJeZYiLRT9
         YKoQy1luuqnn5eSR3YVmfl2kbLrT5y+CQcKkOu8Nz494ATDkamu7vdCDwIfzf7QotRM2
         wY1tHxrVeApA9LH0Ja9gZJfFqB0hRb6Ue/IIiZpAPzzGP1XrX4lwRYY51Vj8w8NFQV3m
         kG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgoY0jiV+79M1m/c+5/eYLNZGa9VAZyHXFqvCw/HOgw=;
        b=lEhHrcyD1x3HYbOSCeW/KiUK9F+vTA3dZOIN8nu4kze6KpTbQ3GMYktVdkZvkBNXLr
         +uuDrbfTJzmOuyVRDFojUuaOKPrAhwoiP2righACGTFlcy1Rzw16EoN5Aq9MyWLOOP8L
         zp3s/pi/A685RMkUyzKXblITe6osYb8CGFxXkADdRe5CcSNUoepkqo+dt7qbIbH/DGwb
         JDWgZeVYLVmRYQqow1d3oaKqE88rXYpThjPHMPy9v4Y2zMmFCi0pRAN6vkH0E/NGPB2T
         RjPlk2zVBhNPi7JsLo4/QbnK4c6gTv/AmxX10XivWD3jSAteAcHf6wRt04yVz78+2cYC
         V7gg==
X-Gm-Message-State: AOAM532axXoRzdDK6HB6LmeZBsGkdaljTdUaFACc/sjbikG58grHIw2u
        br5Y2jMNnPFc7fb2Zuczfbqyi81sFug4LrG1KY6sBFPScNs=
X-Google-Smtp-Source: ABdhPJyFvb9Pp+L1cn++lr81dNI0MJdEbB5U+xQubuYhGo5ZJ7oHrNOlwwFe3cpelwxKBCPAzMK1ZvBK+y4DRTzYDaw=
X-Received: by 2002:a17:907:6090:b0:6f0:2a64:2ef7 with SMTP id
 ht16-20020a170907609000b006f02a642ef7mr26510177ejc.476.1651763101514; Thu, 05
 May 2022 08:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilqnvacd.fsf@gitster.g> <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
 <xmqqy1zhmftk.fsf@gitster.g>
In-Reply-To: <xmqqy1zhmftk.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 May 2022 08:04:49 -0700
Message-ID: <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 9:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> >> * en/sparse-cone-becomes-default (2022-04-21) 9 commits
> >>  - Documentation: some sparsity wording clarifications
> >>  - git-sparse-checkout.txt: mark non-cone mode as deprecated
> >>  - git-sparse-checkout.txt: flesh out pattern set sections a bit
> >>  - git-sparse-checkout.txt: add a new EXAMPLES section
> >>  - git-sparse-checkout.txt: shuffle some sections and mark as internal
> >>  - git-sparse-checkout.txt: update docs for deprecation of 'init'
> >>  - git-sparse-checkout.txt: wording updates for the cone mode default
> >>  - sparse-checkout: make --cone the default
> >>  - tests: stop assuming --no-cone is the default mode for sparse-checkout
> >>
> >>  Deprecate non-cone mode of the sparse-checkout feature.
> >>
> >>  Will merge to 'next'?
> >>  source: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
> >
> > This has been quite stable and I'd like to see it merge early in the
> > release cycle in case that catches anything during local testing.
>
> This one I am not worried about stability all that much; I am more
> worried about breaking those who do not believe in "cone is the
> future" and managing their expectations.

What path forward would you like to see?

On v2 you said, "There are a few things that I found questionable, but
they were mostly documentation issues".  You brought up several points
in v2 where my wording in the Documentation was admittedly suboptimal,
though I think I addressed all of those in v3.

I also brought up an alternative change for consideration in the cover
letter, though you didn't comment on it and other reviewers, while
okay with the alternative, seemed to agree with my proposed changes in
the series over the alternative.

Also, it might be worth noting:
  - sparse-checkout, the capability in Git since ~2010, remains
unmodified by these changes
  - sparse-checkout, the subcommand added a couple years ago, still
supports all non-cone mode behaviors it did before
  - the change here is that the sparse-checkout subcommand's default
becomes cone mode, along with documentation updates
