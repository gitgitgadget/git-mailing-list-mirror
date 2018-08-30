Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F75D1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 09:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeH3NFw (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 09:05:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34357 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeH3NFw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 09:05:52 -0400
Received: by mail-qk0-f193.google.com with SMTP id d15-v6so5267649qkc.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 02:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfO0grg9Tpvp90YKkLh0D1ZMUMUmFyakMsTqGCDuLRs=;
        b=NXWMan5V8Bvw+uswHIu80AmWDiROdjYhiFw/Zhcdw/Jm0pVMyXOLKXjvwpMTbHGk4A
         TaEjaJv0GRaY8O2YHoSgD9zR0wCy3xquqlmhLh0f1W126c1B6Am4uUc4g1MASaKqT+o/
         sj8ytzDwdsj1dYzmN2Cu4Z554/py40Wta6/4NQvTTMDzzy3BMODd3kTeFrQgL14q1qHA
         UUA1uQJUBqYur1k/Jr4RAqeO25Jzlp/Q4zbV2OJiK5WddfoMxVDbM7QaiewSn5CGzMio
         UiBMb+EPKLfteR7eeH4PvtwriK2yUOJv6YwR1TTHahd5T/VyrFR+1Um1s267BvGRYG1s
         6+hg==
X-Gm-Message-State: APzg51BpU3xvcJ0wLAKIvKSvXjOyYZmvIGwTAP1+0likFei8bPjMqnB+
        amoltY9h4ccCaYpZZaS1KvgTgkFvSQgC6HB4FNs=
X-Google-Smtp-Source: ANB0VdaLnZ30wm8t/kGIQS0HoC160lS2H5sJNevBdSBejF8G8VzARJtPNURgPCRbPuMLvw5MNDuZ3WWAQKPif4DIxAQ=
X-Received: by 2002:a37:4653:: with SMTP id t80-v6mr9970046qka.314.1535619884267;
 Thu, 30 Aug 2018 02:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com> <20180830075431.GF11944@sigill.intra.peff.net>
In-Reply-To: <20180830075431.GF11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 05:04:32 -0400
Message-ID: <CAPig+cS3-oRzQrZGM_-pXUVFE3HvMdtODurPkmYgw1vFV8zb3Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:54 AM Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] doc-diff: force worktree add
>
> We avoid re-creating our temporary worktree if it's already
> there. But we may run into a situation where the worktree
> has been deleted, but an entry still exists in
> $GIT_DIR/worktrees.

Can "clean" or "distclean" also be augmented to remove this worktree
(and directory)? I guess that "distclean" would make more sense than
"clean"(?).

> Older versions of git-worktree would annoyingly create a
> series of duplicate entries. Recent versions now detect and
> prevent this, allowing you to override with "-f". Since we
> know that the worktree in question was just our temporary
> workspace, it's safe for us to always pass "-f".

Makes sense, and the patch looks correct.

> Signed-off-by: Jeff King <peff@peff.net>
