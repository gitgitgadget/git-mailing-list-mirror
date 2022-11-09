Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16930C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 11:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKILtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 06:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKILtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 06:49:40 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759571C126
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 03:49:39 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-376596ae449so4164717b3.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 03:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z30wDc3v+RcWXx2+sPwI85VgJuohR3M4zbfCHOmzEXo=;
        b=EOYrjtreCHc+c1/meXpPjxYqcHRzPk9oc+0gz1Yn273eRqukvN9+UGC8hDOPjoDSr6
         y9X+VqmcqWQMVPVHZHMSZUwFUqi7p2cuiLp8ZkoO2N/lIELVY+a8QRxth2GB820ND35y
         lpIwqj7w3T/0bfBrEJKRe7vwueGw0LgEDXdD2OlZMO2LT8Cyy1bQ8gWAYBkaiwKPZWxt
         TH9vjLVikjHrnoR/DCK8VVmvu2RyTER/CwRUWlKpHmiMkjVFLwTadjGvU7nU2oIfnm7F
         IOL5mlr2bcI3Iy09zUY0G9P+3Om8B+ozOc1aXpD/nxiNCeDnS10322j9g0iFwsE4gj4d
         RJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z30wDc3v+RcWXx2+sPwI85VgJuohR3M4zbfCHOmzEXo=;
        b=kpDnQkc2dHdvgsM7Jb1t1z/gBAjTQa93Jy/l04/eyKcuwMbUEzyyHW9crrCmXFUtqE
         0ZCD3h2siyy6gMeShRsE//1wiiJkPs1A4MwhPoNzsKsjdwc3uqisOkrYBYHckaiuTfOh
         apXQ1cSJstVOowFKbOUk2OvKvMDuIMUcWCt8TQdEpQYQoHvQTrOkxf2U67HoUVHe1MdK
         c+lB+iSNm+2K9QcPIc9fIljlDxKe9NM02VMosedn32U3fS62PpkuCO7prZlbVW2EyM+4
         9oZfsY7XAqLjhj673680/7Ch0nIcsG0HNhllDBUynnsSrduHGpnNSD53feEemqxyqjjl
         myNw==
X-Gm-Message-State: ACrzQf3EqDVPFy/drGd9/Oe/yEhtX92nHrfxO8cvGBsjYcX/XvrpLjxP
        mYySOAUnQb5ssLZvvTrpXifS15/L8SHA22QijoSdCKxWNts=
X-Google-Smtp-Source: AMsMyM7u/8dggHHBb0ErsaS6qor/IUscZkhBk9rpT59ukiI/ebsIC9gOpFP/f/Wo5cfQJfdb0dkXE4Jh2GFbg1o12Bs=
X-Received: by 2002:a81:a109:0:b0:367:efbe:e1f0 with SMTP id
 y9-20020a81a109000000b00367efbee1f0mr56385533ywg.365.1667994578470; Wed, 09
 Nov 2022 03:49:38 -0800 (PST)
MIME-Version: 1.0
References: <CADZqe6cMahXdj0D+QZpHfOzjs9hu1PErjE+qT+PSo1FcbLkWow@mail.gmail.com>
In-Reply-To: <CADZqe6cMahXdj0D+QZpHfOzjs9hu1PErjE+qT+PSo1FcbLkWow@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 Nov 2022 12:49:27 +0100
Message-ID: <CAP8UFD0FurXUo79Liu2iaging9ZzXFEjyjFq8VJ3Htkat-+pqw@mail.gmail.com>
Subject: Re: [OUTREACHY][DRAFT Proposal] Unify ref-filter formats with other
 --pretty formats
To:     Debra Obondo <debraobondo@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Nov 8, 2022 at 11:55 AM Debra Obondo <debraobondo@gmail.com> wrote:
>
> Hello Team,
> This is a draft proposal for the Outreachy Internship, could I kindly
> have your reviews on it.
> https://docs.google.com/document/d/11HX9dkEH--ZfXBTRWJ8rhGnlf3Bj_n_4U2Z-q=
gbDYVM/edit?usp=3Dsharing

I am going to review it even if it's a bit late to be taken into
account. (I think the Contribution Period ended on Nov 4, and today,
Nov 9, is the last day for us to select interns.)

Thank you anyway for being interested in this project and for sending
this proposal!

> Below is its basic structure:
>
> UNIFY ref-filter FORMATS WITH OTHER --pretty FORMATS

[...]

> Abstract
>
> Git has an old problem of duplicated implementations of some logic
> such as the four different implementations for formatting command
> outputs for different commands.

I am not sure if there are still four different implementations. As
far as I remember, we have been trying to unify:

  - `git for-each-ref`, `git branch` and `git tag` formats into the
ref-filter formats:

