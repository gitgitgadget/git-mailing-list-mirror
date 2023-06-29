Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE93EB64DC
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 16:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjF2QfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjF2Qeh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 12:34:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BA3AAF
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 09:34:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d9372f027so95a12.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688056467; x=1690648467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QipTjsRaifg9cQJsbuyefQ6aYz21/HyKiFFVNVpHMsg=;
        b=PRKg5XXajJ4plJ0X7zkjhNK5F9ty4WSYHvsxQTM4soWOYXJ//I+Ygats4uEal0jFsO
         mLarCglzv4/Z7lpgshsChuqGEtYOOgpUMwn3kqRUFpq58mfES7XguzFljHoGpab60+hq
         AfddsRR54ICsQuclWtFxgKM6Ludq55cUhBqqjplIOkwrf1Hw1HPHvJ8pUGjW3phMzBeH
         QoyXTKc3Plg6AZ1x8YYc/niWAZzh4d0P6rxT9+9Uwn7N3cMy+abetzxh87lkcJchYPgn
         Oqk78Gq6CVPUcFwaOe+IuYj9H/5qPmSygPLPXn+m9AEvZZv4v1a7fA40GCfWWa6ML52E
         4udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056467; x=1690648467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QipTjsRaifg9cQJsbuyefQ6aYz21/HyKiFFVNVpHMsg=;
        b=hYiI+L5ybYlLHtFv399rDi3neZmvjOtsf60SR9HCOgKLjK0mRHOMS85wDGjMskjZw5
         TP3zfVfgs5UidpgjxMGHAZyRii7egfj4/1DsH0ucjmtNodPt7ZVltL/S6Z8DNDu7yNBs
         IWj94pQDtlkPtodCN3d+epOLDp5wk0ynC5SeGMnJ5Hu9fG2qoUfrqMYrA32SRozVavy0
         hu2Xk1zFr3vEHKARA1EjuPzWkXIcpamCBCIPqPEw5YnDX3kj++YvHGXX2/LuR+6IjgyG
         7pG4nlWOSOG3ActMKJ8fINbnVbJBfLQUsP4Co3a7gEbXU/I0t9lZtP73NrLZYW6lUFDW
         cSqg==
X-Gm-Message-State: AC+VfDw2N6q2KrlTN5JMoRgLbCgjuLnMmYIP5/8h9dM8WsXVh88KA8qN
        rqbM6dbtd3H4MJf7XEYinArvAnOqxsUyawJKsZjtvQ==
X-Google-Smtp-Source: ACHHUZ6/5yd47xXsm2FZxhk+F7BhJ4XPIxtt1e2/CJCMUmBSnTFYzU3JIhUOLDGraqUdiVGmurUirGABy/Ts5qj11Ng=
X-Received: by 2002:a50:d090:0:b0:514:95d4:c2bb with SMTP id
 v16-20020a50d090000000b0051495d4c2bbmr193666edd.2.1688056467117; Thu, 29 Jun
 2023 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
In-Reply-To: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 29 Jun 2023 09:33:49 -0700
Message-ID: <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 9:06=E2=80=AFAM Vinayak Dev <vinayakdev.sci@gmail.c=
om> wrote:
>
> Hey there!
> I was looking through Documentation/MyFirstObjectWalk.txt, and upon
> building the branch containing the given code, I find that I get the
> error that C99 does not allow implicit function declaration where
> trace_printf() is encountered. However, upon including trace.h the
> error disappears, and the build proceeds just fine.
>
> I did put DEVELOPER=3D1 in config.mak before building, but it doesn't
> seem to work.
>
> Is the error pointing to a problem, or am I doing something wrong?
> If it is the former, I would be very happy to send a patch fixing this.

Yeah, it's almost certainly stale in MyFirstObjectWalk - there was
very recently a patch to clean up some headers which probably were
implicitly including trace.h when I wrote this walkthrough. Patches
totally welcome - and if you were working from the reference code in
https://github.com/nasamuffin/git/tree/myfirstrevwalk and it's on your
way to rebase and fix that too, I'm happy to update my branch
accordingly too. (If you weren't, don't worry about doing the extra
work, though.)

>
> Thanks a lot!
> Vinayak
