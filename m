Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD60202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 22:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdIUWvz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 18:51:55 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:45851 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUWvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 18:51:54 -0400
Received: by mail-pf0-f180.google.com with SMTP id z84so3924379pfi.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYcj/veyQyq6QsDhev6dLsWKIIg08tDryh1Wi5O2Cbg=;
        b=srEAOyQXkwIl109Rvnm0ABH24YYWG+46D9u1fVFpWQYmBK5+UCbtG8ARJkto33xwXE
         9pLBDQcbfkr8GExFrVesSuNEnk4GaczdWdGu2sGAQQJCe4gj7cGS9p14IVLBChw/hP73
         OI+7EEKtWkbh/+8YovMNgRViAJ4GKlqkehGV4zY9MuQaIvleq2GpB6RRZvKuSdaj6V5Q
         0PJTZ+cdT7m58Zes4QvpgqOWhujCatQK+2Sv3B+gbESHL3ztBv4sgtYTXNA+b3U2RV7z
         HS3TZmNksHEAuvpnnND3/n01Or1epQQB+mQsYVphJZRuPu+2Ish+zNV8rCTXhJn3ltSQ
         fAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYcj/veyQyq6QsDhev6dLsWKIIg08tDryh1Wi5O2Cbg=;
        b=Gr7Oj8cjH2l/FTBMV7HUpBBlSjXRxyeYRCLqkiYgFDQzE05p5L5ZlrUw9q0ukZrhOq
         Nsk0wNqAiOJjdty89Dot/RbGJZi8r3b+ePm8Q1Ln4ve2ARGRhx7J6aQ1vgh5cSNSiRds
         MDmc3yYu/JsNSptm+ugWy1Dn9wNPjrmYb0ddNyz+G/I6kCK4la2ugQ+8KOEu2Ce2tTMz
         3pkhYfarqaFbLBOWpoZTpKRaqNGK8utkWk5+Hk5jG3Ei3DAneAQ22pnDeeuoL/EdKyEI
         w5RoK3K3ouLl7P9o1poeBxIoOSXgjjDlv4CFMqPKwFdgMCmORrvL+uIr4yCkUOmPq9d/
         16zw==
X-Gm-Message-State: AHPjjUgMoWSIWdh76g0RFQCTIRu6INoyR3ZK4IJGK3eRXowC0OJx0cMz
        Bunv0k6m7Xtu2cg+9ZQLTuSGdA==
X-Google-Smtp-Source: AOwi7QCekO6GGVhSGHHO4455unyzmgvzecbnorYbS/zYxX9IkqJVP7VVQ2W8zOw+C8VrAMFSWD2uag==
X-Received: by 10.99.186.74 with SMTP id l10mr7422269pgu.355.1506034313171;
        Thu, 21 Sep 2017 15:51:53 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:b4a5:cd04:4e1a:a2a0])
        by smtp.gmail.com with ESMTPSA id s4sm3624468pgr.32.2017.09.21.15.51.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 15:51:52 -0700 (PDT)
Date:   Thu, 21 Sep 2017 15:51:50 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK) (part 2/3)
Message-ID: <20170921155150.1d57d89e@twelve2.svl.corp.google.com>
In-Reply-To: <5d295ab3-310e-321e-6e88-69484eb9ce8a@jeffhostetler.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <5d295ab3-310e-321e-6e88-69484eb9ce8a@jeffhostetler.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 21 Sep 2017 13:59:43 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> (part 2)
> 
> Additional overall comments on:
> https://github.com/jonathantanmy/git/commits/partialclone2
> 
> {} I think it would help to split the blob-max-bytes filtering and the
>     promisor/promised concepts and discuss them independently.
> 
>     {} Then we can talk about about the promisor/promised
> functionality independent of any kind of filter.  The net-net is that
> the client has missing objects and it doesn't matter what filter
> criteria or mechanism caused that to happened.
> 
>     {} blob-max-bytes is but one such filter we should have.  This
> might be sufficient if the goal is replace LFS (where you rarely ever
>        need any given very very large object) and dynamically loading
>        them as needed is sufficient and the network round-trip isn't
>        too much of a perf penalty.
> 
>     {} But if we want to do things like a "sparse-enlistments" where
> the client only needs a small part of the tree using sparse-checkout.
>        For example, only populating 50,000 files from a tree of 3.5M
> files at HEAD, then we need a more general filtering.
> 
>     {} And as I said above, how we chose to filter should be
> independent of how the client handles promisor/promised objects.

I agree that they are independent. (I put everything together so that
people could see how they work together, but they can be changed
independently of each other.)

> {} Also, if we rely strictly on dynamic object fetching to fetch
> missing objects, we are effectively tethered to the server during
> operations (such as checkout) that the user might not think about as
> requiring a network connection.  And we are forced to keep the same
> limitations of LFS in that you can't prefetch and go offline (without
> actually checking out to your worktree first).  And we can't bulk or
> parallel fetch objects.

I don't think dynamic object fetching precludes any other more optimized
way of fetching or prefetching - I implemented dynamic object fetching
first so that we would have a fallback, but the others definitely can be
implemented too.

> {} I think it would also help to move the blob-max-bytes calculation
> out of pack-objects.c : add_object_entry() [1].  The current code
> isolates the computation there so that only pack-objects can do the
> filtering.
> 
>     Instead, put it in list-objects.c and traverse_commit_list() so
> that pack-objects and rev-list can share it (as Peff suggested [2] in
>     response to my first patch series in March).
> 
>     For example, this would let the client have a pre-checkout hook,
> use rev-list to compute the set of missing objects needed for that
> commit, and pipe that to a command to BULK fetch them from the server
> BEFORE starting the actual checkout.  This would allow the savy user
> to manually run a prefetch before going offline.
> 
> [1]
> https://github.com/jonathantanmy/git/commit/68e529484169f4800115c5a32e0904c25ad14bd8#diff-a8d2c9cf879e775d748056cfed48440cR1110
> 
> [2]
> https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/

In your specific example, how would rev-list know, on the client, to
include (or exclude) a large blob in its output if it does not have it,
and thus does not know its size?

My reason for including it in pack-objects.c is because I only needed it
there and it is much simpler, but I agree that if it can be used
elsewhere, we can put it in a more general place.

> {} This also locks us into size-only filtering and makes it more
>     difficult to add other filters.  In that the add_object_entry()
>     code gets called on an object after the traversal has decided
>     what to do with it.  It would be difficult to add tree-trimming
>     at this level, for example.

That is true.

> {} An early draft of this type of filtering is here [3].  I hope to
> push up a revised draft of this shortly.
> 
> [3]
> https://public-inbox.org/git/20170713173459.3559-1-git@jeffhostetler.com/

OK - I'll take a look when that is done (I think I commented on an
earlier version on that).
