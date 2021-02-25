Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D553AC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 04:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F864ED3
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 04:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhBYEy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 23:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhBYEy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 23:54:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E65C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 20:54:17 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mm21so6350204ejb.12
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p68GnSd2I5F7Jey80K8TOggKYHLEqOOIbJHGHTxMccU=;
        b=UkITpGhPZCfrHeO7FjbgVyzuCwY6xyLT9sfExl1o/KuxaTh1zw1yMk1WuT+zwe6r4L
         cTmJUcCClRTo4R2vR/XmB+HrtsvVqZ7ZPr/mhKwJ4GEVheHP4B+VGDSrskcF95rhshO9
         yRnsGPTuPd450EfXLEUw/8u50aTFHfriT6YU7QU6kiXQsDKwMsKJGUzKMb+FiXIb5epn
         sLg0pxk4T2dm8xSG/Z+nP2Uf54g9Uw2/xOqfjCS634lUJg666IzjSgP95yR72/CJmm8D
         JP+Tzno3FjWye5b6kDzPpBfGR6uH9mYSvs9ufWdIm5rWGnJG+WAzS6GRzkJHZV0hAhnl
         2xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p68GnSd2I5F7Jey80K8TOggKYHLEqOOIbJHGHTxMccU=;
        b=tNGMfpESad6a1r6Y6/uktCRkyJVsGpu5hd+SAv+7FdiT3lfv7JEXomWQeg+krv7vZV
         4eAtcGk4u+LyjkzobqDCRqt4cwgsfZv5cwHcPJXFLnmwkLkO3fdxHgp9BMfOYfddGNfI
         M9lceHcx1hDpPmiH/KWq2jNKHhRvxRZgM6mXfN9IqfiAF8vR0pLnEeNxMThwoY1J18zh
         PH0TxiXH1JDidlCQHv5ijyFuJdXKYOM+4mnN2fHUEf/NdBT3sKj6ZsvsCNRmbDttN5eX
         Bo5P3YC/W1oFDF5t1L5CMcBmriuLqR2MJ1rM0HxOceDFWudhJ2FxmjiRKoGr0KVypq0O
         viZg==
X-Gm-Message-State: AOAM532ryT6d48lgSSTjhSudJMBUEtfrLZDVM1NesAcoZN5eDvqiqlXr
        g53dvbVc1Ic9qGTtjvzzqizBh1thifeu+wpiBzVz5A==
X-Google-Smtp-Source: ABdhPJw4UAeZkl/SZ1JQc3ZkZkA8SrTmGdjWwn1TXbKO04zf8OZ0FCvl6WGKtEeksvsQzgN//9AwQ8SR/RTwHz0MS2M=
X-Received: by 2002:a17:907:d86:: with SMTP id go6mr888266ejc.337.1614228856389;
 Wed, 24 Feb 2021 20:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20200629220744.1054093-1-jonathantanmy@google.com> <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com>
In-Reply-To: <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 24 Feb 2021 20:54:05 -0800
Message-ID: <CAGyf7-G_OdS_0o7j64HA79n9Qv13SxciQSG+gfY7Qj8kNRQS5Q@mail.gmail.com>
Subject: Re: Commit graph chains with no corresponding files?
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 29, 2020 at 6:51 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/29/2020 6:07 PM, Jonathan Tan wrote:
> > At $DAYJOB, a few people have reported "warning: unable to find all
> > commit-graph files" warnings. Their commit-graph-chain files have a few
> > lines, but they only have one commit graph file with very few commits. I
> > suspected something happening during fetch, because (as far as I know) a
> > fetch may cause an incremental commit graph to be written, but I ran a
> > fetch on a large repository myself and didn't run into this problem.
> >
> > Has anyone ran into this problem before, and know how to reproduce?

I don't have any specific reproduction steps, but we've just run into
our first case of this on Git 2.29. I ended up kicking off a full `git
commit-graph write` to fix it. That displayed the same warning, but
commands run after it no longer do. Prior to writing the new graph, I
had this:
$ ls
commit-graph-chain  graph-88f5fe6e0c659e3742e556982263813d528ead81.graph

Afterward, the `objects/info/commits-graphs` directory still exists
but is empty, and there is now an `objects/commit-graph` that didn't
exist before. `git commit-graph verify` seems happy with the state of
things.

>
> The incremental commit-graph code deletes any commit-graph files
> that do not appear in the chain. I believe this is done by comparing
> the contents of the ".git/objects/info/commit-graphs/" directory to
> the contents of the chain file.
>
> These appear to be case-sensitive, full-path comparisons.
>
> It is _possible_ that something like a case switch or a symlink
> could be causing a problem here. That's where I would look on
> the affected systems.

Are commit graphs potentially problematic in repositories that are
borrowing objects from other repositories via alternates? Have there
been important changes to commit graphs since 2.29?

>
> Likely the full-path comparison in expire_commit_graphs() should
> be dropped in favor of local filename comparisons. A case-
> sensitive match is less likely to be important here since Git
> is writing the paths itself and should get the proper case back
> from the directory listing.
>
> Thanks,
> -Stolee
>

-b
