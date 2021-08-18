Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE3AC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA73261029
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhHRJoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhHRJoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 05:44:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2BCC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:43:38 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j18so1557474ile.8
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ePIsCRC6lKMhPCeWyMomDXWX2DzT8DErkJ1XSotWoWs=;
        b=bY4t/lRcitbUNIT0487RjacWQCWr4ZBSNarAdKdbvDdI72efenHTVJUA+EsK2Ajw45
         ISBo5Velyx5ulY1YsgOvwM+913rDe2mP4hSYPvVP14wt8o317jfoKEdqC4t+gKZQA1e1
         v4vZqjfb/CKFNn9wDdI5hABu25y5riSaLbMQJLYC8gjC4LNDjAjp7G/8CXxHCAGVQ3fu
         KJLhXaBLbivaW3RtplU9PJHpVNaxusSY0rfgCnNxlQQ0VUJxHXClTPBb5cxsglBDWns6
         zwkjUHKlTfuCUHb3p9nEihGPIatlCkO5olPVqAhNlgTCP8O63r75KL3Wq7DiLlFX6Ibw
         NcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ePIsCRC6lKMhPCeWyMomDXWX2DzT8DErkJ1XSotWoWs=;
        b=sIT17T6rCzEFt/aOwu5PDy1YFtk7Yx7YpXDAM6aGSCDNHSzUsPn+LDzmz55J/kHmTp
         8uuRHO57sj+oMs+2HHh5/TL8NpKNuxr0EI3d8+egKTavZVtNuqwJ+ONwFofSeY4ArfOv
         FPBrB6joyM9TyKn/TxofA9lpYg87YHMXOium4mTkdYxokL7GHnftMY+qayDI0AeBK/xP
         ok2uGA3qemcF3Y6SSn69fcWrIgGMiozc+UO7+TY9wi78WVXPD3zHgPbuGUrbdbwExHMM
         ABzgdIRHRGrIMeR2yq8KgIjhIgFqlZ1MAzBUfS5SUYt2SOSfo6SiTfmrmq+hOTdvygTK
         QCJg==
X-Gm-Message-State: AOAM533fCQsmJVV8zMUFjA7w+YBVV2AESfeOYiw5zn4knETCzbirQkmG
        MyYymJNQL1QgWjWpUlWl51wr1ueI+bWuzbRDNN19gq4T9uk=
X-Google-Smtp-Source: ABdhPJxJMyPvg691vQs7j3RLX/66iYeImdpIFwaYfnG8eiAHZl7gkLuGC66jnL9Y7G2+/3G8sB5cZm/JgCAOJlxzXQQ=
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr5742147ila.30.1629279817661;
 Wed, 18 Aug 2021 02:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-6-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2108171332370.55@tvgsbejvaqbjf.bet> <CAN7CjDDEv6vGPKZo3sxz8bgfN2Nzqh0HChR-tGrjDGbkhKZo=A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2108172332050.55@tvgsbejvaqbjf.bet> <CAP8UFD2PE0-8AH7-RH1Xv_cZ5s2bOfR3_KYEhBTdNqYc-Zs5-Q@mail.gmail.com>
In-Reply-To: <CAP8UFD2PE0-8AH7-RH1Xv_cZ5s2bOfR3_KYEhBTdNqYc-Zs5-Q@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 18 Aug 2021 11:43:26 +0200
Message-ID: <CAN7CjDBfHrH_BPfNpwyAn6LSeSu_o2C5v7rR-_SnpMf-=UUeow@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] bisect--helper: reimplement `bisect_run` shell
 function in C
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mi=C3=A9, 18 ago 2021 a las 10:33, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> On Tue, Aug 17, 2021 at 11:36 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Miriam,
> >
> > On Tue, 17 Aug 2021, Miriam R. wrote:
> >
> > > El mar, 17 ago 2021 a las 13:42, Johannes Schindelin
>
> > > > Also: I think at this stage, an equivalent to `cat
> > > > "$GIT_DIR/BISECT_RUN"` is missing.
> > >
> > > In the previous patch series (v3), I implemented the equivalent to th=
e
> > > cat command but I understood reviewers wanted to print the output to =
the
> > > user, so I reverted my changes for this version.
> > > https://lore.kernel.org/git/20210411095538.34129-4-mirucam@gmail.com/
> >
> > I am a bit confused: doesn't `bisect_state()` write to the `BISECT_RUN`
> > file? If so, I think we do need to show the contents by opening the fil=
e
> > and piping it to `stdout`.
> >
> > FWIW I read
> > https://lore.kernel.org/git/CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj=
7ciavCVQ@mail.gmail.com/
> > to mean the same thing, although I have to admit that I am not 100%
> > certain.
>
> I agree that, after `bisect_state()` has written into the `BISECT_RUN`
> file, we should indeed be opening it and piping it to `stdout`. That's
> what I meant in the above message.

Sorry for the confusion, I was understanding that reviewers wanted a
different approach, one thing or the other, not both.
I will do both then.
Thank you for the clarification!
Best,
Miriam.
