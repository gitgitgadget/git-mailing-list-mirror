Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B9C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681D4207E8
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="l4qYrpNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgFROe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgFROe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 10:34:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0CC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 07:34:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u25so3635836lfm.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUW4QhE6NFuGX9+2hFShonxTz1Fe9H3JB4WfgKlaNv8=;
        b=l4qYrpNS4/nk1GTt6TCwI2DOxaS4K6i1QD0pXe5WNLWgkLyaiRxhHRia8ekbPSMToX
         /efcVNdF9TseamPyuF7En2QFdn7X4sAeWZa/pwoDYonkPHKt5fSB6P8Y5UlBAMydnMwG
         k6qymfh/+6wlgzdmrAJMIS6KMG3ckH8K9pHh69XI0TW/shURyzjSWvCl4Rg+WLHuqXer
         7TdSRgAk5HgwfGrW1hUVC60puPP6LhRZ0wjbH8GXpskQITRVKfEzzM2crLfTvKTOhhSw
         fresDlQfvPavrCYz3H4FDF61S9ZM8jYH1KuOqIyA0uhwflq0UokUObuZ37S1ff359Jqw
         rSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUW4QhE6NFuGX9+2hFShonxTz1Fe9H3JB4WfgKlaNv8=;
        b=nHQIpVbJPP2QlfqnZ9XpzMPw1C6J05q/Nd3inJTYPw2E/oUOdbAU60iVXNLahcziI4
         hjT3WtQW9slaqa3opCpUd0D57S3uPJZ1xVUupSgoQTeAi8K3U4sAJM+Z75s2NarqTM8e
         NuEUODjbCdTsiaZ6QqfZtrHusDStf2nxJNEDGsV5UKenG2BOIn580kxyeliUgZfvnUCZ
         9mnUPbEpXvqrFc/NyaT1/I1UysPbZyPVK/Q4M+syy4lGzm0JqlJRMVBSL0SAzFc70DiB
         3Xc81p15BWFNB/kibqD2gl78mukCBqGrUolWUoeR7zl7QQczo37kMK1wj5Lz8dL1yxOM
         b+7w==
X-Gm-Message-State: AOAM531kLYz6nviEtWeBa2xlqMWkprqNMDBEyNhjsmpGxozwmJVO56zW
        wPDZ/62eToR1wYtMEtgu8DbOwBTiwB08mtk65wW2Zw==
X-Google-Smtp-Source: ABdhPJwMJFTk/pSykeiPDNOpqPElsJP1Y+Sh5aDD51MhTAG+/0S54Ly429I4eXUPSVc+LhiZsqtRQBAdbZ2zLUzl4BM=
X-Received: by 2002:a19:8389:: with SMTP id f131mr2494666lfd.16.1592490863779;
 Thu, 18 Jun 2020 07:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com>
 <CAHd-oW5gTJO=6pYXvg3v=JfjffcajPyMpsUOoqXnozwYrg3WwQ@mail.gmail.com> <CABPp-BHtwifTHXxoxTKvz0mx45e2N-4SBTTfoRePcmMFAn1O2g@mail.gmail.com>
In-Reply-To: <CABPp-BHtwifTHXxoxTKvz0mx45e2N-4SBTTfoRePcmMFAn1O2g@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 18 Jun 2020 11:34:11 -0300
Message-ID: <CAHd-oW7tT7GhHz7mCH9Y66B=kriBKv8ZyrTXT-VTJgcXGa1Jzw@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 9:24 PM Elijah Newren <newren@gmail.com> wrote:
>
> If someone were
> to try do change their sparsity patterns or even just run a "git
> sparse-checkout reapply" when they had the above issues, they'd see
> something like:
>
>     $ git sparse-checkout reapply
>     warning: The following paths are unmerged and were left despite
> sparse patterns:
>             filename_with_conflicts
>
>     After fixing the above paths, you may want to run `git
> sparse-checkout reapply`.
>
> This basically suggests that we consider uncommitted and unmerged
> files to be "unclean" in some way (sparse-checkout wants to set the
> SKIP_WORKTREE bit on all files that do not match the sparsity
> specification, so "clean" means sparse-checkout is able to do so).  So
> I could amend my earlier comparison and say that IF the user has a
> clean directory, then "git grep --recurse-submodules $REVISION
> $PATTERN" should be equivalent to "git checkout $REVISION && git grep
> --recurse-submodules $PATTERN".  I could also say that given the big
> warnings we give users when we can't set the SKIP_WORKTREE bit, that
> we expect it to be a transient state and thus that we expect them to
> more likely than not clear it out by the time they do switch branches.
> That would lead us to the follow-up rule that if the user does not
> have a clean directory then "git grep --recurse-submodules $REVISION
> $PATTERN" should be equivalent to what you would get if the unclean
> entries were ignored (expecting them to be cleaned before the any `git
> checkout` could be run) and you then otherwise ran "git checkout
> $REVISION && git grep --recurse-submodules $PATTERN".

Makes sense, thanks! We haven't mentioned "git grep --cached" yet, but
it would behave in the same way of the worktree grep, in this case.
(I.e. searching the submodules, as their SKIP_WORTREE bit was not
set.) So I guess it should be fine, as well.

> That suggests that grep's implementation we agreed on earlier is still
> correct (when given a $REVISION ignore submodulees that do not match
> the sparsity patterns), but that unpack-trees/sparse-checkout still
> need an update:
>
> When we notice an initialized submodule that does not match the
> sparsity patterns, we should print a warning just like we do for
> unmerged and dirty entries.

Yeah, seems like a good approach. Thanks for the explanations. Some of
the test cases in mt/grep-sparse-checkout will have to be adjusted
with this change. Should I reroll the series based on the patch you
will send or do you prefer to adjust them in your patch (and make it
dependent on mt/grep-sparse-checkout)?

Thanks,
Matheus
