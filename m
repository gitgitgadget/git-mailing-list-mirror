Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9695FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A5560F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhHPPvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 11:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhHPPtY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 11:49:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B5C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:48:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y34so35357576lfa.8
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwXrXp5DPFpmCNTLCY2sWd6vDRI5bZYLMSwu++z6wm0=;
        b=mGFq8yU/a3RUybuZ0kbE/kjJnOeTl5MVwH1cwgXyYRg1AyNqSRIcBrJLg31rv5Cvgd
         KMA9ex6rD+Pc0yUMy624YQwtfqjRq2rnuFGIZIzOHn7UnHNRwRKD3bX1teySEDd+4H1I
         rkREhoNRVXpkidGqcm8Oid0pwyceKuUlzDCTPyCGIh7jDDMqzTllz9dZilhiX1sP3Pi6
         ASnUO6Hz/XBjndgrvTls7iOLJlQcakj11rzJvMvmOAj+O87O/Lmo7deF0YxhD4KqXNsH
         5T+uoXOdCeHCuhNpdlL5GxEr8rJ/9sBDefhVgcntywqaEogqvA3lFmdN5Y81/mFvRnGM
         77uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwXrXp5DPFpmCNTLCY2sWd6vDRI5bZYLMSwu++z6wm0=;
        b=f1DtiMSf2jvf11zPA71YIJx1+cgSGRr7qEslwBodPYtxyK2+cYDlpwYnGt2OPsfeAu
         ainpXzjACCuIfpHBiGw0u/AXQZT2imJZBzwNcpI+Q09HVIlA8gUpQnr44gmaM04ww9/k
         QzfO4E+k5yBkg+aLbo5NG11bv7Jip7bcZ7B6c56XjFpcEztkw4a6ypcCFsFV4cZLoAPO
         //Obq4O6KN116yWjKYhYzrQRKNGhQS7hkoHrBfhSA8VTAoiadb/eOoO4ApkZEO67+gON
         USAZ0MOB4KtlI3qmoNiKCPFK8phuDlmUm6FNMYBSlT+ruSYMTexfvs0aWUd87LO68eom
         OuDw==
X-Gm-Message-State: AOAM533/xwywhF6X/6CUwDPCRxUUVqdLToXe/jKEAlukroQVvyqMbg4U
        W6m8vEqLOA3yw7sNyHciESWD2FzfFxVGu8CzJj0qPA==
X-Google-Smtp-Source: ABdhPJzarYTdlpZOUBu/++7xqCjCO8kZts2cqscKzM6d+ROMrvoNHZj58vW6v5t9Zv+yISht2eoMnmStOL5PBV34q0M=
X-Received: by 2002:a05:6512:3f5:: with SMTP id n21mr7574469lfq.359.1629128928761;
 Mon, 16 Aug 2021 08:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1628888668.git.jonathantanmy@google.com> <94db10a4e5943d689113693c64633ddffa5508cc.1628888668.git.jonathantanmy@google.com>
In-Reply-To: <94db10a4e5943d689113693c64633ddffa5508cc.1628888668.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Aug 2021 12:48:37 -0300
Message-ID: <CAHd-oW4rd6=9WP-7k-Z9V1Z-4nDXR13-45cjyB6GEczxD3+56g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] submodule-config: pass repo upon blob config read
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>

Oops, I accidentally deleted this part in my previous reply:

> diff --git a/config.c b/config.c
> index f33abeab85..a85c12e6cc 100644
> --- a/config.c
> +++ b/config.c
> @@ -1820,6 +1821,7 @@ int git_config_from_blob_oid(config_fn_t fn,
>  }
>
>  static int git_config_from_blob_ref(config_fn_t fn,
> +                                   struct repository *repo,
>                                     const char *name,
>                                     void *data)
>  {
> @@ -1827,7 +1829,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
>
>         if (get_oid(name, &oid) < 0)

This should be `repo_get_oid(repo, ...)` now.

>                 return error(_("unable to resolve config blob '%s'"), name);
> -       return git_config_from_blob_oid(fn, name, &oid, data);
> +       return git_config_from_blob_oid(fn, name, repo, &oid, data);
>  }
