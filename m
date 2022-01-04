Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E5C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiADUms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiADUmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:42:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B99AC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 12:42:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f5so153231966edq.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 12:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FM0w7Oaz4hJeY3W9us7WTWxJeDUZ5tNWUhEg4vuxzWA=;
        b=BnU1AtmkYNFXlkhOIY9sG+s7e6wqXS0kmKkEqbNkX0vsrg/rtwVfJxuTr2cNk9RtgS
         nA7hIhrpHhkkPrWoUFQ4S5AANJrYzCTwnw4YoEqAM2OzDEGVstxOSVw0letLQxjrcnl2
         VcmDDHG6jHeS7GKALk61JmJk4FZtZPTGNGpib/IrXpkoUaNii6nFHt79O0fZvn9nWAjF
         rStcABDzwYCuvlHJcjsOe6wP8I9ZAKJVxu+q2Cj4l2yQkCbeoy1YbJg6pQP1gBzRJwN4
         Tf7k0PGZBfIpmJVE+FU8gvyndLqDeSzjcKf3AqomBnhkRyKWWeKG9lvlX/aKSagzYiQn
         LGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FM0w7Oaz4hJeY3W9us7WTWxJeDUZ5tNWUhEg4vuxzWA=;
        b=kWIF2acUqEYOkgTikOC3XWQrT1a0o+SKKV9X6EUO3jwVRv43czkXW6jL4nbhdGd2OL
         7qfseLdhhkv6i5ENewIwU70Vw61O5HjDzGn0++ywj1GFt+XEWobBL8KuhqQAXHV5fRET
         PafkRHuyoA+rzQVXuI+n+0MhZYjLYxtgteKPVJYpKv2BJo3xrp80+508dTTjTLr9v9e6
         DfyutQQtmfwoGmpYc7Kc0GqLtSBtbgJl0oiTam3oDk1bR0qE+ahJX8P6otKXu70SdFeJ
         2y1ElA+U7RyiBrHWGSYjBWMxku13rPz7NccgOtCd1ZQ+mon3H5We6c4BQAaaJqXB3qgb
         QLEw==
X-Gm-Message-State: AOAM532Z/eJ4AA/If3/jUX0ohDY0z95hG65qpMXL/Ncr5uy/SVTSh6B5
        16LX4ocp9tU12z85EPLi4za0ud0MOwifX6ABLpg=
X-Google-Smtp-Source: ABdhPJwkS51bzsWha7XQevTrNWhPf5sLBrO7Tk4a7jgvAUAuuZkwdNovJYa0zfk4gh0u9ZbEUDai26evdWxOa/gXiGo=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr41567452ejc.476.1641328965721;
 Tue, 04 Jan 2022 12:42:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com> <676e8408-5ac3-4293-22ee-c43e9bd6916b@gmail.com>
