Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A252C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 16:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiK3QnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiK3QnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 11:43:02 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FAF22B11
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 08:43:00 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e189so12695589iof.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 08:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO2IVVTiCr7fuyylzX4V3QNUJbt9UQ0OMd4Xbo/HS3I=;
        b=ADM24AUD3R/JewQYCX1q/6dUkP4SXRzNKV4Ty9ejC5mCnFlFg+pBCuv+rCgRC6hFGK
         97G2r/FMC2CqTeFT12CKYJExuwgTzpD82MXdypusx8KrSyOKfz1KHDrLQtTiAW3RHUQs
         /DAej95s5cYpJzfilEYBg0iGTSNGf9HVs0kTeplCgK3QCkEOUTSwDVZZDSJEnIhmDx5J
         E3+fwCT3phOXlGfQtf6ppMi7D3QKYTQwFyboxFqWH83pd63lT/ffk7L94dqRhTsabuCC
         bS22G3nkQdc8eBeamj21e5tWpQPbFrlyGpeSAc1jYgxpuseTJWknKy27h2DEbJBf31z7
         QQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO2IVVTiCr7fuyylzX4V3QNUJbt9UQ0OMd4Xbo/HS3I=;
        b=gkppCSe8Hx/zmiNnEP4uvSiLNP95EoWcNSxoceh1QbLJvVSoV+RDb9qhpnO1jui744
         KglU9862KWl78KtVYZfB+k+ZXKEgqBlS2z05pWHQ9ZKqkKHw3Olj53YObNmJGDsoaWM8
         WQLfbWWnZOaBG9RCWPaOV2CJwCo4JrcPKbklkoO8N7h1Bg2a2NxfN3XuVZ1Cll57agYF
         g8Epk8J1P56NGq1FAh8Lh0SmxdSVtxZYMTfDAn7p4ApyOUpHycpVysNoGqkXxSM/AY5k
         64LkwnAgNcrqAlr1+xYhL81KQNVedDKZjL3Ygpre8yTBYGuELd4wHhFkjNwF9X9LlEbA
         O7ug==
X-Gm-Message-State: ANoB5pl+XamtulFQipcayoPsMwusB+LU6yETT4vEgEqePwDgypZZjDyL
        4hf22sT+LycEZ9ZksyE/g5i5DA==
X-Google-Smtp-Source: AA0mqf5drWBw+Z1r0L0DE9UN4t7waeco3VWUi0PTkOh0TJO49S//eWyu1ysel8whEMjDtH+9OaDxdA==
X-Received: by 2002:a05:6638:4916:b0:389:e42a:eabd with SMTP id cx22-20020a056638491600b00389e42aeabdmr7012541jab.228.1669826579579;
        Wed, 30 Nov 2022 08:42:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q185-20020a6b2ac2000000b006cb4c036d6asm701112ioq.36.2022.11.30.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:42:59 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:42:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
Message-ID: <Y4eIEscigSZ3vClo@nand.local>
References: <xmqqr0xum8tn.fsf@gitster.g>
 <20221129130841.82302-1-tenglong.tl@alibaba-inc.com>
 <xmqqa64914jj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa64914jj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[-cc git-packagers, lwn]

On Wed, Nov 30, 2022 at 12:53:36PM +0900, Junio C Hamano wrote:
> Teng Long <dyroneteng@gmail.com> writes:
>
> >> * tl/pack-bitmap-absolute-paths (2022-11-29) 4 commits
> >>  - pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
> >>  - pack-bitmap.c: break out of the bitmap loop early if not tracing
> >>   (merged to 'next' on 2022-11-14 at 34eb0ea05a)
> >
> > Will the two commits which merged to 'next' on 2022-11-14 at 34eb0ea05a
> > be taken into 2.39.0-rc0 (or v2.39.0 is frozen already)?
>
> 2.39-rc0 was a preview of topics that were already done at that
> point about a week ago.  A topic that is not in -rc0 may hit the
> release, but it depends on how urgent the "fix" is, I would say.
> Unless there is a good reason not to, any topic should spend at
> least a week to cook in 'next' before graduating, and because there
> typically is about a week between -rc0 and -rc1, anything outside
> 'next' when -rc0 was tagged is not likely to have spent a week in
> 'next' when -rc1 is done.
>
> We could graduate the early bits separately, but is it so urgent a
> fix to get them in?

They are nice-to-have, but certainly not essential.

Thanks,
Taylor
