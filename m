Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0175C636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 13:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F8E610C7
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 13:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhGRNSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhGRNSq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 09:18:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174FC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 06:15:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id go30so23399590ejc.8
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mWEuSHj4iPNMFKXkAyfCBgCbBHQuU8APspkIjVvE8U=;
        b=ADjHeB8pWjPzSsSJamp/PiQLT717M4nf4nmIRkNSnDvRust+CJGrzSajzYScqNNIoW
         Frc0DXRQrP3luWgJKiEpsLvciiTKplphROdnNKP0JQ2iI0R6LpDCtXRqkqHAQ75EY+8U
         V3i6QG0CakxOjsn8AP4TOutKfd4oq3H6i8unlzRNFmhTQc+j7E2Vw95hZ07Q2TRhGGit
         n6ZC8U21Ehz2h3S0Qgp2EhRGurvngczZnFaxC7co1G9i/t/7sxCmzFouWKZnEsEP4RYS
         e//pXr+MGimpzL2Mg0B6Qc05/CIUOUTDZK16tAdFD+NesWvEGFLGtlBaF53BXzhyCNR0
         JBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mWEuSHj4iPNMFKXkAyfCBgCbBHQuU8APspkIjVvE8U=;
        b=FCzD0ICf8pFWA4MEIfm+Tm4km1AMBYUo0jncpwnMQyjDeRoTIh76hu+wDOEJbyB9It
         d1OgzIqHe4rYNfG3Vk7FYKBueHbEdinEI2xFeU/8EOF8WGN/QP9MmB/1W+sXviHI/XWw
         toACgdg3VMkk41+hS6rQC/aGuhqZBZod2TZPZhSXIW+QFnyC2JiePkb5s7gqPuXC3Lbn
         H9J+zWN1rr0DlK2256QJjJrPvb7xyHZkcmQ+KMo0hqb13WN+A2xRLnKTcUUqyesDm4+C
         boCmyaZZkxQiGWHHW4atxOuDWXTjNxXcGwSLkiKBqsj+vlHjojb/esXxYeO/07fUYu0H
         kxwg==
X-Gm-Message-State: AOAM530jJc6UOzMQHNguEpBSjQe0I11FZYcwpsfbBxWS3Kzyi51ZIvJH
        JpBzE53BIFe8aYvDY1XvDvCnKTh6tRB8VMy1Xr4=
X-Google-Smtp-Source: ABdhPJxYS9jCZLMZ6BhmfK/JQYUqhOS+z7IKotoFpwERGV5dOKJsNn9LALCDSp2INTNzhI2XNLX8RMj7QLd70vrzZvQ=
X-Received: by 2002:a17:906:1355:: with SMTP id x21mr17789635ejb.216.1626614147261;
 Sun, 18 Jul 2021 06:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
In-Reply-To: <ED260A04-153A-46D5-8A84-CF517085DEC9@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Jul 2021 15:15:35 +0200
Message-ID: <CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com>
Subject: Re: My Git Dev Blog - Week 9
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 1:59 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Here's my latest blog post:
> https://atharvaraykar.me/gitnotes/week9

Great!

> A part that may be interesting to list readers:
>
> - In one section of the blog, I describe the problem of the git
>   submodule configuration not updating properly, when I launch
>   a subprocess that first initialises the submodule. I will
>   appreciate it if someone has a possible explanation for the
>   issue I faced at:
>   https://atharvaraykar.me/gitnotes/week9#launching-the-init-part-as-a-subprocess

My wild guess about why is_submodule_active() might not be working as
expected is that submodule_from_path() uses the submodule cache which
might not be properly updated when a submodule is initialized by a
subprocess.

> The rest of the post talks about my project progress so far, and how I
> avoided the above problem entirely for now by taking a different approach.

Nice that you found a possible better way!
