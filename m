Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD34CC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFBE613E0
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 17:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbhDVRZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVRZB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 13:25:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4D7C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 10:24:24 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n184so20525060oia.12
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFUhglgcfZeQhcPuM+FQW+rxtqwPF80+jEY6L9prPp0=;
        b=REXi72JD89mi1FJkYeP/O3xLiOlufANVaaz/iYMDvlmmvrnM4C3uLenUVSsQ9Tq5i8
         6tBxy/e4j7C4v6Bva+d+/GnZAKRzEKMsoe/aTXjsUYJsJECj1lTeYrWJmT4h58fTkYkE
         L5iPDLydIRYGbsWele/9lA6Warh2Q0Q/C/EE9XnOWzPdnyip1xT101w82zFThWYJ+rGl
         31S7No9tlW3FyLPODS0e//KPpuj2HxMa4gyUQUhL38xkFcgQ9afyeqfEpRapE2EHBh2x
         mMInHUI80saaLgtqtpv/8sII4YLcUfBqXIDRn4GnQrGJUhMfAOpHrhbohBRMY28pJujQ
         vIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFUhglgcfZeQhcPuM+FQW+rxtqwPF80+jEY6L9prPp0=;
        b=hFL9rmmshIELj1lXg4A9bLyzzhQuEKY0X8A38CGnYb18gNoRcQ+4h1ccuyyfRhg6su
         UEluaXc3//nTzA+PFXdtoHiV9NJdb981qnnc1l9tfbwwAS1KowxCZzzYa8ubhCH/H+Fj
         ZNS/m8UVgqGrhIEflG33oRX8GnpFbziF2k/kvRuP3zsy8wmps295hCOx9fH3931K2ogA
         /3gBjiVQL9crF/mY2AywgK+aSHWb2bNW98nP9Sc9ncdFpjW2DdjmRbd0tACJU+hAUGoN
         fMrKJLlgW1gCR6vC1kemhhz0TmcOZKyOHeKOiemil00PlPZIWteo6tpkMAKVTKkOTLTV
         Ix+Q==
X-Gm-Message-State: AOAM533sMpV3j91eSH3fQJwkswA/h3qejWM7vpFZlZpKlu3DqWf1Gudx
        kwSo1Ux+xD3jDwTn+dqLhxN3L609kuqoftMb1mM=
X-Google-Smtp-Source: ABdhPJw9LHYMcYo5AV3amZbtZ7XxF6XznyTuSBX0WCQaKWfgVCyVovQ03oPPwXIxdr/bsfdz7qT6CQuZ9AhrlDyU6Jo=
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr706688oia.167.1619112263975;
 Thu, 22 Apr 2021 10:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com>
 <YHdzDlAfsuZ21HR7@camp.crustytoothpaste.net> <YHf+m7vOQumdJXwX@coredump.intra.peff.net>
 <MN2PR00MB068886B8F36DFC645138DA0489469@MN2PR00MB0688.namprd00.prod.outlook.com>
In-Reply-To: <MN2PR00MB068886B8F36DFC645138DA0489469@MN2PR00MB0688.namprd00.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 22 Apr 2021 10:24:13 -0700
Message-ID: <CABPp-BGWnnMGeK+507Bhm7go-23tVVmT0WfOph7cpHLVEr6snA@mail.gmail.com>
Subject: Re: Git clean enumerates ignored directories (since 2.27)
To:     Jason Gore <Jason.Gore@microsoft.com>
Cc:     "peff@peff.net" <peff@peff.net>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, sorry, I've just been swamped.  It's still on my list to look at.

On Thu, Apr 22, 2021 at 10:18 AM Jason Gore <Jason.Gore@microsoft.com> wrote:
>
> Sorry to add noise to this thread but since the github issue was closed I wanted to make sure I'm not missing any updates here. Would any updates come through on this thread? Thanks!
>
> -----Original Message-----
> From: Jeff King <peff@peff.net>
> Sent: Thursday, April 15, 2021 1:52 AM
> To: brian m. carlson <sandals@crustytoothpaste.net>
> Cc: Jason Gore <Jason.Gore@microsoft.com>; git@vger.kernel.org; Elijah Newren <newren@gmail.com>
> Subject: Re: Git clean enumerates ignored directories (since 2.27)
>
> On Wed, Apr 14, 2021 at 10:56:14PM +0000, brian m. carlson wrote:
>
> > ----
> > #!/bin/sh
> >
> > git init test-repo
> > cd test-repo
> > longname="directory"
> > touch "$longname.txt"
> > last=400
> > for x in $(seq 1 $last); do
> >   mkdir "x$longname$x"
> >   mv directory* "x$longname$x"
> >   mv "x$longname$x" "$longname$x"
> > done
> > git clean -ffdxn -e directory$last
> > ----
> >
> > When it fails, it will complain that it wasn't able to open the
> > directory.  It still exits zero, however.
> >
> > I haven't bisected this, so I don't know if those patches are related
> > to the problem or not.  I'm a little short on time today to
> > investigate further, but hopefully this can get someone on the right
> > path with a modified version and git bisect run if nothing else.
>
> It bisects to 8d92fb2927 (dir: replace exponential algorithm with a linear one, 2020-04-01). I won't pretend to understand everything going on in that commit, though.
>
> -Peff
