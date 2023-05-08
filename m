Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF2C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 15:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjEHPDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEHPDw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 11:03:52 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743921B0
        for <git@vger.kernel.org>; Mon,  8 May 2023 08:03:50 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-54fa79be6e8so161596eaf.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683558230; x=1686150230;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PN6ZAiedue/zJpD01b089QuudH4GOSX52TTPHG7OlA=;
        b=DyxL3uQ8Qg5zzuIR4k1AzfC9gm6QRLgppZZKeD7+gz9vUe7WUxdgoiuM/t4EUp0jG1
         edoRi1CXPhFWiAKxxbYdWUS89I4gBXKtGg5kIilJzyfXAswVUEf/5GDmN3FUWIuuLwGH
         Eg3jPQcmRwR/kz6qIVdPkWCgiZgNz0z0bxM1Vfm4u+jAXIQlNlsvsObmEItQCFpe0jWi
         YsutWLH1PT/YKVZ0k8750aXfwt/8QXngVh+PrF37as7PQVvhpciJ25UcCkDyNeGOKE44
         giU07toA1lA3JYcdrTQ3qnztF2GXlqudIdlUHrDURuDxmeWr3cjxlN/aqxs6TAkFH2xn
         pxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683558230; x=1686150230;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PN6ZAiedue/zJpD01b089QuudH4GOSX52TTPHG7OlA=;
        b=ZWABq6R2OvV4BxC0oF9T5x/F+fHM92FVf8zEMvDNflQGoqXEooeanRZr3L0z8XFL7J
         Lc8irV0wEjl07tT5OA3R30R1+uFgbHFaywJ/TR9QPMbPGmZDjS4FuT4PyIQNMF+X7hqw
         nt8fsEg0ysjL7cN9E4WOIzNtR1i8RGOOUbKKvxsG/CE7VENI084N0HjXa7OuqDfS1oR2
         FK+5F7VMS3b8amXpSJ5MYpVZLBPsd3wZES/38jz1YlYOc4AtXgjRbHX4eeac7EP21281
         AGqTmXnZWVoFbg/a5zl9MUO33OuV/o+5chUsO/BatbAOaGfejs13FRa7bS/xiWj3Jp5h
         qnvw==
X-Gm-Message-State: AC+VfDwzU6SjS3byS+Jf6+mKeKcZju2Kh5mueg+Ni+4YQqKY2jBhNCpt
        Y5+pajPtZNOjieVYf/B22mE=
X-Google-Smtp-Source: ACHHUZ59J0GKC1IB9pS7s13CNE2z27KbriU9QDN2jPuLyjCLuA59H5EWxfxcfHBnf0+QEThim5WaiA==
X-Received: by 2002:a4a:2755:0:b0:54f:83c7:d4cc with SMTP id w21-20020a4a2755000000b0054f83c7d4ccmr1448503oow.8.1683558229557;
        Mon, 08 May 2023 08:03:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g25-20020a4ad319000000b00549f2828585sm4100345oos.33.2023.05.08.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:03:48 -0700 (PDT)
Date:   Mon, 08 May 2023 09:03:48 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dan Stromberg <strombrg@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Thomas Guyot <tguyot@gmail.com>, git@vger.kernel.org
Message-ID: <64590f5430b36_79d229439@chronos.notmuch>
In-Reply-To: <CAOvKW55MbXF8sDaGTTk9XJxw6Ln9E9G8qOF4wbXzEKY=GH=Zag@mail.gmail.com>
References: <CAOvKW55oWs+atYyy-cTb=H0VhJx-V+M7_7FsqjdJ_jU9bR+8LA@mail.gmail.com>
 <a611877f-c515-033c-e015-f3952b520c08@gmail.com>
 <CAMP44s23Qsw3behbm57BNKeT9w_u1OunV04A9uzz85rDcD_Uug@mail.gmail.com>
 <CAOvKW55MbXF8sDaGTTk9XJxw6Ln9E9G8qOF4wbXzEKY=GH=Zag@mail.gmail.com>
Subject: Re: Weird merge records
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Stromberg wrote:
> On Sun, May 7, 2023 at 1:34=E2=80=AFPM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > On Sat, May 6, 2023 at 10:20=E2=80=AFAM Thomas Guyot <tguyot@gmail.co=
m> wrote:
> >
> > > You shouldn't change the user's config - you can instead use
> > > command-line switches with git-pull to force the desired behavior. =
In
> > > this case (which is also the default if there is no pull.rebase con=
fig)
> > > it will merge with the remote (and that merge will be a fast-forwar=
d if
> > > you have no added commits).
> >
> > Actually no: it won't merge the current branch with the remote, it
> > will merge the remote with the current branch, which is not the same.=

> >
> > This is one of the many reasons many git veterans recommend most user=
s
> > to simply avoid doing `git pull` [1]: it very rarely does what you
> > want.
> =

> You seem to be implying that I shouldn't use 'git pull --rebase
> upstream "$branch"'.

If you know what you are doing, then do whatever you want. `git pull --re=
base
upstream $branch` is fine, if you know what that does.

I would just keep in mind that `git pull` wasn't meant to merge your chan=
ges to
upstream, it was meant to merge $branch to your integration branch.

> If that's the case, what would you recommend?

I would recommend `git fetch` + `git rebase` (or merge). If you are expli=
cit
about what you want to do, surprises are minimized.

-- =

Felipe Contreras=
