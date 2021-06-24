Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98116C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B0C613C1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 16:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFXQ0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFXQ0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 12:26:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279CAC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 09:24:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5106903wmc.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesisquare-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFq87RGUjhNWWtFc7mR+5SaxPe1zrZkQW7rpvRD11Fs=;
        b=x97X50B1ICzmYlUNOq8dMcixv2qG0Oj4giEgdiG/05+ssUunCypGk6/78fhkVhwxqj
         ejzrXivlUaIk6HyzM0/Fey4W4jy9WkIe1aN8MX5n2fNLzG+DIyzfuY+XHilnjV+tYAf9
         uDfFEsEzpxGc/5A1GcprRB652Z7mZCO2fKlNoFQOj/3lwcbYNQDm3x1B4rthymGOv9LS
         OCm9cl60zmje1iF6TGgORedsTPlQFDKJEN6rQmei36n4YwZAonb0hwkquwHsLAEWx4bk
         pcdqB9OkILarVJ3QdvwRNHoQx3tQFN87DuwCUlkEu4DoIlih9D35kPjGcQhG2QSP6GSi
         vcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFq87RGUjhNWWtFc7mR+5SaxPe1zrZkQW7rpvRD11Fs=;
        b=KFoEH/5TqRWfFg2YrjmRtWLe4YOlm7XjZBKy5PBLm4XKkPtXdpN7rZGvPJ3FHAE8p0
         uD769VLpYo/xHgMBWacVC+F6jW96be7ffjUkU0ta37Cw4CoL2tyyZxzb9Gc1Z3eZWbS9
         ZvZabraIgtoREuwDwwCAv3zsfPWzAXHnNLtHyiO0xiCRQkg/svTQhcWz51VVLMev+7vL
         DBhcwt2NfPQp3aEJG4ZqGBSjiVUsXIo6Ff5txNxAK/10WevH/lqDg482HG7sY+PDTmLd
         3FlNspRn+L8vv0m+GHpBwHkZQyLeOxNlmgGKCSEjYhpYZ+8GSP3Zt0hgR0HhygDaY5B/
         8STg==
X-Gm-Message-State: AOAM533ZzoRXpsV4Qs3oUpVpq1f5BNh+5kNVf6lqplEn2orykEK89Ctv
        kGdHlPA3UZi9AyVP7lP//NXl6EvahBIyf1KdQchJQg==
X-Google-Smtp-Source: ABdhPJw35cxHwEU+FZPTTPSDb7a5zIPebf0AN3JCUyrFsVE6tMcS0CYvOz81tcIoqwZ04SV3OHPPirkXiNLmbHl+RgU=
X-Received: by 2002:a1c:4954:: with SMTP id w81mr5359007wma.182.1624551862704;
 Thu, 24 Jun 2021 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
 <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com>
In-Reply-To: <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com>
From:   Marco Giuliano <marco.giuliano@tesisquare.com>
Date:   Thu, 24 Jun 2021 18:23:57 +0200
Message-ID: <CANLwWg5Lcf7PYtZ49U-KZ_3UYVb9FJ-g1B+eFYoO2D1t5UArmw@mail.gmail.com>
Subject: Re: Nonexistent changes appear rebasing but only with rebase.backend=apply
To:     Phillip Wood <phillip.wood123@gmail.com>,
        felipe.contreras@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Felipe and Philip for your answers.

Let's proceed in order:
@Felipe: I tried rebasing with --no-fork-point but the problem remains the same

@Philip:
I'm a basic git user, so bear with me if I say silly things...
I tried to search for rebased-patches in .git folder when rebase
stopped waiting for
conflict resolution, but I didn't find any file named like that.
There's a folder named rebase-apply though did you mean that ?

Anyway, looking at the conflict file of "fileA" directly (not behind a
visual diff tool) I noticed that the marker line >>>>>>>> COMMIT
DESCR: FILENAME indicates a different file name then the current
conflicted file.
That reminded me that those two files A & B, were actually copies
(real copy, not symlink) of other two files inside the same repo.
Is it somehow possible that auto-detected-renaming is involved in this
(since the files are identical but in two different locations) ?
Trying to give you some hints, maybe it is totally unrelated...

About the blob check you suggested, please be patient but I didn't
understand exactly how to proceed.

Thanks again for your support,
Marco



On Sun, Jun 20, 2021 at 8:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Marco
>
> On 18/06/2021 16:21, Marco Giuliano wrote:
> > Hi All
> >
> > I'm facing a strange anomaly during rebase.
> > I'll try to explain what happens because unfortunately I cannot share
> > more information since it's confidential and unfortunately an
> > anonymized export does not reproduce the issue.
> >
> > I have the following repository status:
> >
> >     * commit 2 (BRANCH X)
> >     |
> >     |  * commit 4 (BRANCH Y) (HEAD)
> >     |  |
> >     |  * commit 3
> >     | /
> >     |/
> >     * commit 1
> >     |
> >     |
> >   (...)
> >
> > What I'm trying to do is rebasing branch Y on branch X, with the command:
> > git rebase X
> >
> > The anomaly is that, among other expected conflicts, also two files
> > (fileA, fileB) appear modified in both branches, but those two files
> > have not been modified in any of the 4 commits you see in the graph
> > above!
> > The anomaly appears only with the config setting rebase.backend=apply,
> > while not with rebase.backend=merge (*).
> >
> > This might not be caused by rebase command itself, but rather by some
> > previous operations which might have accidentally "broken" something
> > and that the rebase simply makes them appear.
> > You need to know that commit 4 is the result of several squash and
> > reordering of multiple commits; is it possible that some of those
> > operations have created some "leftovers" ?
> >
> > I know this is difficult without seeing the actual repository, but
> > could you just give me some advice or point me to the place where I
> > can investigate ?
>
> That certainly sounds quite strange. I think the patches used by the
> apply backend are stored in .git/rebased-patches, it might be worth
> looking at that file when the rebase stops for you to resolve the
> conflict resolution to see if that sheds any light on which commits the
> conflicts are coming from. Failing that does the content of the
> conflicts provide any clues as to which commits they are coming from?
> You could also try matching the blob id's from the index line of `diff
> --cc` to the index lines in `git log -p` to try and find where they are
> coming from.
>
> Rebase ought to just replay the commits so in theory it shouldn't matter
> that you've been squashing and rearranging commits. What does `git log
> -p branch-x...branch-y fileA fileB` show? (it shouldn't show anything if
> those files are not touched by any of the commits)
>
> Best Wishes
>
> Phillip
>
> > (*)
> > When the anomaly first appeared, I was using git for windows, version
> > < 2.26.0 (unfortunately I cannot recover the exact number); I decided
> > to upgrade git to 2.31.1 and the anomaly disappeared. Investigating
> > the release notes, I noticed that rebase.backend default value changed
> > from apply to rebase from version 2.26.0.
> > I also copied the repository on linux (with git 2.31.0), and the
> > behavior is the same.
> >
> > Thanks in advance for any help,
> > Best Regards,
> > Marco
> >
>
