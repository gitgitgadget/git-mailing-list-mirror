Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC07C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F39161132
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 19:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353361AbhDNTWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349115AbhDNTWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 15:22:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17918C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:22:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mh2so11551799ejb.8
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=+WXulHSPbE9wBC1uJFZ76qn2R5DDQMTzNzZL01uC1D8=;
        b=u6nZHVcldV5yOHqDZnYjjl2xBI+IOtZx3/2pqPkd8rUyjjA2Kvr1ZY2nbfcxBUh9SE
         QJJpvZ6IboR7Tr+mBAHKe+agok5LbDZONBEzAl8rOFYPbzDULOvdIGk0z3Pw9PxyJ387
         xLugpDOb3PXKUV7nRj0WHknEclsppdCpms53XQPL5rr8Dho0Z8zcjLDsAdM3j7mJbs5m
         2np+AyfmpONBFbXyA0kKoSW/2CFyBmEAbMezuHA0P/y2j1pKsx149XIkqR4D8GXOc5kp
         VS6rNOcV8XF8be2JJlnOl1x3Wyaa9wEYFvIPUspKXCLMI5oK48oBxmgzOgJPFnbwc8TU
         3CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=+WXulHSPbE9wBC1uJFZ76qn2R5DDQMTzNzZL01uC1D8=;
        b=ZFb65BUHK3DM8YJPhjLuCa6xsdPGAZpYkpxl7Z6+p24wozycmx5H6FJKzyUZWvmQZT
         LgmYZ5M+2kMuDmesJGgJnLFKCchs7ZSG6nUxB4PG45tHsLPDTMK4rjE/bYxUC5+hGMZ9
         EbEIdxftv8I9SA70iCbaE96MvHj/T8uicVYdWUCXowWz2lMu8LjMejjy4Ynr8mRlMNYb
         fwb63fMcDSGsbPmd+n028ENnzdjMtiRTEVNkX18cu8Ddo6A5Pa5Wpn0jnn3sRKmuzfAf
         d7vy8I3M+OGaVs08+C3K7hvA1yDekj5Gy+iLkvOPOZScT2SHqNvGkPCr4KSspZdIDcv5
         QTVg==
X-Gm-Message-State: AOAM531Jg2jdaz0aH3beHb6RAcAg8PDgMRC4l3vPd4qNIv+eEb+Covy3
        2K2xeQDk0LZVoO5ULMFcaomeaCpV5dQ58HE9
X-Google-Smtp-Source: ABdhPJyRt9146OXDuHQYJhD9VtGJoq5hdvv0RwRwc983O/OPreW2pCkdeACbISCSuYvlyg4bOlGyjA==
X-Received: by 2002:a17:906:ece4:: with SMTP id qt4mr430163ejb.514.1618428139538;
        Wed, 14 Apr 2021 12:22:19 -0700 (PDT)
Received: from cpm12071.fritz.box ([212.86.35.110])
        by smtp.gmail.com with ESMTPSA id i2sm246428ejv.99.2021.04.14.12.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:22:18 -0700 (PDT)
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
 <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
 <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] low-hanging performance fruit with promisor packs
In-reply-to: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
Message-ID: <gohp6k5z0o6593.fsf@cpm12071.fritz.box>
Date:   Wed, 14 Apr 2021 21:22:18 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King <peff@peff.net> writes:

>
> I didn't explore any of those here, and I don't plan to look into them
> anytime soon. I'm just documenting my findings for later.
>
> Anyway, here are the patches.
>
>   [1/3]: is_promisor_object(): free tree buffer after parsing
>   [2/3]: lookup_unknown_object(): take a repository argument
>   [3/3]: revision: avoid parsing with --exclude-promisor-objects
>
>  builtin/fsck.c                   |  2 +-
>  builtin/pack-objects.c           |  2 +-
>  http-push.c                      |  2 +-
>  object.c                         |  7 +++----
>  object.h                         |  2 +-
>  packfile.c                       |  1 +
>  refs.c                           |  2 +-
>  revision.c                       |  2 +-
>  t/helper/test-example-decorate.c |  6 +++---
>  t/perf/p5600-partial-clone.sh    | 12 ++++++++++++
>  upload-pack.c                    |  2 +-
>  walker.c                         |  2 +-
>  12 files changed, 27 insertions(+), 15 deletions(-)
>
> -Peff

I took look on this series and tested as well, together with the
fix for the "unpacking and deleting" promisor objects situation.

It looks good to me.

-- 
Thanks
Rafael
