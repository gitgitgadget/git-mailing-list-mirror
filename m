Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507BAC35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D6520661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwKICh66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBXElx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:41:53 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46607 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgBXElx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:41:53 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so6595826ilm.13
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 20:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=py5jadEhyBO1b4EZFvlp+DwXK4QiPt6j1BJjJI8IRy8=;
        b=uwKICh663MfDUHYi19CuTDS0jme3WoB+aQbS6VEnpCNpBzfhoxWj7XIQvXq/L5jVVY
         c0jwp9ep7BOVcfBzE+86ZiosAiueFgDObzPNZ+22IBcy7rV0eRdGHBm4wHbwupv44xBR
         Vf9rN7t7lfn2qDUWfZgt2Z2AoE4QuPVjxH5LZ+rM5sSg7oanQzV3dAAo4dlBV9qFz2ts
         FDV5t5AJcYdfFm2/2pHYbS/583Se8yBw/BTzt0hsgA3R3sGnrcze7grceATNiKcaXiGD
         jX4AYImhSUM1G3ugcMnBTCz5nmDQoEwY/9YcI2pxX0dvM8JOowvORed7S8lqTLT91Rb4
         YYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=py5jadEhyBO1b4EZFvlp+DwXK4QiPt6j1BJjJI8IRy8=;
        b=TlVM0Uoq9XEmkYlNYSOqOeheQZX6rKdNNc70xG0FoYcopoy/q/K2w7h1saG/ncz3/9
         JmRmT5sS9bkVveOXRSt1G/WhPgh3z9bXUccHJO3MTqAilJaulUgEjP1YToEz/F+sBoMn
         8rgUE6V6Q1ztJSADO61SpWS0i6bR2YQJ6wzbsDMnmXC2DzGtG2RRMuaosbzNfGYZ5UIA
         cpgX9vpp5GKAIec7YUA8Pd5/FnO0gPpy88Ikq+7MnL8qGdm+ofX3RXP99WxJz4eeIl2Q
         PmDk/kvds8//GCQTa7F1kieot2zeZHwkDVaSEdxFigkvU33ik8pXJ//1sazEsAAwgNio
         z7cA==
X-Gm-Message-State: APjAAAXLvujmAAjQYD/8xqriPxlIsUFhUG/OS0ZqpkyhWqY/8CIDbp2A
        BpGCvl5eTeYU7/L4O9Tosxmf3icajeAt9XtnKjV/3w00+Zo=
X-Google-Smtp-Source: APXvYqxdJIvQQpgXZ4m9E9I1/d07p3l/4XxNXsrhOS0Gr8wm/bl2vp8y0yH6X1h//h8Drs5eD3XQ7Ne5Rxznt5gOPeg=
X-Received: by 2002:a92:51:: with SMTP id 78mr58189836ila.121.1582519311581;
 Sun, 23 Feb 2020 20:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221201545.1244861-1-kolyshkin@gmail.com> <20200223050557.6380-1-matheus.bernardino@usp.br>
In-Reply-To: <20200223050557.6380-1-matheus.bernardino@usp.br>
From:   Kirill Kolyshkin <kolyshkin@gmail.com>
Date:   Sun, 23 Feb 2020 20:41:40 -0800
Message-ID: <CAGmPdrxRNVSvQYzOx9-nhtztGgS_q92y3GO8n1nqRE5UJWiQRg@mail.gmail.com>
Subject: Re: [PATCH v2] completion: add diff --color-moved[-ws]
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, gitster@pobox.com,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 22 Feb 2020 at 21:06, Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> Hi, Kir
>
> On Fri, Feb 21, 2020 at 5:15 PM Kir Kolyshkin <kolyshkin@gmail.com> wrote:
> >
> > These options are available since git v2.15, but somehow
> > eluded from the completion script.
> >
> > Note that while --color-moved-ws= accepts comma-separated
> > list of values, there is no (easy?) way to make it work
> > with completion (see e.g. [1]).
>
> This puzzled me for some time, but I think I finally got a way to make the
> comma-separated completion work. Bellow is the code that does the trick,
> together with some tests for the new __gitcomp_cvs function. The diff is on top
> of your patch, so you can incorporate it for a v3. Alternatively, if you want
> to send these changes as a preparatory patch in a two-patches series, you have
> my Signed-off-by :)

Thanks! I played with it, and I can't say I like it. The issues I see are:

1. It does not suggest a comma, so it doesn't work as "discovery mode".
What I mean by it is, in general, bash completion does one thing beyond
the completion itself -- it also helps a user to discover the
synopsis, i.e learn
what command and options are available (same as menus in GUI apps).

