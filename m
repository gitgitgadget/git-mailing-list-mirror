Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7271C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 06:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7338264E3E
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 06:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBJGWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 01:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhBJGWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 01:22:04 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E2C061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 22:12:19 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d7so824377otq.6
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 22:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOeLg+yaGVzSCNVhkO1zpqxFbk/AKXVZBhvKzUyS2PM=;
        b=KAQdnQNLE7ZjYenktiC5cSlogjJVTrOhFRMipq1RRJGRJvCMN2Rnqt5JPalOLC66aX
         fkzeZ9r8Yx7Bvb5ioUfuWZMbX1d2K/dWSAHyLlEdNZvsV/hTVtVbYdGAl90agK/Bb9KW
         qYD6aNWmKOb3U3DcAPM1VhaqtNJ7YmifSp6+F8WmFI5G3J9FAa3TWkf0G3XLW8L5jPlo
         2YtSG8DF4cmVkdou2nQ3HNNvGBLOrmh3vGZsOYswG+/KnH6ti35buDQX1EMDP7XDQe1+
         lvPc230pvB763KJezMrWZgiXaCHr7kHQetW7NpZuFlhSKXVPTOmWNUgg20KGj4ASngR4
         xplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOeLg+yaGVzSCNVhkO1zpqxFbk/AKXVZBhvKzUyS2PM=;
        b=LweeOEcQY8W+2cotzy3iiO9XsGkcUKF3St1HTk/VfnCw0zYPXtTmwqRA1qdZHo1CWl
         TzYVzOQyUjgeI5wpjJDgViYv7eQPmtrDKzoCeiaD9l5fPjcnGC8f1F5X2kNfMq5+AdGD
         WAIrhlndFHfoBDIYKUeBZeFrEOm1YSlwZ+S+qCSq2SaIKqv9a1zcOKYoiFvegYhzk6/L
         uq8y1/JUNXGG2AJHeK7XOE9tYCguAB3tnQtVu4h8UZL4kEnwrGo1ZkZbLnSf2szDadNU
         LNNkzXrrEZeGmCIfY2gPGTlha7z6Z+P71wY2AbVOq8gmWBwCeFLqwpp21bmg14UtikRk
         +OYw==
X-Gm-Message-State: AOAM530f/bj0aI625d0LdKLA46ZMQPEubLCa9kjKdgeYSDv/rw8E9U1b
        TQzwUm9Y/LS8Av1dmpj2LAgnyEWIAIzd2I6bSbI=
X-Google-Smtp-Source: ABdhPJzANxnI+baAcef+HTfGFvhSOdGn3eOda2sY9ocw5T9s/DvsSqKHe2l5XbcYYQsBCM/4nBV9u+KphTRjuMrkSnI=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr1020508otn.162.1612937539024;
 Tue, 09 Feb 2021 22:12:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1599758167.git.matheus.bernardino@usp.br>
 <5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br>
 <xmqqtuqkygfb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtuqkygfb.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 22:12:08 -0800
Message-ID: <CABPp-BFMk7XX-qkXC_C6vh_x7OPUS+Dfu-6SFWvm2WVA14zLSg@mail.gmail.com>
Subject: Re: [PATCH v7] grep: honor sparse-checkout on working tree searches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > This new version includes only the bug fix for the working tree grep, as
> > discussed in [1]. I think there are a couple other patches that could be
> > extracted from the previous v6 [2] and sent as standalone topics,
> > without the risk of conflicting with the sparse-index work. E.g. the
> > unification of the git-grep.txt and config/grep.txt doc files. I'll look
> > into that tomorrow.
>
> As mt/rm-sparse-checkout depends on the v6 that you are ejecting
> with this patch, I'll stop merging that topic to 'seen' for now.
>
> Thanks for keeping an eye on this one.

Yeah, Matheus and I have been talking about both topics off-list a
bit; I hadn't yet responded to his final revision of a newer
mt/rm-sparse-checkout but he has a good replacement for that topic now
that he'll send to the list soon.

Anyway, for the patch submitted here you can add a

Reviewed-by: Elijah Newren <newren@gmail.com>
