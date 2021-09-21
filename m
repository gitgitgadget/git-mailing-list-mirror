Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEAFC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5723D60F56
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhIUPlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbhIUPlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:41:11 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4ACC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:39:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t4so56220060qkb.9
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cNug/qjfzzIz+ZOuE1k7JMz9DvT+dAWMX3T0HayEStg=;
        b=cx6MC5dAeRNHc/lWeTKW8DL8rk9KYMhQ3Gq1BXfna5cXCsVWn32HYyPrOJDuv3m4Uo
         XBUJ0Z7gEpWSXqvSeap3bqwS2qZqyPUDUyJHfBcBZ7QcEz7gxfiYTYocD+RrloQl/Zdx
         rlMvFbfqDrHD6+i1ePo6gVW+wbt+aBED0zOjULbT1camnd8ljYtmF60O/h7g/W1XvX0Z
         eTXrR1iEwPTnQ6GOqX5FL3YIQNxj2cbGAwl6/ZA+Bv5wFb9AlxNq85teXZeHVka5Vtpz
         jvgLOeaa6g/HKxP61fls2QFy1h3+x0LEjBsHL+AF9KB465e5Xgtw5QeqLWSh9vE7NlNA
         3usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cNug/qjfzzIz+ZOuE1k7JMz9DvT+dAWMX3T0HayEStg=;
        b=FN81PvJEK/NK0SzTu5xjs7PngciEeqVyUzCBP9uY75V4QiFAyHoZ4JtbOKN5kQP+qM
         rtUSHXApzEdSfv3NN80XL5tsaLiLGyrtW587DdkjRmq9DpJukmD/SToFVexanQUFfCM4
         UYfu4JXIII2iBOwwl7grLtGQxTV6vPIzBCnFXt5SAzpMj4GCuv+/2IXgdVZVDO6Mpn9Q
         fmS7m4SrGDqw9+wpvkfbzScuvdFbRT6nffZWn3bnhpOiYNsbi2lzooGkGD/TbrMoN2ct
         I3/tTZwtkEWZ3rjzoFohnsRiHXRyinMYZoBW1Y4Ox6I5KoqCqrKpWPTIE9bnB4mIb3z/
         BAVw==
X-Gm-Message-State: AOAM533I1IO3jfoSHhZylr3FWdaZEJ+oPIp1Oxaj1umoPThy3CWXvpjA
        UhcF41XOZClR8p02ibM7IOc/HjW/t8/5jiLe4MorUxL27iU=
X-Google-Smtp-Source: ABdhPJzMWlKcx6bdbynnN7I9B8yLCLnHptAV7mOPi7c7Lklr7+Mxxh7KeHWtL1KIkRnPo6dup08pASodm7YUM3kwbms=
X-Received: by 2002:a25:2256:: with SMTP id i83mr39594850ybi.269.1632238782191;
 Tue, 21 Sep 2021 08:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com>
 <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
 <CAP8UFD2SsZyckX0tpCN-16BJ_mX6iHgd+VNSvfr-kirq2knVyg@mail.gmail.com> <CAOLTT8SACMz_Tct_W+_kh_cG2ELcg7c2sQ=S2si3zpiwDcZSLg@mail.gmail.com>
In-Reply-To: <CAOLTT8SACMz_Tct_W+_kh_cG2ELcg7c2sQ=S2si3zpiwDcZSLg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Sep 2021 17:39:31 +0200
Message-ID: <CAP8UFD01CNqK+-M1nnHU05WP3kW7pdXvjcgJFg1GopAt8ucQ-g@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     ZheNing Hu <adlternative@gmail.com>
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

On Tue, Sep 21, 2021 at 7:41 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:15=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Mon, Sep 20, 2021 at 4:52 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >
> > > I will also prepare soon a page with a few micro-projects. Of course
> > > more micro-project and regular project ideas are very welcome!
> >
> > So here is the page:
> >
> > https://git.github.io/Outreachy-23-Microprojects/
> >
>
> s/Outreachy-23-Microprojects/Outreachy-22-Microprojects/

I think the number is not linked to the year but rather to the number
of Outreachy rounds since the beginning.

Last year's Winter round was round 21 and there has been a Summer
round we didn't participate in, so I think the Winter 2021-2022 is
round 23.

But yeah, it might be clearer to rename all the Outreachy files with
names like Outreachy-Winter-21-22-Microprojects to avoid such
confusion, as I think the round number is not used much anymore by
anyone.
