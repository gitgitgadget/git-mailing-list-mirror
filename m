Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D2FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74FC60ED5
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 15:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhHPPHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhHPPHY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 11:07:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62416C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:06:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g13so35020493lfj.12
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfoZcLzWFLTknazjGArhTimYunTlae9BA3aVocUHN/c=;
        b=l5hsCWiMJNYe0h1sUtjCSU+GL38laYSbtEDXALysf8f8sSHyWAZxpyK/pC0SAzjX76
         vC9qwhPPLJZEMmfI+XFmBg/qCQ3DCiffvDXfYFRd1iDrPzMdai5JHx7/rS4x//ehhohx
         BiVHN8vg2qfkhTlQvcqB+jkfSLb1jTJBSTtJ3kAITwgXy0NuVkU74Z8od9s1ocKqJHP3
         gFm9xlpISHlEOBQtGplQJi5QjOWmqjoqSXLQid62VIx+Ik7zMO6wH3uwJzVHj9HCrhN3
         C7oXZfsv3EYT6e7v3CzMCMGB9pNdR7K5Bq8UA9Xzs2PYVXvOH5UkrlxprifuiecCHAl9
         b4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfoZcLzWFLTknazjGArhTimYunTlae9BA3aVocUHN/c=;
        b=CQ8/SNVthvo7nt1RoniGu583BV27r8gUFDFl52t3BdGhZQtGRrnyeOWWwCh+Xls9If
         VYOJc6KSSOQmpQq81izt1ouFlL2PKUdZ9kljFOzN/FwQKFF1sYAmI+Pzeg4lV2ExjnhT
         r4GUszVsrn1OWvJVn4PJHZGznHd8ddmE4IlNZSVkVTezfzPvYm3KBw7+dAoz6QBZ14xh
         kY2dihFCFY5+0Erke+h8nPutGX08yeH6TSIHQi7F4Y4qnO0woCB6Se/6SXmBvIwureom
         2EEtSF/Yd1WqLEkQ+1kysZ6gFp7EuX7Oe9QvOe1ifzqqAcjhsjUzji5qdw5omugytA/l
         9pgA==
X-Gm-Message-State: AOAM532y4OlqpmzPf6u5vJeZwN1u2ksmpvdEjFmVZ+mSiT8/vMbkL1Qy
        OwN6I2pDKi+lPPn7Hz9mHqhCWd5Snurigc+iuLsRDQ==
X-Google-Smtp-Source: ABdhPJyI/uFVLp7jO/50OeVpPSFiA+uyy/rYGEM5oVQ8RlzFNtKk9X0AGjz/p4suR8XyZUByoZlhm74P9gjAVrRB5yg=
X-Received: by 2002:a05:6512:3f0:: with SMTP id n16mr6081319lfq.502.1629126410774;
 Mon, 16 Aug 2021 08:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1628888668.git.jonathantanmy@google.com> <aa3f1f3c8908bd497ef506db466fc123eaccf21d.1628888668.git.jonathantanmy@google.com>
In-Reply-To: <aa3f1f3c8908bd497ef506db466fc123eaccf21d.1628888668.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Aug 2021 12:06:39 -0300
Message-ID: <CAHd-oW4BruuST61WqguX8Ror0sMmcaErXykv4B5Qb2tv8rszcw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] grep: typesafe versions of grep_source_init
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> diff --git a/grep.c b/grep.c
> index 424a39591b..8a8105c2eb 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1840,28 +1850,28 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
>         return r;
>  }
>
> -void grep_source_init(struct grep_source *gs, enum grep_source_type type,
> -                     const char *name, const char *path,
> -                     const void *identifier)
> +void grep_source_init_file(struct grep_source *gs, const char *name,
> +                          const char *path)
>  {
> -       gs->type = type;
> +       gs->type = GREP_SOURCE_FILE;
>         gs->name = xstrdup_or_null(name);
>         gs->path = xstrdup_or_null(path);
>         gs->buf = NULL;
>         gs->size = 0;
>         gs->driver = NULL;
> +       gs->identifier = xstrdup(path);

At first, it seemed a bit odd to me that we use
`xstrdup_or_null(path)` first but `xtsrdup(path)` later. But, I saw
that we already did this before this patch, and that the second call
is fine as `path` is required to be non-NULL in this case (i.e.
GREP_SOURCE_FILE), because we need it for grep_source_load_file()
later. (Also, the only caller is correctly passing a non-NULL buffer,
so all is good.)
