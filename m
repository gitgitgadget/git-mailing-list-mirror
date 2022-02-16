Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F72C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiBPQi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:38:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBPQi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:38:29 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0325BD4B
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:38:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a23so576681eju.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c4r45OVLn+3chrzksLXeuzWiVeqKzhtule9tizEIQaM=;
        b=Yqg8bQXy4yxUYJVU8bw4bAoxSgzXZ7wJQh5EbZfbPsrGbbTCI4T+8o9kSM9Y5PBuJu
         4dKkXXVwn73gZhLcDVbI+cqCCJucrQ8c6jzYTDzkS/lAiNZBn5+kFG6j+hrC1WKQBt0q
         G9HhPyaUTmAKnrjtKgMEzshaX7yJqXvu0tI1AeSHjR5vwRqb72Y2HnObjC99w19hQ/oE
         aD+o7c51QSAGob2XDzL8M9/K+HEM1cQMc5hUuOv/qIoxLbRCzvBWNfvD6i0Hzwqg9S3j
         8QMTZJz7ejFKFs2X419//dTW+0wxE7kgZu9xdXiZSomkQfvHyPeoFPQAUq4e9j7eYgj9
         Mr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c4r45OVLn+3chrzksLXeuzWiVeqKzhtule9tizEIQaM=;
        b=sGunu/DSQ3llGjV3iH5BFEKhxHUvouOX4N+9wLmqoZfAt4iGPENig3idfExm+0Nsdb
         74XTH0KiOHgNBZJ9H/FeAmrCD40ky7vnXBMC+wR2NZpA9goGi+g7uflKEZEN2kg+HJPP
         +c0W+N4e0rLJe++GQ5KEdWoEnLF/g7w9CQpIFLHQAASs+K8MgIQbueKPdM3w+PcR1DGz
         tIEHjVmaYAu5eJpBclAJN947TGaaz0nY2hFbCDxEYMC1H4NclrWoB/XMPM9fd7ycg+lN
         TTkqcm06Q14a+ksKWh6TIyBOqFLpMu8xUiP+QrZf76/4sMBdqo/HKZpEI88LW0j0avcu
         N65g==
X-Gm-Message-State: AOAM5304asInh9mJfNVqVHvkaJS8czlfC6aPc7XYwU494SRjHzHSH5+n
        kJalKMv1D5GPZdb3Q2/3Zje45hFJij39yq9IHHGqflF6Kj1gWg==
X-Google-Smtp-Source: ABdhPJxp1sds5j/9NdAE10TI1RnVCJM/ej/U54lpCO5akMOKnS4eccz9f2QJBNZezei3r+nWxnQ4obTnlQNZ9H87Uq4=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr3096097eje.328.1645029495108; Wed, 16
 Feb 2022 08:38:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk0dwyrcv.fsf@gitster.g> <CABPp-BFOw48k0M3U+fef1J57wHt2uq4hbKo-vnjAj56nYY6m2Q@mail.gmail.com>
 <220216.867d9vuorn.gmgdl@evledraar.gmail.com>
In-Reply-To: <220216.867d9vuorn.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 08:38:03 -0800
Message-ID: <CABPp-BGG1nOedrcRz+w3PvXmHkJakv+8OZnvgT=ZcszqUsvyog@mail.gmail.com>
Subject: Re: en/present-despite-skipped (Was: Re: What's cooking in git.git
 (Feb 2022, #04; Tue, 15))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 1:47 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Feb 15 2022, Elijah Newren wrote:
>
> > On Tue, Feb 15, 2022 at 12:01 PM Junio C Hamano <gitster@pobox.com> wro=
te:
> >>
> >> * en/present-despite-skipped (2022-01-14) 6 commits
> >>  - Accelerate clear_skip_worktree_from_present_files() by caching
> >>  - Update documentation related to sparsity and the skip-worktree bit
> >>  - repo_read_index: clear SKIP_WORKTREE bit from files present in work=
tree
> >>  - unpack-trees: fix accidental loss of user changes
> >>  - t1011: add testcase demonstrating accidental loss of user modificat=
ions
> >>  - Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
> >>  (this branch uses vd/sparse-clean-etc.)
> >>
> >>  In sparse-checkouts, files mis-marked as missing from the working tre=
e
> >>  could lead to later problems.  Such files were hard to discover, and
> >>  harder to correct.  Automatically detecting and correcting the markin=
g
> >>  of such files has been added to avoid these problems.
> >>
> >>  Will merge to 'next'?
> >>  cf. <20220204081336.3194538-1-newren@gmail.com>
> >>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
> >
> > Is there anything specific you're looking for here?
> >
> > I think it's ready, as I said two weeks ago in the link you provided
> > above.  All reviewer feedback was addressed to reviewers' satisfaction
> > over a month ago, so I'm not sure what else to do here...
>
> FWIW I gave it some light reading just now & left some comments on it.
>
> I don't think any of them should be blocking on it being merged down to
> "next", but perhaps some of them suggest worthwhile follow-ups. In
> particular the suggested documentation changes & the behavior/error
> checking around the lstat() and index iteration in the new path_found().

You do seem to like waiting until after things merge down to review
(Junio merged this 7 hours before your email here).  ;-)

I can include the documentation changes along with my switching of the
default mode in sparse-checkout (i.e. my breaking up and resubmitting
[1] in a separate series), especially since the sparse-checkout
documentation is be heavily modified in that series anyway.  I think
the lstat stuff deserves a separate xlstat in wrapper.[ch] if we
really want that kind of check everywhere, and seems like a bigger
separate refactor.  I'm guessing by index iteration it was the part
where you got confused on char* vs. char **, and there aren't any
changes needed; let me know if my guess on that is wrong.

[1] https://lore.kernel.org/git/e30119b96dfaf9fdb82039cab84f8b81caacc1de.16=
44712798.git.gitgitgadget@gmail.com/
