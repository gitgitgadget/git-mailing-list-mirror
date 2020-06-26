Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81153C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB5D207D8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 00:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="syXrMvNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgFZAAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgFZAAz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 20:00:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F56BC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 17:00:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so3882580lji.12
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1f5yxBfztjFmkTVHiBXnM3hmsvs03tdfMkMWXgwM70=;
        b=syXrMvNv52cU2IecHERNpLw6hKHaAvzzIu5W6rL8PxufuGvBktqxaPBnpNBepKrcXA
         Zh9Rs7uPTgOQomi9sEN6cCq8SPm+lintgvxb2tZ/gvMoIxYOyn9ecjUXW7THYTuQi6pd
         aIh1ELIvcFAoeJwVgcZllBUIPCcynkkIvO/LWZ0msDvaHzsXvGnj3e5JxKL8wZonIAWb
         X+4FhFgjMlv9mqCsPiO6bd4Wwu1PGTCst4xokQo9LNmwNwIEoz6Ir6Th6l2C+GqBqCmm
         ZsOwWpkvyvSgwCg65AJNktbJRbW0bMnTGRIVHdvnqyeTVgvlgkdWRCVFZ7tq+FY2vXn5
         dyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1f5yxBfztjFmkTVHiBXnM3hmsvs03tdfMkMWXgwM70=;
        b=ODQeocWjY9boFsRxvhYUK4fnX7k3fu6+c/BQ+i2DWOY6v9p8/C2FbNrRNbbm1UQaiz
         gTXVHCCpw4VLtXFTXIKqPKKqmtqLKt4hDCOjKOlV3X+NwA1F8SIoj//Udttr8/55UD3i
         P05zUJft4SMeB9XawYSqH4wAEMvoCXAAJLqN5pgn2YqBn9wFky6FJPvEPS/na64uah7E
         m2qHNFdEVaPzpJQktM290NxUV+EX2bFlQ8gsIpy7n5LpwiyKWl3DezndArO4rLwGBE2J
         flJnI0WwfWkIu/pBFMngzO7LpnyQmvCx4iT+K8CUQE/LVZ616Z6GDqrKcCeJ7AI3m7wq
         QxEA==
X-Gm-Message-State: AOAM531refXGowSDRsZjma/pGe1ygxpYca/jk32BfC03fuxO5e23Do6C
        FptH6aTvNf91issXf6GQbLMyCI2vpI6JDMdlp2ym+g==
X-Google-Smtp-Source: ABdhPJx+sQvpXvjXaH6EncRgd+ZPsI8zbYOAyEa7F1ewZLyjrU7t5lry+hX9xqWzzHzOBxcwZUSantKA7zWzxABBqqE=
X-Received: by 2002:a2e:9dc2:: with SMTP id x2mr100928ljj.22.1593129652929;
 Thu, 25 Jun 2020 17:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593115455.git.matheus.bernardino@usp.br>
 <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
 <20200625230753.GB9782@camp.crustytoothpaste.net> <CAHd-oW7GzbtWONYiE9RHQRSzeB1gGvbojJEzdKSMg7qQTMCuOw@mail.gmail.com>
In-Reply-To: <CAHd-oW7GzbtWONYiE9RHQRSzeB1gGvbojJEzdKSMg7qQTMCuOw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 25 Jun 2020 21:00:41 -0300
Message-ID: <CAHd-oW4twBf-OskkJoNCxGO22mpWnVvjyiGT+MsJtF6W-J+Gyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hex: make hash_to_hex_algop() and friends thread-safe
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 8:54 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, Jun 25, 2020 at 8:08 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2020-06-25 at 20:32:57, Matheus Tavares wrote:
> > > +#ifdef HAVE_THREADS
> > > +     void *value;
> > > +
> > > +     if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> > > +             die(_("failed to initialize threads' key for hash to hex conversion"));
> > > +
> > > +     value = pthread_key_getspecific(&hexbuf_array_key);
> >
> > I think the portable name for this is "pthread_getspecific".  That
> > appears to be what POSIX specifies and what our Windows pthread compat
> > code uses.
>
> Right, thanks for noticing that!
>
> (I wonder how the Windows build passed successfully in our CI [1]...
> Shouldn't the compiler have failed due to a "undefined reference"
> error?)

Oh, I know why... I forgot to include "thread-utils.h", so
HAVE_THREADS is never defined and this code is always ignored (on both
Windows and Linux).  That's embarrassing... I'll correct that for v2.
