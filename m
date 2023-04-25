Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4604C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjDYSyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjDYSyn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:54:43 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848018B91
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:54:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-552a6357d02so73249417b3.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682448828; x=1685040828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzRVawEshoOyNwjypcPKtXCqSWuGPvlfBQqt+tIOlbQ=;
        b=ewkf3XmD47zfum39Go81fZ0LfUZYCjOW+DbQf7iyK/vYo7GUfzImDAu6OoRJ2H8l8Y
         UWYq0k2g2E0uI9n3a0CqEMpw2G4b0WLcgQaiRqDBJ9n5a2OuDysdUVpvuVlNw1o8FMhC
         rFuNzaPrpAtXF/A4hUeDYnw9LVd+qbPuuDOi8gQxfWyLRlpHyI9mVAW54RwHBExERYmh
         NLA6qDgtonKv/P051MtN/qd5ACSXHSTEPkEUkEyZXARq4EvR/dsKrBUfqVtBwXiNMAWz
         k0m0SwyIQqS/OuoGe6kAs6kLXTwrJNfshe1zXTurBFjC6dnh2h91QrNreiYwT0qpuqpz
         7h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448828; x=1685040828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzRVawEshoOyNwjypcPKtXCqSWuGPvlfBQqt+tIOlbQ=;
        b=EHEr9jTJFTGGeFX73SOoCuKQihAm6mzEEruPTZPIQSS1fthrQZH4mMnwuHU/5Kv1m3
         avXT9BKRqur6164scSn9Pa+SpwFjEqnZAWllNQ1F114FCg64W5BYGFq5JQobv7hfzSAe
         Km9LwmY+eT2ElVTyCW/TVK9nRQfRf+sqvlDTwazoGObgjhwZKFvA12yhE7eAfQFlxArD
         URuw4f097xXeDUEfqc+yqCM0tgjv12J9bnKnW5YRDFxPzHFiTPdk4VteINzQoyklBtf0
         9Up/rquNVtOMnnkI8C6LYJGq2uMgC8+3fxSRsu+lVfrqpsfWl5psuLu8aWzm/75topz4
         vXCQ==
X-Gm-Message-State: AAQBX9cqtugTocTddL66BYwH9tL5EXTQ/R3iclsUfH54Djj+HK/nLjsc
        827y+oXo3JKhwQu7jk+TkNNE
X-Google-Smtp-Source: AKy350ZNk5LJJDuCdRr4mGvoc6VBTH1cvA8IFrYUD74IVcGD8ffs04esYC+0YZEQZdHiFnB2kw9LfQ==
X-Received: by 2002:a81:5f83:0:b0:556:300c:d653 with SMTP id t125-20020a815f83000000b00556300cd653mr9686217ywb.40.1682448827674;
        Tue, 25 Apr 2023 11:53:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id y195-20020a0dd6cc000000b0054f9a3b60a1sm3761209ywd.33.2023.04.25.11.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 11:53:47 -0700 (PDT)
Message-ID: <a143150d-7cf5-c697-0e48-0f7af1c6de8f@github.com>
Date:   Tue, 25 Apr 2023 14:53:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/24/2023 8:00 PM, Taylor Blau wrote:
> When reachability bitmap coverage exists in a repository, Git will use a
> different (and hopefully faster) traversal to compute revision walks.

Before getting into the code...

> Consider a set of positive and negative tips (which we'll refer to with
> their standard bitmap parlance by, "wants", and "haves"). In order to
> figure out what objects exist between the tips, the existing traversal
> in prepare_bitmap_walk() looks something like:

>   4. Construct a reachability bitmap for the "haves" side by walking
>      from the revision tips down to any existing bitmaps, OR-ing in any
>      bitmaps as they are found.
> 
>   5. Then do the same for the "wants" side, stopping at any objects that
>      appear in the "haves" bitmap.

One important thing about this older algorithm is that it will avoid
including trees and blobs that are reachable from the "haves" that
are not reachable from the boundary between "haves" and "wants". The
most obvious case is that someone force-pushed a branch after rewording
the commit messages but keeping the trees and blobs identical.

This case is rare, and usually the objects that would be repeated are
low enough in count and size (with deltas) that it's not a big deal, but
it is worth bringing up. I didn't see a reference to this side of the
difference in your message.

> One of the benefits, however, is that even if the walk is slower, bitmap
> traversals are guaranteed to provide an *exact* answer. Unlike the
> traditional object traversal algorithm, which can over-count the results
> by not opening trees for older commits, the bitmap walk builds an exact
> reachability bitmap for either side, meaning the results are never
> over-counted.

So the new algorithm is a new, third state of "not overcounting things
reachable beyond the commit-walk boundary" and "overcounting things
reachable from the wants..haves commit region".

> But producing non-exact results is OK for our traversal here (both in
> the bitmap case and not), as long as the results are over-counted, not
> under.

True, our response will not create a pack-file that cannot be applied
locally, but it might be larger than required.

For these reasons, I'm surprised that this patch completely replaces
the old algorithm for the new one. I would prefer to see a config
option that enables this new algorithm. It would be safer to deploy
that way, too.

> The new result performs significantly better in many cases, particularly
> when the distance from the boundary commit(s) to an existing bitmap is
> shorter than the distance from (all of) the have tips to the nearest
> bitmapped commit.

Aside: we may even gain benefits by adjusting the commits selected for
bitmaps by trying for this data shape. One way to attempt this is to
not focus on refs but on history common to "most refs" using first-
parent history as a good heuristic. If a commit appears in a lot of
first-parent histories, then it is more likely to be helpful to these
kinds of walks.
 
> Note that when using the old bitmap traversal algorithm, the results can
> be *slower* than without bitmaps! Under the new algorithm, the result is
> computed faster with bitmaps than without (at the cost of over-counting
> the true number of objects in a similar fashion as the non-bitmap
> traversal):
>
>     # (Computing objects unique to 'master' among all branches, not
>     # using bitmaps).
>     $ time git rev-list --count --objects master --not --exclude=master --branches
>     54

I like how you included the output of --count here. It might be interesting
to demonstrate the different forms of overcounting in a carefully constructed
test case, which would help us be sure that we are using the desired
algorithm during a test case.

>     real	0m1.012s  (no bitmaps)
>     real	0m29.571s (bitmaps, old)
>     real	0m2.279s  (bitmaps, new)

> The new algorithm is still slower than not using bitmaps at all, but it
> is nearly a 13-fold improvement over the existing traversal.
 
> In a more realistic setting (using my local copy of git.git), I can
> observe a similar speed-up:
...
> Here, the new algorithm is also still slower than not using bitmaps, but
> represents a 4-fold improvement over the existing traversal in a more
> modest example.

Interesting that the new bitmap algorithm is worse in all presented cases.

How "atypical" do we need to be in order for bitmaps to outperform the
tree-parsing algorithm? Do we need to try "--branches --not master~1000"
to replicate a stale single-branch clone getting every latest commit?

(I'll leave code review to a separate reply.)

Thanks,
-Stolee
