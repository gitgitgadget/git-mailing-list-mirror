Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94BAC4727E
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 03:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A7D208B6
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 03:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaD6f0XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbgJBDSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgJBDSs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 23:18:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B28C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 20:18:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so22593pji.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uAj0Iq4WWmCC+qLp8viB/xZicyxee/Nsa/FkjWq1/Jg=;
        b=RaD6f0XLKl0sgMAEC163VGpazWN5qHveBaYakIZ7eBSBdKz4hHU74+/ZCIW7irQOMT
         ae9ygfxirwYqxGP4X2b9m83FUSEe1bNL3htpp0VeapccrwNarT7zhgExvPXyqq00xTp9
         xplZNkSb/yiJwK4a7rxlDzD5dfULKkpZbDIgg28z2pxyyDNCQDBIDioPjik0IHMRD1Xu
         VomlQXTMhzlxOsLNii6n2mxtYirEvze1GwU0Uu+1+5f/ClSVwgzVuUoWgHh+p7+b98bA
         207h0ecH8mLLQsrfuVzQB2ijG4jyeHO8rngdcYUinfCHLIefDLdTpBu131pxaOdebYU4
         UrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uAj0Iq4WWmCC+qLp8viB/xZicyxee/Nsa/FkjWq1/Jg=;
        b=OIWMDeVIbOminoGlDS+jVEPiQW3Q+dxQtwPiMfkYbUiZDTYnvkWqybAwteJj8ndDSx
         LZAxsTWUIXK/xQWUV/STuIuuKjgbD7J7VTq+HvgfCRnNqsTVOd9lq6v4YCjITA6Obm6y
         zMd95apSOy+RYgsm321AAoJzWD+JwPkkYj/tT1Ekxh2MlIusgtUyyHBFakBSOD1AlUWB
         S86ioqWi8pxg/wPfMAmJACyLCI0/mXUQ8J6HZC1zTylenY2tstK/qx70Omq08yTh9N1v
         D+JULFF3947jE0o87f13mEbUCr+NHEYQyyiqEeZAgWMTYgu+GcTRBKzdrcalEH+lSAeL
         3zxQ==
X-Gm-Message-State: AOAM530zBQPnKualL5EJYftD6tHcBubT1SM8kDxse39RWrZuUryl/WMv
        CICuaKSLQ6vUx4Z+HjoWFVU=
X-Google-Smtp-Source: ABdhPJzOgEP9uKUinjPKYKbOITkgT+vS2HJUylib0mBAPTMe8dObMCZEN7/jALr8J8TeFq0J3AsKfQ==
X-Received: by 2002:a17:90a:7487:: with SMTP id p7mr459814pjk.189.1601608728138;
        Thu, 01 Oct 2020 20:18:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id n67sm97270pgn.14.2020.10.01.20.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 20:18:47 -0700 (PDT)
Date:   Thu, 1 Oct 2020 20:18:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 01/13] reftable: add LICENSE
Message-ID: <20201002031845.GA3252492@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <6228103b4a6dab23ce3a4498eada8ff649909ff0.1601568663.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6228103b4a6dab23ce3a4498eada8ff649909ff0.1601568663.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Han-Wen Nienhuys wrote:

> TODO: relicense?

This line presumably doesn't want to be part of permanent history. :)

Instead, it can say a little about rationale.  For example, does this
make the code easier for other projects like libgit2 to share?

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/LICENSE | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 reftable/LICENSE

Should there be a reftable/README as well?

[...]
> --- /dev/null
> +++ b/reftable/LICENSE
> @@ -0,0 +1,31 @@
> +BSD License
> +
> +Copyright (c) 2020, Google LLC
> +All rights reserved.

nit: Google seems to prefer a slightly more spartan form of this
license text:
https://opensource.google/docs/releasing/licenses/#bsd-license-file

Nits aside, except for the TODO line, this patch looks reasonable to
me.

Thanks,
Jonathan
