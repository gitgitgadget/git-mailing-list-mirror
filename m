Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A389DC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 13:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbiHSNcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 09:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348643AbiHSNc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 09:32:29 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271CEEF14
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 06:32:28 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3246910dac3so120805867b3.12
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iX/KFxEI3TV+DWCmWFGKMuEsZ/YX5QqaALvrvSpZvZI=;
        b=HmCwcoFHCaoZuxAsy1Rawkqb5UWU13/t9zFcVyWzKrRBCcMyZPIY4aQ5AU0EkAg6Zq
         rdpwWKWVuokF383COeDblf8Sjceyd7AHjPlA0PMHwDxG8u0KQKHE0dhQr9JZrvH9ciEu
         VgCabEBhdSrptNrxcbOKFntYZOBqIHR/6gXObxiNYDiFkUdLLP9b3n2RH16S0tFfdLlH
         WD06TJO5wdutZe06IprE4Zb+1BX+0b1W8Sitc2EH3brpueF5dBPIWFDo83+Ge5hmhyJd
         WwPwP6kEDH5yEKoVBsMndMqNooJWHmbn57JoBurF46AgPVBe5t/OMSeV9v2UTfIg/99p
         ldlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iX/KFxEI3TV+DWCmWFGKMuEsZ/YX5QqaALvrvSpZvZI=;
        b=Hz7CNpT+KW/VLjz7XDhaYmIB8WY0UJ25Sro6CF8Wfndch6RCvpBL8zpzpkBqU8zQPC
         4Ox4ltAoncKnLZZ42vXV1qxvHnw1djSAXC8VyLUSYocSojyiLNXN2WJImoL1x8VZm+h1
         uSvFs6zog4pJYuvx6bQSFLX6eyP7bdEGTc/aYVj4WXFk7vKY7xkDX3PHyT5uo4mvS4JD
         Xeu936aKijMJku4mpfqWGP0RlqDqvG4Lpb1UK1qrjDogZ6i3OBsZIjx0rACgUGXovVrp
         kHw6oi7t+bwgOPqy5snB6Zli8PhIiHu95GBms+FLaY1WcmwNaTBnjIWhG1B2xFhoaRUW
         Cv4w==
X-Gm-Message-State: ACgBeo3HdkIW/OxRQkJS9zfWfTcF3OSc31ZSJJsNShcct+F6IlrM70WV
        YapQ9jpwYNJTD+KejuDKITe69OSFq5X5FOBU/7Cfckj8
X-Google-Smtp-Source: AA6agR57GJKVIbrw46gKOp+f8zPKsH8XTRmPDHJ9AHz/qen4wu2gGFpHLYUXdubOPb/7UrbHmDqmNMHHU0OJHpWaPG4=
X-Received: by 2002:a25:c81:0:b0:68f:287d:453 with SMTP id 123-20020a250c81000000b0068f287d0453mr8260916ybm.191.1660915947530;
 Fri, 19 Aug 2022 06:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net> <Yv9OpXIQ9dYMQJ4B@coredump.intra.peff.net>
In-Reply-To: <Yv9OpXIQ9dYMQJ4B@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Date:   Fri, 19 Aug 2022 14:32:13 +0100
Message-ID: <CAPoeCOa6BDsunamy7_GtaSy-gL_0r3kAwDJ7ffA_uiFUzhen9w@mail.gmail.com>
Subject: Re: [PATCH 1/6] xdiff: drop unused mmfile parameters from xdl_do_histogram_diff()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On Fri, 19 Aug 2022 at 09:49, Jeff King <peff@peff.net> wrote:
>
> These are no longer used since 9df0fc3d57 (xdiff: fix a memory leak,
> 2022-02-16), as the caller is expected to call xdl_prepare_env() itself.
> After that change the histogram code only examines the prepared
> xdfenv_t, not the original buffers.

Thanks, I seem to have a blind spot for unused parameters (I think
this is at least the third such fix from you for one of my commits),
I'm really looking forward to having -Wunused-parameter enabled,
thanks for working on it. Looking at the xpatience.c I think we can
remove the mmfile_t parameters there as well, they are only end up
being used because patience_diff() gets called recursively. I'm about
to go off list for a week, but I can look at putting a patch together
for that when I get back unless you want to.

Best Wishes

Phillip

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  xdiff/xdiffi.c     | 2 +-
>  xdiff/xdiffi.h     | 3 +--
>  xdiff/xhistogram.c | 3 +--
>  3 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 53e803e6bc..8c64519eac 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -326,7 +326,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>         }
>
>         if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF) {
> -               res = xdl_do_histogram_diff(mf1, mf2, xpp, xe);
> +               res = xdl_do_histogram_diff(xpp, xe);
>                 goto out;
>         }
>
> diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
> index 8f1c7c8b04..9d988e0263 100644
> --- a/xdiff/xdiffi.h
> +++ b/xdiff/xdiffi.h
> @@ -58,7 +58,6 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
>                   xdemitconf_t const *xecfg);
>  int xdl_do_patience_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>                 xdfenv_t *env);
> -int xdl_do_histogram_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
> -               xdfenv_t *env);
> +int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env);
>
>  #endif /* #if !defined(XDIFFI_H) */
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index df909004c1..16a8fe2f3f 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -362,8 +362,7 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
>         return result;
>  }
>
> -int xdl_do_histogram_diff(mmfile_t *file1, mmfile_t *file2,
> -       xpparam_t const *xpp, xdfenv_t *env)
> +int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env)
>  {
>         return histogram_diff(xpp, env,
>                 env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
> --
> 2.37.2.928.g0821088f4a
>
