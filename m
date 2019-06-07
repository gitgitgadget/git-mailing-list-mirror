Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DE91F462
	for <e@80x24.org>; Fri,  7 Jun 2019 17:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfFGRdZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 13:33:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37764 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbfFGRdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 13:33:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so1633362vsq.4
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NXdDkv6eFbPt6BEOz739AI9cO/S4JIT1GEu1EqR/cz8=;
        b=VniKoz1JbSWt70ySRcgdMgmo+0aOJrTmF/1qynGUfCBbI4J4qPl2Ax+1B1MT8HvFQ1
         WZmCOa34rFXdGDlbdI+oFoQA5Or8bfZI0DnRr8vPpxLMkyqnGHxifWAPoHnfNKUM+D0d
         47SNiDWeg3PI8IszdvltAyI3iwHF7z1OHMjjpD4uhteJGPrhymDRUP3kz6DiLrh1G9uB
         WaXQY4ejU/kw2ePgPjuVEI5WIrHgQYTXIB8b4RANRpr+EORfRgyH5ts9sPTpr8P4L3E1
         /sSl9jec0/zLKgxpbrgd3el3wXbolpHAq2tUzOFmixMBD266CcZmDIMGHNgmWrLRnXzz
         BXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NXdDkv6eFbPt6BEOz739AI9cO/S4JIT1GEu1EqR/cz8=;
        b=UJdR95UKQhGzfm7x1BwIzmxDjytqTwy1g4QBmUZdexr1S1QBcF6J7jas++atzdIU0a
         VoIVl4lDODMHYY1pDxqRxhAF/YLdlXNZy5CovEJwcH0pVdKdMlxYAK4ThuKvIu8qL3EA
         nh1yRKoJz9frLyq3MvyjISuaUqqxpQ1n8NvzagDXU/gyJwkNyzwZw+Z3HqA+CzmIK9f0
         gCYJWCIMqLZ/rC58h/El358Ie3DxAaZZBs3BqX73OoIDQJHo+wS+2njQExEv4hdphKyZ
         sK7h14g72WgzrqWHOoTGFMV54KkYIuc7OGKYuoXJn/CQFP0bpQVAkrHn3WDMfrOOO4Ee
         rgcw==
X-Gm-Message-State: APjAAAXzUcP/y96UqjAppCDao77a8w1MTeVG5QVnIOcWt99/MoRmNj9M
        4rzG1tbCbuMYOVKc9VNJ5hHQmYdF2eA6N94dJcs=
X-Google-Smtp-Source: APXvYqzfTYvJRMkn646G5flNKMHbcdK2lmfsMRYhKViUeLA5hfW23VlxhiG+CdSteMU+6SqaEkziwx1lIA1o2SluHro=
X-Received: by 2002:a67:ea51:: with SMTP id r17mr2692462vso.12.1559928803606;
 Fri, 07 Jun 2019 10:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com> <20190607100252.GA24208@szeder.dev>
In-Reply-To: <20190607100252.GA24208@szeder.dev>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 7 Jun 2019 12:33:12 -0500
Message-ID: <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com>
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 7, 2019 at 5:02 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Fri, Jun 07, 2019 at 04:30:34PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > "git <cmd> --git-completion-helper" could fail if the command checks fo=
r
> > a repo before parse_options(). If the result is cached, later on when
> > the user moves to a worktree with repo, tab completion will still fail.
> >
> > Avoid this by detecting errors and not cache the completion output. We
> > can try again and hopefully succeed next time (e.g. when a repo is
> > found).
> >
> > Of course if --git-completion-helper fails permanently because of other
> > reasons (*), this will slow down completion. But I don't see any better
> > option to handle that case.
>
> I think a permanently failing 'git cmd --git-completion-helper'
> shouldn't really happen, unless there is a bug in the completion
> script or the git installation or similar exceptional situation.  And
> then that issue should be fixed, but I don't think we should worry
> about an extra subshell and git process in those situations.

Indeed. In think there's only sane option to make this work in all
situation; a reorganization.

Something like this should work:

struct command checkout_command =3D {
.name =3D "checkout",
.function =3D cmd_checkout,
.run_options =3D RUN_SETUP | NEED_WORK_TREE,
.help =3D N_("Switch branches or restore working tree files"),
.options =3D {
OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
...
},
}

This way we could run parse_options_show_gitcomp() from git.c and not
worry about whatever cmd_checkout() needs.

This has the added advantage that it gathers information about this
command that is stray in multiple sources (git.c, command-list.h), and
it makes builtin.h cleaner too.

Plus, we could rework the way -h works too.

--=20
Felipe Contreras
