Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75DEC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B43C2071E
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh5MsHk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgAWQzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:55:08 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45112 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbgAWQzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 11:55:08 -0500
Received: by mail-ed1-f44.google.com with SMTP id v28so3959868edw.12
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0FGYUBNY+RcwbEqbHOBtT3fnvEEJMhP/okkwnhnx+A=;
        b=Bh5MsHk0cTqupTy5xk7FZf5wv2eqO1sCUBHOv7EDj1zpGUX/1PiUAglT5B/YuOjSUR
         sCkjuNuub2QhK0LeBBhOwoOMWhDTYz+KfNnsd2eFR/latHOIa0m7v/0QAPRzwHf5zVbl
         G5JsqY58kEN2yUV7PQ1BIe79ot7ZK5744mwIm9Y3La3aLwHnyOxNPMhsyLcckAGvENq7
         qpzV7ifMWCP9f7R0/ZG8rEyQTc5O81sgwBX18YBTHtGio4AuvC16GQZrpdRUn5ggL9Bh
         dAUZ37+JUDQDRzg1bSAQ0HZV8rJ5d5juzeV16S+kYcrjTRuiNIoN7XdXVXuZABfQEJn/
         r1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0FGYUBNY+RcwbEqbHOBtT3fnvEEJMhP/okkwnhnx+A=;
        b=qD1hNX1DLJzMMCjFm457hlCrVixM/0/aRnaWIen2YYgtG6dBFyaFbdSwr2julQdPHA
         AHqAvzgKQv3RGJBST97+y6QHTBCL0yoO7DJRsXvbI3hJKpkyb19cMmjAP8R3SkGxBBRp
         9ERCLNMEux4WwIvIkECByT57+/OqzmrneI0FokTmH6SyZvPxpdmUp5va2DqTrU5HMBHb
         6ZK/kT06k+G0sX2NzS/bEo1oLyhUyVn/57K+J8fZEhzAGo7mhTWuhR4nYh7g3R3AHsJn
         XI2/8woyAwhc4BscNaIVXLoHufnuQmlz7ReaZduVz3DRK3xy70mCCDZTWtHILlssI5t3
         tJ3Q==
X-Gm-Message-State: APjAAAXCmdWB+t9wKl7nMGNPBv89tojVllZghfENMihiy+U58htQX2pZ
        sNkdUIStb+w/4+V9PZH01sSDBNRbij5SYGW/sAbrCvfhYsM=
X-Google-Smtp-Source: APXvYqzsWcC1QWDgf9GYi/kQdZNbg+G1kisQzMkYNB0Y9YtY3///KsY4djMRHj+Yrq/8sE6sAaea4wzPBpEqETpV5tw=
X-Received: by 2002:a17:906:3647:: with SMTP id r7mr7881465ejb.320.1579798506342;
 Thu, 23 Jan 2020 08:55:06 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Jan 2020 17:54:54 +0100
Message-ID: <CAP8UFD0sTTjFXhV3Ad6+2zw2q=rLtDs=FKZrLkE_EaQXdg91Dg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:

> * jk/packfile-reuse-cleanup (2019-10-23) 9 commits
>  - pack-objects: improve partial packfile reuse
>  - builtin/pack-objects: introduce obj_is_packed()
>  - pack-objects: introduce pack.allowPackReuse
>  - csum-file: introduce hashfile_total()
>  - pack-bitmap: introduce bitmap_walk_contains()
>  - pack-bitmap: don't rely on bitmap_git->reuse_objects
>  - ewah/bitmap: introduce bitmap_word_alloc()
>  - packfile: expose get_delta_base()
>  - builtin/pack-objects: report reused packfile objects
>
>  The way "git pack-objects" reuses objects stored in existing pack
>  to generate its result has been improved.
>
>  Needs further clarification?
>  cf. <20191115180319.113991-1-jonathantanmy@google.com>

Peff replied to Jonathan's questions and reviewed the above patch V3 series

See for example:

https://public-inbox.org/git/20191209081129.GA1546451@coredump.intra.peff.net/
https://public-inbox.org/git/20191209061853.GA38588@coredump.intra.peff.net/

I then sent a V4 based on Peff's comments:

https://public-inbox.org/git/20191218112547.4974-1-chriscool@tuxfamily.org/
