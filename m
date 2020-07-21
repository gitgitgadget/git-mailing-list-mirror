Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B59C433E3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C6521702
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUnGco71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGUAk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGUAk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:40:58 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B9C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:40:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so13714709oty.11
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8ydAsXiGPYPSyFRKnA1gzSBgWMN8xywvXDObqN+1NA=;
        b=cUnGco71u8bMvyK6pFHJR/ycMIOGYH7wEtoJW8PmkxO8ACs0jKg6tWblB+wargEeWj
         b7rAN4JABELdTDEKAK0JoesxdGzldOkasyWTx4QbCCCkOa7LgQy2kx9jK9hkMufX6eew
         DNsI+1Aocb/TlACYSv9bU3fTXq9M1+DDr2vtcoI8hYV7cwCdFdkcaQ51Q9bS0Q/cnkAz
         aLs9bBMTARQOYRoWtzLPbXhtcwb5+zKP2/2Te20ILiAWvXvPLHCYdZJEG37z65qwScFw
         xamTAU98YOm6AGjHs010nSjMjuk/ANi1b6A7oxwG0eCiIAarUbd75DyU6LMCLoHU9CI6
         L08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8ydAsXiGPYPSyFRKnA1gzSBgWMN8xywvXDObqN+1NA=;
        b=tIBi5gDbY8Fi/33++cYSN5T1m9muCqIeVN5n1gEdrJoiArfKrwr2VVE01+uBuEJ+5j
         u97vQNlbDPoTJV1/7Phb+Et0YZ/L06YeWpymgdniYSzbiluVsJjRIle0pGj4Iq0slUV3
         WmM0+G4BuASttCANyK6oRGUVrKi/dR30AfrNXhzY/5nl5FijIdu3EWuDsCbJuNLuk0mS
         rCkEew4wIyBv8tknwNP2MEWvv3CwbqbIo9bqI7ts3MlUGhsvGCqzozzdBbJj38R4aIy2
         Y7IPNdVgKYjqTzdyhWOPLNh1ZJ3ujxZwJTtryP+ZnU+ABT2M89117ep2hxH56nPWyVC+
         uSng==
X-Gm-Message-State: AOAM5310h1GSGY5ATjHidUadguUfAoqoo81r8vtjQmGxdc7TSz+Ri9R9
        5IYphFeuXWLks+L+uI/hat4U1meLCA3VhAsObSc=
X-Google-Smtp-Source: ABdhPJxHm7sNHYAuvru2BhefoCyV8hRTXRh0axJVMEsn+mqWO71Zb7e3kyQdlZqIeog0oq0hbv0tTBoiRWL6gbzjYTg=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr23136949ote.316.1595292057410;
 Mon, 20 Jul 2020 17:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.git.1595287052428.gitgitgadget@gmail.com> <xmqqpn8p91sy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn8p91sy.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Jul 2020 17:40:46 -0700
Message-ID: <CABPp-BGm4UuRsL0K5=rAxyXaQYTgWicmFKNcRRfJziQ7BmSP1g@mail.gmail.com>
Subject: Re: [PATCH] git-prompt: changes == to = for zsh's sake
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "David J. Malan" <malan@harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 20, 2020 at 4:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "David J. Malan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: "David J. Malan" <malan@harvard.edu>
> > Subject: Re: [PATCH] git-prompt: changes == to = for zsh's sake
>
> s/changes/change/
>
> > When using git-prompt.sh with Zsh, __git_ps1 currently errs
> > when inside a repo with:
> >
> > __git_ps1:96: = not found
>
> OK.
>
> > This commit changes `==` to `=` for both Bash and Zsh.
>
> We prefer to see "why" instead of "what", as the latter can easily
> be read from the patch text.
>
>     Avoid using non-portable "==" that is only understood by bash
>     and not zsh to "="; that way the prompt script becomes usable
>     with zsh again.
>
> or something like that.
>
> Elijah, I think this is a minor regression in this cycle, and the
> fix is obvious enough that it deserves to be in the upcoming
> release.  Agreed?

Yeah, it's a pretty obvious and very localized fix for a regression
from this cycle.  I'd say putting it in the upcoming release makes
sense.

> Thank you, David, for a fix.

+1.

> > Signed-off-by: David J. Malan <malan@harvard.edu>
> > ---
> >     Changes == to = for zsh's sake in git-prompt.sh
> >
> >     Upon installing git-prompt.sh
> >     [https://github.com/gitgitgadget/git/blob/master/contrib/completion/git-prompt.sh]
> >     on macOS Catalina, I noticed that
> >     https://github.com/gitgitgadget/git/commit/afda36dbf3b4f5a489ab44c00d5210c1fa894a40
> >     seems to have introduced an issue for Zsh whereby __git_ps1 errs with
> >
> >     __git_ps1:96: = not found
> >
> >     when inside a repo. Changing == to = would seem to address for both Bash
> >     and Zsh.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-679%2Fdmalan%2Fpatch-1-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-679/dmalan/patch-1-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/679
> >
> >  contrib/completion/git-prompt.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> > index e6cd5464e5..16260bab73 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -433,7 +433,7 @@ __git_ps1 ()
> >       local sparse=""
> >       if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
> >          [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
> > -        [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
> > +        [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
> >               sparse="|SPARSE"
> >       fi
> >
> > @@ -542,7 +542,7 @@ __git_ps1 ()
> >               fi
> >
> >               if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
> > -                [ "$(git config --bool core.sparseCheckout)" == "true" ]; then
> > +                [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
> >                       h="?"
> >               fi
> >
> >
> > base-commit: ae46588be0cd730430dded4491246dfb4eac5557
