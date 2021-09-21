Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF6C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEAA60F94
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhIUFlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:41:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34110C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:39:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so69991669edt.7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oN5IZBe4vn2l4e2WkfYqSXXqa/ZysbeXAF9eC7JtlXU=;
        b=nJrXmf/ckah+0gTUzVdTSLf8yuvMUyZ5NzXI2yURTYB7AtzaQxlUyBJI4S71WXAVvY
         iJheAVzl5lx2cwqGL8rnUbGYONuv4VofCZ2cnYluWxpigq7MiupNXfXCVj75hpW5N7nc
         PP8Bb609E/2S8FV9MEjUBmHkYOlpd++F74PtwKKEwj4hcsFlPctb+goG5VAx/07yFa43
         YTTv+1BYzeRPrE/lZds+4pTQlCk2rDRcxa2uebC13H/8iLN1i+spPEBrulAzlNMpzilY
         CgWOWmy+fmcKbW3XDpq7OmI8AkPqqVu2vaaruJi4NdbBbBP4kmMqhDKW7YBw5UOZ6vTp
         09JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oN5IZBe4vn2l4e2WkfYqSXXqa/ZysbeXAF9eC7JtlXU=;
        b=t926d/Uc6URmDg2TyCPQqsL1wxs+66en/Cyq7UNo9R3ldRXwhW7Jihipo0ZZMZpc1g
         lBb80Lx+5ShlthoycM42mQmLsLRX22ltOZVvjD+C8k+iKDnb7EyHMOkRw1hwQP/hI+ua
         DAX5gM4QBQit5zsLS+zsSpz2Cc0Z8i/VNw9sNYLGbTgcKo0+PUXXsCqB3kFfBF4G0ZB1
         sNxvQ06IGRR1SUvVOhAltlu5LbIFKRNPJ+34MaLicyajv9UPZnlijin7IVl1X354nI9J
         bPg+OW8pCAYzIeVx4Uf4pr41TfcrCEs1Z4VzbAeguAgiS2cqcdUveshAM8VWQQr6BPco
         TlRA==
X-Gm-Message-State: AOAM532Wx4aZOxnrutUxvJ6bRES1UJmfk2ko3qMmkh8MXnv3cyaCXxeR
        6HM0YmabIFGwVWJTdRs36pvyqmA+THDy4ymrLZU=
X-Google-Smtp-Source: ABdhPJzPKfAZsNhmRGb+AZJkepFZENEj6B4MvHfnitutsGHuiL4Ps++BgLWRsn6dMkTFrwYoNJRbsA/eDO/AoIji+74=
X-Received: by 2002:a17:906:781:: with SMTP id l1mr33317248ejc.289.1632202793336;
 Mon, 20 Sep 2021 22:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local>
 <CAOLTT8SbS9-grLnn2TOL6XdR3yMkd=YrUnq=FLCo6r03Fqbg9A@mail.gmail.com> <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
In-Reply-To: <CAP8UFD37tQdbcgsMJPYE7KaO1ajwznFRUrG=9=S1WNNM-YZsqw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 21 Sep 2021 13:39:42 +0800
Message-ID: <CAOLTT8S8TxuTmddGp2WGoPtTc3gwGXzizBfVzKd87otRw7Dpiw@mail.gmail.com>
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
=8820=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:52=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Sep 20, 2021 at 9:45 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Taylor Blau <me@ttaylorr.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8819=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8812:10=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > [+everybody from upthread to cc]
> > >
> > > On Thu, Sep 02, 2021 at 10:40:45PM -0400, Taylor Blau wrote:
> > > > Are we interested in participating in the December 2021 round of
> > > > Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial commu=
nity
> > > > application deadline.
> > >
> > > The project deadline of September 23rd is fast approaching, and we do
> > > not have any proposed projects or signed-up mentors.
> > >
> > > If you are interested in mentoring, the time to sign-up and propose a
> > > project is definitely ASAP :-). You can do so by clicking "Submit a
> > > project proposal" at:
> > >
> > >     https://www.outreachy.org/communities/cfp/git/
> >
> > I haven't thought of any good projects for the time being,
> > Christian, any ideas?
>
> I already suggested the following project upthread:
>
> > > About project ideas, maybe continuing Hariom Verma's GSoC 2020 "Unify
> > > ref-filter formats with other \-\-pretty formats" project could be an=
d
> > > idea, though maybe it could interact too much with ZheNing Hu
> > > continuing his GSoC 2021 "Use ref-filter formats in `git cat-file`"
> > > project.
>
> and you replied:
>
> > If the project idea is related to Hariom or my GSoC project, I think I =
can
> > provide a lot of help. :)  I can help them as a mentor.
>
> so I am ok to co-mentor this project with you.
>
> If you are still ok, I will submit it.
>

Yeah, I am ok. grateful.

> I will also prepare soon a page with a few micro-projects. Of course
> more micro-project and regular project ideas are very welcome!

I am still looking at the code in ref-filter.c these two days, I deeply
doubt whether we can add a --no-sort option to git for-each-ref,

Inspired by Peff's experimental patches [1], I think the --no-sort option
may improve the performance of ref-filter by avoiding the execution
of ref_array_sort().

I don't know if this can be regarded as a micro-project.

This may require the help of this patch of mine: [2]
which use list api for ref_sorting. This may can help eliminate unnecessary
sorting.

[1] https://lore.kernel.org/git/YTTC2IUO1ZmTOEoR@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/pull.1025.git.1629882532.gitgitgadget@gmail=
.com/

Thanks.
--
ZheNing Hu
