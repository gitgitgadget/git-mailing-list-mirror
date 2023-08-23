Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B84C27C40
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 19:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbjHWTyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjHWTyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 15:54:00 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163A310C2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:53:59 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-570d0567929so122400eaf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692820438; x=1693425238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21ePEM0o+Hrj9u/QsfS/S0qmubECZbVXqxlZor2FNqo=;
        b=dfvca8qCIQieo8Dj1rj6mpeK5H1plkT+orJRYuEPfNsEHhHMuzr/IFfgKneFK/fz7b
         rB/dBnI9eNfYP4jH0jS0UiXnIbIAnoabUnoOoNd+nAa2SWXjL1U9xSPSXu4MlWamS26G
         hj4uKnZwDhDoGGBWQF6eb7K6Cvl6qnVgAvQa5L3nOF9N4p3/uq6mdzKni8cm4RyCDJf0
         jLYyllASwSir3a28SrEZl+4BX1BhSLN/3Sir3Ijx3lrZ35eC7Dg0q3kbsS+JMpJWyXVD
         CF1OEeTHbDzBI9eSFoHBwEqS0MA7q1mH2b/HWva1TDJG5GQJMpsdyScyu+O3O9lvuclt
         /+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820438; x=1693425238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21ePEM0o+Hrj9u/QsfS/S0qmubECZbVXqxlZor2FNqo=;
        b=E6qaBIc4TbpcT1rg7UFU6YlHYiixVlw6roHrwhcPMFwblT4YH0F2IXwIWX1aPCphlu
         HaxDs23XVX9Q4awe6+j7Sz/Gx92NjFy7gqWZm+gCYcIYsl6AiYm7HnXP/FDh6vCoVec8
         Kb/6AvQBc6h506aBS8zPPPF82LqwSpTrte0EF3fa0fNJlsrPAw1tZ5xGj/n9S4oI6FCU
         5qm/SPLKwl6aeRb5eZ+5rUNIS5OmN5mf0vQHAWU25CutkFoG+I41Y3u57+VzQx1NNeh0
         EbWqT0S+H5BI10d2QuZKL4ygDGkJljZIRQLdvBl7jiz54D9m2oOjyDnenH5vDHeQpyjb
         K+DA==
X-Gm-Message-State: AOJu0Yw8mAbsckjba6hTL/Kk1aO68XtwW43DfMFOzjlDs3QfBXC1oqGD
        TIRyfjAyACaTebVu3veUEmtRoEJEoiemWIXn+kk=
X-Google-Smtp-Source: AGHT+IGq3QUb7X3SP27I/kjQls1G2KgYweb0GR072wGacVbhy5XiXH0PdlU+RecvQr0mRNE9uCY3FieieE+HvFQImE8=
X-Received: by 2002:a4a:2a0b:0:b0:571:28d5:2c76 with SMTP id
 k11-20020a4a2a0b000000b0057128d52c76mr142939oof.3.1692820438307; Wed, 23 Aug
 2023 12:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230823032839.731375-1-alexhenrie24@gmail.com> <ZOZf4/DYOKqQLjR+@nand.local>
In-Reply-To: <ZOZf4/DYOKqQLjR+@nand.local>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 23 Aug 2023 13:53:22 -0600
Message-ID: <CAMMLpeRam03bmO0jnsbKQB7174xv12HJzTtC-6dHFbQDMKB5gA@mail.gmail.com>
Subject: Re: [PATCH] submodule: deprecate --recurse-submodules=""
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 1:37=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Aug 22, 2023 at 09:28:37PM -0600, Alex Henrie wrote:

> > +             if (!*arg) {
> > +                     warning(_("--recurse-submodules with an empty str=
ing "
> > +                               "argument is deprecated and will stop "
> > +                               "working in a future version of Git. Us=
e "
> > +                               "--recurse-submodules without an argume=
nt "
> > +                               "instead, which does the same thing."))=
;
>
> This advice says to use `--recurse-submodules` as a non-deprecated
> synonym for `--recurse-submodules=3D""`, but I am not so sure that is
> correct advice.
>
> In the pre-image of this patch, having arg be set to the empty string
> would cause us to fall into the path that executes
>
>     *v =3D parse_fetch_recurse_submodules_arg(opt->long_name, arg);
>
> which calls `parse_fetch_recurse()` -> `git_parse_maybe_bool()` ->
> `git_parse_maybe_bool_text()` which given the empty string will return
> 0.
>
> So here we'd be doing the equivalent of
>
>     *v =3D RECURSE_SUBMODULES_OFF;
>
> when trying to parse `--recurse-submodules=3D""`. Should this advice
> instead say "[...] Use --no-recurse-submodules without an argument,
> which does the same thing"?

You're right; I misunderstood the situation here.
--recurse-submodules=3D"" is indeed equivalent to
--no-recurse-submodules, and that's what the advice should recommend.

On the other hand, given that the empty string does the same thing
both in a config file and on the command line, maybe it's not a
problem to allow the empty string on the command line. Personally I
think I'd still prefer to ask the user to use a more explicit syntax.
Thoughts?

-Alex
