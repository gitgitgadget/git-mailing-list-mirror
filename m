Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84397C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 12:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642EE613A7
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 12:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354283AbhJAMKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354188AbhJAMKH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 08:10:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7CC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 05:08:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bd28so33858063edb.9
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hamDuvGPfKbi3/He8Oz5MjP42ndPwRMeJ9tpMJ5z33Q=;
        b=IdtIluAT5nbP81pF4d181HyeJfHZIdli5EyUBTGCbOcWIjGOdtXRBtt3n/AtBk/6Jk
         OKcAILs9rOuVrG7pADHtNohB6pMpZet1NC/s8F29yZ9aEwTZ3B10068/IGDXqjOfnnFj
         J7s5t54GsFIoHwgYOtSgX42lKUU0VCqRHY6bNb8F2Ttep267n6SmoWz24mRNgPdY6VN0
         H2pGPkFZlB9vh8QKY77HubOUaTNYNXkNy6J5O2dCHciBQV2oig9GzLmjST3QQBMoi8LR
         QS2keVCy7UFDutUMM8SM4M+UdEDQWAmj26+vSIoqnDjAzUwe5I9PdUCSLvnq/0JZLaC2
         3Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hamDuvGPfKbi3/He8Oz5MjP42ndPwRMeJ9tpMJ5z33Q=;
        b=2av20tnCBlKAJNFPc4uaPnFXMNaTvGD3mMnGaUqLsnKB9fXyTiV0RQ96YFzXXwB0Tv
         8h+Gict75P+Etnah/GM2K/6ChtBjhk6WLgnYoxQuTNKWMhEo3kTiekosiHChelGZTSms
         O3fFB/7jRxpg2mJ+P8UasrKkpPNLbP24qF+Kr5B/zhsOS76fC9VhHd2qvAkcctx67JWk
         K78IKk8aRJf26HTaDThfTJjgxGvz7Jtbf2cKVifqUsM3mqYzHaXfkVOaCr6oYrC5Q+6b
         DrzMe2yyb7yHm+AfgYtDYAp804IS0TlGKS9PysXVJonP3Ch4ZFUGHWlgu/lwBzvbOwG4
         Jqjw==
X-Gm-Message-State: AOAM533l4thZngMaml13uJ4OhooQEg+4lhA2SAL1VFmYiftTGg3dCuUo
        3tKFXXTeQc3wq4S7caDE7L9PrjMobFoSKA==
X-Google-Smtp-Source: ABdhPJzdZqkrTCgHS3wm6IKDxg8QkEm8L5eX0Bi/kvUSq5lMfaC1BLb4wj5VtS9q2IQL9gCKMk4QXA==
X-Received: by 2002:aa7:d890:: with SMTP id u16mr1315236edq.367.1633090101362;
        Fri, 01 Oct 2021 05:08:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k10sm2854366ejo.117.2021.10.01.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 05:08:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #09; Thu, 30)
Date:   Fri, 01 Oct 2021 14:05:20 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <8735plrlql.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

[I figure for this topic update of mine I'll do the split E-Mails as
dicussed in last What's Cooking, also maybe my relatively long updates
to past ones have discouraged reading...]

> * ab/designated-initializers-more (2021-09-27) 6 commits
>  - builtin/remote.c: add and use SHOW_INFO_INIT
>  - builtin/remote.c: add and use a REF_STATES_INIT
>  - urlmatch.[ch]: add and use URLMATCH_CONFIG_INIT
>  - builtin/blame.c: refactor commit_info_init() to COMMIT_INFO_INIT macro
>  - daemon.c: refactor hostinfo_init() to HOSTINFO_INIT macro
>  - Merge branch 'ab/designated-initializers' into ab/designated-initializers-more
>  (this branch uses ab/designated-initializers.)
>
>  Code clean-up.
>
>  What's the status of this one?  Meh?

I just re-rolled this as
https://lore.kernel.org/git/cover-v3-0.6-00000000000-20211001T102056Z-avarab@gmail.com/

As noted there I've got meaningful leak fixes that in some cases
semi-depend on this, but I did more conversions than strictly needed for
immediate follow-up I have. I'd prefer to just got this particular churn
over with if there's more memset()->*_INIT migrations needed.

So it would be great if that would be a s/Meh/grudging acceptance for
'next'/. I promise I'm taking it somewhere worthwhile :)
