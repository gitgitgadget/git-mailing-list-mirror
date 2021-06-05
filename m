Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4273C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 08:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993806139A
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 08:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFEIIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEIIG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 04:08:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD2C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 01:06:03 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i13so5336793ilk.3
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBsEb2hRPgeAQKJFEoBKBjCsnil2745a/DJ31mHKgt0=;
        b=Ot0eoh6GPu76yqSBeZ1TYlchZIggyfPzfGXsHlYAzCePLXqghaZTuWkrr51uJAoXeI
         cxI1qdr0Ki+nSXTpfDQPYjkNHRQ8CJy9BBxu6dq3ebdttVJ/hIXqZg4cRLiUBUMV+suQ
         iEtYZkz0ohOPtLSX1kOGCnewPJBucl9js0FINixZ2TtvN7XIMvNVepQ1FrQjl+2pyMP7
         /0C42DylzaXDRdy/JGFdTktb7Q/Rf8mtH8833yDva3R2j23eDN5+md5ajlE2lnXS/STp
         2Hax/rUueqTppkinRPP+U7UcFR+PUm1XGhi9qu54icWOCHN8XvRlf/q2fUkk2s3dvpCN
         iCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBsEb2hRPgeAQKJFEoBKBjCsnil2745a/DJ31mHKgt0=;
        b=BUKYNNVoGAVd/b+TmjZ6fPnFuo3BayxcMtiIa1Q5XLvzkIgAC9fTWqEeJpUm4Aujmc
         Osw3P7DFUvAJxJxvEFTlZwsq1FzEBWP23S9BGWU84VjeFTjC+ov3wn6VcWwRnHhSWIZW
         ujhj3UzwhIlgGpLGHRMGC0c/M7oQqWQ7JGYiA7/LecfUqQW4+0yFdhAgstEqpzJ1gxM8
         Gguw/BHXxdDVUyE+FbZDz7GD3zV0bkZ1+r5XNZEXFa7gcm6oBnFFz9Yd9mR6ebIunXr+
         AN8zaGQGce6IxhwnmrsTNW2hq3YkKmsYcCQO2CXIcqoA3K0SdeC1J3ogaJW/AgKkA9Ox
         pEmA==
X-Gm-Message-State: AOAM53268XrwhFCCHOrCu9NcBc8fJlfvUwCRzgK7U1p+uz7ZnK9uPWsu
        I4flK0qq39yPU9cYPUQOnUcB5zWOXRy0dueY98I=
X-Google-Smtp-Source: ABdhPJw8KHcl37fn72Uf5+X8EpuvXYEomy0VHvpDsWuzfUTsedPXGp8WASklqfJ3sLbvEokz1vc4b9pf53H5b/Qz4Y4=
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr7061335ili.174.1622880357186;
 Sat, 05 Jun 2021 01:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <pull.966.v2.git.1622808751.gitgitgadget@gmail.com> <CAP8UFD0PPU4O+L3p0qJhKpsiB=MvyGJbbtxP6Vu0YeeVQ-Ojmg@mail.gmail.com>
 <CAOLTT8SEXfNcpzKaGzvMXxJ1NS_dw-S--K5a_jQ=d3be5CgpXw@mail.gmail.com>
 <CAP8UFD3SxAh1ZW2TTMqn2e6=qP1YDd5qVd15yFR669+cPr481Q@mail.gmail.com>
 <CAOLTT8RP1myY32cOMMvU4Q2_XyKsL=+XERij7RYJYM3We0rP8w@mail.gmail.com> <CAP8UFD0xyOseUjSMUJ2fMzHo3d++PN7SOV8eXAvhqTGbkNFwaw@mail.gmail.com>
In-Reply-To: <CAP8UFD0xyOseUjSMUJ2fMzHo3d++PN7SOV8eXAvhqTGbkNFwaw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 5 Jun 2021 16:05:45 +0800
Message-ID: <CAOLTT8ReP+zX-D2sHxODpcFeU8-Vp2C4d+G8jRb6zHTmpANb-Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [GSOC] ref-filter: add %(raw) atom
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=885=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=882:45=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Sat, Jun 5, 2021 at 7:42 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> > I want to mention another question:
> > If I have a new patch series about %(rest) is based on the current %(ra=
w)
> > patch series, should I submit it immediately?
>
> Yeah, I think it's ok to send it as long as you explicitly specify
> (using a link for example) the patch series on the mailing list it
> depends on.

Ok. Because %(raw:textconv) %(raw:filter) dependent on %(raw) and %(rest),
%(raw) seems to have experienced a long cycle. These codes about new atoms
seem to stay in my local git repo for a long time. It may be a good thing t=
o
send them earlier. :)

Thanks.
