Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B683FC433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 14:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8818220709
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 14:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9/UF8qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgGWOJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgGWOJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 10:09:43 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E58C0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 07:09:42 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id m18so1402039vkk.7
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sucrkpmN8/tCZgjw/yntw2oU3BjH4bSPSnKPVaQQOCk=;
        b=i9/UF8qGxXHHmFOYtxHRilrNyDYPrElGPfh/s2WVKUrkNViuc0AYkO05/JkCUNa+4q
         rjvlYaKIMbJHh+zZwtU7iaQN3vpmjQRV703AFCfBXro8bdNmiVYT9u2b1SQQtqrBX9iJ
         PZFDJctFM2LSuUAoMIXEUMqRGu0uJzGqLR+JhJ1idFoZCPbLVsWhioHGze4Abu/NMG8D
         eBjhO9ZAD/ann/P5L6jn9EARLtUDoxl7Bh9oAh3TyBNKjNfbb5aczUb/zgpvOzVzbe1b
         tV9GkVcm0iNiJbcg2ZhEpHzD/3miDdtw2g3MyfMqyhWJEvvTDJED0Cioix3VzaRSN5e3
         WnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sucrkpmN8/tCZgjw/yntw2oU3BjH4bSPSnKPVaQQOCk=;
        b=qjVhCclj3kVgealt3WgtuMcDNT5a3tCxCxOJBOQU/gx+YWk329xse9NsgdUG5LAHjC
         hn79OY2SDplI0d/fRjH3Ok0Q7MHqvX/cyR3xfsfGUl2CFVfwHSMq75D621snLRFOd1fP
         sjsMzBSxFiizsKGZpJsFnd2BeYAuHCaCpVioVE+wsse3XJ1YvhJayXdTFYxv+8tIT7Cy
         0RDLK73oIYsqbZTH1SG1OaGsLZNxftfA6pJ4p31ueC9y8F+EQ+up38nlsNOJ77GdRFol
         g7Ma2vNVnMxpdmhHUGfjyBDbzqPEL1La+GLNheF5Fhv9TioRX5bDUf9OLnA5OQtiKH6i
         yTKQ==
X-Gm-Message-State: AOAM531qDFB6rlKMa4gSdduZuO0iZ3Oz2ZhueCRb20kYrlKYpWlxxpN9
        KMgPxwFySD8YYgn1g17NODsVH+F9yjoB1F/IcC5wahk7ot8=
X-Google-Smtp-Source: ABdhPJxex6gw/K9xEFDYo4FcwX7Rerepd9mIz1rCvIVElC8ozkrLoeRNgghWyyRkUgSiLhQtH/eCRpi0eoqf6gDFM5M=
X-Received: by 2002:ac5:c8b9:: with SMTP id o25mr3884217vkl.87.1595513380650;
 Thu, 23 Jul 2020 07:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
 <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com> <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com>
 <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com>
In-Reply-To: <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com>
From:   Joel Marshall <joelmdev@gmail.com>
Date:   Thu, 23 Jul 2020 10:09:23 -0400
Message-ID: <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com>
Subject: Re: Possible issue with rebase's --rebase-merges option
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I saved the state of the repo in a copy so I could come back to it if
additional examples were needed but I had to clean up my live copy so
I could get back to work. I'll get you some additional screenshots in
the next few days. In the meantime, I'll try to give you some context
around what I'm doing here. The parent branch is my main dev branch
which consists of a series of clean branches and merges- the dev
branch basically looks like what you're seeing in the
--preserve-merges screenshot. I've also got a long running feature
branch that branches off of dev, and it also consists of many branches
and merges, each a subtask of the story related to the feature branch
as a whole. Occasionally to get the feature branch up to date with the
newest features I'll rebase the whole thing on top of dev, which
should result in an unbroken chain of branches and merges as seen in
the --preserve-merges screenshot. While you can't see it in the
--rebase-merges screenshot, those merges show no ancestors when viewed
in reverse chronological order- they just trail off into oblivion.

