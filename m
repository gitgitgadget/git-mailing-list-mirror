Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D5BC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98335613CF
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhGNPLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhGNPLb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:11:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634CBC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:08:39 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so2567832oig.12
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p4BnDMMd8mH8F0wIqLgz6827ARIMOJEE4Gam0qZJYU=;
        b=pdwdlc9yi2hXkvzqxGPexUIcf7K3eA3/gTF5tfqYLhPDNr07ohZA0es8Ve3gtnWHkL
         bWOjSXJzWvFSAD5tirqv6iMDrKPnV52CjffeWqsXHdneXzUmbSUc95DZS0qfQPGO3jpw
         PRsFQLv0Y21ZuDrJg43NHeXhBiZfZ7J9ZCv0J5Cyh4kigzAtHfcIyYTVubjNPOk3uxCt
         GnmDsgOpOpy3Do9rlj7Jt/XdXnlaRZiC6rWt2L3w4HitPgF+IFG5BPJiMWNz/9ez6Jxi
         PW/WwCpbmAyn/peyJJWTp31+QDlWHr0KLzbbmwXARGoq56/QJmXfvFwTCGsf77yjlSWv
         nYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p4BnDMMd8mH8F0wIqLgz6827ARIMOJEE4Gam0qZJYU=;
        b=k3mizUKuEXtuf3UX3X92KbqfEJVFCIh2qSVVf32X41i4/HwSksyWv//g4cBPsiAGD8
         ltO/PwrE6kJgspEXn6+M3hwWShyQ3qvov8SPZTPwuhvx6UnLwKtMneN3cmOl7RrZUFNO
         mW8ZEx1v7z7yh5xxu4iDsyDk5Nl4OQ+zLf29nC49ohjxkMXK4eFhgH+IA6sqiUv/SRwC
         vTZZAzVvJziFUIc6Bw3GvQwq8nn8xHJ0p5wQZzlR7mfXfod81paaQ7kkneXSV1Z7bgtl
         quK6BCmvcBosPgZv8G3cci4g1m1Z2klOyj+l2XiX60R4xnREmk9XF/LFRnx60AnwR1u+
         DU/Q==
X-Gm-Message-State: AOAM531GuxD5YjLnLTCDDrRSl8J5L4rjJh0yYSMCpGCCAVjo7h3tcKWR
        c7R/C7NIkCvyOxjKdKTcWHKJlIENRzAQGX40emQ=
X-Google-Smtp-Source: ABdhPJwTpvlucG8GhL4WIzFBoCD8eNE8JrSSWTPhnTy4gWcUQYIuRA1TCLSRL0CSySMY6spPcz5o2lNkUPGQ/rBvNpM=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr3152142oie.167.1626275318792;
 Wed, 14 Jul 2021 08:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com> <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 08:08:27 -0700
Message-ID: <CABPp-BEJFfTpmekgcsEji4hH+zswPCPxTZS+3sbnDhwGy2kvqA@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 6:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first "payoff" series in the sparse-index work. It makes 'git
> status' very fast when a sparse-index is enabled on a repository with
> cone-mode sparse-checkout (and a small populated set).
>
> This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
> The latter branch is needed because it changes the behavior of 'git add'
> around sparse entries, which changes the expectations of a test added in
> patch 1.
>
> The approach here is to audit the places where ensure_full_index() pops up
> while doing normal commands with pathspecs within the sparse-checkout
> definition. Each of these are checked and tested. In the end, the
> sparse-index is integrated with these features:
>
>  * git status
>  * FS Monitor index extension.
>
> The performance tests in p2000-sparse-operations.sh improve by 95% or more,
> even when compared with the full-index cases, not just the sparse-index
> cases that previously had extra overhead.
>
> Hopefully this is the first example of how ds/sparse-index-protections has
> done the basic work to do these conversions safely, making them look easier
> than they seemed when starting this adventure.
>
> Thanks, -Stolee
>
>
> Update in V9
> ============
>
>  * Fixed typo.
>
>  * All patches are marked as Reviewed-by Elijah. Thanks for the careful
>    review!

Thanks for all the hard work and pushing this feature forward!
