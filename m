Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B680EC001DC
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 20:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjG0UxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjG0UxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 16:53:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D05A110
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 13:53:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so13284467b3.2
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690491190; x=1691095990;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xEh5Fimye2+l1zFaT4uh430sF/BQ0ZWOE7ZZnusoQUM=;
        b=JLGwnRkBSoNEO73mnTHicXRcipDoogS9BImxKIEUnlOZhurxShRAdBFwA/h6sCdhuY
         k8ciwqMZyf+4TgmrcpsmRr6YE8vrtE68BZZRflA9ZtVnoiYC3XyY5UeKYTWedhu+J6Sk
         H+kNjO0sLl6xARL1XQYlvLvFiuorRYD2HCq3mDWmPI/Q44SaP0WIoS5pQbWxN8p58nWt
         jvScFZdaIIVwyGhxYEvG0RmKy9seb9cNknhwnMazJgHhEXc0GawPORGnOFEu8t0G7oTp
         G0+qLQ9QTxIjSjxqPkuotzNEMptwE53s6WVyS2i6ZLLVm15Kp/zZnntEJ95zco0Jbo4F
         jeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690491190; x=1691095990;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEh5Fimye2+l1zFaT4uh430sF/BQ0ZWOE7ZZnusoQUM=;
        b=BDxhm03O1hRc2ioB/FplmXXSgGfhvJwSM/5LoUQgRYGAlQFl5C2/rtRPCTk9lLkhvF
         pqfPUUwxYEVJz7IRqb4Tq1QSOtSKH225+I0/Z7k1Z1K/3PhRngPfl11AcVEqfoZcNkP+
         fK8HugolsK8VNECjc+LtBdgVangWGG6s8+jeJP7kHzv/M96rG9W1bXUw4KlM58e7POax
         F+XqTtGoJJ/LjIkJCYo2BupVVkooMUuw5H+ma5/fQWNwph7ClkXqE488y4ZCfVpFIuF3
         MyiHJWZ2+twBp6kBCkMtPnwJFlgO/tv/hhCB22AWu4zB8Rf72YMMETXCnpgn76pUUAU1
         ohqQ==
X-Gm-Message-State: ABy/qLb6V40soKDczbiU9ab7eyT6XE6snhIyWPLChyBlLm9tk3R+WvxB
        BSbsQBbXrhnN5y/76bOg3rI8E4QuKzGxPjMYgocr
X-Google-Smtp-Source: APBJJlF5J7uXIk7yvgqC8JquaSdSDuXRkbroXyINHEqSjJoGX8lZROxG+Qr/lI5Iru715KAPoqSCB/mXyEFqQOOVVkfA
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:75fe:2dd0:bffd:cf43])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ec09:0:b0:56c:e585:8b19 with
 SMTP id j9-20020a81ec09000000b0056ce5858b19mr3580ywm.2.1690491190464; Thu, 27
 Jul 2023 13:53:10 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:53:08 -0700
In-Reply-To: <ZMKvsObx+uaKA8zF@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727205308.401364-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> > The intention in the current patch set was to not load it at all when we
> > have incompatible Bloom settings because it appeared quite troublesome
> > to notate which Bloom filter in memory is of which version. If we want
> > to copy forward existing results, we can change that, but I don't know
> > whether it's worth doing that (and if we think it's worth doing, this
> > should probably go in another patch set).
> 
> Yeah, I think having Bloom filters accessible from a commit-graph
> regardless of whether or not it matches our Bloom filter version is
> prerequisite to being able to implement something like this.
> 
> I feel like this is important enough to do in the same patch set, or the
> same release to avoid surprising operators when their commit-graph write
> suddenly recomputes all of its Bloom filters.

Suddenly reading many (or most) of the repo's trees would be a similar
surprise, right?

Also this would happen only if the server operator explicitly sets a
changed path filter version. If they leave it as-is, commit graphs will
still be written with the same version as the one on disk.

> Since we already store the Bloom version that we're using in the
> commit-graph file itself, shouldn't it be something along the lines of
> sticking that value onto the bloom_filter when we read its contents?
> 
> Although I don't think that you'd even need to annotate each individual
> filter, since you know that every pre-existing Bloom filter you are able
> to find has the version given by:
> 
>     the_repository->objects->commit_graph->bloom_filter_settings->hash_version
> 
> right?
> 
> Thanks,
> Taylor

Regarding consulting commit_graph->bloom_filter_settings->hash_version,
the issue I ran into was that firstly, I didn't know what to do about
commit_graph->base_graph (which also has its own bloom_filter_settings)
and what to do if it had a contradictory hash_version. And even if
we found a way to unify those, it is not true that every Bloom filter
in memory is of that version, since we may have generated some that
correspond to the version we're writing (not the version on disk).
In particular, the Bloom filters we write come from a commit slab
(bloom_filters in bloom.c) and in that slab, both Bloom filters from
disk and Bloom filters that were generated in-process coexist.

I also thought of your other proposal of augmenting struct bloom_filter
to also include the version. The issue I ran into there is if, for a
given commit, there already exists a Bloom filter read from disk with
the wrong version, what should we do? Overwrite it, or store both
versions in memory? (We can't just immediately output the Bloom filter
to disk and forget about the new version, only storing its size so that
we can generate the BIDX, because in the current code, generation and
writing to disk are separate. We could try to refactor it, but I didn't
want to make such a large change to reduce the possibility of bugs.)
Both storing the version number and storing an additional pointer for a
second version would increase memory consumption too, even when
supporting two versions isn't needed, but maybe this isn't a big deal.
