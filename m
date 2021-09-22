Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE25C433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42631611CA
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 15:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhIVPCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbhIVPCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 11:02:48 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588BC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 08:01:18 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id b67so1257463vkb.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ymsi1sqjNGvowKhCIQIFGlyBv9cK1dJmnUGhhGX0esE=;
        b=owd3slBaUMKgUhhSVg38KN7XOZ77BLzA1edmJ7GbPOF5C0KpJg45VjSphAgiv0+aCv
         kHoZyw2k44aP4lTvSqTlqhOBndc02S/4JMYxFGFbzpog8wUOuFu/550CvjoZPXwqR6Yc
         LfBbaoPJdZv66FyZM9x4m0vEnh2CWQB/zC4YYDr2Y+lJkNFvQs27XyjEOOA0P/gmaWTt
         NdwGZJMVfaQKSQGai3NaRVo9YTRYNg+oLqb6A4N/GlE1adqpW8KE1Gji3HQ6Zv9HZqMp
         /8St8cBox5LYU5Mv29oaUtW8WHNzApJVVsRzrsR/ItUS3vRNMz5kWQ1/6OJtZrs+lm1E
         yeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ymsi1sqjNGvowKhCIQIFGlyBv9cK1dJmnUGhhGX0esE=;
        b=db9mzZFj9ZEKHV6A5mrfU1+Na1dMhTNlFlMjcvs5atkw8L9ebNGQIWfVUQ04ZnkQsU
         kURBnD2Q9jawz9lNyuuaEekyAYQGTYZJkkre+gEXVUm3EiOmmK8zgemZnkXrLOOXptcD
         6xKH7ujbVnRd6PZXKff1PaozO2rzDq1A4KVP8RBHI9oR2FGosOt8kOd0i5gsWWfDJSJw
         GQUnBHIYk3F2KOvXydiBI3xtvGgbNho5XKx2o7OByLnxgmNSrBt0LEzkmB0CiWgjRoXO
         4bHlCS7rqrbbAQ29Zgvfs6epX2g7IFlirZwE5S2Yub7zVCnnSUwplqeHVV/s+7pxRDwf
         umsA==
X-Gm-Message-State: AOAM533PZ2CMJqID5QiYISoCK4FbURZiu3PNR3e1vf5GatpldJaLV0t6
        oFT8x5XeY5d0FsfIxr0S1PbnY3edYScgSXpNsEA=
X-Google-Smtp-Source: ABdhPJyy0TGuuXoUPxxUSVtQOMMjncbhFCSUmwlupWvbsyJ58EgiUpTMWUZzHbal4IftnONuU2wOMGUUdYBwPmD39UA=
X-Received: by 2002:a1f:1b16:: with SMTP id b22mr133470vkb.1.1632322871667;
 Wed, 22 Sep 2021 08:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
 <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
 <CAP8UFD2SsZyckX0tpCN-16BJ_mX6iHgd+VNSvfr-kirq2knVyg@mail.gmail.com>
 <CAOLTT8SACMz_Tct_W+_kh_cG2ELcg7c2sQ=S2si3zpiwDcZSLg@mail.gmail.com> <CAP8UFD01CNqK+-M1nnHU05WP3kW7pdXvjcgJFg1GopAt8ucQ-g@mail.gmail.com>
In-Reply-To: <CAP8UFD01CNqK+-M1nnHU05WP3kW7pdXvjcgJFg1GopAt8ucQ-g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 22 Sep 2021 23:01:00 +0800
Message-ID: <CAOLTT8RL_HnEQ4WPrq-KpBRLKjexroxtz0SVAFZYakF2AXY7jw@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <ttaylorr@github.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:39=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Tue, Sep 21, 2021 at 7:41 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:15=E5=86=99=E9=
=81=93=EF=BC=9A
> > >
> > > On Mon, Sep 20, 2021 at 4:52 PM Christian Couder
> > > <christian.couder@gmail.com> wrote:
> > >
> > > > I will also prepare soon a page with a few micro-projects. Of cours=
e
> > > > more micro-project and regular project ideas are very welcome!
> > >
> > > So here is the page:
> > >
> > > https://git.github.io/Outreachy-23-Microprojects/
> > >
> >
> > s/Outreachy-23-Microprojects/Outreachy-22-Microprojects/
>
> I think the number is not linked to the year but rather to the number
> of Outreachy rounds since the beginning.
>
> Last year's Winter round was round 21 and there has been a Summer
> round we didn't participate in, so I think the Winter 2021-2022 is
> round 23.
>

Ok. I thought it was related to the year before.

> But yeah, it might be clearer to rename all the Outreachy files with
> names like Outreachy-Winter-21-22-Microprojects to avoid such
> confusion, as I think the round number is not used much anymore by
> anyone.

Thanks.
--
ZheNing Hu