2. It's not smart enough to not repeat the option that is already there,
i.e. if you type git diff --color-mode-ws=ignore-space-at-eol,<Tab>
it will offer ignore-space-at-eol again, which in this case doesn't make
much sense.

3. (this is not about the __gitcomp_csv, but rather about the way
--color-moved-ws option arguments work) Some values for --color-moved-ws
are not meant to be used together with others, e.g. --color-moved-ws=no
is exclusive, and it looks like allow-indentation-change is exclusive, too.
Others are more complicated, e.g. ignore-space-change "includes"
ignore-space-at-eol so once the former is set, it does not make sense
to suggest the latter. Even coding all these rules (what makes sense
with what, and what doesn't) sounds a bit too complicated.

So, all of the above makes me think that maybe it doesn't make
much sense to have csv completion at all.

>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 348f0c0c57..e12f90b1cb 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -476,6 +476,41 @@ __gitcomp_file ()
>         true
>  }
>
> +# The following function is based on
> +# https://unix.stackexchange.com/a/176442 (under CC BY-SA 4.0) written
> +# by diffycat (https://unix.stackexchange.com/users/17452/diffycat)
> +#
> +# Call __gitcomp for options that accept a comma separated list of values, i.e.
> +# something like '--option=val1,val2'. The caller must have already checked
> +# that `$cur == --option=*`. __gitcomp_csv requires two arguments:
> +# 1: The option in the format of '--option='
> +# 2: The list of possible values for the said option, separated by spaces. Note
> +#    that the values cannot contain commas or spaces.
> +__gitcomp_csv ()
> +{
> +       local cur_values="${cur##$1}" available_values
> +
> +       # Filter out already used values from completion reply
> +       for value in $2
> +       do
> +               if ! [[ ",$cur_values," =~ ",$value," ]]
> +               then
> +                       available_values="$available_values $value"
> +               fi
> +       done
> +
> +       local prefix pattern
> +       if [[ "$cur_values" == *,* ]]
> +       then
> +               prefix="${cur_values%,*},"
> +               pattern="${cur_values##*,}"
> +       else
> +               pattern="$cur_values"
> +       fi
> +
> +       __gitcomp "$available_values" "$prefix" "$pattern"
> +}
> +
>  # Execute 'git ls-files', unless the --committable option is specified, in
>  # which case it runs 'git diff-index' to find out the files that can be
>  # committed.  It return paths relative to the directory specified in the first
> @@ -1532,7 +1567,7 @@ _git_diff ()
>                 return
>                 ;;
>         --color-moved-ws=*)
> -               __gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
> +               __gitcomp_csv "--color-moved-ws=" "$__git_color_moved_ws_opts"
>                 return
>                 ;;
>         --*)
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 5505e5aa24..75b6afe2b7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -122,6 +122,21 @@ test_gitcomp_nl ()
>         test_cmp expected out
>  }
>
> +# Test __gitcomp_csv
> +# Arguments are:
> +# 1: current word (cur)
> +# -: the rest are passed to __gitcomp_csv
> +test_gitcomp_csv ()
> +{
> +       local -a COMPREPLY &&
> +       sed -e 's/Z$//' >expected &&
> +       local cur="$1" &&
> +       shift &&
> +       __gitcomp_csv "$@" &&
> +       print_comp &&
> +       test_cmp expected out
> +}
> +
>  invalid_variable_name='${foo.bar}'
>
>  actual="$TRASH_DIRECTORY/actual"
> @@ -580,6 +595,21 @@ test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name
>         __gitcomp_nl "$invalid_variable_name"
>  '
>
> +test_expect_success '__gitcomp_csv - display all values' '
> +       test_gitcomp_csv "--opt=" "--opt=" "val1 val2 val3" <<-\EOF
> +       val1 Z
> +       val2 Z
> +       val3 Z
> +       EOF
> +'
> +
> +test_expect_success '__gitcomp_csv - do not display values in $cur' '
> +       test_gitcomp_csv "--opt=val1," "--opt=" "val1 val2 val3" <<-\EOF
> +       val1,val2 Z
> +       val1,val3 Z
> +       EOF
> +'
> +
>  test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from config file' '
>         cat >expect <<-EOF &&
>         remote_from_file_1
>
> --->8---
>
> > [v2: added missing ignore-space-change]
>
> Change logs are quite useful for reviewers, so thanks for adding one :) However,
> they don't really need to be part of the commit message. So the common place to
> write them is between the '---' line and the diff stats. Everything you write
> in this section will be available for reviewers but discarded when the patch is
> applied.
>
> > Acked-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
>
> If you are going to send a v3, please, also use
> "Matheus Tavares <matheus.bernardino@usp.br>" instead (that's just how I
> normally sign).
>
