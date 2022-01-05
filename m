Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F5C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 22:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiAEW4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 17:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiAEW4A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 17:56:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E4C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 14:55:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a18so1347194edj.7
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YSNb4oi6WQc2K40QkaupkGoWA3vKPCKBJx3beuoyvs=;
        b=NghRgDQtzXBWZFlLx3QYr2hisoEvk1475xZNDBi0IiKXPFA4lgl+LBU1qCvg/gD7+5
         4lDE89PIUtHJWdg2X6oUhCUQmzjvfdCgvtbPAYf1ZEB4t1dg7eGs8jBXuE8pp9NRLSML
         x/pILLQ6XWGj6ZwkI4q4Mq2OI41VDFG3y29U1RYi+x4we3JrFUWZgx5JWf/FrUdJeP9Q
         rWvWFMxypdsiayrT75IiWC9y7sBTLvQ6msTKDwpp5iJ7tpjXhkMl10MUc7Nnw99YVfWM
         S4VJuekaGp36JPZvzUt0PmTTCugXRvm4/ots2TNwYzAAkM6W0yAPfwlrMI2SAncQ0fyO
         07zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YSNb4oi6WQc2K40QkaupkGoWA3vKPCKBJx3beuoyvs=;
        b=ZpaXHkrsr1ZfqHv2+HgqUX0YcfQY4uRLSZB7gZ7Bf7McL7xrkmk75gZhGOn14NsaMA
         Np4uaikjPNgFZ1BikN553hPxPIjsZvyrXxeuaZ1QggOdE1NzcE1pjk3EFj0O9DRjH/NM
         dnRcGiYJetQt0rcUvxqjRb8Y9Xlp7/D+hai6PReBHY8O7KkeY60nJQ9GTNqybUuesIFe
         qYd4yD/UNQ/TOU6bgomFw1vLjgjBS230xwsZMp2AuTOTq5s09MS4CmLPtxXjEsOhzLdH
         RqP/rvLQ/e2TiZ4/2AcAKgtBJL24l2qQkTOiP4dH56jEXaVHgmyct2jxAOf5jVQxJUI+
         fbsg==
X-Gm-Message-State: AOAM531G0QQlsdlhw5sTKfLIJpowbzcBqnCRoamyajivcDMAEh4iA5ok
        viL0gcO5EuR+3ynau2nvQ2/AT9J8Wm4L72JI7hpn7T7UiOU=
X-Google-Smtp-Source: ABdhPJyhwCFhJcG5rCBlecm5dsezWHprh1y2vnoavo5WDuXMuZbr7cn3jCm98cYYaswC4FQ6NYXkZWqhrvdhEAnEQLU=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr43457850ejc.269.1641423358290;
 Wed, 05 Jan 2022 14:55:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com>
 <676e8408-5ac3-4293-22ee-c43e9bd6916b@gmail.com> <CABPp-BFJF7hyr5onMFQNC7r_x+XfJVn9wXhxyMV6Lu+pxbfyPA@mail.gmail.com>
 <8202614a-022f-b71c-cf88-d5a3788cc150@gmail.com>
In-Reply-To: <8202614a-022f-b71c-cf88-d5a3788cc150@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 14:55:47 -0800
Message-ID: <CABPp-BG4xA6G0E9FeognvFoAns8tg+9SRr8d4O6s0QT4L71uTA@mail.gmail.com>
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

