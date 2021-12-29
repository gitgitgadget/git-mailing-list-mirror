Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4CC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 22:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhL2WpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 17:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhL2WpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 17:45:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575AC061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 14:45:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so91262554edq.6
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qe0PxJD9Wa0PVk/OoWrOl8tpbgfVByj0kBcX/YGmfXE=;
        b=MMp4EWbJcLKf9XYYM0iuy9SIbHdm/4omIp31072PagFOhUvp6OfFWArk6hcpHEfDYY
         VY3p5s9Ermz8DfrEr5DZnlYK83KyrE9nSUDexQTQ4O50FjOgNBB/uZ7brYhmzCvTTf6B
         ir8xbH95pJltPfMNqBKuMI/Ko5Lae4o7Wf63Sl5hneUG1mb4/5jX8+c+TY7cnx1YzUTf
         0K8OM1f9nVAqZSMtE0XVmTiCnDPNxOqIc1exww0UPb2JHpPnCESJwotRTUDOWw1VYxaS
         2V491OkqIs2OI1StAJ/kV/16Xs4V1N7uWZMGO/Mxj6Xe2XrAyaXguiHgVrbIA7lXaNz+
         g+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qe0PxJD9Wa0PVk/OoWrOl8tpbgfVByj0kBcX/YGmfXE=;
        b=na+BjLxyVS0nJyqoHVOOYYKMxveVXcmXsyr2CJT3tk6lyZUuRqROR+zMoJ1UlNb0B3
         lCsyzGXDdjajZoCYjgRu3nK16/5BcgSjySHjEJeYocMrKGBqaz5XGP+pgfHfbqhy0K1s
         blFjHkjxx4T4kN6hFOVI3/2741FjVdGUupm1lK/E8oClA7mw/qfXGTfXZw+UKMaO4ngN
         I6vUqQCxYJSrswzRfQuTX2cHESBqjofU2vbzEy6zDL0CrCfhqGt+WLkAdNZ9695IsvWL
         4Y7zfi5t09JhmAn9BPaPirtZ0XNgxoL4iMqIvuYe2fnHMEw72gVQyxM6g1YhNq3/s3AV
         jWdQ==
X-Gm-Message-State: AOAM532JwFJeOx7nRYRNYYol/m6wsq/AhQd1pc0tgb281+VNLF1QkDUO
        iqAtVX/QI2MKaCcE3x9+JKL49uM+RRx/Nj0FSUk=
X-Google-Smtp-Source: ABdhPJwMzbwIwA5ZZ80yBmP6Yy2MoysJJ84ys+5spcCfKzxvFdIODRD5quGLr+X5cfHn6BOxlvFJN2C+C2WkSYMtuY0=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr22236955ejc.269.1640817915579;
 Wed, 29 Dec 2021 14:45:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <fcece09546cbdb5f1bcd0d0c5aaa3a54e9d3b852.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com>
 <e2ef25b5-9802-1dd9-b96c-ea85d2082b48@gmail.com> <CABPp-BE9umOTkjfnB0X+9nTZaBmeXd4z5DmiZ1Upzds=m1spPw@mail.gmail.com>
 <0aa32f4d-9101-16ff-58b8-29a8651a69f8@gmail.com>
