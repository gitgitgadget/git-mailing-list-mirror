Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB4C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 07:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiGIHxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGIHxi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 03:53:38 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35545143E
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 00:53:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 72so804722pge.0
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0hhur2xIe7ULWYZviYw0Mz7PJy9TKcfIpImLTv3Lt0=;
        b=me4ijyAQS0Ygwmqna+uZFblyWaDS1q68IQhzokTYzfA336yo+DXlDgq5W9toHM0CS0
         hN/KaJcYNP7yf1yFMOGh9Plao0f64k3LPt8sDd0s4l7wYPEiifErpFEwHK3RBUZ6zyom
         XvO+jwL/P9JPW0HTF0yRC/UuPkA4LBFfu7UW61K5EHtFMhZhvRkN7JGwfAXwjoPWBziD
         ZNCYDYVd3HoJiEioaQ06ckBZqgkkryyIsPKh5+f5vIWgJUYM1gWmJBZ+cwICE0mSJd0n
         nzkldPD1FKX7e01cj4lfvcXnP4OZ0eaVep3wksYRu/w7MKijuPlVye7e9qU2APQJfMvO
         EPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0hhur2xIe7ULWYZviYw0Mz7PJy9TKcfIpImLTv3Lt0=;
        b=FKtZu6sLnzmJbJl2pyZDMWRI4/ELwLxjX43z30kLEZm1YnGsK/veDgMDa1TO0FL511
         k7oYbKAw7HjbGh12l7Nzvnl8PT4CHVLXHBEd2tywPBftxKgpEmYbdvgfHAG6b0IyMgzu
         B+o7ZXxVqgiE7PfBcIUS48Zndc6VLv+IfaHpN26xjIDZxVW+HO39OIv6mytoe+8Lj0ou
         HxFTyBYSagc8GxTl+ITb7D2PpapRCaKhtAIrp9IR+ZHdR33U3UNFw+mwVBKTIyIV/e6s
         cotVjOWhhHJNwasspqF0v/g5v8ntwp4RmUeJZVRl+lL0L4O6+qpqzvs3qW9BTBcSGbgS
         aaBA==
X-Gm-Message-State: AJIora+NGCYzejReC7NuWSvLSDG3Nf+8/Pp0c11mXow9+Istb+PBJLtI
        +mIS9IY2Ybrp50aIsut9Gko=
X-Google-Smtp-Source: AGRyM1tSaHuAf1+sfc6q4bOmd856tUVDS23t+Id6VuH/ecWFumeGQQgHLEls90kx62gc5SAZOQFgLQ==
X-Received: by 2002:a63:2cc6:0:b0:411:4fd6:49cb with SMTP id s189-20020a632cc6000000b004114fd649cbmr6626711pgs.365.1657353216219;
        Sat, 09 Jul 2022 00:53:36 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.202])
        by smtp.gmail.com with ESMTPSA id g124-20020a625282000000b00518e1251197sm863038pfb.148.2022.07.09.00.53.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 Jul 2022 00:53:35 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Sat,  9 Jul 2022 13:23:10 +0530
Message-Id: <20220709075310.83848-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
References: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello Philip,

Philip Oakley <philipoakley@iee.email> wrote:

> Not sure if this is new in this extension, but should there be a link or
> two to the basics of XOR compression and some of the bitmap look up
> techniques?
>
> It's not always obvious if these techniques are 'heuristic' and only
> have partial commit data, or they have all the commits listed, Nor
> how/why they work. My point is more about giving new readers a hand-up
> in their understanding, rather than simple implementation details for
> those who already know what is going on. For example, are there any
> external articles that you found helpful in getting started that could
> be referenced somewhere in the docs?

As this series is only about adding a lookup-table extension (and not
about bitmap itself), I am not sure whether it's good to include those
things in this series. But I agree with your point that it should be
able build a logical understanding among the new readers.

There are some external articles[1] which talk about bitmap internals.
But I think it would be better if we can make a new doc file (may be
`Documentation/technical/reachability-bitmaps.txt` or similar) rather
than putting those details in the `bitmap-format.txt` (As the name 
suggests, this file should only contain format details of bitmaps).
That file would provide the answers of "Why bitmaps", "how they are
stored",  "How they are fetched", "how they work with pack-objects,
git-fetch, midx etc.", "Detailed explanation of each bitmap extension"
, and lastly "what are the future works" (if any).

What do you think?

> Separately I'm preparing a short series on adding 'reachability bitmap'
> and 'commit graph' (among other stuff) to the glossary as part of giving
> folks [0] stepping stones to cross the chasm of understanding

Great!

Thanks :)

[1] https://github.blog/2015-09-22-counting-objects/, https://github.blog/2021-04-29-scaling-monorepo-maintenance/
