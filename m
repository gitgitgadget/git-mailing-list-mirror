Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE6C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF5222C9C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgLDTMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgLDTMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:12:41 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD4C061A53
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:11:55 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t8so4397392pfg.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X5oBbeUxL89SA3iv42jgLvN5hv0K7sPHPAebYLDDVJw=;
        b=cWXxAjPyXHdxpp9YzvROEK1MUw9ieIt8NquicoZtfPha5Uz2FhUw2oQ3gOKg9g+9En
         PaGHA6dPPR9tXd9zsAeZBTaQMF82wpA0OqkRE2WfK4fgTb0Twar5TjOxufD70+wT377G
         0kIdaZq7rYdNuiEh1PWrOInXsZnYv5yhbwwHXogeN9fgiENi7DUQsdf7/D9GqF7RUz0T
         LXidsFM444USz56J0hEP1SWQQV232wYV5lNHBVQ2fEqzykIck13LCoYrr7hD6qdzHlSe
         h/f+qgOVD3oTz6rZkrw+NKveLq5EZ+mAd5268AFKOp+ND+csdPx/06KNCdGelUorhvRD
         X3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X5oBbeUxL89SA3iv42jgLvN5hv0K7sPHPAebYLDDVJw=;
        b=L0TFhWAtBaluRScUW5BjVnfxs60ZstylB5gFelFcujw0/Z/sNN/uj4zFG+RQeJD4xw
         93JLcvIQ+23VyIJx/OwKyLjNh1IOgK98b/dmXmgJ0raTO56+ghw2viDZK2I1MW5ZhHv5
         aduK/05vUTB4VA4WViW3MMUtNwsr316QbEx2nzXQtPLzL0eauPBzPlgljWMKq2CECak/
         qskLVRE7BmhUnAfLOgpc5Vp1VOMcZdExAESwsQL6YCd897Lr/GUMb4kMwEg4Zsx8j9aI
         CgCBlXN8/eeGDqcu5drJkuMB1OKIG6O0NZ6Gm2+Ff6Xg9WwxFs87FGWyjRwSE1dw20Ep
         /Vwg==
X-Gm-Message-State: AOAM531lmsEf1uxqbjzRWHdDutrtsQyX6nVN4nvnOkxYII5m7fwMboLD
        ScuxXVj2pZlDsxWGnlkKsHZ/fw==
X-Google-Smtp-Source: ABdhPJwqZgBrP2kwR0v43Fu7aFPvDKGhBnb3Zzgr2P4wA88Vcn9315jsTwYdixRPaqzZLjsosMNmyA==
X-Received: by 2002:aa7:9435:0:b029:195:f6a2:b610 with SMTP id y21-20020aa794350000b0290195f6a2b610mr5316499pfo.32.1607109114897;
        Fri, 04 Dec 2020 11:11:54 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id mr7sm2825685pjb.31.2020.12.04.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:11:54 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:11:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X8qJ9yKVcGSw0bWx@nand.local>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
 <X8qIaOe3aT1qr+es@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qIaOe3aT1qr+es@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 02:05:12PM -0500, Taylor Blau wrote:
> On Fri, Dec 04, 2020 at 01:53:23PM -0500, Jeff King wrote:
> > I also considered adding a full iterator type with init/next/end
> > functions (similar to what we have for hashmaps). But it ended up making
> > the callers much harder to read. This version keeps us close to a basic
> > for-loop.
>
> Yeah, I think that a full-blown iterator type is overkill for this
> purpose. Another possible approach could be a macro:
>
>   #define for_each_oid_array_unique(arr, i) \
>     for (i = 0; (i) < (array)->nr; i = oid_array_for_each_unique((arr), i))
>
> but I don't think that's making anything more clear than
> 'oid_array_for_each_unique' already is. So, I like the approach that you
> took here.

Hmm. I take part of that back; it would simplify the caller in the eighth
patch, which first wants to sort the list before iterating it (which is
necessary, because we look at 'i = 0' before calling
oid_array_for_each_unique()).

So this could look instead like:

#define for_each_oid_array_unique(arr, i) \
    for (oid_array_sort(), i = 0; (i) < (array)->nr; i = oid_array_for_each_unique((arr), i))

Maybe a little too magical, who knows.
