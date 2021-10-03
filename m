Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D57C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 05:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD0B61108
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 05:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhJCFAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 01:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJCFAE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 01:00:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBCC0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 21:58:17 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y197so16401193iof.11
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MGmX2W90y39ITKWZZFxyN58q6v4bwgYktBaXW39+Ihs=;
        b=zdJamB40gQt/7vfhKJWSz6UvH7s6j2yduL8ZbhNesCZlfB/jwasTE2+4Ho/9vsKtvz
         MUlmDJpCkPtaGsjqjF1DtAiw6KQbljNJMpmOeTQ3aCqmXmOjyxN1NPrE9vVbRzCburNS
         lew//WD9zE0GM2VP+rTOq/A7/msEAvWgLO2XrXnBZEjjzDq8ejfKCBz45qk7hnjzKKl3
         gr6LK4hF139bDvaSBQ+XVVS7pKIDDfMi4h4coc76z5maMuNNiAzv+ZbCTncn2m908HpT
         gzWsdctajeLKXl8HPAbzgGq8GDGPi4NBQTFUzq5ZGHP+ouOuut6AgVPoQ4qq4xgruNor
         q3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MGmX2W90y39ITKWZZFxyN58q6v4bwgYktBaXW39+Ihs=;
        b=Sb1XvTKWszLEO829yIrT6YATu2M61rU7REbuA61wGMcDaNVXbI1KOs7N2sGhB86+Kh
         Fz0JA8k8lhDrau73qx3Cf9v5W2Y3QlAAuJzV7fX3h5zmTNFX5EVXBuuG0jZRZcWSJwuv
         erREvk/Moli2jdDm0S+tfRw6cqHdsei2V9aMqybpq/uUbfwnj/o0JeM2zmPRXU7gt0Ma
         ufUXvChLXDM7TiN/Vvj9HIxp9Y+zhlOiJ6k2M0HOsVA1FV0499C+RgtxgrlG+Ht1oXvh
         36WFu63ePDxtLP7meZB+9WiRNdcOWEV0vuMrE/7hOH3MWVidzsXL+Q1zPKcNuJSpvgR4
         5bCA==
X-Gm-Message-State: AOAM533dl1AWgXh/QHc8PgRqQrOh46W7VVJ2xudKxLH9wjha9wZSKdxC
        EGn5wLJEZsakq+iFl2ESsuPKnw==
X-Google-Smtp-Source: ABdhPJz/cbFKgpIZnqrYK6YwVif/CW7aPPAQdBaLBfptMidm1ZoKdbReef9+HB/Om5Bzm0e7W45HsQ==
X-Received: by 2002:a5d:9256:: with SMTP id e22mr4510452iol.152.1633237096833;
        Sat, 02 Oct 2021 21:58:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u18sm6496847ilj.24.2021.10.02.21.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 21:58:16 -0700 (PDT)
Date:   Sun, 3 Oct 2021 00:58:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] p5326: create tag needed for shared tests
Message-ID: <YVk4Z/3X4xC2m58n@nand.local>
References: <ad6777d3-73d0-54d9-200b-88aad2d265b4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad6777d3-73d0-54d9-200b-88aad2d265b4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On Sat, Oct 02, 2021 at 07:22:35PM +0200, René Scharfe wrote:
> p5326 fails with the following error:

Thanks for noticing; this is indeed my error, and your reasoning is
accurate.

This came up during my series to propagate namehash values into MIDX
bitmaps here:

    https://lore.kernel.org/git/a8c6e845adf559a96e37c973fea16da8a42e7cba.1631913631.git.me@ttaylorr.com/

and is in next as 2082224f17 (p5326: create missing 'perf-tag' tag,
2021-09-14).

Thanks,
Taylor
