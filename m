Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935CC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 12:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136D660EFD
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 12:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbhIFMhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 08:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhIFMhs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 08:37:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6DC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 05:36:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q21so11124778ljj.6
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3sVajlVrt7qy6ut5NV4bQ3nhr/cjxcO4tthEVPhxOn8=;
        b=Pr4ZqB81/Nxyt6+ydkgw6Tz+/slkozjSAZ+bmboa6zjDFwJk1qgamRlySGcTMWpaGL
         ESFp++Zc2L38FnQx4BA4+/rBceMLjsEWi4r05LxKD+rR3BA4pEZ4WnUNQhA9S9FZNXy6
         zlMoyf5TUVrzkSni47KLkmpabxOsOGKTa/lsQni65XKLMXmoNdObzpXXpSdW42F9myeL
         wE1T1+GFbu5oSUhiZITXlQ3EQtnUYJx5w0G6C+x4Rd7yVdyuQFjWG0+m+Gq9MhEy2J9E
         N1t1tY+gbMzD7uAYJOSX8o55V4IULrIXAowYQsiuhZ7MRT2Rds+S9YKGpi17E/oyRIP4
         LgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3sVajlVrt7qy6ut5NV4bQ3nhr/cjxcO4tthEVPhxOn8=;
        b=SDb01sNEt/0mc7GpUAqHen9NS9uWcAePb1bT0cHoOzskKbA9kjBB92RO9qgRNkUFji
         xGmkRiHp3u69nu8IDBNImjHo8iOaJmxwwtaYQMtIcx2XhwawSBAY+poLh0Plm0vodaEV
         cgRda36PyUyKN0eVjgfePZvb4vWxA7/m1N9TX8YJqKWp6Mu1QWwEtZBNSravcUrvYP4i
         axzTqFFvezOE98KJvOqxB/Cr9moGPNXrdId+jonoiG9No3JbKgGOiH3s2nLCgCbOi8Tv
         N+YmCNYb4K22UXKxLA8/7UZsuB/5JjlX3udQrqoq9Qz1WnnMS19vKr3VDnLtcIYaKPn4
         8W+g==
X-Gm-Message-State: AOAM5312kMm/A+fCXUHzytO47Nqo1wdnt5DATCo6iNpcvWCEBoj4606b
        lDF+670ZsYpTwmlf7d0xCgeoS561w7+nElWb+PZ03A==
X-Google-Smtp-Source: ABdhPJymnUhjLW9VTIifG7h2T6dHf2lTRz16kYwXCESs3wwdtzp9SKeEFBaSSwdsnJGZeWJGiw7w7RDN0lCKtAhpswA=
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr2895042ljc.375.1630931802339;
 Mon, 06 Sep 2021 05:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
 <CAOLTT8QufEU5Q64JfQyEOs4FYCsrNX2jgj8PdmYziVtKnRyu4w@mail.gmail.com>
 <YTNrehKnfPo3E5RI@coredump.intra.peff.net> <CAOLTT8S1Tfu6YWcoHhZcydQYd_yBBCavdqyV_TzoOrEW6zHXGQ@mail.gmail.com>
In-Reply-To: <CAOLTT8S1Tfu6YWcoHhZcydQYd_yBBCavdqyV_TzoOrEW6zHXGQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 6 Sep 2021 09:36:31 -0300
Message-ID: <CAHd-oW7PKQRQMRhG8577SKXL=tKSNCj=kavCthKLwZHWa-0n9w@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     ZheNing Hu <adlternative@gmail.com>
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

On Sun, Sep 5, 2021 at 5:59 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=884=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8B=E5=8D=888:50=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Sep 04, 2021 at 03:40:41PM +0800, ZheNing Hu wrote:
> >
> > > This may be a place to promote my patches: See [1][2][3].
> > > It can provide some extra atoms for git cat-file --batch | --batch-ch=
eck,
> > > like %(tree), %(author), %(tagger) etc. Although some performance
> > > optimizations have been made, It still has small performance gap.
> > >
> > > If the community still expects git cat-file --batch to reuse the logi=
c
> > > of ref-filter,
> > > I expect it to get the attention of reviewers.
> > >
> > > The solutions I can think of to further optimize performance are:
> > > 1. Delay the evaluation of some ref-filter intermediate data.
> > > 2. Let ref-filter code reentrant and can be called in multi-threaded =
 to take
> > > advantage of multi-core.
> >
> > I don't think trying to thread it will help much. For expensive formats=
,
> > where we have to actually open and parse objects, in theory we could do
> > that in parallel. But most of our time there is spent in zlib getting
> > the object data, and that all needs to be done under a big lock.
>
> This big lock is "obj_read_lock()", right?

The object reading code actually releases this lock before doing zlib
decompression (and acquires it right after), to allow better
multi-threaded performance.

However, it is unfortunately not so simple to call object reading
routines in multi-threaded code, even with this lock. The lock mainly
protects `oid_object_info_extended()` and its wrappers. Some global
resources used by these functions are also accessed outside of them,
which could lead to race conditions in threaded code.

That's why `builtin/grep.c` and `grep.c` have some explicit calls to
`obj_read_lock()` outside `object-file.c` and `packfile.c`. (And it
can be quite tricky to identity these cases.)
