Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486BC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E004122C9F
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLDTQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDTQj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:16:39 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634FC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:15:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so4119303pgb.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MsWiJwb2FGQ5skzW2lCVc+XoaqEL8WbliI/jiibG+kM=;
        b=pGLWct/AN+X3h+r8+0yDi0/84d74abU0ZVjbx+wsEJnm6cld5QZSeE9fo6sOMKYtje
         cqLv5PuWXTHDHtFCVDyE/1TlkoVuHtIaoWw8oD6MIYkdYedozInCs1CmeNddrCL0rM7v
         DslGVkFjXNKmmLGL8v/MnIofvIjm33J9qOOHmZefyA3Nymff/YNIdK4lXjnsxMnGrbj5
         4AwG01mHoVUcSx3ha5dZmS/RNNlPxwsLns2aQjIQyl0KDnhy+I57wMwVqlSwvRCgoyFw
         fpmD8TY4d4BjbUMsp2J2sufg3Db+jbnx2qbUu3jmzHNge+pyTA7r0F1vm4vOUkW45Eoj
         I91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MsWiJwb2FGQ5skzW2lCVc+XoaqEL8WbliI/jiibG+kM=;
        b=dy0VNbV97+O/Ovt4iAzG10nN8TkMNPvOXiQMz9hAOJqDRV5Hd801UTR/u32v76IBgw
         9O3ZUp+1RN/PgId8QGplKnNnKpr5tr9ZAdGpv91x/TmD9Rq0LpnfMFkT5FbEUfFQ9PIe
         /8h56t0aXqF/0ueM8Ai1lGf264Rp1oCwQRtBgitLWKMXm0Q0dkbIMsgqGQ2jQE1Nfu8L
         PDLx8lAsFtcesc+u3SpQ1Q4W1bXDlGdlOehOtynC6jU/fKEn6LCNaLRKpdTOG9WVoLqG
         6JqQZnYksC16TZcLQGNVnkAr+uoG4hzB2+/J3zvlbdk9TJ80uONTBi6Y4aKI3o2KOA8w
         u7KA==
X-Gm-Message-State: AOAM531QBdaUAgAqslGm2D3JAih6qbLQzWAytSh2E8JcQmmqCQ+qYImH
        e5+Zau0K3wrw32Yrz2qr5Kn/UeWpT8xMsukX
X-Google-Smtp-Source: ABdhPJyW6v+IX3vVsI0KYvGHbdA3Tr/AzgvLX/hbm/WlsTsWJ5FOcTt+LsYsDI7+K+MbnXqL7yvY/Q==
X-Received: by 2002:a65:63d5:: with SMTP id n21mr8683588pgv.346.1607109359229;
        Fri, 04 Dec 2020 11:15:59 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d25sm5522057pfo.172.2020.12.04.11.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:15:58 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:15:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/9] misc commit-graph and oid-array cleanups
Message-ID: <X8qK67IBtB3lqSaV@nand.local>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 01:48:35PM -0500, Jeff King wrote:
> This series came out of an off-list discussion about using oid-array in
> commit-graph.c to replace a similar data structure. But I found a couple
> of things to clean up along the way.

Thanks, I appreciate you taking this up. Everything that you wrote looks
very reasonable to me; I noted a couple of spots that might be worth
changing, but I won't be sad if you ignore them.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