On Wed, Jan 5, 2022 at 12:20 PM Lessley Dennington
<lessleydennington@gmail.com> wrote:
>
> On 1/4/22 2:42 PM, Elijah Newren wrote:
> > On Tue, Jan 4, 2022 at 11:41 AM Lessley Dennington
> > <lessleydennington@gmail.com> wrote:
> >>
> >>
> >>
> >> On 12/31/21 4:52 PM, Elijah Newren wrote:
> >>> On Fri, Dec 31, 2021 at 2:33 AM Lessley Dennington via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >>>>
> >>>> From: Lessley Dennington <lessleydennington@gmail.com>
> >>>>
> >>>> Fix custom tab completion for sparse-checkout command. This will ensure:
> >>>>
> >>>> 1. The full list of subcommands is provided when users enter git
> >>>> sparse-checkout <TAB>.
> >>>> 2. The --help option is tab-completable.
> >>>> 3. Subcommand options are tab-completable.
> >>>> 4. A list of directories (but not files) is provided when users enter git
> >>>> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
> >>>>
> >>>> Failing tests that were added in the previous commit to verify these
> >>>> scenarios are now passing with these updates.
> >>>>
> >>>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> >>>> ---
> >>>>    contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
> >>>>    t/t9902-completion.sh                  |  8 +++---
> >>>>    2 files changed, 30 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> >>>> index c82ccaebcc7..7de997ee64e 100644
> >>>> --- a/contrib/completion/git-completion.bash
> >>>> +++ b/contrib/completion/git-completion.bash
> >>>> @@ -2986,24 +2986,38 @@ _git_show_branch ()
> >>>>           __git_complete_revlist
> >>>>    }
> >>>>
> >>>> +__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
> >>>> +
> >>>>    _git_sparse_checkout ()
> >>>>    {
> >>>> -       local subcommands="list init set disable"
> >>>> +       local subcommands="list init set disable add reapply"
> >>>>           local subcommand="$(__git_find_on_cmdline "$subcommands")"
> >>>> +
> >>>>           if [ -z "$subcommand" ]; then
> >>>> -               __gitcomp "$subcommands"
> >>>> -               return
> >>>> +               case "$cur" in
> >>>> +                       --*)
> >>>> +                               __gitcomp "--help"
> >>>> +                               ;;
> >>>> +                       *)
> >>>> +                               __gitcomp "$subcommands"
> >>>> +                               ;;
> >>>> +               esac
> >>>>           fi
> >>>>
> >>>> -       case "$subcommand,$cur" in
> >>>> -       init,--*)
> >>>> -               __gitcomp "--cone"
> >>>> -               ;;
> >>>> -       set,--*)
> >>>> -               __gitcomp "--stdin"
> >>>> -               ;;
> >>>> -       *)
> >>>> -               ;;
> >>>> +       case "$prev" in
> >>>
> >>> Shouldn't this be "$subcommand" rather than "$prev"?  I think with
> >>> prev, it will only correctly complete the first path after "set",
> >>> "add", etc.
> >>>
> >> Good catch, thank you! Fixing in v3.
> >>>> +               set)
> >>>> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
> >>>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> >>>> +                       ;;
> >>>> +               add)
> >>>> +                       __gitcomp "--stdin"
> >>>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> >>>
> >>> I was going to make a simple suggestion for making it just complete
> >>> one additional level at a time and leaving out the -r, and then tried
> >>> it out and found out it wasn't simple.  I got something working,
> >>> eventually, but it's slightly ugly...so it probably belongs in a
> >>> separate patch anyway.  If you're curious, it's basically replacing
> >>> the second __gitcomp... call for each of set and add with
> >>> `__gitcomp_directories`, after first defining:
> >>>
> >>> __gitcomp_directories ()
> >>> {
> >>>       local _tmp_dir _tmp_completions
> >>>
> >>>       # Get the directory of the current token; this differs from dirname
> >>>       # in that it keeps up to the final trailing slash.  If no slash found
> >>>       # that's fine too.
> >>>       [[ "$cur" =~ .*/ ]]
> >>>       _tmp_dir=$BASH_REMATCH
> >>>
> >>>       # Find possible directory completions, adding trailing '/' characters
> >>>       _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
> >>>           sed -e s%$%/%)"
> >>>
> >>>       if [[ -n "$_tmp_completions" ]]; then
> >>>           # There were some directory completions, so find ones that
> >>>           # start with "$cur", the current token, and put those in COMPREPLY
> >>>           local i=0 c IFS=$' \t\n'
> >>>           for c in $_tmp_completions; do
> >>>               if [[ $c == "$cur"* ]]; then
> >>>                   COMPREPLY+=("$c")
> >>>               fi
> >>>           done
> >>>       elif [[ "$cur" =~ /$ ]]; then
> >>>           # No possible further completions any deeper, so assume we're at
> >>>           # a leaf directory and just consider it complete
> >>>           __gitcomp_direct_append "$cur "
> >>>       fi
> >>> }
> >>>
> >>> But I don't think that needs to be part of this series; I can submit
> >>> it later and hopefully get a completion expert to point out
> >>> better/cleaner ways of what I've done above.
> >>>
> >> I'm admittedly curious about what made this so difficult. I removed the
> >> '-r' and updated my tests to expect only directories at one level, and
> >> they passed. But I imagine I'm being too simplistic.
> >
> > I've forgotten some details since last Saturday, but I think the
> > problem was that doing that would only ever complete toplevel
> > directories; after completing those you could keep tabbing to get a
> > deeper directory.  First, let's get a comparison point; ignoring
> > sparse-checkout, I can do:
> >
> >      cd $GIT_CLONE
> >      cd cont<TAB>b<TAB><TAB>
> >
> > and the ls line will replace those <TAB>s so that I see
> >
> >      ls contrib/buildsystems/Generators
> >
> > Now, if we just removed the '-r' from your git-completion.bash
> > changes, and then typed
> >
> >      git sparse-checkout set cont<TAB>b<TAB><TAB>
> >
> > Then you'd see
> >
> >      git sparse-checkout set contrib
> >
> > and see 'bin-wrappers', 'block-sha1', and 'builtin' as potential
> > completions, but not as subdirs of contrib but instead sibling dirs to
> > contrib.  That completion rule wouldn't let you look within contrib/.
> > My more complicated rule had to avoid calling __gitcomp to avoid
> > adding spaces so that completions could continue (but should add them
> > if we have tabbed all the way down and there are no more
> > subdirectories), had to add trailing '/' characters so that we know
> > when we have the full directory name to pass along to ls-tree, and
> > then had to manually do the work that __gitcomp would manually do with
> > making sure to only provide completions relevant to what has been
> > typed so far.
>
> Ah, I see. Thank you so much for the thorough explanation. I know you said
> this series could go through without that update, but I feel like it
> should probably be added. Don't want to start off with the wrong behavior.

The wrong behavior only occurs if you drop the `-r` from your patch.
If you keep the `-r`, as in your patch submission, you get the right
behavior, it just might be a bit slow.  The only reason I investigated
dropping the `-r` and then following up with all the extra workarounds
needed when the `-r` was dropped was because some repositories may be
big enough that immediately recursing trees down to the lowest depths
may be expensive.

For example, in linux.git (very small compared to the Microsoft
repos): `time git ls-tree -rd HEAD >/dev/null` was 0.785s (cold cache;
a mere 0.084s on second run).  If repositories get much bigger than
that, folks might not like the slowness of using `-r`.  But I think
what you have is fine as a first cut.

That said, if you want to add a patch to this series that switches
your straightforward implementation to my much more complex but faster
alternative, that's fine too.
