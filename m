Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13817C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 06:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7484204EF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 06:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oB0ZdxVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgE2GzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 02:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2GzO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 02:55:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C8BC03E969
        for <git@vger.kernel.org>; Thu, 28 May 2020 23:55:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w90so1132460qtd.8
        for <git@vger.kernel.org>; Thu, 28 May 2020 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frmdtX0t2mD0f+5AHRiL+xZrC8hA5opRDWu4t3vRxzY=;
        b=oB0ZdxVt8x5qXE391U3g1UpS6qNIj0AJ2fehby9/4K7iEVLwWGUWGJ6HmaK7pfRIvg
         WasIkyZsPVKouJZIZJEA2vl1t6a0QNr6qE+PFZzjJDEsIZGsRH225krOTjuykvsZlfsZ
         kgThlKNE5c4V5LATt4AHtXUKzq5CflSUN+bSv99S1Cb2sxxP6n+RSosvfqj2FFo+lfqb
         ITk07MHOHTetZD/855v+OD8TOr28751osCVdsBPeM6uV90hCB3K/RERFDdfUyb6oGz+v
         itR++Kj6cWzj41Ch8TUzexi3B1YNsYI1NBsTfVShuQj26SVerLIY9rAK4+wFedpsVYqx
         V5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frmdtX0t2mD0f+5AHRiL+xZrC8hA5opRDWu4t3vRxzY=;
        b=qGHu6wUignsIEev7SZ+u08puYswfIsQ1U+eqJrp0E/UE2Y7bH7KJ3MWg24DTQqhPmY
         VLhUPPinLe1PNUWSh7p+Eu+h2MzS22uePDFPkwuqixDsH62Otj2IG1wgNXMdU+o56utv
         kD8BX1YyOT8hew4dXEWQaKKvD325FmNycpPi6hRL1LxZVqQbaqje+gBK+m19n9KKabpX
         HkGd814Du5CQzt4TCiqVyg6G37OlR5OUOMAcMf0kSnZa3MsZgvguVN2BbwL+PrRQWfLG
         LQZiyH7cwqYHTrgcNXBI1xchBMeS6AXIaN2KEOoAk44fQKL/baR5Xc7yQvwDk/X1Qtm7
         Svuw==
X-Gm-Message-State: AOAM5328gRZsRqQGfSGug+1xOX31/6bMEJf0K8cEZAo+edidDdJLjTgJ
        irPBdI38lfnbilIEkJSIKb0WCYrc+DCilHEwrXKq4A==
X-Google-Smtp-Source: ABdhPJywd4H2N+dG8c1LZeCVk3M2xR1n+MejWi5oP1V176rYxFXHTkzK+tXOt1gvFRK60hu2vcUW+IEBzN1Rb9Sp9RQ=
X-Received: by 2002:ac8:185d:: with SMTP id n29mr7292934qtk.19.1590735313284;
 Thu, 28 May 2020 23:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com> <20200529000432.146618-1-delphij@google.com>
 <20200529010119.GE114915@google.com>
In-Reply-To: <20200529010119.GE114915@google.com>
From:   Xin Li <delphij@google.com>
Date:   Thu, 28 May 2020 23:54:59 -0700
Message-ID: <CAOhzduh4V4LKgzksTkSdEDrgsv59jTpfYDBTUzZvRxZOaqhhmg@mail.gmail.com>
Subject: Re: [PATCH v4] fetch: allow adding a filter after initial clone.
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ian Kasprzak <iankaz@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regarding t/t2404-worktree-config.sh:

On Thu, May 28, 2020 at 6:01 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Xin Li wrote:
>
> > diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
> > index 286121d8de..9536d10919 100755
> > --- a/t/t2404-worktree-config.sh
> > +++ b/t/t2404-worktree-config.sh
> > @@ -23,8 +23,10 @@ test_expect_success 'config --worktree without extension' '
> >  '
> >
> >  test_expect_success 'enable worktreeConfig extension' '
> > +     git config core.repositoryformatversion 1 &&
> >       git config extensions.worktreeConfig true &&
>
> Yes, makes sense.  Does this patch need it, or could this go in a
> separate patch?

Yes, this patch needs setting repositoryformatversion to 1 as we would
no longer recognize extensions.worktreeConfig=true on version 0
repositories.

> > -     test_cmp_config true extensions.worktreeConfig
> > +     test_cmp_config true extensions.worktreeConfig &&
> > +     test_cmp_config 1 core.repositoryformatversion
>
> This (both the existing code and the modified version) is strange: we
> just set the config, so why are we checking it?

The check was mainly to match the existing pattern (which sets
extensions.worktreeConfig and immediately asserts that they were set).
These assertions are not strictly necessary but are harmless, so I
don't feel strongly about keeping or removing them.
