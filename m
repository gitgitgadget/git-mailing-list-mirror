Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034A120780
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2IcNpKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbgFWW5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFWW5v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:57:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8501C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:57:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 17so431893wmo.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hSj5OIIQ7Qp+ebRJt/AZFtFvcYYwNda/6itJpJzDCg=;
        b=d2IcNpKCIWehSyzgs13GT/CIap3VPwk2n841WkqlyC2o7vmBt8ikIA31/EZ1sZDXBg
         hpboV0R+xx1HDiAa6NqbuXY8NNmRkM4UtzsOtKACxH6BRhskpc0hr2akheRLUsLMiV+k
         Ou2Qf4LVRoLSK5zaiwGlByn6Ns/E4g/2foC6/OxIG70z57Ysdpvc3xLvPiViHdn7mr6T
         Ven6AwyE0jrjYer/2dzK/cSOcOMb/wPg1SlidDsL3WPFKcURzzf8UxRW2/6nC2VTUGLu
         kLMcwI8qycHMuBduAR6Uyhu9E8TM6Hm6OaZ0SvISouK6jjQnv98oq4MgGelUxuwyrJR9
         UM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hSj5OIIQ7Qp+ebRJt/AZFtFvcYYwNda/6itJpJzDCg=;
        b=EzaWP3mJXuCoEPvV1Oe0gs0LmNSgTvB4ExTp3Kb5nDCrge+c36D9KZel7VGg1cXodE
         gPBOo73qyI09ZSDICI0H3wCU73elTBLpj0C71s7uVJbbJbvlBvCYa4ql9z8TsjTSLAnx
         x4icwZx2MpS6TS/bfCpUPq1E4RHwWwmNxJ2rOQeAMpdmTnJ2O7T8OFwd1iOUii8+OwEq
         RAHJcoFgHAznYgT+T7K8f634FIFj1LXQ4GxXA1jXooaLrQinwbiXw6LT7X5unxu18XQP
         rTiwMhHucuQ29sqxXv4LhsHVeVTiD40xKZ4k1UYS1MstV64Dn/lRPQzbdj9oUA488DOS
         sSzQ==
X-Gm-Message-State: AOAM530Yxkp3gJTYWBE986b2PmBoVRvVHGelvCtwFzhLiT83NgA0sEEP
        oTWYFHdBacEJTpU6Wu2FIswtgyxYbRVw29I8G/uHrusC
X-Google-Smtp-Source: ABdhPJyXUJOnaT+bhLTHKgrq25r1Y9fqxsC2JiqljvFfkdPPPTyD9yLyMAlVPCgrLSpniowPmcdk4yXKvkktZG6mwSk=
X-Received: by 2002:a7b:c212:: with SMTP id x18mr26231760wmi.119.1592953069478;
 Tue, 23 Jun 2020 15:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
 <20200622194122.GN6531@camp.crustytoothpaste.net> <871rm6x86y.fsf@osv.gnss.ru>
 <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com>
 <87sgelpmb2.fsf@osv.gnss.ru> <CABPp-BFwNnD-zZvHjCAvvmzy1wTT3yy-smK5nCtQ937apaNmkQ@mail.gmail.com>
In-Reply-To: <CABPp-BFwNnD-zZvHjCAvvmzy1wTT3yy-smK5nCtQ937apaNmkQ@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 23 Jun 2020 15:57:38 -0700
Message-ID: <CAPx1Gvc6X5zgHXfnaKD+sBM=P1ve4raR5tJzTaZnwwTugBva_A@mail.gmail.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm going to snip a lot here as I'm not really replying to one
specific proposal or another.  I just want to add some background:

On Tue, Jun 23, 2020 at 2:48 PM Elijah Newren <newren@gmail.com> wrote:
> Once you record the information for which files it applies to, then
> you want it to happen whenever the merge machinery fires, right?

This is, of course, already the case for merge drivers defined and
used in .gitattributes entries (though note that they don't apply to some
merge *strategies*, e.g., `-s ours` completely ignores them).

> The problems I was raising were not with the resulting end-state tree
> that users can construct or what happens with those trees once
> constructed.  My problems were with expected automatic behavior from
> the merge machinery coupled with incomplete specifications that
> sounded to me like a pile of corner cases and bugs that I'd have to
> field while trying to maintain the merge machinery logic.

This is already a bit of a problem with merge drivers in .gitattributes.
In particular, suppose we're doing a standard merge of commits H
(HEAD) and T (theirs) with respect to B (base).  If the file is named
"foo" and there is a merge driver defined for "foo", this merge driver
is completely ignored *unless* all three copies of foo differ!  And of
course there are rename issues if a file's name was foo but isn't now
or vice versa.

I do think it might be reasonable to be able to mark a merge driver
as "always use this, even if two or even all three inputs are the same".

> Oh, and I have a problem with "branch specific" files from the email
> you were responding to.  I think those are a code smell.  But my
> primary concern was the expectations of some new automatic behavior
> out of the merge machinery and how/if it gets configured.

They're not only smelly :-) ... they don't even really mean anything.
In particular, merge works not on *branches* but on *commits*.  If
we're merging commits H and T with base B, we may not be on any
branch at all (detached HEAD) and there could be anywhere from
zero to arbitrarily many branch names pointing at or containing each
of the three commits.  But of course it's common to have one branch
name for each of H and T, and that's where most people who want
this are coming from.

In any case, the merge driver stuff is useful to some people sometimes.
It might be a little more useful if you could force `git merge` to use it
even if only "their side" of the merge has changed the file since the
merge base.

Chris
