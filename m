Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA0C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443361AbiDVCcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443352AbiDVCcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:32:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402BDE3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:29:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a1so3125522edt.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHT2GTSReANdCs/z/L1g7EfhdZR3Zr+SMU+m3vsXGZU=;
        b=Y6eY+Bgng4Qs8KlFl88DReF8EVzsjpEZNC8GJWEpcnwO8JuLVxyVEcFeQqtko0kOxu
         jiqZ5gbkcg17EYtacjYQGlrD8CRT6sFAOpoCKHlKTMXJ2jvieiqwJUqr+Ht9WP3a1nI3
         AgxjIMheEb6HWAvS41FchAz3rOj4XYODrFhA1J2p/90usl+MeErRFiQmE+ocwrpXLU3y
         QggqjHFQwyjJZsT3hZ3Pik1bjx87El32ODxl6pHG+CDGp0U2hNuQ/0y86Cub5mC8UZFL
         BjipbGR/H5m2WIrJbdVu/VcpRmqR0cjOt87gCjG4Rv+qGY9gmHDEVC2EaZSFIQHbN37K
         KTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHT2GTSReANdCs/z/L1g7EfhdZR3Zr+SMU+m3vsXGZU=;
        b=uF82H50i8MnAoiSOJn4hwmvAaFXBIrnLkGAXa/HTMO5xDvWtFWnuNYAYsyUVkAiD2E
         iBes1IOHHJvP0Jd6+oCNxLYH8YeFLrSONGWTcB2agKkxEdSCPBNK83NJ4n00Di0uEGyO
         NWr1wFu3lY+UyvK5xBhDZJxx18qE+cesIUEgvxZFHn8OnoG5LNMnxmUKnFpkmZ/uDeCt
         0sTG+3AcmBWoAffGSQygY2unYi8cTurLuiAELyWAUVrRd0pIIKmLft/DFufA+UHIK9TH
         pnSXx2MYOiFKlbgZyd8eAoKE7bq0X7KgevWfbX/EDPa3jt7abukPrsIKq/iE3czKV3lu
         eEVg==
X-Gm-Message-State: AOAM530LGR8uTeT5unF6nnlewC2JqexjBj64QVirtu5FhrC/uwiPjg5K
        500v3aIHvAW5tqaRwExXqhaJXh7ObFho2muYBgc=
X-Google-Smtp-Source: ABdhPJylFhU82SRe9kErHqmP+T13SBTIhTHiBnT9tz26g9oeJh4jt/85ulVZTw0eU8qIze+lfoYhI3blsCnsqfZhZnM=
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id
 w9-20020a056402268900b0042215c4e17emr2606070edd.33.1650594594127; Thu, 21 Apr
 2022 19:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com> <a53179764bc5d411726a095a587ea728aa9a20d3.1647054681.git.gitgitgadget@gmail.com>
 <xmqq8rtcqnnn.fsf@gitster.g>
In-Reply-To: <xmqq8rtcqnnn.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Apr 2022 19:29:42 -0700
Message-ID: <CABPp-BGmmg7YxaZwerivWGAQ6J5cpc9pRrJkHwMUXArvRXZ+rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] sparse-checkout: make --cone the default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the long delay...

On Mon, Mar 14, 2022 at 1:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  The subset of files is chosen by providing a list of directories in
> > -cone mode (which is recommended), or by providing a list of patterns
> > -in non-cone mode.
> > +cone mode (the default), or by providing a list of patterns in
> > +non-cone mode.
>
> OK.
>
> > @@ -60,7 +60,7 @@ When the `--stdin` option is provided, the directories or patterns are
> >  read from standard in as a newline-delimited list instead of from the
> >  arguments.
> >  +
> > -When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
> > +When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
> >  input list is considered a list of directories.  This allows for
>
>
> I expected a change to Documentation/config/core.txt in this step,
> because the default value for core.sparseCheckoutCone becomes true
> if unspecified with this step, and the normal expectation by the
> readers is what is not explicitly set to true is either 'false' or
> 'unspecified' (when 'unspecified' has its own meaning, like in
> gitattributes).
>
> Something like this?
>
> diff --git i/Documentation/config/core.txt w/Documentation/config/core.txt
> index c04f62a54a..03cf075821 100644
> --- i/Documentation/config/core.txt
> +++ w/Documentation/config/core.txt
> @@ -615,8 +615,10 @@ core.sparseCheckout::
>
>  core.sparseCheckoutCone::
>         Enables the "cone mode" of the sparse checkout feature. When the
> -       sparse-checkout file contains a limited set of patterns, then this
> -       mode provides significant performance advantages. See
> +       sparse-checkout file contains a limited set of patterns, this
> +       mode provides significant performance advantages. The "non
> +       cone mode" can be requested to allow specifying a more flexible
> +       patterns by setting this variable to 'false'. See
>         linkgit:git-sparse-checkout[1] for more information.
>
>  core.abbrev::
>
> > -When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
> > +When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
>
> "is set to 'false'" would make it clearer.
>
> > +If `core.sparseCheckoutCone=true` (set by default or with an explicit
> > +`--cone`), then Git will parse the sparse-checkout file expecting
>
> "Unless `core.sparseCheckoutCone` is explicitly set to `false`"
> might be clearer, but I am not sure.  It is just that I found the
> phrase "set by default" confusing.

Thanks; I applied all three suggestions.

> >       /* Set cone/non-cone mode appropriately */
> >       core_apply_sparse_checkout = 1;
> > -     if (*cone_mode == 1) {
> > +     if (*cone_mode) { /* also handles "not specified" (value of -1) */
>
> The comment is correct, but if we can make the code not to require
> such a comment, that would be even better.

I had that in v1; I'll revert back to it.
