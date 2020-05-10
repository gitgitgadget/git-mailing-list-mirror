Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E05C35280
	for <git@archiver.kernel.org>; Sun, 10 May 2020 04:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA12206D6
	for <git@archiver.kernel.org>; Sun, 10 May 2020 04:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="cz1jY9Fi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgEJEXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 00:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgEJEXn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 00:23:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BFC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 21:23:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so1559899lff.9
        for <git@vger.kernel.org>; Sat, 09 May 2020 21:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3El9CIiRzzL+P9bsEnyV7BaCaoZ8qa5fcp8RimM4iqA=;
        b=cz1jY9FijHIshev/3+s8PJr8t5mpw2Q7UbFYbEQCk1bXB6df7FTd+etTWx4rbZUYTI
         ByS6x8LZzUNAQ3W04wN9t0waksYh604KK7UghufwHn13uIFx7wLWiPY8A11gxr5scwGW
         h7WbXxeKDhzRPBk6W3nGJZMVgHazJSB+ujhub7OskSc35zYzJyl9bKCsvMNBXRYoed/U
         EPdgjxNFwedBb9Ah4+Q0bXWZ+xSCxkGDzANYWOj8+AcqV4Emp8hQZYzSvAlL2fkvmI9+
         gBW4JOr/J8+f8zr1eLz6FtuJMvqpHwMhabprpRNJ3tKaXpHJ5mpIAZzlzXD62OqTWuuo
         98Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3El9CIiRzzL+P9bsEnyV7BaCaoZ8qa5fcp8RimM4iqA=;
        b=pFWBNGt27TmwsQCn63askBWw9P95czg1gIf+OBgiv16FGiwOAccNVrAEhoZJW+Z0n4
         IZuQFcL+2jnQEh00+bNtpDASmWSalAimRODAznS/2G7feDkadHInJ+Z8jd5YVIEjGVPM
         iF2rlabkbUwI2znrnxop9Ozod0LEzC+cvOeyMKpMCaREZhTToTYKiPPfa2BuIAE6VMXm
         uH7zKsxExqjX52HMeCJKAiLcl187OdS7v/sFNF5PkJFqXR9ntoVsXK/hjgft8vYtgqta
         9ErHEir94IA+FBQT0Ij5gB1bTZqN53ydzwYC/8PmJxA30EyZqBmPp8k2OpfmT/lxK3OL
         3Y1Q==
X-Gm-Message-State: AOAM530L4W0+gKWvxEXAhfjPGaLxG/EhAdOuwFoDTJR9NAQIhgT3A0o8
        05lCcbQNTqEu8S+Urflsxg7Oew+BBN1HDAQ1Ar9060dZgVo=
X-Google-Smtp-Source: ABdhPJwEHDQYmh2Og2XyIlljHGOeNDZUXtL1iXm/uCShitfgmq6JwM06Uex2tvC8PFHIsvVExCj621ZuEwASfK92XT0=
X-Received: by 2002:ac2:4213:: with SMTP id y19mr6357561lfh.99.1589084620998;
 Sat, 09 May 2020 21:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br> <3e9e90624901113fd5c5670c0c2023c709f71d6d.1589058209.git.matheus.bernardino@usp.br>
In-Reply-To: <3e9e90624901113fd5c5670c0c2023c709f71d6d.1589058209.git.matheus.bernardino@usp.br>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 10 May 2020 01:23:29 -0300
Message-ID: <CAHd-oW6-A6_3FTskMWHvD5=23SLRFU19s2JrYMx3f94i-uB27Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] config: add setting to ignore sparsity
 patterns in some cmds
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 9, 2020 at 9:42 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> index 3bd67082eb..8509694bf1 100755
> --- a/t/t7817-grep-sparse-checkout.sh
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -63,12 +63,28 @@ test_expect_success 'setup' '
>         test_path_is_file sub/B/b
>  '
>
> +# The two tests bellow check a special case: the sparsity patterns exclude '/b'
> +# and sparse checkout is enable, but the path exists on the working tree (e.g.
> +# manually created after `git sparse-checkout init`). In this case, grep should
> +# honor --restrict-to-sparse-paths.

I just want to highlight a small thing that I forgot to comment on:
Elijah and I had already discussed about --restrict-to-sparse-paths
being relevant in grep only with --cached or when a commit-ish is
given. But it had not occurred to me, before, the possibility of the
special case mentioned above. I.e. when searching in the working tree
and a path that should be excluded by the sparsity patterns is
present. In this patch, I let --restrict-to-sparse-paths control the
desired behavior for grep in this case too. But please, let me know if
that doesn't seem like a good idea.
