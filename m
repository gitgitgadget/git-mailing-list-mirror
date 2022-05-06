Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED246C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 09:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380074AbiEFJFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 05:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiEFJFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 05:05:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA006643D
        for <git@vger.kernel.org>; Fri,  6 May 2022 02:02:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so4543491oty.3
        for <git@vger.kernel.org>; Fri, 06 May 2022 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6zCoX8jrAQg/FmV6fvVVieLmPVBPjZ0+T9Qgxm9N77Q=;
        b=f6Gtv6qYsjJXm8RjHvEfxhz/FmXnzbjvo87ikm9xUngqviuTnfx1WHat1nGGnddU2r
         2TzPtrO5bLPreGud2WkG0u9wmdtyibGxtuEOjYXp4CwAlKxB3q5y11f1Gh+LiE7H5zQV
         1lC90/SowqTRIeVb7a3HgJ8fPsTSJyh7oSVpeEL/UJtJvQXBjmLM/Rh+RGYLx4/rWzEq
         WO6zfNQdRodcnGjHcThxOJq+QNr7O71Ry9GNsBXrcKKbQMJ/bzn9HhLPhvoyJQhOQEeI
         /qqJjTC+1F1vJhk4HMYTnnGrgS93g6B8GEDDyhsYIu7npD/tMrVWqCe7Ufc6FbJehjtC
         ERrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6zCoX8jrAQg/FmV6fvVVieLmPVBPjZ0+T9Qgxm9N77Q=;
        b=Ol+3I/0qtfHdpNcE5nwnOAGud21zXgpfXnYBzW+wa9oNl9AkXJeahgXKHo7zHuX5dk
         P0pbVkmX54z6ObE0SbUypl1Ut4JL7JPkDdEbQrUqouGSxB3+gc6OFJca40y7NxEZmc+C
         FAf/xS/g6UtM76v8qE01CcOB1Hiu3e543+cQah81ghuu8ronrKUdKpULxPjy/Y0qQH7n
         LmcpN7pmGTNDI2AZoHJwdh/oymtgYMtc/aI5gjrMQp30SdMA40GQO5MYU/DbGfmDx+oF
         jWhqVwpuOVr1ixd816bZwkWwugnNojlXjTOZMXJm8s+ISDvPoj2l3ow2T+SsLM8MhcvA
         puaA==
X-Gm-Message-State: AOAM5324VP1SvaAqDLgUGiCkv/j5xuWCQnW8z6h3LN4ZjrYms+S8mXaq
        kTErkLYtIcEE5xp0iYurrm5hqDQPhW1FTQQ3GsQVevQ1AyM=
X-Google-Smtp-Source: ABdhPJwfjU8KniWOC3lE8bRRcNfxOAZTRMI1Bc5XDVAZ+FxjQpiAwWE+P433DVIhjwAQLIgFoB5dzX3FtzhEOeUhMgY=
X-Received: by 2002:a9d:4d8f:0:b0:606:210c:ccf5 with SMTP id
 u15-20020a9d4d8f000000b00606210cccf5mr692704otk.308.1651827725929; Fri, 06
 May 2022 02:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnNbXaZA9pdDspb2ajWk==rSAP0xEAQ4LNfwkzsN7B7Exg@mail.gmail.com> <ff856dc509c7424cb7137d9cac318714@atlas-elektronik.com>
In-Reply-To: <ff856dc509c7424cb7137d9cac318714@atlas-elektronik.com>
From:   =?UTF-8?Q?Christian_Gr=C3=BCn?= <christian.gruen@gmail.com>
Date:   Fri, 6 May 2022 11:01:55 +0200
Message-ID: <CAP94bnNw7rjiYQtv5k5vznwOi8tgQxzmJ3Wc_6Fvu9aXWqcPZQ@mail.gmail.com>
Subject: Re: Resizing panels in the gitk window
To:     stefan.naewe@atlas-elektronik.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Stefan. I use Windows 10 Pro (latest version, 10.0.19044 Build
19044) and git version 2.36.0.windows.1.



On Fri, May 6, 2022 at 10:32 AM <stefan.naewe@atlas-elektronik.com> wrote:
>
>
>
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: Christian Gr=C3=BCn <christian.gruen@gmail.com>
> > Gesendet: Freitag, 6. Mai 2022 09:46
> > An: git@vger.kernel.org
> > Betreff: Re: Resizing panels in the gitk window
> >
> > Maybe there=E2=80=99s a better place to address gitk? Anyone?
> > Thanks  in advance, Christian
>
> I think it would be a good idea to at least say on which OS you're using =
gitk
> and which version of git is installed.
>
> Regards,
>   Stefan
>
> >
> > On Thu, May 5, 2022 at 9:01 AM Christian Gr=C3=BCn <christian.gruen@gma=
il.com>
> > wrote:
> > >
> > > Resizing panels in the gitk window leads to a error message that=E2=
=80=99s presented
> > multiple times in a dialog:
> > >
> > > expected integer but got ""
> > > expected integer but got ""
> > >     while executing
> > > "$win sash place 0 $sash0 [lindex $s0 1]"
> > >     (procedure "resizeclistpanes" line 38)
> > >     invoked from within
> > > "resizeclistpanes .tf.histframe.pwclist 1834"
> > >     (command bound to event)
> > >
> > > Is this a known bug?
> > >
> > > I=E2=80=99ll be happy to give more details.
> > > Best, Christian
> > >
