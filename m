Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0DEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E876961100
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhIUUQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhIUUQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:16:02 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472FC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:14:33 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id n17so505971vsr.10
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3zTugPPMV5GdUOMukHk0km7jM2CgB+GSX0ovQ/6A+4=;
        b=Q6WVkNgcg8cvXxEmu2cDb4z05UsTbAhsIJiKDzdlWg98G/JO8iPrBoxJzCnvDcs/kA
         17MuFPv+yC/h+VJkgf8xHq37YRCoK1xB5+lZ1CPRb69EsPmKBgfCncvLouF7FE3Rwao+
         nQZxxyZXoaxyTJ0/9xidnk/yJsvHHqk0OmgpMzIzXUYfboae4+CnMc7vy+OMLDtC4gZJ
         74l6smCjyRvZp8iEZ49KkOmx0vHSPB6n/fKR2eOxROZ0tYAm69/rg7kTiPSfC4qi7Bno
         dmOphp9mgg+1Gl5rSmlXdtOssae/kUfNCeOdlb4ynkNk8CeiVhzIRhfZlOb4DA0KCPHE
         J2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3zTugPPMV5GdUOMukHk0km7jM2CgB+GSX0ovQ/6A+4=;
        b=uLe5SVDDRi47qrCkndSd1jMkJOHnWu93Jnmhrvc+8KVV/PfBz+V8cGqpdgTLcdjYc2
         NlwUh8w/3Vba24oPnDrWfjIk890FB1hdQbbVqLaHoIMrQbwJgbSOUKdBfOLZxv3ttOV+
         7WfgKToj38HhJ9NBQQbZ2bk96TZR78/n+RcAbc2YKFObHT4aKoe1FwYHQ3TFnSN8V080
         4c0zxk/tsMQ+1nbu6BdZMJ4UOp318lpOHtn+RitIdauft2dm7Gx8btDhqM5v+9OewT/C
         5msrH9gSnRuE9RJHdh5WieCpknjjqI3kH+PXyeGIVHHB/L8/7uzWpz6xN5ivHK4fEv4V
         aXAA==
X-Gm-Message-State: AOAM53048nAnBHgY1akRFxFsFqbMmlZjb4HR335f3FjFicBDlaBwu7Ck
        FfzwR5DgPpAhkgJ+mYz68RBQerpskKDgEBY0f14=
X-Google-Smtp-Source: ABdhPJw1tzZZr9dXsGYUjYVo/EHsXG83MhyPuP3ARtDSx1L1tTBVOXeMqryQuQWVQT9SIG4YjNlcMelc6fztlyKq5Is=
X-Received: by 2002:a67:d51d:: with SMTP id l29mr22075176vsj.46.1632255272316;
 Tue, 21 Sep 2021 13:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net> <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
In-Reply-To: <YUoorS6UwA1DmwBm@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 21 Sep 2021 13:14:21 -0700
Message-ID: <CAPUEspgrqxrhp-5diEenH+vevWi3QtxpjPqTwDuU5J-JHOXg9A@mail.gmail.com>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 12:48 PM Jeff King <peff@peff.net> wrote:
> But certainly I found the behavior surprising. :) I'd guess it's because
> HTTP/2 is sending some binary goo instead of text headers, and the names
> we get are just coming from some lookup table? Or maybe I'm just showing
> my ignorance of HTTP/2.

AFAIK headers in HTTP/2 MUST be lowercase as per the SPEC[1]

Carlo

[1] https://datatracker.ietf.org/doc/html/rfc7540#section-8.1.2
