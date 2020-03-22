Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9F2C54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 10:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A6220663
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 10:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzToVbO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCVK7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 06:59:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCVK7N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 06:59:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id n25so11935547eds.10
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bK08YoPTy5wKEHtI3mDVh0/kkw7T1MVxBseAORX8TjE=;
        b=LzToVbO3GKiAMIaowQ7EGvDZkFj+WeK3AVycI+hbT5whOAnA9fyki+Andgm5UlBsxP
         jBmj+mjyGCvyLafzVRqH2TrZxOVFOEZPQEHZgue8ufYupRlXrt7yz1uxDrUgxup8TsLZ
         C51nVYqsn/jLrEwPpVH11YDYmT/Bq7T7/DeIiGYNftz1sUIdY9QynkRO60yIRYCR3OLy
         8OCxAK1fzQMZEm1VmR1t76+rfJdHbW5B5mANGWW10+VD9sHvfDn5VU/02UsWkd1UWnom
         yCo7fw4b/t6/hIkV7SCFLPNTu/Qt2qNmlmrwgONHa+4F8BBk0G34ibxXy96aJJPtgzbu
         79yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK08YoPTy5wKEHtI3mDVh0/kkw7T1MVxBseAORX8TjE=;
        b=ZIOdemhvv1xVUdnfgNK+F299CO0wkQ5h3CfWQkRLb029KeVTlbHexqwfPskl0xDyS0
         hSQgdbdvK9mGkmyaADfXCBxBew1u9j1qZsx9WdbeOjQRIH5grv4+3qU9LdMJEja+/brN
         izd6yDIBGOTYHbpdm81bLE65FwZ7EPqiJw/Fe7if4UnyJjkJkJR4s7J4K+gx2LBnZE9/
         dOicII8jjt7N2KCvJ9cv6qfgx1EUGlWZlJEhHXusd19IiP6ypXND38NJCQhJ4BOTG8wO
         FSY8+/kObVpqgjRgODBn6pIR7wp1uHUniLHxdyPaGeTMNIccDvBPmw5IPRTLtjk0x2lN
         SE1Q==
X-Gm-Message-State: ANhLgQ2D8G2xgAfCl5aP/qmbRsndbksKkflwAFV28CNFOtsvZWctpDbM
        zF7w75uHs4JhoBnV8JyisRic73sCEDSQqyg68fE=
X-Google-Smtp-Source: ADFU+vshEMSmbuBmgLSa4AdDjU3bonwlofQyw8vzm7qvhpRySFMUdyzfs5Z6xp2Hwi3mvDUHYOQNw/YnTv1uqi1Mp+M=
X-Received: by 2002:a05:6402:8ca:: with SMTP id d10mr16515393edz.362.1584874749588;
 Sun, 22 Mar 2020 03:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.586.git.1584638887.gitgitgadget@gmail.com> <20200322095137.GB635598@coredump.intra.peff.net>
In-Reply-To: <20200322095137.GB635598@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 22 Mar 2020 11:58:58 +0100
Message-ID: <CAP8UFD1mCXvcfUQxY4uMEPEjZp8+yPwu6SgTmZBEH6GR=8ixSA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Slightly simplify partial clone user experience
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 10:51 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Mar 19, 2020 at 05:28:05PM +0000, Derrick Stolee via GitGitGadget wrote:
>
> > This was something discussed briefly at the contributor summit: users will
> > have a hard time remembering git clone --filter=blob:none <url>. This series
> > simply adds a --partial option that is equivalent to --filter=blob:none,
> > with the ability to specify a size using --partial=<size> that is equivalent
> > to --filter=blob:limit=<size>.
>
> I have mixed feelings on this. I do like making things less arcane for
> users. But are we locking in a behavior for --partial that we might not
> want to live with forever? I.e., the current thinking for partial clones
> is to fetch no blobs at all, get all commits and trees, apply sparse
> filters, and then fault in the blobs we need. But imagine we later grow
> the ability to easily avoid fetching all of the trees. Would we regret
> having the simple name "--partial" taken?

I agree with that. Something like "--filter-blobs" for
"--filter=blob:none" and perhaps "--filter-blobs=<size>" for
"--filter=blob:limit=<size>" might be worth it though.
