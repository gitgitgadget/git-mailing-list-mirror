Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EAC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 23:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354068AbiETX20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 19:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbiETX2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 19:28:25 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BB1A4920
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:28:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t15so146835ilg.13
        for <git@vger.kernel.org>; Fri, 20 May 2022 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8jDSU2NvtEou9Xe3F5jKkFg/6fQwQHb+Yk57E1yucI=;
        b=bQW5HFnIBdovFfc/IUPJvgBDoXd6iENyFRBxwkPg2s42WTpWfNXmEUfieaWXt/QQGW
         ZgFwMk2ZQFsSmc2u346LQhlDwPx91p3X6GB1kVqkZGke6yLHEfsjBzRXNkPa3oB50c/l
         hsaevvm8D3rqWyaTqAlEcCTmpCVrS6ABO51ZBNpiCBKihO/YU2tHBHCfMj1ZbUWj/YxZ
         1pFrplertT0VVDCS9zvNySOQFjpP8ZHkTJ4kTfNwBB4GB/FKMtMecaolp3shO9+UYG2L
         1KYzsqi7WbX6mTpOz6ffFpXSv09yldm0df9uZVVAJIUVVn7sGIbzLhwh7uk3In64hPrQ
         mi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8jDSU2NvtEou9Xe3F5jKkFg/6fQwQHb+Yk57E1yucI=;
        b=bHbnPj2yvGMn/7X5Rwe7xcqB3eCQRDd+kYOcSGh2iXW6TIEMQ4GV+eCFeyEfJNvPb6
         j1/be4KaSVipbogjYw7VZoQUVL/qI0TDkCNj1Uq1lNNN8MOwdSNZHJzcAGoaeTTdW8aG
         YZ0ZMc/cVlBPFZ6J8lTyrCivieuz0YUeJ+Wbvevt/UEufqKsemVNUHBTkWUQRJ0fms3h
         aHtrw/i4kmQVODbmhUQ7tbtL2VzeHj3uM/dqoILhRnIg+8RirTWzbAg0dfmJj5TXpLWb
         6pbmtpf7S1empVNegBdcfR4YglbIXMglmac95XI4PfdxDN/0esNTOZ1oC2+3ZfXIVKrp
         NXdw==
X-Gm-Message-State: AOAM5300xA/RD/Dt06z1VdZU7+FLPKyVlt0CaGkPXG/V+OXhc9jBdzLm
        seag1NobGGd3NLRmiHH10fqOjg==
X-Google-Smtp-Source: ABdhPJzHEc3awpkSeIo7VTf/2lCr2ZH5qwp2dxEaZiGrC5dLv1nCHmdgS5QAyAoEWzIqDt+ufW4qZg==
X-Received: by 2002:a92:d9ce:0:b0:2d1:34eb:d203 with SMTP id n14-20020a92d9ce000000b002d134ebd203mr6551296ilq.69.1653089304681;
        Fri, 20 May 2022 16:28:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m4-20020a02c884000000b0032e6fe7bbe0sm1027392jao.149.2022.05.20.16.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:28:24 -0700 (PDT)
Date:   Fri, 20 May 2022 19:28:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #05; Mon, 16)
Message-ID: <YogkF8iapIZlFkXE@nand.local>
References: <xmqq5ym4zpmn.fsf@gitster.g>
 <789a0510-63b3-b297-ff35-de752d4f64d6@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <789a0510-63b3-b297-ff35-de752d4f64d6@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 17, 2022 at 09:10:23AM -0400, Derrick Stolee wrote:
> On 5/17/2022 1:37 AM, Junio C Hamano wrote:
>
> > * tb/midx-race-in-pack-objects (2022-05-13) 2 commits
> >  - builtin/pack-objects.c: ensure pack validity from MIDX bitmap objects
> >  - pack-bitmap: check preferred pack validity when opening MIDX bitmap
> >
> >  The multi-pack-index code did not protect the packfile it is going
> >  to depend on from getting removed while in use, which has been
> >  corrected.
> >
> >  Will merge to 'next'?
> >  source: <cover.1652458395.git.me@ttaylorr.com>
>
> Looking at the conversation here, I would change this to
> "expecting a re-roll".

Yes, please. I have a slightly longer version of this series which
addresses a problem discussed in:

    https://lore.kernel.org/git/Yn+v8mEHm2sfo4sn@nand.local/

and below.

It's available in my fork on GitHub in the
tb/midx-bitmap-pack-objects-races, but not quite ready for the list
yet.

Thanks,
Taylor