In-Reply-To: <676e8408-5ac3-4293-22ee-c43e9bd6916b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Jan 2022 12:42:34 -0800
Message-ID: <CABPp-BFJF7hyr5onMFQNC7r_x+XfJVn9wXhxyMV6Lu+pxbfyPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sparse-checkout: custom tab completion
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 11:41 AM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
>
>
> On 12/31/21 4:52 PM, Elijah Newren wrote:
> > On Fri, Dec 31, 2021 at 2:33 AM Lessley Dennington via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Lessley Dennington <lessleydennington@gmail.com>
> >>
> >> Fix custom tab completion for sparse-checkout command. This will ensure:
> >>
> >> 1. The full list of subcommands is provided when users enter git
> >> sparse-checkout <TAB>.
> >> 2. The --help option is tab-completable.
> >> 3. Subcommand options are tab-completable.
> >> 4. A list of directories (but not files) is provided when users enter git
> >> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
> >>
> >> Failing tests that were added in the previous commit to verify these
> >> scenarios are now passing with these updates.
> >>
> >> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> >> ---
> >>   contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
> >>   t/t9902-completion.sh                  |  8 +++---
> >>   2 files changed, 30 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> >> index c82ccaebcc7..7de997ee64e 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -2986,24 +2986,38 @@ _git_show_branch ()
> >>          __git_complete_revlist
> >>   }
> >>
> >> +__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
> >> +
> >>   _git_sparse_checkout ()
> >>   {
> >> -       local subcommands="list init set disable"
> >> +       local subcommands="list init set disable add reapply"
> >>          local subcommand="$(__git_find_on_cmdline "$subcommands")"
> >> +
> >>          if [ -z "$subcommand" ]; then
> >> -               __gitcomp "$subcommands"
> >> -               return
> >> +               case "$cur" in
> >> +                       --*)
> >> +                               __gitcomp "--help"
> >> +                               ;;
> >> +                       *)
> >> +                               __gitcomp "$subcommands"
> >> +                               ;;
> >> +               esac
> >>          fi
> >>
> >> -       case "$subcommand,$cur" in
> >> -       init,--*)
> >> -               __gitcomp "--cone"
> >> -               ;;
> >> -       set,--*)
> >> -               __gitcomp "--stdin"
> >> -               ;;
> >> -       *)
> >> -               ;;
> >> +       case "$prev" in
> >
> > Shouldn't this be "$subcommand" rather than "$prev"?  I think with
> > prev, it will only correctly complete the first path after "set",
> > "add", etc.
> >
> Good catch, thank you! Fixing in v3.
> >> +               set)
> >> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
> >> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> >> +                       ;;
> >> +               add)
> >> +                       __gitcomp "--stdin"
> >> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> >
> > I was going to make a simple suggestion for making it just complete
> > one additional level at a time and leaving out the -r, and then tried
> > it out and found out it wasn't simple.  I got something working,
> > eventually, but it's slightly ugly...so it probably belongs in a
> > separate patch anyway.  If you're curious, it's basically replacing
> > the second __gitcomp... call for each of set and add with
> > `__gitcomp_directories`, after first defining:
> >
> > __gitcomp_directories ()
> > {
> >      local _tmp_dir _tmp_completions
> >
> >      # Get the directory of the current token; this differs from dirname
> >      # in that it keeps up to the final trailing slash.  If no slash found
> >      # that's fine too.
> >      [[ "$cur" =~ .*/ ]]
> >      _tmp_dir=$BASH_REMATCH
> >
> >      # Find possible directory completions, adding trailing '/' characters
> >      _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
> >          sed -e s%$%/%)"
> >
> >      if [[ -n "$_tmp_completions" ]]; then
> >          # There were some directory completions, so find ones that
> >          # start with "$cur", the current token, and put those in COMPREPLY
> >          local i=0 c IFS=$' \t\n'
> >          for c in $_tmp_completions; do
> >              if [[ $c == "$cur"* ]]; then
> >                  COMPREPLY+=("$c")
> >              fi
> >          done
> >      elif [[ "$cur" =~ /$ ]]; then
> >          # No possible further completions any deeper, so assume we're at
> >          # a leaf directory and just consider it complete
> >          __gitcomp_direct_append "$cur "
> >      fi
> > }
> >
> > But I don't think that needs to be part of this series; I can submit
> > it later and hopefully get a completion expert to point out
> > better/cleaner ways of what I've done above.
> >
> I'm admittedly curious about what made this so difficult. I removed the
> '-r' and updated my tests to expect only directories at one level, and
> they passed. But I imagine I'm being too simplistic.

I've forgotten some details since last Saturday, but I think the
problem was that doing that would only ever complete toplevel
directories; after completing those you could keep tabbing to get a
deeper directory.  First, let's get a comparison point; ignoring
sparse-checkout, I can do:

    cd $GIT_CLONE
    cd cont<TAB>b<TAB><TAB>

and the ls line will replace those <TAB>s so that I see

    ls contrib/buildsystems/Generators

Now, if we just removed the '-r' from your git-completion.bash
changes, and then typed

    git sparse-checkout set cont<TAB>b<TAB><TAB>

Then you'd see

    git sparse-checkout set contrib

and see 'bin-wrappers', 'block-sha1', and 'builtin' as potential
completions, but not as subdirs of contrib but instead sibling dirs to
contrib.  That completion rule wouldn't let you look within contrib/.
My more complicated rule had to avoid calling __gitcomp to avoid
adding spaces so that completions could continue (but should add them
if we have tabbed all the way down and there are no more
subdirectories), had to add trailing '/' characters so that we know
when we have the full directory name to pass along to ls-tree, and
then had to manually do the work that __gitcomp would manually do with
making sure to only provide completions relevant to what has been
typed so far.
