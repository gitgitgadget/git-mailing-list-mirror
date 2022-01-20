Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D48C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiATLE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiATLEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:04:10 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52CFC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:04:09 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id 2so10052251uax.10
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 03:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DDmJ1t6sHxNba366NmyosgJzOSVrP3PtBeDRevxpR24=;
        b=QGixE7LdmAAu8snz5NuioHV0LpUT25uf6iDuHxmKh5JdPolpJhPEXcdpFOiCOB12tN
         pmYZpiEfuoUms6McWwHatswoJiZ6bPIke/UtLzmSGeI/1EQLWL/N8ZUu5xXetb1m5adh
         MXQsJuSHr/3/xQ1DtLokJAjN9G61l9wXlOtqcwnt3Le1Na1lnCJXIEuR7GLNcBzibaxq
         StetaE8RpYe9FcljNai2zayKmme3nVctFAjyaVqBqHc1troVFnEtIGHFC59uzR/cG5Rb
         c1ViW380Jvptu2vdOIrJ65IiSxCBxhc/IBFo+7m5SB1gnau1B69BOICsVrg90KbqMANz
         2NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DDmJ1t6sHxNba366NmyosgJzOSVrP3PtBeDRevxpR24=;
        b=O9G8h5Rc/8/oEy5RMsVMuhV/126JPw9S/WJI7Lx2AfAY3zivCr+LMunUvnNE+NO1Z1
         IvXj/7BjR+jOSstgrIONCIwYxyAYWDiQbfL7DFRQKDjCSeHKSk4YdGPno8N3DaSsX+ro
         6mXf9UZYVlFODD/vBV3hfmZqbvMy+Dbb6uTXBNN2SHE8LC2k/v3Oh3hEIetUH5kkFcbg
         DsHcCVwGV1XDjrnujlCrupNFjg1/6gMb+kUBN8MrShP338bAds3MxB3EjWa+HWqPwMPZ
         gzSYJ1ZsjcHH0AKq+g32LBVmCG/PG2Mk5bxAwxYYLj2QjDn1uG+921WxBV006+O3zQB6
         /+sA==
X-Gm-Message-State: AOAM5301WwwzVoMzzRWCSxsFM4QFR+3tFzISCR346XSNcCyi3qxh0vjI
        EjViF75fQzIswdBnO4XYOEmXnxPTTh1fYZrn6TJZJHZ+4DT8Wg==
X-Google-Smtp-Source: ABdhPJwl+uxvAKHvtZaQsA9IEB8jX1iI3RFk7+3gRNg01bZy1EshmtBRud0kXO0DZhhjm7W+P1HHoWMkb5FpwLnVb4g=
X-Received: by 2002:a05:6102:4194:: with SMTP id cd20mr1437154vsb.83.1642676648799;
 Thu, 20 Jan 2022 03:04:08 -0800 (PST)
MIME-Version: 1.0
References: <xmqqwnivjgtg.fsf@gitster.g> <CAFQ2z_PA4zHV8xc1f+sMW9DnaF1E4AQrvkCav_Sx-bKRkgDLtw@mail.gmail.com>
 <CAPc5daVFUoK1UQUO5jdsLSUQ8XfkiEk+MoWKg2CZB0=N6N9XXg@mail.gmail.com>
In-Reply-To: <CAPc5daVFUoK1UQUO5jdsLSUQ8XfkiEk+MoWKg2CZB0=N6N9XXg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 20 Jan 2022 12:03:57 +0100
Message-ID: <CAFQ2z_NZL+8No44863K5n7cQkHmtn35_BtKKTQiFzHweHfTHag@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #05; Wed, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 11:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > > * hn/reftable-coverity-fixes (2021-12-22) 18 commits
> > >  - reftable: be more paranoid about 0-length memcpy calls
> > >  - reftable: add print functions to the record types
> > ..
> > >  Expecting a reroll.
> >
> > The reroll was sent on Jan 12. I dropped the "reftable: be more
> > paranoid about 0-length memcpy calls" from the series.
>
> The last time you mentioned "Jan 12", I went back to the lore archive
> for the original thread [1] and didn't find anything but a few comment
> messages on that day.

Sorry, you're right. I didn't understand your previous message on the subje=
ct.

GGG has started enforcing line wrapping commit messages at 60-76 chars
(https://github.com/git/git/pull/1152#issuecomment-1011290837). I
hadn't realized it didn't send out the series.

I grepped for '76' in Documentation/*, but couldn't find any note. Is
this new requirement for GGG documented somewhere?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
