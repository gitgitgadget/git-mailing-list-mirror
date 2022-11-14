Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EFEC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 21:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiKNV5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNV5v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 16:57:51 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9011F5A0
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:57:50 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id bp12so6461222ilb.9
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyPWje0SHJPh/6S3qAxplmlfv5TxMzKjiiMAmeCGY5Y=;
        b=vLWpZaOFYJrPgp7sWoPHtdpnS0REWON47PnK3fAbI+EanD1Kv4v0mr1PIBIwaEXe8P
         VgsmoqfsNc9G9Hs9enj7VJsqDqTuiRLFefXp7hTEuRSfEOELcFbqwr331K6zqAGm9Yj4
         s2GRXMUomEMHusOpdc/ZXLVRXXBMkCJFkRaK6oC/KHzr8ebkbmdOJDO3yzGVG/V4/NPL
         eU45oJTAJyq0YGIHYWo5fTGp/qD6d7r71yZ6J1N2CLBN18VCGBWRx/mJs8mTcy4NjOpL
         iGsyfDbix0FyV0YSXhcEMSPV3DR3q0kqn47uqSjhrbl13+8N0+SnAyZF0yWxF30+j7qY
         Tw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyPWje0SHJPh/6S3qAxplmlfv5TxMzKjiiMAmeCGY5Y=;
        b=lkVchNb2vqTHA12SaTIIXUtnIa8+GunNth40uwC940HRhWRnkZbb7sZZfW6Q83bwaW
         dvTujwBBc4ajz69qTnRdVEKoFdqDGnDwovyhOhxer3AEKmYd0mZ5ncAoPs+ECjIi1snG
         QB2r4XQnRfdWUVG8tJxBwGjDjhWqha+J6hbNGEKVgiaPSaX7WjMS/nHuNLjgRGDjjLOI
         iVBERUhxZItDKoPY2yjc3Jj1jMP81obGj2r9DYyQzbL5rBpA2fvhirPZA1Kk2ad9dFA3
         1ZniAft1DjaVIdaWB/Ptj/OfS5Bf5QiDK3W9TmSYILnE1CLRw2gWEEV0WtyUJVrGu7Q/
         iQMw==
X-Gm-Message-State: ANoB5pnRih4rIzd9HpdZ0XxW+1OeIcw8E5SWODLb5qF/m/58GrrGICJi
        7OyzYKSS6+QNuGevaAf3dtgDPw==
X-Google-Smtp-Source: AA0mqf4IajCcBOWcnqAxiE+5PBvEK6w5PTpU3tNHxjnbY0qZ1dkU1GlTjmlmXwOX9xKbltUPzAwG7g==
X-Received: by 2002:a05:6e02:607:b0:300:2b50:8dbd with SMTP id t7-20020a056e02060700b003002b508dbdmr7078720ils.274.1668463070066;
        Mon, 14 Nov 2022 13:57:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y2-20020a056602048200b006bcbeddb6e5sm4148489iov.32.2022.11.14.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:57:49 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:57:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, me@ttaylorr.com
Subject: Re: [PATCH v2] Doc: document push.recurseSubmodules=only
Message-ID: <Y3K51orNpT7buAju@nand.local>
References: <20221108002553.3836987-1-jonathantanmy@google.com>
 <20221114213713.2341945-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114213713.2341945-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 01:37:12PM -0800, Jonathan Tan wrote:
>  Documentation/config/push.txt  | 14 ++--------
>  Documentation/git-push.txt     |  6 +++-
>  builtin/push.c                 | 12 ++++++--
>  submodule.c                    |  6 ++++
>  t/t5531-deep-submodule-push.sh | 50 ++++++++++++++++++++++++++++++++++
>  5 files changed, 73 insertions(+), 15 deletions(-)

Seems reasonable to me. Glen?

Thanks,
Taylor
