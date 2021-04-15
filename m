Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF8C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF6360E08
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhDOUik (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:38:40 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:45046 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhDOUik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:38:40 -0400
Received: by mail-io1-f42.google.com with SMTP id p8so4174665iol.11
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 13:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0I0TNpx5Bi1X0GpB8dv918sg3Uqf0F+PRH0aOBFJCM=;
        b=CKdYLyUu6dn0QazgXZEkfuM3tzX+pHxbbm0FYU+U1wOCXt4XtoqiQf+3jm3Dor19TL
         Fsi5aVGoTSCov213cnLZUlWNNJzkFwh/ShHPVkbPc14rD/u2YzsRVgyNdCJychYAHhJ8
         Ya40Ehil2MFXA6Ss4K3OPg/DWz5ZfK9dIdFKreg17PldMTbeOmK9joSMbrBw9ntbPmzG
         ZbPt2mVaHOjmAg8eRv140pJvCW3jL1KdKROLHCMb6at7cq6OTKXZ0aAqImu1VB5d4Xe8
         XkmFYZiYwr3xzY+sj4tZfqpLE/dFB6pDO592DD5jfl8ZoVF1+mz46/7W2FxTNwc6xB0l
         PnQw==
X-Gm-Message-State: AOAM5314VjtvCYau0x6Xns/BJ4UqaZMvfv9lRzVB7138zyaFz2n6cScb
        3sPwUvuCmVRAqnFUxEGnaeWqAauUE/ezGD5jTak=
X-Google-Smtp-Source: ABdhPJwsuM0GHbtMxaxELkO6yet0KIIvHDWgKmpePAJX73CV45VGF8hoAEOfcfHRZKj94xtHHnGsQcmwoNzxCLA1AqA=
X-Received: by 2002:a5e:8717:: with SMTP id y23mr761398ioj.111.1618519096500;
 Thu, 15 Apr 2021 13:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net> <87tuoijzsy.fsf@evledraar.gmail.com>
 <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com> <CAPyFy2A25EApYOivqhD_-sUNpep9c98DXHh0tXLd7T17qQLFLg@mail.gmail.com>
 <xmqq7dl3qqrh.fsf@gitster.g>
In-Reply-To: <xmqq7dl3qqrh.fsf@gitster.g>
From:   Ed Maste <emaste@freebsd.org>
Date:   Thu, 15 Apr 2021 16:37:54 -0400
Message-ID: <CAPyFy2Bf8t_2HggKG7LMY4u=9qBJ0-+xcx-gCv_kh7KYHg1-hw@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui <albertqcui@gmail.com>,
        git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 15 Apr 2021 at 15:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ed Maste <emaste@freebsd.org> writes:
>
> > On Thu, 18 Mar 2021 at 21:29, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >> > +* Works across Windows/Linux/macOS
> >>
> >> Git supports other platforms as well.
> >
> > In particular, FreeBSD is an example of a platform that is not in the
> > above list, but included in Git's CI. Is there an explicit list of
> > supported platforms (and perhaps a notion of support tiers)?
>
> It is not like there is a Git company who employs developers to
> support certain platforms.  This is the mailing list for the open
> source development community for Git, and Developers come and leave
> over time [*].

I'm sorry that my query wasn't clear; I have no expectation of Git
volunteers providing support (in the commercial sense) for any
particular platform.

What I am interested in is the Git community's expectations around
platform support, with respect to new features, changes that break one
or more platforms, and similar. I submitted portability improvements
for FreeBSD, and certainly expected that if a change introduced a
regression on one of Linux, Windows, or macOS it would not be
accepted.

> * You can peek into config.mak.uname to see the list of platforms
>   that have had a working Git some time in the past.  Hopefully most
>   of them are still up-to-date and working, but we wouldn't even
>   know if a minority platform, for which an entry for it was added
>   to the file in the past by some developer who needed a working Git
>   on it, no longer works with the latest version of Git with recent
>   toolchains after the original developer lost interest.

Yes - this is what I'm wondering about. It seems this information is
not available other than by inspecting config.mak.uname or reading
mailing list archives. I can also look at .travis.yml, .cirrus.yml,
and .github/workflows/main.yml to get a sense of the platforms
supported by Git's CI. That includes at least various versions or
flavours of Linux, macOS, Windows, and FreeBSD. Is it worth putting a
sentence or two in README.md about this?
