Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F3CC05027
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAUBey (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAUBew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:34:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118096A331
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:34:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j17so10543944lfr.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FxGAu8a8+6nwKe+SC+UNYdvJfQ/HiT9nAGwH5VEno6w=;
        b=gMjIDw4fM7UzRg7wBFROciI+fpH81XG8XRAtyGsYslNivzrHXyF3tt6q4fZ58fcei4
         Kc4rWrdpoUzmRsU5dVn0veRFArEPFHf1zriwBb3Dw+bbdFHmmj/cXCocCiMaamPqZB1/
         PLHWpbZhYFZL1hNs7VFv/9MxwRlAZlFYA0MrzZk/rnNK28c3Wk9V9E5NOWv+PrUYjTc+
         iqZaT2i+7ZnEs8NH7Ax/6A643BvgOZpGsHssFsXNN835Lew4CAHd9Jxd3zIw4XU+OSA1
         IzYL/0ei+tLsKb7IMKRNO5APdHrESR+yRHbDo72wXs1wlMr9YtcLqbtbXJFSFBJupBoQ
         OyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxGAu8a8+6nwKe+SC+UNYdvJfQ/HiT9nAGwH5VEno6w=;
        b=yOKeVuHC+hsv2MvAKpyOW+wnLe5KDex0ugnYX3lqJ6B6a4zFlmGWsD9OsXtZiMak6N
         X3v8z+DptY11Wmoz+Rs9ZLzuA7OHbSopSF4x+T17+nluA0hNMd5WuWQCXdU1llzSJYZa
         v/B4m1hczkY51KYIz2zMJN2xwOyhyMNrdKFyAnywM972icZn3bzH2hXuaj+fimiwZfW9
         3YkG2Qxdj05n25TPtlB3jzF0RrvwuRrA9wQY6QQxS5UJrEaYXV6tmpWjfYg9bi2bjKDS
         72jqUdwko4HEmQjtPBKAcZEsbcUHR+kcb+oJEytJ7pnPLASespRkg6tgI6sKkruTLj+w
         yGbA==
X-Gm-Message-State: AFqh2kq4K3SdpOSw56hCYqsmFJ4MiZKDE+dhysCxQXDxx+liW03SjR4C
        f8aimMaSf0RAGyBimLglKsL7NGihTCJ8XqE2c/U=
X-Google-Smtp-Source: AMrXdXvOTJixlj8Jqx/4GQuKBBWNi2WtX4B3y2KsJkoqYMt4ysJQtkAoghC4vJCQ+P+Jo8Eq0cseqv3GBBSe63zNavw=
X-Received: by 2002:a05:6512:3b9c:b0:4b5:9233:6e9b with SMTP id
 g28-20020a0565123b9c00b004b592336e9bmr1658389lfv.394.1674264888910; Fri, 20
 Jan 2023 17:34:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com> <2e44d0b7e571cfac2a25d00f3fe3d143c895793b.1674190573.git.gitgitgadget@gmail.com>
 <bb75c8e1-05d3-1359-e06a-ee013ae677da@dunelm.org.uk>
In-Reply-To: <bb75c8e1-05d3-1359-e06a-ee013ae677da@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jan 2023 17:34:36 -0800
Message-ID: <CABPp-BG8JmXApAsTVxpi2_8DpWi6ix-PhuOG6w=NwR0f=eA7xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: mark --update-refs as requiring the merge backend
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 8:46 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
> Thanks for working on this
>
> On 20/01/2023 04:56, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > --update-refs is built in terms of the sequencer, which requires the
> > merge backend.  It was already marked as incompatible with the apply
> > backend in the git-rebase manual, but the code didn't check for this
> > incompatibility and warn the user.  Check and warn now.
>
> Strictly speaking we die rather than warn but I don't think that
> warrants a re-roll.

Oh, good catch.  I'm re-rolling anyway, so I might as well fix this.

> I just had a quick look to see how easy it would be
> to add the advice Stolee's patch had if the user has set
> rebase.updaterefs but does not pass "--no-update-refs" when using the
> apply backend but it looks a bit fiddly unfortunately as we could die in
> imply_merge() or later on.

Yeah, and it gets even more finicky than that.  If the user specifies
_any_ merge-specific options on the command line together with an
apply-specific option, then there's no point bringing up
rebase.updaterefs (or rebase.autosquash).  We only want to bring up
those config options if they are the only reasons for getting a
backends-are-incompatible error message.

> Thinking more generally, imply_merge() does a good job of telling the
> user which option is incompatible with "--apply" but if the user passes
> a merge option with "--whitespace=fix" and omits "--apply" then we just
> print a generic message saying "apply options and merge options cannot
> be used together" which isn't terribly helpful to the user (doubly so
> when the merge option come from a config setting).

That's not specific to --whitespace=fix (it also happens with -C, and
in the past happened with other options that used to only work with
the apply backend).  In particular, it's whenever both backends are
implied -- in those cases, we don't try to keep track of which options
implied it and thus only provide a very generic error message.

> I've also noticed that "--autosquash" is ignored if we end up using the
> apply backend. That's a separate issue but shares the "this may have
> come from a config setting rather than a command line argument" problem.

Yeah, Stolee also pointed this one out...and --autosquash was missing
the same incompatible-with-apply-options warnings too.

> All in all I'm not sure if it is friendlier to die when the user has
> rebsase.updaterefs set and they try to rebase with "--whitespace=fix" or
> if it is better just to ignore the config in that case. If we can find a
> way to print some help when we die in that case it would be nicer for
> the user.

I think ignoring it would be worse, as I argued over at [1].  But
another thing to keep in mind is that we can eventually make the
question obsolete by deprecating and eventually removing the apply
backend, as suggested by Junio[2].  That would allow us to remove all
the incompatibility checking and simplify the manual.


[1] https://lore.kernel.org/git/CABPp-BHDhpSVpuaubTP=smWaf7FBmpzB-_Frh0Dn5oN+vx0xzw@mail.gmail.com/
[2] See "longer term goal" of
https://lore.kernel.org/git/xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com/
