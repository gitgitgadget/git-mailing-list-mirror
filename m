Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA9C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CE261159
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhFPIRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhFPIRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 04:17:12 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D09DC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:15:07 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so1760353otl.0
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYgQFusbWryM9wBzObXh9Aih12NFKp4txKBIXSXq/s8=;
        b=JEfIETU4QQZ698kW2CJXKmT1c+SkGnQsYUzJYS92gxBG+vLS3OahbUzfKYqOJFZcnQ
         pl4wfcnOEgfGbkovHBoOmXC8IWivRzB/TImsMNG/PVVrBI54cNQnXmls6rugyBd+ZnzH
         YYqTYfPo2qHw1QDi5+CYYAX4aiLQNriKWWbMSQuWiMbMV5UPZlG1np+qbNJPEKR2Ztjr
         NQmV/VT+QAHhldef62Dm4k/DS/ks5/VSpgjy9kDixcfH64v7VnT/K1q5NcoY2sVXF2+s
         vEZSctdi9NM75qt0eBHPI0taO9Ms+/hadIBbynhs00mGh0Q47UUyoOUdIOO9IukKyWn+
         xiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYgQFusbWryM9wBzObXh9Aih12NFKp4txKBIXSXq/s8=;
        b=UUR1bNyJuNz/4hYnvWWQM8v6ptNG+tMVLOCj3hCMGQSovNRQkds883VBLQIBET5NkP
         9yxX4W7+YWdTqDAPi4F1S1APgT25i0r1KYhr41XWyjbGnRewMCxJoYAwcNbmezl9aAaS
         /zXisASuiyE1MEHXc96pUAdu4teoWxFgYuHNCiwUjFhWTHN5BVky+UP5LHiLxb0Cx+u3
         u9Ro4/B2FV1wbk5hWV/6VsbuDbcOdjaxuxgv7grVRRldGIqFVkqVfpj1lFa5CBq703KQ
         svb4g7mELG7ut3ljgL6o6d+0gsRPWeQGx2gs9Pm6WoiOlP3/QPi3BAYnytfGFilx217F
         KAmw==
X-Gm-Message-State: AOAM532TstJpyvSpwyTLo2e+VCcsUYtVrVxBr9gjXtaq2V7XG7zhrm1k
        lEJKSMeEgBKixBESoDYjA7OLFd+dVSD3ajwMGeU=
X-Google-Smtp-Source: ABdhPJyoqdRJbxO6cOjX1wSiXXHWx8F1/HNCYgNtZbL5+w3K6U6aSi5Ep4SlZNUy0daDjyiYbAtjeAswtYkKKUy1WWk=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr2921449ote.316.1623831306535;
 Wed, 16 Jun 2021 01:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <55d0eb59-10a0-1dff-f195-4d660c6028e0@kdbg.org> <CABPp-BF2KnktDTtTfp=hRS36HN-xYC8=P1eYcqaBhJvAJcTCAw@mail.gmail.com>
 <a5267880-09be-a1ed-32bb-3b056b831fb4@kdbg.org>
In-Reply-To: <a5267880-09be-a1ed-32bb-3b056b831fb4@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Jun 2021 01:14:55 -0700
Message-ID: <CABPp-BFPaHEUzJsBO1dyv+7DteZfJX=Qfi2dLaYS5J30VAVAcA@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 11:16 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 15.06.21 um 23:45 schrieb Elijah Newren:
> > On Tue, Jun 15, 2021 at 2:36 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >>
> >> Am 15.06.21 um 07:16 schrieb Elijah Newren via GitGitGadget:
> >>> Implement a zealous diff3, or "zdiff3". This new mode is identical to
> >>> ordinary diff3 except that it allows compaction of common lines between the
> >>> two sides of history, if those common lines occur at the beginning or end of
> >>> a conflict hunk.
> >>
> >> As a data point, I tried this series (cf9d93e547 en/zdiff3) on my
> >> criss-cross merge test case that started this adventure, and it produces
> >> the very same output as diff3; cf.
> >> https://lore.kernel.org/git/60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org/
> >
> > That's good to hear; your two sides had no common text at the
> > beginning or end of the conflict hunk, so I wouldn't expect zdiff3 to
> > change that particular example.
> >
> > The XDL_MERGE_FAVOR_BASE idea (cf.
> > https://lore.kernel.org/git/20210611190235.1970106-1-newren@gmail.com/),
> > though would I think simplify the diff3 conflict markers in your
> > example to
> >
> > <<<<<<< HEAD
> >     CClustering ComputeSSLClusters(double threshPercent, const
> > CDataInfo* scale) const override;
> >     void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
> >         double& minDist, double& maxDist) const;
> >     double EstimateNodeDist2() const override;
> >     std::vector<double> EstimateNeighborMinDist() const override;
> > ||||||| merged common ancestors
> >     CClustering ComputeClusters(const double* dist, double threshold,
> >         const CDataInfo* scale) const override;
> >     virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
> >         double& minDist, double& maxDist);
> >     virtual void ComputeUMatrix();
> >     virtual void ComputeKNearest(int K, const double*,
> >         Neighborhood& result) const;
> > =======
> >     CClustering ComputeSSLClusters(double threshPercent,
> >         const CDoubleArray& compWeights, const CDataInfo* scale) const override;
> >     static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
> >         double& minDist, double& maxDist);
> >>>>>>>> no-compweights-in-cnet
> >
> > That seems like it might be nicer, but I don't do many criss-cross
> > merges myself so it'd be nice to get opinions of others like you who
> > do.
>
> That *is* nicer as it is just the regular conflict with some base
> context. Does that mean that the regular recursive merge is a bit sloppy
> because it throws away too many conflicts that occur in virtual
> ancestors? Even if that is the case, I couldn't tell whether that is a
> disadvantage or not, as I've actually never seen nested conflicts in the
> past; the diff3 test was the first time I saw one.
>
> With the referenced patch applied (after a small tweak around needs_cr
> to make it compile), my testcase does indeed produce the above conflict
> under zdiff3 mode. The diff3 mode, OTOH, produces an exceedingly large
> non-nested and obviously incorrect conflict (I'm not going to post it
> here): our and their side are large and share a lot of text, but the
> base part is identical to the above and is far too small.

The thing about XDL_MERGE_FAVOR_BASE in combination with a recursive
merge, is that if you have two merge-bases, then XDL_MERGE_FAVOR_BASE
will put the text from the merge base of the merge-bases in the
"original text" region.  If your merge bases themselves had multiple
merge-bases, and those merge bases in turn had multiple merge-bases,
etc., so that you end up with a deeply nested recursive merge, then
XDL_MERGE_FAVOR_BASE will cause you to get the "original text" filled
by the text from some ancient ancestor.  The net result is that it
makes it look like you have done a three-way merge between the two
sides you expect with a really ancient merge base.  So, a really small
original text is probably something to be expected from the
XDL_MERGE_FAVOR_BASE patch.

The fact that zdiff3 shrinks it down considerably reflects the fact
that your two sides had long sections of code that matched at the
beginning and end of the conflict hunk.  So it sounds to me like both
pieces were behaving implementationally as designed for your testcase.

Whether using "ancient original text" makes sense in general rather
than using a "more recent original text" (in the form of an attempted
merge of the merge-bases complete with conflict markers), feels like
it's one of those tradeoff things that I figured those who do lots of
criss-cross merges should weigh in on rather than me.
