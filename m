Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00547610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhIIObE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbhIIOa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:30:58 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E2C14115C
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 06:21:09 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id j5so694670vki.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=43wxCOzwK+gePuMKhP8P2cjKMYjCr5sAjarY12/3NU4=;
        b=PdXZJYboSGtI2EPqBquP1jnAZXNNw+dsKQRqbUaewWgfrSZNWmW8Rba8efO2z/pjIJ
         gDiNZEy9JaJxA53zMfQapOZFf42Ii10zubD2N4+N7QjzDnmfyKJrWae/krzuw/lVVbtM
         vY1xoTX/zrRmLtmPS0aDv7nXHYgIVn641+IsYeUncH9D+0rbBH19Cq8G6fZ5mEpvc51O
         GVftLg84gmr9xdqCQBKn1Hk23WaR+um8+T4f6KPszeBebJvgDpdPRfxL5U82pZfYWYHP
         Qma6RQtp0HGMGuUNTLhQkiYouTfQFBRe8EhSfJemZAYJLUUwrxDISuvpY/H8aEuMsYNu
         2nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=43wxCOzwK+gePuMKhP8P2cjKMYjCr5sAjarY12/3NU4=;
        b=vlh9kWz1ywyB0pqaSQEBAmk+bNAu4u3vAdFFE4+yght7RSKPCdRKPyz2AlT49BgvvI
         KVnUyGu5WCH0s8f7FeU86S84HjibBWF9A8Fij5hAzQw3RrT5sy4GGYQyf18SKTTFmNS8
         UwkqTgPLyIHd9+cv7CedCk1o/hb3kj9jldUcR0pRQ9+ODe/G53TQneSnh7k/OS9oljk1
         wAVljBM3Tc5mrQv+thM2+n+Qli/TBv4/GdehiyTmRWFqjGSYbdDQSxk+gNDKHrezeT3m
         4wY9/E6IltCgvyD/qcv/rvGQU89Ga70yLbdGapc0VRCqT0nkp6RZpfDYORl3woewOhsh
         wHzA==
X-Gm-Message-State: AOAM532IB2YIZRxmI/rmuAAOzbQZw0B2HljH5lRrQ2BdAycvKBwliG3Y
        H36BAB3+j16YkQWByTCkDt8NRqjJNEiu8grArIy0tcRa8fXMs2kvMwo=
X-Google-Smtp-Source: ABdhPJyOSas0eViLia5vkfT3KkMF7x+H7Zqi2Kwh85NcGRNfYTqZVqIPX8zj3Rb9aVgQ/z4WCVEPPb58cs4poBlI+7o=
X-Received: by 2002:a05:6122:734:: with SMTP id 52mr1429505vki.8.1631193668039;
 Thu, 09 Sep 2021 06:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <CAOLTT8RzHb5zWUm1psZRTP=iST-jP4DBmG2Zh1UPdo6z+QyHcg@mail.gmail.com>
 <YTS8yiYwR+eeZf4+@coredump.intra.peff.net> <CAOLTT8SYx4f8x-0zjXLJVOpW4-Mj34mjsfwr6tWo0PbZAV9B0w@mail.gmail.com>
 <YTehP58NfcnDSWEc@coredump.intra.peff.net>
In-Reply-To: <YTehP58NfcnDSWEc@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 9 Sep 2021 21:20:56 +0800
Message-ID: <CAOLTT8TSNtVqZrdYpRpUp-JfvHUpDAMEo5k4SkiLJUjMmefcLA@mail.gmail.com>
Subject: Re: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 06, 2021 at 09:30:45PM +0800, ZheNing Hu wrote:
>
> > Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B49=E6=9C=885=E6=97=A5=E5=
=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=888:49=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Sun, Sep 05, 2021 at 04:19:53PM +0800, ZheNing Hu wrote:
> > >
> > > > > In this version there are 2 patches, tested against 'git for-each=
-ref
> > > > > --format=3D"%(objectname) %(refname)"' on a fully packed repo wit=
h 500k
> > > > > refs:
> > > > >
> > > >
> > > > Regarding this 500k refs, is there any way I can reproduce it?
> > >
> > > Try this in a clone of linux.git (or any other repo):
> > >
> > >   git rev-list HEAD |
> > >   head -500000 |
> > >   perl -lne 'print "create refs/foo/$. $_"' |
> > >   git update-ref --stdin
> > >
> > >   git pack-refs --all --prune
> > >
> >
> > Sorry, It seems that the above command is difficult to complete on my
> > machine (it took more than ten minutes). It may be stuck on git update-=
ref.
> > So I tried to reproduce it in a repo which containing 76K refs:
>
> Mine didn't take nearly that wrong, but it does depend on filesystem and
> disk performance. It's going to create 500k lock files in refs/foo. :)
>
> You can cheat a bit like this:
>
>   {
>     # grab existing packed refs; don't worry about peel lines or the
>     # header comment, we're producing a lowest-common denominator
>     # version of the file
>     grep '^[0-9a-f]' packed-refs
>
>     # now make our new fake refs
>     git rev-list HEAD |
>     head -500000 |
>     perl -lne 'print "$_ refs/foo/$."'
>   } >packed-refs.tmp
>   mv packed-refs.tmp packed-refs
>
>   # and now ask Git to repack to get everything sorted, etc
>   git pack-refs --all --prune
>
> It sounds like you were able to come up with a smaller version to play
> with anyway, but I enjoy coming up with such hacks. :)
>

Thanks, this method really works. :-)

> -Peff

--
ZheNing Hu
