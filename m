Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC02C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 03:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiBWDOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 22:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiBWDOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 22:14:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C4D11C04
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 19:13:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a23so48781579eju.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 19:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3NkbDpL5/7IaKdDJnBniemFFvjxivnjf98Vqm+rs60=;
        b=NNTZ0Ofg1OaXyiGG+1R3fpfNlRBv1wmMONfkepjDiFdqhb7MYxPXnlcfKDG9o3E1+t
         3Lw5pw0K+nKR9yl+YeVawgwfvg9V2HqvQ06JTLMT3EYtEE7mip+GqqaQLOWcYTzrocpR
         0/7/ff0SnkUompLgZZMnYXa83jPs+GyCIms/PtaGYgj0PUQrbL41OK8Mqgu2TphW2OPx
         Gyz9bvcpXbjw/2JkGnyyiBygCvQBL4nm8VCcZnVCAVBhSm7Jbjcg4zq0+kf+/XMbhe7K
         z3g8DykCyrq4mfALmffc1A3IRM9xoI6P7+Mb2a3thHbEOHleqnm3CGGUNcP0w7fjCK3A
         h5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3NkbDpL5/7IaKdDJnBniemFFvjxivnjf98Vqm+rs60=;
        b=vcbkffzV1flRw21BIn0ZBW+hujXBFYjvKNpTp0rclq3zHGX1gicbKQ6rwlxZjT7pua
         z1bjwJWO1KuvR6j0PDIy1F4wRkANfGI+BjORtKY6PCEB9qSbUEdN1fA2Z76+FUjfwmDx
         AmGWD74Nh7OvXL8N4NNhAE5Lcr4VgIaz/kZhVSnxvtk5+TJ1QJ3UWOp+fy8U09OWB9Ls
         7Arf4/X5MOQhtqoJrl4RcOdGup55aLH9Tr+Tg2SClfgKDno5cEkDZ5EX4YjxQ5S8HhUh
         FuuBPQhMo8CPGw/whRIH5py5xOevuwv/0XUYbW065oOf1HHLExDXi/Shq/plHG6dC6NE
         S3Ow==
X-Gm-Message-State: AOAM530sHNPDL95vto4xQcZlPCTarRMUDZj2vUTqv3p+ZNpJNIpfSd4X
        2RZXjhhUVqc03FV+EAqFRiHTCTruwISVH2C1DmA=
X-Google-Smtp-Source: ABdhPJzWh50LaoN9bT/1SOYbOKlYnmit3vsMeAINJtu6BAbFQZXcGgfrb3WddTjUCeOcVD/Tcs0MIRSZxDhLYPIIfLo=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr22145028eje.328.1645586028048; Tue, 22
 Feb 2022 19:13:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2202221751550.11118@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2202221751550.11118@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 19:13:36 -0800
Message-ID: <CABPp-BG7id0GfpDee_7ETZ_94BC_i-e_=-u=PrYJeD7d4sVbiw@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 8:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 21 Feb 2022, Johannes Schindelin wrote:
>
> > [...] since `merge-tree` is a low-level tool meant to be called by
> > programs rather than humans, we need to make sure that those messages
> > remain machine-parseable, even if they contain file names.
> >
> > [...]
> >
> > Do you think we can switch to `sq_quote_buf_pretty()` for these messages?
>
> Or maybe much better: use NUL to separate those messages if `-z` is passed
> to `merge-tree`? That would address the issue in one elegant diff.
>
> What do you think?

Separating the combination of messages for a single target path from
the combination of messages for a different target path by a NUL
character may make sense.  Would we also want the messages for a path
to be prepended by the pathname and a NUL character, in this case, to
make it easier to determine which path the group of messages are for?

I'm not sure if that does exactly what you are asking, though.

The thing that is stored (in opt->priv->output) is a strbuf per path,
not an array of strbufs per path.  So, if we have a rename/delete and
a rename/add and a mode conflict for the same "path" (A->B on one
side, other side deletes A and adds a symlink B, resulting in three
messages for path "B" that are all appended into a single strbuf),
then we'll have a single "message" which has three newlines.  We can
add a NUL character at the end of that, but not between the messages
without restructuring things a bit.

There's also at least one example, with submodules, where there are
two path_msg() calls for the same individual conflict in order to
split conflict info from resolution advice, and those really shouldn't
be thought of as messages for different conflicts.  (I'm starting to
wonder if the resolution advice should just be tossed; I kept it
because merge-recursive had it, but it might not make sense with
merge-ort being used by server side merges.  But even if we toss that
one, I'm not sure I want to commit to one path_msg() call per "logical
conflict".)

But...maybe this would be good enough for some kind of use you have?
Because if you only want to care about "simple" cases, you could
potentially define those as ones with only one newline  in them.
