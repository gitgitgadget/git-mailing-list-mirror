Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076AF1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 22:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755386AbeFRWBX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 18:01:23 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46440 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755003AbeFRWBX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 18:01:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id v197-v6so6183895ywc.13
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+xzy7dkcyFcUgMKjOZPpEJwcQhy4Ljsq/ZnLCAADto=;
        b=KzxjzueRwOKeaUasOABw4zdaTmM/yJ084Ii4lE6pBBd9KEl+R2n0AZWCl8YaRzz4mM
         5ZNXx5/n6ueB5aK5XTwi9BVO/QpCQXWk9wEQjhafcgVPW0scIVHxS6a2w4v738c5rE5e
         gx5pbEYx+L5wnjHHmLa+o7J1d/UA6dLHNmBGaRBi6QpRzkDXQeqtyUVoFQA+r+DyngSU
         +hPs3v7wN4VWVq2EqzgGklTd2pbBHFv+Ed4SsKDIf9YnJ226hGiXRHk+95p6og+rf7BK
         ew5ffhSavjFJW3fDd3vq4h3ej0Y80GivSEN36S4neeVx9l3iVvsUPH3Z7eRfRW/o1Cc+
         efFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+xzy7dkcyFcUgMKjOZPpEJwcQhy4Ljsq/ZnLCAADto=;
        b=MBofOtkGqcmZ0flxGSGyGP42iQ7Rm2xKqHmmZ3akF6aNyIgId3fyzCXgZdqhkbjUI6
         IajijrkiEwfu4X7Ntfn7tO5nkKX8F2aale3FJcU3/hVghMRi4vqpRXYB0XXYwpG5o9At
         nOD6+jwlVV3FRoNe99omB9G4hx8U9VUnbFpqJqKBF+dHaHkoJpMO/2FBCO979Hwg05yR
         w0LhjzlSQAhUf4wpH7bz4ciwIgkE94uXaP9psg0h+XHXtwoA39OWTSD4bzA8FERj/Q39
         El2v0ntkvaT3UerYu18dIqVIyBSsfxcJNSw8jrudCACoVGZR+P7nC7vdGd6OTSfnt0/s
         ZH1A==
X-Gm-Message-State: APt69E0Urt+trGHgy78e+F2owVgVg0u6gM06a9RtV61YbKF0ux/Zeq3/
        KzoT1vxkZLzCRbpCUyFYXiPSalWtYJ55ZzMd84an3g==
X-Google-Smtp-Source: ADUXVKJPBziGrsIkO5PtJ1Dji7G7H2LpPZBCudieG7K+9FZ3jadwUhGPJYsQWcaHzsvGKlazrRJi3Uw+oR2hXDTkBrU=
X-Received: by 2002:a81:e544:: with SMTP id c4-v6mr6799637ywm.345.1529359281968;
 Mon, 18 Jun 2018 15:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180618131844.13408-3-alban.gruin@gmail.com>
In-Reply-To: <20180618131844.13408-3-alban.gruin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 15:01:11 -0700
Message-ID: <CAGZ79kaLSCXSDHN8=L-FCBvQ9jRJqit6VFNK3VmHm9H07ThEsg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/3] rebase -i: rewrite setup_reflog_action() in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 6:19 AM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This rewrites setup_reflog_action() from shell to C.
>
> A new command is added to rebase--helper.c, =E2=80=9Csetup-reflog=E2=80=
=9D, as such as a
> new flag, =E2=80=9Cverbose=E2=80=9D, to silence the output of the checkou=
t operation
> called by setup_reflog_action().
>
> The shell version is then stripped in favour of a call to the helper. As
> $GIT_REFLOG_ACTION is not longer set at the first call of
> checkout_onto(), a call to comment_for_reflog() is added at the
> beginning of this function.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--helper.c   |  9 +++++++--
>  git-rebase--interactive.sh | 16 ++--------------
>  sequencer.c                | 31 +++++++++++++++++++++++++++++++
>  sequencer.h                |  3 +++
>  4 files changed, 43 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index d2990b210..d677fb663 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage=
[] =3D {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>         struct replay_opts opts =3D REPLAY_OPTS_INIT;
> -       unsigned flags =3D 0, keep_empty =3D 0, rebase_merges =3D 0;
> +       unsigned flags =3D 0, keep_empty =3D 0, rebase_merges =3D 0, verb=
ose =3D 0;
>         int abbreviate_commands =3D 0, rebase_cousins =3D -1;
>         enum {
>                 CONTINUE =3D 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_=
OIDS,
>                 CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH=
,
> -               ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
> +               ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, SETUP_REFLOG
>         } command =3D 0;
>         struct option options[] =3D {
>                 OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward"=
)),
> @@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, con=
st char *prefix)
>                 OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase m=
erge commits")),
>                 OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
>                          N_("keep original branch points of cousins")),
> +               OPT_BOOL(0, "verbose", &verbose, N_("verbose")),

verbose is quite a popular flag name, such that the option parsing
dedicated it its own macro OPT__VERBOSE.


> +int setup_reflog_action(struct replay_opts *opts, const char *commit,
> +                       int verbose)
> +{
> +       const char *action;
> +
> +       if (commit && *commit) {

While this is defensive programming (checking the pointer before dereferenc=
ing
it, the first condition (commit =3D=3D NULL) should never be false here,
as the caller
checks for argc =3D=3D 2 ? Maybe we could move the logic of the whole
condition there

       if (command =3D=3D SETUP_REFLOG && argc =3D=3D 2 && *argv[1])
               return !!setup_reflog_action(&opts, argv[1], verbose);

as then we could loose the outer conditional here.
