Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E645C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2DB601FA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 03:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhCDDFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 22:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhCDDE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 22:04:59 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C4C061756
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 19:04:13 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so19399637qtw.4
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 19:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mw5Bex3Cz4DtclbLl8ijeilOG32MHn8tVfCbik+5ccU=;
        b=EKM/CedF8l+s0VzeOLEV7q4HX1hzqSdmX2bOZee8mYay7zwMpcKfwg8NUCC508sUCJ
         65jyFN1nM4SaQbv/qW/OJUjVzZ1FOrA5vzmF/hWJZst6giM5XHRzMsgja+3a4AKN2PPV
         n8WMM/LGLjpQyAulFui3G4mLv3vx6cmYlKPI47R7QWqFUWsg/Vs6SvIBBSVSdzg1uA0d
         5Jzhvd/KtzERPxjzNM7njYf7iBMzQooHlLrj+3jl+PsmQ930p7pcQsTV0cMtcMGqBNKD
         gbiWicqoQDQ7Mixbai3Jik9LQIvbKBfq6N4rUL+LC4uSKV68qRTVmmWGXIDqUH5PeNSa
         YdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mw5Bex3Cz4DtclbLl8ijeilOG32MHn8tVfCbik+5ccU=;
        b=MsL0jlfJNH3cA8UcVO3S60bwhFrOIof8jQKdfK+Z3wVK0izk57458gXtNMhMus9/bd
         b01vKVDYT0GHnMGXwv6v0EMWJZ1/ZHwb6B7863G1KqXs+SV8swXzJRDdjn0GZEuc3Qkc
         iLpOhnvSUyjoUg4HlQK1cf434cobT2MkgRJ4i4mDBl8lJufw8z8ZNit6jypWxH1sPbYU
         pFkNVHEWplvnphKizVBEn/f4o9mcXADCwJ+Wbfhs9vmyXFjYNGJwaAmHnlfHbNu9UFsJ
         sPUKslC/GaFYayqiw9/EYuBR6Adx+Q8O4lJkQ6YJYsbnh4bGAukp5re7h3PfpnSnL4Oq
         tdjA==
X-Gm-Message-State: AOAM533mXOO4yoNSW2ic0Fntq4YNXU7j24xbkcv5Z4fSWDKzvWAs3Lit
        /aLUQ0ZtlNtizktmPWUjgUrixA==
X-Google-Smtp-Source: ABdhPJzf8hLOckSZ//zujBFJhtTDqp+lMBgGZ+JdmVgeoITxA8gxrBdNjq3jY0LyZ0itVT+popTfAw==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr2378248qtu.182.1614827052930;
        Wed, 03 Mar 2021 19:04:12 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:661d:484a:c652:586b])
        by smtp.gmail.com with ESMTPSA id e21sm340896qtw.63.2021.03.03.19.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:04:12 -0800 (PST)
Date:   Wed, 3 Mar 2021 22:04:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 08/15] midx: allow marking a pack as preferred
Message-ID: <YEBOKpaD1gGXRTvp@nand.local>
References: <YD6NVxDib8ccf/6Z@nand.local>
 <20210304020017.1802260-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304020017.1802260-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 03, 2021 at 06:00:17PM -0800, Jonathan Tan wrote:
> > I
> > think ultimately you want something like this squashed in:
> >
> > --- >8 ---
> >
> > diff --git a/midx.c b/midx.c
> > index d2c56c4bc6..46f55ff6cf 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -582,7 +582,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
> >  						  struct pack_info *info,
> >  						  uint32_t nr_packs,
> >  						  uint32_t *nr_objects,
> > -						  uint32_t preferred_pack)
> > +						  int preferred_pack)
>
> Why this change?

This was wrong in the original patch: ctx.preferred_pack is an integer,
and is set to -1 when no preferred pack was specified.

It's certainly unlikely that we'd have 2^31 packs, but silently
converting a signed type to an unsigned one is misleading.

> The rest makes sense.

Thanks for taking a look.

Taylor