done by Karthik Nayak (GSoC 2015)

  -  `git cat-file` formats and the ref-filter formats:

started by Olga Telezhnaya (Outreachy 20217-2018),
continued by ZheNing Hu (GSoC 2021),
but still not finished due to tricky performance issues

  - ref-filter formats and pretty formats:

started by Hariom Verma (GSoC 2020)
continued a bit by Jaydeep Das (GSoC 2022)
but still not finished (although there doesn't seem to be hard issues),
so proposed for Outreachy 2022-2023

> Ref-filter {.c.h} and pretty-lib
> {.c.h} formatting logic

I am not sure it's worth talking about filenames as early in this
proposal. Also, on the current master branch, code for the pretty
formats seems to be in pretty.{c,h} not pretty-lib.{c,h}.

> have been no different and require(/d)
> unification, which will help to simplify adding new functionality as
> Git continues to develop.
>
> This project was initially proposed by Hariom Verma following his FOSS
> contributions to Git and Olga<olyatelezhnaya@gmail.com>=E2=80=99s work on
> =E2=80=98Unifying Git=E2=80=99s format languages=E2=80=99.

See above for more details. (Yeah, Olga worked on a project named
=E2=80=98Unifying Git=E2=80=99s format languages=E2=80=99, but it was actua=
lly about using
ref-filter formats in `git cat-file`.)

> In his final report, he had completed almost all pretty format
> implementation with a few challenges :
>
> 30% Log related failing tests on branch pretty-lib-2.0.2
>
> Inability of pretty-lib {.c.h} to handle unknown formatting options.

Yeah, Hariom wanted to create pretty-lib.{c,h} files, but I think this
was not necessary so it wasn't done.

> Mailmap logic in ref-filter requires modification due to the new email
> options which do not allow rebasing and consequently affects the MBOX
> commit format.
>
> MBOX commit format.
>
> Completing the work and Rebasing a few other pretty-lib branches with
> features such as fix-graph3 using Junio's way to pretty-lib-2.0.2

I think it would have been better to summarize things a bit better,
and to avoid talking about low level details that are sometimes not
relevant anymore, like pretty-lib.

> He also brought attention to :
>
> Olga=E2=80=99s remaining work https://github.com/telezhnaya/git/commits/f=
ormat
>
> The purpose of this Internship Project is to solve the challenges,
> submit well-functioning patches and increase functionality and
> simplicity in pretty-lib {.c.h}.

Here also I am not sure it's a good idea to talk about pretty-lib.

> Deliverables
>
> The purpose of this project having been to improve and easen the
> functionality of pretty, I aim to deliver in the following:
>
> Working on failing formats to pass tests and maintain desired functionali=
ty.
>
> Easen error identification when handling unknown formats.
>
> Update MBOX commit format so that it still holds initial settings with
> additional functionality.
>
> Modifying mailmap logic to allow additional application.
>
> Finishing work in other pretty-lib branches and merging with original
> once tests are passed successfully.
>
> Update documentation for ease of understanding
>
> Final report on the improvements made and their importance.

I think it would be nice if the different pretty formats for which
some work is needed could be listed along with the work needed.

> Work that may be done if the above is completed before the end of the
> project timeline:
>
> Understanding Olga=E2=80=99s work in depth.
>
> Working on the formats in ref-filter that were being adopted from cat-fil=
e.

This project is not about using ref-filter formats in `git cat-file`.
Yeah, it would be very nice if you could do it, but it's very unlikely
that you could do it on top of unifying the ref-filter and pretty
formats. (This has been discussed recently on the mailing list between
ZheNing Hu and me.)

[...]

> In the case of the outreachy timeline having been passed, I plan to
> work on this during the two months left in my long after-semester
> break to further my knowledge on git and remain an active member of
> the git community.

Nice!

[...]

> Below is my programming plan.
>
> Programming Plan
>
> I have divided my programming plan into 5 parts, which would be as follow=
s:

I have basically the same comments for this section as for the previous sec=
tion.

[...]

> This is the micro project required while submitting the proposal for
> the Outreachy 2022 program:
> https://lore.kernel.org/git/pull.1372.git.git.1667150441883.gitgitgadget@=
gmail.com

Thanks for working on this micro-project!

> Motivation
>
> Git members are welcoming, I feel it will be a good learning community
> for me to grow as an Open source contributor and software programmer,
> which is one of my personal targets. During my contribution, I
> received understandable feedback in a short period of time and was
> able to make =E2=80=98polished=E2=80=99 and =E2=80=98out-of-the-blue=E2=
=80=99 patches as required.
> (It=E2=80=99s part of the conversation thread in my microproject) This br=
ought
> to my awareness that git is an easily approachable community for any
> programming challenges faced.

Thanks for the kind words!

Christian.
