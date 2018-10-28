Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30FD51F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJ1PTr (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:19:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39224 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJ1PTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:19:46 -0400
Received: by mail-io1-f66.google.com with SMTP id n11-v6so3102771iob.6
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0P7JUsgJKWsaU28nHKhbdAzd0TZelwcLsUnhesNZcVY=;
        b=lMOPZhnlREVuYIdfcKJf0m8FjWDjL4/ifkbB7AgU7uswXV/yA2tKYretXfoHuZzMkc
         LAsgpvcSDcEFg/Ww5+rkkB/10YqeQCyu7Vm+tFHEFA1+CfK8qJTwEjI1hW3x99cqwWjI
         Eg9tZ7GKqhrNl8k83wJTMQkpLLAH5wwXnp9ohHXOuozayw3J1qaBaxl5dd8xhs+95A7F
         /BNEzehqmGTxGgV/6FIsxB8oRXjw3Q3X0g153sJa0JqV3VMB5HYX/LQRz5kF9b0i3+bV
         T6ZJoF2civOP+bbc8i+FSeVS9aWykcN5sAQTk4qPuYXxPVprB+WN6HgavWwPvrhZ7gsc
         6cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0P7JUsgJKWsaU28nHKhbdAzd0TZelwcLsUnhesNZcVY=;
        b=gLgUH969PDGLzuyiEJwqFIFhEeWbG3jzsV6nkihXzufT52CtMwz92NtDmoPrqd+VbV
         wrK5zwL094QHZFpPq4n/4TU+hJb6tJsJYiqVbw/Un8WILFG+3n3RfBP6t7FDzThRjjJY
         PD2roAg5lN1z3kZikijnBDX7jPxptqrR+7Zdr43xAnnN9J0DSiTeyvDAxgkCmIPVj65U
         0aPtlM+5FLhW6mpc9gSPFcLG48DxkGEhIZZaEsy+QXPltuv6MI3Nb8VlaYLHXGx0PAmV
         XjhOC/z69u6eb1eTJUaMOomX355KK+dkvBlQedWEK9Iv5iHrHrMIiLx2PHojuq2cEOF1
         MFZw==
X-Gm-Message-State: AGRZ1gIAACO6CsG/jDlSqE55Yu+g9otPKyQXmCTqZzsjcoyh0KgXHRO5
        cXmSQWT4/ME9Kk0Iq4eWj1fuvzlKcewJnOvbNwE=
X-Google-Smtp-Source: AJdET5fsYYiWZSWCpTQLSyPmeawg4BIvtnQ2t5/G6bIBeR8J5njxvZi9Mgvev9H97sn98A8wHW+OT4uHy4Y1pzG39SM=
X-Received: by 2002:a6b:6f06:: with SMTP id k6-v6mr4688914ioc.236.1540708565668;
 Sat, 27 Oct 2018 23:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is> <20181027084823.23382-1-pclouds@gmail.com>
 <20181028062533.GA15061@tor.lan>
In-Reply-To: <20181028062533.GA15061@tor.lan>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 28 Oct 2018 07:35:38 +0100
Message-ID: <CACsJy8BoWmWaVpXnSL8Stm_2XDnKfXSaj2i0UwZg7aEgYF9i4w@mail.gmail.com>
Subject: Re: [PATCH] wildmatch: change behavior of "foo**bar" in WM_PATHNAME mode
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        dana geier <dana@dana.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 7:25 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Sat, Oct 27, 2018 at 10:48:23AM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > In WM_PATHNAME mode (or FNM_PATHNAME), '*' does not match '/' and '**'
> > can but only in three patterns:
> >
> > - '**/' matches zero or more leading directories
> > - '/**/' matches zero or more directories in between
> > - '/**' matches zero or more trailing directories/files
> >
> > When '**' is present but not in one of these patterns, the current
> > behavior is consider the pattern invalid and stop matching. In other
> > words, 'foo**bar' never matches anything, whatever you throw at it.
> >
> > This behavior is arguably a bit confusing partly because we can't
> > really tell the user their pattern is invalid so that they can fix
> > it. So instead, tolerate it and make '**' act like two regular '*'s
> > (which is essentially the same as a single asterisk). This behavior
> > seems more predictable.
>
> Nice analyzes.
> I have one question here:
> If the user specifies '**' and nothing is found,
> would it be better to die() with a useful message
> instead of silently correcting it ?

Consider the main use case of wildmatch, .gitignore patterns, dying
would be really bad because it can affect a lot of commands. It would
be much better if wildmatch api allows the caller to handle the error
so they can either die() or propagate the error upwards. But even then
the current API is not suited for that, ideally we should have a
compile phase where you can validate the pattern first. Without it,
you encounter the error every time you try to match something and
handling errors becomes much uglier.

And it goes against the way pattern errors are handled by
fnmatch/wildmatch anyway. If you write '[ab' instead of '[ab]', '['
will just be considered literal '[' instead of erroring out.

> See the the patch below:
> > -                             } else
> > -                                     return WM_ABORT_MALFORMED;
>
> Would it be possible to put in the die() here?
> As it is outlined so nicely above, a '**' must have either a '/'
> before, or behind, or both, to make sense.
> When there is no '/' then the user specified something wrong.
> Either a '/' has been forgotten, or the '*' key may be bouncing.
> I don't think that Git should assume anything here.
> (but I didn't follow the previous discussions, so I may have missed
> some arguments.)
>
> []



--=20
Duy
