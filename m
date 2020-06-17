Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D1C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C821556
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji6T8irv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgFQQsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgFQQse (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46834C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 09:48:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 97so2164613otg.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3XDQ4nif8avV9xwl5/gtPe+OiYhBJrQ8Mbtrenn75r8=;
        b=Ji6T8irvIhyvPizmNTwsAU6dY4lVmdh6z2/5TUFsnp81YK1Q3FofI6BfEbgooECJCP
         uC7XPLSw+ubjl63KX0FEyUhifYLY+roejemYXd00s2Q3jiLGb7QjpFbsJZlNZJDU89dt
         +N917cRVqoybLqll9MsJXegPnOM0UvvI9TT9Al1A2po1QBbz8snHJMLz8H04I5qcIT3V
         h9nEioxM4jVioAhbZfxdoLusvO07lDqnjYrAAW+ul4VUKJ1m2aBBj6OD3nYVDa76TXF0
         Ev7FTsobVUze1Dlse+3iMSSEnrmNc9Pb7rUMviiAkFM0jxR3CIxLamk6NeD7kcJQp3XQ
         P+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3XDQ4nif8avV9xwl5/gtPe+OiYhBJrQ8Mbtrenn75r8=;
        b=dfW3GAgv5a+MTB5HBtQdNnWLh2NcAIFM/GiWMZzHzL9YFe81wgc4x/jgK8tZI6YHYE
         yLb6I3+XNkotzSYBJpjPSwJL7V+SQnQv1jnNen0Z64+gf5DTsdkaJPyF/Gt+tWJBGcfS
         ySjHqoNnp0Y5JeA/0OyZxbFktg2sFqVq+Ayi/vda2tcny5udMa2FV3EaJYJRscoMRLLX
         CxaMf+ezIXh2eHnpQ5zmGUD76nEdGmPFsgWHZtgiPJ45+QZabLHYcJ/9iVLl25W7grqE
         aFp2fZP57JT5+KUS5tgSJenwlRP67zXm2n5yverQ5PDEleKrCErlKeGI80pmWvWNrypa
         Xt4A==
X-Gm-Message-State: AOAM532Xi9Z3tAA5+hvf1/dm++4ek58C0dp+3o9t0zHF+i4jKfcnVbT9
        9oRkBoyc/NGUuoPZWueEuHdR9Lbbiy+1yNdPjSs=
X-Google-Smtp-Source: ABdhPJwK8XWEPV4x1Pn0+NQ3HKnz4Fzeqn1lGLoONoA1DSCp8hBvrqpj0MVhRpbV2Efw0Mp/uT7dzM04pXNgTnoRhZo=
X-Received: by 2002:a9d:7606:: with SMTP id k6mr7915023otl.316.1592412513422;
 Wed, 17 Jun 2020 09:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3xRKf+rQuq=j_4NJpNbRq4Rdxz7MjQaxi3c9usS+c615k19Q@mail.gmail.com>
In-Reply-To: <CAL3xRKf+rQuq=j_4NJpNbRq4Rdxz7MjQaxi3c9usS+c615k19Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 09:48:22 -0700
Message-ID: <CABPp-BHyc=aYqY+YuvNRsFsrMPL6+O=CX37jzXx38_-SXw5gLA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sparse checkout status
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Son,

Thanks for the feedback.

On Wed, Jun 17, 2020 at 12:40 AM Son Luong Ngoc <sluongng@gmail.com> wrote:
>
> Hi Elijah,
>
> > Some of the feedback of folks trying out sparse-checkouts at $dayjob is=
 that
> > sparse checkouts can sometimes be disorienting; users can forget that t=
hey
> > had a sparse-checkout and then wonder where files went.
>
> I agree with this observation: that the current 'git sparse-checkout' exp=
erience
> could be a bit 'lost' for end users, who may or may not be familiar
> with git's 'arcane magic'.
>
> Currently the only way to verify what's going on is to either run
> 'tree <repo-root-dir>'
> or 'cat .git/info/sparse-checkout' (human-readable but not easy).

Well, there is `git sparse-checkout list`, assuming users know they
are in a sparse-checkout, but the whole point of my suggested change
is that they sometimes don't.

> > This series adds some output to 'git status' and modifies git-prompt sl=
ightly as an attempt
> > to help.
>
> This is a great idea but I suggest to put a config/flag to let users
> enable/disable this.
>
> Git status is often utilized in automated commands (IDE, shell prompt,
> etc...) and there may be
> performance implications down the line not being able to skip this bit
> of information out.

This surprises me; I considered performance while writing it and kept
it simple on that basis.  In particular:
  * This does not cause any reading or writing of any extra files; it
is done solely with information that is already loaded.
  * If users aren't in a sparse-checkout, their performance overhead
is a single if-check, which I doubt anyone can measure.
  * If they are in a sparse-checkout, then they'd get one extra loop
over files in the index to check the SKIP_WORKTREE bit.

In which cases would performance implications be a concern?  For a
very simple point of reference, in a sparse-checkout of the linux
kernel (using --cone mode and only selecting the drivers/ directory),
I see the following timings for 'git status' in a clean checkout:

Without my change:
[newren@tiger linux-stable (hwmon-updates|SPARSE)]$ hyperfine --warmup
1 'git status'
Benchmark #1: git status
  Time (mean =C2=B1 =CF=83):      78.8 ms =C2=B1   2.8 ms    [User: 48.9 ms=
, System: 76.9 ms]
  Range (min =E2=80=A6 max):    74.0 ms =E2=80=A6  84.0 ms    38 runs

With my change:
[newren@eenie linux-stable (hwmon-updates|SPARSE)]$ hyperfine --warmup
1 'git status'
Benchmark #1: git status
  Time (mean =C2=B1 =CF=83):      79.8 ms =C2=B1   2.7 ms    [User: 49.3 ms=
, System: 77.7 ms]
  Range (min =E2=80=A6 max):    74.8 ms =E2=80=A6  84.5 ms    37 runs

I know the linux kernel is tiny compared to repos like Windows or
Office, but the relative scaling considerations are identical: it's
one extra loop through the cached entries checking a bit for each
entry.  If people are worried about the "extra loop", I could find an
existing loop to modify and just add an extra if-block in it so that
we have the same number of loops.  (I'm doubtful that'd actually help,
but if the concern is an extra loop, it'd certainly avoid that.)
Anyway, if you've got more information about it being too costly, I'm
happy to listen.  Otherwise, the overhead seems pretty small to me and
it's only paid by those who would benefit from the information.

However, all that said, I have good news: Peff already implemented the
flag users can use to avoid this extra output, and did so back in
September of 2009.  It's called "--porcelain".  Automated commands
should already be using it, and if they aren't, they are what needs
fixing -- not the long form status output.

> > For reference, I suspect that in repositories that are large enough tha=
t
> > people always use sparse-checkouts (e.g. windows or office repos), that=
 this
> > isn't a problem. But when the repository is approximately
> > linux-kernel-sized, then it is reasonable for some folks to have a full
> > checkout. sparse-checkouts, however, can provide various build system a=
nd
> > IDE performance improvements, so we have a split of users who have
> > sparse-checkouts and those who have full checkouts. It's easy for users=
 who
> > are bridging in between the two worlds or just trying out sparse-checko=
uts
> > for the first time to get confused.
>
> One of our users noted that the experience is improved when combining
> 'git worktree' with sparse-checkout.
> That way you get the correct sparsity for the topic that you are working =
on.
>
> In a way, the current sparse-checkout experience is similar to a user
> running 'git checkout <rev>' directly
> instead of checking out a branch.
> It does not feel tangible and reproducible.
>
> I was hoping that these concerns will be addressed once the In-Tree
> Sparse-Checkout Definition RFC[1] patch landed.
> We should then be able to print out which Definition File(s) (we often
> call it manifests) were used,
> and ideally, only the top most file(s) in the inheritance tree.
>
> So the ideal experience, in my mind, is something of this sort:
>
>     git sc init --cone
>
>     # assuming a inherited from b and c
>     git sc add --in-tree manifest-dir/module-a.manifest
>     git sc add --in-tree manifest-dir/module-d.manifest
>
>     git sc status
>         Your sparse checkout includes following definition(s):
>         (1) manifest-dir/module-a.manifest
>         (2) manifest-dir/module-d.manifest
>
>     git sc status --all
>         Your sparse checkout includes following definition(s):
>         (1) manifest-dir/module-a.manifest
>         (2) manifest-dir/module-d.manifest
>         (3) manifest-dir/module-b.manifest (included by 1)
>         (4) manifest-dir/module-c.manifest (included by 1)

I think having a 'git sparse-checkout status' would be a fine
subcommand, and output like the above -- possibly also including other
bits Stolee or I mentioned elsewhere in this thread -- would be cool
and would be helpful; it'd complement what I'm doing here quite
nicely.

But you're solving a related problem rather than the one I was
focusing on, and you have left the issue I was focusing on
unaddressed.  In particular, if users forgot that they sparsified in
the first place, how are they going to know to run `git
sparse-checkout status [--all]`?

I think having a simple line of output in `git status` would remind
them.  With that reminder, they could today then go run 'git
sparse-checkout list' or 'gvfs health' (as Stolee mentioned he uses
internally) or './sparsify --info' (as I use internally) to get more
info.  In the future we could provide additional things for them as
well, such as your 'git sparse-checkout status'.


An aside, though, since you linked to the in-tree sparse-checkout
definitions: When I reviewed that series, the possibility of merge
conflicts and not knowing what sparse-checkout should have checked out
when the in-tree defintions themselves were in a conflicted state
seemed to me to be a pretty tough sticking point.  I'm hoping someone
has a clever solution, but I still don't yet.  Do you?

Thanks,
Elijah
