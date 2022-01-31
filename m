Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474EC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359390AbiAaVh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358076AbiAaVhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:37:54 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4AFC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:37:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id me13so47326918ejb.12
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqO/6PWgmlrXDF/AY1uXBCJwDWnOPO/ZxkTNYcOzLIg=;
        b=Dn4rM7wFh4mTH6VTupN1J7FLfh65GOOmV0H8I8918GCijWRhF6v/wokAAq9R9qrtSK
         93sms7Wr7cKqdlfoB495vrnfPhm+BhSaG36YiwwY7mW4o6GKnLiRZCAbW63RXh1vsQ/0
         +vytK8P4x19fZrlJ32vxUjSVcvC92oCmSAb3p+VF+2z2SNgKQPTSQjEkYJWIPAdwm47q
         pfOK9sYnGUm0P5lqJDvJzUbWqe2kzXuS5hipfWZr4ang+/sWB+0m3b2C483KJ/vtgG8S
         eME+JkxobhP6MMJHJcr8Qxj8mEBOuw3Ho60oksbn9lXAFwzuTqSjI0EpE7ZB0aC2IsGy
         Ohlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqO/6PWgmlrXDF/AY1uXBCJwDWnOPO/ZxkTNYcOzLIg=;
        b=FvIaT3SgN/xgpoH89u6nOcWYsgAVZQV9fCRrHqvLYC3tQrRAJcq86KkiBlpabNb7mb
         6jAy2oMt9uMupLt/vGRBeCjiPK+nxXuUsrLnE+8PWHDCdJBKnJXsqDtWGnlDTiSlS2Vd
         EXv4Mr5UnelzJJNCPIeUMFAm9addn+VkCgwTNp+56cPwfJrPSnuUj4CVP9D9Qh/5F3/o
         yXU0UWBpK6jIE5WgLoACZ6Ty8p9kX16PU74mgP4IMJIVvdv+jZnpTaWJ9Yfa2mQx+H7G
         CMnrMkGTWELZzBMZjhVaJM6AC7ZNzRcqkSODfIcCVKwgKl3Iy6dQ4nWYH1ouEeHekWUe
         Uf0w==
X-Gm-Message-State: AOAM531qUkSgxixB6ntjAIX7RfVGBlOcjpkYl2vCIK9wwPuB/keVGXKd
        mWFvL5SOuRUzEAluQPC9QoZCZ9BbqnBI325fC9M=
X-Google-Smtp-Source: ABdhPJy6Tp91jfh8SQdcC2R/5mCg+nzDgN0H9vrIOJU2YbJ5BIfu9SKN93+7QdT2TE66V0b93S5ht86V+go51gFahjs=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr12849163ejc.100.1643665072124;
 Mon, 31 Jan 2022 13:37:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com> <7d70beb2a6b3967c51d1d7feb34bfb9368066cdb.1643318514.git.gitgitgadget@gmail.com>
 <CABPp-BFG6fD3hDTrG_HZP9qv0qYaHBFxV3idik6YHE53cnFt6Q@mail.gmail.com> <82bb12d0-0505-1997-21ba-b9863bfdf2c8@gmail.com>
