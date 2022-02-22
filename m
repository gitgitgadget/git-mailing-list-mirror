Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB18C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 01:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiBVBzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 20:55:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiBVBzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 20:55:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94525C4B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 17:54:45 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bq11so11859139edb.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 17:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iOGPvy3VHPRRswPcPtG2jutp3eI1nTguxot6aIjOxVo=;
        b=KZnuoR9cPTlLGiOOPtmFMTx1t8E10j08KPDeybZwaiNdEPWFXj0tETWMLsxiNbWQCN
         3rlYXExB3oSvoYAywPSfw2ijXpcmfJPNXTTj5h7Fl/fiSk0pYv5cjRWTlwv1vDQbFODi
         XC7B/xaABUe2UXOvOIWCNfPsjjBwU1aB1rO/l1VW32AQBPe7xl4Fyoz9hdg7yhq2msor
         QLHj27dx3zyUpp2ROIbR0fAMhcqsS7gXaCygiYPRPLNix0EzqBS48F0ytY/KIF/5BA4S
         dG4a6L2X7guiwUWR6Xd0jnaiFNQX7oFkO4fmKFeEtbM1Z5jBFHJ0OZcPtD4X8z3dvjmZ
         JJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iOGPvy3VHPRRswPcPtG2jutp3eI1nTguxot6aIjOxVo=;
        b=A1QpUNBtdNh6oHlWDTLobZWc0O1Fj7nYWqgJ8BEKCZMvlNq0PYNnUBsj0P3lz5MnuF
         yVmpe8fPEocViDFjZO/emgB3pXs+pDZw6U37pjfb3VVe9kvAyx8rNVcGIBMVO2ujbjtl
         9CYAmAPLte123Fn+fp2B8R3gwbQ79y6JXOPE9MjaVeYrNy3YW6O8TrZNfkwAa3BDXeC7
         4c9ZSzAZ1DBEUARB6pN+AoAoracUSiL61l0goh5STLl4+6Ok/vQ+4It0AFxtZf20GmzG
         9N20o0hlnl8VAPFbziD+dJzmERBCvSJmwYzDB5fQoRQgRBNS+uqOhBCXb7lS5tXNYnEl
         5Utg==
X-Gm-Message-State: AOAM5316v4bf3FvE9Ri+HSE14eUgeeX1ocGxa49Cz2/vYCEBjOvRmQGd
        Fw/F4V5wr5h08+AaO9UzWuvSa1CzuRh0PgUoTaI=
X-Google-Smtp-Source: ABdhPJw9eEz8X4Q+bJyajJOaLiaKrBfnOK7bhIFdRoDf09tVS/bgTUVLJib7i0T+TuRed6sqjZwmo/3HKuQB9Bvj0tI=
X-Received: by 2002:aa7:cc12:0:b0:410:cb7b:a9ba with SMTP id
 q18-20020aa7cc12000000b00410cb7ba9bamr23641925edt.196.1645494884407; Mon, 21
 Feb 2022 17:54:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
 <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com> <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
 <220203.86o83o5jr2.gmgdl@evledraar.gmail.com> <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com>
 <220203.86fsoz6hr3.gmgdl@evledraar.gmail.com> <CABPp-BFFcFxWL+FRSf9ANwHU1mp_oWcsfLOwvBAuv-J3oNh3SA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211011510.26495@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202211011510.26495@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 17:54:33 -0800
Message-ID: <CABPp-BGzWOqgsiRx0jAitbriCCyP8GaVHcCmYV-+CAJZXf1f-w@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 1:13 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 3 Feb 2022, Elijah Newren wrote:
>
> > On Thu, Feb 3, 2022 at 8:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> > >
> > > On Thu, Feb 03 2022, Elijah Newren wrote:
> > >
> > > > Man, what a can of worms this all is.  Maybe I really should just d=
rop
> > > > patches 5, 6, and 8 for now...
> > >
> > > Yeah, I really think it's worth it to just sprinkle a tiny bit of
> > > if/else (or a macro) here and print to stderr inline or not. We can m=
ake
> > > some use of some usage.c when there's good reason to do so, but this =
bit
> > > just seems like a needless digression.
> > >
> > > I hope all of this has helped somewhat ...
> >
> > Absolutely; thanks for reviewing!  These parts may just end up in me
> > dropping some patches for now (since they're not actually being used
> > anyway), but I think it's all good feedback.
>
> So we dropped some useful patches future-proofing `merge-tree` for the
> sake of appeasing a refactoring with no immediately obvious benefit? I
> really don't like that direction.

Even before any of =C3=86var's comments, I had already noted on my cover
letter[1] that "to be honest, patches 5, 6, & 8 may be less relevant
since we're now including these messages on stdout anyway" -- so I was
already wondering if I should defer them to some future series.  Then
when =C3=86var reviewed the series, he noted (1) that I lacked tests of
these changes (which is true, because nothing uses them, and I can't
easily add a test as I have no current usecase in mind), and (2) these
patches would print a "warning: " prefix when printing to stdout but
not print such a prefix otherwise, which felt inconsistent.  Those
seemed to reinforce the comment I had already made that these changes
were unused in my series and maybe should be separated.  I still like
the general idea behind the future proofing you did here, so maybe I
was just being lazy, but between those factors I decided that punting
until later made sense.

[1] https://lore.kernel.org/git/pull.1122.v3.git.1643787281.gitgitgadget@gm=
ail.com/
