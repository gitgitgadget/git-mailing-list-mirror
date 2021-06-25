Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3DCC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 07:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196E96141E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 07:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhFYHPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFYHPL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 03:15:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C0C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 00:12:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f15so9422256wro.8
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesisquare-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pg73xCzjm6TtWcgIZqz+faFjEfLR0Ky0u6xknk45Ln4=;
        b=Iot2VX3fFZHlO0DPH4iYY5P1aSSsFkIMP0TnVzJ2h1WvMRmAHejcLuVk/mYIf/Nqhd
         qIvdz3ErA+hEZPxXCMrDp2RqioPqYZ6Zz/UL5SjO8pOgNfBGe0je7iCHyP+nsJ073Ygx
         a2MOLMY3GL01eZWAe08O1adlgUA0Qg+bWjEIULEKi8/w4ud/ECh77zcazIM6xlvcFY56
         FFkI+3BV7FHkmlGbmlgZuz0R4nac8SpNRiq/BEgoWr4GebKFyLl0w79FgdDaanl5ajow
         oTyac94z3sSijUJ7S1owwLcWtRRmcK2xjzZ5vT93sb7vx0fzv3b+qxYp2oJR24rQUFBK
         dUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pg73xCzjm6TtWcgIZqz+faFjEfLR0Ky0u6xknk45Ln4=;
        b=YMlz/aiPeYiaJS1Q3DLGjbJ2d3h132tJZdEkd/5r+8zIS4Eyw+iJTh2rGb5kTuodH4
         r6PqjjhlfXb9CxSlEmAauutYGUJqYc0mJk2scq3M0e3FlSLXCbTLDSW7eZfGaqESQJKv
         QQphT9lLqXiW5hX4qn7Hxs1VakTS24qkWJiIeWUvUbzxkrsPdhjwS+ADe1VgaPsOvG//
         EPKnehec0T7GrhbzxweognFsPnXkBwwoWRhhOV08+0ZW6UjMnIxwIKpHYMhhNBRZM2ly
         g+Pa931ggGuxYnV6zT/fjugcyQvgC+p8CJfvEv+A/n43oc/q1xkOrNrp/4PVzhFKOAb0
         Z3vg==
X-Gm-Message-State: AOAM531FSTE8ONTvcKXuqd9svxLuAUH0/IgOeR4N98wD3GQduaXz7rh/
        8pLCIWX1mRiERkvHWXec+0x4VwyBRNJFoB/xzzN6iflPChfgu9zd
X-Google-Smtp-Source: ABdhPJyzUCSFpxS/XP1k30mjOt6QcvzvmoxyDlWPxQHlcmMcGbWvZV66MCq4dl0GaZD3XSOiFfbmi4Qaran41KaqprM=
X-Received: by 2002:adf:a404:: with SMTP id d4mr3569248wra.156.1624605169671;
 Fri, 25 Jun 2021 00:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
 <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com> <CANLwWg5Lcf7PYtZ49U-KZ_3UYVb9FJ-g1B+eFYoO2D1t5UArmw@mail.gmail.com>
 <6b604658-8f7e-ae5d-7161-c48aed7ccbd0@gmail.com>
In-Reply-To: <6b604658-8f7e-ae5d-7161-c48aed7ccbd0@gmail.com>
From:   Marco Giuliano <marco.giuliano@tesisquare.com>
Date:   Fri, 25 Jun 2021 09:12:24 +0200
Message-ID: <CANLwWg7YFC2VrRYz1PR1U9SVG5yiyRVnyMspGc8PqKktouz8dQ@mail.gmail.com>
Subject: Re: Nonexistent changes appear rebasing but only with rebase.backend=apply
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,
oh, so I guessed correctly...
Could you be more specific about the copy/rename issue of the apply backend ?
Is there any bug report I can refer to ?

Thank you very much for your support

Marco