In-Reply-To: <82bb12d0-0505-1997-21ba-b9863bfdf2c8@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 31 Jan 2022 13:37:40 -0800
Message-ID: <CABPp-BGyH029hidv2t5hmx6=LLt=9m1R_7vZLK7JYizybmaFgQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] completion: sparse-checkout updates
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 12:03 PM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
> On 1/27/22 5:21 PM, Elijah Newren wrote:
> > On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Lessley Dennington <lessleydennington@gmail.com>
> >>
> >> Fix custom tab completion for the sparse-checkout command. This will
> >> ensure:
> >>
> >> 1. The full list of subcommands is provided when users enter git
> >> sparse-checkout <TAB>.
> >> 2. Subcommand options are tab-completable.
> >> 3. A list of directories (but not files) is provided when users enter git
> >> sparse-checkout add <TAB> or git sparse-checkout set <TAB> in cone mode
> >> only. In non-cone mode, these commands will continue to complete both
> >> directory and file names.
> >>
> >> Failing tests that were added in the previous commit to verify these
> >> scenarios are now passing with these updates.
> >>
> >> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> >> ---
> >>   contrib/completion/git-completion.bash | 15 ++++++++-------
> >>   t/t9902-completion.sh                  |  4 ++--
> >>   2 files changed, 10 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> >> index c82ccaebcc7..a920cdab201 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -2988,21 +2988,22 @@ _git_show_branch ()
> >>
> >>   _git_sparse_checkout ()
> >>   {
> >> -       local subcommands="list init set disable"
> >> +       local subcommands="list init set disable add reapply"
> >>          local subcommand="$(__git_find_on_cmdline "$subcommands")"
> >> +
> >>          if [ -z "$subcommand" ]; then
> >>                  __gitcomp "$subcommands"
> >>                  return
> >>          fi
> >>
> >>          case "$subcommand,$cur" in
> >> -       init,--*)
> >> -               __gitcomp "--cone"
> >> -               ;;
> >> -       set,--*)
> >> -               __gitcomp "--stdin"
> >> +               *,--*)
> >> +                       __gitcomp_builtin sparse-checkout_$subcommand "" "--"
> >>                  ;;
> >> -       *)
> >> +               set,*|add,*)
> >> +                       if [ $(__git config core.sparseCheckoutCone) ]; then
> >> +                               __git_complete_index_file "--directory"
> >> +                       fi
> >
> > --directory only affects how untracked files are presented in `git
> > ls-files` (which _git_complete_index_file uses), and you're not asking
> > for untracked paths at all here.  So you've got a useless flag.
> >
> > Testing this commit out, I can verify that it completes on all tracked
> > paths in the index.  Perhaps that was an intended intermediate step,
> > but if so the commit message needs to be changed since it claims this
> > commit is doing something else.
> >
> > There's also a problem in that `git sparse-checkout --cone path<TAB>`
> > is not using this codepath.  If the user specifies --cone, then we
> > should give them cone-mode-style completion the same as if they
> > already have the config setting set.  Or, we at least need to mention
> > in the commit message that we don't yet correctly check for the
> > `--cone` option to get the right style of completion and are leaving
> > it for future work.
>
> >
> Thank you for your feedback, it is very helpful. As I've been thinking
> about this, it feels like this commit should perhaps be dropped in favor
> of the __gitcomp_directories commit (with some modifications per [1]). I
> know you initially said to add the __gitcomp_directories commit in
> addition to what I had, though, so I wanted to confirm whether removing
> this is the right course of action.
>
> [1]:
> https://lore.kernel.org/git/CABPp-BEq9pTqsy_R_SR1DSgUK58ubNR1Gk4G1RoL8wkadyo6zw@mail.gmail.com/

I think the link you meant was
https://lore.kernel.org/git/CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com/.
Anyway...

I thought the "git ls-tree -d -r --name-only HEAD" step you did
previously was a useful intermediate step because it was really simple
and it highlighted the direction we wanted to go for cone mode -- it
just had some caveats (it was potentially slow, and it has the same
quoting issues that my patch had).  I feel that sometimes an
intermediate step helps reviewers -- both current ones and folks
digging through the code years from now.

I think __git_complete_index_file() is a step in the wrong direction,
and as such adding a patch that uses it does not help people
understand the path to the end goal.  So, if the choice is about
__git_complete_index_file(), then yeah, we shouldn't include that
step.  But your old step 2 might have value.

I think there's a few possible choices you could make to replace your
current patches 2 & 3; including:
  * 1 patch: Just use the __gitcomp_directories commit, modified to
handle the special quoting needed
  * 2 patches: Insert your old "git ls-tree -d -r --name-only HEAD"
patch, made specific to cone mode, mentioning the performance and
quoting shortcomings in the commit message and stating that a
subsequent commit will address those issues.  Then add the
__gitcomp_directories commit, modified to handle special quoting
  * 3 patches: First commit same as the case above.  Then add the
__gitcomp_directories commit without changing it to handle special
path quoting (i.e. the second patch only addresses the performance
shortcoming).  Then add a 3rd commit handling the special path quoting
(addressing the remaining issue).
  * some other split that occurs to you while you do the work.

Of the first three, I have a small preference for replacing patches 2
& 3 from this round with the 3-patch replacement above (making your
series be 4 patches total), because it provides a "10,000 ft overview"
before jumping into the weeds, it naturally documents why a simpler
solution that might occur to folks isn't good enough, it allows
reviewers to focus on just performance or on just special quoting when
reviewing so they don't have to try to guess which end goal each line
of code is working to achieve as they attempt to review.  But I'm
partially guessing at how much work is involved in the special path
quoting, and at how localized each part of the solution might be.  If
either of the performance or special quoting concerns are nicely
localized in the patch anyway, then the separation of commits becomes
less important.  And perhaps a comment in the commit message is good
enough to provide the 10,000 ft overview so you don't need the
explicit "git ls-tree -d -r --name-only HEAD" step.

Anyway, that's how I think about it.  Other than the fact that
__git_complete_index_file() should not be included as a step, any of
the choices could be fine so I'll leave it up to you.
