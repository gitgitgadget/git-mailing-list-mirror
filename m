Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D90FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 23:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006E820734
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 23:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCPsFnVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgFQXOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQXO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 19:14:29 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF9C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 16:14:29 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s13so3055734otd.7
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeKla5CzPhCuNBPAsHn4JnUBpbZDW0zoYRXtLD/3A8s=;
        b=GCPsFnVGnPhRdnJhjwut8iI8kACnxcnjLzc6+oyrOv7UsC+BmoNL/SbIfwnsvHwZcK
         u7tRaUZe4VLTxSFtfXsEgx4cfXxb3bE+d9a1InpxQFJ6DcdaYj8mwjCaHnDotqiNSC1g
         H5E6MgDJxPJuLRxYWjgSqQgLTTnNpCCxlaSP2NhqIH6YuqyysswT+zxqFhpetktnfOSi
         0GR8yGh02rcYf3EljYcC1rqgmtabNt1tzS3rjwB6rNKfeBIVOF7J0y4cN/iuKpZiDB67
         T3rgsI9zv1rF2qUXpJ4zbdGcyriP5Tw/ZS+9HFNAj+T8RUl3lbUkezSb+cwFpvUp8+Sz
         hjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeKla5CzPhCuNBPAsHn4JnUBpbZDW0zoYRXtLD/3A8s=;
        b=LZbMnzQadTRY7I7lFdjiAINuGUf7XfoQz4bKLtWk2LgpHjS5QFUsjamDEY8a/nk55B
         THBMdQWhUGUANmXwj289ksdM5Ilj/ckWOC+z8Jf4Sq6e4/cDjTVJH3U6EhA+FCBWh8+W
         QHVlKxGlxJEGSIm8CzCyaolHa3LI/nBSdiZ8EznUWTg6c6hW37MBDBallFsO/z5wVJsY
         Gn8RPSn8UbRr4e/cplZpDwwdyDMkpHzTymCHOuuZT2VkIrMy0gm1x8dj6kn2elgVkJAo
         /LmNgE4GfE1RXA/2c/gNN/Clss0hSAQc88tvpZcgGmgVdhsIC0HVOG2MLt9hjOfEes+q
         j7kA==
X-Gm-Message-State: AOAM531Vh2n4rDNRONtFti6C5LZv5/f8ejWC5ZTEUhamneJ9pZwGkLZC
        PBOCHUpLELOcSqJQx1MJnXL2IjFeDGltioKMy92JemlcRiU=
X-Google-Smtp-Source: ABdhPJzCEl/U6jAd9gZie9u995qePO5HbeqyAOQp+VlR8GvlOluQApMKZ6NG5q+ebXoKZzmtlJB0u7JvMD8fN8+QRfs=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr1185807oti.162.1592435669057;
 Wed, 17 Jun 2020 16:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
In-Reply-To: <pull.627.git.1588857462.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 16:14:18 -0700
Message-ID: <CABPp-BET86K_N5_W1pXMWeFccbUdxU8+vNvi+m-i6PX0MrXknw@mail.gmail.com>
Subject: Re: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Another late addition...

On Thu, May 7, 2020 at 6:20 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> IN-TREE SPARSE-CHECKOUT DEFINITIONS
> ===================================
>
> Minh's idea was simple: have sparse-checkout files in the working directory
> and use config to point to them. As these in-tree files update, we can
> automatically update the sparse-checkout definition accordingly. Now, the
> only thing to do would be to ensure that the sparse-checkout files are
> updated when someone updates the build definitions. This requires some extra
> build validation, but would not require special tools built on every client.

"In-tree" still bugs me after a few weeks; the wording seems slightly
awkward.  I don't have a good suggestion, but I'm curious if there's a
better term.

But I really came here to comment on another issue I think I glossed
over the first time around.  I'm curious if all module definition
files have to exist in the working directory, as possibly suggested
above, or if we can allow them to just exist in the index.  To give
you a flavor for what I mean, with my sparsify tool people can do
things like:
    ./sparsify --modules MODULE_A
which provides MODULE_A and it's dependencies while removing all other
directories.  If MODULE_B, is not a dependency (direct or transitive)
of MODULE_A, it will not exist in the working directory after this
step.  Our equivalent of the "in-tree" definition of MODULE_B exists
*in* the directory for MODULE_B, because it seems to make sense for
us.  I want people to be able to do
    ./sparsify --modules MODULE_B
and have it correctly check out all the necessary files even though
the definition of MODULE_B wasn't even in the working directory at the
time the command ran.  (The sparsify script knows to check the working
directory first, then fall back to the index).
