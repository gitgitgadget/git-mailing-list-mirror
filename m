Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4552FC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3E7207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="e0xy/UtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgFZONX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFZONW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:13:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B9C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:13:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so10508490ljv.5
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOo9+hZ6fSJ0pn3D2/hhG201hY0bxex8SpQaV6rO3Wc=;
        b=e0xy/UtYAfGsOFzPPRPefDoVCJ2eh6DhVdbcNAYs90sJ8MI23xnbiHkS4xNdmjUDJ5
         OYJ4OR5c0FCnZhftCqoo9YGJPfSkqeUcT99SFLwhYBD9VvEMR4AFxxTvffP89UNfuRIO
         Ojw+BCF/0+zWydcN5zq8p0V0gxdilRhmOllMB9fkny2PDYcgF5yHzFZVzLcMj/LpFgHv
         nSdCx1pC+ihcgy0GvWTu9QX1cqb5EulcRnybC7tiQY7XaL3+JickoKGg/IFTq3jRXYf5
         +5HXU+/v+KwNri+w0qKK92z3CAsrDlfuVwGTPIl2DGsykJdzBzh2S++7EEDdaKMSYqNc
         T71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOo9+hZ6fSJ0pn3D2/hhG201hY0bxex8SpQaV6rO3Wc=;
        b=ZVO0eSrZrcnMxEuFtRUJP8xJu+hOnrO7sybiJok+W1rmMuX+RyAbg48jx1r/+qZsMe
         wtAsZL4tDKy/1liDsQIqOGWZZ1DK2+gFLvU29oVh8iskgkFpBt9LGTLNaPZALgFldBMV
         5vz4KbSnKu3mQgb15/POYEUZztxVdoMvVPCxT1zZ6ZC5ljNQU7jjZjGLY67e5UACzKdG
         2iGriQZ4HgdqPj7ss4CnDqmoN/Humew2vNp0bd+yPzvaMao/uiJHCgy7nkj+QukEx+xm
         9V506hheHvWpbRLTbCyqBbgtPDhr1ou7lOhtIi991TxxA/1NL7ht5wHkjJjpgWagAEuW
         4x0g==
X-Gm-Message-State: AOAM532FWik60NNCe2RtB/EJc+G0v40OD2o31LwJSJidijaflo8tUo8h
        AfR+KmYxTZ30HNlyylBoWWAEGXxZoq7YztoC/YXA23/9
X-Google-Smtp-Source: ABdhPJzLbkiHxg4jXVB6Ybu6IvytDEm0NkFbyd0UAxtqPKRVuULckCXm176wFEkwgc1e1y7hnpHt/QTg/rk716+gBTI=
X-Received: by 2002:a2e:959a:: with SMTP id w26mr1479700ljh.74.1593180798372;
 Fri, 26 Jun 2020 07:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593115455.git.matheus.bernardino@usp.br>
 <e5a10d3f2152859b75bd815c37511975057d0ab0.1593115455.git.matheus.bernardino@usp.br>
 <CAP8UFD3NwKtWYL_H5fWjT-HQVd3W8ZJ49p+faDyMQ+==ttCWjA@mail.gmail.com>
In-Reply-To: <CAP8UFD3NwKtWYL_H5fWjT-HQVd3W8ZJ49p+faDyMQ+==ttCWjA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 26 Jun 2020 11:13:07 -0300
Message-ID: <CAHd-oW7Ev_4=Kw8z=qi6U_oR6a7dzhL3kTH=xkL1PFsfqXu5QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] compat/win32/pthread: add pthread_once()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 2:45 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jun 26, 2020 at 3:00 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
>
> The commit message might want to explain a bit the purpose of adding
> these features.

Will do!

> > Note: the pthread_once() function is adapted from:
> > https://git.libav.org/?p=libav.git;a=commitdiff;h=b22693b06d1e5d73454a65c203b4d31c1ca5b69a
> >
> > Which is LGPLv2.1. Should I add any notice/acknowledgment somewhere,
> > besides the comment I added above the function?
>
> Yeah, I think you should also tell in the commit message where the
> code comes from (along with the hash of the commit) and that libav is
> LGPLv2.1 which is compatible with GPLv2 as explained in section 3 of
> the LGPLv2.1.

Sounds good, I'll add that information.

> >  compat/win32/pthread.c | 22 ++++++++++++++++++++++
> >  compat/win32/pthread.h |  5 +++++
> >  thread-utils.c         | 11 +++++++++++
> >  thread-utils.h         |  6 ++++++
> >  4 files changed, 44 insertions(+)
> >
> > diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> > index 2e7eead42c..5a7ecbd999 100644
> > --- a/compat/win32/pthread.c
> > +++ b/compat/win32/pthread.c
> > @@ -56,3 +56,25 @@ pthread_t pthread_self(void)
> >         t.tid = GetCurrentThreadId();
> >         return t;
> >  }
> > +
> > +/* Adapted from libav's compat/w32pthreads.h. */
> > +int pthread_once(pthread_once_t *once_control, void (*init_routine)(void))
> > +{
> > +       BOOL pending = FALSE;
> > +       int ret = 0;
> > +
> > +       if(!InitOnceBeginInitialize(once_control, 0, &pending, NULL)) {
>
> We put a space between "if" and the following "(". It might also be
> interesting to know perhaps in the commit message how much you adapted
> the code.
>
> For example perhaps a good strategy would be in the commit that
> imports the code to do the minimal amount of change so that it builds
> and passes the test, and then to have another commit that adapts the
> style of the code.

Makes sense. Alternatively, since the code ported from libav is quite
small, I think we might as well already adapt the style in this same
commit. I'll fix that for v2, thanks!
