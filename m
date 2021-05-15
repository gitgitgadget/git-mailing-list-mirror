Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9253AC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 12:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4BC613D1
	for <git@archiver.kernel.org>; Sat, 15 May 2021 12:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhEOMPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhEOMPE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 08:15:04 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB592C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 05:13:50 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id f184so2101306oig.3
        for <git@vger.kernel.org>; Sat, 15 May 2021 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LxQDeqZ4Hy8eKy2vDsiCLTqlPF7fHXKjaesJ0RukAOs=;
        b=YL6Bo3Mm2Nhom/YYdTo5pX27rJJ8X6wjYen4sT3tKBeIFwTs/ZwGSvdKd0pG/l2+Ki
         C3JqVEzFH6OMXoRfNoxecbauIBCSXCinuLmpqVAwlQ0iwD8mcpyCr7AGFvBgE9ztOZnp
         lEowe1SthM5mZXMekUQhSPRZcwPmulVQigLiynBKrJFi+9RaAQyAr3ANeaPnPJfBAD99
         mXOr4v9U4+DFCsM1cw/r/biySz28MRMKMyPgudTbU38ONQ4Ex25l9g8o+2PBywR6NH4u
         /JoEBVgn2eFXy+WdggfEWYDVthQuE92WtDBZe22706iz/JGtGCQLsG5x7VCYu7FSrxhQ
         2Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LxQDeqZ4Hy8eKy2vDsiCLTqlPF7fHXKjaesJ0RukAOs=;
        b=sTlTWdZbb55VFrmMbMEy2eLnnItIbcUBjYzvUDpdNjRQjjOakIwGyPTTVbzU899iLH
         GPiwPVMX+KtrPZon1Hd7OJ2AloBMdsCayGfioJKXGG6PLPl9I2/efn2ZOKNgjEbwIX39
         B8HTWJmq0cFPTLAGC0SXF65cIOMg/Co/h5jVqRtZkZuwCjUefB5Cy/KZFYTZ4u0LEL+A
         qYjO7nvfHqIiXL2VIR8kYdiDDhtCLY9B6klTvD30Sc/0eZv+8Z/bVCI5D+Q7woyuf5Jr
         DXLiKranSHg67TSgY1zhuQgfycdzIPYfdVCxmifVtzel5o0uoSUyQICo3LC/uql5nr68
         xJIA==
X-Gm-Message-State: AOAM530oK6aRLAaKfeQ68w34ShbGxRLgHTciAN0n/pvnChLYSkK1u5xb
        glAZe9MOM1yf3GSDeYBrA4s=
X-Google-Smtp-Source: ABdhPJzzm+RJS6+16LLjuWMphBuU8UCAo1CICiafJXQUDRqVNFm/AJaI6jY7KDkhpKDmWop7YqNKKA==
X-Received: by 2002:a05:6808:b35:: with SMTP id t21mr17692091oij.18.1621080829875;
        Sat, 15 May 2021 05:13:49 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id i11sm1925038otk.70.2021.05.15.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 05:13:49 -0700 (PDT)
Date:   Sat, 15 May 2021 07:13:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609fbafc73fcd_e173a208f4@natae.notmuch>
In-Reply-To: <YJ+WzATLCM8SW2GH@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-2-felipe.contreras@gmail.com>
 <YJ+VGKUa0Kk3BRWQ@coredump.intra.peff.net>
 <YJ+WzATLCM8SW2GH@coredump.intra.peff.net>
Subject: Re: [PATCH 01/11] doc: allow the user to provide ASCIIDOC_EXTRA
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sat, May 15, 2021 at 05:32:08AM -0400, Jeff King wrote:
> 
> > On Fri, May 14, 2021 at 07:14:25AM -0500, Felipe Contreras wrote:
> > 
> > > Without `override` all additions will be ignored by make.
> > 
> > That's true of all of our Makefile variables. Is there a particular
> > reason to give this one special treatment?
> 
> To go into further detail: usually we distinguish variables we use
> internally from user-facing ones, and include the latter in the former.
> I see a later patch wants to start passing ASCIIDOC_EXTRA on the
> command-line, and we'd use two variables for that.

Well, it's not exactly user-facing; it's only needed for doc-diff.

Would TEST_ASCIIDOC_EXTRA make sense?

-- 
Felipe Contreras
