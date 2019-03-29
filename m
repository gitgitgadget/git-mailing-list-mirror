Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C587220248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfC2PrT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:47:19 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40152 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2PrT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:47:19 -0400
Received: by mail-vk1-f193.google.com with SMTP id l17so599356vke.7
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nh+xO72/NPpBUrII8PTSoIshfnJYPQYwHHWCLhsflPE=;
        b=Bll59Va2o5OfvN8gxw6mYxE0NLa6ydY1m4+rMV+1DNn+tgVY/wm3p4ax0T79g3+iIz
         3qG/VO05ns3ikhR7GK1rp61ix4srT+YpLK5/AODqPVmgYaUWqZ+yqFheun6d75ncEeep
         WR0oe8dfn7XaOTq+ratEINozSzOZNYcMxdA/X+pY1R1uEkl4ug2b3UUbmSOMW6T7subK
         lKd2PX4ut04hi3XSk0w+qTrcXPFiu5l+VfQAs9zPbPfhoZ+qHk+hefrnZJUnAxog7mw+
         rVX1fCiD4UcV/KdIUFgfJeW6vr/LQnN1ps63IR1nTRa8Xa+Tv+D2+F97o/1FYNexORSH
         wC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nh+xO72/NPpBUrII8PTSoIshfnJYPQYwHHWCLhsflPE=;
        b=nBL3s/mXsnAPP2MEvnriIT+wu5Gapd19uYlmzLcJePoNu0wfY8OplWEPYrdkgS9p3n
         RGDsl/JXYXDDLYBgu2mWxcaWFxU3/SJZy1lYdB9YSBEZW7kYjE8XWZVQJ3TN/+/2xLnl
         jev3uBF+Ki7dR0+zMbpXHYm4IppGri8L/6IgY7n9H417SUk8etGOxqXlxWsSjQ/IeRY1
         FEvKbRc1PNSQkw9thRnGfWQIydNDbkIsAyPXbcaOMq0sH2c0nVCaSaGAm++JRfaZnLld
         41ZZ929Igof8U1r/ZEKvnoSeAF87yjT7cVhmG2RVX5GWzP9FdYArgAAm64ytjTrBslpK
         7twg==
X-Gm-Message-State: APjAAAXcU5XSgnnafkKzUVF7ozM2mwfZaruKsfurhD5hlUGmjwMzx/2r
        NrfGL36z8TjtJDaRHpEDQHfVwFMTCDFdSw8xCLc=
X-Google-Smtp-Source: APXvYqyFvZATjI3UZm59R9MjWsJTeLYtlrcd/n+RTJLykS9Xv6atxD5b4rdPgQX8EmWJnt1Ul3NtJSsFk0UL6w7D6ek=
X-Received: by 2002:a1f:2fc2:: with SMTP id v185mr2431301vkv.92.1553874437901;
 Fri, 29 Mar 2019 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190321131655.15249-1-pclouds@gmail.com> <20190329103919.15642-1-pclouds@gmail.com>
 <20190329103919.15642-24-pclouds@gmail.com>
