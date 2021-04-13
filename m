Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F9C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B4761278
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhDMK7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMK7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 06:59:01 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789DC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 03:58:41 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id s14so1527184vka.10
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WP1ILzad+ZkkG43muCv8bmbDmIMEsA/IO5cP7PhqfE4=;
        b=JtfIos6WY//r3i1DUt0xmjXnN48Z4LjUkTDotnUoZKuNWIsl2wDwrvnITxVHfZ59wK
         oIf98XlxqkIH1hOvRsEla+ZU/+HydX4E9quD/Cb7kmWEhkccXArNLDIE6e7qzVaYodVq
         tKN7kveemHxpAaAjvIpfzYmTJpXAL61t72KGb745xcNDp0bwttU9yE6rKy5tR9K2TSyp
         mJVZmpt4IPW9TUFVNfDk/1qFBMflyqGjWH0Sm0kXEC9MIcHnY0tvSLJHiZ8M/HdTv0F5
         tPrRjDykYarfU1XgUPNbnk79OdveOtaDQQ/Aryj0sG0bvp2ZwSsDmY8/2bJDm/IiJ8Lq
         Ie/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WP1ILzad+ZkkG43muCv8bmbDmIMEsA/IO5cP7PhqfE4=;
        b=W6LVKOLboE0H0lmW1tlWK56yFgukICo96y+47NhtPb4//28r10U/eX6KBga3Bbhzoc
         4xoLC0Xg1HQaSu8gQpdPrwXrS91sGCEjqvZ4d2PsQ4pX3aKB+EWl8BVU5SvRyFnLgpR0
         h1vkvk0Pw6LXmPUOjAyffPOV4DF2r+xNmvRPK+J98Z1GrKDqhhHOV8vkyW9rLwSvQqMc
         9NVmsqP97Sm69EPw5I4qJO3r7dRljbevhnAvqwDRnaPaUYlIoQ7EbsASoyYvrmrZV++0
         /SUJVeSiMGsUZdOtTgTgKhUpcjDwZl/SqzWGaQqd/pXgEuYf6WNLh2PXAXUww6UJepUk
         VCFA==
X-Gm-Message-State: AOAM5300M5xr1LavKFGmO5oidn7VcBJ4dx4jh+kCmdJckNoLrRyk9wtc
        CdssxVT60hE0wDoKMUlTBU2/eBoqImowlb2H0+zSxQ==
X-Google-Smtp-Source: ABdhPJyhOyUQJTkkP6dELQlSpJo+GMqOgBocdURzeg+JO1VGH8xbLqBKM/qUGuiXX75OBJDCpP5m2rJht3Hh9tu8IyU=
X-Received: by 2002:ac5:c185:: with SMTP id z5mr10650276vkb.19.1618311520896;
 Tue, 13 Apr 2021 03:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com> <df8003cb9a7d9e017d358251a2d22c0e72454e03.1618255552.git.gitgitgadget@gmail.com>
 <87czuyehnv.fsf@evledraar.gmail.com>
In-Reply-To: <87czuyehnv.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Apr 2021 12:58:29 +0200
Message-ID: <CAFQ2z_P7GjwjerP7S39xkdK20wzeE+z09NRpCnJuNCXFnJ=r8A@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] reftable: utility functions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 10:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > +int strbuf_add_void(void *b, const void *data, size_t sz)
> > +{
> > +     strbuf_add((struct strbuf *)b, data, sz);
> > +     return sz;
> > +}
>
> Is that cast needed on your compiler? This compiles without warnings for
> me without that.

No! thanks.

> Also, maybe this is the sort of thing that makes sense to split into
> general "APIs needed for reftable" patches. E.g. something like the
> below (just the strbuf.h change):

SGTM.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
