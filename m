Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C138C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 12:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKIMh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKIMh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 07:37:27 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DCC1788F
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 04:37:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso1150554wme.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veImyLssZzIvWK13cRGYpnlHPJfzcCJ6Fn9Oxuj6RqU=;
        b=JelGGfDCD6JWfZaA8JZp+QGdNvg5WESukWyIGq8+3twzOcJDrE2ka+ltvT4dFsXCiq
         /G/wZlzrmaqKt6viDy15bsrtLzZuyJ6F5Xt73069i8QDNBEInLraPN0+WUKd5nR6/JlW
         zCP9YFGIfkthqBUbanA8H4CoEtqqdC586efYN9b6lblKID2Lf6jZrCvJ5CwN3VAy3AOf
         2W26JXheO0qb0IA2WAxPGfOTCZAkmJAWVhR9+JMYUI08/V/ZNt8eu90ytaToRdUBZKyH
         MMtXtzxNY1zFt24djqDBAe8aQB0dp3PpzEgQ+Sr1p/EzoaEuTIarUzezmyNNmxL/Ilcs
         QCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veImyLssZzIvWK13cRGYpnlHPJfzcCJ6Fn9Oxuj6RqU=;
        b=hioECfzU5CDVeG0iiuQY2yEbCdX4HkY4IzQSFHXX1PcLz2S9xQeyBDnorubrKlQv6A
         9a4U7lSY1CTbtijuYhy4Eh5BJO1PiijqJX8po5oDb44tmGlN8PhwaHgj0jJv3vooucA9
         XBTtD2pB+yH+jJnNHoKagf7v7Sogq6hYHguxQ+w0CtznxgWmPTBMbr8ztrV8C4CZ0Psu
         QfwKPk96M846GU9ZgneyeaqZ0/dfHP0BYhfn8cXugjQDUkcON/v1YUHLW1laQYAwfgOr
         bqVcFkEscgEB6oQ9qhUD98DEOZiHfxxdksbZT9Yba9F4n2XPtgGUWIH3IK9mTSNzD42I
         /iQQ==
X-Gm-Message-State: ANoB5pn5mIBjjC430fvnnyhTbEaL0h6NPh/HbfstK27HgzLRrXxA/CA5
        opwU4XXJXKa5suWBbbUsvZqGWWcH5h6JFoSDRj5nBbN0PMM=
X-Google-Smtp-Source: AA0mqf5QMQrM/WXihmZu7jlV80gkn6Nxar3PdW+jcVmlkkn8qLdMSDe/5fNRHQKHsZ7YO2ZxF/nnPdrQmkd5AVF5hg4=
X-Received: by 2002:a1c:f407:0:b0:3cf:a856:ba12 with SMTP id
 z7-20020a1cf407000000b003cfa856ba12mr11580733wma.18.1667997444462; Wed, 09
 Nov 2022 04:37:24 -0800 (PST)
MIME-Version: 1.0
References: <CADZqe6cMahXdj0D+QZpHfOzjs9hu1PErjE+qT+PSo1FcbLkWow@mail.gmail.com>
 <CAP8UFD0FurXUo79Liu2iaging9ZzXFEjyjFq8VJ3Htkat-+pqw@mail.gmail.com>
In-Reply-To: <CAP8UFD0FurXUo79Liu2iaging9ZzXFEjyjFq8VJ3Htkat-+pqw@mail.gmail.com>
From:   Debra Obondo <debraobondo@gmail.com>
Date:   Wed, 9 Nov 2022 15:37:10 +0300
Message-ID: <CADZqe6fXb7KtG95qfE6XeCiLodTB-17RWsCT7YE6DPOkb_D+bQ@mail.gmail.com>
Subject: Re: [OUTREACHY][DRAFT Proposal] Unify ref-filter formats with other
 --pretty formats
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Christian

On Wed, Nov 9, 2022 at 2:49 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Tue, Nov 8, 2022 at 11:55 AM Debra Obondo <debraobondo@gmail.com> wrot=
e:
> >
> > Hello Team,
> > This is a draft proposal for the Outreachy Internship, could I kindly
> > have your reviews on it.
> > https://docs.google.com/document/d/11HX9dkEH--ZfXBTRWJ8rhGnlf3Bj_n_4U2Z=
-qgbDYVM/edit?usp=3Dsharing
>
> I am going to review it even if it's a bit late to be taken into
> account. (I think the Contribution Period ended on Nov 4, and today,
> Nov 9, is the last day for us to select interns.)

