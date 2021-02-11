Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D8BC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6468664E31
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhBKDFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBKDFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 22:05:34 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A956C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:04:54 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id dr7so172482qvb.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uFrSpkyA0qm1lHO+QvokmCakv50HUYLyxho4W3i4SoE=;
        b=Ay5jZdaHUUIBKxNYVNxVUbjT+QXVXCAyUbarmgsYix1A1uHW4avErthPPYm7trD0NL
         wlyvTnzAOajcQr1ScqZ+8+vA2VTuuaaYp9VbSNiwRKALRlZKfJ285LBp+kf4n+lOweCl
         AKxnE01vJpU+swiQ176pdaF9mofRWEicj9ohsL1HBN/ZQ02l7fcKU/0Yr341cDqMaSyk
         RKJTeZ8julVBes1kh2UiMDt2FTmUIEfVXOWUzv4z25hx0R8pmg2Ib5umvIqQ8W+TAg5f
         59/eLQpjRZY5XsiZqGaY97qpq5wcZSGie50TMnrtx8TPWYWzsQP6mH1/dkLnbbAvaxWB
         KGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFrSpkyA0qm1lHO+QvokmCakv50HUYLyxho4W3i4SoE=;
        b=Jqh7JUpiG5Q+pEE15gGYmowDH7yRMQ7OeR50avmwfFj9K30YmPRieWqZsNiioo9Nsy
         mRFlBmiPTb/Gg3tNpHKOGb2NrEXYA7oOUjhiap25BUmbGLgu7JMalA7K7KOxMg/8ZT38
         5KPIAX62QvOhzfON9cQ/2HTEabet6nHLnu8ZxnXUULh/bIBhT/k7AGBud7xfuV1ZKpLu
         GGPLmHsNTucKCvTQ7vy+3tq1CXCc9dBKB1DZaEb4oDW2+C8hut4A/6UfgxV1kKtCfwUV
         08Szzlhv0gpSMtqxMHiKhMxE3dGUNkTONEPWlrb/Nf+hRVoxLflE3242dt3+N0xN1oFg
         AYiA==
X-Gm-Message-State: AOAM532/l3GJMzW56JN8mmIHve4XaKQ6PqdbjXsbzC/7H+e15NzJ4OiR
        QRB8Kh1pY3hwkE+VsYf22kaW0gojRUO5dCoq
X-Google-Smtp-Source: ABdhPJwizDhiUYCqMCwph5Hu4nn0wsXFyo97Dfdo5caJ5eiDpQGjw97EoS9lNfJkCXEjAVASuXB3qA==
X-Received: by 2002:a0c:fa90:: with SMTP id o16mr5923273qvn.55.1613012693437;
        Wed, 10 Feb 2021 19:04:53 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id o12sm3057917qko.117.2021.02.10.19.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 19:04:53 -0800 (PST)
Date:   Wed, 10 Feb 2021 22:04:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 7/9] pack-revindex: read multi-pack reverse indexes
Message-ID: <YCSe0/OIXisrgNP6@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <4c5e64c5fcb2948a0598d6e0c70097a9561716a9.1612998106.git.me@ttaylorr.com>
 <3680ce51-81ba-d6a3-a0b6-6f3a7cc14503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3680ce51-81ba-d6a3-a0b6-6f3a7cc14503@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:53:23PM -0500, Derrick Stolee wrote:
> ...this assumes the hash is of the same length as the_hash_algo,
> so you are doing the right thing. Currently, I think we check
> that 'm->hash_len == the_hash_algo->rawsz' on load. We'll need
> to check this again later when in the transition phase of the
> new hash work.
>
> (No changes are needed to your patch.)

All makes sense, thanks.

Taylor
