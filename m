Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B08C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 02:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiC3Ckr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiC3Ckq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 22:40:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4AEA94D6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:39:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q11so23265842iod.6
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sh8be+oU6UyKj98Erk3Fxn1NYtSQZmbU1v7CEOPnbMo=;
        b=Hoc4GC+nVYDb0kzTkVJ95h+DafrN5KE3wIttyYckxWP4JLp7yyCa4ZBZ6yETJt4eIk
         KATUtOJLvXdUbHvK0GpAsotm+wFt3eYH5us01J5hCXiQDKdCCi25KFh1LaPjyOeLZL/O
         b1wa4Ihp6UaaOj33pTJuM71hqXfUqubxMb/9OFG5aC7X2moE2rlEOGiOdnTFd9uljY1J
         D9xWjUXaidh9Q2whW55oSmRTbqgTtMkqxnFmsYkDrE1OlqMfMk25AYgXCP9V2sfc/zPw
         9Lh4iv4ROalJCLe1DFT4XKVd/rg46eZ1MxtMH73OGfnAlq1LYlChzH06/zlfapwrgXL2
         5tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sh8be+oU6UyKj98Erk3Fxn1NYtSQZmbU1v7CEOPnbMo=;
        b=7IuFDE3Mr6WAI0X+AFzfnN4WOb5viMRStKBwjq6Xft0fLDNMqPmEXYF9HLYYHUzukx
         /R9ISa1d596NwDjDJQk60A7lohKAEkrPOwrU1RLDlGu8+ytj/xk3swusclgi74a073V5
         OCoXNGfsEtOpDf6KHLeZeLKV4jVNcb484HSEjKACyQv6XGItuW9sw3WJ48IJ7ByjZGEc
         GxXizlyyhB5bM6XTUPBc50XzAO82GGMQa/xcO5AdwzXjP9z5IfTQTASGCjphkSxotQn7
         QMQVJjDRsqiykO8DQfQmGGDkiw4kR1rlYsOVMS38cqTZ2QNCoDjw9HM5F45f457rhf4O
         QCEQ==
X-Gm-Message-State: AOAM531EhRncpEWmhsn+L+u4KHC2+MFvJq1Wg4YweBLxrXjQP1bbCQHW
        sxfgjzfq/6pkZTuaW+3FZgYDGQ==
X-Google-Smtp-Source: ABdhPJy91JT3+jr/MoobjOLphGRpoSWrwKypUHGwgVji675sDGCoYxLoKt4/09+VD4AIgRMKzjmSyQ==
X-Received: by 2002:a05:6638:14c6:b0:319:e02c:1fc2 with SMTP id l6-20020a05663814c600b00319e02c1fc2mr17009586jak.44.1648607942424;
        Tue, 29 Mar 2022 19:39:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u11-20020a056e02080b00b002c87d5830cbsm8408049ilm.40.2022.03.29.19.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:39:01 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:39:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/3] pack-bitmap.c: use "ret" in "open_midx_bitmap()
Message-ID: <YkPCxRDelmwpdey3@nand.local>
References: <YjzCTLLDCby+kJrZ@nand.local>
 <20220328075907.75529-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328075907.75529-1-dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 03:59:07PM +0800, Teng Long wrote:
> Although all MIDX bitmap are scanned, only one of them will eventually work
> , and there seems to be no guarantee that the last MIDX that works is the
> most appropriate one? (with the same comfusion applies to non-MIDX
> bitmap's behavour...)

I think your "which is the most appropriate one?" exactly highlights the
problem. Since Git can only handle one .bitmap file at a time, we should
tell the user when we found more than one candidate.

In this case, they may be expecting or depending on a particular choice
for performance reasons, and so may be rather surprised or upset if Git
chose a different available .bitmap.

The one exception to this is when we have both a single- and multi-pack
bitmap available, in which case it almost always makes more sense to
pick the multi-pack bitmap. So we don't complain in this case (i.e., if
open_midx_bitmap() succeeds, we immediately return success from
open_bitmap() and proceed to have prepare_bitmap_git() call
load_bitmap() on the previous result without even bothering to check for
pack bitmaps).

Thanks,
Taylor
