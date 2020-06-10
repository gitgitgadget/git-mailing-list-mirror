Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34128C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090DB2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1O5uw1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFJVyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFJVyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:54:12 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82397C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:54:12 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q10so989702vka.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byWDr804t9AVeVUsyHjn2fkDIDioeCl91zjrikyVU4k=;
        b=g1O5uw1XRyT8mw4YBVM1GdheDmgf6W95h+ZkaT8dGMnOyPSfUzCfHpc64mfeSAFfur
         h8g544V2Q1MpzP92ZjMX32s2pnVh8fW/qmksxVpupaDsMS7/w+rk8yuNMdwX0AExNUOQ
         zstnTUg8wsjdBjOBvqGw+6DLgidP8gZ2aQuKeUHfq+p/6w42op0nS08E+QS8HfhoSzsk
         9wnTdsC1wEXGvd57VMwLt1QAEBr6+S7+f8ryjjcPMV0ou08L33AE0dCl3tM5He4KNApn
         KFbBUd4AHj5kNsHr5qD1UnfcIWbEC0wNgjnSd4oE2Wq/ylBZz9hjd6JEcS6qLA+I0ATT
         21iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byWDr804t9AVeVUsyHjn2fkDIDioeCl91zjrikyVU4k=;
        b=A4ENACXWAqSTpt01jqQfkdlqjJ8qTUHamkJCEfqIc46I27wbhZdyUFKgvEkhSboC7O
         8Z1FJxY2Qyl5UhpFi/Hfgt0xYvOSok+SM8o0KEVu6Ra7ooMBVY0zCkHWHIgP3qNye7sl
         aNegFYfNHVjLQF4d7W25cYD/pcu5sE1sPN+tEPxkEVtB3KX7zUzEvusSguuT36H3NRsj
         pSumeWYZK3ZbB0c9j81tXPjwNBvi88Mohkr7SNj13i+BmT6fKxAVsmMODHVtOO9SjwOM
         fjXKjMA1GeGT8Wjfif8G17Z2A2stBY5Fky0LJHl6P9rhaBVPP7ngB1DQ0r3ATXXML5Pv
         q8RQ==
X-Gm-Message-State: AOAM5305VtgZlgWABzVBrISg2JbaFYl4GsUvNqHor2GkImfpk5rrX/KX
        hVcx99P52VbU0k6qUEpC4R1Xu/oDsJsGQZcY/Lo=
X-Google-Smtp-Source: ABdhPJzusYSGDscRZnJec86QaOLyiYVOELiuf3h+qDRJJDLAwokf0LV45sEF6nDzugDGWBvEW6LJJwtaKYdXdjt9a+U=
X-Received: by 2002:a1f:4303:: with SMTP id q3mr4141951vka.65.1591826051594;
 Wed, 10 Jun 2020 14:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 10 Jun 2020 17:54:01 -0400
Message-ID: <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, don@goodman-wilson.com,
        stolee@gmail.com, Jeff King <peff@peff.net>,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -        * We also leave "master" as a special case, since it does not reveal
> -        * anything interesting.
> +        * We also leave the default branch name as a special case, since it
> +        * does not reveal anything interesting.
>          */
I feel this is a weird thing to do, since you're trying to anonymize the branch
name,and now the default branch is identifiable with your config file.  For
example, if the default branch contains the name of my project/repo then this
sounds like a recipe for accidentally sharing it. I feel a better
alternative would
be to exclude nothing from the anonymization or the proposed default default
branch name


> -       if (!strcmp(refname, "refs/heads/master"))
> +       if (!default_branch_name)
> +               default_branch_name = git_default_branch_name(0);
> +
> +       if (!strcmp(refname, default_branch_name))
>                 return refname;
>
>         strbuf_reset(&anon);
> --
> gitgitgadget
>


-- 
Matthew Rogers
