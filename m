Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62DCC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21EC61353
	for <git@archiver.kernel.org>; Wed, 19 May 2021 12:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbhESM1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbhESM1J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 08:27:09 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BEC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:25:50 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id j19so2744007vkj.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xC+nZ3kl+Xtffzr5XdWhDYvqZT22iwzlUBxhN27Ii8=;
        b=OojkEuUpcKBFD+G9S6pBRXWEO9Ck1R2CeoxNlVSGxuguZB+1u5UgyL2ncfz3LXNC+n
         KMPMZdMeigAViNao/mYX/2QcpAVkfVT+5xR6qi+fcbBBCSMYgLchreC72Na9hnvod+IV
         i+DEkwHRV+gnrj8vZ6UafrazVCUnaaKUQCg9nxVamMpInDqhQbkeD79UZnDP4PNQphJd
         JvfcfwCwsdLrchSdIMhDAcVmNnZeYzXUxUFyoy2rUJQo6DaT5HnuLTLpMjnWyYsisRuT
         bu9SBhClaAahzbJbzmP/bkJEMvJcDL1EzMvd/6AXELeFsPXWiOw2BY7sO3Y4xVpy2lV8
         0IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xC+nZ3kl+Xtffzr5XdWhDYvqZT22iwzlUBxhN27Ii8=;
        b=MdNd7dy6/K5mjw3AZXWJvjrkukcvSI52c3sh7euAIPT8m0ZU05x4142Q7z7nxwG8bh
         ERx8THGx5MHlz78NDJE2Ql6cPOu5swUeARVTF4iKllqoPX4DNPhySgyHwV8T9IUMnLff
         h/3PvvmJy0UnPhD2AYXEw5S9M5e8vgY8PWxBkbTM+p85u2ifNaqIBJxVx+JC5OBzjJc9
         C3RjaDYE/jDW4Ic9jbnFjTaTBRyMd8rvgaWKJoVo23rMu7U4KTNvpOYH2rmqdQyRr09u
         tE4Sl7xAlQpAy04n393rnbmLeSPPnzNcPCxvof8GTUO4NWQUYe7Ei7g+I/xrcKMv6SI/
         nnXw==
X-Gm-Message-State: AOAM533hPSdti0qXVZZmAYukoAlMMkkbcPye4Q7ujIfqFrz6hpNxayEe
        W8d9RasXHDfd9pk7VeRtIilb61G3THcV5WTsLNOoGw==
X-Google-Smtp-Source: ABdhPJyyTPCZNxUDIyuX6k6XHPjAQXwWhUXGCBTh9AI2lRGu6gO2xx1YszJd6ghyCbdjRUXeh71MmWVmqg9jFrl4dEk=
X-Received: by 2002:a1f:99cc:: with SMTP id b195mr12801650vke.25.1621427149156;
 Wed, 19 May 2021 05:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
 <xmqqk0okebtb.fsf@gitster.g>
In-Reply-To: <xmqqk0okebtb.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 19 May 2021 14:25:37 +0200
Message-ID: <CAFQ2z_MCySh2p+fL0uL8tAQhkpbnkGF6e=NOYicpAxN582aqag@mail.gmail.com>
Subject: Re: [PATCH 1/8] refs: remove EINVAL specification from the errno
 sideband in read_raw_ref_fn
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 4:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > A grep for EINVAL */*c reveals that no code inspects EINVAL after readi=
ng
> > references.
>
> We often use a pattern (which is common) like this:
>
>         if (some_func_in_ref_API(...) < 0) {
>                 if (errno =3D=3D ENOENT || errno =3D=3D EISDIR)
>                         ... it is OK for the file to be missing ...
>                 else
>                         ... error ...
>         }
>
> If a piece of code currently sets EINVAL to errno manually when
> signalling a failure by returning a negative value to communicate
> with such a caller, we wouldn't see EINVAL mentioned, so such a grep
> alone would not help us guarantee the correctness of an update to
> stop assignment of EINVAL at all.  The callers must be vetted more
> carefully than "we are happy that nobody explicitly mentions EINVAL".

Sure. I looked at the callers, and documented further what I looked
for. But how far should one go? It's a global variable, so
transitively, almost all of the code could be observing the EINVAL
value under very specific circumstances. But it would also be a
terrible, fragile coding style and use of undocumented behavior.

> > The files ref backend does use EINVAL so parse_loose_ref_contents() can
> > communicate to lock_raw_ref() about garbage following the hex SHA1, or =
a short
> > read in files_read_raw_ref(), but the files backend does not call into
> > refs_read_raw_ref(), so its EINVAL sideband error is unused.
>
> This paragraph is confusing.  It says EINVAL is used to signal
> lock_raw_ref(), and it says EINVAL is not used by the same files
> backend.  Which is correct?  If one part of the backend uses it, and
> other parts don't, wouldn't the backend as a whole still use it?

I tried to clarify the message. files-backend.c makes assumptions
about the errno return for files_read_raw_ref, but it's not making
assumptions about the abstracted API in refs.h

> That is because there is a codeflow like this:
>
>         if (files_read_raw_ref(...)) {
>                 if (errno =3D=3D ENOENT) {
>                         ... do various things ...
>                 } else if (errno =3D=3D EISDIR) {
>                         ... do different and various things ...
>                 } else if (errno =3D=3D EINVAL && (*type & REF_ISBROKEN))=
 {
>                         ... deal with broken ref ...
>                 }
>                  ...
>         }

as mentioned above, this isn't calling refs_read_raw_ref, so it's not
affected by this patch.

> > + * Return 0 on success. If the ref doesn't exist, set errno to ENOENT =
and return
> > + * -1. If the ref exists but is neither a symbolic ref nor an object I=
D, it is
> > + * broken; set REF_ISBROKEN in type, and return -1. If there is anothe=
r error
> > + * reading the ref, set errno appropriately and return -1.
>
> So, this is not sufficient to let caller correctly and safely handle
> errors.  "set REF_ISBROKEN in type, set errno to something other
> than ENOENT or EISDIR, and then return -1" is necessary, I would
> think.

I tweaked the comment. Note that the function has only a handful of
callers (and only one caller where this behavior is relevant), and
it's changed in a follow-on patch in this series. Is it worth the
effort to wordsmith this further?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