In-Reply-To: <20190329103919.15642-24-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Mar 2019 08:47:06 -0700
Message-ID: <CABPp-BHX1gRhTdurAwrPg60Hk-OuhbrEN=4zatx4OOUo-DkQvw@mail.gmail.com>
Subject: Re: [PATCH v6 23/27] switch: reject if some operation is in progress
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 3:42 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Unless you know what you're doing, switching to another branch to do
> something then switching back could be confusing. Worse, you may even
> forget that you're in the middle of something. By the time you realize,
> you may have done a ton of work and it gets harder to go back.
>
> A new option --ignore-in-progress was considered but dropped because it
> was not exactly clear what should happen. Sometimes you can switch away
> and get back safely and resume the operation. Sometimes not. And the
> git-checkout behavior is automatically clear merge/revert/cherry-pick,
> which makes it a bit even more confusing [1].
>
> We may revisit and add this option in the future. But for now play it
> safe and not allow it (you can't even skip this check with --force). The
> user is suggested to cancel the operation by themselves (and hopefully
> they do consider the consequences, not blindly type the command), or to
> create a separate worktree instead of switching. The third option is
> the good old "git checkout", but it's not mentioned.

I think these safety checks are pretty important for checkout too...

>
> [1] CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=3DYtUvQkWriAk5w@mail.gmail.com
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/checkout.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f7967cdb7c..5f100c1552 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -24,6 +24,7 @@
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "unpack-trees.h"
> +#include "wt-status.h"
>  #include "xdiff-interface.h"
>
>  static const char * const checkout_usage[] =3D {
> @@ -56,6 +57,7 @@ struct checkout_opts {
>         int accept_pathspec;
>         int switch_branch_doing_nothing_is_ok;
>         int only_merge_on_switching_branches;
> +       int can_switch_when_in_progress;
>
>         const char *new_branch;
>         const char *new_branch_force;
> @@ -1202,6 +1204,39 @@ static void die_expecting_a_branch(const struct br=
anch_info *branch_info)
>         die(_("a branch is expected, got '%s'"), branch_info->name);
>  }
>
> +static void die_if_some_operation_in_progress(void)
> +{
> +       struct wt_status_state state;
> +
> +       memset(&state, 0, sizeof(state));
> +       wt_status_get_state(the_repository, &state, 0);
> +
> +       if (state.merge_in_progress)
> +               die(_("cannot switch branch while merging\n"
> +                     "Consider \"git merge --quit\" "
> +                     "or \"git worktree add\"."));
> +       if (state.am_in_progress)
> +               die(_("cannot switch branch in the middle of an am sessio=
n\n"
> +                     "Consider \"git am --quit\" "
> +                     "or \"git worktree add\"."));
> +       if (state.rebase_interactive_in_progress || state.rebase_in_progr=
ess)
> +               die(_("cannot switch branch while rebasing\n"
> +                     "Consider \"git rebase --quit\" "
> +                     "or \"git worktree add\"."));
> +       if (state.cherry_pick_in_progress)
> +               die(_("cannot switch branch while cherry-picking\n"
> +                     "Consider \"git cherry-pick --quit\" "
> +                     "or \"git worktree add\"."));
> +       if (state.revert_in_progress)
> +               die(_("cannot switch branch while reverting\n"
> +                     "Consider \"git revert --quit\" "
> +                     "or \"git worktree add\"."));
> +       if (state.bisect_in_progress)
> +               die(_("cannot switch branch while bisecting\n"
> +                     "Consider \"git bisect reset HEAD\" "
> +                     "or \"git worktree add\"."));
> +}
> +
>  static int checkout_branch(struct checkout_opts *opts,
>                            struct branch_info *new_branch_info)
>  {
> @@ -1257,6 +1292,9 @@ static int checkout_branch(struct checkout_opts *op=
ts,
>             !new_branch_info->path)
>                 die_expecting_a_branch(new_branch_info);
>
> +       if (!opts->can_switch_when_in_progress)
> +               die_if_some_operation_in_progress();
> +
>         if (new_branch_info->path && !opts->force_detach && !opts->new_br=
anch &&
>             !opts->ignore_other_worktrees) {
>                 int flag;
> @@ -1514,6 +1552,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
>         opts.only_merge_on_switching_branches =3D 0;
>         opts.accept_pathspec =3D 1;
>         opts.implicit_detach =3D 1;
> +       opts.can_switch_when_in_progress =3D 1;

I think this should be 0 too; this check is good for both checkout and
switch.  And if people really do want to use it during in-progress
operations because it is sometimes safe enough, then both operations
deserve some kind of override flag that checks for the appropriate
safety conditions (as we're discussing in the other thread) and then
allows or rejects it.

However, I'm totally fine with proposing another patch after your
series lands to do all of this; this patch is fine as-is for now.

>         options =3D parse_options_dup(checkout_options);
>         options =3D add_common_options(&opts, options);
> @@ -1549,6 +1588,7 @@ int cmd_switch(int argc, const char **argv, const c=
har *prefix)
>         opts.switch_branch_doing_nothing_is_ok =3D 0;
>         opts.only_merge_on_switching_branches =3D 1;
>         opts.implicit_detach =3D 0;
> +       opts.can_switch_when_in_progress =3D 0;
>
>         options =3D parse_options_dup(switch_options);
>         options =3D add_common_options(&opts, options);
> --
> 2.21.0.479.g47ac719cd3
