Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BDC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiHHN6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiHHN6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:58:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E03DF48
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:58:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gb36so16716814ejc.10
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9ItFIj+M5XVtsm5gbSW0H+fAHCLJ6asR4AZwMsFN3Ic=;
        b=QdQPJcl/EDfz+8r6qgcLBH3nWRVUHjXx1arASBFi7ZFfdLrad8FHeXRMfU9TJfXwhf
         L3liWlpUOz5XABMgJhy5oWeR13Iu65wUUTJ+nFdFIUJbNl24Hfx3n9mDRmU5lwejC895
         CHksVQB7dCIhmLApFdKT8ILUcFyD2/BnxPRAsRTcrFBr4Iiw7wQaC/SQavHXnw721QW7
         oOYjNnFLzxtlXPDplivoay+9T8VebXScnv2waqCsOaRjhySu3oambFbqGWgIjb8KSQGB
         osLZ+hamjYpW+iR4qZJsa4VQfiEFNMtG7KbjLpadMhcvN6oXZZ6oXLXGSw1kJOb42iZC
         HyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9ItFIj+M5XVtsm5gbSW0H+fAHCLJ6asR4AZwMsFN3Ic=;
        b=70uJPHV/G/wQ0IUhQLWuEp+c6KjKYB5gLOaSsTyon4QT+tAP4HwwHN7QEbMK/OJ4Vt
         twjzuaBQr0SZofWRo/VODPIN0pA+OAlTKyz/MopUwKDUlYZmzmES7x8yE2QSHN7+AnLo
         QmCjJ/u+nheUcznZxxRf7lj/8aI0kg8rdxMkpzWit2dida6JVkbMdonmvKNzcSvb7mJy
         BktrECCY8k3LZ/yxoL7Lk9y1Vc8Zfxfm0vffFXFBczDaefDhgNznPDIRP+nU8I3WtfSu
         oVJChOPTO2pMVDMwAlvodV/oNi5JQrgTKNhkuhGSqUbQAbjmASDKOji2fenJumeuSsph
         vMqA==
X-Gm-Message-State: ACgBeo3rBXjOrvpJH/MXak2M5K7hJcnwOBD/nAjwY0VqMjCOFohj2kFX
        SGL9zPt4s14gPjuAa5eZZsxMh4Asv01dznyHVQ8=
X-Google-Smtp-Source: AA6agR6Egh+K+vIvxS9e6MdCI0OF1iuIyGvkW8azozGi19lENekVRdAlITJATIoy9q3j3fw3r/T7PgReATl6Y+HlHBY=
X-Received: by 2002:a17:907:781a:b0:730:ccea:7c29 with SMTP id
 la26-20020a170907781a00b00730ccea7c29mr14094672ejc.85.1659967098993; Mon, 08
 Aug 2022 06:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
In-Reply-To: <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 8 Aug 2022 19:28:07 +0530
Message-ID: <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 6:36 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Abhradeep,
>
> On Tue, 2 Aug 2022, Abhradeep Chakraborty wrote:
>
> > On Tue, Aug 2, 2022 at 9:05 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > > Since you are very familiar with the details of bitmaps now, I would
> > > like to encourage you to work on some kind of validator/inspector,
> > > e.g. something along the lines of a `test-tool midx-bitmap dump` (and
> > > later `... verify`) that would help future you (and future me)
> > > investigate similar breakages. Ideally, that tool will not only parse
> > > the `.bitmap` file but immediately print out everything in a
> > > human-readable form.
>
> Have you made progress on this? I am interested mostly because I am trying
> very hard to maintain passing CI runs of Git for Windows' `shears/seen`
> branch (which essentially tries to rebase all of Git for Windows' patches
> on top of `seen`), and this failure is consistently causing said CI runs
> to fail for a while already.

Hey Dscho, I am trying hard to solve the issue but unfortunately I
haven't found the key yet.
I investigated the bitmap code-base and used debug lines but didn't
find a way to fix it. Sorry for that :|
I am still trying it.

Hope I will be able to share the good news soon. Thanks :)
> Ciao,
> Dscho
