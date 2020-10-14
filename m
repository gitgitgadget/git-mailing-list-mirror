Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C435C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B690E22257
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 02:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX+dJAWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgJOCJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 22:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgJOCJh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 22:09:37 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE35C025242
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:41:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i12so1307493ota.5
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmDBFKlRga+BFXtPRE3vQ3h/vXSR/nqSr8gNyAMTqNA=;
        b=gX+dJAWljnxb4TxRcHbu2qTBTILFA/uclliubCJeoPMwxrl0wT7cKDolgu5zLbOBbh
         MHgYnImvj2UVij8qM/8TfEBkADK1wcnh08jSwTHuVOZTtCKzMgxDwf8Z7qY2AYnwYwGn
         R1auzXfLBcUCysQEo8NsJ1v5jH/i0XvtFua4hqajda1zjCp/X9NIWPv0r6LZ8tvLCA7d
         kRnG0JVAYKK/2ujSAfDlexEsnPwkt377ULA+d6RPVahxAIAlNtg0Rd5wF8WN/sL8BNam
         81lNh8uM9AFZoEmap77iHfhBh/RIKZ+xaEle71RPnRs6jEwLWfmAuhE9vtEosSTT3nHi
         2dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmDBFKlRga+BFXtPRE3vQ3h/vXSR/nqSr8gNyAMTqNA=;
        b=hFfp5j28ifgcwgC0r+dau29TwCHTx1/Z+W6ncwS3cl4+qN7r4nO7rFjK03wucMmgOs
         Ef5d4mRu3VVwFaSm+haJTC6vkqHsJr13PEIApmS/Ntu6bo+ymmsPK3vs8VACNsE/ycPn
         LjYmigFEcT4tsThGCuxPy7CM6NBceNNhqCd71i9HNg9NNPH7zDLfQHMxdBwex+nGtLS5
         pR4aqLjKw6HEOX6LGSHDmxgmnESJ8kXiYVKmDMLHby3mdV+8iTDHRZhut50Iftc5wSi9
         iCvLQIb6pTnhCnwtN4MQcQGXZtGbXs7rNqts26V9zV9NaDy//9AGKLyHRoPiIt4/kAR7
         ldEA==
X-Gm-Message-State: AOAM532NMqZrFVdSbx/AkJtC4NlOW2MOIn/ZkNTZz/GFDWO5Yv4hqfjT
        MR0irDltI+8d5oXW3h5kqMdIfweWiGESxtcbWdqtOji/3TaUUXjj
X-Google-Smtp-Source: ABdhPJwiyYB5bYtBdijypRgzvDH/EtMhKhr87Z3NeEKnh8E3+hPkAXVC/zIRGwNnYHR0ecuvTv6okmLVZvUSReC/Szc=
X-Received: by 2002:a9d:2c4:: with SMTP id 62mr862977otl.102.1602718880013;
 Wed, 14 Oct 2020 16:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
 <20201014165607.GA2044338@nand.local> <CAN8Z4-XGbb_z3vmJYATONmBkxBcfxwyC-_4XEOkP0sxsdT9wxw@mail.gmail.com>
 <20201014172746.GB2044338@nand.local>
In-Reply-To: <20201014172746.GB2044338@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 15 Oct 2020 00:41:08 +0100
Message-ID: <CAN8Z4-V2zb4kLw9wgkWxf+Cs9NdgUu5YHnhtDZm0qiqf4WS+BA@mail.gmail.com>
Subject: Re: Partial clone fails with file:/// URI
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I improved the "bad pack header" error message in a patch off of
v2.28.0 (https://github.com/gitgitgadget/git/pull/755)
However, rebasing onto v2.29.0, it seems like the error no longer
occurs during checkout.
Was there some recent improvement? Looking through the changelog, I'm
not finding anything obvious.

It appears that regardless of
git config uploadpack.allowanysha1inwant true

we find `git checkout` succeeds on v2.29.0

There is a test case in the PR above
Also a manual repro:

cd git
git checkout v2.29.0-rc1
make
cd ..
git/git clone --filter=blob:none file://$(pwd)/git a_clone_of_git

Thanks
--Nipunn

On Wed, Oct 14, 2020 at 6:27 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Oct 14, 2020 at 06:04:18PM +0100, Nipunn Koorapati wrote:
> > Hi,
> >
> > I've been building git from source and directly using the executable. Roughly
> > ```
> > cd git
> > make
> > cd ..
> > git/git clone --filter=blob:none file://$(pwd)/git a_clone_of_git
> > ```
> >
> > This is what I was missing:
> > git config uploadpack.allowanysha1inwant true
> >
> > If this is not set, then the checkout fails w/ a
> >
> > fatal: protocol error: bad pack header
> >
> > Perhaps the error message and/or docs could be improved here to
> > something with more detail than "bad pack header"?
> > Not seeing anything to suggest this in the docs
> > https://git-scm.com/docs/partial-clone
>
> Ah. OK; I feel much better knowing what the difference between our two
> setups is. This is a long-standing issue (I remember seeing it when I
> was experimenting with partial clones several releases ago) so I'm glad
> that we _don't_ have to treat this as a regression in 2.29.
>
> > Thanks for the prompt response. Appreciated!
> > --Nipunn
>
> Thanks,
> Taylor
