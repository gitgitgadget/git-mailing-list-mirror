Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C9BC433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B932080A
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZY5RTmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIFTZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgIFTZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 15:25:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9AFC061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 12:25:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k25so7603870qtu.4
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDZdX2Cdwj7+9cT+3Nsgwp2uT8FrnDRQc3WWymYKp6A=;
        b=pZY5RTmZNGEz5UsTGPLf/MVR8SYxEPfyBDgblqeTMznZAFiKHf5Q3Hk8hF3MQBgwf4
         3GIT9RAVx85uDzYE6d2QDJCxRDQ5pv/pyyf2fNOSsKdlX3+96NypmhxCjgjc3EYF4ZuJ
         sn+4vm7b5eSy/shzivH3XtMsoemtonVaxS9XwVC6yVUfpge1jrvg2yEiGfLt103EQOoC
         hhB4CWxMPFp0WH3LEmQ5HSTzsH0OvzfGFA8HJWCmqLiAQY4ZKxx6qFS3TTI0JmJmV7C8
         MbJ91kpsCpQbl/++MSk0nphaoY6OhhvwjyRtahR5VTTXX/RVFrt5rmRSb5hoICJ0lfzJ
         xp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDZdX2Cdwj7+9cT+3Nsgwp2uT8FrnDRQc3WWymYKp6A=;
        b=Y3zRrtuLus/EkTZVIQCVvbIR794qt3DSYg4tgvR89sf/M5U1+W5clC3UpIJxSk0ynj
         bVyVNImwmrQ9mM0Qt8gunPzMw9x1dQUhYK8jNmw/wKJ2RBR2gc5lU/X7ynWKNdfZ31ap
         YbaQh1hHAd4oCNB0b9R63YQcNBxx1H1C6+mKs5zCLpSu3ZRKcFUTUSdhi1BDzgzy6rGX
         0GHwFxZx6k1rQ0WP8oP4XCvgV6PDq4SA9QWu7fh+JIiB8GvAarVsmCi4En1r+urFj7fC
         Vjx2bdatCeLKrop5nxeM/yOg3tfPJ/u7zOsdSPhVi1C0ynKA11ykmqsp+eDpBUXdcTeZ
         Ln/A==
X-Gm-Message-State: AOAM532MsdGW8zwuA+JRuHMDZHvr8DytievXykUhCrqkAZ0AGYDtRIZT
        qsJvxE9ooCFYqEKU6i1jCTGhGzQ3nl+srKDguTAFR048
X-Google-Smtp-Source: ABdhPJzoFqPBAkVREcjHHD3dOcqjYAf2XpbdbkRBg1G01PvSGlOYlFF7EmWaiM/7gPhRGUdjS8Mwr/DkWDsoQvfP1YI=
X-Received: by 2002:ac8:202:: with SMTP id k2mr2749911qtg.359.1599420339308;
 Sun, 06 Sep 2020 12:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.725.git.1599231196975.gitgitgadget@gmail.com> <pull.725.v2.git.1599370473141.gitgitgadget@gmail.com>
In-Reply-To: <pull.725.v2.git.1599370473141.gitgitgadget@gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 6 Sep 2020 22:25:28 +0300
Message-ID: <CAGHpTBKduYnWymtCYR0AAdYy4rhXZgQkrUiHu59bpNX5UDEYfg@mail.gmail.com>
Subject: Re: [PATCH v2] submodule: suppress checking for file name ambiguity
 for object ids
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 6, 2020 at 8:34 AM Orgad Shaneh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Orgad Shaneh <orgads@gmail.com>
>
> The argv argument of collect_changed_submodules() contains obly object ids
> (the objects references of all the refs).
>
> Notify setup_revisions() that the input is not filenames by passing
> assume_dashdash, so it can avoid redundant stat for each ref.
>
> A better improvement would be to pass oid_array instead of stringified argv,
> but that will require a larger change, which can be done later.

I'm wondering if it would be possible to track all the commits that
were received
via the transport, instead of resolving them by ref changes, because resolving
from refs requires excluding all the previously-known refs, which can be a lot.
Our repository has ~35K tags, and I believe there are larger repos out there...

What do you say?

- Orgad
