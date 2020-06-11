Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF775C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8565206C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byKaoEm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgFKSaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKSaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 14:30:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3457C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 11:30:18 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b18so5324366oti.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbKebRb0kiTIsMRyK6VwPIAwABuA5KuzDajXjZIEGKo=;
        b=byKaoEm8yK+DPjCLqfx8ZxRb/MvY0/NKEXBRMJEPYaA+n/2fc13lmdYWk28OzfrQBa
         26Q5uzcLJ3vqMqPUyDagpfV4LxbwR5Mo/a1O2xNl3M0P6Z7MR+4BWjGmb/LyT0cA1NPl
         c+XcE9+EFshMa/5i3l0ee10hMpTWeVRi8060txXdx9NX6/G3De3pyC/sbdnW4wluyBcC
         xBnsqX4pnxPAPxUMhgf/kZiEQqbWzmzHEm6xr1D+ub7UmvSQrE/AnoKJfR6vccnIRn+J
         sAEq7hk+iS5NVVYvqrF+FKdL8gRiYyNIemRzubnWccEJep3I31UIN3Qw++c7Kpl+CgKP
         Kq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbKebRb0kiTIsMRyK6VwPIAwABuA5KuzDajXjZIEGKo=;
        b=RqmarRl/dELBXTN/W2OEzzXN71XFVwJNhFZsRY+vNdEP8umlEFZi6G+RQsjhJQFZjJ
         41QYE1ylJlsCIktUUTlTU8GtiVdXNUQ0qXu2m6hPg3YB1QaF1yNJAVpD+Rmnck88HONm
         E7is4fexCmFuhINjf9cB1T/DosBmSILBNbYchy586j6HLagpM1zPSY+c4yQfy+MwtDvX
         0IHwEpAh1DF+capAzonmy8rQI9VxOk9jN1ljm1grHnJDjK23b3kDlMULbq3JGlr93i4e
         XDyvoa79Ln39D0M76VH4qd8rNxyMSaS6frvxRHjV0a6VStV/XFh8p63G9tDkk3EIk8yX
         MTEQ==
X-Gm-Message-State: AOAM533f+yme84lNSJhalFNKnAnpVdgpiYVp8FkjR/568BGicEsxk+lY
        vhY8npn+yeYfsWBAUNMTCZoXWFmFTf/7gWrZAz6SLu+tgiw=
X-Google-Smtp-Source: ABdhPJzCA5fxrxGwp9zI9ay8PfB8C0ypqzuK8Cr4kyidqDj3hQWxx41kQj+NAyf0P34KusOHSyAms6++p7x2RZH0bNc=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr7861295oti.162.1591900217930;
 Thu, 11 Jun 2020 11:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <000801d64010$565b0b70$03112250$@gmail.com>
In-Reply-To: <000801d64010$565b0b70$03112250$@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 Jun 2020 11:30:07 -0700
Message-ID: <CABPp-BFRX3MPn=jw+Ezdx1pmxVF9SJw7Mxhk5cS5KUrXFJmM=w@mail.gmail.com>
Subject: Re: git sparse-checkout set not working in git 2.27.0
To:     Alasdair Hurst <alasdairhurst@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 11, 2020 at 9:52 AM Alasdair Hurst <alasdairhurst@gmail.com> wrote:
>
> In git 2.27.0 sparse-checkout doesn't seem to work the same as it did in
> 2.25.0:
>
>
>
> Version: git version 2.27.0.windows.1 (the same behavior occurs on 2.27.0 on
> linux too)
>
> Commands:
> -git clone git@repo.com:user/repo <mailto:git@repo.com:user/repo>
> --no-checkout --depth 1 sparse-repo
>
> -cd sparse-repo
>
> -git sparse-checkout init
>
> -git sparse-checkout add packages
>
>
>
> Expected behavior (as seen in 0.25):
>
> -ls
> packages
>
> The packages directory is checked out and available the repo root.
>
>
> Current behavior
>
> -ls
>
>
>
> No packages directory is checked out and the root is empty.

Thanks for the report; this was fixed by commit b5bfc08a97
("sparse-checkout: avoid staging deletions of all files", 2020-06-05),
currently cooking in the 'next' branch of git.git.  See the thread at
https://lore.kernel.org/git/pull.801.v2.git.git.1591324899170.gitgitgadget@gmail.com/
if you want to read up on it.
