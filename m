Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC60ACE79A9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjISPwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 11:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjISPwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 11:52:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A893
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 08:52:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so7259484a12.2
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695138732; x=1695743532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbBsFPnKjpS/AcXE9gFzj70cDtMUF2ZSFo380uPnYQ4=;
        b=X9wJDaQzAp9+g4rb00ezHwAuVBJ6HETvykuSvgzZzWsWzkxi4DDAmcwifI9f1rJoaK
         x2HwCKuXYi6JcxMxrft8pgbA63K/w3ON/XHpn+c/3mNENnbP3RqH36Bum1/59cpRtxdJ
         CuWuehkoHIm9FC2YhW62OUUkYK+wos1mij2zXki8yzMlJq1M+qRweDbK6Mfg/Yi2vsl1
         WEhdACj3RBuXDiWGE/8uoPuWr4llpGCgRx1SBkZ17rTPM1nlxh9/7LbcauPDU2DsifWF
         gN+I78s0yw46dEVhz7/1LW80vn3Oiwz4WVZ/Y3lKNascjEgw0YEv4h7ZdO+NjmpKoYBi
         JpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138732; x=1695743532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbBsFPnKjpS/AcXE9gFzj70cDtMUF2ZSFo380uPnYQ4=;
        b=ZmLlWHbBlMmLfz4/tUg0Xq7T6uKp3JP8C08+La6an9VxPDRmCYK2KsQKKDb74ctJhp
         eno5wSAgmA4eQY75BAnbZgZ1NLTM3Gbf836KB2PC049qbu8L+e6cmya3AbTLytyeOtro
         AsM1po1O8ZWvmuFNf7XTUI0G8SYd+ApOsx/gHa3P3RfyDfA7cpAJI53a75JS7r5Q2OIX
         JK/8VrqT1o1s2pLfIEB+YQwrUnkdUPIq6/437T8KH+yGzqZj18vDs5cAu88W8YCvOp06
         vKdMTH/yHHI0WduDDsJuqHdW46V6yPj95jJPJd8Clkpxpe7TVQlwnqbgc6lFRKrYpAO+
         cHMQ==
X-Gm-Message-State: AOJu0YxCrFXfJQpxUS8UmfIoh3LeVCdTD79QqCpn9hjXRmcHejOxABCm
        /S3EFhwL4v/Sjj+hWp/Rn1qugl1NsU9b2PepDKWNxg==
X-Google-Smtp-Source: AGHT+IH8NPNuh12vIPJxBLRt7x+ixSKbUX99S7fVidJqNoN+Ap56nKQe0IiNwwSyZBAXJf3t6PyUVWXAr4Xgexb0XFU=
X-Received: by 2002:a17:906:3146:b0:9a1:cbe4:d033 with SMTP id
 e6-20020a170906314600b009a1cbe4d033mr10667606eje.53.1695138732077; Tue, 19
 Sep 2023 08:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
 <dea0fbb139a82fe449a7edab6a8f445ce763d0c0.1695059978.git.gitgitgadget@gmail.com>
 <xmqqa5tjje0y.fsf@gitster.g>
In-Reply-To: <xmqqa5tjje0y.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 19 Sep 2023 17:52:00 +0200
Message-ID: <CAFQ2z_O-s-NT+DfxTSSuTq1Z6J0LZz8X8cFTPoOohfqX2rM-yw@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs: push lock management into packed backend
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2023 at 12:46=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> This looks a bit more convoluted than necessary.  Is it the same as
>
>         if (refs->be->transaction_begin &&
>             refs->be->transaction_begin(refs, tr, err))
>                 FREE_AND_NULL(tr);

Changed this in the next version.

> > +                     /* TODO: leaks on error path. */
> > +                     ref_transaction_free(packed_transaction);
> > +                     packed_transaction =3D NULL;
> > +                     backend_data->packed_transaction =3D NULL;
> > +             } else {
>
> If it were just a matter of flipping the early return and freeing of
> the transaction before going to clean-up, then that would have been
> less effort than leaving the TODO: comment.  What other things are
> needed to plug this leak?

you're not missing something. I didn't have enough time yesterday to
look into all the details.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
