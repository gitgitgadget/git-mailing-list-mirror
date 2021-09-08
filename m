Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D55C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000C7611AD
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351314AbhIHTVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350598AbhIHTVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B53C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:20:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a4so4621600lfg.8
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDeAC2zHKKB0qiwTrJpk+h5dgWwBlGVT05tW/fEjRwk=;
        b=O9U8J7rJTfFadGA3pelvo6N7+H7BckXq9dgR1f0vxlTasl6YVHi7y4rtIOL44GDLvw
         2kLjgGcgkZvjzYcGffI61Uhgk14jdCYqVEEs3p8atPgsx35PAd9/plLUS/sF49lea6rf
         bNxWgJ7sTPP4njT5lyYSWxuribqHYznXB/5S8Rmi7kPxGiff3aIVt3v3VuNS/D6jhxJf
         A/spdhPHOqVnncXLFneFCrqAlEZBGDGulRcHE/BzKLnMVgGRDujZMudblEdxDf9TNb7A
         /qcSesexL6k4sDedbwb1UkiEuzjFmq6i0ve98Bfxoxrc3s4L/P5de8XVMHZwUoSr6u0d
         OCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDeAC2zHKKB0qiwTrJpk+h5dgWwBlGVT05tW/fEjRwk=;
        b=XqrY6lS3oNbRpnk9igQFfdH7He+UI5YwiCDLpPnWSfred3/PGJOlZAS21zURpKoVR7
         gibSIPOIFbeEFWwhPEQBr2yKKMVeM90v7juZiOoQd16O6c4dVW7z8ABMNrnAS59TspNY
         z84h1PkkNWsOU9s5PL+RZnsAR2oMzaCm2tCDWKjTrpxbnFtppoLbPgwAU5qx1tXAbS2A
         OeeJqsKAxykE3VFPar8owHCLaKmVTilHQGFd8qmarVC6xawJ6E93KmLuRh08pIz6Jrxd
         R9raiM0OvfpSCoeYQdsbCsTT4fsEyWndMFqeToFMgQTKQbAviTlNhBTnOFxYomOKdd5c
         hcrg==
X-Gm-Message-State: AOAM533jRuRHV4v+QGvKSxcGLtVxycprqoF55jWtxREmgJEtUASK6X2Z
        E3GN46Ok3V+MofgGqdGuuNaTXYw3lUAdCUKCD28=
X-Google-Smtp-Source: ABdhPJxxeVH6//9cX28mjAFGLWvrUfFH1PKzULBjGC1VamUpdffclKiBe4KQuEt7ndxpwIhQ6esScyEVKBU0cn0sQBI=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr3664424lfg.557.1631128823621;
 Wed, 08 Sep 2021 12:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
 <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com>
 <xmqqmton7ehn.fsf@gitster.g> <CANQDOddQsf4Jj+634mdnJXaPG=2idCbCHd1iXO2qm1EMGcDmXg@mail.gmail.com>
 <xmqqr1dy3mq5.fsf@gitster.g>
In-Reply-To: <xmqqr1dy3mq5.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 8 Sep 2021 12:20:14 -0700
Message-ID: <CANQDOddtfO20dysG=p2g2CVHZCAVWAr7=T-srSristJ=VGirGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 12:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > On Tue, Sep 7, 2021 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Neeraj Singh <nksingh85@gmail.com> writes:
> >>
> >> > BTW, I updated the github PR to enable batch mode everywhere, and all
> >> > the tests passed, which is good news to me.
> >>
> >> I doubt that fsyncObjectFiles is something we can reliably test in
> >> CI, either with the new batched thing or with the original "when we
> >> close one, make sure the changes hit the disk platter" approach.  So
> >> I am not sure what conclusion we should draw from such an experiment,
> >> other than "ok, it compiles cleanly."  After all, unless we cause
> >> system crashes, what we thought we have written and close(2) would
> >> be seen by another process that we spawn after that, with or without
> >> sync, no?
> >
> > The main failure mode I was worried about is that some test or other part
> > of Git is relying on a loose object being immediately available after it is
> > added to the ODB. With batch mode, the loose objects aren't actually
> > available until the bulk checkin is unplugged.
>
> Ah, I see.  If there are two processes that communicate over pipes
> to decide whose turn it is (perhaps a producer of data that feeds
> fast-import may wait for fast-import to say "I gave this label to
> the object you requested" and goes ahead to use that object), and at
> the point that the "other" process takes its turn, if the objects
> are not "flushed" yet, things can break.  That's a valid concern.

That's right. This appears to be a possibility in the existing bulk
checkin code that produces packfiles for large objects as well, but
my change makes the situation much more common.
