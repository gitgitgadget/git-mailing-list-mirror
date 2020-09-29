Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02389C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74F12083B
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPKJUqH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgI2Twb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgI2Twb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 15:52:31 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FEC061755
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 12:52:31 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n193so2738186vkf.12
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqK0UHqW8S6ctxf+BKrYJL9UcTpDDPHDJ7H5sSZ5AKQ=;
        b=GPKJUqH5E2DgOkb6oq0hexE6ZknYdZKSci0P+cLtLz143oCm7oPjF8pCjfo/RnCenw
         SF54LQeJodaaOIorOyuee/9xZDQavUGQ+l8iSKcCnVjfZoGyE5T+ik6xuWV4a1GbvwoQ
         U9PWESA2qVmm+1O2Gq1E3lskVGeXxL2ibZRjn4NB5FdnjCuk62hvyJjPJZLRLyU6VHGP
         ckwAKUCwBZSNJRAkS/NQwYCDBc9rLg9WNwDni9J0hFOq0pYzhG3E5HkKt+ooF3QiFXCH
         XKNekxQZinr+0pJrfXpIUkEWu6VP0oxtmLcVG64O6IfANZUor6669OT1ntoDicwAJkrF
         yzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqK0UHqW8S6ctxf+BKrYJL9UcTpDDPHDJ7H5sSZ5AKQ=;
        b=fea9Pbm6cER119mA0zaMPo68iL1ApYaMw/8yAiYffeAXkmKSzwC2Zhz4sXQPNSKLDn
         mYCL2fSpFlvHuENGxRczok+CgwL81wZBi6620m1Wthu7DstDq6yXELcr4mEgpHwOE8YV
         umrbHEFqBwRSvnbb1oTXEQrPgN018zWS4AZkeN6FCFjlvFxtTj3hyFxbtpclsqaIwIIA
         U6xiIm8WDunkG6jgBAnXNI2yfsPZEOyxt7IH2mX0N8kcqMgV1LIit4Rh25J6deqYE46l
         Xxgcc6jrvlizdfIVF6NMiIlZ/gqD1fXpjbuObvOaLKsVFzH/c+rXhjP4q4KZfaPBBnS4
         ViyQ==
X-Gm-Message-State: AOAM531UEsY5ePB/PVRQkbzoXbpYOrW3tkmgaTlJrOuf5B9vNZpgipuC
        vKR8/7o8c/ZgNlOA9swFhu26dT5KnQ1m48n0M3ySMdJSJlE=
X-Google-Smtp-Source: ABdhPJx7fZMed4IZQllz/gjwlT8da50jYQ0U9fCRFKjwP68RcggdL8NdgrI7l31SNcn0RCDydZA8koKB8OGqG4BuVpY=
X-Received: by 2002:a1f:d986:: with SMTP id q128mr4120709vkg.7.1601409150395;
 Tue, 29 Sep 2020 12:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600814153.git.matheus.bernardino@usp.br> <991169488b17e492c6d2c2f212267a66693aa7ec.1600814153.git.matheus.bernardino@usp.br>
In-Reply-To: <991169488b17e492c6d2c2f212267a66693aa7ec.1600814153.git.matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 29 Sep 2020 21:52:19 +0200
Message-ID: <CAN0heSoJvkZ+gvQwZMPW5Q0HqB0mOUnVqXiOqnPk48cDxMzAqw@mail.gmail.com>
Subject: Re: [PATCH v2 11/19] parallel-checkout: make it truly parallel
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Wed, 23 Sep 2020 at 00:53, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> --- a/Documentation/config/checkout.txt
> +++ b/Documentation/config/checkout.txt
> @@ -16,3 +16,24 @@ will checkout the '<something>' branch on another remote,
>  and by linkgit:git-worktree[1] when 'git worktree add' refers to a
>  remote branch. This setting might be used for other checkout-like
>  commands or functionality in the future.
> +
> +checkout.workers::
> +       The number of parallel workers to use when updating the working tree.
> +       The default is one, i.e. sequential execution. If set to a value less
> +       than one, Git will use as many workers as the number of logical cores
> +       available. This setting and checkout.thresholdForParallelism affect all

If you end up rerolling this patch series for other reasons, you might
want to consider using `backticks` around
`checkout.thresholdForParallelism` so that it gets typeset as monospace.

> +       commands that perform checkout. E.g. checkout, switch, clone, reset,
> +       sparse-checkout, read-tree, etc.

Similarly here. Or perhaps go for "linkgit:git-checkout[1],
linkgit:git-switch[1]" etc.

BTW, as far as ".e.g.," goes, this list looks quite long. :) I almost
get the feeling you've made it fairly exhaustive and added the "e.g.,"
more as future proofing than anything else. I don't think anyone would
complain if you left out, say, the plumbing `git read-tree` from the list.

> +Note: parallel checkout usually delivers better performance for repositories
> +located on SSDs or over NFS. For repositories on spinning disks and/or machines
> +with a small number of cores, the default sequential checkout often performs
> +better. The size and compression level of a repository might also influence how
> +well the parallel version performs.
> +
> +checkout.thresholdForParallelism::

Sorry if this has already been discussed, but this "For" looks somewhat
odd. Basically every config knob is "somethingForSomething". ;-) Could
this be `checkout.parallelismThreshold`?


> +       When running parallel checkout with a small number of files, the cost
> +       of subprocess spawning and inter-process communication might outweigh
> +       the parallelization gains. This setting allows to define the minimum
> +       number of files for which parallel checkout should be attempted. The
> +       default is 100.

Martin
