Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978BBC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3417E206F1
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5p/7uFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgKBUTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBUTH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:19:07 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377BC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:19:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v5so10634856wmh.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j60D2lFv8Vkhx23z+oqdeXvFpFvi52xk+2qXub+UUfw=;
        b=Z5p/7uFMowwgSwcD/k+U+Iaiaf1P4Zhk7C/jQLTlmakvB6TuzbPuVzCIsk0k4K5tyx
         G75yhi1v7obUQXHNtZQGFb3LpX7dXmDWZebzV+n5XEaDvC+Ly6qNDz3YsZ5wxXi+g3of
         lxL4DuMydp3T2DUNwohLEx5dqPiIQDPWN8tUM0LN/ReeroCWb6dOBjkOuPkp2wZFBbi0
         2vJHeoGnW/TAuW7H1l5hQQ4ODkza1SGbloebZJrLTJCbpYacn5lpbtV1DoBHkfcoWcXs
         RbapfeE24PgnzMrlKUdZgzDiDOoRFGOACYl0OY4y6VLy4Er7ATA1YIaiPM8cVcdyKGhW
         BXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j60D2lFv8Vkhx23z+oqdeXvFpFvi52xk+2qXub+UUfw=;
        b=cyX09rreM2WViPR+0B1goLeHnb0ioGBZGMjiczml5lw/iebdV1PEQ33UX89CH5aozw
         0ffvsHPT2HLOwO2tv+Gk+wBdWFLy2W5nmYMxtd/Zv0TC4AjGHhEvOPrb9QY9JecdTtPQ
         sRoj98XWyOdeWd8YuI2bWaui4g4qXpmnYIzCm1RTEsa2G690baHhA+PeBQKrWInuUEUE
         2pzVGEGpX/YIXwmeKw8XTQgUv+uw3R2ChZftqfMWibAu5YfgMLUqHwE/XMBgcnplH52i
         gkz2saK1qJXZk0IZAAC8xpH+WuceoyEP3f0iW3IAi4ZRhifwMzX1qfKGTcB9qJTVjnzb
         6ziA==
X-Gm-Message-State: AOAM532iDDVQ+4gisfpuzbmZGaQeFSgiuwPvDg+y1w9KJiLYxHPSQWR2
        DQ2cZNVQtcTWmLoITYSu/K95cfjVAG5sk0sCSep6TBQs2b8gzg==
X-Google-Smtp-Source: ABdhPJyYm5FId5u69LWUL6jmv5AwqqKyptDA4N8GPgeMAWMfhv5b1xjKU0AJ1yVWccaFV0EnLDmOypiikXWkET7sBxU=
X-Received: by 2002:a1c:4054:: with SMTP id n81mr14410613wma.48.1604348345766;
 Mon, 02 Nov 2020 12:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com> <xmqq361x7xj5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq361x7xj5.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 2 Nov 2020 14:18:54 -0600
Message-ID: <CAMP44s2bgZbKde-UFL7+sR-7QgEv5Oiho2LTi3RG7S4BD0iuaw@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 11:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> On zsh the situation is different; zsh by default has a git completion
> >> (/usr/share/zsh/functions/Completion/Unix/_git), and some might argue
> >> it's more complete than git's zsh completion,
> >
> > How is that completion script developed, maintained and distributed?
> >
> > By "by default" I believe you mean that it gets installed when you
> > install zsh automatically.  Is the situation different on macOS land
> > (which I can believe, unfortunately)?
> > ...
>
> Web searching for "zsh git autocompletion" gave a few interesting insights.
>
>  - https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
>    was the first hit, which is about how to use what we ship in contrib/

It's weird that he didn't have completion. He probably hadn't enabled
completion (in general).

>  - https://stackoverflow.com/questions/24513873/ which was near the top
>    had these gems.

> The "knows out of the box" in https://stackoverflow.com/a/58517668
> is matches your "zsh by default has".

