Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215CEC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00D02083E
	for <git@archiver.kernel.org>; Tue, 19 May 2020 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWEeNtLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgESONw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESONw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 10:13:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC03C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 07:13:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs4so11651489edb.6
        for <git@vger.kernel.org>; Tue, 19 May 2020 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ac7CQf69pNMPV5G3r1S7Hxh6B7/nTdtf55C+bzoQ36s=;
        b=fWEeNtLpFWtOhK2e+I4NDsfnXlFOacfxc2ys/1ziEa5mtnufW1BDVLR9AwB/9zRR7i
         gv2NBpcQ28MjzFkGBwipF9VQP4TIEM1yjEb+HeK6B9jobujkUYx0bCaBatkf94/D0vuw
         5E+OERaXDJWKqRhdtdgNNLwUizVSow6xX2xq5vU8I0uTbZmLNsaOeE67JUuVz6omMc1W
         F4bvhZb4vkPtNkHoH7CHUKRpm7iXLFsDjjZIlIP7sdZ3rqXHypJi2SOUndBvDC7MB9Dj
         LkmEnteV/IczMP+hP4eom9hE/Iw8W/sN8ZuCLAMrgPSXR4PahDUsltofOrB/xkYqnlIs
         b1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ac7CQf69pNMPV5G3r1S7Hxh6B7/nTdtf55C+bzoQ36s=;
        b=fPuR2Lmh3au2CcLoZzuo88mkCarZuFh7WL1GZ1EMjafPJbi4gTFwdeSB8fubh77jAD
         pBLe6ydxWO5M5Coa1+w9ziGz+yBwgL5kvWRTlPv+c/4prCixbNrgB7whimHWF8lysmIG
         BT1Vhh9YwuUrvf4BpbeuGIxcGpsteAJfx/sD0emMa7PhfcKkyGfV1VdCbmauRqsO+Wyw
         r7fD1/WHGuYpSVkU5n3kfRnld6ZV7QxHyNSl0gOGbC2Y1Zjtdmtq/yO80GurUZcHeLTl
         nCdegYe4CAUMy/3768mmwb2xA75O+WYQCv1yY8lSvfPVuQX8nUlm0p9knFyYksQLiHJG
         ll9Q==
X-Gm-Message-State: AOAM532Q8BQKhfHhotGv/RqF62REu9ctB34giH266hJca8QJUEcJOsKA
        ftgVsBa45D5urRFabgFmWwZwTTbIoMNNJOoDLGI=
X-Google-Smtp-Source: ABdhPJyH1LpoBbjU3dpO8wvZdBafJcSIs1mNk8gqEEIcd7HMTIO1xjq+exEP0JIrBadG1Eqo3iDrNaKe5lGUp9opt4w=
X-Received: by 2002:a05:6402:948:: with SMTP id h8mr10388830edz.127.1589897630856;
 Tue, 19 May 2020 07:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518141311.GC1980@danh.dev>
 <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
 <20200518153025.GD1980@danh.dev> <CALDDTe0BvyXYz39n0EqGnJgdfHMziwW7V5xQO_H=+OKm20jfFA@mail.gmail.com>
 <20200519005645.GD1999@danh.dev> <CAP8UFD2vYwnwgNWX3tg5w-7kCg3kzNscVbnk0DJfSD4UV-D0hg@mail.gmail.com>
 <20200519113920.GA2051@danh.dev>
In-Reply-To: <20200519113920.GA2051@danh.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 May 2020 16:13:38 +0200
Message-ID: <CAP8UFD00AAG7hmLEq_LzhcmQ=iHMV27W9+75g9y9JMQSt15j6Q@mail.gmail.com>
Subject: Re: [PATCH] t5703: replace "grep -a" usage by perl
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Darren Tucker <dtucker@dtucker.net>, git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 1:39 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-05-19 09:13:19+0200, Christian Couder <christian.couder@gmail.com=
> wrote:
> > On Tue, May 19, 2020 at 3:00 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng D=
anh
> > <congdanhqx@gmail.com> wrote:

> > >  test_expect_success 'config controls ref-in-want advertisement' '
> >
> > At least you should add the PERL prereq to the test with something like=
:
> >
> > test_expect_success PERL 'config controls ref-in-want advertisement' '
>
> Well, that's is not t/README says:
>
>  - PERL
>
>    Git wasn't compiled with NO_PERL=3DYesPlease.
>
>    Even without the PERL prerequisite, tests can assume there is a
>    usable perl interpreter at $PERL_PATH, though it need not be
>    particularly modern.
>
> And, there're a lot of tests using perl without PERL prereq:
>
>         $ git grep -l '[        ]perl ' 't/t????-*.sh' | wc -l
>         55
>         $ git grep -l PERL 't/t????-*.sh' | wc -l
>         35

Ok, sorry about the noise then.
