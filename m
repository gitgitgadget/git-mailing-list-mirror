Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C30C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA48B60FBF
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhHRJo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 05:44:56 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461BC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:44:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id f6so1383246vso.5
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mv+3nVmgLBO3s1ViJJwq16rx7grR+kwtk4VI+ye1yi0=;
        b=ZmR9+5grYswY+Eu2uzqz39mLI/4qatTXLNPGKNouB7d6EfvE8sidpONIqB1Mn0W1KS
         SXiAgqm0oosD5ch1+NvWkluOGlx+hIYSw68nfLGz3rUX4hQr6suGdgD56gu6WhAhBglE
         99cr9lKfgTtzQTkva8njaFj/fr5bgh9iiLtSeZeN/6EtIyEyOHnwc9WZJk9Xjqti/d7e
         ECQmNhHuCLCGftvtNQZRYlkOXl6b913pd2/bCJ07e3Tp1D93q81Ol23BjVb6XUhdgt0D
         jVGalo8VnYLAdPybiV9fxvSJekNdYcKacQ6ck7VWPakIZAAK1cEEF4gAGPjgZfHH4OZf
         8j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mv+3nVmgLBO3s1ViJJwq16rx7grR+kwtk4VI+ye1yi0=;
        b=d6hE1CpSyzv7X510SjHArDQMnl18u3N/5io0zDim+VOziAdyWY5Wnpz+rRrGXE8c9K
         tz5AgVHvxs6U/2LysB0Ks/14HeToYjMJE6edoSRdVSdmxFH4xzVkPx/FtczPkRh4NarQ
         wZf+mS823s+SdTeU6A8MgcVeca7GCekse8B3p1c/xwR25hShRYa2I99B7qpxVH0NjHPf
         FdMNrOdZe7tmvPM1rA/YNZ3ur0LcfTQR7EPHfWiQ8nZFR6px4MF87/WZZzXWZ4xafFcf
         Huxac2ITw2HnQl6ruMG1UzjCUl5q3Y1cragmlhNIwB4fpUrXLIHIqBmT6f9hPWl9oLvX
         jK8w==
X-Gm-Message-State: AOAM530c29xbiXi8CaeEQB8P2OCLjNUK27CgJCV04c+0gbxLTAZKYzOX
        oGad4mqbfFjLX76ekkJORX9GRnwZhNKdVeoW/SE=
X-Google-Smtp-Source: ABdhPJzrgLrCzQO2ZWSa/0D2gLnlchzzn1jxemKOXzoy2aCmja2yp0GCyCqL/gMdtDOKgCdn6X4UVztTQKtzKn6NP8g=
X-Received: by 2002:a67:fa0b:: with SMTP id i11mr6661865vsq.44.1629279861264;
 Wed, 18 Aug 2021 02:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210817082310.2157-1-carenas@gmail.com> <a5468146-aa26-62a1-2c7e-e35fa73ff041@jeffhostetler.com>
In-Reply-To: <a5468146-aa26-62a1-2c7e-e35fa73ff041@jeffhostetler.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 18 Aug 2021 02:44:10 -0700
Message-ID: <CAPUEspgreQEs+N2J=pWXm83Tv=D2xKbujFs5OQZJkmMoP9GENA@mail.gmail.com>
Subject: Re: [RFC PATCH] fsmonitor: fix building with NO_PTHREADS
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 10:56 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> BTW, what platform did you detect this on?

macOS, when building with:

  $ make NO_PTHREADS=1

obviously not using the defaults.

Carlo
