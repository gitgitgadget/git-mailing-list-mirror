Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13784C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376591AbiATPPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376558AbiATPPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:15:06 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EEDC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:15:05 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id x33so11340622uad.12
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rWH+xfLWYAMX7ueiofm3cy0wWdiDykAPOqn1ZoZbnQ4=;
        b=NYN2fVe7aGH5N3zocPYxPER4Mq58goyIZoNHcH1/RAkN1n0xRXEH4LnSxPCgg/zSuz
         jPc2dZdhz/zaFD7Y5XHzuGvL/sX0PmLVLmgg13+ltsubRSSUxjJzRUDNqamUXGZ3GNMb
         4FyB+rb5OjNYj8lukYVc6RdRrX6wIGI8bMv8goX2cbYVQdayPE7g9+XORVPg+7gauAAT
         nv5qWyXuokDeqO0Afrp0+UNrKYQFIqeFpvrITv4dbP8zvuiyzCMpzEwAN1HtdBMBrGVX
         DaMHWqhyL60X5j0zsYTNYWy4YmbEvECCIm4r8BVT5S5B8ePlGmgu3DLLOX6UoiGcoDjE
         SrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rWH+xfLWYAMX7ueiofm3cy0wWdiDykAPOqn1ZoZbnQ4=;
        b=6DK1z/cEGUW8jPPCEMJI/hvlOjQr7PcCOjPPTD9c1nbqNjtonfIDtwoHV9Fl0mQqFs
         VK0GJE4y0AkuKqDo0Q6rqgpWHk2nz0YrDrUgzLRqMbGGENgvn5O+9fbAyasY4iaTAE8w
         ityGRDW3Uz+iK4Tjwu2k7d8qdiqlwBRb0qUEOWOaO5MnvgVmdOKAVs1ka+uJEdnan9jv
         gRgpqg1yH485daggu7x2xMQhlFgQcRpEd7SEuLxzhlAI9a0qeo+kutGqtwi8S26ul+ew
         LTIt+Ac9Iu2zA6pUlpnFV11X56GNw+2p962mbwYjlHgmvqelwZ+/fDpGoxTglyapXdC3
         qiEw==
X-Gm-Message-State: AOAM533jLNBWQgNGvNetTW8a4M5cfBTHBnlf2oj0diO2Tfcp+Ii+vs4x
        wE3sYitr6RhBygrW/PzfyFYqxd2XUZbAEcVyCkGd+Q==
X-Google-Smtp-Source: ABdhPJw1Kq77jlw6WB7DPy6+ViIh4SzMs95Nua6Jm4DEB9bwPJ1k6unoHSXMwOiw4vbI31wEZUAAskpux0a51+QTqdU=
X-Received: by 2002:a05:6102:4194:: with SMTP id cd20mr2034653vsb.83.1642691704961;
 Thu, 20 Jan 2022 07:15:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqqwnivjgtg.fsf@gitster.g> <CAFQ2z_PA4zHV8xc1f+sMW9DnaF1E4AQrvkCav_Sx-bKRkgDLtw@mail.gmail.com>
 <CAPc5daVFUoK1UQUO5jdsLSUQ8XfkiEk+MoWKg2CZB0=N6N9XXg@mail.gmail.com> <CAFQ2z_NZL+8No44863K5n7cQkHmtn35_BtKKTQiFzHweHfTHag@mail.gmail.com>
In-Reply-To: <CAFQ2z_NZL+8No44863K5n7cQkHmtn35_BtKKTQiFzHweHfTHag@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 20 Jan 2022 16:14:54 +0100
Message-ID: <CAFQ2z_Pquzt_L6uB6eW1U=aQYm0wCD326xCACW4Mqv_cFtpC-Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #05; Wed, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 20, 2022 at 12:03 PM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> > > > * hn/reftable-coverity-fixes (2021-12-22) 18 commits
> > > >  - reftable: be more paranoid about 0-length memcpy calls
> > > >  - reftable: add print functions to the record types
> > > ..
> > > >  Expecting a reroll.
> > >
> > > The reroll was sent on Jan 12. I dropped the "reftable: be more
> > > paranoid about 0-length memcpy calls" from the series.
> >
> > The last time you mentioned "Jan 12", I went back to the lore archive
> > for the original thread [1] and didn't find anything but a few comment
> > messages on that day.
>
> Sorry, you're right. I didn't understand your previous message on the sub=
ject.

v6 is pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
