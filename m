Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF37C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BF62070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhA0D67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbhA0Byb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 20:54:31 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E19C061574
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:53:51 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id l11so402631qvt.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 17:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxkjnwYWXlvkrclllUpWHWWxvI1mtJa4jtGVKNL6JFI=;
        b=JfSeqQFtHa8BcAaX611ywQMPA8bpH4CA396FQhwws6i/lhbocwf+Qk80NouCvrvXMV
         ikZgSiJ/TioWctt1o7xu2nWuKb7RwAnlYhHDQBvDcs5xzlIfYb58sPxDmhyXGSApzD+e
         VG5STxflhWm69SGX8m2DjCzTj4W63xw7rWQULZdFOu9rNWrvI5Rm8JoCBBa/BYVcHJiE
         X04sg3jIwz/DNgecLMz8C8TORTUfzo5SvtJi63BO69i3X4eq9S8OMNQZR8ry0AkYZ9xN
         VgJaF3znUnUw17ic2i7w68fwaf2RAF1lvUFBiHNSOfVZmnJWDa2Dr3ieTeV4GFRczUbO
         Vyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxkjnwYWXlvkrclllUpWHWWxvI1mtJa4jtGVKNL6JFI=;
        b=dYJfq35R8nJshmL5kh2mtD0CyQiUkafyj7tGnXBfdx2d5+AtFk5eXbXaijQxuuOOuP
         NbW0zYL+uxaomJnYGh13TjB+y+WRksTZD5ZFiOtRaOs6ncxse2eYgszOXjPLdkhoCmr3
         +rnYrXHMbaxgt66GXFQSO74sQxuMgMsBazqtAoA7tRT8gCzKVHujFzW1yjOw8NlzkywW
         hbuiS366tFmdGYN57T5rJhC6KoilX6DwWiVNoPa4LroZEG2JDOImTWTyyT0hhv4MrBXC
         GftqXJhtpE5hmwXEYfHyq2Td6JYUg3SmpQumAGgf7tUfBFC8U5jdO/A0jBSD2sB4AW42
         C9ag==
X-Gm-Message-State: AOAM532wAbh2dG1qtOjgjWFnhG5xHw5aLuQowsTA8+9QkWdUMh+QV8Dp
        dvRNes0KJMIgUyY5ECDzmHI3bCySkQd5VB8ic/Q=
X-Google-Smtp-Source: ABdhPJxOhVm8YPNypUWj6/uJ4w6xcZx4x6IwAZk1JaDRSkVBOZauXoKMB/H6VpGn4qvCHnZnIjyR9bApYBGW0HU3tf8=
X-Received: by 2002:a05:6214:845:: with SMTP id dg5mr8555097qvb.32.1611712430492;
 Tue, 26 Jan 2021 17:53:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.848.git.1611676886.gitgitgadget@gmail.com> <09b32829e4ff2384cb35afaf1a34385e25bac8d8.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <09b32829e4ff2384cb35afaf1a34385e25bac8d8.1611676886.git.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 26 Jan 2021 17:53:39 -0800
Message-ID: <CAPx1GvfQ4K+2mt0BC-1o7e0omHAvC6XhmpOuGa41v-b850w14w@mail.gmail.com>
Subject: Re: [PATCH 01/17] commit-graph: anonymize data in chunk_write_fn
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: this is purely style, and minor, but I'll ask...

On Tue, Jan 26, 2021 at 8:08 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>  static int write_graph_chunk_fanout(struct hashfile *f,
> -                                   struct write_commit_graph_context *ctx)
> +                                   void *data)
>  {
> +       struct write_commit_graph_context *ctx =
> +               (struct write_commit_graph_context *)data;

Why bother with the cast on the last line here?  In C,
conversion from `void *` to `struct whatever *` is fine.

(the change itself looks fine, btw)

Chris
