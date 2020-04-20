Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE736C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9408220722
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acFf8V1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTWWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:22:25 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6F6C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:22:23 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p67so2492371ooa.11
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ga1ckiww7SBM2alvV/OFrHRtuEv4oHU2U3xaGvy9viA=;
        b=acFf8V1Yp0iHyeQ0f6I5eLUN7EUD5RDwvOdLWMMrj/tHbcmdQ6zZSZt0cdXkpmPYRj
         W2Nw3ttbFOZoktGbEKBDaZfEsxFxGP4xPmvulY0c6KipbrND6ddBVxEKr2Fhuo3OTuTX
         MdM9loqxHs783q8qN07eA2A95FEX45GYZwJBA3KGaNpQ8uutMTamr4i/k7PZGgIcaUrX
         jwpr0Qz3NGnMEJXiW7Zb/ETSJGF44xNEC2NhpbnZ4t3+DzLd6K3y0hm8HIjx5hCht/Al
         OsgGYnJ4cVfj9pmeLgQ9MiR//z5VW8FNm1W9HK2COgrN0KovOEZmlDBzcfUwVZjV9Xqk
         uQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ga1ckiww7SBM2alvV/OFrHRtuEv4oHU2U3xaGvy9viA=;
        b=Sam5aKtHMqkb4eI7iDzLjb8cWeI6llLdeBpowhMtkLTAC0u5O25F2OQc6nL9VrabOu
         iNPbEtg1DTfjGAE22XFjpQaXSD+xdcXxXLdVMtI3M/M0fMazG4scCniXnYflxJsdlzWh
         xRng9H/kz0dRg3IqkikJo+Wt7Bz2JihT196ScrTVe1ayigFMnUPaL+7BYGORn3y77Z7e
         TMriB+0wUvcNXoPnWvHNpoPXrgb1urRPJHN/ITlcYRNM3Rvhv9uRKIN58vzDtXzAg640
         DHyrN1vvJKHdZQmuR++DN4l8MjK+LimY2YpOzGSeZYoI0ewhsA5HamTgrk2D2kckEwVT
         ZfTQ==
X-Gm-Message-State: AGi0PubaMbPo5vp8KHwbM6pv+ycc5S2g0X55gkI71ItFbR5ZKepsa4jj
        bHtW18KkdxTEnLF/F5Uhb46Gfb3oG8qA2QDSDBUKYbFq
X-Google-Smtp-Source: APiQypLU13uefUuUwvDMD2yBhix4StngYdlicdcjRmXygFt1zi4ySUocUhroLnCLUoNXr2RgT+Pt1VHXFld6U8pFXYE=
X-Received: by 2002:a4a:850d:: with SMTP id k13mr14596134ooh.7.1587421342880;
 Mon, 20 Apr 2020 15:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoimeOB7-ZTbApMuvA=n6QxFtW_E80gy8Y60CU8EduZc6Q@mail.gmail.com>
In-Reply-To: <CAPMMpoimeOB7-ZTbApMuvA=n6QxFtW_E80gy8Y60CU8EduZc6Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Apr 2020 15:22:11 -0700
Message-ID: <CABPp-BF+UPXT_91tzA1FqNxyfN7opc74CX1ZEJNhXYB0pGJpiw@mail.gmail.com>
Subject: Re: Git and sparse-checkout on large monorepos - hiding irrelevant
 changes for a sparse-checkout specification?
To:     Tao Klerks <tao@klerks.biz>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 2:21 PM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi,
>
> I posted an "Is this possible?" question on stackoverflow
> (https://stackoverflow.com/q/61326025/74296) and was pointed here.
>
> I understand from recent updates that there is increasing built-in
> support for large files and large repos, between some of the older
> capabilities (sparse checkout in general and shallow clone), and the
> newer ones (partial-clone and git-sparse-checkout).
>
> I'm playing with a large repo, and finding some "rough edges" around
> large diffs (eg 200,000 files "added" in the "initial" commits of
> shallow clones).
>
> I was hoping these could be smoothed out when using sparse checkout
> (where each user would only see say 30,000 of those 200,000 files),
> but can't figure out a way to easily & consistently apply the
> .git/info/sparse-checkout specification to tools like git-diff and
> git-log (across many users with some semblance of consistency).
>
> Is this something that is or is expected to be supported at some point?

Yes, we would like to support this at some point.  See
https://lore.kernel.org/git/xmqq7dz938sc.fsf@gitster.c.googlers.com/
and a bunch of other emails from that thread.  You may need to set a
config setting, though (see e.g.
https://lore.kernel.org/git/CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com/
from that thread).

Also, there is no plan at all for when this will happen.  You'll note
those links are kind of recent.  These issues have also come up
before, but I'm too lazy to dig up the links to the other threads.

> While I'm asking, I have two less-important questions:
>
> 1) Are there any plans to support a filter along the lines of "keep
> blobs used for commits since date X handy"? I know I can do a shallow
> clone, then turn on filtering/promisors, and then unshallow, but then
> later fetches don't bring in binaries - a mode that provides this
> "full commit history but recent blobs only" might be nice? (I imagine
> that's probably non-trivial, because the filters are probably based on
> properties of the blobs themselves... but one can dream?)

Given the context before this in your email, could you clarify what
you are asking?  In particular, are you really asking for all blobs
since date X, or for blobs within your sparse cone (going back to
beginning of history), or blobs within your sparse cone since date X?

I personally don't think doing anything with shallow clones other than
avoiding breaking existing usecases has any value.  So, I'll focus on
partial clones.

I've been trying to win some mindshare for the second of those options
(having the ability to specify sparsity cones to clone/fetch and have
it respect those and only download blobs touching those paths, plus
all commits and maybe all trees), and perhaps the others could be
added on top.  I'm planning to help out with this, after my merge
work, but who knows when that finishes.

> 2) Is there a target date for when git-sparse-checkout will become
> non-experimental?

We're more feature based than date based.  I was one of the ones
asking that we put that loud this-is-experimental warning in the docs,
and in particular mentioning that other commands (diff, log, grep,
clone, fetch, etc.) could change in the presence of sparse-checkouts
precisely because I want to see some of the above things fixed and
even have some ideas for merge/rebase/cherry-pick in this area.
You're likely to see some commands start gaining support to work
better in a sparse-checkout (e.g. Matheus posted some patches to make
grep better respect those), and more commands slowly gain it over
time.  Once enough have it and we've worked out the known bugs with
sparse-checkouts (we have some significant patches in 'next' that 2.26
users haven't seen yet), then we'll discuss when it's time to remove
the experimental warning.

> Thanks for any help, my apologies if my questions are too forward.

Sorry that the answer amounts to "we don't have that yet", but the
things you are asking for are things we've been discussing and moving
towards.
