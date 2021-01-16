Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5377C433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 03:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D923A05
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 03:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbhAPD0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 22:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbhAPD0i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 22:26:38 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4648C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 19:25:57 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id l14so5008139qvh.2
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 19:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+C7hhEeLSJxdgIXe1F7ACxtVuVlnCTQg/QJzRdHmPf0=;
        b=D9yl7e59YzFAK63q2AHpg4UrXUA06mcftgHlYFiaRo6tY9+T2+PdFNVQ1pjt2dbQvE
         Lm7Gm5XpMBY07Owu46NRu8SqX4Rac1Uck4S2K1o2qgkfiCwoBZooIgjGhaIMTnR2kicL
         jc6m320dzVhe+bmqTy0i9K2hY0g7cupXI/sHj7wL6Wt6IHP6WojCaTW+j5vSdm7LBnnq
         TA4WCi11udRQZN4nUp0IMo06YIZr5oF/oEtclEs1RSvN08tDaE16BcfoyDXiQaIsIEex
         BbIpmIbJlVhxGLP7b0SUEJgG4SsYt32lYnqkUeDHoO5Yd9IevR/6TuAzf3ix2Ct8VCIJ
         4gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+C7hhEeLSJxdgIXe1F7ACxtVuVlnCTQg/QJzRdHmPf0=;
        b=hnCvhk4kwheYXb4O1D0VpQghZnoyNw/0LtZRgKLzUsI5C5CVdnuLfE3hN55+AZ3mip
         06XbEInAXr8LFd2DVRcdWic14GJ9t6SVChWnQDtzodVaU5HzkBEqGfXSjcQZl2UISe8R
         X0cFVetVOK5cREzYNXU99BNVp68gQNxu2d87WKIilRE9GSmkNCvqRt9W0KsGr6/z/x/U
         5sNF7qSRAwh7aJiZE3JjPW/2yVoDHO5rdmUmcdHSbZOAAJCcHie+Py2Rj2IJlwOWOupF
         nFxwJ0KPdnhky/n1S/0rsuw+F8a+xYAv3lBNObkALbEbqCmJaUCOZDl4Mn/2lZT2aIss
         b8rw==
X-Gm-Message-State: AOAM531L7VxwANMfKD7AXslh32n75kUseGXC9nwbXgnwyY3iDeCc63zJ
        nX6agVltLpMfuxy4CPgR9I9fCw==
X-Google-Smtp-Source: ABdhPJzL6axcI2ihKkN4uhoraP0E9lS04f40iMMEwkxezmJlB2TUm+ndWzW4tmnowV5V9LIRaMF6eQ==
X-Received: by 2002:a0c:f0d3:: with SMTP id d19mr15236402qvl.55.1610767557039;
        Fri, 15 Jan 2021 19:25:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4081:f2ff:d6a2:cb33])
        by smtp.gmail.com with ESMTPSA id k187sm6427126qkc.74.2021.01.15.19.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 19:25:56 -0800 (PST)
Date:   Fri, 15 Jan 2021 22:25:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #03; Fri, 15)
Message-ID: <YAJcwzd7HjkwAOv1@nand.local>
References: <xmqqbldpr90k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbldpr90k.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 05:00:11PM -0800, Junio C Hamano wrote:
> * tb/pack-revindex-on-disk (2021-01-14) 8 commits
>  (this branch uses tb/pack-revindex-api.)
>
>  Introduce an on-disk file to record revindex for packdata, which
>  traditionally was always created on the fly and only in-core.

Thanks for dealing with some of the shuffle between this and the
tb/pack-revindex-api branch. I have a string of topics in my fork
that are based on this multi-series of patches, but I'll send them to
the list one at a time to avoid crossing topics.

I figured that sending these two at the same time would be worthwhile,
but seeing the pain it caused was enough to not make me want to send two
dependent topics at the same time again.

(There may some semi-related fixes--especially around .keep packs--that
I could pull out of the chain entirely, and so they could be submitted
alongside other topics without one depending on the other. I look into
whether or not it's possible next week.)

Thanks,
Taylor
