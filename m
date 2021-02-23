Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC29C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D8E64EC1
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhBWRJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 12:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhBWRJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 12:09:25 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4004C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 09:08:43 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 2so8127501qvd.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6C+vi85jWjXrIZjj5SG+rrdcXAH0ac/zSER3F6cBMtU=;
        b=DavnnrTOt3DuzExYSX2xgtnzxohSPHkMcJDUgWc45by3sWdb/hzCeW5S8RA/78ZmdB
         Wpkqj3qov3OgIV107qX8xH63rWybMrV3zosm5386tUqntfUouHv0iC3uWk3ynF13Lp6F
         sGPAJobn+aCItLeoctVdIVwuT8IfRdvEc2FYBUyqHFlw2vikQ1EbOtnvE47WeovkOBTJ
         Lpbob2Xsg/mHtE59p5Gwoi/iUTpPltu32iJ5as3zDCQr9AVUunI4qBIXJb7F47MWx/EZ
         oz5Ov7SBfdnD3dtmRO9+D5DqQvQiaWMqUgYhTGWplDQCqfzbGt/slpZnBAvw87lzr4Di
         e6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6C+vi85jWjXrIZjj5SG+rrdcXAH0ac/zSER3F6cBMtU=;
        b=MKFtMhjG94h8tdbPCTvHOoogsPKYUw6svLAUi1EnxYcJ6uk1r/+lgalvXT+LgCBtva
         HSMIl/dAGcJlIGsUm3/WREnkgN/EFszZj8293lsJHqza+zqAE4yYkAoXKPe/rphlT+Z6
         WHYf2F81l3Krgd6VS4QWE+jR5qnm076Hr+4esh7Qk7mcg0bpBolfI8eS0na5jhRcRDzU
         8zA2yj4lNTHNOHFxpptZpdwVVNmf16U68XoTX0XbkEDMftnovEsgTVhk6YfhuyTDh4/Z
         u5JBvQOVMXAN6yPD8K72B6gtdq2iA5MMuH4my5yptoxctzjTfSMVHAYJOTe7vQ0BcZfJ
         jLYA==
X-Gm-Message-State: AOAM5313DOiFd2pSBKHw/mjwDQmwiQBuhoyUTfpOgp72Jf4yI0MvEaSX
        OsIA33mVP2OSrbaLh/F9LQT/Ow==
X-Google-Smtp-Source: ABdhPJzHS3BTbMGU3VWxVr4lb/tGpjxy1dpBkMGLuRgw0K/ZzzpARp/GmhhJ4q70MzmnR/m9BXLiGg==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr1910916qvt.37.1614100123143;
        Tue, 23 Feb 2021 09:08:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id 184sm164397qki.97.2021.02.23.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:08:42 -0800 (PST)
Date:   Tue, 23 Feb 2021 12:08:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH 0/3] add: minor --chmod fixes
Message-ID: <YDU2lzxPqsOwjv9N@nand.local>
References: <cover.1614037664.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614037664.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Mon, Feb 22, 2021 at 10:10:32PM -0300, Matheus Tavares wrote:
> The first patch was broken out from [1], to avoid holding it off while
> there is still work to do on that series. The other two are minor
> related changes.
>
> [1]: https://lore.kernel.org/git/cover.1613593946.git.matheus.bernardino@usp.br/

All look quite reasonable to me, thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