On Thu, Jun 24, 2021 at 8:39 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Marco
>
> On 24/06/2021 17:23, Marco Giuliano wrote:
> > Thanks Felipe and Philip for your answers.
> >
> > Let's proceed in order:
> > @Felipe: I tried rebasing with --no-fork-point but the problem remains the same
> >
> > @Philip:
> > I'm a basic git user, so bear with me if I say silly things...
> > I tried to search for rebased-patches in .git folder when rebase
> > stopped waiting for
> > conflict resolution, but I didn't find any file named like that.
> > There's a folder named rebase-apply though did you mean that ?
>
> Looking at the source I thought they ended up just in .git but I haven't
> checked again, as you seem to have found the source of the problem below
> lets not worry about that.
>
> > Anyway, looking at the conflict file of "fileA" directly (not behind a
> > visual diff tool) I noticed that the marker line >>>>>>>> COMMIT
> > DESCR: FILENAME indicates a different file name then the current
> > conflicted file.
> > That reminded me that those two files A & B, were actually copies
> > (real copy, not symlink) of other two files inside the same repo.
> > Is it somehow possible that auto-detected-renaming is involved in this
> > (since the files are identical but in two different locations) ?
> > Trying to give you some hints, maybe it is totally unrelated...
>
> I meant to ask if anything had been copied or renamed but forgot. The
> merge backend detects copies and renames and handles them correctly but
> the apply backend does not so I think this is the source of the discrepancy.
>
> Best Wishes
>
> Phillip
>
> > About the blob check you suggested, please be patient but I didn't
> > understand exactly how to proceed.
> >
> > Thanks again for your support,
> > Marco
> >
> >
> >
> > On Sun, Jun 20, 2021 at 8:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> Hi Marco
> >>
> >> On 18/06/2021 16:21, Marco Giuliano wrote:
> >>> Hi All
> >>>
> >>> I'm facing a strange anomaly during rebase.
> >>> I'll try to explain what happens because unfortunately I cannot share
> >>> more information since it's confidential and unfortunately an
> >>> anonymized export does not reproduce the issue.
> >>>
> >>> I have the following repository status:
> >>>
> >>>      * commit 2 (BRANCH X)
> >>>      |
> >>>      |  * commit 4 (BRANCH Y) (HEAD)
> >>>      |  |
> >>>      |  * commit 3
> >>>      | /
> >>>      |/
> >>>      * commit 1
> >>>      |
> >>>      |
> >>>    (...)
> >>>
> >>> What I'm trying to do is rebasing branch Y on branch X, with the command:
> >>> git rebase X
> >>>
> >>> The anomaly is that, among other expected conflicts, also two files
> >>> (fileA, fileB) appear modified in both branches, but those two files
> >>> have not been modified in any of the 4 commits you see in the graph
> >>> above!
> >>> The anomaly appears only with the config setting rebase.backend=apply,
> >>> while not with rebase.backend=merge (*).
> >>>
> >>> This might not be caused by rebase command itself, but rather by some
> >>> previous operations which might have accidentally "broken" something
> >>> and that the rebase simply makes them appear.
> >>> You need to know that commit 4 is the result of several squash and
> >>> reordering of multiple commits; is it possible that some of those
> >>> operations have created some "leftovers" ?
> >>>
> >>> I know this is difficult without seeing the actual repository, but
> >>> could you just give me some advice or point me to the place where I
> >>> can investigate ?
> >>
> >> That certainly sounds quite strange. I think the patches used by the
> >> apply backend are stored in .git/rebased-patches, it might be worth
> >> looking at that file when the rebase stops for you to resolve the
> >> conflict resolution to see if that sheds any light on which commits the
> >> conflicts are coming from. Failing that does the content of the
> >> conflicts provide any clues as to which commits they are coming from?
> >> You could also try matching the blob id's from the index line of `diff
> >> --cc` to the index lines in `git log -p` to try and find where they are
> >> coming from.
> >>
> >> Rebase ought to just replay the commits so in theory it shouldn't matter
> >> that you've been squashing and rearranging commits. What does `git log
> >> -p branch-x...branch-y fileA fileB` show? (it shouldn't show anything if
> >> those files are not touched by any of the commits)
> >>
> >> Best Wishes
> >>
> >> Phillip
> >>
> >>> (*)
> >>> When the anomaly first appeared, I was using git for windows, version
> >>> < 2.26.0 (unfortunately I cannot recover the exact number); I decided
> >>> to upgrade git to 2.31.1 and the anomaly disappeared. Investigating
> >>> the release notes, I noticed that rebase.backend default value changed
> >>> from apply to rebase from version 2.26.0.
> >>> I also copied the repository on linux (with git 2.31.0), and the
> >>> behavior is the same.
> >>>
> >>> Thanks in advance for any help,
> >>> Best Regards,
> >>> Marco
> >>>
> >>
