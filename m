Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D909AC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D2D20663
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXUlnMKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgFOLcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:32:30 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0CDC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:32:29 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v6so5528384uam.10
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWDZoKo4aWmor0IFxA2T2Hu6nX76P5wcxrPE7Vr2M/U=;
        b=LXUlnMKo8/+YyAV0RglVhWFbKzquH1t8Kz6OrOg/jZ15RtNidQfb2WnOaNWIO/yvHn
         6pLWkiBNEI6trT6GRgWFuFdlqUHHhut+URFDnHCxwwTpEmDtBLim1VVnGnArnWGkGqs9
         Y51PX8eQV+3rv+jCHO5NVAxSHVDvxExWtzn90XohS2rsFg3EsvLaZ14obQGDHKrMJe6f
         xYMfmN08zOhCnDhiX0xe5mS6RTvDQoK87RXNGtviJSpnRxycWBaP/rzGYR5nP1ASxKpx
         adSiLWsUMQ2N1cVTiPu4cR4DUOb1aBv0VIGjvgIQak70idmjxPMsfZpRogosGYqMHbpZ
         9gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWDZoKo4aWmor0IFxA2T2Hu6nX76P5wcxrPE7Vr2M/U=;
        b=Mu5TDcZ0gO+FGEpl3kd2c5/iNfz4u5GWEdcdz6W5tiAYDEoOjyeYeaLhvYfMNnsi89
         dazd+7Gqa9H3sTxk6lWMn8Lq84iS3EjlPUxLJmLjsrth71WZIfmzf1LWVpRiwcRNUxUu
         xl01/7aAt2Q/g6/8heEHn3uZEK4ejmgtUyYMBUVshu9t2q1me/4Utq8pu6cna1cG1ABj
         aKn0xQ96+wcxZsyv9o2zvmwt86hLG9+kjryZQJr07a9VT51qJZ7VFjVbBIMFEgm5NTDk
         ncSH+bXuZB95+jrbxWONCBSyJEJhmboKGm4DX6gWyHK1tyVJWNCzTYAytRtgfB5ZLg45
         HCZA==
X-Gm-Message-State: AOAM532n4HyTvpLWvqvAxSZq9KkNV2pw946rQXUuPW74jve91rG7oNnv
        9tsVis2Vh/NdyB6D5FLL4dNd4UnPsQGWREhFilJjRQ==
X-Google-Smtp-Source: ABdhPJzRXVq7sCae8oSa2RejcnbQp16z+W8MbbychPJ5/l/lhXnggQ+uFNZV2zqfQB5xM27EFcwxOF9Da4hWdg+RjOM=
X-Received: by 2002:ab0:1e4:: with SMTP id 91mr18288474ual.112.1592220748403;
 Mon, 15 Jun 2020 04:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> <a4a67ce9635197d759a12a617711764c1df16b65.1591380199.git.gitgitgadget@gmail.com>
 <9a5c0243-115e-ce50-dd80-2be4c889f4ba@gmail.com> <CAFQ2z_MDeiZshhmx=BjqCg7hTF04Fj7oM5dKs15qeESEPjjXEg@mail.gmail.com>
 <543c80ab-9e51-ed34-baca-70a1f8b46b2e@gmail.com> <487a962b-31b3-5e7e-5f57-2fbc46af5dd0@gmail.com>
In-Reply-To: <487a962b-31b3-5e7e-5f57-2fbc46af5dd0@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 15 Jun 2020 13:32:16 +0200
Message-ID: <CAFQ2z_O3Xv4Y1GZ++o=25kofUaSHUUMSV+LFLzu0eWp+6HTa3g@mail.gmail.com>
Subject: Re: [PATCH v16 02/14] Make refs_ref_exists public
To:     phillip.wood@dunelm.org.uk
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 12, 2020 at 11:51 AM Phillip Wood <phillip.wood123@gmail.com> w=
rote:
> > It was a stepping stone towards that, the git_path mechanism that is
> > used to create git_path_cherry_pick_head() etc was changed to take a
> > struct repository so it could support submodules without forking a
> > separate process. However are still plenty of places where the sequence=
r
> > code assumes a single repository (it calls update_ref(), delete_ref(),
> > commit_tree_extended(), ...) and the two contributors who did a lot of
> > that work have moved on. With that in mind perhaps we'd be better off
> > just using ref_exists() and delete_ref() in this conversion. The call
> > sites will be easy enough to fixup if those functions are converted to
> > take a struct repository in the future and the result of this patch
> > series will be nicer. I've cc'd dscho and Junio to see what they think.
>
> In the end I put some patches together that change delete_ref(),
> update_ref() and ref_exists() to take a struct repository*. I'll clean
> them up and post them next week. Hopefully that will mean that this
> series can then use those functions when converting unlink() etc which
> will avoid having to expose a separate api for pseudo refs.

Sounds good.  Can you CC me on the patches?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
