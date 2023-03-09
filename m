Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F284CC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCIR51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCIR5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:57:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9954FCBC8
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:57:20 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id cf14so2883194qtb.10
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678384640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytvvvRD3hrVSw2T++8yPe3p88qPyz8pKcP3OgAv0guc=;
        b=fd36n+N7A8hxGIVaUNZtQXcR/OgnnLyxYNEy7/kpvbZ/Op678z1RVyjFgglZ+ak3Ow
         VMC0zNSxvV9zys4XoP8xWmHW889mtB4kWNy/Oz/s1JdVzQzn9+OIOfrs0GAY3ASnundq
         3A5VVmmTrBNHZ3zNjYlGzBU+p3+smzzDsob4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678384640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytvvvRD3hrVSw2T++8yPe3p88qPyz8pKcP3OgAv0guc=;
        b=awUXaMxwyFQWyXcUstYqvk/QX+5WmIc/MCrWXRegD6LjW/BkaCFRln5LJqdqf1TyhY
         pKzzeZKXPXBM2kRkuhjvJuwxwPHxwxFiEzgFxQwC8dYAozkyGj17xrN0FuaWPvc9w3Ni
         VedKpbDqsnP/y8wVb7f3drnHwT03r5zxaPZJV80XrKrE5nzr4GzWc4DEQ5R791542DCB
         mM/tmSYJxNVJDv4xLtf1c2bPVZrlTxixoIrOIvPSko+VmB7VpwDiV3He5Un3GcNWErpO
         prbo+qTpBylTCIcr/Px9MBQG/Jl/hmkasJtNV8xifvM0QPCHw78L85ZIW33wKZIPqIxv
         K2Vw==
X-Gm-Message-State: AO0yUKWkH3Hz4heMMZOdur6WQinutipYBzupBKiYTKff56qjxiUBlnxF
        FA/m/o+tlYe98FAmjUc+ihwD6g==
X-Google-Smtp-Source: AK7set9iN6xPivPieI8bazbyRtTptnR+iqcn+JbEKPLLo3AzUguTAazzIoJH9fUZSf0jhVMT7QMyrg==
X-Received: by 2002:ac8:5711:0:b0:3af:4d45:b73 with SMTP id 17-20020ac85711000000b003af4d450b73mr36606404qtw.33.1678384639994;
        Thu, 09 Mar 2023 09:57:19 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id b1-20020ac84f01000000b003bb8c60cdf1sm14037648qte.78.2023.03.09.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 09:57:19 -0800 (PST)
Date:   Thu, 9 Mar 2023 12:57:18 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org
Subject: Re: Fetching everything in another bare repo
Message-ID: <20230309175718.j5c2dbx3asphiqhu@meerkat.local>
References: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
 <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
 <64282d0f99df59085a18585846d2086a652677e2.camel@mad-scientist.net>
 <ZAn80gnIFLOF4Gco@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAn80gnIFLOF4Gco@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 10:35:46AM -0500, Jeff King wrote:
> You may want to try the "preciousObjects" repository extension, which
> was designed to prevent accidents for a case like this. Something like:
> 
>   [this will cause old versions of Git that don't understand
>    extensions.* to bail on all commands for safety]
>   $ git config core.repositoryformatversion 1
> 
>   [this will tell old versions of Git that don't understand this
>    particular extension to bail on all commands for safety. But more
>    importantly, it will tell recent versions (> 2.6.3) to allow most
>    commands, but not ones that would delete unreachable objects]
>   $ git config extensions.preciousObjects true
> 
>   [this is it in action]
>   $ git repack -ad
>   fatal: cannot delete packs in a precious-objects repo
>   $ git prune
>   fatal: cannot prune in a precious-objects repo
> 
> Sadly it's not quite smart enough to realize that "git repack -adk" is
> safe. If you want to occasionally repack with that, you'd have to
> manually disable the flag for a moment.
> 
> I will also say that while I implemented this extension a while back, it
> never actually saw production use for my intended case. So I think it's
> pretty good (and certainly safer than nothing), but it's not thoroughly
> tested in the wild.

We use it in grokmirror for objstore repositories [1] (the super-parents of
all forks), as a precautionary measure against a sysadmin running any kind of
manual operation that may result in loose objects being deleted. I do believe
it works well for that purpose.

-K

[1] https://github.com/mricon/grokmirror#object-storage-repositories
