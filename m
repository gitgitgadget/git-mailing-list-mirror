Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434EEC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E626112F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 05:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhIUFUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 01:20:06 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF07C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:18:39 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id k10so18968447vsp.12
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 22:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mukzmUr2fAfhpZCoG6ziJkzxzeraEZn5pPfBja9srY=;
        b=U5wNelq0CA1jCspocL9IeZ/m6peBa/lEDhC7s5Ph8erNHNDfJmyq2QIU2Ww2fnGM6V
         SHo/fDZ2uFUCz6voducxRHsnsoW0J+CoXgcW2Xj6MswDuG5tMh1OVLut0qfjvtRmLyu9
         D68pxv/jXuvUxFZvRDy+iC2z91lEo9nArZbzdluqNlggdhfAFC9xk0eKpTn9TPrbBa2e
         XTENmHfnnsTbZw3kmNdupFtm9E8nRlubw2BpJ8BFcayasl/HuDuF6PWKrlwRhn2ThZdr
         hE1kODByrIm7Ssxxlk1UPRMQA7JNtLLPyHwj/BNBzYvGW58hNJkr0sN/l3PGahtmQi7U
         R/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mukzmUr2fAfhpZCoG6ziJkzxzeraEZn5pPfBja9srY=;
        b=vkpvwTlwwfxL/HBc7IoydTjkX+5b3fDUFc1/qgwkQ7sinEpAHyqMX6rCk2F0Lh1uEy
         yR92by5hBZAQ9D5fcBPDqQUvzb6ZZnI1mrCkJlaspKnPAMA7E+1KKuWEakLWQdONIj/p
         ZqsIVSsCaC2AuOxcqIx3W6n3ntJzp0PVzlQzaqEfRU/XXjGdB0Btx4Gh+zPuzhUCZBuX
         3RlOz1ZTRI/0aP0PC9Y6trIV+gI4sHjuJt5Bp4snrjF7B4TxHHVaw0KLXbieUsILnCds
         jYEybe+02KAVis9IEFWftAih5xU9YiZp5ZP8Z1lqESUjg1FMd/f4FPSf/89/HNphf5YP
         QZCg==
X-Gm-Message-State: AOAM530uZILZm1MZLbHTlcMHWHAiCiEo//J5wXsQ2GJOnN5THt3IseRg
        1Xle4jRD6iYXEc3VFTXx/2Fg6O9ANR0IRoFcCpU=
X-Google-Smtp-Source: ABdhPJxOiRTNNtNXyZaznTwz7zf1gkGPVwHvsk8yaHOdMGZMxKJhHH1RGOjt5m8IGZrHm0saHJks7Gqxmifh2UayN6U=
X-Received: by 2002:a05:6102:285a:: with SMTP id az26mr7384607vsb.11.1632201516858;
 Mon, 20 Sep 2021 22:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net> <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
In-Reply-To: <YUlVsLkFGRfRqpKG@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 20 Sep 2021 22:18:25 -0700
Message-ID: <CAPUEsphSyZB-vtubjYhN_5Gy3Zv0HQ=fH=+G8kMYzJyrOLXPxQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] grep: stop modifying buffer in strip_timestamp
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 9:09 PM Jeff King <peff@peff.net> wrote:
> @@ -971,7 +966,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
>                 switch (p->field) {
>                 case GREP_HEADER_AUTHOR:
>                 case GREP_HEADER_COMMITTER:
> -                       saved_ch = strip_timestamp(bol, &eol);
> +                       strip_timestamp(bol, &eol);

Why not something like (plus added error handling, even if it seems
the original didn't have them)?

  eol = strrchr(bol, '>');

Carlo
