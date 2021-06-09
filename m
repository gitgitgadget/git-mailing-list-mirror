Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625CC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1648C61184
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhFILay (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhFILay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 07:30:54 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBE3C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 04:28:43 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id x8so12648991vso.5
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 04:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2iMmhnsjM1KJetrWqty9B/0ySkfBIxXePR5ff5sGGLU=;
        b=q+MxM2hoCIlHh2Uu9VkHQJTGPVF7zCV1S3YyPoI4Q7IVnhhZZhrl6pjAG+dT06XXtI
         J0J771DiubG6hPdnjkuVJHN3jIfAXXcMPwK5P7cGHPn0SqYgUsXnlnEVOxwWcTNxADPf
         I2ujQoe9SH5n5fbCXdDWYXmxWSnERlsFxubKfzEkx3dsBQ9kT1cBZ6sUa6wes43NREZg
         60AwnN5G/PnDsJ8QFo9EqXIDtAlZ5xOcbUD9hb4lD2Vca+Kwan9fqdUj0S83WZvsY1fJ
         ZHdcI0WZhiVtvjaCi6k33KDK1g6LBqAOb7rqgLy5nxYG9yO5fMkQn+bdIk96goqFP1q0
         7YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2iMmhnsjM1KJetrWqty9B/0ySkfBIxXePR5ff5sGGLU=;
        b=oZAMLZ3vix+hW9aL66zsNs2xvCcUHJwzv18ApMRylVwDts4BeFYw+cdzkFPYA0pJGe
         UYNcm4TD8SDkYsjO4I8He1LzR+iAKyCtG9TI6O5aNs3t1JJu1DFQkpEA2QZAqWVOcfCZ
         vBXI4BAllx5feIJShb+4aaJX+IWZT9dJV75GnkAOrqGvdQAMhVC0mpR1mA0C8iLydE1B
         ioiBm6y6Jbu+GTmYLn7TE6kF4elMmWNtZoaFW9/ZSGSQOLDmtxC6CfhlImnwO0m9mw4B
         j2kDmTCrVvAh9+4ld0TQxSbJrTTRXe6eGltUa7G2W9RQKizjDCbrgGSMfxKI8Bf7bknq
         ykFg==
X-Gm-Message-State: AOAM533rPInLzNpJIy98r0l3O+O4YolTF5WAXfgwwBHKWlGujC/m/5r4
        VZFuvpOTPBm6dPWmG2fXgN+jFxV5ftdm+bkza/l9Zg==
X-Google-Smtp-Source: ABdhPJyCR3vc3JOieuBEEM5D5fZjePu1CYv2QqEGv0YEvp9D63ecIfEyGtadeSRvWm9otQqI5PkZOB7PSiIwRPcPZVo=
X-Received: by 2002:a67:b24e:: with SMTP id s14mr4576610vsh.28.1623238122630;
 Wed, 09 Jun 2021 04:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <7e8181e77d409af7595e357ad233b7781e026b78.1619710329.git.gitgitgadget@gmail.com>
 <20210603021927.343351-1-jonathantanmy@google.com>
In-Reply-To: <20210603021927.343351-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 9 Jun 2021 13:28:31 +0200
Message-ID: <CAFQ2z_OHWSJT6Dz8iMSBaGG_=8KvCKCeaj8Dds0jBBQD5KheJQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] refs: remove EINVAL specification from the errno
 sideband in read_raw_ref_fn
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:19 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > A grep for EINVAL */*c reveals that no code inspects EINVAL after readi=
ng
> > references.
> >
> > The files ref backend does use EINVAL so parse_loose_ref_contents() can
> > communicate to lock_raw_ref() about garbage following the hex SHA1, or =
a short
> > read in files_read_raw_ref(), but the files backend does not call into
> > refs_read_raw_ref(), so its EINVAL sideband error is unused.
>
> Does this mean that there is some code that sets EINVAL, but no code
> uses it? If yes, that seems to mean that we can't remove EINVAL from the
> documentation, since some code still sets it.

It means that an alternate ref backend doesn't have to return EINVAL
to work properly.

added to commit message.

> > As the errno sideband is unintuitive and error-prone, remove EINVAL
> > value, as a step towards getting rid of the errno sideband altogether.
>
> How is removing one possible value a step towards getting rid of the
> errno sideband? I would have thought that we would be working towards
> transmitting all existing values to the new sideband (the out param).
> Unless we are planning to get rid of all values in the sideband - in
> which case, this should be described in the commit message.

It means that we don't have to spend braincycles in further commits of
this series reasoning about EINVAL.

The existing functions potentially transmit all kinds of errors, eg.
EIO if there was a problem with the media, or ENOTCONN if the git repo
happens to be on a FUSE filesystem that crashed. These are not
relevant to the ref backend, so we don't treat them specially either.

> > - * set errno appropriately and return -1.
> > + * Return 0 on success. If the ref doesn't exist, set errno to ENOENT =
and return
> > + * -1. If the ref exists but is neither a symbolic ref nor an object I=
D, it is
> > + * broken; set REF_ISBROKEN in type, and return -1. If there is anothe=
r error
> > + * reading the ref, set errno appropriately and return -1.
>
> The rewrapping was unnecessary and makes it hard to see what changed.

Fixed.  I suppose .clang-format settings should add some configuration
about the line size for wrapping comments.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
