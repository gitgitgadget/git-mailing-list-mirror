Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7415DC433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 17:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BFD610A6
	for <git@archiver.kernel.org>; Sat,  1 May 2021 17:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhEARHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhEARHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 13:07:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372DC06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 10:06:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a4so1741203ejk.1
        for <git@vger.kernel.org>; Sat, 01 May 2021 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/Bj0BeGGkQEzLQ01qqi2UMcvCS1i+cSXndsrUyBU+s=;
        b=oWYp1kK2538gVORroP9NlWN+mEU7c/8TEHgs7RuEQSVwzM5d1DHvb+dJXdJ+SDdXpx
         ABS90Bf+i/wPKK4wovaFnzOG/RfXRkAoOgMVDY420hPCEzY/qA2M/tVRc7iMyiqaioNF
         EWRp/kCY1bHw6FgAlaoyoTodpTUHDHLWZjVrmpRdijE3nwsyliOwMIMc42mNXQk0E9cv
         yAR3SBkMs1rIMfFtff9qwi2p8bmZHtpwJCrJ2IH+IU5S6pHnsbnDV2wHZHwZiqz1qUv2
         RTVDS0AGpLVzwCcsxFwtzJXhMhsuPm9AucHTV5tLalbU1u4ATk7BEnJA/rE8TjMrXmcM
         ttmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/Bj0BeGGkQEzLQ01qqi2UMcvCS1i+cSXndsrUyBU+s=;
        b=GGdpnuxWAfNI0mNWX3eMCZ1/X59bsEIzy18ROVYimWKkYR/0+2rBsXmOB3PMItQD11
         ol8BL6q/O5CqWnZ/LzHdftggKkqr9Di/kbGn0YiCpNB5XvvTZGlcVoAVe0UCHBzoptv0
         iQ2NbJzij704nyZPEGF2iGwCemf1QzJmaUk1tM0anJosLFwyUP+y1EZZLjmur69MfhCs
         AXd0eahHcCn52RXL3/pNIK+Nig+LNCBahbvrq39ib4guY2ctO1E3fEcLrSTy/9VLcpZL
         v8nce8cApwT28RqL5eFMJc6bB+smEGJl0mDYgzcyLD/C33EO1iCiOOxCxUDszuOfZ+l4
         QsBw==
X-Gm-Message-State: AOAM533IdljmUc+T1pC8l0Q59s7aPr70bih2NRMm8VEPNIUNwOmEzRDC
        2pMVLyRSuA1VlHN0R7Qq9AxmCffnVrZEAiXfdUk=
X-Google-Smtp-Source: ABdhPJxMXfU043fbV1qTHbiumSDIVeMAwxPHy65DTRq2PEOrLaj2GfzEzx7WGgvvFlZYm8T9jsJkwY+eoNw+YqG39Wg=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr9413581ejf.341.1619888802655;
 Sat, 01 May 2021 10:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br> <f870040bfb3e73ee8cd27352b0acc65bb54be560.1619818517.git.matheus.bernardino@usp.br>
In-Reply-To: <f870040bfb3e73ee8cd27352b0acc65bb54be560.1619818517.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 May 2021 19:06:31 +0200
Message-ID: <CAP8UFD1dz=u-nXyxSKArP-fAiX6mq3FV+oiiKCHCqbWMMf4TWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] make_transient_cache_entry(): optionally alloc
 from mem_pool
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  struct cache_entry *make_transient_cache_entry(unsigned int mode,
>                                                const struct object_id *oid,
>                                                const char *path,
> -                                              int stage);
> +                                              int stage, struct mem_pool *mp);

It's a bit strange that `int stage` isn't on its own line here, as
other parameters are. And if line length was the issue, it looks like
it could have been on the same line as `const char *path`.

> -struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
> -                                              const char *path, int stage)
> +struct cache_entry *make_transient_cache_entry(unsigned int mode,
> +                                              const struct object_id *oid,
> +                                              const char *path, int stage,

Here also, it's a bit strange that `int stage` isn't on its own line,
as it looks like you want  to put others parameters on their own line.
And this is not consistent with the above declaration.

> +                                              struct mem_pool *mp)
