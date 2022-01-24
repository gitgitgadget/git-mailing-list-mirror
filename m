Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60CAC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349711AbiAYCAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1851339AbiAXXc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 18:32:28 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C8C041888
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:53:38 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id 2so33176536uax.10
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SVk0mQQ/6eLMP/WXW/a7wO/Ct4tw53qb7UiOAj1p7PQ=;
        b=NQtq5UPUniP0qDCYEk85ALQ50VHDZY0wc4NbhsX9ZMgVb5DobYFakc19AIzCpfq3YZ
         Bf/K+e+tRgkuc52RkW0nscx8ux4jgMXEOMYg8WIZ1dQgR5GzGuUFCXBBwfP6oI00gOJv
         pevwYYQi0/NlG2f+4xAuev0F5DQRecLiMFD7K0tZe5txvrkIgx8bPVeI+soquWZpxU12
         KB9OJ3UZVRWqbTr8UDkuhiowhvyDgtyCssktfB1kiMvuy43Kkechht1fI8RxSBFl4jqQ
         urpjtpWzyWfw/9sele2LYgO7RmRCGSVyDR0SVir45FYRakmB2FGS1lyzs7ZZlpk9s2HR
         WTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SVk0mQQ/6eLMP/WXW/a7wO/Ct4tw53qb7UiOAj1p7PQ=;
        b=MfS+pTyHoXvHrjbJMH+JAZ57I8MuRBB+cuPwTkdEOmGQBIEvanOAl6EfHkmOInHgB/
         GO3aMmosoUdVk+kI5jkBeUS7FmrY/v4m3eo+VXW032/s12lfjje9bmFyptbzvY98YM1j
         uMrUHags7peTMGnllgJ119/1SWPvQVbnk/1bs3B+SQA94X7qTt2UCYFkPMiFODk/2gEF
         eUSWu5c4j+nCwVbTS1N1aYDYj+WrWGwknCkAq72BN0KokInCSXUCAXOrG1NEcijpMmia
         mb5pk9YMAAyE/QDTYRYWeqBLsC1PTro43HttNKhBrOZN4aYjmnMriy+iNHUTX9RA7OGW
         aRAQ==
X-Gm-Message-State: AOAM531EdcwOwDLOThMPU5iVKBu//liQeAKKuk9vmHfAE5AmlByTVPKs
        42pBUOYGZY8rIf1nxO7C1RMiTwp55lfd8h2RX9lfrA==
X-Google-Smtp-Source: ABdhPJxpz7hl5OKDpiNGwXk2MqV2uVUkQEwxza99RTpL6r1VmXwyb1J11pelPCgwefCCoLaNyViTrEjRWVKW1C803JM=
X-Received: by 2002:ab0:4888:: with SMTP id x8mr6106377uac.55.1643054017094;
 Mon, 24 Jan 2022 11:53:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com> <047bbb75fcbb67c41d307bf5fa44587a76cc0777.1643051624.git.gitgitgadget@gmail.com>
 <220124.86ilu8hqag.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.86ilu8hqag.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 24 Jan 2022 20:53:26 +0100
Message-ID: <CAFQ2z_M7s9Y_FH5x+qJxyZO0iHq+b_mf8=-dKcmADzFEoGLJUg@mail.gmail.com>
Subject: Re: [PATCH v7 14/16] reftable: make reftable_record a tagged union
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 8:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> I didn't test the v6 on xlc on AIX 7.1, but found that it refuses to
> compile this code (but the one on AIX 7.2 is OK with it):
>
>     "reftable/generic.c", line 135.26: 1506-196 (S) Initialization betwee=
n types "char*" and "struct reftable_ref_record" is not allowed.
>     "reftable/generic.c", line 147.26: 1506-196 (S) Initialization betwee=
n types "char*" and "struct reftable_log_record" is not allowed.
>     "reftable/writer.c", line 261.26: 1506-196 (S) Initialization between=
 types "char*" and "struct reftable_ref_record" is not allowed.
>     "reftable/writer.c", line 312.26: 1506-196 (S) Initialization between=
 types "char*" and "struct reftable_log_record" is not allowed.
>     "reftable/writer.c", line 406.45: 1506-196 (S) Initialization between=
 types "unsigned long long" and "struct reftable_index_record" is not allow=
ed.
>

> I.e. you're dereferencing a struct type here to get at its first member,

No, that's not what I'm doing.

> > +   struct reftable_record rec =3D {
> > +             .type =3D BLOCK_TYPE_REF,
> > +             .u.ref =3D *ref,
> > +     };

reftable_record is tagged union, and u.ref is a reftable_ref_record. I
intend to shallow-copying the parameter (a reftable_record called
'ref') into 'rec.u.ref' , precisely as it is written.

Does this patch pass the unittests?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
