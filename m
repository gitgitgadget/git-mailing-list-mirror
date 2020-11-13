Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8DC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3024E22252
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="b8qdLa0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKMVaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMV37 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:29:59 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0457C08E9AA
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:29:57 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id x13so5373679qvk.8
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rbrjCQjQhn5goPJfYS5Ci6QHV65myp9vDlqrR4bk9fM=;
        b=b8qdLa0z33FM68D3cZfWrYNk8Gm3t35REBdSFuSnm74z6fmkL8qMCxGTn+BPSdoLqX
         0++rZ8RBg/GjGYp6eQHRnJlMD0QRCDZR0tTW/GUGhiWxY1l265QUY+ILGD2LW6UzrXYq
         2Zn9aeywlcBU4uy2KOpsyoiM9YTDOOFHik5S4sXhr+VddO+me1VVY5Hvu3NfBwBW37aB
         2JDuvWsVCR72SEx7cch4zk/igvEMFT3UatiIVFrKi+3I9CQcavsUw9A2T3wBEELAT9Gp
         7MFwb0BK7/KENSMXHEyozI8H6G78/OMfLSSBZalkmRRq1ZsI1R1Ft66zIqRDN8vFChfh
         1HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rbrjCQjQhn5goPJfYS5Ci6QHV65myp9vDlqrR4bk9fM=;
        b=GK6Qz9qnAXk6iQh7Bgwlh8BAJ4hL4taE6uYrGBQlNIrci4TvMYGSRsFfYFBgdcJME9
         8064mm93PpavkY5rAfXiHIypZAZ0mtU0reL7vKYF/WfE9hi+D/GoeZ7NPWXaqTffUvKy
         G1IYSk2l3VIayPhwOLLoYs1tDsTUPWZNcGKVjYoJwTbSFUxGTwTAd8BU/BN/agBkUsVL
         gKDaEZYhX3nA53z4hrnymJtm/XQ3EAsLYWUSdqtGZxD1Ycdz0uUiPPSRzM/M3drtvcZn
         +yrv7IbX08jkTVTgW3oUHARgMSyyVh2AjMM0GfFQatH19jNcID5p51ulBe7RrD8Wsohh
         mIkA==
X-Gm-Message-State: AOAM532U2VR6mbGenREhMRkNPzEfKBtBB5JXykAVFjScaqW/OF7rI6Lr
        zxzUeRp1AdNWUbOahrzDWdEHSA==
X-Google-Smtp-Source: ABdhPJwjUQKkN6ugpmyq/VK6kXH0Rrx6kExwtAzsucU9ZxJc5GHChlY66jd8OPboOK5rTV9yfz6GtA==
X-Received: by 2002:a0c:b664:: with SMTP id q36mr4367065qvf.6.1605302996809;
        Fri, 13 Nov 2020 13:29:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:51df:232c:7a24:7fb0])
        by smtp.gmail.com with ESMTPSA id 72sm7865157qkn.44.2020.11.13.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 13:29:56 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:29:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/23] pack-bitmap: bounds-check size of cache extension
Message-ID: <X6760infcF0hRYTG@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <1573902df00e8a14a9cb68c37f55474388b1dc2e.1605123652.git.me@ttaylorr.com>
 <CAN0heSqiiMZgT+rEgWVVR_cEmPK2bS3QNnJuHahrqVQet7_Qug@mail.gmail.com>
 <20201113045700.GA743619@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113045700.GA743619@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 11:57:00PM -0500, Jeff King wrote:
> On Thu, Nov 12, 2020 at 06:47:09PM +0100, Martin Ågren wrote:
>
> > The addition should be ok or mmap has failed on us. Do we know that we
> > have room for the final hash there so that the subtraction is ok? Yes,
> > from the previous commit, we know we have room for the header, which is
> > even larger. But that's cheating a bit -- see below.
>
> Yeah, I agree this ought to be checking the minimum size against the
> header _plus_ the trailer.
>
> I think the previous patch is actually where it goes wrong. The original
> was checking for a minimum of:
>
>   if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
>
> which is the header plus the trailer. We want to readjust for the
> MAX_RAWSZ part of the header, so it should be:
>
>   size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
>   if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)

I'm not sure that I follow. If you apply this to the second patch in
this series, the only thing that changes is that it factors out:

  index->map_pos += ...;

into

  size_t header_size = ...;
  // ...
  index->map_pos += header_size;

What am I missing here?

Thanks,
Taylor
