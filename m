Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C5C43333
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0D664EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355373AbhCCGfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576602AbhCBTQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 14:16:04 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A34C06178C
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 11:15:22 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a2so15586832qtw.12
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GeKsgqIlUxopC5XfSrR6ONlEtYQBRnkuRHBBGgTx8jY=;
        b=wFOAlNn9iNGdJ3L0g6RHbsS2IxgF0G3h8Uaxs5mVizpKmIE0DzTUJdjW8bBkv7iqY+
         wXQR3w2f0gEMphrZJD9Q8/lvj6smqDtiZMTfOfOj/MDL3iSkS4bVdLsccGWGpFLos7n7
         R74G4kvKjviaWJYuJwiCBx2xeCbvxEI3VXkbk/SGOMEtUIZnRBwuXv9vMQU/J/KPzId6
         153i7M7tkowKjCf0NTnaykBjpwxRTczGPpgClUCO+YuA+uUIaeMnoh5TU/7U92aYq24a
         L35jpd1yP4Isc0tGNRHT2dPNtXWgVMdpfZvZCjWIfWiFkQahGisV5xGQmqa/VdtpyjGK
         jyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GeKsgqIlUxopC5XfSrR6ONlEtYQBRnkuRHBBGgTx8jY=;
        b=LO1cJ+SdRbafIyVGVc+0hShUxu73SoJ3aE0oL9pTqfmD1eIjrcZfBK1hUiIufB6Kwr
         JQuLFJA6IOASXtpK8sUGeaczuJ44GDaYR8cBtEOmCzuAPZdNZN5i5rJyU9fGO+MgJQ17
         qE/jvq+Jf0WmbPzDHUNpu0QDCG24f1jIOF16ZFHG2NMdwesrwuAiNmQFiQATPOFVQrMr
         OwCVWKFznZJ0BueEmHA1Ntx2a26G/eRIea2sr+FWFYZdVhXnNZKs+FZht4sPIhC4wHsS
         aDPEVN5GJEAnva4yaJNMD2b50r0LyrJeN4I1vwKWc+e89mvtV2vfD77toWYRFTzv9KlO
         VaNA==
X-Gm-Message-State: AOAM530axEmOiwNEBufYJTXiLnLvmgNDAk+BRmTIJTeSY9igLEdBayBK
        m0T017oNnGk2awFgYpCGSEI4Og==
X-Google-Smtp-Source: ABdhPJww2NQAPFKUtyRt+OTaGUj/Q/145AwuIYAD4nNjLX67TaIBXk918O5KjLR5US8HUek9/dHiZw==
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr18946870qtd.48.1614712521828;
        Tue, 02 Mar 2021 11:15:21 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1582:4add:dc39:710a])
        by smtp.gmail.com with ESMTPSA id m21sm7170116qka.28.2021.03.02.11.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 11:15:21 -0800 (PST)
Date:   Tue, 2 Mar 2021 14:15:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 12/15] Documentation/technical: describe multi-pack
 reverse indexes
Message-ID: <YD6OxwU936MRKa1I@nand.local>
References: <404d730498938da034d860d894ddbb7d6dffc27d.1614193703.git.me@ttaylorr.com>
 <20210302042111.4038479-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302042111.4038479-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 01, 2021 at 08:21:11PM -0800, Jonathan Tan wrote:
> > +== multi-pack-index reverse indexes
> > +
> > +Similar to the pack-based reverse index, the multi-pack index can also
> > +be used to generate a reverse index.
> > +
> > +Instead of mapping between offset, pack-, and index position, this
> > +reverse index maps between an object's position within the MIDX, and
> > +that object's position within a pseudo-pack that the MIDX describes.
> > +
> > +To clarify these three orderings
>
> The paragraph seems to only describe 2 orderings - object's position
> within the MIDX and object's position within the pseudo-pack. (Is the
> third one the offset within the MIDX - which is, I believe, trivially
> computable from the position within the MIDX?)

Sorry for the confusion. I was trying to distinguish between ordering
based on object offset, pack position, and index position.

I guess you could count that as 2, 3, or 4 different orderings (if you
classify "pack vs MIDX", "offset vs pack pos vs index pos" or the last
three plus "vs MIDX pos").

But I think that all of that is needlessly confusing, so I'd much rather
just say "To clarify the difference between these orderings".

> Also, which are stored in the .rev file?

The paragraph above describes it a little bit "this reverse index maps
between ...", but I think it could be made clearer. (I was intentionally
brief there since I wanted to not get too far into the details before
explaining the relevant concepts, but I think I went too far).

How does this sound?

--- >8 ---

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 77eb591057..4bbbb188a4 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -387,12 +387,15 @@ be used to generate a reverse index.

 Instead of mapping between offset, pack-, and index position, this
 reverse index maps between an object's position within the MIDX, and
-that object's position within a pseudo-pack that the MIDX describes.
+that object's position within a pseudo-pack that the MIDX describes
+(i.e., the ith entry of the multi-pack reverse index holds the MIDX
+position of ith object in pseudo-pack order).

-To clarify these three orderings, consider a multi-pack reachability
-bitmap (which does not yet exist, but is what we are building towards
-here). Each bit needs to correspond to an object in the MIDX, and so we
-need an efficient mapping from bit position to MIDX position.
+To clarify the difference between these orderings, consider a multi-pack
+reachability bitmap (which does not yet exist, but is what we are
+building towards here). Each bit needs to correspond to an object in the
+MIDX, and so we need an efficient mapping from bit position to MIDX
+position.

 One solution is to let bits occupy the same position in the oid-sorted
 index stored by the MIDX. But because oids are effectively random, there
