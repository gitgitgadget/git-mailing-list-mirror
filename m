Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37157C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0848A2073B
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 00:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ul45Pnge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLKAv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:51:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39375 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLKAv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 19:51:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so17305422oty.6
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 16:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxF2mStS/O3yI9oQ4F0MuKmdzJguCCeSxhr4K4VCgnQ=;
        b=ul45PngeTn3tB3HwrgbqWq1m4lLqvzJ7sQdUeyYPVP4ZhmQm0XTwD1ywzXvUKgb1q0
         l80nb8o8OzcAFG6o/yPVcLAEH7fFrqAHMHSKpKl6fb8RA6QC0oUiQIq9MHXrhK+sTxT7
         mCWk7HvM39PXXXn1JbQyOlJVVYdCLKcjepERcgqFkzZFts4cJVq5Zzep4s15AJVa6VPt
         ribL/Jojq4CdzWVGdDGnBiEMa8jOs8NCM4KXOju33sF4WcH20pMCaw+iV4KV0Y7g99po
         Q5JnfDu7j9SVrRGRvVBrI+tcnxG5n6XJX0dJGRVzqT0ekS4yf8hfSwNl7NqliMESVFAA
         GWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxF2mStS/O3yI9oQ4F0MuKmdzJguCCeSxhr4K4VCgnQ=;
        b=t4hJMT7Pw+RnzLL/qfYi8EgHDLJas3f1IwoGxqEVxQvoJ9utClmT5zPL3UBXIaDTqm
         Nb5ZfHdzplGxtmFk4SShDL17zbO2p/s6UZIziev8t9GDB+tZJSwMGoSCNko3oP/6ahz7
         sBf5TlFpE9xkE0Hwxtw/Z42HTyCnZVYMk+0GjI/Bu/N1eu+9yoSdc72oZC4OjYWdVw95
         wxlDQgB/Me4uMok5JATru5Ca0Vk+/waDjgN9xnx6ttAGLN82j0rH+s6o3UXbvWg7JVUP
         3Xw5Q51zG7nPS0LgLl/CQ08GFKKv2hpxWOyd/DVF6wdSNAscly1IWsXl+fENJGAlXcBx
         4fRQ==
X-Gm-Message-State: APjAAAUvBQiNKSYr3tfMmiCKT8NomihLg5d1UtdSInmnP+fyDvnxBZG4
        aNd5G+M+u/PmrrSIVGgY+zWG6R+FBECtcyGUDbH7og3I
X-Google-Smtp-Source: APXvYqyPIfgMxC3cqGaxs2+ZO/zB19d38mekZjfPomntt44lDneSKhd5PppeG44raidaQoSktbm5fQk5LfbCC1jFoas=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr456783otn.267.1576025518247;
 Tue, 10 Dec 2019 16:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20191210194803.emsvjibq3jyjkjrx@t440s>
In-Reply-To: <20191210194803.emsvjibq3jyjkjrx@t440s>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Dec 2019 16:51:46 -0800
Message-ID: <CABPp-BEhZaUxb2qKQLEpkG7+a9zQhYMxmbc=Na+P_RetrWk+1Q@mail.gmail.com>
Subject: Re: merge branch with updated submodule leaves repo in modified state
To:     Daniel Bosk <dbosk@kth.se>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 11:58 AM Daniel Bosk <dbosk@kth.se> wrote:
>
> Hi all!
>
> `git merge`: if a submodule is updated in the merged branch, the new
> version is not checked out after the merge. Is this correct behaviour?
>
> `git switch` correctly updates the submodules when switching between the
> branches. I would expect `git merge` to leave the things in the most
> up-to-date state.
>
> I tested this with the following settings.
>
>   $ git version
>   git version 2.24.0
>
>   $ git config -l
>   push.default=matching
>   diff.submodule=log
>   diff.colorwords=true
>   diff.algorithm=minimal
>   diff.exit-code=true
>   commit.gpgsign=true
>   submodule.fetchjobs=0
>   submodule.recurse=true
>   log.follow=true
>
> MWE:
>
> ```
> mkdir repoA repoB
>
> # init repos with READMEs
> cd repoA
> git init
> echo "A" > README
> git add README
> git commit -m "Adds repoA README" README
>
> cd ../repoB
> git init
> echo "B" > README
> git add README
> git commit -m "Adds repoB README" README
>
> # construct nested structure: repoA/repoB
> cd ../repoA
> git submodule add ../repoB/.git
> git commit -m "Adds repoB submodule"
>
> # update repoB in branch
> git switch -c update-repoB-submodule
> cd repoB
> echo "B updated" > README
> git commit -m "Updates repoB README" README
> cd ..
> git commit -m "Updates repoB submodule" repoB
> ```
>
> Now, doing `git switch master` will have the correct version of repoB,
> where `cat repoB/README` outputs "B". A `git switch update-repoB-submodule`
> from there will yield `cat repoB/README` output "B updated".
>
> However, switching to master and then merging will leave repoB at the
> old commit:
> ```
> git switch master
> git merge update-repoB-submodule
> ```
> A `git status` says there are new commits in repoB, it's actually a
> rewind which excludes the new commit (changing `repoB/README`), so `cat
> repoB/README` outputs "B" instead of "B updated". It feels unintended to
> get a repo which is in a modified state after a clean merge. Bug?

Don't know where it falls on the spectrum from bug to unimplemented
feature, but it's certainly a known issue.  The last time I remember
discussing this was here:

https://lore.kernel.org/git/CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com/


Hope that helps,
Elijah