In-Reply-To: <0aa32f4d-9101-16ff-58b8-29a8651a69f8@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Dec 2021 14:45:04 -0800
Message-ID: <CABPp-BFdVPRgFy8DLFEB13Trh5J4S+xma-U5FUnUvQLNMfNNjA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 1:39 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/29/2021 2:51 PM, Elijah Newren wrote:
> > On Wed, Dec 29, 2021 at 9:31 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 12/29/2021 1:37 AM, Eric Sunshine wrote:
> >>> On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >
> >>> The obvious way to work around this problem is to (again) special-case
> >>> `core.bare` and `core.worktree` to remove them when copying the
> >>> worktree-specific configuration. Whether or not that is the best
> >>> solution or even desirable is a different question. (I haven't thought
> >>> it through enough to have an opinion.)
> >>
> >> It makes sense to special case these two settings since we want to
> >> allow creating a working worktree from a bare repo, even if it has
> >> worktree config stating that it is bare.
> >
> > Agreed.
> >
> >> As far as the implementation goes, we could do the copy and then
> >> unset those two values in the new file. That's an easy enough change.
> >
> >> I'll wait for more feedback on the overall ideas (and names of things
> >> like the init-worktree-config subcommand).
> >
> > What value does the init-worktree-config subcommand provide; why
> > shouldn't we just get rid of it?
> >
> > I know Eric was strongly suggesting it, but he was thinking in terms
> > of always doing that full switchover step, or never doing it.  Both
> > extremes had the potential to cause user-visible bugs, and thus he
> > suggested providing a command to allow users to pick their poison.  I
> > provided a suggestion avoiding both extremes that doesn't have that
> > pick-your-poison approach, so I don't see why forcing users into this
> > extra step makes any sense.
> >
> > But perhaps I missed something.  Is there a usecase for users to
> > explicitly use this?
>
> I think the motivation is that worktree config is something that is
> harder to set up than to just run a 'git config' command, and we
> should guide users into a best practice for using it. The
> documentation becomes "run this command to enable it".

Okay, but that's an answer to a different question -- namely, "if
users want/need to explicitly set it up, why should we have a
command?"  Your answer here is a very good answer to that question,
but you've assumed the "if".  My question was on the "if": (Why) Do
users need or want to explicitly set it up?

Secondarily, if users want to set it up explicitly, is the work here
really sufficient to help guide them?  In particular, I discovered and
started using extensions.worktreeConfig without ever looking at the
relevant portions of git-worktree.txt (the references in
git-config.txt never mentioned them).  I also pushed this usage to
others, including even to you with `git-sparse-checkout`, and no
reviewer on this list ever caught it or informed me of the `proper`
additional guidelines found in git-worktree.txt until this thread
started.  So, relying on folks to read git-worktree.txt for this
config item feels a bit weak to me.  Granted, your new command will be
much more likely to be read since it appears near the top of
git-worktree.txt, but I just don't think that's enough.  The
references to extensions.worktreeConfig in git-config.txt should
reference any special command or extended steps if we expect users to
manually configure it (whether via explicit new subcommand or via also
playing with other config settings).


Anyway, if we think users want to set it up explicitly, and we address
the discoverability problem above, then I'd vote for
"independent-config" or "private-config" (or _maybe_
"migrate-config").  Because:
  * no sense repeating the word `worktree` in `git worktree
init-worktree-config`.  It's redundant.
  * The words "independent" or "private" suggest what it does and why
users might want to use the new subcommand.
  * It's not an "init":
    * The documentation makes no attempt to impose a temporal order of
using this command before `git worktree add`.  (Would we even want
to?)
    * As per my recommendation elsewhere, this step just isn't needed
for the vast majority of users (i.e. those with non-bare clones who
leave core.worktree alone).
    * ...and it's also not needed for other (core.bare=true or
core.worktree set) users since `git worktree add` will automatically
run this config migration for them

And, actually, with the name "independent-config" or "private-config",
I might be answering my own question.  It's a name that speaks to why
users might want it, so my objection to the new command is rapidly
diminishing.

> It also provides a place to update the steps if we were to change
> something in the future around worktree config, but I'm guessing
> the ship has sailed and backwards compatibility will keep us from
> introducing a new setting that would need to be added here.

Yeah, the best time to force a config change is probably when we
introduce a new command with it.  If we had forced
core.repositoryFormatVersion=1 in order to read extensions.* at the
time that extensions.* was introduced, that would have been fine (When
we tried it later, we had to revert it for backward compatibility
reasons.).  If we had forced extensions.worktreeConfig=true when
introducing git-worktree, that would have been fine.  We did force
extensions.worktreeConfig=true when we introduced git-sparse-checkout,
which was good, though we localized it to sparse-checkout and avoided
adding it to worktree usage in general at that point.

The other good time to force a config change is when we have cases
where behavior is already broken anyway.  For example, the
(core.bare=true or core.worktree is set) case that started this
thread.  But in such cases, we have to localize the forced-config
change to the cases that are "broken anyway" unless we can verify it
won't break other cases.

I'm not sure that this new subcommand will ever fall into either of
these categories, so I also agree that we'll be unlikely to ever
change it.
