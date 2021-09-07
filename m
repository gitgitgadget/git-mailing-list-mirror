Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68271C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 05:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBF4600AA
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 05:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhIGFvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 01:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhIGFvj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 01:51:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED7EC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 22:50:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so11236664iol.5
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=At/CboAoX9EBVCP3bovEz48v1ujeNN+IaxDbAeP5D6k=;
        b=FemMkm+i71QjZO2KKj+kOaMmmpzUJLCFee0fitKegVVJQuPKaulttRyGkRd0BkPcr6
         d39P4o3vrt2PBhr8atcwrwKqFek7uUjNWDgYfYAspUziObIyXNvQ/JB9GlZkr+Osi7j2
         lPirNL/e50m8hhktkZ1/GwNsiO6NhqttDsCjgkvmr2bv5XvyZmDV3e7Vwlnys8aPGN60
         ++Vylty8u1cNS78w7ONugv0dAAqbuu/dKIyfHP17jlSIV5QN+kFoWwAT5POVh4OVQbla
         OZeD7LGnDlY+eq0dbbkpdQyRY0DHOtjBhYfnklQxbbMurwr/8NllPcQD34D1lD6YLZu9
         rH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=At/CboAoX9EBVCP3bovEz48v1ujeNN+IaxDbAeP5D6k=;
        b=aQj/9frxhzBCbmHBwX65YvYZMj34mZPXLZEHTY6rtbatsmuxGKkDUTE5QvtYHl23DJ
         Xqxc3lp6fVDCqa/glq1GuKVVvRhEGbfNDFGT+yHIpgOAPRIbIXo1aeF427r0KgeKUiG+
         CaTFBmnNpOkWpnCALZ+Nh1pFYvAmcYsZfe11hFvt80foiX/uGKa3ni+BS1VhUGknft/T
         QzuPnZ8iF5Nb+gzCGGElvtJWTEZX9qddkP3dINYWrDXJhXMPAhKmErQ/qn33+B0CIlVV
         e12n0B7YTD0l6yLaORF/QrkJcoDdS7zf+E08fYguB3pD9AgSGROo95AU9+tzINPB5Uaf
         TFaw==
X-Gm-Message-State: AOAM533aEXzVToxtUJqCfD47Egl2OHW+ZvGl3qWgNT8M7cjykUDPbP2s
        CBqdInztEUrzXPKgnm8/SbyazSfhwU+5Nz2q1OgzlyiTNL1BF3bJ5UQ=
X-Google-Smtp-Source: ABdhPJw1VSBm9AXCejq2Dg0yFI+wSfgTN5anwnnZBgWgGglpxZz2xpA8Je+V2QrKGuJkT2zLmL2oTLeXvfIVcNWBv8w=
X-Received: by 2002:a5d:8484:: with SMTP id t4mr12279266iom.126.1630993833059;
 Mon, 06 Sep 2021 22:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
 <CAOLTT8QufEU5Q64JfQyEOs4FYCsrNX2jgj8PdmYziVtKnRyu4w@mail.gmail.com>
 <YTNrehKnfPo3E5RI@coredump.intra.peff.net> <CAOLTT8S1Tfu6YWcoHhZcydQYd_yBBCavdqyV_TzoOrEW6zHXGQ@mail.gmail.com>
 <CAHd-oW7PKQRQMRhG8577SKXL=tKSNCj=kavCthKLwZHWa-0n9w@mail.gmail.com>
In-Reply-To: <CAHd-oW7PKQRQMRhG8577SKXL=tKSNCj=kavCthKLwZHWa-0n9w@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 7 Sep 2021 13:50:21 +0800
Message-ID: <CAOLTT8Ra93pBzML4wD0mOOBSM+boG3aTgtWc9qsiBHTMZ0m+=g@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> =E4=BA=8E2021=E5=B9=
=B49=E6=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:36=E5=86=99=
=E9=81=93=EF=BC=9A
>
> On Sun, Sep 5, 2021 at 5:59 AM ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=884=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8B=E5=8D=888:50=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Sat, Sep 04, 2021 at 03:40:41PM +0800, ZheNing Hu wrote:
> > >
> > > > This may be a place to promote my patches: See [1][2][3].
> > > > It can provide some extra atoms for git cat-file --batch | --batch-=
check,
> > > > like %(tree), %(author), %(tagger) etc. Although some performance
> > > > optimizations have been made, It still has small performance gap.
> > > >
> > > > If the community still expects git cat-file --batch to reuse the lo=
gic
> > > > of ref-filter,
> > > > I expect it to get the attention of reviewers.
> > > >
> > > > The solutions I can think of to further optimize performance are:
> > > > 1. Delay the evaluation of some ref-filter intermediate data.
> > > > 2. Let ref-filter code reentrant and can be called in multi-threade=
d  to take
> > > > advantage of multi-core.
> > >
> > > I don't think trying to thread it will help much. For expensive forma=
ts,
> > > where we have to actually open and parse objects, in theory we could =
do
> > > that in parallel. But most of our time there is spent in zlib getting
> > > the object data, and that all needs to be done under a big lock.
> >
> > This big lock is "obj_read_lock()", right?
>
> The object reading code actually releases this lock before doing zlib
> decompression (and acquires it right after), to allow better
> multi-threaded performance.
>

Yeah, I guess this unlock place is in unpack_loose_short_header().

> However, it is unfortunately not so simple to call object reading
> routines in multi-threaded code, even with this lock. The lock mainly
> protects `oid_object_info_extended()` and its wrappers. Some global
> resources used by these functions are also accessed outside of them,
> which could lead to race conditions in threaded code.
>
> That's why `builtin/grep.c` and `grep.c` have some explicit calls to
> `obj_read_lock()` outside `object-file.c` and `packfile.c`. (And it
> can be quite tricky to identity these cases.)

Indeed, a large number of global variables in ref-filter code are worth
eliminating.

Thanks.
--
ZheNing Hu
