Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F6C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE65561260
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 09:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhKKJGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 04:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhKKJGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 04:06:00 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4A1C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 01:03:11 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u60so13367162ybi.9
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 01:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eOZaS74GHLpbylS/UOIghUSNLMcuH0rqwlyN5fOFq1I=;
        b=XaGFyuORNTBIUgqP6W0yfKDF5svk43zzV5K5N4dU8jwJ+Tgk3EdXYtfMd+DIt/OtXW
         Kv6Anr8J2aEzkNmDNkjC9MGTimAYXgZTj6j53V5l9ci4ahyJNuwKSxXw3EKEJnK7H+sM
         HY5WP0NEIvDAxEyHZY97gj85CQUar6p2ZuDElgW8KH3Lhpy+cOEn70mGTdjngArYhz+d
         a0B6CcBbMkoyblxY5SZ9elBEJN1XSNJCgDYd4UN0rFF8s18pUN0qSG7MpW/EUw7RG/ET
         JX4cttCrXZUBrklTCDQN19GIyS82ZZdE5WfYGuwdo381aOpZPBOfI/AMPlAqaHx+yVAR
         eR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eOZaS74GHLpbylS/UOIghUSNLMcuH0rqwlyN5fOFq1I=;
        b=BebmxBx2Nu5v/b0pCGanjfd/PM4a9g7puPf1frRZ8gd5nazVg1mYKUxvOo1ftC/Cn2
         bAWnL90/C1E836JYLPql5xavTvU0I9hucm7GrO1ZottGKKalaakQ7rYtWug4EA156+vy
         tqb0/hJ/FJXCDBLWXCL2AFzDY2wBZaboyTLnJlagafrp1i3GhJhZ5M+VmvbtUBrowKrZ
         g4A5/P94Dx5aGA9DP+cDjEJsy/16ZC9KgUhu/dljriFeBhxYpUAZWJRz2RqZ/VNj2HaS
         z2jfrERH5qAApe0MNfCcJLMZGh9XLlo3sNPbG7eXDqNtdImadBbbQamlXIcbrvmdQ6On
         Dg+A==
X-Gm-Message-State: AOAM532zNJZhG7LyV3QewjemKofrEfB+12417OfyiamTzWmZUDVb3nES
        QbuY1i8e3pbhENBsOI/S899xaiq+kyuyOFu8RaA9ks0LtVs=
X-Google-Smtp-Source: ABdhPJxzl8CxidfM/dDE8Uxn0XTtGPu/etHfRlria/bgD7CL6OiX6QUflCBZMWlsPHckeNnrjPQUR5YGIXpKgnnHB9Y=
X-Received: by 2002:a25:cd88:: with SMTP id d130mr5867211ybf.241.1636621390909;
 Thu, 11 Nov 2021 01:03:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
 <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com> <7214fa73fdd13418744903f6c769fdb77c9512ce.1609272328.git.gitgitgadget@gmail.com>
 <CAPNYHkm5Qp8HQGU5_6DXc7xpCrdGgEin0WYAxbRNOkKW0j2ERQ@mail.gmail.com> <CABPp-BFqZj4qYXbPGLyX=4RM4OdLNL=VbYyhbLakU-RrvU+wfw@mail.gmail.com>
In-Reply-To: <CABPp-BFqZj4qYXbPGLyX=4RM4OdLNL=VbYyhbLakU-RrvU+wfw@mail.gmail.com>
From:   =?UTF-8?B?QmHFn2FyIFXEn3Vy?= <basarugur@gmail.com>
Date:   Thu, 11 Nov 2021 10:02:34 +0100
Message-ID: <CAPNYHkn5aHW1e_G5BKcaHWnrTSR+=VKOnKPdDPLJ5bH9DedKTA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] diffcore-rename: simplify limit check
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 9:06 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Nov 9, 2021 at 1:15 PM Ba=C5=9Far U=C4=9Fur <basarugur@gmail.com>=
 wrote:
> >
> > Hi all,
> >
> > First post on Git mailing list, to provide a comment on a patch. Hope
> > this works.
> >
> > In cases where the `rename_limit` is already greater than 65535, the
> > `st_mult(rename_limit, rename_limit)` multiplication overflows and
> > process halts.
>
> Out of curiosity, what system are you on?  And how many renames do you
> actually have?

I am on a 64-bit Windows 10; but following up on your question, it
became obvious that these limits have something to do with 'which git
executable' I was dealing with. This problem surfaced when I was
working on Visual Studio 2019, and was trying to rename not more than
10 files. My config had 999999 as the renameLimit, and VS2019 showed
the 'fatal error' in its git output. However, git bash was all fine
with listing the renamed files. And the difference between these
scenarios turned out to be, yes, different git executables. VS2019 has
its own copy of git which is 32-bit, and it hits this 999999 * 999999
overflow; whereas *my* copy of git used in bash is 64-bit which does
not have that overflow problem.

>
> We used to clamp to 32767, but one specific repository needed values
> larger than that, in the range of ~50000.  However, due to a number of
> rename detection related optimizations added since then, the git of
> today can handle that same particular repository and support full
> rename detection with a rename limit under 1000 for merge/cherry-pick
> (sorry, forgot the exact numbers), and probably less than 10000 for
> diff (just guestimating; I don't want to go and check).
>
> Anyway, all that aside, I don't see any such overflow for rename_limit
> being 2**16; we can push it much farther:
>
>     size_t a =3D 4294967295;   /*  2**32 -1  */
>     size_t b =3D a;
>     size_t c =3D st_mult(a, b);
>     printf("%"PRIuMAX" =3D %"PRIuMAX" * %"PRIuMAX"\n", c, a, b);
>
> Output:
>
>     18446744065119617025 =3D 4294967295 * 4294967295
>
> Adding one to the value of a results in:
>
>     fatal: size_t overflow: 4294967296 * 4294967296
>
> > But I don't think an 'overflow error' is very helpful
> > for the users in understanding what is wrong with their configuration;
> > i.e. `diff.renameLimit` documentation says nothing about a 'maximum
> > allowed value'. I would either clamp it to a reasonable range, or
> > inform the users about the limits, or maybe both.
>
> That sounds reasonable, but I'm not sure it's worth the effort in
> practice.  2**32 - 1 is so impractically large for a rename_limit that
> I don't see why anyone would need a value even remotely close to that
> level (and I wouldn't at all be surprised if other things in git
> scaling broke before we even got to that point).
>
> Perhaps you're dealing with a 32-bit system?  Even then, the
> repository that hit this was about 6.5GB packed .git history; and you
> might need to be a lot larger than that given the optimization since
> then in order to hit this.  Can 32-bit systems even handle that size
> of repository without dying in several other ways?

Good point, but the system aside, 2**16 - 1 =3D 65535 would remain to be
the limit for the 32-bit git executables, wherever they are used.
Therefore, maybe there is a point to curb it, or mention this
somewhere, as I have said before.

--=20
Basar
