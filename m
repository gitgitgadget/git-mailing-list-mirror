Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F8C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 21:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDLVwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 17:52:47 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F7F448F
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:52:46 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54ee17a659bso247049677b3.4
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681336366; x=1683928366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmgxDAST22Yyss06uZoDsLckjmFhHbXopXthY1zCyXI=;
        b=o28EHYD3AM7ZuKuWmIm1+1FkTFiNbLe8y5AdBhDbzmVzCVKa83Fqz65fPluwrGKOJ9
         BcR+cf0PaiMZY5zgpNgfy8wQohU4y6Xje6QU33FoWc2V96LHtjD+W/iZ1E1IjIGS8U09
         tYL/dbSR3sNHBwSc6kwBPSCYcj3FqGKRYG+uj3IDsYCMck2LB05tKaSYQp58he7N31ck
         gsZOS3+Wh7SBWwBoiUsaOvhiQcSNkFSVuTXMj6I1753A8Fs/ZzqJ8pNJAySj8Tng8qP2
         wXfC8HriHp+G+bJ0t/stce8htCaqT8tJAbgvS4e4wB9rvFDUXojSPwNVIjqgjfXO8A4Z
         T/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336366; x=1683928366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmgxDAST22Yyss06uZoDsLckjmFhHbXopXthY1zCyXI=;
        b=K7zFJzBgN+zwtbd1HWUQcMqWSaE8Fpc1SYRAO2hSGrT5kVivib4Iq050/OT6h56S8F
         vtTC+Kxxn6Ic/3tGocRXXMSPaYzAtObDrkMSwZq/oZdXr4vm0VU0t1cplplbmyWGab+3
         qADt4V86UjXfCYqM9qOEAVEP7sq/lwNDtWW+UhON4r7yXGpoFnQL9oGduZ9fMVxLtF+x
         FsASTdrzv5JjtjgLz3gE3dD/NC5u52mpBkdPrMKFLOH6hmIC3TiWSmvz8SgU2e4kkt1R
         mcSfSgGI6tAzLbER+gzCWM74XPNpQSFIUslW3ztJmDPERUcNjql1TzK4BMb7K01ZzI9h
         OyTA==
X-Gm-Message-State: AAQBX9fGKsAxF1W9I58/wER75EETUHcio5mEALxGiBNUhu9K9jnnBlRK
        mBOmsigHPGhbyCGwKOVS6ObBSA==
X-Google-Smtp-Source: AKy350aJ04CPiQbBRDott6KvUHsLR5RyBzUiHzXR11+dqaz2G0enWsBHXmXNesB5iSa5oS+H+JTIEg==
X-Received: by 2002:a0d:c406:0:b0:541:6a0a:9676 with SMTP id g6-20020a0dc406000000b005416a0a9676mr3138799ywd.48.1681336366073;
        Wed, 12 Apr 2023 14:52:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 184-20020a8105c1000000b00545a08184e9sm3185797ywf.121.2023.04.12.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:52:45 -0700 (PDT)
Date:   Wed, 12 Apr 2023 17:52:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 5/8] pack-objects: fix error when same packfile is
 included and excluded
Message-ID: <ZDcoKN1rEzqxZAe2@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <9b278a4c91a5631d1b7b11bf56ab560c6bb58645.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b278a4c91a5631d1b7b11bf56ab560c6bb58645.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:22:48PM +0200, Patrick Steinhardt wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index fdf3f440be..522eb4dd31 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3366,11 +3366,9 @@ static void read_packs_list_from_stdin(void)
>  	for (p = get_all_packs(the_repository); p; p = p->next) {
>  		const char *pack_name = pack_basename(p);
>
> -		item = string_list_lookup(&include_packs, pack_name);
> -		if (!item)
> -			item = string_list_lookup(&exclude_packs, pack_name);
> -
> -		if (item)
> +		if ((item = string_list_lookup(&include_packs, pack_name)))
> +			item->util = p;
> +		if ((item = string_list_lookup(&exclude_packs, pack_name)))
>  			item->util = p;

Oof. I was hoping that we could avoid having to look through both
lists. But that relies on us having disjoint sets of packs in the
include and exclude lists.

We probably *could* just ban this combination outright, but that would
also involve some work to try and detect that case. So I think that
doing this (and ensuring that the resulting pack is empty, that is that
the exclude set takes precedence here) is the right thing to do.

This (and the elided test below) look great to me.

Thanks,
Taylor
