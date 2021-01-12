Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A4C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BE223110
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbhALQs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhALQs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:48:28 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73836C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:47:48 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id w79so2403749qkb.5
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QtlNboPBlGbOYLpWQWBVxcf1Wq7qNYT3XaNW8CPYUEw=;
        b=kMk5fMsHtvsLpNc/sHQBw1Vreo1RHxRvbg5oGZNrbg0wcAQSvF29PAnZDdqUb1w8cH
         Pl/+AakYWXg3K2M1kfZSX7+s7P8y6BoXGIvJyliigguK6A6g/BCrdGE88mIfks9r5/mw
         rXgtu4w0IL2gqz87bQ1d9X2h6jlDTgU4RoynBi2uQJd8OGf5zJn7HlgPkzoRyKK2CeeW
         TmPrh1zndLLePHiVKbDxGPfyb+l7vrxtesLD93v3KR89naU2ZXitgfnX344+rR8cyzFV
         G9A+0S4EKSm7x8J0KxAmHDoDUijYjKDUX5+ZarLjU9ReB2aRQs7yzSAcYVl6IBi4Vy8F
         su6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QtlNboPBlGbOYLpWQWBVxcf1Wq7qNYT3XaNW8CPYUEw=;
        b=hNlkg/B22ANWnTyBZIqiW93E4w7cRFFINp3i5cM5L47uyXgHJt+t9/P87LuR+ovT0R
         FL18coSj5Hd0LSi/sduJibeu0XSHfrqkY6sUphAvWTJV+EdpKR+DBG1esvmJ2l2ld0LJ
         2CRbzNi3PrAAUP3YyzJgwG+PiB6gK21Bs2UXdfkfKF0JiD7fVuwZ8FHXshi4Xy+frL6P
         FuB/s6pG8nCjiHY6Vyy7FmZWoMsAgw5vjUdIDghfVI21H6m/BPK9nNwH3D6IUVpewt0L
         h/maBtx7GqGRWp04Y9eZFQQbQ1OVv02feSgNvhgQDO4r1Arj9d2dmtLliBQTKLk6eLub
         T3OQ==
X-Gm-Message-State: AOAM5332RtBWYTx1sJQRSuBMjYdqS/zZ/tX7/8LMCplVsBXO9mbLW/gX
        ffXa/UmSSOPl70BZPOY3rDJzb6zfvkcByA==
X-Google-Smtp-Source: ABdhPJzb/M5GnWXiTdXlF4jq/+lGoYklKHZPR9yHPTQh0/n+zWm1N7wfLNBUbEO4SmgENCQO4SdMuw==
X-Received: by 2002:a05:620a:696:: with SMTP id f22mr147218qkh.259.1610470067704;
        Tue, 12 Jan 2021 08:47:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id e11sm1374150qtg.46.2021.01.12.08.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:47:47 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:47:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 09/20] try_partial_reuse(): convert to new revindex API
Message-ID: <X/3SsBNNgztxJ24H@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <54f4ad329f56808432549aa885f2847d5c9a8ac6.1610129796.git.me@ttaylorr.com>
 <X/1mpl/ZmL4NPIEm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1mpl/ZmL4NPIEm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:06:46AM -0500, Jeff King wrote:
> On Fri, Jan 08, 2021 at 01:17:17PM -0500, Taylor Blau wrote:
> > Somewhat confusingly, the subsequent call to unpack_object_header()
> > takes a pointer to &offset and then updates it with a new value. But,
> > try_partial_reuse() cares about the offset of both the base's header and
> > contents. The existing code made a copy of the offset field, and only
> > addresses and manipulates one of them.
> >
> > Instead, store the return of pack_pos_to_offset twice: once in header
> > and another in offset. Header will be left untouched, but offset will be
> > addressed and modified by unpack_object_header().
>
> I had to read these second two paragraphs a few times to parse them.
> Really we are just replacing revidx->offset with "header", and "offset"
> retains its same role within the function.
>
> So it's definitely doing the right thing, but it makes more sense to me
> as: [...]

Thanks. Reading these both back-to-back, I agree that yours is much
clearer in describing what is actually going on.

Thanks,
Taylor
