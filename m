Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01025C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 03:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52376112F
	for <git@archiver.kernel.org>; Wed,  5 May 2021 03:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEEDr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 23:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhEEDr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 23:47:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D195C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 20:46:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso562214otv.6
        for <git@vger.kernel.org>; Tue, 04 May 2021 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ulb6aIezUv5qafUi4+miwgqSseK+tT57rFdM2Mi3cks=;
        b=fpsQJNRllKzoc7hdNiGtcChJ2womit+67AJiw4ClX//ikLn7q6HKBv5idwqHu0tCSr
         80XnA4r4cn46IA8+d2KQVJ7pP02Mlg81j+eOaNgDSDTK0eFOnxXhMk/UQ5YZluBOPR8w
         iBaSzP9kQ5zWB3IkYmL+2ouZ12hMnu242rGXx2Poyc7pQeHb7NF9VYUABqmc0DDdVqL/
         queQPzq4eb1P40CtaIadXjkQIkpwEgEm4ctV6mfX5+ca/Kt3lTyPFMdKeL0YhG5uAvz6
         IQtAhUd9xwN8XSheMTIRLsmvcCvQIKIZFdTlRRBrRGmLF0mbZy8W9QD0NFq44Y3yvti/
         Kecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ulb6aIezUv5qafUi4+miwgqSseK+tT57rFdM2Mi3cks=;
        b=HRLYjWsRLNTwBJoblH6a2EQMmhuqty/4hHZGV7p7KS2yxYgpRx/Mpy4fPEQCm0Qiwc
         JCMJWXSXpUd6IshsBSNZGhA8xUcT6dBbl8tRWQ6CbNy0Uk4YPOgbqXJ6Q5QvUDqKr0q1
         VDEu3SA/vUsvm8yRFgtrjVbhwY1Zu99N++ytAQrc1+ZIxkfD+hS0/ae1wzFxe2sohwPf
         pO+axDM5fCEM2abcAjM2YiyvfHv8AaAwca1uN8Gw8kbGpz3+UYBj4s4UM2rLg+mR/PGF
         74Pi247uEEkhcvJig1UwHHoo5qovClps5ZkMGV48xaTnUNaoSDM8AvSTRdPqpnd0VHtx
         /qxg==
X-Gm-Message-State: AOAM531OE11sp7yRv4tJeOGR/9a5t2wfQOHnxCVT7TrmKDtbokU6u9Mx
        fMV1CoIRcSi6FEgO9Hyg6rkww/zY92I1WlVVTzMfPBpHDio=
X-Google-Smtp-Source: ABdhPJwlECt1Esj/gGPumEkk/hTRW+MJpFemIeb4rlUNNfJjtHzKsq7W0aumsJwiQ6HeHdIYPP0qxtgyCSKg66X0JMM=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr22259819otf.316.1620186401793;
 Tue, 04 May 2021 20:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
In-Reply-To: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 May 2021 20:46:30 -0700
Message-ID: <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
Subject: Re: git switch/restore, still experimental?
To:     =?UTF-8?Q?G=C3=A1bor_Farkas?= <gabor.farkas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 4, 2021 at 3:36 AM G=C3=A1bor Farkas <gabor.farkas@gmail.com> w=
rote:
>
> hi,
>
> the "git switch" and "git restore" commands were released two years
> ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
> BEHAVIOR MAY CHANGE.".
>
> i'd love to use them, but this warning gives me pause, perhaps i
> should wait until it stops being experimental, i worry that it might
> change in behavior unexpectedly and cause problems for me.
>
> considering that they were released two years ago, could the
> experimental-warning be removed now?
>
> thanks,
> gabor

This probably makes sense.  The author of switch and restore isn't
involved in the git project anymore.  He decided to work on other
things, which was and is a big loss for us.  I think others (myself
included) didn't know all the things that might have been in Duy's
head that he wanted to verify were working well before marking this as
good, but these two commands have generally been very well received
and it has been a few years.  Personally, I'm not aware of anything
that we'd need or want to change with these commands.

That said, we're only a few weeks from -rc0, and I'd rather remove the
experimental label early in a release cycle, so maybe this would be a
good thing to do after the June git-2.32 release.  That'd give plenty
of time for others to chime in with anything they might be aware of
that they want or need fixed.

Thanks for flagging this.

Elijah
