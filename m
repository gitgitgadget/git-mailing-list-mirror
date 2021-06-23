Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C02C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E1061185
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWT4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWT4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 15:56:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0DC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:54:03 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so3174426otg.1
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=jV5MoI+BxcsIE/yr9mb4Nb+DMpWAuhxjAy+qKETaw70=;
        b=p1NAoHFb1qbJHjYwgFwjBoYb2nAGd6p/Z13jJPW85hGW+3ICZQSNWs8cn/zgt7mK14
         1kFlPplR6Si9DJN+scA1Lim5yGqnBE+vbzdG8MQjr0Jn5j1D6TpOhQzrlrXd3+klmIo1
         wel13tChRfsFXvAtorB3bimg0Ah4o5Wvz2FcdiwSGRctHThxB3bwhRo8MSePe0NPneK3
         UWZ67WOivFwPnyscNyOBTsLJZ8kRbDRAD0+G84iI5bLhR5BcjdJSLXHAUYjj+cxs1kW3
         pyY35F7aQ2H5hsGMzKmMmFohb3DJWt1okM3PKhyPskBa/bkOZaNPIHin5sUjdEwP/7Uo
         wQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=jV5MoI+BxcsIE/yr9mb4Nb+DMpWAuhxjAy+qKETaw70=;
        b=c/yxAceD/CKwxDkr5QR9QEqVMdv/dJJCGBfyZb7XszVLxigWUsDe/ldJYkgx4IgFGO
         S1U2JzTMW9oK/wnNzyEOE2aTKPncvxJ44Rx2hkZNTAJ2xsi7xtmlJAmS2sHnbpM3HPBX
         Ed6p4Jy4iJn7cHVUiYTnlL7VP+8hEWQkTw3C4JPa1BtFr/HP8oZnR020yedY0syuBBep
         2+n4XeV+k8qrhzU4AyBBCyEPYxU9f4zHf1QMxMLmWKJR87KnurlgvtOFdYU0t53VHwRx
         YhQrMU/LetwK19extBjCIpZkdzSi+n2WIofm5jMf/+vIG23rTE+/S5QxJOjwg4OiC4yM
         VnsQ==
X-Gm-Message-State: AOAM533ESAvKLuJQORUPoj5HPo39YzMAVu3D+JdTJLBes1+U6xKxur24
        EPYE+csbqa1NfqE4IVJfP6Q=
X-Google-Smtp-Source: ABdhPJwZpi7Iv0mJCDuxxnLBO5kjcwg/HXOQkniwZTB3YE888JGLIdyU8uMhGH6b2nsKHn5Iv0aRqQ==
X-Received: by 2002:a9d:206:: with SMTP id 6mr1464543otb.31.1624478042888;
        Wed, 23 Jun 2021 12:54:02 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id a22sm209686otq.10.2021.06.23.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:54:02 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:54:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Message-ID: <60d39159291c2_4290208c9@natae.notmuch>
In-Reply-To: <CAPx1Gve+Zf4PHMVjv3gCTaW_0Fh6W7xL+J4bnAU0FA8OV7SR2w@mail.gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com>
 <YNI5KVGT2mLlTrnz@coredump.intra.peff.net>
 <CAPx1Gve+Zf4PHMVjv3gCTaW_0Fh6W7xL+J4bnAU0FA8OV7SR2w@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: fix "cscope" target to refer to cscope.out
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek wrote:
> On Tue, Jun 22, 2021 at 12:26 PM Jeff King <peff@peff.net> wrote:
> > (I wonder if anybody even really uses cscope. I wanted to love it as a
> > better form of ctags, but I have always found it so baroque and
> > complicated that it ends up being a waste of my time to try it).
> 
> I use cscope all the time, from vim.  If you use vim, you'll probably want
> cscope_maps.vim.

Or just set cscopetag.

-- 
Felipe Contreras
