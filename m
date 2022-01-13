Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC167C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 14:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiAMOXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiAMOXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 09:23:41 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3911C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 06:23:41 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id m57so3865476vkf.9
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 06:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PgX52h8mb2DJn6Ra1V31r4gkBD7h/jrH0KPrvEqtIKM=;
        b=coK+pSH93gdR1yHDmuicdNlnIQpVuQ+FeY1czdjdMHF0wTKthJXYJY7MYA+NYBC7+A
         oGxGoF8VJhPqpVnb+nPX3ub74vV6OSFkOWuqIvUumnsxI+LdkA0LHsSW73t0/JA4o7Qb
         TSTKbAfTbQIopB1lmVL9gB5t1MUOVnsSPgxDU1T3IwMZsU9taMDw8s60I2zJPxEESXAS
         Fqehkxacdgl6U/hVcjJH2N8HSm2DcKe0yGy4IXkDNII2/g0TrCEeBmkFiXvaCJ/1s3Hl
         XA8BS/brj2RohQOg9dQIseI59bQ8NqDhDWTeidCYx43mN1TOm0CkLtSnq2s81Duef/MY
         hb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PgX52h8mb2DJn6Ra1V31r4gkBD7h/jrH0KPrvEqtIKM=;
        b=kzqnWJa7nV04+Lio/BIk8D3U1CeWHZN/376eWRtnC139gyS1al1pU0Z9C+zPODWXSn
         1W417rOwy9I7ecrEGdl7Omw1saX9tX+jTaqjNaLhMjO2f65S54/vqszfuyl8vD0/iQnb
         dOtZsQe/8HWqG52Mniz2c2fUJOrRFUmoCAgx1GLmDHUboki3WfVVdWVnag+GL6JfiCoI
         3Fuc0F/nW11PH1ZSjwApC4d5bIB82+U6Qjgq9z4nTRlNEk2cDih71CjaIygvBGQy+Hkm
         9wKRBXxLKCbYdjG54gcWzwpIW23rjBDJ91Anp3+62tHFQ7krImHYAdapva0Gw6zpXghs
         qqKg==
X-Gm-Message-State: AOAM531sGLwViIV7fE25KEN/FNWnB222jnIqQmComfN/KO9kmfhn+nEI
        s+nbetoGrvAEx0cjR3P7NRCewch9MIB9zSbI7Ie4krpLMfY=
X-Google-Smtp-Source: ABdhPJxB7nDkJnc+l9Jhz+yiQ14+roPd22gUHuUz3HnTbQzjlH9pgQqQoIKaII20GJSEcsc4YPZhF2Sqdo3uJ/NsFcY=
X-Received: by 2002:ac5:cda4:: with SMTP id l4mr2378161vka.10.1642083820721;
 Thu, 13 Jan 2022 06:23:40 -0800 (PST)
MIME-Version: 1.0
References: <0b86f6c2327b88886ad8667d28e0fa8382791499.1633638316.git.gitgitgadget@gmail.com>
 <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 13 Jan 2022 15:23:29 +0100
Message-ID: <CAFQ2z_M2ZH-8RNS_zxShkdaXdO4x4Vr8EwrFo6atd0qzyy36oA@mail.gmail.com>
Subject: Re: [PATCH] reftable tests: use C syntax compatible with old xlc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 12:38 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change code added in 1ae2b8cda84 (reftable: add merged table view,
> 2021-10-07) to be compatible with older versions of AIX's IBM xlc
> compiler. Version V12.1 of it (on gcc111.fsffrance.org) will hard
> error with:
>
>     "reftable/merged_test.c", line 211.19: 1506-196 (S) Initialization be=
tween types "char*" and "struct reftable_ref_record" is not allowed.
>     "reftable/merged_test.c", line 212.19: 1506-196 (S) Initialization be=
tween types "unsigned long long" and "struct reftable_ref_record" is not al=
lowed.
>     "reftable/merged_test.c", line 213.19: 1506-196 (S) Initialization be=
tween types "enum {...}" and "struct reftable_ref_record" is not allowed.
>     "reftable/merged_test.c", line 214.19: 1506-196 (S) Initialization be=
tween types "unsigned char*" and "struct reftable_ref_record" is not allowe=
d.
>     "reftable/merged_test.c", line 349.19: 1506-196 (S) Initialization be=
tween types "char*" and "struct reftable_log_record" is not allowed.
>     "reftable/merged_test.c", line 350.19: 1506-196 (S) Initialization be=
tween types "unsigned long long" and "struct reftable_log_record" is not al=
lowed.
>     "reftable/merged_test.c", line 351.19: 1506-196 (S) Initialization be=
tween types "enum {...}" and "struct reftable_log_record" is not allowed.

Weird. What C standard does xlc implement?

> Perhaps there's a better way to do this, but just duplicating the
> earlier struct values declared earlier in these functions works, and
> is probably the least bad solution.

I'd rather not duplicate anything. Can't you do

  struct foobar *want =3D { &r[0], &r[2] .. }

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
