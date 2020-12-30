Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6924FC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286E72072E
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL3UUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3UUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 15:20:36 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E1AC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:19:55 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o11so16427504ote.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9VD5JAZSmEGo7W0jUZbHCNHfkBKnzND8iUGAYHblGI=;
        b=iIDZrGo8QRIY607HCQBibZvFEKbpo2jllfS7deyvOFNXw793GIt4aDHA2IJ3B7RXx8
         EMLT/zsUOTcMPZTMfkloQ6PtqzeTQtTVxvXUzJ98kVOS3EmnD953yo3ZT/vyseFwtPNu
         exGsWVSd4fwyIiz6Yac1vPPbLC4pkM5E2m604M9lW7yNE7C1F1765cYSKKYdaeHieGal
         pCVnKMKtmb1Q/yrmMCax64HwoFqOFP3nUTMBsPpVwON+OJM4qP/DKqLRVe/ChhpJqDM7
         k+70lJwOY+8fUUM/LpI121dDAwtrd8QUNDzQk/GqrVQWPm8If8CY7sAJgDrahFy0Sz19
         DB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9VD5JAZSmEGo7W0jUZbHCNHfkBKnzND8iUGAYHblGI=;
        b=MRD8tX403EPxTvxvydvaZiM+q6uBCRG4hmnqDx8vOlp/JAzDATv9/1M9RQl1L4Y/hD
         Pbn9P1AtaP4YdTh1UY8xwawds22EhuGvTtXlEx5an0uXqetZ7EoNbtNjxpONONv4iC9x
         ePguiIDFdWdpH5gUM/FWS7+fUF3Vh9fV5osLlY9VWHnwcfWL1ax1iYMPdlpCH1KxJ+BC
         COea93BS09150JYrXVEkobQrmlqD+cay+uNXUCwYZFO9ehkol1Whcp+yMnD2tfna2Tbb
         TvLVznMc/yY5Kb1ImOfnSrVZKigZFEfNJ+R0Ls7hbQh+ujN3dNPdWfvHVSWDFLofA48k
         WduQ==
X-Gm-Message-State: AOAM530+8iOH1bWk+BUDVuH4lOqKkbFIxKSLb/VqgyWZWAJ74ceqZOGI
        QvYPR6jUF+M1TZPdj86CXTt4FO9FfOdvCYgu6jkjfViC
X-Google-Smtp-Source: ABdhPJzdfzwIfmKQji6/SwA1pfeNi3DxEGKeBi8B/YsmPgve28AEBg9eK5YNCOsYzeos4vb09linir52dBQxWqWx7dM=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr40145635otr.345.1609359595093;
 Wed, 30 Dec 2020 12:19:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 12:19:43 -0800
Message-ID: <CABPp-BG6iiQ=_SvGEFCGnYe+z57op+b6vWfJmw=w_0eikzpvCA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Cleanups around index operations
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> I've taken a professional interest in the index lately, and I've been trying
> mostly to learn about it and measure different operations. Along the way,
> I've seen some possible improvements in documentation, behavior, and
> tracing.
>
> This series collects most of my thoughts so far, including:
>
>  1. Adding extra trace2 regions and statistics (similar to [1]) (Patches
>     1-5).
>  2. Update documentation about the cached tree extension (Patches 6-7).
>  3. Removing an unnecessary loop from verify_cache() (Patch 8).

The series seems pretty simple and clean to me.  As I mentioned on
patch 6, though, I don't know much about the cache-tree extension
myself (I show up in blame/log due to moving a function there with
just some slight tweaks), so it'd be nice if someone who does can take
a look at the documentation added in patch 6.