On Wed, Jul 22, 2020 at 2:30 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Joel
>
> On 22/07/2020 18:09, Joel Marshall wrote:
> > I've attached a couple of screenshots from tortoisegit. The branches
> > are too long to show in their entirety, but this should give you an
> > idea of what I'm talking about. The highlighted commit is the head of
> > the branch that I'm rebasing onto. Interestingly, I just noticed that
> > while --rebase merges reports that it's rebasing 202 commits
> > intitially, upon manually reconciling the first conflict it reports
> > that it is rebasing 183 commits.
>
> Thanks, the rebased topologies are certainly quite different, what is
> the topology before the rebase? Looking at the --rebase-merges result it
> looks like the second parents of merges that are being rebased have
> ancestors in the upstream branch. If that is the case then I think it is
> working as intended.
>
>  Are you able to run
>
>   git log --format=%ad --graph $upstream..HEAD
>
> before and after the rebase to check that?
>
> Best Wishes
>
> Phillip
>
> > On Wed, Jul 22, 2020 at 10:22 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> Hi Joel
> >>
> >> On 21/07/2020 22:20, Joel Marshall wrote:
> >>> Thank you for filling out a Git bug report!
> >>> Please answer the following questions to help us understand your issue.
> >>>
> >>> What did you do before the bug happened? (Steps to reproduce your issue)
> >>> This is a difficult one to give proper steps to reproduce. The issue
> >>> is with rebase's --rebase-merges flag. We recently switched from using
> >>> rebase with the --preserve-merges option to --rebase-merges. Most of
> >>> the time the output is the same, but sometimes it is very different.
> >>> I'm unable to determine whether this is by design or a bug.
> >>
> >> --preserve-merges is buggy if you rearrange the commits (this is way
> >> --rebase-merges was added), if you're just rebasing without reordering
> >> anything then I think the result should be the same though there may be
> >> some corner cases I'm not aware of. Are you able to share the topology
> >> before rebasing and after with --preserve-merges and --rebase-merges?
> >>
> >>> What did you expect to happen? (Expected behavior)
> >>> Resulting graph after running rebase --rebase-merges is the same as
> >>> running rebase --preserve-merges.
> >>>
> >>> What happened instead? (Actual behavior)
> >>> Using --rebase merges tries to pick substantially more commits and
> >>> results in merge commits with no parent commit when viewing log in
> >>> reverse chronological order.
> >>>
> >>> What's different between what you expected and what actually happened?
> >>> When the issue does occur (it doesn't for all rebases) it results in
> >>> two completely different logs and picks commits that are apparently
> >>> not part of the branch being rebased. eg, for a branch with 128
> >>> commits including merges, --preserve-merges picks 128 commits and the
> >>> resulting topology matches the original branch's topology.
> >>> --rebase-merges picked 183(?) commits in v2.24 and 202 commits in
> >>> v2.27, and in both cases resulted in a very strange topology.
> >>
> >> That's interesting there were some changes to how empty commits and
> >> upstreamed commits are handled between v2.24 and v2.17, without seeing
> >> the staring point and the results it's hard to tell what is going on though.
> >>
> >> Without seeing some examples it's hard to tell if there is a bug here or
> >> not though it does sound a bit suspicious.
> >>
> >>> Anything else you want to add:
> >>> Feel free to contact me at joel@tusksoft.com for additional details.
> >>
> >> You email me directly if there are things you don't want to share on the
> >> list
> >>
> >> Best wishes
> >>
> >> Phillip
> >>
> >>> I
> >>> would love to understand if this is by design or a legitimate bug.
> >>>
> >>> Please review the rest of the bug report below.
> >>> You can delete any lines you don't wish to share.
> >>>
> >>>
> >>> [System Info]
> >>> git version:
> >>> git version 2.27.0.windows.1
> >>> cpu: x86_64
> >>> built from commit: 907ab1011dce9112700498e034b974ba60f8b407
> >>> sizeof-long: 4
> >>> sizeof-size_t: 8
> >>> uname: Windows 10.0 18363
> >>> compiler info: gnuc: 10.1
> >>> libc info: no libc information available
> >>>
> >>>
> >>> [Enabled Hooks]
> >>>
>
