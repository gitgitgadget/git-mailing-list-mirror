Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5630C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E946103C
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbhIXC3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243813AbhIXC3V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 22:29:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99814C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:27:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso11180287otb.11
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxDrJWDojWGAdIreGqiBqyUN3hdAMKssN2x+cpPmp9I=;
        b=lH7Qj39iXRuYTfwMwbRQG27uoq4ITfDt48O99Z8vNBqsOZyMCUO/wifXjI0cdgQAx+
         4NDOUHhLX08FnDucii5c1wH80oescPIQyjicxyx3gl9ypKLwtc3t2fzt0eKsng91n450
         8ss3HBvF3Io/nma/L7hOApwFYLDCNK3Wv4TWwoFveyattBf9wDMZCw2GwzvGCrpS/fc8
         UbKSnnSZrHlu9QfoU1sKh8CGuZLcEJthSTu2Cuc7/Z8/gmA5PUEPutIF6R9qUlqRoxB+
         i3MlquHeMJWxWGtvagSL6dtTlHwQ9pHy4LbDod4xQ/f065s3BTc6eWr1POvHclnBA0s8
         /YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxDrJWDojWGAdIreGqiBqyUN3hdAMKssN2x+cpPmp9I=;
        b=qLo1Z9pZ5H2/su0IWJLATQsOrnAWIQbspw/nFfWxYJKnqYWnlewfhAmZ48zKNl9H6v
         j/kBpaeXx63f3qqTfrlC44zZvzOHPpwpdBD6fATeCh2xfCsGJrhAalUzJmwO5E+/tU0b
         gsnCPoXa7+xs6ixQmF2OKhWbgNvw8rYm6BvbZsAg77Qh3A2eCgDmLNLFbuVZvS6HYoDF
         mu1iv6CHh+BdVDtQJ7+j3G8q79h0QnIHRC1HEK53gL2LPkh55/wL8JY0zg1QYBZncwRP
         wKl0jFaFybnbUXYGRhn7DdUXWXd6cn/n+iKqwuiSGMsBbM56H2D3eVHeyO333Yqo/bO3
         cRjQ==
X-Gm-Message-State: AOAM533x0DTmBjpZfSXQWbrLccFDVXSxVGjNDdveDCL4yFVGuOaf9MCg
        wpOJc6pF6sEiWsDNT2N/OOyLBqSUTtfbeMWopYc=
X-Google-Smtp-Source: ABdhPJz8aRL50/oV/+WTGEFE0Td3mIBdTV7D1OSsH9lSdLVvVSbTrTxVdk7JIT2ZWB18rwAhOcMyvhAU82yz2qHHEUs=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr1813478otj.276.1632450467466;
 Thu, 23 Sep 2021 19:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
 <acef3628-9542-d777-2534-577de9707e15@gmail.com> <CABPp-BGnWeFiJ11x8j1J+yjgVB9r858S47y40h8cFQYF4TR1HA@mail.gmail.com>
 <a3433f37-4a22-faa1-16a7-cbc01a24af6e@gmail.com>
In-Reply-To: <a3433f37-4a22-faa1-16a7-cbc01a24af6e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Sep 2021 19:27:35 -0700
Message-ID: <CABPp-BGBX=QR0FVML1iukOSUir5d_st1jbuMjqsb6aEJ96wHhw@mail.gmail.com>
Subject: Re: [PATCH 2/6] Split unpack_trees 'reset' flag into two for
 untracked handling
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 11:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 20/09/2021 17:05, Elijah Newren wrote:
> > On Mon, Sep 20, 2021 at 3:19 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> On 19/09/2021 00:15, Elijah Newren via GitGitGadget wrote:
> >>> From: Elijah Newren <newren@gmail.com>
> >>>
> >>> Traditionally, unpack_trees_options->reset was used to signal that it
> >>> was okay to delete any untracked files in the way.  This was used by
> >>> `git read-tree --reset`, but then started appearing in other places as
> >>> well.  However, many of the other uses should not be deleting untracked
> >>> files in the way.  Split this into two separate fields:
> >>>      reset_nuke_untracked
> >>>      reset_keep_untracked
> >>> and, since many code paths in unpack_trees need to be followed for both
> >>> of these flags, introduce a third one for convenience:
> >>>      reset_either
> >>> which is simply an or-ing of the other two.
> >>
> >> See [1] for an alternative approach that used an enum instead of adding
> >> mutually exclusive flags.
> >
> > Oh, interesting.  Any reason you didn't pursue that old series further?
>
> Mainly lack of time/distracted by other things. I was also not that
> confident about modifying the unpack_trees() code. Duy was very helpful
> but then moved on quite soon after I posted that series I think and
> there didn't seem to be much interest from others.
>
> >>> Modify existing callers so that
> >>>      read-tree --reset
> >>
> >> it would be nice if read-tree callers could choose whether they want to
> >> remove untracked files or not - that could always be added later. This
> >> patch changes the behavior of 'git read-tree -m -u' (and other commands)
> >> so that they will overwrite ignored files - I'm in favor of that change
> >> but it would be good to spell out the change in the commit message.
> >
> > Those commands made no distinction between untracked and ignored files
> > previously, and overwrote all of them.
>
> Are you sure, I thought 'read-tree -m -u' unlike 'read-tree --reset -u'
> refused to overwrite untracked and ignored files currently.

Doh, I was thinking of read-tree --reset -u rather than read-tree -m
-u, despite the fact that you explicitly called out (and I even quoted
you on) the latter.  You are right.

> >  This patch changes those
> > commands so that they stop overwriting untracked files, unless those
> > files are ignored.  So, there's no change in behavior for ignored
> > files, only for non-ignored untracked files.
> >
> > Your suggestion to point out the behavior relative to ignored files in
> > the commit message, though, is probably a good idea.  I should mention
> > that ignored files will continue to be removed by these commands.
> >
> >>>      reset --hard
> >>>      checkout --force
> >>
> >> I often use checkout --force to clear unwanted changes when I'm
> >> switching branches, I'd prefer it if it did not remove untracked files.
> >
> > I originally started down that path to see what it looked like, but
> > Junio weighed in and explicitly called out checkout --force as being a
> > command that should remove untracked files in the way.  See
> > https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/.  Seems you
> > also felt that way previously, at
> > https://lore.kernel.org/git/d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com/
> > -- any reason for your change of opinion?
>
> I've no recollection of writing that email! When I was writing today I
> thought that 'checkout -f' and 'switch --discard-changes' behaved the
> same way but it appears from that other message that they do not so
> maybe it is OK for 'checkout -f' to nuke everything if there is a safe
> alternative available in the form of 'switch --discard-changes'
>
> >>> continue using reset_nuke_untracked, but so that other callers,
> >>> including
> >>>      am
> >>>      checkout without --force
> >>>      stash  (though currently dead code; reset always had a value of 0)
> >>>      numerous callers from rebase/sequencer to reset_head()
> >>> will use the new reset_keep_untracked field.
> >>
> >> This is great. In the discussion around [1] there is a mention of 'git
> >> checkout <pathspec>' which also overwrites untracked files. It does not
> >> use unpack_trees() so is arguably outside the scope of what you're doing
> >> here but it might be worth mentioning.
> >
> > Oh, that's interesting.  Yeah, that's worth mentioning and perhaps digging into.
>
> It'd be fantastic to fix that if you have the time and inclination to
> dig into it.

I won't include it in this series, but I'll throw it on my (long) pile
of things to perhaps look at later.


Thanks for the suggestions and pointers in your reviews!
