Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A624AC433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 19:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831AE208C3
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 19:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH9g7F/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgFRTUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFRTUB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 15:20:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF86C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 12:20:01 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v13so5461256otp.4
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rp5g6OEOPRYFA0O3Rd4Lb8wz+7RaBVfGz8JM18jAL80=;
        b=ZH9g7F/+tv9oNsh+x1UPvbkP7WpQXLe0jIZkv4tpxF7rmJUaOsQGjaLxBo3knxau8n
         cGultxGkDrIeMXEiImY0JYzcreQUWo5wx75OFy8tl5WBZh6iB2h8JUCYHE68MqICHA6F
         YS4WlvlPo3oZ/gHAy2BQeuP0qX38bdN87Ku4EAg1C1s5GxvofHkFhxlKdVUjRSN42Va+
         1tsEYuO9pnCFgzPoo4Rp1VpwgKkXHuvICAB16qxny5ybCWKsEbbiFNb7F78aGxU4Uyri
         HYj6srBNLjq0JyqmBlsObQen8B6gy3uHrAZX95gSxj72dJ1wrBYisV1YiQYIGbZSdAtj
         4HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rp5g6OEOPRYFA0O3Rd4Lb8wz+7RaBVfGz8JM18jAL80=;
        b=FniKkaQFGiWRj2BlzlSlejhGOVn72kdUOcnie7LrmrqX2hDmo4n7xPX95/aVmGAekc
         qDyw1ilwIFcshJOJhj9HS5w70J/HrChr4bfGykLGdrwtOdaWx+CZcDg7996Ob6fhLpf2
         9o+VuhMjxcjFNdRKXaaJu2GiWRGFBuQqObBeTyHSPMtUTStO2I6az0AVi6hW8NPcDdOk
         fH3cyNyMoNDNxY/67iI08SkVUA1wxLY8gKl2WtxQI4GhzpNfEdo61pzhm8pdeUJB9Lo1
         9k0CZRJE4cuZwuQ7VlB6m3s5LLJf5jU3//Vfuvs5D0Fxo9CsojQy2HJ4Lo2eKWHOfq/q
         BFNw==
X-Gm-Message-State: AOAM531n3paHy9msc6wj13tM96pnWhNmCtbUwlVntqcjt9r+vh670C6C
        ZgjD20V+mv4NCDdaXqEVbRlrL5EspNIP/FvAJ1UarxOx
X-Google-Smtp-Source: ABdhPJz3gMO/TdMZ3FE6s30LYv3leHAPJjtRmgNvpRKW0ki1/Yh6+PVcyd4ctgveE/XBeCFWq/GtVU4ZWuPi/oMeq6A=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr234411oti.162.1592508000929;
 Thu, 18 Jun 2020 12:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com>
 <CAHd-oW5gTJO=6pYXvg3v=JfjffcajPyMpsUOoqXnozwYrg3WwQ@mail.gmail.com>
 <CABPp-BHtwifTHXxoxTKvz0mx45e2N-4SBTTfoRePcmMFAn1O2g@mail.gmail.com> <CAHd-oW7tT7GhHz7mCH9Y66B=kriBKv8ZyrTXT-VTJgcXGa1Jzw@mail.gmail.com>
In-Reply-To: <CAHd-oW7tT7GhHz7mCH9Y66B=kriBKv8ZyrTXT-VTJgcXGa1Jzw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Jun 2020 12:19:49 -0700
Message-ID: <CABPp-BHV6iKH4PS6Gqfhe6piBdgmZ9D+cgXvSJ+dNcw-UHD-+w@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 18, 2020 at 7:34 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Wed, Jun 17, 2020 at 9:24 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > If someone were
> > to try do change their sparsity patterns or even just run a "git
> > sparse-checkout reapply" when they had the above issues, they'd see
> > something like:
> >
> >     $ git sparse-checkout reapply
> >     warning: The following paths are unmerged and were left despite
> > sparse patterns:
> >             filename_with_conflicts
> >
> >     After fixing the above paths, you may want to run `git
> > sparse-checkout reapply`.
> >
> > This basically suggests that we consider uncommitted and unmerged
> > files to be "unclean" in some way (sparse-checkout wants to set the
> > SKIP_WORKTREE bit on all files that do not match the sparsity
> > specification, so "clean" means sparse-checkout is able to do so).  So
> > I could amend my earlier comparison and say that IF the user has a
> > clean directory, then "git grep --recurse-submodules $REVISION
> > $PATTERN" should be equivalent to "git checkout $REVISION && git grep
> > --recurse-submodules $PATTERN".  I could also say that given the big
> > warnings we give users when we can't set the SKIP_WORKTREE bit, that
> > we expect it to be a transient state and thus that we expect them to
> > more likely than not clear it out by the time they do switch branches.
> > That would lead us to the follow-up rule that if the user does not
> > have a clean directory then "git grep --recurse-submodules $REVISION
> > $PATTERN" should be equivalent to what you would get if the unclean
> > entries were ignored (expecting them to be cleaned before the any `git
> > checkout` could be run) and you then otherwise ran "git checkout
> > $REVISION && git grep --recurse-submodules $PATTERN".
>
> Makes sense, thanks! We haven't mentioned "git grep --cached" yet, but
> it would behave in the same way of the worktree grep, in this case.
> (I.e. searching the submodules, as their SKIP_WORTREE bit was not
> set.) So I guess it should be fine, as well.

:-)

> > That suggests that grep's implementation we agreed on earlier is still
> > correct (when given a $REVISION ignore submodulees that do not match
> > the sparsity patterns), but that unpack-trees/sparse-checkout still
> > need an update:
> >
> > When we notice an initialized submodule that does not match the
> > sparsity patterns, we should print a warning just like we do for
> > unmerged and dirty entries.
>
> Yeah, seems like a good approach. Thanks for the explanations. Some of
> the test cases in mt/grep-sparse-checkout will have to be adjusted
> with this change. Should I reroll the series based on the patch you
> will send or do you prefer to adjust them in your patch (and make it
> dependent on mt/grep-sparse-checkout)?

Ah, good catch.  Your series came first, is longer, and is reviewed
other than the submodule/config stuff that needs someone more familiar
with that area than me.  Since my patch needs more work anyway, how
about I rebase my patch on top of your work, and make sure to ping you
as a reviewer to make sure I don't mess anything up?

Thanks,
Elijah
