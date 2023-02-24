Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A3C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBXGDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXGDC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:03:02 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1E15148
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:03:01 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-53852143afcso110570947b3.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oEZVP9T9lNkAx+JVAGqCx5YO+L9+8c4X98b3Sj1SaM=;
        b=qC0hK2btHf0Mw8ALki58Kiu3hR8YrSaPqTgqgt8KVSzSqd5wDdTGuyQU8H+GAsHRiI
         0zkZ3lOFIgpo1zmQBFDu2mB7bcn9Kp5sODB7Hhu08TC1SbCYLXfi1cYucSlU5HBRxllM
         BKzdcjhCJyCkWVldKUHicyQFJOkt3HqsLrqmZ6lKy+DC75DXJoLq69Z+KqXZeeZm6Dru
         bvq953mTp9yasqIIey4ocS/RU92Was559shfV/8DDEaF+HkZJSVP0uoB73UAhVeE9jyg
         sCJJCwAbtjArs8O9LS+Z8mAfQ0eAPMjgtwTlpht4Mqr5Rsubb3iyp+vKLrxTuCjRiStf
         rsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oEZVP9T9lNkAx+JVAGqCx5YO+L9+8c4X98b3Sj1SaM=;
        b=WcNWtRgn3cXBeOz0VBWgHq8aUi8KWKwx4YTNrICXTIpSXbZXoqNyslOcsxibTcPwej
         +2NNBsppmu5fI6L3zm9MkyZ6hdSHg0tJofLF5pn1320Bhymi8RGho7gmAZbY4jHXg8yT
         Shl6LAqoArDUlZzaGW0TJzHIBaIMUUhrVEVE+Ra937iAuw7uDgGt1iCfIgicVV3kCMi7
         9hJSsfnHMYBU2Nu12hUKZhmcxSe5zQw21hCY/IOKXmTSvMU2G/wA+creltxsBLWLGjGG
         atYqizAIcPUYmFLRN0Sc6s51YpNCCDEr1Ah2z20KSpk5l3qElByIWljQiaR4Gt4+P8hs
         7FDQ==
X-Gm-Message-State: AO0yUKUM77xs7VoSYygDL0eCwLidOG9jMaH623KzfUf0ZQDnQMcC+Nxs
        NGOhaa1HZo9zMdWTsspF31broJWn9i+EFY3gfBo=
X-Google-Smtp-Source: AK7set/LtgFrtT+UGSM1osX2dtbc/0QL5QprWosJaEGKEzYq/9VNJyGBuK66YwRPt/p47MYWNvZZCEa+UCtexrWr3u8=
X-Received: by 2002:a5b:406:0:b0:904:2aa2:c26c with SMTP id
 m6-20020a5b0406000000b009042aa2c26cmr3406570ybp.5.1677218580916; Thu, 23 Feb
 2023 22:03:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1465.git.1673951562.gitgitgadget@gmail.com>
 <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com> <966cb49c388b652861c773ad7430875bf7896c16.1675529298.git.gitgitgadget@gmail.com>
 <xmqqbkm64f3t.fsf@gitster.g>
In-Reply-To: <xmqqbkm64f3t.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 24 Feb 2023 14:02:49 +0800
Message-ID: <CAOLTT8TxtysmA_Ug8-+XB02QLigQnp20eBgdCjHkdZHXidnCmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [RFC] push: allow delete one level ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=BA=8C 06:13=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 13ff9fae3ba..77088f5ba8d 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -1463,7 +1463,9 @@ static const char *update(struct command *cmd, st=
ruct shallow_info *si)
> >               find_shared_symref(worktrees, "HEAD", name);
> >
> >       /* only refs/... are allowed */
> > -     if (!starts_with(name, "refs/") || check_refname_format(name + 5,=
 0)) {
> > +     if (!starts_with(name, "refs/") ||
> > +         check_refname_format(name + 5, is_null_oid(new_oid) ?
> > +                              REFNAME_ALLOW_ONELEVEL : 0)) {
>
> I am somehow smelling that this is about "refs/stash" and it may be
> a good thing to allow removing a leftover refs/stash remotely.  I am
> not sure why we need to treat it differently while still blocking
> update/modification.
>
> Is it that we are actively discouraging one-level refs like
> refs/stash, so removing is fine but once removed we do not allow
> creating or updating?  It somewhat smells a hard to explain rule to
> the users, at least to me.
>

As I mentioned before, the problem we encountered was that
the refs/master created unexpectedly cannot be deleted. Additionally,
some programs only search for references in the command space of
refs/heads/ or refs/tags/, so they may ignore one-level references
such as refs/master. Therefore, generally speaking, it's better not to
let users create/update special one-level references. This can be achieved
directly through git receive-pack or implemented by upper-layer
services in positions such as pre-receive-hook.

Certainly, I can remove the previous section as you requested.

> > diff --git a/connect.c b/connect.c
> > index 63e59641c0d..7a396ad72e9 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -30,7 +30,8 @@ static int check_ref(const char *name, unsigned int f=
lags)
> >               return 0;
> >
> >       /* REF_NORMAL means that we don't want the magic fake tag refs */
> > -     if ((flags & REF_NORMAL) && check_refname_format(name, 0))
> > +     if ((flags & REF_NORMAL) && check_refname_format(name,
> > +                                                      REFNAME_ALLOW_ON=
ELEVEL))
> >               return 0;
>
> This side of the change does make sense.
>
> Thanks.

Thanks.
