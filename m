Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BFAC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B156061416
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 14:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhGEOTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEOTb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 10:19:31 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48D9C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 07:16:53 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id q3so6846110uao.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c4a6XUnL50JpOq6NSCuk4revA/W1tlrbZlIppSecH1U=;
        b=JESbO9CT8IooOqOYRFdJLngFiAHggDmx8uMLFPQwr7nYLwfsYrfNYVn1SCLASB+OfN
         p7fepzkbk4hiHsdBEPrtRe/PzrsFWsgdukwj43ZTitRSHRjfpwkTzpLt1E4Hk/K+fRiC
         BLkhhdXzVQ1tul7yLGHwRYl8jzJsWBHJF5AbWAY6dBoNTqiRVygo/FnpexjHwpeDbIcg
         WJVMpEUKNNfS/nI6h7NKm6fdg5GL20VBX653AVoEiPHJeDrjyiyemMrruDtWyy51fIj1
         Ba1yjdnx0wAXxh/tRQGX8oZuYHL9k2mQk+B0oZ72M8aVq71Til9okMWs6bdlrW+YUcoZ
         9+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c4a6XUnL50JpOq6NSCuk4revA/W1tlrbZlIppSecH1U=;
        b=WkFTrbaJ7hyS+qHe4bed58FjDQhuBTXjGV1FNYJfM99ofOOObX4Yu5gxFcXZQv95PE
         eSMyPoPpYigl22u0KLnwoID0twAAnFcoML4FOGcAOQbWJmuuF/K+qT/SjDJ7wb9Wg/iu
         Uo//3Rp+TzadGwO3ntTAc5cnM97sVM4F0pqPtx1Pptsgu2OIgciJUFlo17uHJa0uI8kk
         EnvRU7Yq5JS0/mZvXoLGMvpPrgYZfwIfwUx/+2TIMBW7jV6y3xAOojZP5HDg2OgxsMqt
         rJNQhQg5RnKdwfmdV5OK1Ur64+ERVQoBmXScoRLyBkzYbF+fTBKOB7D5EL9trDtu+fCv
         a1Yw==
X-Gm-Message-State: AOAM5321FQ3Z5e2n2PwujLq/xwU6rUL10xZa3bbUPiCb8SzPHjzso3hA
        vRhddQMxuBupOdUWGqu+GaEJao1XTJxhiRw1MuthJQ==
X-Google-Smtp-Source: ABdhPJxTrVDIfF4xaEqCutF2NVKtg3CRjEoxZMRx1K4wSKA+wl9zmTJXbqbZ+8nhMRtnhVaV4HAdX3EO3YIAoB6f0T0=
X-Received: by 2002:a9f:3ec6:: with SMTP id n6mr10186779uaj.87.1625494612724;
 Mon, 05 Jul 2021 07:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com> <cbe09a48036c0befafa0f26f72d188dc765f5b7b.1623329869.git.gitgitgadget@gmail.com>
 <87k0mae0ga.fsf@evledraar.gmail.com>
In-Reply-To: <87k0mae0ga.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 16:16:41 +0200
Message-ID: <CAFQ2z_NpyJQLuM70MhJ8K1h2v3QXFuAZRjN=SvSsjnukNRJ8pw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] refs/files-backend: stop setting errno from lock_ref_oid_basic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 1, 2021 at 1:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> >       }
> >       if (!resolved) {
> > -             last_errno =3D errno;
> > +             int last_errno =3D errno;
> >               if (last_errno !=3D ENOTDIR ||
> >                   !refs_verify_refname_available(&refs->base, refname,
> >                                                  extras, skip, err))
>
> ...this particular change gives me some pause, because all the rest is
> about squirreling away our own errno for our own caller (which it turns
> out, we didn't need).
>
> But in this case we're only guarding against
> refs_verify_refname_available() possibly clobbering the errno we just
> got on !resolved in refs_verify_refname_available().

This comes from 5b2d8d6f2184381b76c13504a2f5ec8a62cd584e

   .. invoke verify_refname_available() to try
    to generate a more helpful error message.

    That function might not detect an error. For example, some
    non-reference file might be blocking the deletion of an
    otherwise-empty directory tree, or there might be a race with another
    process that just deleted the offending reference. In such cases,
    generate the strerror-based error message like before.

I think we want to keep this behavior, hence I think this should be kept as=
 is.

I'll add a comment.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
