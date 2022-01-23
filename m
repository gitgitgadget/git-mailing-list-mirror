Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E161C433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 00:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiAWAic (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 19:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiAWAib (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 19:38:31 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A1C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 16:38:30 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id w206so7874889vkd.10
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 16:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE4Q+cHZn+4JtI95pWUx1rv5Wsyb3OjBgCY0IgUbYjY=;
        b=k4+YNlwNIV81P/beUo9H7Its1AvRA63rghjkBq87Z0i5BKzZ8lIZsIkYQ5W9ITqD4m
         oViVHMXaoc8yImcMix3G4GepOwXN+JxuL5An+dekvq4US+IVHc3i3uj1ynyAmanAWzN7
         I6OcphTfJRmIijtJT1QnQCbfE3QjeHKVqaFBBWNiucy8fxRR2Xpm3GxxJZkSyuU/9wHe
         sfV2vxK0lMvzj6wNgUEzfpnHlwRXAbJBCekJV2SQCidKwnpRcNBkR1yHZ++gb5PEiMbw
         rzYYQ0h8w/ei3OAqqcStEa4ng/LxCUiVPyHWTxsl72Is3ahed6M8+OUPXkBsVxsu3Bzm
         LpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE4Q+cHZn+4JtI95pWUx1rv5Wsyb3OjBgCY0IgUbYjY=;
        b=KjxPxbGIp4XFPM22jsLef849S70PEN7MnDiwOVQ40Ev8L+avc1O+5+oE61Q01HDHtK
         2Cv1lPnuH3DoZpI/NVQzDxUWBi04Dc2ylx2uR8MQDkrg5KT1/Is0SLd8iEXOj3QhB7hz
         yvf7E/VSrwgYAVewcFnuN3IdFMNB9HuN58CnjavufwLjSSO+PtV7GNOahtT+Ku5r85A4
         uccHhiTNcliQIeRroEkifr113I+dsmY8MRUmZayd1GnECT/FFOtQzqoo9XCmZN7+khUo
         vJyMARYjrd9j7RV2Erm0Xw4sb6408HBL8h5S/NiK1GARC2lwIgOmF7+yAWxbuAMxnJLv
         grog==
X-Gm-Message-State: AOAM530oKtawxpyE9B4woNm5jv1pHQQ8RM4cR1s3f01ih+zPyBDbnbrE
        2gX7pJjFseWZ8sG1AOT/Vm6hqqAVviaex8rrgc96ik2Oh87AN1Ae
X-Google-Smtp-Source: ABdhPJxlPed3NI6iY+BrU0pLRDoUDK/zS/hYa8gIi4luOhwVOwUt11N2lnE7RzqrnE290QN7x1XTKv6euhfZBQxTh5A=
X-Received: by 2002:a05:6122:1793:: with SMTP id o19mr3995088vkf.40.1642898309027;
 Sat, 22 Jan 2022 16:38:29 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
 <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org>
In-Reply-To: <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Sun, 23 Jan 2022 08:38:17 +0800
Message-ID: <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com>
Subject: Re: Some sub-commands can't be completed by TAB key.
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 10:47 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 22.01.22 um 09:42 schrieb Hongyi Zhao:
> > I find that there are some  sub-commands can't be completed by TAB key:
> >
> > $ git <TAB>
> > add               cherry-pick       fetch             latexdiff
> > [...]
> > As you can see, there are some sub-commands which are not listed in
> > the above list, for example, the following ones:
> >
> > $ git ls-remote
> > $ git ls-files
> >
> > Any hints for this problem?
>
> Tab completion is only available for user-facing sub-commands
> ("porcelain"), but not for sub-commands intended for scripting
> ("plumbing"). The intent is to make tab completion more efficient during
> day-to-day work on the command line. For example,

But there are so many git sub-commands, so if the plumbing feature is
supported, it will facilitate user to check the availability of some
sub-commands.

>    $ git l<TAB>
>
> arrives at
>
>    $ git log <cursor here>

I see the following:

$ git l<TAB>
latexdiff   log

> instead of
>
>    log     ls-files     ls-remote     ls-tree
>    $ git l<cursor here>
>
> -- Hannes
