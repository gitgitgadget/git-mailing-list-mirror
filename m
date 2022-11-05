Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624BAC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKEAkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKEAki (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:40:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318842FFEB
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:40:37 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r2so3398308ilg.8
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 17:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lABu5xdco9AjuuScOvgJS5adWC1lHp0ijHNLrCKdyeg=;
        b=IQidMvyPvK8HDIt8BaX60PjiFtp8MWRiViZuu+Tp53+D2Bx0ZJ4JnR5j0atxH9Y15N
         5FJJlu5HgC2DbCUilJ7hdPGhEEeOSmCmZ5/3u9naEdzqgaBWFzvBdauXunX49ZhqEsfB
         zfrHSkTJYoUj9FtCck0JqLDhkDP5575EokH37ybty1V2fMIrsuQlRmiYWAOncszSu6ST
         XOU3J0UJl9uBxrZ9U683rSkH87Kp6dyV/iUmR9B+I8cd/FrsGenKlbeD5LFhuqARRqAQ
         kJY5fiFUbh1QeilKdllCd9ulYloccShaWi0HZnkztRNCpStgQoLIh11s9qvC5BNdLQ/M
         Jonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lABu5xdco9AjuuScOvgJS5adWC1lHp0ijHNLrCKdyeg=;
        b=WZXGfQ2MEEtcjZWTuC27ka/WG/Qc59sIubRRK7luf0RDIhzF1p0qGr0OLoHyUU6zLL
         kQrYkpAp/ObAc/N3Fj4aMTw0WNkj6JynJC4MGhNpu7mqoJWHE2VderiKIzUhdpL/szT2
         wUv8HLJGQMxUWAGAuAct18b6A40Qcssr+J+eZFWGNFy4eXV3df6pN3iMfHE5nk8KdMI5
         fDGV82Luza/YEuq8x/3gRlo579KDxQgDeMQiLSlCwyPTYIXXWdQ8XCcJowYcraMXN9Cw
         hZ6r7usLA+PwjGUmvBMwYLBxB9Pl7kDZ1Y9DcQ/vNLJxsVFZtvEmZIoZIC0320Dx4UsS
         OG3A==
X-Gm-Message-State: ANoB5plWZRspjaCQ5479NvD0YBTAANYNhrWY4/c9lUftg95Ibc+0siUR
        16V5snwRODVgiDUYG0RBXD5TQA==
X-Google-Smtp-Source: AA0mqf4hw/c9vGj4EkNkdE1/nImA9khwpCy9EGueAa+8Ast537GObab9Bl6TFWgG3reIbzh6SOxKTA==
X-Received: by 2002:a05:6e02:188d:b0:301:ffc7:c825 with SMTP id o13-20020a056e02188d00b00301ffc7c825mr972213ilu.7.1667608836558;
        Fri, 04 Nov 2022 17:40:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y9-20020a056638228900b0037508cc0bc2sm183264jas.12.2022.11.04.17.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:40:36 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:40:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y2WxAwNuKTOJEhz0@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667485737.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 03:37:25PM +0100, Patrick Steinhardt wrote:
> Hi,
>
> this is the second version of my patch series that tries to improve
> performance of the connectivity check by only considering preexisting
> refs as uninteresting that could actually have been advertised to the
> client.

This version was delightful to read, and I don't have any concerns with
the approach or implementation.

I would appreciate another set of reviewer eyes on the topic, but if
not, I am comfortable starting to merge this down as-is.

Thanks,
Taylor
