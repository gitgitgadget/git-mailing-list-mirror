Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A95C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536F4610E6
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhH3MY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhH3MY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 08:24:26 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF0CC0613D9
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:23:32 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id t13so3039717vkm.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JsDi83DbQ0ltkprnEB1TS1WrUoC1G5kfPqiMGvh9HTI=;
        b=HlOaXNr3TtNtbL1bH2LMgP14OKPZkVwiD/05Yv4vc7ZBG3NjP+QKpCkJqSZFcfPdXh
         u4wFqYN3fgkZ3BAVQMzWObRgspeH0La8fjhFlCq0paHyvZf8f+52p6uogeEP4n2cbEtz
         uCI80qANwBgwrDnx/S6yw3wDyzZKfB8zk7OZxMUKVdBesGLdQR9abwx4a4BkEluyI6dw
         V50a6Zqdnp2MCyQt9JyaZK7Mf9nL1GgdxPVsUlhgECqwSqyIbYjpIx+6xJ/gOrNdfY4h
         GBRKQzzxa+qiPtnf1uaen+d9kZ4eQJeS8L+oYyq275BKlL4PuQlQ9jOBmHtOnaqLDoJb
         +e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JsDi83DbQ0ltkprnEB1TS1WrUoC1G5kfPqiMGvh9HTI=;
        b=muQIXKssZB8sdswaLq4sPAnJxXrgHE/sk2MEOV83OBM8vtzf2is2YSV6WAIZkuTc4i
         vAb9LtXOT6VakDZQnsRkBEUoW3GSHZF5TeH5YCJiu7NYn7qZMYKtheaPw73tfR05Td0P
         N4ox6x6QbNsdDMrgXwUMzqocViUx69NOKY7LECEMa/nSyY4CS9NTK9B3PA8xDxF78n3I
         UecWPqC2Jk+J4kX+wnk463KWslMgiZfOpAg2heVzXo98wNmlecrR1Ry8yGsjDa2rgmQy
         P2ZVjfzeNy2pHsXnEh7UoN72knWWNhzyjFSRThdlU3Thyvs4HluBAypvC2TnwzMg7K6u
         U54Q==
X-Gm-Message-State: AOAM533s5HjPwLZexkqlOtvoXUA4dhha7QtzW53gM+8mOcIWTc2/JwQX
        K87N1RT65QWM6INtK38IIKSSVvhDJKZ4gTsrahyouwCFooc=
X-Google-Smtp-Source: ABdhPJzU4/rDtTYn6syx3NQP1CfaSoDuD34V4Q+F9RWzpY6ZcLUeouO6OSJdDAl0qLdmdaQHu6hcHltxEnSZQF9xQ/k=
X-Received: by 2002:a1f:c102:: with SMTP id r2mr13224392vkf.19.1630326211466;
 Mon, 30 Aug 2021 05:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq35qr7mq5.fsf@gitster.g> <87tuj7xhqo.fsf@evledraar.gmail.com>
In-Reply-To: <87tuj7xhqo.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 14:23:20 +0200
Message-ID: <CAFQ2z_PCUr3D0H-fzfHcFFayzdDJc64=JgVM5_2kuLJn-G9awA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 2:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> Han-Wen: It would be really nice to have this re-rolled sooner than
> later, my and Junio's "fixup" commits at the end are a band-aid, but I
> already ran into wanting to bisect something between master..seen that
> was unnecessarily painful due to the series now not compiling without
> the "fixup" commits at the end.

I am folding in the __FUNCTION__ fix.

However, I thought patches should be sent against the master branch
and not against some intermediate  version of 'seen' ?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
