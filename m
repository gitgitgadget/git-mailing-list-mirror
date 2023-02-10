Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462BDC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjBJREQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjBJREP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:04:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588E70715
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78D78CE290B
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF807C4339B
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048650;
        bh=F1t8NfQWM6cjph+qm8V2PYZHo1K9ZANOoNPbYntrQtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IrJMMd1VgZcB0BJJ1j6WwumLrVjotcr3n6j0P62+b1F3DyROv4tSTk+8kKDLJ1Rdy
         QH7ha3n7dFJvVLlokZEA+Egiuqz7GgVVarQgCetl36s23rDSx8WxoIiWADkFduUNZG
         voXmmac4P8dTma5cuFKgR5Njs7wwviCp2he435ZUWP9U4Mby/iOIWnBwoyfhX792WO
         IUXPS2o40fBXi+aPTEIQYirjFztQBS8RTRoTeqNO7Nonx+kJXyNkGdJLw8JzO6MJJ7
         OhmcP6nCfK3eiNdr9TA3GqYi8j84bC8I9GbZNzoOH57Td724Yx7UnWCDkijq16m6m1
         5d141+WyCJpyQ==
Received: by mail-oi1-f170.google.com with SMTP id bi19so4970883oib.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:04:10 -0800 (PST)
X-Gm-Message-State: AO0yUKXCw2tLgE85YsOupNT3OyVRkbqZVYR2Grm+Je/G0opZYYOgMLf7
        odkpDL6gjc4QI4fTwLcz4IP+llnaGjlK0VlbaA4=
X-Google-Smtp-Source: AK7set9eD2i4PRNLAw2777aGf7dQ2pYTFE1lFHnZnqXMM9N4y+EmDfMO/ycnITdIWLyoN8YkSS5tVHuEpZeBRtJ0Ze0=
X-Received: by 2002:aca:210c:0:b0:35e:7c55:b015 with SMTP id
 12-20020aca210c000000b0035e7c55b015mr1338447oiz.287.1676048649956; Fri, 10
 Feb 2023 09:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20230210075939.44949-1-masahiroy@kernel.org> <20230210075939.44949-4-masahiroy@kernel.org>
 <230210.865yc9wtkx.gmgdl@evledraar.gmail.com>
In-Reply-To: <230210.865yc9wtkx.gmgdl@evledraar.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Feb 2023 02:03:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASe4z4EQD6w++9Q7G9U2GEWeCgmANYUTWps2xs96ubzBg@mail.gmail.com>
Message-ID: <CAK7LNASe4z4EQD6w++9Q7G9U2GEWeCgmANYUTWps2xs96ubzBg@mail.gmail.com>
Subject: Re: [PATCH 3/5] wildmatch: remove NEGATE_CLASS and NEGATE_CLASS2 macros
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2023 at 10:14 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Feb 10 2023, Masahiro Yamada wrote:
>
> > The other glob patterns are hard-coded in dowild(). Do likewise.
> > [...]
> > diff --git a/wildmatch.c b/wildmatch.c
> > index a510b3fd23..93800b8eac 100644
> > --- a/wildmatch.c
> > +++ b/wildmatch.c
> > @@ -14,10 +14,6 @@
> >
> >  typedef unsigned char uchar;
> >
> > -/* What character marks an inverted character class? */
> > -#define NEGATE_CLASS '!'
> > -#define NEGATE_CLASS2        '^'
>
> Thanks, maybe these made sense in rsync's codebase, but...
>
> >  #define CC_EQ(class, len, litmatch) ((len) =3D=3D sizeof (litmatch)-1 =
\
> >                                   && *(class) =3D=3D *(litmatch) \
> >                                   && strncmp((char*)class, litmatch, le=
n) =3D=3D 0)
> > @@ -137,12 +133,8 @@ static int dowild(const uchar *p, const uchar *tex=
t, unsigned int flags)
> >                       return WM_ABORT_ALL;
> >               case '[':
> >                       p_ch =3D *++p;
>
> ...as the context shows we hardcode most of these tokens.
>
> > -#ifdef NEGATE_CLASS2
> > -                     if (p_ch =3D=3D NEGATE_CLASS2)
> > -                             p_ch =3D NEGATE_CLASS;
> > -#endif
>
> Hrm, but isn't this a logic error? No it's not, because...
>
> >                       /* Assign literal 1/0 because of "matched" compar=
ison. */
> > -                     negated =3D p_ch =3D=3D NEGATE_CLASS ? 1 : 0;
> > +                     negated =3D p_ch =3D=3D '!' || p_ch =3D=3D '^' ? =
1 : 0;
>
> ...you're refcatoring thise while at it.


Yes, this is a trivial refactoring.


Or, do you suggest splitting this into two patches,
verbatim replace + a small clean-up?

>
> Personally I'd prefer to just see this change without this, and it came
> as a surprise given the commit message.
>
> I find the pre-image easier to read (sans the macro check, which you
> should be removing).
>


--=20
Best Regards
Masahiro Yamada