Thank you for taking your time to review my proposal despite its
lateness, I sincerely appreciate it. I've been at the period in the
semester where balance gets a little bit 'tricky', so, I was putting
in my last minute efforts. I had, however, submitted some of the
'required' details in the Outreachy portal before the deadline .
>
> Thank you anyway for being interested in this project and for sending
> this proposal!
>
> > Below is its basic structure:
> >
> > UNIFY ref-filter FORMATS WITH OTHER --pretty FORMATS
>
> [...]
>
> > Abstract
> >
> > Git has an old problem of duplicated implementations of some logic
> > such as the four different implementations for formatting command
> > outputs for different commands.
>
> I am not sure if there are still four different implementations. As
> far as I remember, we have been trying to unify:
>
>   - `git for-each-ref`, `git branch` and `git tag` formats into the
> ref-filter formats:
>
> done by Karthik Nayak (GSoC 2015)
>
>   -  `git cat-file` formats and the ref-filter formats:
>
> started by Olga Telezhnaya (Outreachy 20217-2018),
> continued by ZheNing Hu (GSoC 2021),
> but still not finished due to tricky performance issues
>
>   - ref-filter formats and pretty formats:
>
> started by Hariom Verma (GSoC 2020)
> continued a bit by Jaydeep Das (GSoC 2022)
> but still not finished (although there doesn't seem to be hard issues),
> so proposed for Outreachy 2022-2023
>
> > Ref-filter {.c.h} and pretty-lib
> > {.c.h} formatting logic
>
> I am not sure it's worth talking about filenames as early in this
> proposal. Also, on the current master branch, code for the pretty
> formats seems to be in pretty.{c,h} not pretty-lib.{c,h}.
>
I understand, I am still doing further research on this project, to
understand it better. I was also following Hariom's commits and
branches, which could have caused the confusion of me naming it
pretty-lib(as he has) instead of pretty (as is in git). I am yet to
begin looking through Jaydeep's work as well.

> > have been no different and require(/d)
> > unification, which will help to simplify adding new functionality as
> > Git continues to develop.
> >
> > This project was initially proposed by Hariom Verma following his FOSS
> > contributions to Git and Olga<olyatelezhnaya@gmail.com>=E2=80=99s work =
on
> > =E2=80=98Unifying Git=E2=80=99s format languages=E2=80=99.
>
> See above for more details. (Yeah, Olga worked on a project named
> =E2=80=98Unifying Git=E2=80=99s format languages=E2=80=99, but it was act=
ually about using
> ref-filter formats in `git cat-file`.)
>
> > In his final report, he had completed almost all pretty format
> > implementation with a few challenges :
> >
> > 30% Log related failing tests on branch pretty-lib-2.0.2
> >
> > Inability of pretty-lib {.c.h} to handle unknown formatting options.
>
> Yeah, Hariom wanted to create pretty-lib.{c,h} files, but I think this
> was not necessary so it wasn't done.
>
> > Mailmap logic in ref-filter requires modification due to the new email
> > options which do not allow rebasing and consequently affects the MBOX
> > commit format.
> >
> > MBOX commit format.
> >
> > Completing the work and Rebasing a few other pretty-lib branches with
> > features such as fix-graph3 using Junio's way to pretty-lib-2.0.2
>
> I think it would have been better to summarize things a bit better,
> and to avoid talking about low level details that are sometimes not
> relevant anymore, like pretty-lib.
>
> > He also brought attention to :
> >
> > Olga=E2=80=99s remaining work https://github.com/telezhnaya/git/commits=
/format
> >
> > The purpose of this Internship Project is to solve the challenges,
> > submit well-functioning patches and increase functionality and
> > simplicity in pretty-lib {.c.h}.
>
> Here also I am not sure it's a good idea to talk about pretty-lib.
>
> > Deliverables
> >
> > The purpose of this project having been to improve and easen the
> > functionality of pretty, I aim to deliver in the following:
> >
> > Working on failing formats to pass tests and maintain desired functiona=
lity.
> >
> > Easen error identification when handling unknown formats.
> >
> > Update MBOX commit format so that it still holds initial settings with
> > additional functionality.
> >
> > Modifying mailmap logic to allow additional application.
> >
> > Finishing work in other pretty-lib branches and merging with original
> > once tests are passed successfully.
> >
> > Update documentation for ease of understanding
> >
> > Final report on the improvements made and their importance.
>
> I think it would be nice if the different pretty formats for which
> some work is needed could be listed along with the work needed.
>
I will continue to edit my proposal as I do more research, despite the
passed deadline (today), because it will help me, if not for this
particular project, maybe in future, I will be able to apply the
skills, knowledge, understanding and thought process gained from this
one.

> > Work that may be done if the above is completed before the end of the
> > project timeline:
> >
> > Understanding Olga=E2=80=99s work in depth.
> >
> > Working on the formats in ref-filter that were being adopted from cat-f=
ile.
>
> This project is not about using ref-filter formats in `git cat-file`.
> Yeah, it would be very nice if you could do it, but it's very unlikely
> that you could do it on top of unifying the ref-filter and pretty
> formats. (This has been discussed recently on the mailing list between
> ZheNing Hu and me.)
>
I will look deeper into it, since well, I will still be having the 4
months holiday's time.
> [...]
>
> > In the case of the outreachy timeline having been passed, I plan to
> > work on this during the two months left in my long after-semester
> > break to further my knowledge on git and remain an active member of
> > the git community.
>
> Nice!
>
> [...]
>
> > Below is my programming plan.
> >
> > Programming Plan
> >
> > I have divided my programming plan into 5 parts, which would be as foll=
ows:
>
> I have basically the same comments for this section as for the previous s=
ection.
>
> [...]
>
> > This is the micro project required while submitting the proposal for
> > the Outreachy 2022 program:
> > https://lore.kernel.org/git/pull.1372.git.git.1667150441883.gitgitgadge=
t@gmail.com
>
> Thanks for working on this micro-project!
>
> > Motivation
> >
> > Git members are welcoming, I feel it will be a good learning community
> > for me to grow as an Open source contributor and software programmer,
> > which is one of my personal targets. During my contribution, I
> > received understandable feedback in a short period of time and was
> > able to make =E2=80=98polished=E2=80=99 and =E2=80=98out-of-the-blue=E2=
=80=99 patches as required.
> > (It=E2=80=99s part of the conversation thread in my microproject) This =
brought
> > to my awareness that git is an easily approachable community for any
> > programming challenges faced.
>
> Thanks for the kind words!
>
> Christian.

Thank you for the feedback. I would still love to be considered in the
case that Outreachy creates space for companies to accept more
interns. I will also send a V2 for the proposal soon.

Thanks,
Debra
