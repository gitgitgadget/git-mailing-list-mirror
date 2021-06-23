Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B42C48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9E46120D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 06:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFWGuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFWGuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 02:50:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25AC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 23:47:57 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h9so2232314oih.4
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 23:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOd/2PWJy2r7P9ZMCDXQK3c+Y+z1ot9PJy908G49V3k=;
        b=E/mOMywK3f4gfrbDBYVrfTQH7vA3LWmK2R2D1cT0l9eu3z4xyaVmZQiIEZ/E6g54Zx
         1kjoxto/zouzAa3eSKv6e3tnB3YSUPIBM9Rfik+OqzbUAz3e9i+frPOCO+LVzHbY1FNB
         ZZyLcKtq8d1i+1Y/MN1V4hYEJOC4spSy2ujbL93V+xy/tONmMJ5+ajBBKn8f2j6+ruVz
         C6RxvIH0qkII1PTjxCoQkA6L6rYM0Uvv8SCblO1xzS2cYir7nKe1ZMonLLpfy4NCENwc
         tl/0OV9o/h1cnSgtBhR325DJvGZo5NHtkLm63fuE+DsXx4ZGMVMDCFIV1SwqKV3YBxfK
         w3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOd/2PWJy2r7P9ZMCDXQK3c+Y+z1ot9PJy908G49V3k=;
        b=gPms0MLsmsKSCc8KB98nkqUleUmjo37lFGLP2VlUQsKWQk37CGjY0m6i619atnAu2T
         ZKXFspDQL+fzgiVM5WJKoo2yB9dPQeXqPJPXWvxQaOwPVHzIoEUp8fN8f5w7fLz0KGSR
         5pLAMTey5VcBgE5qpKnSiO0GNvkTfGNmIsHtACDdFzPktGZjWA736OkenpB3eQ+6v9xd
         HAqpeBad/3kPL8nZVRA6I8FOtRxTCBdTFFC7cq3/m9GYfnfKkhXNhd/av3fNwDtWVJ9B
         EcLhVcoKykyKiAKFcD/2ElCIj4uv4NL7iAWFH1BvRCCF9GdU1v6oO7U3vJiBzS5/ZRHp
         H/1w==
X-Gm-Message-State: AOAM533T0uuuxjgJmKM7Mf4Vhx/yljn39M6oirCBThrcRWhTapUaRRF9
        wOl80H/LLGjrysh7G1hUmW9bmjKu58IXPvzQkU0=
X-Google-Smtp-Source: ABdhPJwD5Vm+EsOpx7iKrPIXhnzvhsAC0yMrczELeMKRrS58G5oq7eJu/mywuHEGgCCPsnyftFSRJA/t9Tb2cLIGW9M=
X-Received: by 2002:aca:f482:: with SMTP id s124mr2015091oih.167.1624430877250;
 Tue, 22 Jun 2021 23:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <CAMMLpeTmYcJHf1t7VpOBakMZ_vtk+9bmLRTMA9ueghG6WwCRtA@mail.gmail.com>
 <CABPp-BEnPrg_tsqLtmj7Ag6JnR6ku_K3Uv65rdRu-j9_qMYhmA@mail.gmail.com> <60d2b5ffc23af_1b53208aa@natae.notmuch>
In-Reply-To: <60d2b5ffc23af_1b53208aa@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jun 2021 23:47:45 -0700
Message-ID: <CABPp-BEPgUAe-efyk-Y5AVXRe64uUtz0XUJ-fPzKi8eSfnEquA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 9:18 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Tue, Jun 22, 2021 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > >
....
> > > Thanks for the link, and sorry for not having followed this
> > > conversation closely enough to have seen your previous replies. While
> >
> > No worries, you were trying to be a good citizen by reviewing patches,
> > and the patches didn't come with links to the old threads
>
> That's not true. This patch series [1] came with a link to the previous
> patch series [2].
>
> I didn't, cannot, and shouldn't contain hundreds of links to the hundres
> of responses to this topic over the past 10 years.

Sorry for being unclear; by links I meant either direct or indirect
ones.  Your series came with a link to the previous series.  The
previous series, however, only contained a link to a series you were
basing upon rather than to a series which contained the changes you
were resubmitting.  Thus, following the links in each submission would
not get you back to the old discussions (I double checked).

Also, this particular point was not meant as a critique of your
current submission.  I don't even think it's all that big a deal for
the previous submission either (it's an easy oversight to make given
that Junio submitted a portion of one of your old series).  My point
was simply that Alex didn't need to feel bad for not having been aware
of all the old discussions; even if he had tried to dive deep by
recursively following all the links, he wouldn't find it.
