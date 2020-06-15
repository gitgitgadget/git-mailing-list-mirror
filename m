Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E6C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7338F20714
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkwDww8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFOVqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFOVqU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:46:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD95C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:46:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id a3so17378805oid.4
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HnZXy5NrVYP0kVyjOT6VCOWwbuHORGuF0Lp6PAiLjU=;
        b=OkwDww8+EffuVwRMYw/vUm9UW15nsoBUeBNa1ORpvf9Ps8mPCWUOoPRpnZBcrSC42C
         dz+IokXD09gz7WlctllrE8+R/037FgxpQdOe2MLcWblFou15OeSQR0qEeKWAZC0R7eUQ
         FpLYtA8Kqit5FAfI5aNjEhCBdVugEYldlnSRYjO0Pum6sXF4HjC4af99gSJWVF9d9XT9
         70uhfDnhmfBWMePdXV7zWHuM9EYMJ0/eUt31fvcDBAN4XvU7+VFCrNfYN5ekJvM8Zvjm
         zsG9q31DvrEUqYk/pE5MWq+ERmvPQ6Deq5l5GnP3wvIq1pKqT6EBAu5y1+620V4YBHXL
         JbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HnZXy5NrVYP0kVyjOT6VCOWwbuHORGuF0Lp6PAiLjU=;
        b=NzyaTedBHvf07E/bIKkvII6tVH4LeAwmLP1q4A5WVbGDO9Pvk44wW2n1pFwK9iiEs7
         59uoKZYGeI9qTBlQ0lRwyp7Win17ZrN4sWIC9/zS5spGGob2NZ+kkuh3uSmZRdTcfFcz
         ucMbvt817lhpeNquVSERUQSZ/cE+UQ7+Ma8UJMa8JYTY/rq5AVJp4DQkk2VhEDJfOhoF
         8aHe8bimhJtiCV91W6k3fyOU7+d0IDRhBZlExydQFyYVLgYZ1BC3JS2jY0RZ0qz9Mqhu
         /HmNzgbA9eElS9LLKAUp+Q5PYCFh3hlrC9JnNKoyRwPc9Xjg883su1x+ovq4bvqR7yOZ
         VnBw==
X-Gm-Message-State: AOAM5330nM1g9pnZk9etylNgBVIJaUoo8pXXMrf6lvhetWcUKoCJT4xM
        cfNPFOpVOXaZo3GpCGdpzdqdJu/Gklzdac/3zGg=
X-Google-Smtp-Source: ABdhPJxRQpqRGxhn8fDGMnYICmOwVv7bFCMS+PjwjwaJHFPsUbylbPMi7JWKsGrJ0qZ4i2MJHXiegKPLhpnaTaf4Gh4=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr1109714oic.31.1592257579095;
 Mon, 15 Jun 2020 14:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <CABPp-BF8vo_fCbM1ct0MYFhQcVmPwfq7_Q3Fd+SnM0=gVmxkrQ@mail.gmail.com>
In-Reply-To: <CABPp-BF8vo_fCbM1ct0MYFhQcVmPwfq7_Q3Fd+SnM0=gVmxkrQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Jun 2020 14:46:07 -0700
Message-ID: <CABPp-BFpE=fH7o7K-SLbU=k6NC4YN_jViu0ATeDHaZ+u_5UjGw@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick clarification:

On Mon, Jun 15, 2020 at 2:38 PM Elijah Newren <newren@gmail.com> wrote:
>
> It probably doesn't matter at this point, but can I point out an
> additional issue with "default"?  I worry it's quite likely to lead to
> confusion: does "default branch" mean the one named "default" or the
> one HEAD points to?

...or the one HEAD *on the central server* points to?  (This issue may
not be relevant to those that aren't operating with a central
repository workflow, but the branch checked out when the user first
clones is often thought of as the "default branch".)
