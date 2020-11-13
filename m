Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3CC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B8E2224F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="NXvXYvgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKMV45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMV44 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:56:56 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6973C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:56:56 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so7904013qte.11
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dDkIhRI7xP3mUSLxCKN/ikznD2T7kteU6LCuBvK58z4=;
        b=NXvXYvgVnyYaojrg55GUL1Xk6b5kos/B0aVPx8nh8TGqUiRvm0QAXqv7b23VppeOFa
         AlmSsiJ3kNX1glDYNgWmfmVGCqCEb2Td39ipXDQKKdSAbhkpdxnD6tJW1GdVU2Mpb2x2
         3qNHPRvNSkA03U3DDkC4YbIRf32SCWUcLGmTEFlbSUwYedqao7OQucOWKBXXhbDPc1WV
         dnFSfQJB3AGoDy/pbc/SXCYpJVGqFNH7Z2P0Y3PBINBXmtaGI1v+m02m08+ODflsZpwU
         76LUdJL9EfP43oO1RAvQGD03zBs2LGtcLkEBIC769mwWSiN48b0SbmVWOEqzN/fXl2kE
         wbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dDkIhRI7xP3mUSLxCKN/ikznD2T7kteU6LCuBvK58z4=;
        b=oe0UT16o7spuxC9enB6aSqD9Hw16vH0QgplY6+vfT/9T/mOhCttyLkh2EFpBJsrCgM
         GUO+JWFRYFSSj0y6cGXYbMQ7w5fg+X0SPKC/tUk0yVL6iOLty5EVKRfEdONZsNF2AWtl
         GhrvrDtF4CTbu+u/55KBPXCAcOmLlOoiJW3WtW26IgD8cZiRr6x/rRfFzIevzwLtdLYW
         GItKMwois0oxffc4SwOiM6oudW7+l6lQXkpZQI2T7d1P/+k/P296P9SBsEroS2jroPoP
         fRvzAXlaRIhItacKQtc+o51uRmk51Ydz7Qt1wMloZWyE5ALsQ5zvzKVHvcaxwJ0zHlyi
         NcBQ==
X-Gm-Message-State: AOAM5336212UVqweADHq8x30kXwhNpZFMXmFlMjH/0W0yfagsHwUVNf9
        uTaScVNQJwLB17/nuthkP0k9I5eR9glRg4RJ
X-Google-Smtp-Source: ABdhPJzMF4/Y5wa0Rm43Y1ZgCMKJWHBU/rde9VDRf6PGFGM6DcDOmL2HJR3lz3vhMYyUQ5+MUbNQyg==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr4030562qtn.162.1605304615997;
        Fri, 13 Nov 2020 13:56:55 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:51df:232c:7a24:7fb0])
        by smtp.gmail.com with ESMTPSA id 21sm7982231qkv.78.2020.11.13.13.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 13:56:55 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:56:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Message-ID: <X68BJSbDjdRGpPOR@nand.local>
References: <20201113215307.20855-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113215307.20855-1-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 10:53:07PM +0100, SZEDER Gábor wrote:
> In 't5310-pack-bitmaps.sh' two tests make sure that our pack bitmaps
> are compatible with JGit's bitmaps.  Alas, not even the most recent
> JGit version (5.9.0.202009080501-r) supports SHA256 yet, so when this
> test script is run with GIT_TEST_DEFAULT_HASH=sha256 on a setup with
> JGit installed in PATH, then these two tests fail.
>
> Protect these two tests with the SHA1 prereq in order to skip them
> when testing with SHA256.

Thanks, this looks obviously good to me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
