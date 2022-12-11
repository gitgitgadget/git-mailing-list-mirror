Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5499C4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 16:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLKQCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiLKQCF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 11:02:05 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47855BF44
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 08:02:04 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3b10392c064so115728117b3.0
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 08:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kPXCUZ6VAUh0exqa+QCl74UVII2IdLx1UXoUTB6cyI=;
        b=XPGSgJDxFRWoHrwrjJWzMyPg1IV2e6xjChtnC5Mcej2CFC/pPV43dBixKKeQ0Nw/7y
         NFZuq93pAHgGQ8g4i0FIDd1WyKUFaPIOXO0AfJwKHEa/57zvT/uUuxYqEzGVgC/3MeXE
         UMwAQyuubm4qeONF3OEgCXWhUn2dG2iculSjN5cLbfNKtnm8dFv6xrV7W+7jBOsZiHwB
         z7+AZmZj0wpN/jdYfl/t4nvf5zDqxBskzCNbBL/VbZwGQIanEOo9vDbgOuKV24+XEXJE
         WYBg0eiEp9NRqLe6IKS3dEmbCi5fUWMeuc5fIlTwIhfPeb8GmByx4DUemIGpCFNECEVR
         FycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kPXCUZ6VAUh0exqa+QCl74UVII2IdLx1UXoUTB6cyI=;
        b=Um13US7KSQ1OUDJREYrixX8GaWQv6NbWKRdlAaKMdeglN7gfvXejbu81hQmPg87zpR
         kvmRoo2MO2XJjaQmVqW3ZNooUJjrKvR+Wku7jUDKhjqCMpJyAcC1Ys1PhIwHdYXuT5Mh
         qJov547ArALpkXGxFB5YxZafSwDOfP561PPvrPUE5gDQl6RXobiGlCZYxNHyhDdYLs5Z
         xfi3vCPGRoBOudaa04DV1XklxbPr3wunFBMrp8V+6SYJ6HHWd2BaG6wLdNZAGQ05JBAK
         mIrgi624rS0/EM2IoBaCzBIeZhnqCjMOYFuEn0c5USJwGX7hsvkKqKF/erY9FMJbflS9
         01kQ==
X-Gm-Message-State: ANoB5pmxYfl/b6Chqyxg9/dTx95RZX33ayg+Yv1BNf5sYo39blwUKuDX
        GcH5Q3aHo5ecmcsA07U9yfmpl5qLzsffwj0YV4I=
X-Google-Smtp-Source: AA0mqf6IgX2nPFl96D2izsoBHwiIC1Zbt4wCzkMjW2Ux1mdy3MPOcGPYksVdv2RinbnThbjYUSO2Nkerh+pS3Umndh0=
X-Received: by 2002:a0d:d64b:0:b0:3da:fc23:9796 with SMTP id
 y72-20020a0dd64b000000b003dafc239796mr31369928ywd.263.1670774523412; Sun, 11
 Dec 2022 08:02:03 -0800 (PST)
MIME-Version: 1.0
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com> <20221208011631.GH28810@kitsune.suse.cz>
 <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net> <20221209004918.GI28810@kitsune.suse.cz>
 <Y5KRQMcUlepwNlor@coredump.intra.peff.net> <CAOLTT8SR6JWX6mRLbyq4keb4JCfJP6Vq07LzHpb_f+e1jMnsZQ@mail.gmail.com>
 <221209.86bkoc7kgi.gmgdl@evledraar.gmail.com>
In-Reply-To: <221209.86bkoc7kgi.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 12 Dec 2022 00:01:51 +0800
Message-ID: <CAOLTT8SqFJFk2sO6quL_O8gm4FL-w+mbvjH+cg2L7OF3G_-mLw@mail.gmail.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B412=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=94 21:52=E5=86=99=E9=81=93=EF=BC=
=9A

>
>
> On Fri, Dec 09 2022, ZheNing Hu wrote:
>
> > Jeff King <peff@peff.net> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=BA=94 09:37=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Fri, Dec 09, 2022 at 01:49:18AM +0100, Michal Such=C3=A1nek wrote:
> >>
> >> > > In this case it's the mtime on the object file (or the pack contai=
ning
> >> > > it). But yes, it is far from a complete race-free solution.
> >> >
> >> > So if you are pushing a branch that happens to reuse commits or othe=
r
> >> > objects from an earlier branh that might have been collected =C3=ADn=
 the
> >> > meantime you are basically doomed.
> >>
> >> Basically yes. We do "freshen" the mtimes on object files when we omit
> >> an object write (e.g., your index state ends up at the same tree as an
> >> old one). But for a push, there is no freshening. We check the graph a=
t
> >> the time of the push and decide if we have everything we need (either
> >> newly pushed, or from what we already had in the repo). And that is
> >> what's racy; somebody might be deleting as that check is happening.
> >>
> >> > People deleting a branch and then pushing another variant in which m=
any
> >> > objects are the same is a risk.
> >> >
> >> > People exporting files from somewhere and adding them to the repo wh=
ich
> >> > are bit-identical when independently exported by multiple people and
> >> > sometimes deleting branches is a risk.
> >>
> >> Yes, both of those are risky (along with many other variants).
> >>
> >
> > I'm wondering if there's an easy and poor performance way to do
> > gc safely? For example, add a file lock to the repository during
> > git push and git gc?
>
> We don't have any "easy" way to do it, but we probably should. The root
> cause of the race is tricky to fix, and we don't have any "global ref
> lock".
>
> But in the context of a client<->server and wanting to do gc on the
> server a good enough and easy solution would be e.g.:
>
>  1. Have a {pre,post}-receive hook logging attempted/finished pushes
>  2. Have the pre-receive hook able to reject (or better yet, hang with
>     sleep()) incoming deletions
>  3. Do a gc with a small wrapper script, which:
>     - Flips the "no deletion ops now" (or "delay deletion ops") switch
>     - Polls until it's sure there's no relevant in-progress operations
>     - Do a full gc
>     - Unlock
>

Well, I understand that after the branch is deleted, some objects may be
unreachable, and then these objects are deleted by concurrent git gc,
which leads to data corruption in concurrent git push if these objects need
to be referenced, but what I don't understand that is it enough to just blo=
ck
the operation of deleting branches? Once gc happens to be deleting an
unreachable object, and git push new branch (git receive-pack) happens to
need it, won't it still go wrong?

> You'd need to be certain that all relevant repo operations are going
> through git-receive-pack etc., i.e. a local "git branch -d" or the like
> won't run {pre,post}-receive.
