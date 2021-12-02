Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89473C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 16:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359420AbhLBQ2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347508AbhLBQ2C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:02 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FD3C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 08:24:40 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id o1so106278uap.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qXjnFJvCyfUrbloGPfJ0t66ZMGZP0RKK9O0q5xjgw9g=;
        b=gYYhDtJCVj7lhOxj0OEHahWoeYQLRiyuV2Gy6MnbfhP43H/Wh6k9Rb1FxaVG22cxSN
         RTDJemO6lPlDg0zfmIs/0TXZsayMrV3sXmvXDtkjwkhdN9ymVfyzgD6cOCHTxzHKbmZd
         nZoSzCgPgf9S22tP3nkZCD4gnScnl7vuX5wxQof5+wjy9BPF99vNi7WVyZIxfjMwN3Tv
         U5b3T+vNmEoi7MEHEFNQNKlrsYV1T8Eo0Y6OSoe61ANXuUabIWJQOCqtXNcV8iuEp7gZ
         L/n2dkSaFxq0rZ6ci8tWaiLGvcuE+zK6fudLD9IqvukPORy8RXvYmcgLl4l5n7eIpvoj
         Ze3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qXjnFJvCyfUrbloGPfJ0t66ZMGZP0RKK9O0q5xjgw9g=;
        b=tsVPdnq2c98VTzzV2vjFKDpnnRIjEXSe5AwdvY73NkPWHXgtB/fDxlq3Z10ONJFf+F
         onTyMOUStkt5RNjIF23MwaUZ1dZVgZg9USSkQ+yjCfFnzbKZQRtcQVyznYEZZaLXsF2M
         pYxy4tFTH4YMhD0l9RwJAK5YKrvIzlH4/ZnfGjP6NaqxCLe/ud1FGKM54jGcbhd59iYa
         p9F139PbsCthY/mFzIlYqS7OvK5jBFCIOCo1RTHOCYj7bHuoqQgWGUPmqPV6TbidMQRf
         T5gGYJw98c0wqTlw/a5Wf7FBzqfY8c5ZPGBX4jk08VEKiZlra5daHyjkKXo22bgnjktv
         Ogeg==
X-Gm-Message-State: AOAM531sC8OthI2vZ+izvPTg23j3ln0ZNn/hhXyztJOXSy3s1i6zB6I3
        txtHBA3UM2hMtGoYnkiCqAiBH7j1phDlMwTxHy7s/Q==
X-Google-Smtp-Source: ABdhPJwZsFUVDrmlVgD0JJAGMu9n2n95ve3TWAsqmy1vWlQ2OUQiJmf2/KCgqWcfJWoeTyNGKPrhQ02TpS/8LArhQj8=
X-Received: by 2002:ab0:36fa:: with SMTP id x26mr16374427uau.15.1638462279214;
 Thu, 02 Dec 2021 08:24:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com> <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
 <xmqqilwf72nf.fsf@gitster.g> <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
 <xmqq1r2y7ork.fsf@gitster.g>
In-Reply-To: <xmqq1r2y7ork.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 2 Dec 2021 17:24:28 +0100
Message-ID: <CAFQ2z_NYgsiLM1Ffw3O9gAFHVuq68iAfrRbgodHdUPRo5Pm0UA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 8:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > On Fri, Nov 26, 2021 at 9:16 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >>
> >> The API promises to have only LF, not CRLF, at the end, so
> >> strbuf_trim_trailing_newline() is a bit overkill (and if payload
> >> happened to end with CR, we would lose it).
> >
> > it would be best if there was a way to escape characters (ie. "\n" =3D>
> > "\\n"). Do we have a function for that?
>
> Mere escaping would not work in a backward compatible way, without a
> trick.  It was envisioned that we probably could encode *and* signal

I'm talking about the debug output, which isn't subject to
compatibility guarantees.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
