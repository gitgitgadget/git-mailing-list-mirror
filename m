Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683EEC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 22:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A38221FE
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 22:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbhATW3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbhATVvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 16:51:41 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB6C0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:50:34 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id s6so11668153qvn.6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rma9WePIZOSZjctww7z7QG2fIyRV4pamXU0bsLXQE4=;
        b=N8dZrn9xRhOwYLbwcQlUBYjZKjiSvnVrzeVjllksWn9ESHZV2kV8hxZtV36bsKyde7
         tLS1o4Mf5Gta+lSrYXF8HaL+cSMlSg8nmbw9j9GszGLw5tKNfvCIor+PGcMDWK5wiQDI
         7fruXGxKH52hPrXUKMuU5vZfcsqDsiFLmLQlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rma9WePIZOSZjctww7z7QG2fIyRV4pamXU0bsLXQE4=;
        b=MS18Yy1qYgH61A4yxQ/MKp8jEupi3uP40h8rtz5+F+pOiLy1ZhLWcadYb5GjWnE5p7
         PUvmJF7bVE/Q4DhCj4H/LGIBIELXniIbAC3jeMP5B3qN7PdjF9945oOzjDIyQhJ6NQpZ
         ahZnpLIWM8pyAaVGJ4yQqPV486XGqIdtT/MP+b4CzsYRrngtPWVeAL4buC+6tDKJT1Jo
         B0HSD91dDfAzlnsvk9tS9ygx7/oszja9hfr0tWojM2bZD7iN8Z8GXmf6iDYn1lP6zJ0t
         Fh+b0MEdQM68JnuJAVNR9zByzMJ3xcuFQ6ExbmR3CSXkNr/8oLk2l3xiwqKtressDesw
         hJkg==
X-Gm-Message-State: AOAM531ieuR0eQXDhvk65WWiWXLl4YVBZulrytlE6ju2sCjBGxPCKu55
        0vNSf2qId34RyuPznVzc7VZ60hAJKfhRKadLyijHfcKky/gFpg==
X-Google-Smtp-Source: ABdhPJwJNuiShQsNtOMZFZUDLjotLdVWR8rofdQLf3bjKxpllL7nmMRk9AMCRoRvS6y0T4miX57JODqJrQ0jQ18U6gc=
X-Received: by 2002:a0c:b59a:: with SMTP id g26mr11480950qve.26.1611179433574;
 Wed, 20 Jan 2021 13:50:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611080326.git.me@ttaylorr.com> <cover.1611158549.git.me@ttaylorr.com>
 <5fc081b2d554db305400ec52fac8683a3ed59597.1611158549.git.me@ttaylorr.com>
In-Reply-To: <5fc081b2d554db305400ec52fac8683a3ed59597.1611158549.git.me@ttaylorr.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 22:50:22 +0100
Message-ID: <CADMWQoNH+1MRGYsrJjHTUqhyYMHb9XP5-dQ3KHLT2qNVGGtttA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ls-refs.c: initialize 'prefixes' before using it
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the person whose name is on the "From:" line, I approve. And thanks!

On Wed, Jan 20, 2021 at 5:04 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> From: Jacob Vosmaer <jacob@gitlab.com>
>
> Correctly initialize the "prefixes" strvec using strvec_init() instead
> of simply zeroing it via the earlier memset().
>
> There's no way to trigger a crash, since the first 'ref-prefix' command
> will initialize the strvec via the 'ALLOC_GROW' in 'strvec_push_nodup()'
> (the alloc and nr variables are already zero'd, so the call to
> ALLOC_GROW is valid).
>
> If no "ref-prefix" command was given, then the call to
> 'ls-refs.c:ref_match()' will abort early after it reads the zero in
> 'prefixes->nr'. Likewise, strvec_clear() will only call free() on the
> array, which is NULL, so we're safe there, too.
>
> But, all of this is dangerous and requires more reasoning than it would
> if we simply called 'strvec_init()', so do that.
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ls-refs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..367597d447 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -90,6 +90,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
>         struct ls_refs_data data;
>
>         memset(&data, 0, sizeof(data));
> +       strvec_init(&data.prefixes);
>
>         git_config(ls_refs_config, NULL);
>
> --
> 2.30.0.138.g6d7191ea01
>
