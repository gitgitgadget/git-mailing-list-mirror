Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B0C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6192086A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="JxrPIb6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgLAWXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgLAWXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:23:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2FC0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 14:22:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u2so2001955pls.10
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ERaNST2eL3KTDNyymjYLCpTjMVBNyMj50wCUAM7+m2o=;
        b=JxrPIb6CR73XABMDHcGH63P/lRVIFqD6rhl+oIT3jStx8Y3rVH3G4doh7qWNkJ8U7t
         2fyesGp+yLeno5Sc2o3ZonHz2HM1TVP3k26mU8xaUSVgyoKE+YCInCp6IW2NGc2jPMKn
         sCGDtNcPw+QoC7N5Ng1JH9Js1cXt/6dxULn/AIhZHuJAiz/KZkvC6fN0ruDhQrXHo9SU
         wLUN9ptRr/YInJTidvr6KZY1Mc/yGCE3877BOA9vj5B48HvYFb8bDassMcqdJNE7f+mR
         LYfJf4tdLa9vAPZfk6ZJznZnsDh60T1dnQMqFsXZUmHxAvNu1chGGMIjBNSvtOIEawxl
         pZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ERaNST2eL3KTDNyymjYLCpTjMVBNyMj50wCUAM7+m2o=;
        b=eZ92o8AeCcSx9GcrgsT7MF5HU2DVYpRsXpUojLGWw9mugkpCVGtb2D3AVKR0IBUIgV
         2OtBjGl7wwSTkuMaXT4tnnsJBIFzGmRaWWpocP6HBsgTk3gO+2sGRLpjvYeGW+IARibb
         0dPZciqDoPiilbtepq9zcGlzO65Wl6qs466niNuJ+tvoWXpA+casthIyzPeBDV4sJylI
         M2NzRHzd0WgN6+AMZcDp+8VbMjCHY+ofHVo5gO5mjdCODx1fBY7yG3l6eUrv4RKUq3sc
         zJxmcW5jl5g4Lyu7I+4gQkebuonNN4Ap9sCzqidi2oAzQe9qdI6O7b0+PfyTz7qTWcsa
         8loQ==
X-Gm-Message-State: AOAM530LuDOnPb5qGKiiBeisTNO4du3yVMzrPzcwq3JesmKnpi6+lhe+
        UeZ1y5UNk1Lwty3ZNx8c7wbfNg==
X-Google-Smtp-Source: ABdhPJxTJav+s9yEuVSR/LcrnVAfHbVqcl91C7vfSGRlZb1uOYFMoT3xJMoJLtkCxCvMJbHpvYbD6A==
X-Received: by 2002:a17:90a:7d08:: with SMTP id g8mr4863509pjl.180.1606861372681;
        Tue, 01 Dec 2020 14:22:52 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h7sm723991pfq.76.2020.12.01.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:22:52 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Tue, 1 Dec 2020 17:22:50 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] banned.h: mark ctime_r() and asctime_r() as
 banned.
Message-ID: <X8bCJ/ZukppAsoTY@nand.local>
References: <X8aMt2LEiCLkdV9/@nand.local>
 <20201201211138.33850-1-gitster@pobox.com>
 <20201201211138.33850-2-gitster@pobox.com>
 <CAPig+cROG5+khWvBWbWgVhNuDyWkCQYBXwte5VeazuCCXMAA_g@mail.gmail.com>
 <xmqqzh2xmb7o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh2xmb7o.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 02:07:55PM -0800, Junio C Hamano wrote:
> > This still needs a s/conveinent/convenient/ mentioned earlier[1].
>
> AH, thanks, fixed.

That was my only nit, but I'm certainly quite happy to see these get
picked up.

Here's my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

if you need it (which I doubt, but there it is anyway).


Thanks,
Taylor
