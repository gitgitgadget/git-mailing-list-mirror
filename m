Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A5EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjGNSsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjGNSss (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 14:48:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA730DA
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 11:48:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso18521377b3.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689360526; x=1691952526;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0QfUbEziABSBZvqTUhNFVCtr8czygzeNBpBzaGnnUlM=;
        b=OdoBdazXrIzCbNnUz+jyQOQ5FkflbcOkgrsRZ6ZU7e2M0nfLAA2Sg7TwZDT51aJSQF
         2mGyadlin7dQUlXvdmaWfMhiSJAhuS/KAUoijaVeYnS+miUha7EU8GDBVxWJ8y4fgr56
         9BhJ3sirxRxXaB0UrtxzJpPL3GxU3YPj2Dow/2IcOqMQ1aSFBbIHFH9zEevn8BnKp+H5
         Fc9Re+v3btimkjG8xKfKkXueg6OUSUEjn67GJjMve+lxQ3KWLPQQWGduqhRYB/U3726j
         tV2pHIsSUlAE1WH9i6gjdf44BW6+KqawAZ81H4MDAJZryRkf51daTPoQ2fOhSRFLYopB
         5dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360526; x=1691952526;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QfUbEziABSBZvqTUhNFVCtr8czygzeNBpBzaGnnUlM=;
        b=OdH6nHz/2hP8qciWxEkoDKZH3Q2SW0fb8KtFFKaywdvWPre9WlPislmTprOIoy/9cx
         5CmXpoO4CJxYNnvxOX12DiqpRKaHrCrR87olww2fFKwkIx8btx5N3ttkdFcSPMQ66lC4
         AtPWbNYylGtgRx93GCWHVSX2vb5jU4CM1rDCh/B5Y3bHII9O8BdIhyk5vVgJ9t0Oq1JL
         j4EYLDSDcAHRsYhZ5PhJCwYALRkCZwY6St0wEs7MpHZnilgFel/PV0yQM3bbUcmXzXPA
         yvRf65Soi324Y4Hrwc8HG7gNo5lg/BwHAABCoz7mnRniLDmxXEc+dPVdrw8+c9C247sm
         qGBQ==
X-Gm-Message-State: ABy/qLYcYoD1CFx8gaiqCcIuwy5vpvh95/TpAXduTEFKDSMhQjqS+zZL
        Nx18jrQfA22gr1LpvGmYTMUGkok3RledYTDPpcyt
X-Google-Smtp-Source: APBJJlHggRoZ+UMWa1gGD4IXNBbxt9sZQndOck+2U/MVAIT9rwWeyM4GYQpp1SccJ40i3iS+7NJs7hdqtoVCfMNo3xUv
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:db41:f17c:70c4:c573])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ae43:0:b0:c5d:2380:23d6 with
 SMTP id g3-20020a25ae43000000b00c5d238023d6mr27990ybe.7.1689360526209; Fri,
 14 Jul 2023 11:48:46 -0700 (PDT)
Date:   Fri, 14 Jul 2023 11:48:43 -0700
In-Reply-To: <xmqqlefjlanl.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714184843.1360071-1-jonathantanmy@google.com>
Subject: Re: [PATCH v5 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> >          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> >          Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >     @@ Documentation/config/commitgraph.txt: commitGraph.maxNewFilters::
> >      -	If true, then git will use the changed-path Bloom filters in the
> >      -	commit-graph file (if it exists, and they are present). Defaults to
> >      -	true. See linkgit:git-commit-graph[1] for more information.
> >     -+	Deprecated. Equivalent to changedPathsVersion=1 if true, and
> >     ++	Deprecated. Equivalent to changedPathsVersion=-1 if true, and
> >      +	changedPathsVersion=0 if false.
> 
> I forgot to comment on this part earlier, but does the context make
> it clear enough that these `changedPathsVersion` references are
> about `commitGraph.changedPathsVersion` configuration variable
> without fully spelled out?  They sit next to each other right now,
> so it may not be too bad.  If they appeared across more distance,
> I would be worried, though.

Ah, probably better to spell it out. I'll change it.

> >      +commitGraph.changedPathsVersion::
> >      +	Specifies the version of the changed-path Bloom filters that Git will read and
> >     -+	write. May be 0 or 1. Any changed-path Bloom filters on disk that do not
> >     ++	write. May be -1, 0 or 1. Any changed-path Bloom filters on disk that do not
> >      +	match the version set in this config variable will be ignored.
> 
> So, any time the user configures this to a different value, we will
> start to ignore the existing changed-path-filters data in the
> repository, and when we are told to write commit-graph, we will
> construct changed-path-filters data using the new version?

Yes.

> >     -+Defaults to 1.
> >     ++Defaults to -1.
> >     +++
> >     ++If -1, Git will use the version of the changed-path Bloom filters in the
> >     ++repository, defaulting to 1 if there are none.
> 
> OK, that was misleading.  The configuration can say "-1" and it does
> not mean "I'll ignore anything other than version -1"---it means
> "I'll read anything".  The earlier statement should be toned down so
> that we do not surprise readers, perhaps

Ah, good point. Will do.

>     When set to a positive integer value, any changed-path Bloom
>     filters on disk whose version is different from the value are
>     ignored.
> 
> to signal that 0 and negative are special.  Then the readers can
> anticipate that special cases are described next.
> 
>     When set to -1, then ...
>     When set to 0, then ...
>     Defaults to -1.
>     
> When set to the special value -1, what version will we write?
> 
> >      +If 0, git will write version 1 Bloom filters when instructed to write.
> 
> And we will only read 0 and refuse to read 1?  Or we will read both
> 0 and 1?
> 
> Thanks.

Currently, there is only version 1 (no version 0) and after all the
patches in this patch set are applied, there will be version 1 and
version 2. I think that with your suggestions above, it will be clearer
to the reader.
 
