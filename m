Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAECC678DB
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 00:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCEAnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 19:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCEAnm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 19:43:42 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB4B451
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 16:43:33 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536c02c9dfbso115402597b3.11
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 16:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fbRZ1YZXr6vgVewfq6E9Gr7urBENBkEiRx6gIGksAQ=;
        b=HXWZQ7LyS5gdlhwv/SvZy9ifZ4rWeMvZcNxe+yJcLghsn35Wv8QItN7E0GLxqYAySW
         LbTQ2xwEjmfdlUq37MPwbh+Z6mSEkAAbz6FKXKPkI3dei2526roccOvicaaDx23GiKuZ
         ZeavE4oK/NnsAix6ck9G4i1okOGSiE7xJ24QwTrQPfunxE6AyHTYeV2Dz5YKIjNgdOxo
         7SyfVOfNSaBzJyImNBr/Ynthf7LmjfyHKIR0iOfMuBFCMQe31ZZD47cTz/KJntgZFT+D
         ju/iBjZYqZ61vQcZkfklwqYRDWuoNpa8uX+Po3M4LtIrQjw0LovSVXtblkGN8NTdYo/f
         pkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fbRZ1YZXr6vgVewfq6E9Gr7urBENBkEiRx6gIGksAQ=;
        b=6gtvvRg5kW9XCIBG/SrvV8crKGGauDoRL7JrIzAVHYeZPjcr9X/JUtzaBJ/0rV+k31
         J12DvK90v+fc7+PnuWUIoTvjdOuk15ihmxK+xmdadIYHhDwVt1EHh50lna7bCmPYfGut
         TwkPQQCS0+hmbI3EOcYkT1IiPz7Ikm3BXKPPvrQJ+QmbuRgoaxVz+KY/6OjYnZFX+/vN
         dTggXIAkvtlpUoKOdh6nrNRz2CtKB7eumfo4D8Us4nKttTmSesPSmk3FuZCCWmQ2zAfI
         BE9vROkLiA3+HCzcftR8mXgtPuBTlXifRJB2xxRUtduThSKtcCE6fkT85tzPyg1ERc9v
         /8Aw==
X-Gm-Message-State: AO0yUKVZHBjU3Bc+uhajyqB4Z9DL35Swu01Xsy9yP8Wvnm0xWDUtBo2M
        CaHenzvgHv4fnX/iRa/I4JuX0N+fNvA0C2CsEkU=
X-Google-Smtp-Source: AK7set9z06I1/PHeHOnjzyaSL+VTSmw5Y+AY0/FKxREq4AcKBjlqqzlz54ZRivY+jBLXknfNWbu+2LT+IIN6Iq1FQ8s=
X-Received: by 2002:a81:b286:0:b0:533:9185:fc2c with SMTP id
 q128-20020a81b286000000b005339185fc2cmr3947794ywh.7.1677977013011; Sat, 04
 Mar 2023 16:43:33 -0800 (PST)
MIME-Version: 1.0
References: <87y1oco3i9.fsf@igel.home> <CABPp-BEEDS=v7ouOKts83OFMxDq=F0TKO1XvHEbnmXJ+Z1WELA@mail.gmail.com>
In-Reply-To: <CABPp-BEEDS=v7ouOKts83OFMxDq=F0TKO1XvHEbnmXJ+Z1WELA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 4 Mar 2023 18:43:21 -0600
Message-ID: <CAMP44s3Kqyrdavp1OiozNbA7k4EHCj0KiQq4d2Dyg_KZSEAUuQ@mail.gmail.com>
Subject: Re: [PATCH] git-merge-tree.txt: replace spurious HTML entity
To:     Elijah Newren <newren@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 4:27=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Sat, Mar 4, 2023 at 9:48=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
> >
> > Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> > ---
> >  Documentation/git-merge-tree.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge=
-tree.txt
> > index 88ee942101..ffc4fbf7e8 100644
> > --- a/Documentation/git-merge-tree.txt
> > +++ b/Documentation/git-merge-tree.txt
> > @@ -108,7 +108,7 @@ This is an integer status followed by a NUL charact=
er.  The integer status is:
> >
> >       0: merge had conflicts
> >       1: merge was clean
> > -     &lt;0: something prevented the merge from running (e.g. access to=
 repository
> > +     <0: something prevented the merge from running (e.g. access to re=
pository
> >          objects denied by filesystem)
>
> I'm sure I'm the one who put it there, but I don't remember any
> details.  I think it unlikely I would have jumped to '&lt;' without
> trying '<' and hitting an error first, though maybe I really did.
> Also, there could have been other edits since then; perhaps this was
> only needed when other characters appeared later on the line?  Or
> maybe the '&lt;' is only needed by asciidoc and not asciidoctor (or
> vice versa; I have no clue which I was using)?  Should we add a
> "lessthan" field in Documentation/asciidoc.conf under "[attributes]"
> and use "{lessthan}"?

For what it's worth I checked with both asciidoc and asciidoctor in
multiple output formats and < works fine. I even checked an ancient
version of asciidoc and it works fine.

It doesn't seem like &lt; was ever needed, and it doesn't work because
it's a literal section.

> Or, if this one really is spurious, should the same html entity in
> Documentation/git-rev-list.txt be expunged as well?

<=3D is automatically replaced with =E2=87=90 as explained in the documenta=
tion
[1]. However, to prevent substitutions one doesn't need HTML coding,
just doing \<=3D is enough.

I don't know why people try to guess what asciidoc and asciidoctor
should do, they both follow the same specification, and I haven't seen
a problem in git documentation caused by either one of them not
following the spec, only by git not following the spec.

Just follow the spec.

Cheers.

[1] https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/

--=20
Felipe Contreras
