Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5ECC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DCE60F9F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhG0Rgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhG0Rgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:36:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DEEC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:36:36 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l11so58746iln.4
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jhLDvVC74qJjghqULLA9NgraxuIHyIIu/PmkdDduNX4=;
        b=agpcl6DMhnkPPtgJt8Co1BOc7hPP45Ua+p4tvdBwv2a+SE2r8E+4Wof/ElzdWfpMdv
         Cy8mz0pOf1W62pPGPdegMixuCkrC/PCaGuWLXWlF98f26B2mQazASshaA/6Kt8KjbieN
         T3FqzJGQJ8PFfUAI0srzi+3+KlOvxHkxVh/S8QMTzCMbp4TASkO0toCqDvhrF6bDcJnS
         L95MwDG4ehawA4sIDbCmiglUqyCR4ofJVYiXtrq+5pLaEScXNstX5SmQxO/rHHpVpMA9
         uLT/TkexH4E0tQ2VOqEkewM4WKcMCCdVXFq8PXqg+8TISkb7pvy5rE20RJaBkdHjQn8A
         qT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhLDvVC74qJjghqULLA9NgraxuIHyIIu/PmkdDduNX4=;
        b=mkrQomrQ4Xh5LGD6hGNYYotMcgmdBS4R1M7h4Ro5vJwH+XsyKTH72ss43jdF/Ya49n
         Fq4bCvwPJ2eDGCPYBur9fZ8XUElqgqLtxU3GsTZv+VtNR2n/COWmtVK3jozjzjRCQP8J
         HG+ocJ85B7S9fOXTrSyPHOIBINZRjGK6qqOKqoqZ4Px6TbwhfCvGpOjI7fLIjtK8JVxA
         PUcs9Ty9SUIXO3rro5cwWC6tnCNa6VV0S4P9AkhUDt9CDv6tUfuEuBOsjo/BKLhPxtJG
         c79hrR6F0018h2e8KyP+oOwc1zwi/TTR2fL1fbhDYjDYX1LdDoI9l3Arr4JWtII0iSi0
         GcKQ==
X-Gm-Message-State: AOAM530rdK5Xd4x96RgzM/sOCZuLda4AWBvIvkraRSd2ICmpPpEddE83
        pZiRGOLjjbcGrA8llx7YeLbFug==
X-Google-Smtp-Source: ABdhPJzDkyqLmoWJN0gjNtytNq6TZgiIfyixqe49dacJ7Eg4CV/v9vFVn7ioq6JTvcLwWgBvUGl3zg==
X-Received: by 2002:a05:6e02:c87:: with SMTP id b7mr17512420ile.210.1627407395735;
        Tue, 27 Jul 2021 10:36:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id m184sm2730174ioa.17.2021.07.27.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:36:35 -0700 (PDT)
Date:   Tue, 27 Jul 2021 13:36:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YQBEIrRfcq5dhpZn@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:29:49PM -0400, Jeff King wrote:
> On Mon, Jul 26, 2021 at 06:14:09PM -0400, Taylor Blau wrote:
> > So in this scenario, we have two copies of the same MIDX open, and the
> > repository's single pack is opened in one of the MIDXs, but not both.
> > One copy of the pack is pointed at via r->objects->packed_git. Then when
> > we fall back to open_pack_bitmap(), we call get_all_packs(), which calls
> > prepare_midx_pack(), which installs the second MIDX's copy of the same
> > pack into the r->objects->packed_git, and we have a cycle.
>
> Right, I understand how that ends up with duplicate structs for each
> pack. But how do we get a cycle out of that?

Sorry, it isn't a true cycle where p->next == p.

> But now the internal midx writing code can never call close_midx() on
> that, because it does not own it to close. Can we simply drop the
> close_midx() call there?
>
> This would all make much more sense to me if write_midx_internal()
> simply took a conceptually read-only midx as a parameter, and the caller
> passed in the appropriate one (probably even using
> prepare_multi_pack_index_one() to get it).

No, we can't drop the close_midx() call there because we must close the
MIDX file on Windows before moving a new one into place. My feeling is
we should always be working on the r->objects->multi_pack_index pointer,
and calling close_object_store() there instead of close_midx().

Does that seem like a reasonable approach to you?

Thanks,
Taylor
