Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE66C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 00:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894A22077C
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 00:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI1Owmpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgAJAGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:06:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgAJAGX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 19:06:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so76403wrw.8
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 16:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AVDdHS+gwoOtZzx5UUGOp5edCR8+HzN4ChIUUVkIuBs=;
        b=mI1OwmpwsomuUhOHJpjMergU2UwN2xl/2ev5WPy6KHm3qBokNa6jsfy0bg9GATI1I2
         F7sW3ZUiedVliMK5XWRCKtRgoP9zuyOWwRgwwdtxN/T4sKeK8KJAqeZ5GNjCAKfD9hWw
         dZRI4mDfTQJClputXMs+k4kxwl0DBD/X1kEBtwzKnb4KMF8wqQ6ZG9sei0y7b/nEMD7/
         m3c8w+pqjGl6jnZPXPPBmDubcEDrps4cEABGD8HnsVwiSicoA6OIWV7x2bJfw3I/XtE5
         jE280uHWrxqov/tveO3slmhcledNIeerHeS7tJ1ihSDlI3hikJQ1uqT2XSKJ2cNECNBP
         2XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AVDdHS+gwoOtZzx5UUGOp5edCR8+HzN4ChIUUVkIuBs=;
        b=Kg09XhzGfXUysLBHaGkjX7rjm+p2q4wDeEG2GIUqwRJwcA/mJhcfGxMIs9/P3bLmWJ
         dwt2JONuNzSj8UVVXK5NeY0ZzNby+1hrY0ILfFm6BF6LTxE2Fdvpg6HeuncWwxlDLZne
         4O9iF8cp2iGFkL0ztN0vZK+jCBA3u3i6fwBOXVg152mvC2r+rh/FQ5YA1WGyiQb7rC+z
         qprqnXhxAyxp+UyHtPC4GN3kmD/uqg7grRLJKR9+BrdzSjWA4nz3rFoIiRuq1qHIPdhV
         vsBsVg/RYxrMSah4DX780WJpgFzUyckZa1ByEjr2X87Lf34YVfMEYWg2patLham7X3FR
         M7mQ==
X-Gm-Message-State: APjAAAUAW0GZ9yVvFFHl++OKIelhgrDjzqrF8qvrcp2GtavfiTdg88kS
        oR+1gDplSwds2QepH1rS36s=
X-Google-Smtp-Source: APXvYqxO/Hnqz9n8+MJDGgPmmTgOS5RVJS7lrINEroP2kkxghITw4FMBYeu+nrpaCMy5ipdqeVCpng==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr99808wrs.106.1578614781849;
        Thu, 09 Jan 2020 16:06:21 -0800 (PST)
Received: from erosca (ipb218f5ef.dynamic.kabel-deutschland.de. [178.24.245.239])
        by smtp.gmail.com with ESMTPSA id p18sm247541wmg.4.2020.01.09.16.06.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jan 2020 16:06:20 -0800 (PST)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <rosca.eugeniu@gmail.com>
Date:   Fri, 10 Jan 2020 01:06:03 +0100
To:     Elijah Newren <newren@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
Message-ID: <20200110000603.GA19040@erosca>
References: <20200108214349.GA17624@lxhi-065.adit-jv.com>
 <CABPp-BHsyMOz+hi7EYoAnAWfzms7FRfwqCoarnu8H+vyDoN6SQ@mail.gmail.com>
 <20200109105307.GA1349@lxhi-065.adit-jv.com>
 <CABPp-BFiDNb18m8geTCxKLXg0fOd0DS1dWRVWCfnTG0suwGRHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFiDNb18m8geTCxKLXg0fOd0DS1dWRVWCfnTG0suwGRHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, Jan 09, 2020 at 10:05:52AM -0800, Elijah Newren wrote:
> On Thu, Jan 9, 2020 at 2:53 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > Some years ago I was hit by 'git merge' producing slightly different
> > results compared to 'git rebase --onto' and 'git cherry-pick A..B'
> > (maybe I can come up with a reproduction scenario for that too).
> 
> If you can, I'd be interested to see it and take a look.  I'd normally
> assume it was just some case where A..B included "evil" merge commits
> (merge commits that made additional changes not part of the actual
> merging) since rebasing or cherry-picking such a range would exclude
> the merge commits and thus drop those changes -- but you identified a
> real bug with the default rebase backend so I'm interested to see if
> you happen to have more bugs I should know about.

Here is a _simplified_ scenario to get a totally unexpected result from
'git merge' (initially reproduced years ago, but still happening on
2.25.0.rc2):

   ## Preparation
0. git --version
   git version 2.25.0.rc2
1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
2. git remote add linux-stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
3. git fetch linux-stable

   # Reproduction
4. git checkout f7a8e38f07a1
5. git merge --no-edit e18da11fc0f959
   ## Merge v4.4.3 commit
   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e18da11fc0f959
   which is a linux-stable backport of vanilla v4.5-rc1 commit
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7a8e38f07a1
   the latter being checked out at step 4.

6. git show HEAD
   ## Inspect the _automatic_ conflict resolution performed by git in
   drivers/mtd/nand/nand_base.c. Git decided to integrate e18da11fc0f959
   alongside f7a8e38f07a1, while essentially they are the same commit.
   We end up with two times commit f7a8e38f07a1.

What do you think about that?

> Unfortunately, you should note that git-2.25 is going to have the same
> bug you reported; there are still some loose ends with my series to
> make -m the default, and the 2.25 release is expected within a few
> days, so my change of default won't happen until 2.26.  (That series
> would have needed to be completed several weeks ago for it to go into
> 2.25).

Thanks for this piece of information and for the time/effort spent!

-- 
Best Regards,
Eugeniu
