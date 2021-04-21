Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC4C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96D361427
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhDUKQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238627AbhDUKQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:16:27 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338DC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 23so3612698uac.9
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ZX9ZGBkNVShCaPrnQ5egwHSd+r85/nP+3LTnexqMGQ=;
        b=Fj8Q5RDpsg8IhczECQUaeXNjP6zxlhbBH74k3oxbHxVphc1ktoZYF/yra7Yjm8zLAu
         UjHRxW2PCbV4HVylOwuCuGi3IrdM4IPOB6ETaytAieu4/JujuhF70h6OKL4XpDQAI5l1
         Ky6mYh5VtDrBFqFzWq8Iihhq3bWGRY1SrE/Fw5v2cZ3TudcAnyAZikP2ekBDCKqk2o2H
         uDhD3TQ9NdkJ2H9vOfLIp4n0QXBrfh4lQPDo0h5NqRrt1ZdmW6dAaWZQFJqkkqzSPz8q
         K/OuTNga1EIEXgb8MMhzZRsOlDlxcK5LoQEypeNyNsux+tQqLcPeVntKfsmAxpjAPzrh
         xqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ZX9ZGBkNVShCaPrnQ5egwHSd+r85/nP+3LTnexqMGQ=;
        b=owTLAMbQpuyHr7jm/PgVDCPNrMPXVFJjlCd7gOOuApHkyjPxx3YlyZ7ZJTiczJgxt/
         D9PFPXXGufX33zsxX7Yl//QxrkSt5piD/3RGWiFMtaW4gZnJAapJshkpppJ5twLRfc++
         guRKJGsIE7a1H7f2UrKAoQjl2LiLcVDWgkxBB1KitHXiTZISwgpkYQo8YgNyW8Zl04r3
         Rs5Xk+ZKrCBf/IzrjKeIggt1isAULdrG4EkNJjCfrFwxNzT3w+oN5/Vr6nl7SyL6IqeM
         bNKzb+GchIRcUWU0s2lo1nqUZroiV2LIRxiaw+mkNeYNjCg7VUAWb6qOJ+jGSb3t48Az
         qrRQ==
X-Gm-Message-State: AOAM530YBEgPWwTMEreXvWobHX8NCi/dK0D54RHW1pp2p0lSBskBPpaJ
        LVwp9Bvs/uVtpDxQ0eGpyNA+oaTV6vtXx8Z/t1KrQU5V24Bjlw==
X-Google-Smtp-Source: ABdhPJyyEc5uizMqjlY7nwVsbrbJeiNQLK08g0ceIBrTelUkFMkR1QbVaL4gRU0SteXHbnf/PcvmUIKeNI4wzHXndLo=
X-Received: by 2002:ab0:7216:: with SMTP id u22mr6907001uao.83.1619000151923;
 Wed, 21 Apr 2021 03:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <8103a80394aefdd4e8b5061dfbb6a6199fe5fcae.1618832276.git.gitgitgadget@gmail.com>
 <xmqq35vk7pzd.fsf@gitster.g>
In-Reply-To: <xmqq35vk7pzd.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 12:15:40 +0200
Message-ID: <CAFQ2z_MaS_jBof5VaqRg8K+0NN2n1GQ7mwnKnvjy__yzchwv1Q@mail.gmail.com>
Subject: Re: [PATCH v7 01/28] refs: ref_iterator_peel returns boolean, rather
 than peel_status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 8:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Before, the cached ref_iterator would return peel_object() output direc=
tly. This
> > led to spurious differences in the GIT_TRACE_REFS output, depending on =
the ref
> > storage backend active.
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  refs.c               | 2 +-
> >  refs/ref-cache.c     | 2 +-
> >  refs/refs-internal.h | 3 +++
> >  3 files changed, 5 insertions(+), 2 deletions(-)
>
> A few observations.
>
>  * The ref_iterator_peel() is defined to "Return 0 on success." in
>    refs/refs-internal.h and implication of the missing mention of
>    what is returned on failure is that it can give any non-zero
>    value back, and in this project a failure usually is signaled by
>    returning a negative value.
>
>  * If the trace output cares that all non-success trace entries to
>    look identical, I wonder if that layer should be the one that
>    normalizes "0 is success, any other value is failure" into "0 is
>    success, 1 is failure" (even though I find a positive 1 used as a
>    failure a bit odd).

No, it should not.  The whole point of the trace output is to see
where and how the files backend and the reftable backend return
different results. By having the trace layer paper over differences, I
will miss regressions of the reftable backend.

>  * refs.c::peel_object() is defined to return "enum peel_status"
>    which is not even a simple yes/no.
>
>     PEEL_PEELED =3D 0
>     PEEL_INVALID =3D -1
>     PEEL_NON_TAG =3D -2
>     PEEL_IS_SYMREF =3D -3
>     PEEL_BROKEN =3D -4
>
>    The comment in refs/refs-internal.h about "Reference interators"
>    suggests me that ref_iterator_peel() is supposed to be a moral
>    equivalent of (recently gone) peel_ref() which was a thin wrapper
>    to still surviving peel_object(), so I expect ref_iterator_peel()
>    to allow the caller to differentiate various failure modes.  And
>    as a way to debug into a running system, I am not sure if losing
>    the distinction in the trace output is even desirable.
>
> packed_ref_iterator_peel() does use !!peel_object(), but I have a
> feeling that that is what should be fixed and not the other way
> around.

All these functions go into ref_iterator_peel, which is only called
from peel_iterated_oid().

That function calls !!peel_object(base, peeled) if there is no
iterator. That leads me to conclude

All callers of peel_iterated_oid use it as a boolean exclusively, i.e.

  if (!peel_iterated_oid( .. )) { .. }

Aside from these considerations, it is also odd to return peel_status.
For example, PEEL_IS_SYMREF is unnecessary, because the symref status
is already returned from iterator_next().

> I haven't seen a good justification given to help convince me that
> this is a good change (and I presume it is, as I trust you or any
> other contributores enough not to knowingly make the system worse),
>
> > +/*
> > + * Peels the current ref, returning 0 for success.
> > + */
>
> And if it does make sense to squash the peel status down to "bool",
> then the comment should mention the single acceptable value for
> failure, not just "0 for success" which implies "different negative
> values depending on the nature of failure".

I can make it return -1 instead.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
