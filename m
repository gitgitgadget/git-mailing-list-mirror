Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BCC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BA6610A2
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFOVra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhFOVr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:47:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1426C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:45:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so180073oiv.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8L+INDaDk3NZHG4dO7/ktGDuXVcXD+VVuQnCeepwdRU=;
        b=DxGPUCd/QCPZ5eItCPp2nv779N9h9wtUJaM8qkysHA/SUKxEe+XJaapK0B1o1Coag4
         yiTM9qUBzHEnoTSJJNOOc6RRLe77CaQqQgKUB40xLNv7Ti0ap827ySGrbOrVPukYtqaU
         QaAMjXjNye626/OTY56w3iHKthQkycDvaaGNbG/B7+n5OvFcWAlsHZyD7KVtG/zCVK5L
         FoXyGgo/vIRVdvtT9P7iqyymFZ8JmVuwL9hh0HYelt1svZVJQYA69R6CHTKS1RIXR78m
         QWQQ1G+/pQrhLsGQdneRrlw9sFdkPJYSm8vJxgvVfU5iDZYb9bn3irkzIw8Hmx3o1i+t
         JMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8L+INDaDk3NZHG4dO7/ktGDuXVcXD+VVuQnCeepwdRU=;
        b=CbCLcB9KvXz6Nlv1eHHZ6yCb7NASrFfDZNL6GrkhyezuHNw6RRGxtTe5vPnnAtlBiS
         NJ/cwgqvWMloJDxE4qPpbKboAPA5wkkTt/TzV1+Co5iyEa1TBSz7rxvYHY2K67VtQUHV
         xzimlpaKkCvEgbMeSFalC4XHhzaq567JChLBUSgBfsc8edRgiAzm/WC7Bqds45ctIP50
         tyIKwEE1QlPb5OqcSf1NFjtldks6tGV+7HTwMkPJSbmsbbO6NXsCTYjTFZKq8oQ3T38D
         JtGDLB4UnDkTm3KWxn8Gt2uo/K4QYItSRogKxx0UZd4MHH3kb4glxsf+h8DwxUenH2Tu
         N94A==
X-Gm-Message-State: AOAM5327urFLSJjplQIPttcw9O0p+wzWrECy9Qhe5aOldUU4LDd1Q9hZ
        me46fW2mF6KsO6bTZuB+1sR70qRWC9++5P0TJyw=
X-Google-Smtp-Source: ABdhPJzVqn5DXB3yJK4y04mYT/7BdFcefwDnyb77bYYKRVAjjaWFhNg2C2ppbVrpRLm5GfZimhbRrnFvkwX609swA9A=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr4627603oib.39.1623793524145;
 Tue, 15 Jun 2021 14:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com> <55d0eb59-10a0-1dff-f195-4d660c6028e0@kdbg.org>
In-Reply-To: <55d0eb59-10a0-1dff-f195-4d660c6028e0@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 14:45:12 -0700
Message-ID: <CABPp-BF2KnktDTtTfp=hRS36HN-xYC8=P1eYcqaBhJvAJcTCAw@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 2:36 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 15.06.21 um 07:16 schrieb Elijah Newren via GitGitGadget:
> > Implement a zealous diff3, or "zdiff3". This new mode is identical to
> > ordinary diff3 except that it allows compaction of common lines between the
> > two sides of history, if those common lines occur at the beginning or end of
> > a conflict hunk.
>
> As a data point, I tried this series (cf9d93e547 en/zdiff3) on my
> criss-cross merge test case that started this adventure, and it produces
> the very same output as diff3; cf.
> https://lore.kernel.org/git/60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org/

That's good to hear; your two sides had no common text at the
beginning or end of the conflict hunk, so I wouldn't expect zdiff3 to
change that particular example.

The XDL_MERGE_FAVOR_BASE idea (cf.
https://lore.kernel.org/git/20210611190235.1970106-1-newren@gmail.com/),
though would I think simplify the diff3 conflict markers in your
example to

<<<<<<< HEAD
    CClustering ComputeSSLClusters(double threshPercent, const
CDataInfo* scale) const override;
    void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist) const;
    double EstimateNodeDist2() const override;
    std::vector<double> EstimateNeighborMinDist() const override;
||||||| merged common ancestors
    CClustering ComputeClusters(const double* dist, double threshold,
        const CDataInfo* scale) const override;
    virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
        double& minDist, double& maxDist);
    virtual void ComputeUMatrix();
    virtual void ComputeKNearest(int K, const double*,
        Neighborhood& result) const;
=======
    CClustering ComputeSSLClusters(double threshPercent,
        const CDoubleArray& compWeights, const CDataInfo* scale) const override;
    static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
        double& minDist, double& maxDist);
>>>>>>> no-compweights-in-cnet

That seems like it might be nicer, but I don't do many criss-cross
merges myself so it'd be nice to get opinions of others like you who
do.
