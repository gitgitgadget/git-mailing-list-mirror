Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E130C433E0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B77206F0
	for <git@archiver.kernel.org>; Sat, 30 May 2020 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns4LbNX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgE3TNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3TNh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 15:13:37 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8EC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:13:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f89so2690794qva.3
        for <git@vger.kernel.org>; Sat, 30 May 2020 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=poU0LZluM1PM5NOg3/EGLgAEZk3pe1LlGhQnNkuvTcw=;
        b=ns4LbNX9lmsepvuXLWjt0E09T6DedP/HrPkiklRyXFp+LZTYvXLsSeHXkjtNVL7odf
         k2Jlns7qC746ziDSIE9rSffe5YOcLhRXOatUh0JJ+7cEdoJ50ZuRDk12SMpv9imzgOEz
         rI3k6Rqi+B+Lqqb6STnMZPfub7Y5r3FwRPfoRxvbxdzXtw4/CtkER0xTORwDOzSj4qYm
         TO8cRdfdsIqXE4mwEVuKtYpv0B/GwJkFhx8Q8A2pY2D2+nQmPYMeAX3vy3EyEKw/eBNP
         3lAG44FMpac0c4zMQHlMXlcPglBj5FJCydRVhOOeT1RWTW18KWWmaZYlyBNfGoF+8zQt
         fHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=poU0LZluM1PM5NOg3/EGLgAEZk3pe1LlGhQnNkuvTcw=;
        b=PBt7g2qIfImN9aS2wdPwTh+NzA+sOTN3geHr4CNwb1GDFnWRIIeyUQJExOnF0rTEQf
         C819niMgXAUuMOhSek9HSoSUX14Tfjvu7LVD9KWcn0J2KiUgvAeTw6oNmLOmGvVVxNer
         9Eagbb3sXrWdHDSeMLVAv+poCRzPq76pCVMqLlILEvWMAm5LCH14TtiuljIpMnqmjsgt
         d7q6C4LHYbsyL/aWndXEUYR1H8MHgjVs8svhNncGQr49CFeRMRCHq+rPIt82lgPHub5N
         kRIuU9DU+xYikpQ/gtMEfpzojpNp/ixS0nuWBKN1B3Av+lW+UU5Fm86FKzlYIPu9h3al
         5now==
X-Gm-Message-State: AOAM533KjlSLnBXiUAiWNOHX1PPcL16a+6k2z1zanyTQ51tjHB20pBbk
        HqK5KxoOwznKqle++z3rv+kgEETZgvaJYOsEKj7b4w==
X-Google-Smtp-Source: ABdhPJyPFX398hapA18MWoTd6uFLtd+imeW6dvn5r/C7KD9CipyA81RMypxdEgc4iBnWZk/f9b369fk63i3nsQ10ADQ=
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr13854807qvf.30.1590866016123;
 Sat, 30 May 2020 12:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
 <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <bb329d16ce0999e198addf83d56f75762c830e1f.1590759624.git.gitgitgadget@gmail.com>
 <20200530141448.GD2151@danh.dev>
In-Reply-To: <20200530141448.GD2151@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sun, 31 May 2020 00:43:24 +0530
Message-ID: <CAKiG+9X8kEB+7n+DF5nj21KcNv_eihTTU7uQjNHAy=bvWr7=Ww@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ci: modification of main.yml to use cmake for
 vs-build job
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 7:44 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-05-29 13:40:24+0000, Sibi Siddharthan via GitGitGadget <gitgitgad=
get@gmail.com> wrote:
> > To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
> > directory of script or path. So we copy the dlls before we configure.
>
> If ICONV_OMITS_BOM is such a troublemaker for CMake,
> I'm fine with not supporting it at all.
>
> It seems like noone except me have interest in ICONV_OMITS_BOM.
>

It is not a problem supporting this check. This check has to be
implemented sometime down the road.(as it is specified in the
Makefile)
The issue currently is that this check is a bit big (~50 loc)
including setup and cleanup. This might be a burden
for the reviewers as the only reason for considering CMake support is
to support windows developers.

> > @@ -302,4 +308,4 @@ jobs:
> >      steps:
> >      - uses: actions/checkout@v1
> >      - run: ci/install-dependencies.sh
> > -    - run: ci/test-documentation.sh
> > +    - run: ci/test-documentation.sh
> > \ No newline at end of file
>
> Please fix your editor ;)
>
> --
> Danh
