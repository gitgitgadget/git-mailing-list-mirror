Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27DC433E9
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 07:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FE464EDE
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 07:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhBTH5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 02:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhBTH5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 02:57:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDCC061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 23:57:07 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k22so37329048ljg.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 23:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbFkhsImNk1pOX9ZzV9QER9/u6c5OPXYXZmv+YiaVmA=;
        b=UFqk3UyPb7BvfnqJONTq0kBd4JG31HchsI7Cs5rQmrXOLw3qbSOUdJJQ5QLeyZcvQ3
         Qaufx7nthCWjak03wvV2uLcrjritBP6UP3kXGlkgYiT+iCkpL3w8OOuiF8k7xMeXRto7
         QUzT1VwwgWomfaey7xlGsItL5567KJBj79lYk7CbLUosZe7hsb65UWd8kSe8l45fj/co
         JfLhtRh73Ibcj7N9t0Xoz4MAEMH7Pbh6P02GaQ++Ndlb5DMmuPVnkr2GhTjPhHv4Dy38
         Ec6W0MM75PbaZq/5wRBfDyz2FNDZXtD5WrZKksGNOQ4OPdktQD1hbfOKzkdnTjghx7oS
         U9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbFkhsImNk1pOX9ZzV9QER9/u6c5OPXYXZmv+YiaVmA=;
        b=A5+6JZLbJU3O0tuIYRM0JdAE2trO5bd6OI6ylTOfIJEXlfaqfu3c4rTiR4Yt4sbkeP
         d1r9xZvfZJlwlHg3iM+OTc5LccjBImrl/uyKqXOriD4J2Gd+EsEtr0sh90z3JGL9m0+6
         Q2Vy18DsLoMuDp7JbrFvAHIYBB2TMfjQNRvniRr7vSmHw2efyXgKjiP0eICYr9H5vjFh
         vccuMAHQWJAKbdnB//yQAU1HhvILjySTOXG9ofnEEsSzbgIujzGjk5BT+cruSuGt0oGi
         sHpohuFmOpsVBzfbvDdA1JUA9zLqq7lD5vq+O6cn1XIUHmpnK0Aniw4PlyCRi/0axeD/
         pqUA==
X-Gm-Message-State: AOAM533LybIDRf7aV8oa9AuDi47Ty/YxPIl3Z/VHoH5R731TPGhbNGqo
        WyEWM0jikmvms3ynHfNMQ7UZ9cG5izWPsPV1JLw=
X-Google-Smtp-Source: ABdhPJwBTFDnQbDrqRX5n3PSygBK3BV/u2XHXVSqbpLf0FCIJ6teIIHwT1VOrrgNDfvNAqqfR/V6ppuuSFf2mNTowz0=
X-Received: by 2002:a19:41cd:: with SMTP id o196mr8377730lfa.30.1613807825645;
 Fri, 19 Feb 2021 23:57:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
 <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com> <xmqqv9ana05b.fsf@gitster.g>
In-Reply-To: <xmqqv9ana05b.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 19 Feb 2021 23:56:54 -0800
Message-ID: <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 19, 2021 at 11:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff Hostetler <git@jeffhostetler.com> writes:
>
> > On 2/17/21 9:48 PM, Neeraj K. Singh via GitGitGadget wrote:
> >> From: Neeraj Singh <neerajsi@ntdev.microsoft.com>
> >> Writing an index 8K at a time invokes the OS filesystem and caching
> >> code
> >> very frequently, introducing noticeable overhead while writing large
> >> indexes. When experimenting with different write buffer sizes on Windows
> >> writing the Windows OS repo index (260MB), most of the benefit came by
> >> bumping the index write buffer size to 64K. I picked 128K to ensure that
> >> we're past the knee of the curve.
> >> With this change, the time under do_write_index for an index with 3M
> >> files goes from ~1.02s to ~0.72s.
> >
> > [...]
> >
> >>   -#define WRITE_BUFFER_SIZE 8192
> >> +#define WRITE_BUFFER_SIZE (128 * 1024)
> >>   static unsigned char write_buffer[WRITE_BUFFER_SIZE];
> >>   static unsigned long write_buffer_len;
> >
> > [...]
> >
> > Very nice.
>
> I wonder if we gain more by going say 4M buffer size or even larger?
>
> Is this something we can make the system auto-tune itself?  This is
> not about reading but writing, so we already have enough information
> to estimate how much we would need to write out.
>
> Thanks.
>

Hi Junio,
At some point the cost of the memcpy into the filesystem cache begins to
dominate the cost of the system call, so increasing the buffer size
has diminishing returns.

An alternate approach would be to mmap the index file we are trying to
write and thereby
copy the data directly into the filesystem cache pages.  That's a much
more difficult change to
make and verify, so I'd rather leave that as an exercise to the reader
for now :).

Thanks,
-Neeraj
