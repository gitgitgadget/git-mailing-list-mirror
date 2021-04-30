Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B492C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 17:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43247613F7
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 17:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhD3RSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3RSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 13:18:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB36C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:17:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso1756319oti.2
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YrJY2pa+pU348vOad2Q0XqPEJz7XSoKBUse7YF7fkv4=;
        b=RNnIehmhRsFjhKAJy6VcVqOaiUneCfhU6vhYP24qI5dmYx/K/UYydK/5cFvFdG2poL
         EnkWhUYlaGVnsqZiPbq+8bi04kulzCTOF/jRGkSRZWehzWMN9vjwyJVQ2jEfkGLhrHNi
         B+JLwq192Szw67pEqYCu+sZM19Ax/FRtzH3xXxAApVNgE4HEVVj5vLn6uDNBkn3+9P7J
         fAKuq3aO1f0OBogNZPjuZqBO4zj+W2HodoeMKJva7SZNq9m+jssZU28T7pyzIWD48YRF
         3NsELlGVOh+EctuTgtNBttvYSSXPEe2Sar0LhbI+GX20xw62gwYCqC0Ml7gvTbB8ZA95
         XNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YrJY2pa+pU348vOad2Q0XqPEJz7XSoKBUse7YF7fkv4=;
        b=peVpOsCPzmrb0q6a8aksv1i4B3RDXaIJJ8/a585aJDJGlSgO69VXquOjHPbwYFCn9m
         DovbcqD/uELbQEn2XVVbQBfRbhhsDu4R12Vs4ThX+t1D2Rc7VSHSEL7JEHenCROQvLPA
         Q5HIZB9BEky+n9UTuqnkOhyqIY/ESng9TOMGe5iakKah3oP3UCr6EhOk/rx6hO1e8hyT
         MQxxECtGFOb+DgolPkRfRiccu5DZfO9npiVKIaizgVxZvbYxHtrzGv2ReRTWfPiBywPI
         q6keqvRK/d6GkTGAJ1ui3Y0q/hEfMpXako6ymloEul1qrd9VfDY3nsrSstqiISH0YXZx
         C/fw==
X-Gm-Message-State: AOAM532D2o4eTfz69oXPCy0iriVQfFVpwqV6B8+IvOjJ/45Y8Lm6MSd+
        i3fbQRgjzPk9ej95nVNZtLEOhMmIkfIF0Ya41fXmtLjmcj/gew==
X-Google-Smtp-Source: ABdhPJxbHZmaUH+SlX8d6nYnOj18so/rKlhYeTj8xcub1DNLFGFAZD9/6VIrYZSStC3l6yCGDdW7R0i0vhAZDsKtgQ4=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr4481585otf.316.1619803048525;
 Fri, 30 Apr 2021 10:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <011f01d73dd0$ecf91e00$c6eb5a00$@nexbridge.com>
 <CABPp-BH6RgiMwGLz31nHmis3VTpuEUG--G_6Y+Wfwg24u4Zbag@mail.gmail.com> <012601d73ddf$3d0cf660$b726e320$@nexbridge.com>
In-Reply-To: <012601d73ddf$3d0cf660$b726e320$@nexbridge.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Apr 2021 10:17:17 -0700
Message-ID: <CABPp-BE_5c1vXuxPWTO82cGmyajXxpxW+-ycZ+-5vy+tsV3bUA@mail.gmail.com>
Subject: Re: [Patch 1/3] connect.c: add nonstopssh variant to the sshVariant set.
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 9:38 AM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> On April 30, 2021 12:25 PM, Elijah Newren wrote:
> >On Fri, Apr 30, 2021 at 7:58 AM Randall S. Becker <rsbecker@nexbridge.co=
m>
> >wrote:
> >>
> >> From ba4beb8ed0dff67ae6b95692d346adce346e2871 Mon Sep 17 00:00:00
> >2001
> >> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >> Date: Fri, 30 Apr 2021 09:56:09 -0400
> >> Subject: [Patch 1/3] connect.c: add nonstopssh variant to the sshVaria=
nt set.
> >>
> >> This enhancement allows the NonStop SSH subsystem to be supported by
> >> git without the need of a wrapper script. The command arguments for
> >> the platform SSH client in /G/system/zssh/sshoss are constructed based
> >> on optional supplied environment variables SSH2_PROCESS_NAME (system
> >> defined), SSH_SUPPRESS_QUIET, and SSH_SUPPRESS_BANNER.
> >
> >Before introducing 3 new special environment variables, I think this com=
mit
> >message should explain why you can't just use
> >
> >GIT_SSH_COMMAND=3D"/G/system/zssh/sshoss -Z -Q -S"
>
> No, it would be GIT_SSH_COMMAND=3D'/G/system/zssh/sshoss -Z -Q -S $ZSSH0'=
 and that does not work correctly in the current git code base.

Is the problem that $ZSSH0 may contain spaces, or that $ZSSH0 is
expected to change over time and you don't want to have to re-run

GIT_SSH_COMMAND=3D"/G/system/zssh/sshoss -Z -Q -S $ZSSH0"

each time?

> >particularly since GIT_SSH_COMMAND was introduced specifically so people
> >wouldn't have to create wrapper scripts to pass to GIT_SSH.
>
> Going back through the archive to why this is needed: https://public-inbo=
x.org/git/008101d4f3db$56c20410$04460c30$@nexbridge.com/
>
> The SSH2_PROCESS_NAME is a system environment variable, not something I a=
m introducing, that specifies the name of the SSH process. It's format is [=
\NODE.]$NAME, which causes shell to blank it out. A wrapper script is curre=
ntly mandatory on this platform.
>
> I have been looking for a solution since that thread.

Ah, so it's the case that $ZSSH0 changes for you, but is set somewhere
by the system and you don't want to have to redefine GIT_SSH_COMMAND
each time you log into some box.

At a minimum, this explanation should be included in the commit
message here, otherwise the problem you're trying to address won't be
understood by reviewers.  It wasn't at all clear to me from your cover
letter or this commit, and I even had trouble parsing it out of the
other thread you linked to.  Only this above paragraph about
SSH2_PROCESS_NAME and its value on your system explain it. (It's still
hard to tell what from your "[\NODE.]$NAME" is literal text and what
is meant to be replaced, though, it might be useful to have an example
of the literal value of SSH2_PROCESS_NAME on some random node in the
explanation as well.)
