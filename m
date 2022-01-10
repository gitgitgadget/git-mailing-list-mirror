Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F4C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiAJTCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiAJTCG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:02:06 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873AC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:02:06 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id o1so25305998uap.4
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S6feBxgKyWtiIS0N+wck1dE98S27WWlWsAjQ5RQi5To=;
        b=aC/lhZ3zPo0U+Im9c3U6eEPhLebLAhWnTG5DRfdtazzMmrISTAh+5salSRaHT7Oy6c
         eYA1vxHmpilGY2OVAAHVFZoto321oGfdfvuBhIFGCTiDBGN3mLKPe8eYhkwnqCRFFG2f
         cWh6YGDcUk8YeQXb5XbFloGNM6qo2PqFWpJtYAr5yc6uW5TBegnc9F63VuGaaPx1y9jZ
         ae2bXluFacqTLS7Scgp0iAWmkQIcamp/gTtt55S53CTsP9GFa11GgH8Aa9Z4eyujPlaq
         ddwCUa26Zo/xvlo+nohV33GdjJwu9arnsNu/Iiu+ySlvkp/0TFZrtwqrwMXRzHHcWXJs
         SbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S6feBxgKyWtiIS0N+wck1dE98S27WWlWsAjQ5RQi5To=;
        b=0CLlPDr20r0G/SXINtFW/spvj/tt27MHAGrCQUXhMIR/if0AeWy4enC8zLMrl30c5B
         85af4vxaA5iJnCLC+SALiP9Q/iFA9gE2yLxitzqgjMI9Qz3pj2DKK0zMU2N3PvjfcDAZ
         X1YWX7xtNIAHWExd0hu8OtB80eNKuA45IVJn9/BUsWMIN52cgzAgRUGvHhpFj6wIICfY
         hpAT2Bvl0/M1JHMDhV9PmQwRFhjtXu5s3Bx24cAdOm7JYZUDy8R/9qa+uZdhCC90+HUV
         ON/8f5Bg1dopwDQSMkF4o57IRr/9J2Fv4Zd415/HT+iYdf6uq6oKt+erEZIPn3m3AgZF
         5DHQ==
X-Gm-Message-State: AOAM530FlNWAv44ZMSTvECE6/i/5h1PNFC/fS0qwZKKfYuRZ+ZPPs0vx
        kZNsjkBZPAvlZeXz1KugcYJcxpXmHlodSI1au6/QWw==
X-Google-Smtp-Source: ABdhPJyxtGSOFHvHWTqiVsuzu1G7IYPViDVgv56BS+L+PTFswb4wemmgPW7VNK0TVnrtNEbbRL3EzgO8lh/BfIrTbxU=
X-Received: by 2002:a05:6102:419f:: with SMTP id cd31mr596406vsb.83.1641841325663;
 Mon, 10 Jan 2022 11:02:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
 <c01b1c335a33e5f44289c520a1634d071d882223.1640287790.git.gitgitgadget@gmail.com>
 <xmqqsfui4nkr.fsf@gitster.g>
In-Reply-To: <xmqqsfui4nkr.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 10 Jan 2022 20:01:54 +0100
Message-ID: <CAFQ2z_MEN2j-sHmGK4SA6N8P9bHvjO2=+G0XxXp_9vzLRxwKuw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reftable: support preset file mode for writing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 5:46 AM Junio C Hamano <gitster@pobox.com> wrote:
> >       if (add->lock_file_fd < 0) {
> >               if (errno =3D=3D EEXIST) {
> >                       err =3D REFTABLE_LOCK_ERROR;
> > @@ -478,6 +478,13 @@ static int reftable_stack_init_addition(struct ref=
table_addition *add,
> >               }
> >               goto done;
> >       }
> > +     if (st->config.default_permissions) {
> > +             if (chmod(add->lock_file_name.buf, st->config.default_per=
missions) < 0) {
> > +                     err =3D REFTABLE_IO_ERROR;
> > +                     goto done;
>
> This part does not exactly make sense, though.

why?

> If this were a library code meant to link with ONLY with Git, I
> would have recommended to make a adjust_shared_perm() call from
> here, without having to have "unsigned int default_permissions" to
> reftable_write_options structure.
>
> I wonder if it is a better design to make the new member in the
> structure a pointer to a generic and opaque helper function that is
> called from here, i.e.
>
>         if (st->config.adjust_perm &&
>             st->config.adjust_perm(add->lock_file_name.buf) < 0) {
>                 err =3D REFTABLE_IO_ERROR;
>                 goto done;
>         }
>
> so that when linking with and calling from git, we can just stuff
> the pointer to adjust_shared_perm function to the member?

I read over the adjust_shared_perm function for a bit, but I'm puzzled
why its complexity is necessary. It seems to do something with X-bits,
maybe for directories, but that doesn't apply here as we're only
handling files?
We also only write new files, so we never have to look at the existing
mode of a file.

With the current approach, the option is very clear about what it
does, and the unittest is straightforward: set the option, do a write,
and check that the files have the specified mode.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
