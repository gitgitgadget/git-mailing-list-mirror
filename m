Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520921F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbeKDAsW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:48:22 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50209 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDAsW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:48:22 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so7179511ite.0
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eWJeHcbfWdyK8coO/QTkqn9Ami77ha6taKtbVJL8waQ=;
        b=hSjAZgYGGu0X8k09TfSkseUAdIWedJnrtaBUrxxUElhbfW3wRuB/NbpJyTtGiFowrX
         2WXUqFJe6b/dSxJIMsNO+yIvxAJ1D3fwdHFI79yH3LFDVcVIXsWaZaJG5PHha9m6/7V3
         N9+jRhobTeE1nHt72lzc0FpEXqRtAre2/hH9862nbcPbxGfo5svJveL1PHfN/P7LsrLk
         PRmYzYMjOtBmLbQr0nyQhfYlydD5AurokxjcRgagNqEL6QlgT8ThnAzIX7MrkMETva6I
         kWd2a5aS4mUnAE0bLakEN1sZgw2CmYPd+pdhmw+jaX4Ye808kb8MR4Og3iEB87KG//kW
         kINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eWJeHcbfWdyK8coO/QTkqn9Ami77ha6taKtbVJL8waQ=;
        b=ra/TcfWq8beDLMSt+eUH4G20b4PBPs+UnlffWC2GBG4WuO/EhR0bVWih3qj2yYsClb
         uM1mxaou9sec5VgPN5fnx8nkommHxm0YzC/q3kq7RJIvR54aSxEll9pr39jMy5qsebyW
         Sg1dkCRU3oRpu08rebhhI2Xw3HGv+eoklssSLYI+Er6LEYECI1IdXO+GA5HpE68Me0WE
         k98GJukDvO237cZdThzls3ywkQrjR7oI+tHsKGwe/HZIDOjSV2wszMgbAI6c/Wm8MPJa
         JjZq4GezaJ49/fJ5KExKoDm6Dd4z9FMMlJS+3Pht0EzBVfwPjRHun6hQt1rZHES5sSWS
         ObNg==
X-Gm-Message-State: AGRZ1gIlwMqek9a3PoMLUwtsqQjXETj04RmOhNUKT80RU3q2x6/qgIFY
        u4YcRUldKu0IJHVFgnusLm/IvLLpW/emYp5CCMUXAQ==
X-Google-Smtp-Source: AJdET5c5Ky7ps9R33X3Rt/EBLWGz6DemDwuGqUSqEnFmM/fX3BQSx+v91f/WQI9QwGaKmrDIeLGhIMbxfYexZR09ZQc=
X-Received: by 2002:a02:9795:: with SMTP id s21-v6mr14188602jaj.92.1541259403204;
 Sat, 03 Nov 2018 08:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181020193020.28517-1-mgorny@gentoo.org> <CACsJy8DKD3F3o74gTHW-WEL_hpB8x+oaWX8_SwN01Nmz3W9Z_w@mail.gmail.com>
 <1541259137.1028.12.camel@gentoo.org>
In-Reply-To: <1541259137.1028.12.camel@gentoo.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Nov 2018 16:36:17 +0100
Message-ID: <CACsJy8DwGHWLWxLrC2XZ5XS+se2W6gYCXtFjzWghgkgYGi08ig@mail.gmail.com>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple signatures
 on commits
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 4:32 PM Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> w=
rote:
> > Perhaps my gpg is too old?
> >
> > $ gpg --version
> > gpg (GnuPG) 2.1.15
> > libgcrypt 1.7.3
> > Copyright (C) 2016 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gp=
l.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> >
> > Home: /home/pclouds/.gnupg
> > Supported algorithms:
> > Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
> > Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
> >         CAMELLIA128, CAMELLIA192, CAMELLIA256
> > Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
> > Compression: Uncompressed, ZIP, ZLIB, BZIP2
>
> Perhaps this is indeed specific to this version of GnuPG.  The tests
> pass for me with both 1.4.21 and 2.2.10.  We don't have 2.1* in Gentoo
> anymore.

Yeah I have not really used gpg and neglected updating it. Will try it
now. The question remains though whether we need to support 2.1* (I
don't know at all about gnupg status, maybe 2.1* is indeed too
old/buggy that nobody should use it and so we don't need to support
it).
--=20
Duy