This is just the tip of the iceberg.

In the past people that wanted to have the Zsh default could do `brew
install git --without-completions`, but the Homebrew team decided to
remove that option, so now everyone gets the completions overridden by
installing Git.

https://github.com/Homebrew/homebrew-core/commit/f710a1395f44224e4bcc3518ee9c13a0dc850be1

> > so why would
> > distribution maintainers chose the one in 'contrib' (an unofficial
> > contributed script) over the official one? Indeed they don't, at least
> > on Arch Linux.
>
> You're right.  They would certainly not, and the situation is quite
> different from bash completion where we seem to be the authoritative
> implementation.
>
> This leads me in a totally different direction.
>
> We are making life worse for the zsh users by shipping our own
> version, aren't we?  If we didn't ship our own completion script for
> them, the user did not have to remove the one "which is considerably
> less complete/capable".

No. You are assuming the opinion of one user in Stack Overflow is a fact.

There's a reason people prefer to use Git's official completion, and
there's a reason I wrote the wrapper.

The Zsh default completion is *incredibly* slow. Just as a point of
comparison when I do `git checkout <tab>` on the Linux kernel git
repository, it takes *three* seconds to complete. With the Git
official completion it's instantaneous, just like in Bash.

This defeats the whole purpose of completion. If it takes less time
for me to type the thing than it takes the completion to complete it,
then the completion is useless. I explained this to the Zsh
developers[1], and they didn't care.

They prioritize completeness over usability.

I even wrote a blog post about the issue:

https://felipec.wordpress.com/2013/07/31/how-i-fixed-git-zsh-completion/

> Perhaps we are misleading users with our
> version that has an implicit "came from those who know Git the best
> in the world" label that gives it more authenticity than it
> deserves.

And perhaps not.

> A good zsh autocompletion would need to be written and
> reviewed by those who know zsh completion well.

No. Those people don't care if their completion is unusable.

Zsh users want a completion that is usable, and achieves the purpose
of a completion; to make the user more productive. Not a completion
Zsh developers feel proud about.

> They also need to
> know Git somewhat, but the expertise on the former would be a lot
> more important, I would think.

I disagree. To make the Git completion fast, efficient, and consistent
to how Git is supposed to be used, it's much more important to know
Git.

For example, if you do `git <tab>` in Git's Zsh completion, you get
only porcelain commands, if you do the same in Zsh's default
completion, you get "check-attr" in the list, which I doubt any Git
developer would consider something the user should see by default.

You can do `git check-<tab>` and the Git's Zsh completion I wrote will
still complete it, even though it's not visible initially.

So in that sense *my* code is superior; 1) It shows only the common
commands by default, 2) all commands can be completed anyway, and 3)
can be configured to show aliases too, and the order can be configured
too.

Why didn't the Zsh default completion do this? I don't know.

> But as you said in
> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
>
>     The answer is obvious: the set of zsh users and the set of git
>     developers don't overlap.
>
> this community is not equipped to give good reviews and improvement
> suggestions on zsh matters to your patches.  And I do not have a
> feeling that the situation would change soon.

Neither does any other community.

But in this community at least some people try.

> Do your recent 29-patch improvements not just fill the "gap" but
> surpass the one that comes by default with zsh?  I have this nagging
> feeling that the effort to make the autocompletion better for Git
> users who use zsh may be better made by you ("git blame" tells me that
> you seem to be the only one who's invested heavily in the script,
> unfortunately) joining forces with those who develop and maintain the
> autocompletion that comes by default with zsh.

This is not possible, as the Zsh maintainers don't care about usability.

Plus, the whole point of my wrapper is to leverage the Bash
completion, which is actively maintained. The Zsh developers would
*never* agree to use the Bash completion in any capacity.

The current situation is far from ideal, but I don't see any obvious
way to improve it.

[1] https://www.zsh.org/mla/workers/2011/msg00506.html

-- 
Felipe Contreras
