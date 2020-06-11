Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC91CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A448B2074B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1k/Ew7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgFKAUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFKAUw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:20:52 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF2C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:20:50 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g129so2411026vsc.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cDgVb8Ir0eCcL+xq6WP2tCGSgpxCwx7zaZ6dCXe61NU=;
        b=j1k/Ew7bC3bXDts+FVlExgn28lvRX7ZlnWkh8Pn+PQLohTQlW/jNFQu8HDjf+pr6Ji
         RuP9KwycThLA+eJomupALo64I5+9vgsuLezSTxqnQ/bwsHskbdoHokMC2nw6LW3eOpy6
         M5uXzTEyunnNTHS/tlfjevsLbUN6rbC+1gfAFh+spMAbwJijaNLh2Zmt/2PnlSoyotx9
         mj6/aiQPq7HtN1zKFSS9o+Q84lXXEXx0ibI3Wy4i+h1DhIYWQOcjB8y4uILBekEbE7cZ
         t3Q56NoAMpPO8F28DNmVz+B0iQeimwp/+hx5h1RCUSg1XLxhMbiHXyx2ISkU5SPHna+t
         6Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cDgVb8Ir0eCcL+xq6WP2tCGSgpxCwx7zaZ6dCXe61NU=;
        b=Bf+jqtoLh7UcvZRU58lpPX19aD7yBM4rVSbQa8zlXto00Yvfp2Q7wVxV4gyxUtd0ml
         NI7QjGUyGvJc6SFDUiJJ82N/IOoCXW7QKmwvYUG1bUKA2OS3KQ7sqM374ycFqOC1rdwq
         xaaCuEga7dvRSWIomvmGLYVIgZOBX2AQUiIDAEBc8HjkxjLSkm0Tol1INr4nvMF1WfwV
         /TMNXWNJ9Ujg3r5rv7baLgegkayB424fguQyI7Crz3bmTZV8Pt/AYiq7lOV1dpN8Ehg/
         zbbfrMm40hV71/+wtdnhrw9QXs8VeOU5RCM1LJ7Ueg4zEw/GKHeiR4YM1Sta/hxnUP9i
         DYcQ==
X-Gm-Message-State: AOAM530lnTfbaRweGgiTyU2GQl3LFWC/4F26tevYOv7yh2scnXQsxA/A
        KaqpXKk1FNoTM14Cikpg8rq2d4Zkb74co6pUj90=
X-Google-Smtp-Source: ABdhPJyX/7NuU9EAT7lERVp0PvNF4HlsWXJdsR3g6dV06yhpMSVs2CD83RrvZ5inK//mU0a1/pPTRW0T2N2XUnrrvvk=
X-Received: by 2002:a67:30d1:: with SMTP id w200mr4853251vsw.40.1591834850008;
 Wed, 10 Jun 2020 17:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
 <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
In-Reply-To: <20200610233912.GU6569@camp.crustytoothpaste.net>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 10 Jun 2020 20:20:39 -0400
Message-ID: <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think this is fine because it only reveals the name of your particular
> choice of default branch.  The goal of the --anonymize option is to
> allow people to maintain the structure of their repositories while
> stripping private information from them, primarily for debugging
> purposes (e.g., providing to us for troubleshooting).
>
> The things people want to prevent exposing are their code, data, project
> names, user names, etc.: that is, anything identifying, privileged, or
> private.  The default branch name isn't any of those things; we know you
> have one, and for troubleshooting purposes, we aren't that interested in
> what you called it.  You've almost certainly picked it out of a set of
> one of 20 words that people use for this purpose, none of which are
> private, and all of which are shared by millions of other repositories.
>

I think that's not very convincing.  If branch names in general are identifying
enough to warrant anonymization then shouldn't the default name be too?

> In the extremely unlikely case that it does matter, invoking git with
> something like "-c default.branch=$(git hash-object /dev/null)" would be
> sufficient to anonymize all branches.
>
> I should point out that people frequently ask for the output of "git
> config -l" for troubleshooting, and most people wouldn't consider their
> default branch name to be worth sanitizing there.

I think this is a little presumptuous, most people wouldn't consider it to be
worth sanitizing because there isn't currently such a config setting.  If I give
you the the output of "git config -l" then I think it's obvious that all of my
configuration settings will be included (and therefore I can choose to sanitize
accordingly), but if I'm giving an exported repository I think should be
anonymized, but my default branch, which someone could innocently base on a
project or company name, could easily be accidentally included in that output
which could lead to a frustrating experience


> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
Matthew Rogers
