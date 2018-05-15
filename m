Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6C11F406
	for <e@80x24.org>; Tue, 15 May 2018 13:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeEONOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 09:14:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38990 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeEONOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 09:14:06 -0400
Received: by mail-oi0-f68.google.com with SMTP id n65-v6so72259oig.6
        for <git@vger.kernel.org>; Tue, 15 May 2018 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LOndvQNthMIzyUj2nufqp0/ZHE0mSFjgimxwgAPVGwg=;
        b=UbwSGRdmCioP5N/zZ7cpnGlQ7R88hpJo01wOW6HCKz0n5j4jPE/W9mFXfWY0TdI2hm
         F1SVVOpeVh4Dnhe9lafdLNdygxFIpJywdir+V0VglR2+Wekw1SpxFV2Hd8Sf/3hH9FrC
         UlQSLHMRwU0PsXxKwCjnbW8yONki6RkwIBFs1vJOrX4PNDOk4JNNUdQsQVDu598vN8S8
         38cCoSgLWvgE4kH8RcE6eaI8GcltAAMmMiY/oEs9MVuTIs7h5+h+tJLr/QZ4mRHZEcii
         OmVOUn9vrc3KzQU1ETaFIgOM/F3a9Gm9lOIT+4XuP1BaygRrwWAxPtiPG3xQim/4rK8U
         RC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LOndvQNthMIzyUj2nufqp0/ZHE0mSFjgimxwgAPVGwg=;
        b=ukalJMgR0xse/4bNw7dAHTmJBVUQAllotM1UlwF3FYVWUZU3HCAvrhu5LphyzlIy++
         MMsxxAjA+Y8PAYHfFvdijMUT45LzzkHu0PUkm9iuF62X+g3nlC4wTdBs4h/2WKaYw/SX
         e2O2eURKc4Z7a+apxxSGQtbLckx1xo38L35wcx+q1VZka8x87112d6NePV3VUhKKgB3F
         QOJTaS7XGU+OpHpA9VoekWF5SvaF8uhmYE0OfPGQoQ0+7yiVMQRpw7dxDXsbOSFCe2b2
         AO6AU/1jL+5AmYrj8xfJKLg2EfKhi72YA7ZJ78ERtzoz2ymyc+uAmSJzUpYTjqjujuUS
         31AA==
X-Gm-Message-State: ALKqPwdCXUQ5t4wdDUMSH4YD0/bfr1uy29rGY7howeFs4+aIiPGdcNkQ
        XPl7H7UYq0HChL+4kW6FeL0UIv5UJ+GHlUFBxkc=
X-Google-Smtp-Source: AB8JxZoEZfB6ozSi105iDpcvwrIjGWP5bycGs5Nf5iOlLOlPfd0WGrgZzqjk4r0zo2uW1zU2Y8wN08YKYn5/y/25Wtg=
X-Received: by 2002:aca:2e09:: with SMTP id u9-v6mr9855819oiu.228.1526390045515;
 Tue, 15 May 2018 06:14:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 15 May 2018 06:13:35 -0700 (PDT)
In-Reply-To: <20180515010425.149200-1-sbeller@google.com>
References: <20180515010425.149200-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 15 May 2018 15:13:35 +0200
Message-ID: <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
Subject: Re: [PATCH] grep: handle corrupt index files early
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, ao2@ao2.it
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 3:04 AM, Stefan Beller <sbeller@google.com> wrote:
> Any other caller of 'repo_read_index' dies upon a negative return of
> it, so grep should, too.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Found while reviewing the series
> https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/
>
>  builtin/grep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 6e7bc76785a..69f0743619f 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
>                 strbuf_addstr(&name, repo->submodule_prefix);
>         }
>
> -       repo_read_index(repo);
> +       if (repo_read_index(repo) < 0)
> +               die("index file corrupt");

_() the string (and maybe reuse an existing phrase if found to reduce
workload on translators)

>
>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>                 const struct cache_entry *ce = repo->index->cache[nr];
> --
> 2.17.0.582.gccdcbd54c44.dirty
>



-- 
Duy
