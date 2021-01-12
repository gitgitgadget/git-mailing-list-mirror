Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B903C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E172311B
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbhALRA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388731AbhALRA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:00:26 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8439AC061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:59:46 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id c7so2467915qke.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2LEW1PyhgKxM/qgf+1WrRgVPMa3ysdJ6mH5h6ssmvA=;
        b=YzRKi+sU/MOj6uGPZnCL80QKd1jR/PWt0hwbmSSereCaHwTKJY/R5eUcimRYr+dA75
         XpQaXXh5SushY/mtMuCrIAKJ8GWK4o6oVFe9mR6POxCKQcou22Xg8Jo03rkBF858aehy
         aqEb89+EsEnGWd3YOnL2H7vY5z8hNuoanAesTVUadFsroMplgY6XC8VQ4L5UcsrmwbRM
         HCOp7ths9Gg/P7j2M5WxsSZTdn3gou0BnOSUBKXtjpy0B7wxkwtbykoTQ1uVDYGu0r0b
         3JKBG5y50D4Nxku9d9YR+18n8+ZNb1zxrNSk3WBSMibykDG+pYnoqdRzg9MY71tTIefJ
         XdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2LEW1PyhgKxM/qgf+1WrRgVPMa3ysdJ6mH5h6ssmvA=;
        b=M4MV4ondIqb+oq8COCEn0DtMa679dne7+e22LOLdybaxxO9+4DA098rtlpOCENP04z
         YY6XACzpEN4RqPsGNXM/E4zHcBzbq/xgqZj0TjQFd1V4l2rf5oNP0aYcHKwyDpNg4P8c
         rmG3zS0mQgzBCbsnXRzMniGxqhanwkctzLupK5UIMV/iN3p7ZinF8pVNgUa9tOUfA8HX
         1pLTQOmvqdppferRE5ppZBFxa081PdgN82QfarAirLF6aP3z1u2kv7aW5uRmfhxjc1H4
         lG92TkYvDrIILqpu6PDxnSuSKWVJpDRCwAiAfKpqvGzZeC6r18nYYiB/sfiEFV4WYXoY
         rYnw==
X-Gm-Message-State: AOAM532eW5XUXPn0blnqYjKpfsWn1TGnFk3hAu7BGvdU8a3APTWlk+4a
        nzCW0B/S1zkSjO9BRF1hLjfeag==
X-Google-Smtp-Source: ABdhPJzBph+eL2grlF64/do3CvMKkh6QGFoRKNbaVF1J4Q3XGbO3GZQAWTgmKTjMMJIktYvIBA9haw==
X-Received: by 2002:ae9:f402:: with SMTP id y2mr238040qkl.356.1610470785823;
        Tue, 12 Jan 2021 08:59:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id h22sm1333070qth.55.2021.01.12.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:59:45 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:59:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 18/20] pack-revindex: remove unused
 'find_revindex_position()'
Message-ID: <X/3VfteeF3Ok2C+S@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <d60411d524656f4680ac578765b2a8704325a060.1610129796.git.me@ttaylorr.com>
 <X/1st6SrJXysoejt@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1st6SrJXysoejt@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:32:39AM -0500, Jeff King wrote:
> Good catch. We might want to drop the initialization of "lo":
>
> >  	int lo = 0;
> > -	int hi = p->num_objects + 1;
>
> down to here:
>
> > +	hi = p->num_objects + 1;

> to maintain symmetry (though it's quite a minor point).

:-). I agree it's a minor point, but I think that the symmetry is nice,
so it's worth doing.

> I notice these are signed ints, but we've taken care to use uint32_t
> elsewhere for positions. Shouldn't these be uint32_t, also (or at least
> unsigned)?

I'll let both of these be an raw unsigned, since the midpoint is already
labeled as an unsigned.

> -Peff

Thanks,
Taylor
