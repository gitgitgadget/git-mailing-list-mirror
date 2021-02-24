Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DDC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB72164E7A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhBXU5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBXU5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:57:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE16C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 12:56:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a17so4711536lfb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W7P35LmzeiACyaMDwhzSSLIsbJYwP4avf5slqLmOQU=;
        b=HPcUt6v3AVL9zkXmOuibNPyjUsc8WThzFio5JLDrCc+fBychxH4z7M8mGR2kXJN/fG
         iHkAEdC4gZg+Lcp0S1f9Dj57Xi7bUkLoz8UvvgV6LPqZ6NdKq/yGKOXLVkgWLbvIw++e
         xi5Ne4UuGtrzztFFEE8G0FYD+WjbZzKjDCY/vutyxYG5D8ybmS4os+mlIExAz2aZMzfv
         ui6nLv9gGVvbpIUUJL//FjEdSYrX+5rjiCiho8cnCyTCfmi/mY1Jsn6JbepZPFLd2eBb
         dmhPos7hua61eZq9acLz50UtdkVueeLybS29Z1HrhuXxumZvXNNCy1oj0HnmJlVw+Mu2
         QZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W7P35LmzeiACyaMDwhzSSLIsbJYwP4avf5slqLmOQU=;
        b=OZ7m6DixgGKDX6RFeXrIusIc9SrnHNPagMkBEY8taXVNWJrET2VvFERNYcXV9sA0KH
         RDHpL68OYqgwyew748+Rg8Q5o83nL/oIFxMSD+zco8/T+X/QZlZbvCd6oiZ/1sBXV2NA
         RNoBf4150ZSo4v+OvJO/q3Fjptql8sAhdNg2EGQclaOWB8pvG+LojVY/bDHH8vvDZcqn
         6hjc+bxVxpEOzU3hfGzQ/pHd+BYCZBOfv7MQoZHVoLyvVjMCrxubI3u0BmNiQo5hEatN
         U6cM2Y0jhlMWj5+6c67bPRffF7kg7kLdKg7G1SKRDi5klTnljqtKphwsKFLeYW9L2/o8
         8UGQ==
X-Gm-Message-State: AOAM530srMEdJGGaEoZqj8i6i28bBwNIEjJcvGLBrUZlUE9/UFRKC4nm
        48kuWF0pJ95FZthdJpyU0Zp6bZJGy7f5A1hfgOI=
X-Google-Smtp-Source: ABdhPJy50JX2ET1neJEMC/ogZ1KfppT4jOit6fIkf0BBHl+xL/dYOlovJtF/AbfrGhJPDVxVkADhp0BQp087OV0hoCY=
X-Received: by 2002:a19:6b04:: with SMTP id d4mr20790493lfa.638.1614200217642;
 Wed, 24 Feb 2021 12:56:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
 <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com> <xmqqv9ana05b.fsf@gitster.g>
 <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com> <xmqqo8gd8tyr.fsf@gitster.g>
In-Reply-To: <xmqqo8gd8tyr.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 24 Feb 2021 12:56:46 -0800
Message-ID: <CANQDOdfJApBOEm2gPMwtz9T0ETPoDk107mF7LYRGCmjFLi3Jxg@mail.gmail.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 21, 2021 at 4:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> >> >>   -#define WRITE_BUFFER_SIZE 8192
> >> >> +#define WRITE_BUFFER_SIZE (128 * 1024)
> >> >>   static unsigned char write_buffer[WRITE_BUFFER_SIZE];
> >> >>   static unsigned long write_buffer_len;
> >> >
> >> > [...]
> >> >
> >> > Very nice.
> >>
> >> I wonder if we gain more by going say 4M buffer size or even larger?
> >>
> >> Is this something we can make the system auto-tune itself?  This is
> >> not about reading but writing, so we already have enough information
> >> to estimate how much we would need to write out.
> >>
> >> Thanks.
> >>
> >
> > Hi Junio,
> > At some point the cost of the memcpy into the filesystem cache begins to
> > dominate the cost of the system call, so increasing the buffer size
> > has diminishing returns.
>
> Yes, I know that kind of "general principle".
>
> If I recall correctly, we used to pass too large a buffer to a
> single write(2) system call (I do not know if it was for the
> index---I suspect it was for some other data), and found out that it
> made response to ^C take too long, and tuned the buffer size down.
>
> I was asking where the sweet spot for this codepath would be, and if
> we can take a measurement to make a better decision than "8k feels
> too small and 128k turns out to be better than 8k".  It does not
> tell us if 128k would always do better than 64k or 256k, for
> example.
>
> I suspect that the sweet spot would be dependent on many parameters
> (not just the operating system, but also relative speed among
> memory, "disk", and cpu, and also the size of the index) and if we
> can devise a way to auto-tune it so that we do not have to worry
> about it.
>
> Thanks.

I think the main concern on a reasonably-configured machine is the speed
of memcpy and the cost of the code to get to that memcpy (syscall, file system
free space allocator, page allocator, mapping from file offset to cache page).
Disk shouldn't matter, since we write the file with OS buffering and
buffer flushing
will happen asynchronously some time after the git command completes.

If we think about doing the fastest possible memcpy, I think we want to aim for
maximizing the use of the CPU cache.  A write buffer that's too big would result
in most of the data being flushed to DRAM between when git writes it and the
OS reads it.  L1 caches are typically ~32K and L2 caches are on the
order of 256K.
We probably don't want to exceed the size of the L2 cache, and we
should actually
leave some room for OS code and data, so 128K is a good number from
that perspective.

I collected data from an experiment with different buffer sizes on Windows on my
3.6Ghz Xeon W-2133 machine:
https://docs.google.com/spreadsheets/d/1Bu6pjp53NPDK6AKQI_cry-hgxEqlicv27dptoXZYnwc/edit?usp=sharing

The timing is pretty much in the noise after we pass 32K.  So I think
8K is too small, but
given the flatness of the curve we can feel good about any value above
32K from a performance
perspective.  I still think 128K is a decent number that won't likely
need to be changed for
some time.

Thanks,
-Neeraj
