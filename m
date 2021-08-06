Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8910C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A5B61131
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbhHFT5b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbhHFT5b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:57:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6FC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 12:57:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k11-20020a17090a62cbb02901786a5edc9aso397162pjs.5
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JeHDelfk+F6hgZERXP8qO4WrJfq4lolZrAfcFYht84A=;
        b=RyFcLVwCDWKOlc2tWH43Ux6Aa85h1BMdEhL1xpELc62gBW8Nm1PnCldd8WbKmLbEpr
         ioIN8R/L8zCxWQ0/GxvLd/LvCE5hNjWlfSU2qumenda2ADtUyGf9qtOVFXIwdHDlOgpE
         5u7R+Pn+j35/lWepZbQB4uPae5nzEN5GL3l5t9nM2bt32GZ49gSXbq1xpXCGfATd4oSj
         PiFo5yp/Ky5IR5pUfWrGrasb2IJOZpL/Pta2lfWMrYKi2WXi4RVWOUE8wDL6PP+I5u4w
         3UbH4vJDQJjDzsAdAQG+mJv3hAA/10oaTPv2/nnVSSpyk+xuCHU4I8FKgZNmjt1ZLWAf
         mA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeHDelfk+F6hgZERXP8qO4WrJfq4lolZrAfcFYht84A=;
        b=AuBGYRjnlnHeIRanDxbOLY5YmTRaH02j52p7YLxYcDvxSCmE1BSRUOD2aOKhVpd9Rg
         fgvdYFoGd9/HNf3QjX/2hulJ0KP13RRR7U04+Pvy35W6O24X3BOfEbRDb9/WYXPS1Jh5
         dSBM7XZaeeWxQksJ3DycpwXpB5W2EOv821i9phhXCaLWf6u+og6cATtxLqzvGzRvmNIX
         oUizXnp4xTmMkbB1q4m343uBmZ1+DBFk+ft01Juj0KU3QvfPXeM9hufAlYR/z7R1x9xf
         JZky4raZd/4l9KPKrFQUEgoId0GXIV/2XzcSa8tCYj3QiBjE9UvS+UBFl9BTMbwaTDXn
         BHqw==
X-Gm-Message-State: AOAM531rYpZbhq+ZbvGi+rlPqtshrmjob8mXReoS5YasVB/7RkG+PD77
        Du4VQLTmHNbXlfXw0CERCWE=
X-Google-Smtp-Source: ABdhPJxDMt56mwF38EicLEJSVRKIdbVtVH7iMtlpXusLJ/JchQ3DZYXzUD8jiQkGBZ5f+KwJE3mugg==
X-Received: by 2002:a17:902:c94f:b029:12c:dd57:c580 with SMTP id i15-20020a170902c94fb029012cdd57c580mr2136897pla.42.1628279833604;
        Fri, 06 Aug 2021 12:57:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7578:9c9b:8fe8:cece])
        by smtp.gmail.com with ESMTPSA id h188sm2571838pfg.45.2021.08.06.12.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 12:57:13 -0700 (PDT)
Date:   Fri, 6 Aug 2021 12:57:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
Message-ID: <YQ2UFmCxRKNMOtrD@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com>
 <YQtYEftByY8cNMml@google.com>
 <YQyUM2uZdFBX8G0r@google.com>
 <xmqqh7g2ij5q.fsf@gitster.g>
 <xmqqczqqihkk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczqqihkk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> For example, 1e20a407 (stash list: stop passing "-m" to "git log",
> 2021-05-21) that dropped "-m" must be reverted as well, no?

No, that change is fine.  The "-m" doesn't have an effect one way or
another after this revert.

Thanks,
Jonathan
