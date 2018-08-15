Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE79C1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeHOW3i (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:29:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39867 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeHOW3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:29:38 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so3485149ita.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=StpEe24qWXBzt14nas5zt2V0+4CEZK7G4uGjad+AEcY=;
        b=svxVEYlrKHM4ykRjr9Wda56XrT5O4GMt45b+0/VhV4cIkSrFapK5syCdvqml5z4I//
         sBXilVhHzTfpNjN2ylv7DXCyoCY+xA8HFI2/Fw8M5v+z85CyC5cD8PqMx0csKgUTrxTj
         yvhu2SbjqPdBxcxnBI9fy+kBiPN/yvCiCbs9z1ljnJweDCqhrwoTtDg1bF7N2cl6ePDl
         d/toQh1wrPFpRKKoGx7f7l7rZ3RGc9OW3BDKnk5raNPO83XOJKpwuTvuBwlHuDC5D58I
         u3GklEvsd1NDhXCKp6SV90uvKg3Ay3Vr3fScYIf2iuUizmhldUyOnaxZ+6JhvTVVuU0M
         iJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=StpEe24qWXBzt14nas5zt2V0+4CEZK7G4uGjad+AEcY=;
        b=RieE6455lQvMbwEs9YsZg3+6rcnTbegfRoBD/ovp3PzKo9snXJlscb2cnHUaM/5g5M
         3DlI+9OtT/Zox/5mL15ix2hzoKl4Jk0eLE8vrX2jD0apjWy0/ujPTDmJP38nZ4hikii+
         01UfF6vthgOL+oXugPVumyXhd7GiX2q/XeCAt0gMd5jqAVY65lBBVZgsAuNGGjPWcogh
         SIZCA0cNKX1pfa3BvxREr0kYXl9ANLUTnBYyAAP2fMxuwhe/65kEhhfYqpSl/gTOQ5GA
         QuI4a+VZaEj1F1S1Ee4fw+KyqmwqagO0BVBpcIta+kjC05he8SntYbX6xaOv6hRXVVOm
         X8Ww==
X-Gm-Message-State: AOUpUlGs/G8PRgVF39l9RrPRW4UQCzX7hS8z7NHnSxqGrTVE/djNpUNL
        msSMDpwUm22LunkoJg0ZSUCBmwQaLZo/u+7KToE=
X-Google-Smtp-Source: AA+uWPyJgEdGLqSRLEjWvpFWiPYVBMQEU2AcMTKeFzzuBt2zu58WGiN7G7Ze0mlvqEyOrNxdDS+YifIwzKvsjtrGN5o=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr19384435itc.68.1534361768349;
 Wed, 15 Aug 2018 12:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180810153608.30051-1-pclouds@gmail.com> <20180812090714.19060-1-pclouds@gmail.com>
 <20180815190816.GA26521@tor.lan>
In-Reply-To: <20180815190816.GA26521@tor.lan>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 21:35:41 +0200
Message-ID: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive filesystems
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 9:08 PM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
> > +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
> > +     for (i =3D 0; i < state->istate->cache_nr; i++) {
> > +             struct cache_entry *dup =3D state->istate->cache[i];
> > +
> > +             if (dup =3D=3D ce)
> > +                     break;
> > +
> > +             if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORK=
TREE))
> > +                     continue;
> > +
>
> Should the following be protected by core.checkstat ?
>         if (check_stat) {

Good catch! st_ino is ignored if core.checkStat is false. I will
probably send a separate patch to add more details to config.txt about
this key.

> > +             if (dup->ce_stat_data.sd_ino =3D=3D st->st_ino) {
> > +                     dup->ce_flags |=3D CE_MATCHED;
> > +                     break;
> > +             }
> > +     }
> > +#endif
>
> Another thing is that we switch of the ASCII case-folding-detection-logic
> off for Windows users, even if we otherwise rely on icase.
> I think we can use fspathcmp() as a fallback. when inodes fail,
> because we may be on a network file system.

I admit I did not think about network file system. Will spend some
time (and hopefully not on nfs kernel code) on it.

For falling back on fspathcmp even on Windows, is it really safe? I'm
on Linux and never have to deal with this issue to have any
experience. It does sound good though because it should be a subset
for any "weird" filesystems out there.

> (I don't have a test setup at the moment, but what happens with inodes
> when a Windows machine exports a share to Linux or Mac ?)
>
> Is there a chance to get the fspathcmp() back, like this ?
>
> static void mark_colliding_entries(const struct checkout *state,
>                                    struct cache_entry *ce, struct stat *s=
t)
> {
>         int i;
>         ce->ce_flags |=3D CE_MATCHED;
>
>         for (i =3D 0; i < state->istate->cache_nr; i++) {
>                 struct cache_entry *dup =3D state->istate->cache[i];
>                 int folded =3D 0;
>
>                 if (dup =3D=3D ce)
>                         break;
>
>                 if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORK=
TREE))
>                         continue;
>
>                 if (!fspathcmp(dup->name, ce->name))
>                         folded =3D 1;
>
> #if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
>                 if (check_stat && (dup->ce_stat_data.sd_ino =3D=3D st->st=
_ino))
>                         folded =3D 1;
> #endif
>                 if (folded) {
>                         dup->ce_flags |=3D CE_MATCHED;
>                         break;
>                 }
>         }
> }
>


--=20
Duy
