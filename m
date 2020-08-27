Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B4C433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942162177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598549811;
	bh=9N9o0dYPtdUo7+NrRMuzXkeck0WGvSa/xzawm4hHHVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qFx5py+oI0uKIUHmNUDTIaEjPh52YA/ZpEzWI+46w1VVVK9u9vnqlRooI2thycL5n
	 uLPO5zY6Hy4q18s1qYFlBDIRmYVlvPQByr3reCmhI8Ujfb4g85Otv+czYzur37Rv6K
	 pxrZE/+kbM9Gbhjim9bExuJckdJ3hXaJ07XPi6ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgH0Rgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Rgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:36:48 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0842C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:36:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id p25so6695561qkp.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxkloUYZXSbkB5wLGGe9qr/JiHVsACs+bBMTDfH64DI=;
        b=iFOuFf9d96V7ExfKu0DoqsRItfQJryI6QmAj5LmmYfLDJdFySXlgMuWxhQZP03XCBu
         Sfw84nGNzGryj/Y3HzS4ZerBsFQsL6Je7p5AfuQ1XCpcx90XaHm/iFljcMyhzaYtx1V5
         bnUW0mXeW0MddBsCqfM+Dbd8YAWZ7qFWUW5xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fxkloUYZXSbkB5wLGGe9qr/JiHVsACs+bBMTDfH64DI=;
        b=I6go52DS/j8jXmkVHankKRlZzvTSHoOu+pTw0v3gdllPH0ZMy9ppMYic+u3yQnIPnh
         wCaZySS+DXfLhA/CNjIK3DfbM3aeIaMwJSThZkIjYlxNNbAkCHnUDVUUYLaJyid5y8nI
         a/MCNSoFGIk3zt1m+RxhBury9meVQTFY2TF+Z+x3Sd+tpyoNQgTrdM9Jwf+latnJRCFV
         Bcw1YHf0V+IJcqAksg26IvTjWP+OJiNQeLL0f6PGw5z4GwWZIujDHl9M4ptX5OpSdnLV
         H3xdlDHZeQMCgDctpdscqul2/XTm/6OCookOZT5ZxqwSlv+cNwjb1xaoW+20J0KUkN6S
         gHEg==
X-Gm-Message-State: AOAM531ZVYJ0HtYVR5vqpoQce3NweCyALdewYjVXPV7+hnTxaoBFu667
        TuXl4myXMI7N+KMCj13u2A55j8ehq72FeUXg
X-Google-Smtp-Source: ABdhPJwIFpRaFL+1HcHEWugx3QueKByckdBEgfu80M0qo60SafJFoiptVrE/BY0lP8dLC1JFeXc9Kw==
X-Received: by 2002:a05:620a:2224:: with SMTP id n4mr5998507qkh.18.1598549807977;
        Thu, 27 Aug 2020 10:36:47 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id v185sm2488729qki.128.2020.08.27.10.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:36:47 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:36:45 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Cleaning up files reported by size-garbage
Message-ID: <20200827173645.digsnbu3z4donzno@chatter.i7.local>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200827155529.3vtmrec7nn3mqgpl@chatter.i7.local>
 <20200827171954.GA3970312@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827171954.GA3970312@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 01:19:54PM -0400, Jeff King wrote:
> I think that git-gc will clean them up (via git-prune). It will also
> check that their mtimes are older than the expiration time, which avoids
> accidentally cleaning up the pack for an incoming fetch or push.
> 
> The default gc expiration time is 2 weeks, though, so you might want
> something like:
> 
>   git gc --prune=5.minutes.ago
> 
> if you're trying to get rid of them immediately. Likewise use git-prune
> directly if you don't want to incur the cost of a full gc/repack.

Oh, you're totally right. For some reason I was convinced that git-prune 
didn't touch them, but I stand corrected.

Thanks for the pointer!

-K
