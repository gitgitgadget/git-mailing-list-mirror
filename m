Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391B9C00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 00:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiHBARG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBARF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 20:17:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2934D2980E
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 17:17:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y11so19679967lfs.6
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 17:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=+qRqGfwRSZ0RXN1odZgzPzhuZhecz+ZXyT1GOhdCG4s=;
        b=d6TiF5SZRFqkCysfDqpWYwlXeiaIAXCy7XZ7fZ7TWl+5pPk5hxkvLok1HyfSLoyXrU
         4czSL1YTsLg5+1L2HkwP2oUvyySBSYEDffM0NzlmAjxE3xez2g8/xaUAgSi0/HCmYibI
         gwcKuBrPDnsulcVRoHXkOhPeH+tp+KnufiA1tqnzptHCGIde7wYjLOo8SqP2gYYLY3Hl
         9iad8CrzxU/sQTQl+UVWZAqlSkZjT4jYkG7iGJRK6u7lVbDAjy94fyJml8GQ0Cxto8lt
         PZ5hXrfysF0kU6K7Nryaq88yGmIGWHVzG9SAG+upsApC1dB53FL1Q2PJ/XKh89lnhM6h
         BQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=+qRqGfwRSZ0RXN1odZgzPzhuZhecz+ZXyT1GOhdCG4s=;
        b=RZBUd9HmB/OFkooQ6M7XwxQziqevdNGwqvPJ+NqFw2IDKHaQTrjbcc0ieCWrep/Ps1
         vR2beGvEwtbAzGW6iQy/n/JOLHMK0Vu8oJubZJ1dAg98kY4p/axs/Lbr5D7fYSitF/Mi
         wKBFvL+DfCAAEY2+a1UGJzQiXoyyv7nEvMNf7T/AzVA5F7LbcSx/70xTw50TXF4wWrlB
         7rCCJmdCW99u9nfRHAxiyhWpKaRbCwbnpcCGxLKCFVvxHHWVoKNk97CuZ5XYTtPwin/B
         KIZzQcH+GbQeZ3T9SVcOFZaMwUUy/7jNl2gayYOwj6dKbLSHRpfqJDIqR0ZBt6NbxRUk
         IrGA==
X-Gm-Message-State: AJIora/oVVHca+r/WlZOjwMSkTgL9w2sNrsHByZqNTYdWDQ+l/MBFmL+
        t5UphIE0a5NxvTSF5Wfrlp3xk5LtMvROWkEgn4Y+HS0Pv04=
X-Google-Smtp-Source: AGRyM1tIHVrDAfILpSOH4sQrz+BhNc6Wa/am5uT1fileDknBtytFbx04cLNFcZj96zbiB4Sfb8wTkkt1SJ/xtICnZiI=
X-Received: by 2002:a05:6512:3f13:b0:48a:a89e:3ccb with SMTP id
 y19-20020a0565123f1300b0048aa89e3ccbmr6057835lfa.245.1659399421489; Mon, 01
 Aug 2022 17:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659291025.git.matheus.bernardino@usp.br>
 <86e6baba460f4d0fce353d1fb6a0e18b57ecadaa.1659291025.git.matheus.bernardino@usp.br>
 <220801.86les8i495.gmgdl@evledraar.gmail.com>
In-Reply-To: <220801.86les8i495.gmgdl@evledraar.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Mon, 1 Aug 2022 21:16:50 -0300
Message-ID: <CAHd-oW6GLf=4VxAvMy6c9jrGx1zcSHbe_NKbAUg7wvNBPOmEXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] t0021: implementation the rot13-filter.pl script
 in C
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 1, 2022 at 8:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Sun, Jul 31 2022, Matheus Tavares wrote:
> >
> > +
> > +     caps =3D argv + i;
> > +     cap_count =3D argc - i;
>
> Since you need to change every single caller consider just starting out
> with parse_options() here instead of rolling your own parsing. You could
> use it for --always-delay in any case, but you could also just add a
> --log-path and --capability (an OPT_STRING_LIST), so:
>
>         test-tool rot13-filter [--always-delay] --log-path=3D<path> [--ca=
pability <capbility]...

Ah, makes sense. Thanks

> > +
> > +     for (i =3D 0; i < cap_count; i++) {
> > +             if (!strcmp(caps[i], "clean"))
> > +                     has_clean_cap =3D 1;
> > +             else if (!strcmp(caps[i], "smudge"))
> > +                     has_smudge_cap =3D 1;
>
> In any case, maybe BUG() in an "else" here with "unknown capability"?

Yup, will do.

> > +     fclose(logfile);
>
> Perhaps check the return value & die_errno() if we fail to fclose()
> (happens e.g. if the disk fills up).

Sure. Thanks.
