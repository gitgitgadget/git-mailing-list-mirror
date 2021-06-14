Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB33C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551EB61350
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhFNNWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhFNNWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:22:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF48C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:20:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x16so6322499pfa.13
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D44DFUVxUy8nCNuWYsNiukuHpeSiCIgFt/MSQdpIRLI=;
        b=hdbqFyAY9+IScMND8ru1iCkBB7h41Wa1g66QJp3AqE0HBsXlSiByTDHDGUBD7F9eF0
         XzYW/EIQ7j7UPZvZPMVKdVO3+aOKDehdCWhL5i3nm49N9JvxWQ49Rr9fKd62A317RoTU
         54ViJr0xFlSJLWcyoxTQWn/pFyQJK138WHT01uAPffLLKiXFsMqsrvkqHJPScES9AeNZ
         oYpxhKZnvGZelFqaZsfyQw0PjtQsyIaNNAMLuJjtj3gPF/MAKoqjdeexS9mXW23rdB2D
         1yTJtygvLGfKtJzzJrs0Pdnibi8Ok8uhPTQt00ki1dN1zT+T+q2CouzZlGEWVD2lEGfQ
         Nhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D44DFUVxUy8nCNuWYsNiukuHpeSiCIgFt/MSQdpIRLI=;
        b=Uu4fZo/5xyHrPY1w66nMj26wWWA7Zcj4GThjX/qk6pHjuDBaj8h3+80Pp8VJw4p/0i
         YOz2Vww297I2UGUNvsp3zW8GzgD33FNyyvABeSEdTU0yVsWkdgLSj+FmpF+Pyrv6ZxCh
         vY71aDhpaarr7k97BenNe4O2ZNfDvW5lpknAFPSBifRa9/d1Fez5AmOYEl+jGopd17wr
         qteTySCaVqtDM7cd46nsIdxx102fC+KNvrQwGHrG6MHaFXVYLWjoJ1nilo4R51LYnaLA
         KXblUlDFPEa8PDpMpREta5n/3flIYXWx22WjPYb+ENsW2d5bm+oOKy2AC5oa61vr6+Uv
         G6gA==
X-Gm-Message-State: AOAM530mxQiJUC+eu9S4d7RuyhaMURQ+8wDCZdaERpR35Ka5rQIDK7kr
        aBgaoMOLeyVaCi5FMdLwN0yCM/v/ZeYYpt1A/5U=
X-Google-Smtp-Source: ABdhPJw8l5orGCsGZocAYtSME1xdA0NhSyoukaVkvlpKQFcTayRlYwY5+0XMaguI07SsKieNYJFClw==
X-Received: by 2002:a63:31c2:: with SMTP id x185mr17315870pgx.97.1623676809898;
        Mon, 14 Jun 2021 06:20:09 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id gq5sm12180881pjb.17.2021.06.14.06.20.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:20:09 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] Git Blog 4
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
Date:   Mon, 14 Jun 2021 18:50:05 +0530
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A4656C1-770C-429D-92A5-7A77453627D7@gmail.com>
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13-Jun-2021, at 19:47, ZheNing Hu <adlternative@gmail.com> wrote:
>=20
> [...]
>=20
> Since I am a newbie to docker, I would like to know if there is any
> way to run the Git's Github CI program remotely or locally?

Whenever I push to my fork on GitHub, a GitHub Actions workflow gets
triggered. I don't think you need to do any special setup for it.

You should be able to just access it from the 'Actions' tab.

Either way, if you are looking for something specific, there is some
work going on to update the documentation to mention this:

=
https://lore.kernel.org/git/patch-2.3-7add00cc87-20210512T084137Z-avarab@g=
mail.com/

Maybe that might be of help to you :-)

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

