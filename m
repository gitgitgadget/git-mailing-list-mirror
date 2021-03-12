Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D7FC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 05:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E343664F94
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 05:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhCLFBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 00:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCLFAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 00:00:46 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522BC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 21:00:46 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 133so24111003ybd.5
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 21:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmWjAWua/QU78XMoPAuufzJWxVibbN2nsjzwiAcUS4Q=;
        b=p8nWa+qOxWPPGBzY5GWz8qLZG07DIZw98NJ1LAgAW6GfrduKBol0Nit3fzaqtTjVr8
         DvuyJxZYJtObCO3MhBrhmU9CS3VpNG9t6B2EEjJRxJr53Ta5s2ZtgmLRrO8rWMHhgMNR
         K5wqMFQ2Vzn+Ls0ZwenTrkDC+4G7d1hEYFXgH9Ra3UgHDypo2bSxt4na676hL9s+TMwD
         AU3UiiUHZHOUgOZTCB2btHhWnCXiYavN+rDl8szv4crzZKnhRptjyQQND03ewZFXW7fY
         mhGG4ZmGxJgDb7wmMOymqIH3RwBFLl1dZRVeHm9iHR+tcWpRV1wEkmPyU4TIKp3cEgYC
         SnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmWjAWua/QU78XMoPAuufzJWxVibbN2nsjzwiAcUS4Q=;
        b=bCzV+kApjRIRXfo0n1IlgtOH6lGimX1Q0vY9mzaRQIeimV1sokrZYcXDYqXoeNlwWN
         t2VEfGNha7ea9QPpLtXfTP05ETNpWJ3mspXGKVkf++ETzgVpYJ4/NsBS5LewUvAbrgMi
         x1XXPTVYXIikNOzRLlFTTjMA7VX9eGsAqJXim0vNh1yAMrIDPCGYc42Ke4mwHI4X1lMK
         /eOvxbsxuAWI7AcoJ83WMszlHifRjNrlcDT0RYin3y8n3hAOs4oAtJOzCVcL3LpQW4SK
         7GK71t9tS0H1LsiaVK8xf72EYoKLOrR9/TdF2rGsu7nH2PFPAcGquzrLMXa/H/0By56L
         y/pA==
X-Gm-Message-State: AOAM533Z137YMpIX3rLeBYvbcbflzH3EcCJetqrPsSKqrCD4GTEtzASF
        0+eQSjt3J69VnYOJ6sgNGshqFb4MlEQcZkewEZUbrS774yd+jg==
X-Google-Smtp-Source: ABdhPJxE+lcxQi2ytpafW2jgqrTZEWPBwizF66y7OzkN2yoj4Y00pOPV18pWEw5jtcAure4dV67f4ObpeOkSKYAmelE=
X-Received: by 2002:a25:8087:: with SMTP id n7mr16681486ybk.367.1615525245577;
 Thu, 11 Mar 2021 21:00:45 -0800 (PST)
MIME-Version: 1.0
References: <875z1xwznd.fsf@gnu.org> <YEpusE7ZIE5RgOws@coredump.intra.peff.net>
 <87a6r9o1yo.fsf@gnu.org>
In-Reply-To: <87a6r9o1yo.fsf@gnu.org>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 11 Mar 2021 21:00:34 -0800
Message-ID: <CABURp0pFdHAx_+-e+O35Qxtbe3_+cZy9SZcOSeR2R7v_neRwKg@mail.gmail.com>
Subject: Re: [Bug] Stashing during merge loses MERGING state
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:45 PM Tassilo Horn <tsdh@gnu.org> wrote:
> >> Or that popping the stash again would also restore the MERGING state.
> >
> > This would make more sense: the stash records that part of the state,
> > and then we make it available again later when the stash is applied.
> > However, that feature doesn't exist yet.
>
> Too bad.

Consider also what happens when `git stash apply` results in a merge
conflict because of differences between your current index and the one
you had when you originally saved the stash.  This results in the
usual merge conflict markers that then need to be cleaned up.

Could we sanely deal with this in a world where we also tried to
restore .git/MERGE_HEAD when the stash was applied. Something like
`git stash apply --continue`, possibly after resolving the stash
conflicts?  But what if we stashed the merge conflict that resulted
from the stash apply?  I guess it would still work, but the stash
history would be, um, interesting.

I wonder if a fix could be as simple as recording the MERGE_HEAD as
the third parent commit of the stash ref. I think that would provide
all the information needed to put things back, except possibly for
things like the rerere state, which is also set up during a conflict,
and other incidentals like .git/MERGE_MSG.  (And it feels like it
might break compatibility with older versions that don't expect a
third parent.)

I would be a bit concerned about the possibility of silently creating
an "evil merge".  Suppose you stash this conflict on some branch and
then pop it onto a different one.  I expect we would then be prepared
to store all those changes from a different branch including existing
resolved merge conflicts into the new one.  That could be surprising
and subtle.

But maybe I'm overthinking it.  Wouldn't the stash apply result in
merge conflicts that would catch out all the troubling parts?

I think being able to stash during a merge conflict could be very
useful.  I do sometimes need to get back to a working state
momentarily and a merge conflict represents a long pole to doing so.
Similarly, it could be useful to stash a conflicted `git rebase` so I
could return to it later and pick up where I left off.  Now we really
would need to store some extra metadata, though, like the todo-list
and ORIG_HEAD.  And we would definitely need some extra command line
switch to tell stash (or rebase) that I want to include all the rebase
state and also "pause" the rebase by restoring to my starting point.

Thanks for raising the issue, Tassilo.  This has obviously given me
more ideas for things I forgot were missing.

> > I can't offhand think of a reason it couldn't be implemented. It's
> > possible that it would mess with somebody else's workflow (e.g., they
> > think it's useful to stash some changes independent of the merging
> > state, and then apply it later, perhaps while replaying the same or a
> > similar merge). So it might need to be tied to a command-line option
> > or similar.
>
> Everything breakes someones workflow [1], so an option would be fine.
>
> However, I'd suggest to protect users shooting in their foot with a
> warning and confirmation query for the time being.  I consider myself a
> quite experienced git user but this stash trouble today came totally
> unexpected.  And I've asked on #git@irc.freenode.net and got no answer
> which is totally uncommon.  So I guess that this stash during merge
> thing is pretty much a gray area.

I don't think we could easily add the warning when the stash is
applied since we have forgotten the merge existed in the first place.
So we would have to do it during stash save.

"Warning: You are stashing during a merge conflict and your merge
state will not be restored by stash apply."

Seems reasonable.

Phil
