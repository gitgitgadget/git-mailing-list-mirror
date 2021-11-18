Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF18C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951F861B54
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbhKRBz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhKRBzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 20:55:25 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E0C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:52:26 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bk22so4692265qkb.6
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RqwNr8Q5UZCWIcBh+IfI7y4DbM0AweDoySH1NOJfqgo=;
        b=Xu3ZBoIsxIlyoPqjRUh0mMh5CBhB1hgNEZWncRu45grdYBSVaKD4nD0JnK6Q2l4PDU
         z5hKmMPBg4dMwsH5c+EzSD4f8u9ZZaGj+JJFL9BmPMJRYi2VaRsY7Hw1dqAd88cJ5gBr
         c3g+KG70q0IMO15HWE3vm4MePANReM4MxbR/Cnj8UrkbxtI5aeZkpPvrycrGYXq1h1Mn
         59FWEcCOb4Dk8yLVQG9yYewPxYm1nnAwvjscd0EvN/CQfEX+158Me7ET19Uezrb9wMnt
         rA00j6YoTV2lfE5pfnd37YOw82Albnl2Fx2pp4YvPC1ybjAMPbS/T1tMfh/NJgg0FjpV
         wHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RqwNr8Q5UZCWIcBh+IfI7y4DbM0AweDoySH1NOJfqgo=;
        b=MQsoI7i7b7kDM6klVsse83Q1ueYnhurEbdaReW+vd8lGf3oxYw0/H5j1nKecLOahTY
         PppEmsAV5Bl4yGVzEauQ+DnXyBMD82Hbo7RRC5kBVw4mf6MVAc/h1qvXKzgAW1Boi+uH
         HfouUC8GwJIxiuoiYL8h1FUapQVdmsXAIRtElTPsyKt6uNIB0pdQcowqudPEYafN1iLc
         NqfTQVcZArQ1ndGjw2qkSds4UwAbBOz6mc8AHHG/UvnnZDh6YrqaX3gajDAtT9iZUlGw
         MLc6UYK6ijNx4bTi0zuUC8gxxMme2gkKyz7wt0IPvx9oAGqqgtU9DpSlTAvsShzz0Xg4
         n3/A==
X-Gm-Message-State: AOAM533/NDxHYB53ijF7CoY3aRBY6bUKBxN80dK4f3lbooG33W+Vu8f4
        3c08IOnYCnG0s33Et8KSFUuVnVLBdSiDAdOnQ2Hzd+dy+NDWdQ==
X-Google-Smtp-Source: ABdhPJyO5blKmy53qUkyZ35u3mG6b5jsw/96rztH2Mq3g+aAXlgBsK5bdkDITpdMdIQvmxOO8FykABOclnHWDMvkSBc=
X-Received: by 2002:a05:620a:bc1:: with SMTP id s1mr18128461qki.49.1637200345725;
 Wed, 17 Nov 2021 17:52:25 -0800 (PST)
MIME-Version: 1.0
References: <127c9dbd-4861-beea-a85b-af7412ce141f@etguillot.fr>
 <6fa0b1dd-ac20-ff55-95ea-1c22347f9199@iee.email> <20211117175149.7slohfqqwsmn3ua6@yadavpratyush.com>
 <YZVB5hy4Xuim5K9B@nand.local> <CANYiYbFq-SAq2VLcFFX8P=Y8-JzjqW63mJqTuOCgO+q+Zzf=DQ@mail.gmail.com>
 <YZWvJdWcmhIl9DxR@nand.local>
In-Reply-To: <YZWvJdWcmhIl9DxR@nand.local>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 18 Nov 2021 09:52:14 +0800
Message-ID: <CANYiYbGuR8WNvD_2Kw_M0XX9H027Z2m137S0zwrfL7oURSpTUw@mail.gmail.com>
Subject: Re: Need help in understanding how to submit a patch
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Philip Oakley <philipoakley@iee.email>,
        Etienne Guillot <git@etguillot.fr>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 9:40 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Nov 18, 2021 at 09:37:57AM +0800, Jiang Xin wrote:
> > On Thu, Nov 18, 2021 at 1:54 AM Taylor Blau <me@ttaylorr.com> wrote:
> > >
> > > Jiang,
> > >
> > > On Wed, Nov 17, 2021 at 11:21:49PM +0530, Pratyush Yadav wrote:
> > > > Hi Etienne,
> > > >
> > > > On 17/11/21 03:47PM, Philip Oakley wrote:
> > > > > On 16/11/2021 21:15, Etienne Guillot wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I found a typo mistake in the french translation of git-gui.
> > > > > > I did read the instructions on this page
> > > > > > https://git-scm.com/docs/SubmittingPatches
> > > > > > but I still not sure where should I push the correction.
> > > > > >
> > > > > > Thanks for your help
> > > > > >
> > > > > > Etienne Guillot
> > > > > Hi Etienne
> > > > >
> > > > > The Git Gui is managed by Pratyush Yadav (cc'd) and hosted at
> > > > > https://github.com/prati0100/git-gui
> > > > >
> > > > > Not sure what the latest is on contributing translations (not cov=
ered in
> > > > > the GitHub Readme..).
> > > >
> > > > I usually ask people to post patches on this mailing list and I rev=
iew
> > > > them here. But I make an exception for translation changes since th=
ey
> > > > never get any reviews anyway.
> > > >
> > > > So I am fine with either a Pull Request on GitHub or a patch on the
> > > > mailing list.
> > >
> > > Since Pratyush is the maintainer, does the po/TEAMS file in your tree
> > > need updating?
> >
> > Git Gui is a standalone project with its own workflow. The file
> > "po/TEAMS" is only used for Git project, so I am a little confused how
> > to update this file?
>
> I misread Etienne's original message, I thought they were asking about
> the French translation for Git, not git-gui.
>
> > > I'm not sure how up-to-date the file is in general, but the last comm=
it
> > > was made semi-recently back in August, so I assume that the entry for
> > > the French translation is outdated.
> >
> > French l10n team is led by Jean-No=C3=ABl Avila, and is very active.
> >
> >     git log --no-merges -- po/fr.po
> >
> > L10n for git-gui are maintained by different people though.  Because
> > "git-gui" is merged into git using subtree merge strategy,  I cannot
> > find commit logs of "git-gui/po/fr.po" using the same command, and
> > have to find the original git-gui commit, and find commit logs from
> > "po/fr.po" (which is quite different file from "po/fr.po" of Git).
> >
> >     git log 8a383db4b2 -- po/fr.po
>
> Yes, clearly no update is necessary here. Sorry for the confusion.

It's really easy to confuse. No problem.

BTW, what is the elegant way to find commit logs of a tree from a subtree m=
erge?

I have to run git-log on "git-gui" to find the 2nd parent commit ID of
the subtree merge, and run git-log on it.

--
Jiang Xin
