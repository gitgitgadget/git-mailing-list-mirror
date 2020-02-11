Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1544C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C593120714
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRsDIKUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgBKQlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:41:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38337 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgBKQlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 11:41:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so4376539wmj.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4v14vFDq0a+TMCXL0p/DUGzBsSlPYdr/gBbvPIPFimU=;
        b=TRsDIKUHGAUiOYqz1U/grDMV8C/Mi6PQQEOG6iXpzPUq7ut5bt5eq2tokATOOtlILc
         CBjZed1CaLYln94k+qIpnp2Wqv5EG9sqx1Vow1ZiZ2lSxDddzMe4lTRd/K4AvG+ttOy8
         ymSOTuSyOyHhs81EU7mkDK/s+jQOc5tVc2rOnHkeMQz9zL51y0ntgEQPeYtpuH4SffxD
         KfxxOPcaZR1zx5aX1TlW3fy8r9Xt/HXVFppiBj+BgcEY4O3EX8kr0B7uNf0yDmgglRhW
         EBRVtaO2t/6epszLKqijlYsslcZdKorn9xvtCArZ750TKRGraBveEao2Dt74/HoOyDiB
         ve3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4v14vFDq0a+TMCXL0p/DUGzBsSlPYdr/gBbvPIPFimU=;
        b=lKTggC37niFMwE1MiteVPpvF4dC+n+1Ii9O93wv9JpcIpx4PnKdvlp8SdBuCBYAfPC
         bqf4YcIVLYeL1sgriNi6FVa5syaXxVKf2Ed14hT8uFA4zDVGkgTQEF03sFjMuikn0hzj
         3uvRjEDSxqxeFCPw+a/Hg71Tl/0J5ejK8G5w/b+tZ0Yx14uniR8C4JoZbe73McK0NcJ8
         6EMZj5E5HIPGj7VY+Emhk12vUuprRNxvSypzk8cxLoU7ImaLRn1Mnwp4iUO10Ix974Tq
         wT7ePiqfu8cviFJixaEjCzmo4nIDgEfemF3/h8fsYp9qVwpurBMk614Q6fEctzfiZ+kB
         SbTw==
X-Gm-Message-State: APjAAAXbkN4MoyQSmKi2Jg9WUGTNq/f41/dj3o5Ub/dILJF/WMrsJpsy
        YgSzYUnYMEGNctoxuOt17IVbDwoMVA6i00rd9ht46A==
X-Google-Smtp-Source: APXvYqzFFVMeaNXCZHtmBfjrtqci4uik93OyE8GwCz1gKZLD7Z5sJPNPMd7c1aHhSk34XatRRDLdd4gFg16QdPkElmE=
X-Received: by 2002:a1c:610a:: with SMTP id v10mr6279130wmb.44.1581439269439;
 Tue, 11 Feb 2020 08:41:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com> <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net> <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
 <20200211000520.GA6454@camp.crustytoothpaste.net> <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
 <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 11 Feb 2020 17:40:56 +0100
Message-ID: <CAFQ2z_P-nK4OSb-CWwm2Fqh=kc3H4PsHu6K8Zxh_HRW9_-Z2yQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> Here is what I saw:
>
>     A 24-byte header appears at the beginning of the file:
>
>         'REFT'
>         uint8( format_version )
>         uint24( block_size )
>         uint64( min_update_index )
>         uint64( max_update_index )
>
>     The `format_version` is a byte, and it indicates both the version of =
the on-disk
>     format, as well as the size of the hash. The hash size is indicated i=
n the MSB
>     of the `format_version`. For the SHA1 hash, `format_version & 0x80 =
=3D=3D 0` and all
>     hash values are 20 bytes. For SHA256, `format_version & 0x80 =3D=3D 1=
`, and all hash
>     values are 32 bytes. Future hash functions may be added by using more=
 bits at
>     the right.
>
>     The file format version can be extract as `format_version & 0x7f`. Cu=
rrently,
>     only version 1 is defined.
>
> If you cast in stone that "& 0x7f is the way to extract the
> version", then you cannot promise that you may steal more bits at
> the right of MSB to support more hash functions, as you've reserved
> the rightmost 7 bits already for the version number with 0x7f and
> there are only 8 bits in your byte.
>
> It seems that you are trying to make the format too dense?  Is it
> too much a waste to use a separate word or a byte for hash?  Or
> perhaps declare that format version 1 uses SHA-1, format version 2
> uses SHA-256, etc. (in other words, do we want to support both SHA-1
> and SHA-256 when we are at format version 7)?

I can see a future where we have a different format that allows for
more metadata so we can encode the hash size separately. But maybe
that can be for format v3 and up.

Let's do format v2 =3D format v1 but with 32-byte hashes.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
