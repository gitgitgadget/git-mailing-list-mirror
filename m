Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E45C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjHASwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHASwm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:52:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D471BC5
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:52:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584375eacacso54939157b3.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915956; x=1691520756;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iR06wBguil39ZqSlbc3avoj+Ce+kYY7HgLgnBLBIRTQ=;
        b=Se4AMlRuHQ3rK6Rh80bvUF7DLJqIpmA6CcxRuJhoIr9JbWMijSox34eMvdpJ+CA9eG
         1UM94OL8Mt1IwIurg6G/Yf9ovGUhH7uzdGzhBTgB5M5o3Cvoin+O2hkjVm/ZDXG7Vvq7
         yx5NTJZzZFJpBV3nXy5loYtP6TqMwWaRdkntY9ZKeIkbbAzeE9s6NG1zdsoPBNSSfHVH
         mbdZmnrKh9ESIOYe81wKlCXmLBOubscPK9fa6xjnHEOJedyQ/m8zPud8kOkIArTnIyrB
         BzrFO/ZJE0aA83aJlBebkufmcGXskHPkReybkoVJMvYDNe8TMJWZ7SjGbdipPW5xRLLf
         Aqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915956; x=1691520756;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iR06wBguil39ZqSlbc3avoj+Ce+kYY7HgLgnBLBIRTQ=;
        b=LaYD9QxClzTYg//WI8MM1cfKuSv1dLi8Xc8ob+mztHxs0aGmDBVIQkHr3HCgv8wwup
         2OagF/1fQf08AQO2HN6fUK8gAp7YDt9gY/a8Vh1BIrILaozrCpLdgLBNHiNJba1hY3Tp
         Vd4Lw5a1x7u1dIo8rG2Cr05KDC5Iuqz12XEmpKsLtcEdLquW5GMTIxvegBIw9rMD5oHg
         SSK1QVWNZCpQcTxHzUnTYBdMt/lOBdVwNyVCZ2j9sFCA5al7uXndZSlr42br2ELgOANG
         vN9XUSlU87iWDVHSINrLbMLk4XTJ1Iw0VPRyM10DVGptPSx09mbDroLgGjPVK8uSvC6Z
         4Cmw==
X-Gm-Message-State: ABy/qLb5EX1IzirvLAVKSGob/r8+DM1B/MqysHxofzcBJz3xrC4BqG4G
        3bAfJ90b0lXhYKHIanWsIoS3ixUwBU0aTgREjCCC
X-Google-Smtp-Source: APBJJlF8UPM0AZ0r6TjdAg6URWxVUEHzWmG7IOE1KFMxugWLF/tcuJvMY0qOX9Rc5jAED0KqMU2XmmNgR63L6IrsoB+N
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a81:af0e:0:b0:579:fa4c:1f22 with
 SMTP id n14-20020a81af0e000000b00579fa4c1f22mr106650ywh.6.1690915955852; Tue,
 01 Aug 2023 11:52:35 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:52:32 -0700
In-Reply-To: <ZMlKMmAs3wKULAOd@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801185232.1457172-1-jonathantanmy@google.com>
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
> On Thu, Jul 27, 2023 at 01:53:08PM -0700, Jonathan Tan wrote:
> > Suddenly reading many (or most) of the repo's trees would be a similar
> > surprise, right?
> 
> That's a good point. I think in general I'd expect Git to avoid
> recomputing Bloom filters where that work can be avoided, if the work in
> order to detect whether or not we need to recompute a filter is cheap
> enough to carry out.

Makes sense. I just don't think that there is a cheap way to detect if
a filter does not need to be recomputed (the closest way I think we have
is something that will require reading a lot of trees in a repo).

> > Also this would happen only if the server operator explicitly sets a
> > changed path filter version. If they leave it as-is, commit graphs will
> > still be written with the same version as the one on disk.
> 
> I think that I could live with that if the default is to leave things
> as-is.

Ah, thanks.
 
> I still think that it's worth it to have this functionality to propagate
> Bloom filters forward should ship in Git, but we can work on that
> outside of this series.

Makes sense.

> > Regarding consulting commit_graph->bloom_filter_settings->hash_version,
> > the issue I ran into was that firstly, I didn't know what to do about
> > commit_graph->base_graph (which also has its own bloom_filter_settings)
> > and what to do if it had a contradictory hash_version. And even if
> > we found a way to unify those, it is not true that every Bloom filter
> > in memory is of that version, since we may have generated some that
> > correspond to the version we're writing (not the version on disk).
> > In particular, the Bloom filters we write come from a commit slab
> > (bloom_filters in bloom.c) and in that slab, both Bloom filters from
> > disk and Bloom filters that were generated in-process coexist.
> 
> Would we ever want to have a commit-graph chain with mixed Bloom filter
> versions?

Probably not, but I wanted to be robust in case a third-party tool wrote a chain with
mixed versions.

> We avoid mixing generation number schemes across multiple layers of a
> commit-graph chain. But I don't see any reason that we should or need to
> have a similar restriction in place for the Bloom filter version. Both
> are readable, as long as the user-provided configuration allows them to
> be.

Yes, that's true - there is no inherent reason why we can't mix them,
unlike with generation numbers.

> We just have to interpret them differently depending on what layer of
> the graph (and therefore, what Bloom filter version they are) they come
> from.
> 
> Sorry for thinking aloud a little there. I think that this means that we
> at minimum have to keep in context the commit-graph layer we found the
> Bloom filter in so that we can tie that back to its Bloom filter
> version. That might just mean that we have to tag each Bloom filter with
> the version it was computed under, or maybe we already have the
> commit-graph layer in context, in which case we shouldn't need an
> additional field.
> 
> My gut is telling me that we probably *do* need such a field, since we
> don't often have a reference to the particular layer that we found a
> Bloom filter in, just the tip of the commit-graph chain that it came
> from.

We'll need the additional field because we don't know which commit graph
layer it comes from. In fact, we don't even know which *repo* the commit
comes from, since the commit slab is global. (Moving the slab to being
under a repo or under a commit graph layer would fix this.)

But I think there still remains the question of whether we really need
to support multiple versions in one Git invocation.

> > I also thought of your other proposal of augmenting struct bloom_filter
> > to also include the version. The issue I ran into there is if, for a
> > given commit, there already exists a Bloom filter read from disk with
> > the wrong version, what should we do? Overwrite it, or store both
> > versions in memory? (We can't just immediately output the Bloom filter
> > to disk and forget about the new version, only storing its size so that
> > we can generate the BIDX, because in the current code, generation and
> > writing to disk are separate. We could try to refactor it, but I didn't
> > want to make such a large change to reduce the possibility of bugs.)
> > Both storing the version number and storing an additional pointer for a
> > second version would increase memory consumption too, even when
> > supporting two versions isn't needed, but maybe this isn't a big deal.
> 
> It's likely that I'm missing something here, but what is stopping us
> from discarding the old Bloom filter as soon as we generate the new
> one? We shouldn't need to load the old filter again out of the commit
> slab, right?
> 
> Thanks,
> Taylor

I did not look at the code closely enough except to see that there was
a gap between generating the new-version Bloom filters and writing them
to disk, and I was concerned that now, or in the future, there would
be some code in that gap that reads the Bloom filter for a commit and
expects the old-version Bloom filter there.
