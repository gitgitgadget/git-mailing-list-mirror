Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6884A20248
	for <e@80x24.org>; Thu, 14 Mar 2019 03:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCND3h (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 23:29:37 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54127 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfCND3h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 23:29:37 -0400
Received: by mail-it1-f193.google.com with SMTP id x189so2408133itd.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfqgEH/j1qZ+hlC8qHhrd3SYh6fxjvs4i1sf7oxiL84=;
        b=pwsRK6mWjkwRygVwR4rK75Y2OkDvppvi/h1WEmM/wN3j4mqQzIGIHkPVV5YGV2TRIY
         Y8n2ADZJTnI8ig5SrkwP5jZy15TQB+2yh+yu9Fz3l0S8qgm4v9amIlypB508OH91pmN/
         W2oyKmTtE7IOJ0a3zN55f91jicIzMHk67PD02pcBMzBDjIucNejT5mmTYqaG0zuNIAbf
         C7DD4EUGW2BcKRRtbmxoqdFIlCkrBySUoUYKo0lrVs6e+2F9cNQaJv2eNgRVCItkLXJs
         2/jrHMzLJNq4ffpJYSbO4i3HxVPQ1stLoibK+JZT6dC1CIfZRKmTCAY4cLyw/l8scXWf
         4kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfqgEH/j1qZ+hlC8qHhrd3SYh6fxjvs4i1sf7oxiL84=;
        b=tUiDP+GNvPEAPo7PGzm88naXq3tJSH11KqcSuM4TqhGRwdP5EV5JCNwRkv618jciAY
         WEcVx4u2WhyFtigbKgNSu1LeGrKUDPPIdee7fGIQ4+eBsOCGIPlDJ0hjQA7HzzfLORQO
         g1i99gwhvodxvYTyPV0HZbyb7Vv+4qYzi1+RUWdhgV2DfCJBmEXLB7IwFBFLp/qpQNyh
         XdAI6GikMoZnjxLPGY53aOZrdHyQPBDP2bG5RvulC7mFIHH0WfQrZDnCLrA9hfhAOuoP
         tpN+Gj1uuynZEvl4sBrir9mu7DdaECgX3M1R4rWhvdOKT+NOQl3yeNPz0+Fp3QlBpqrW
         Kk5A==
X-Gm-Message-State: APjAAAU18uFafawAT4FlarRgMjXklKKjUjwxUs3P2rpLwdS8UCyMcOWw
        HdLcs0k3cB9ODFs/EiVKO5/Qucuz9d+G0cNtDKE=
X-Google-Smtp-Source: APXvYqyK4QV0LzQVY3CACL+vRIF3zgFeTfDpv+tSKIEFmrNJESqysiGIYYFzxkfcyX1tdHNLoOuRkWc7qyDIGcGGP6s=
X-Received: by 2002:a24:7542:: with SMTP id y63mr835744itc.70.1552534175826;
 Wed, 13 Mar 2019 20:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
In-Reply-To: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 10:29:09 +0700
Message-ID: <CACsJy8CuNQR7javX7KTC7txivH1OkejCbVJdHGD+XJ-0ftT3ag@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > +-m::
> > +--merge::
> > +     If you have local modifications to one or more files that are
> > +     different between the current branch and the branch to which
> > +     you are switching, the command refuses to switch branches in
> > +     order to preserve your modifications in context.  However,
> > +     with this option, a three-way merge between the current
> > +     branch, your working tree contents, and the new branch is
> > +     done, and you will be on the new branch.
>
> I was wondering what people felt about making this the default for the
> new command. If I'm carrying changes over to the new branch then I want
> them to be merged in, it's annoying to have them carried over most of
> the time but then sometimes have the checkout fail without specifying
> --merge.

If my worktree has local changes and I accidentally switch to a
different branch, I could switch back without losing any local changes
and the tree I have is exactly what I had before the switch. Is this
still true if -m is made default?

I think sometimes a 3-way merge creates marker conflicts in file, and
this does not look easy to reverse when switching back. If it's true
and we can detect it, we can still abort this case (i.e. requiring -m
to continue) while allowing succesful 3-way merges by default. But are
successful 3-way merges reversible?
-- 
Duy
