Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29668C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F466109E
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbhERNNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349473AbhERNNl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:13:41 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5DCC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:12:23 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id x13so4892729vsh.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tKVg8+exIGc0AbKpHuqf5xu38oEZyZld5vzISDln2jY=;
        b=HJ6r37ey1XpfVdskuMeS5CxVEWXQJ8BZ7bt169UzsfDj5lKGIpz+wFAXnPVTZaJ917
         ff8mTAjCyVN4yn+EULgIIYOZjuepfS67cpN7/GbFuTKbOkkPojuAFSsMerl4/hhSm+0C
         t6pqsLQrWanKTD0C7fL5rirckuxNzoOL3ti2H+P++LUM736ujcSIFZmeWSUI9XDRY5P0
         HaKRINdDCKuJLGJjt0aNqimenEVJqks1LNgjPbRAqRYhmUEpSyTWxGOUrKlfIsgx//03
         0J3JtOhFyoZzwvO1UMKKPtwwzQL7xt+MMnfMquHpFkuoQzbWgh+n3xJbjJ3D9FlLPXUS
         n0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tKVg8+exIGc0AbKpHuqf5xu38oEZyZld5vzISDln2jY=;
        b=mvjn26qq4QCc/1cP2CWQxiYmJv+m9nZaMfd/iZtCTc9fmDUveA4coVyTFpkI8hjdnA
         dW115e+G5VCRDdPB29UT3ZBYT92ppZdoTXr4qlCoc+Yr1sbIhcLggnu8jhawGAImZ+I2
         1j2SOl2YFQtuZ0a6aeuFX6he5dePk6u6oqeZeM+8M72OyEU9GtI8/AvUfjkb3JBZBYWd
         KWgzgesNlOFSuk3HkxTqbCSICGX0xpHgGeJ0IYwiO1qLkLWxiwB75izbg8OccNFYXfk3
         5yqix48zBQvDdWQbWdrEm80PN2BkHZ6cqRcG0AmN25wdHWfL2magkZNBDiYMAoAHW1M7
         3Gjg==
X-Gm-Message-State: AOAM5302Ir6NtiVEzoHz6h6jOi43ccoksBJnFPdZ9JH/+7erw/L1NoT4
        BVhQ5ZW35wGblNVgwwdOHsBlo6s4tuxbKPqi9NBkrA==
X-Google-Smtp-Source: ABdhPJylAiFT0psWoFEsw56lyXexprp7ZQCkM7lJRz/L8Tub83uSuOvRJVd7WpaFUiSgaqm6/mTkN0mgQ57pRrDHlRo=
X-Received: by 2002:a05:6102:9c9:: with SMTP id g9mr5351781vsi.50.1621343542859;
 Tue, 18 May 2021 06:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <028dd13e701bf82523cc6da1e68a9dab480c1b27.1618832277.git.gitgitgadget@gmail.com>
 <ef664c5c-d959-e265-d678-6fc54d23f031@ahunt.org>
In-Reply-To: <ef664c5c-d959-e265-d678-6fc54d23f031@ahunt.org>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 18 May 2021 15:12:11 +0200
Message-ID: <CAFQ2z_Ot=tsVi9bruFXJ2KgPVFvHpJEKZTRQQh6oHjF0px93Ow@mail.gmail.com>
Subject: Re: [PATCH v7 10/28] reftable: (de)serialization for the polymorphic
 record type.
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 7:23 PM Andrzej Hunt <andrzej@ahunt.org> wrote:
> If src->offset_len is 0 then offsets will be NULL - and passing NULL
> into memcpy() results in undefined behaviour. I think we should either
> add an "if (src->offset_len)" check around the memcpy, or perhaps switch
> to COPY_ARRAY() which performs that check for us. (We can probably also
> skip the malloc and hence also olen calculation in this scenario though,
> because obj->offsets should already be NULL if src->offsets was NULL?)

Thanks for the detailed report. I've fixed this for the next round.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
