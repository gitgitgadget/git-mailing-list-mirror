Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0EFC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F196103E
	for <git@archiver.kernel.org>; Sun, 30 May 2021 06:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhE3GUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 02:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhE3GUU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 02:20:20 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39C5C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:18:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b5so7152817ilc.12
        for <git@vger.kernel.org>; Sat, 29 May 2021 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIIogyhmoJojuibJ8LR9iA/o95vzX6RwbxuM0lP6gOc=;
        b=rX2qTG0vwGczTZtjyHA/URcZXJiAcP0Av9wpkKuA/vRDsPal6gCccqP17Md42R/HSF
         iJlvqHUPUSkIDDCziIpDz8Gtn+Qrr3BIev6KYTg7QWqa587c0mpbPSb8vSuUu5LaD0hm
         hNsoIqGM3j3Q+tZhoatGFyQpwTfmPNsPf/SKKP4KAujGM3h7UzWfaZoS11NnDuNJtEiy
         KIb0qaxYB4FhbDvX+4wCpV4G3N44/Z0/TIEoMfm899I3V/pM+qmbtSHT9wFoHh8RmGjD
         2xHgPwGK/mxylQHjiHzH8G4lSTnegSzIEAOiUx46vwLmAkD6AZx/wsf3QELxMhvTN1Ef
         wMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIIogyhmoJojuibJ8LR9iA/o95vzX6RwbxuM0lP6gOc=;
        b=NAcJO0dRxoOC92hSLuH+grXG6DlSljPtCz934wx1UY+b16SXPSUWFWFQ/iu7mu2z37
         hTd+/lnVXFNXqu73KD9HGpdZYt8sRybwLMRaf8joQJ2P/yBuagU7Inj9Q+OuA27heF6j
         7tiVvIxA4xb29br/PrFmWzAHrJpcYFFsI3t61vrLAFGP+oFdAAc1Qzoz3Q5Pu+mZclut
         D4TKgnz+1S+oiev47V1DXGtee/6x674Tr2jn0TqMbGLyM0FRS9pSvbx0UUTxftW8iUrV
         JTSzi/atSKsV9Ng6Hh9g8G+6ZpYicMH4nMM/ecH0CkZTCIrPod6fWQZoegQToYkW6OiQ
         NQqQ==
X-Gm-Message-State: AOAM5327tf+/5TPoacr3rbqCHeB/mlcL7wsn4zmL6YNCHHkHYi05LyCP
        izuI1jTCOYMK3AHvv2zEcIoiNKhwWqtXvoO3mu4=
X-Google-Smtp-Source: ABdhPJxAp3xTM2pkEnXTUHMkRRC1ZWAe0JNzwL+f2vRs3rQ76w4yKBQZLmLtpdW+Ta7R21jCHeTtYF7otEFCVrAqdps=
X-Received: by 2002:a05:6e02:1541:: with SMTP id j1mr13399099ilu.146.1622355517378;
 Sat, 29 May 2021 23:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210530021528.21287-1-davvid@gmail.com> <60b30b159bda0_50fd208ee@natae.notmuch>
In-Reply-To: <60b30b159bda0_50fd208ee@natae.notmuch>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 29 May 2021 23:18:01 -0700
Message-ID: <CAJDDKr7rVpnCgMEbw4aeLXrUWMxV=sOYNCUn-2o69FgpbU3XwA@mail.gmail.com>
Subject: Re: [PATCH] contrib/completion: avoid empty arithemetic expressions
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 29, 2021 at 8:48 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> David Aguilar wrote:
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 3c5739b905..d51ff5302d 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1177,6 +1177,9 @@ __git_aliased_command ()
> >  __git_find_on_cmdline ()
> >  {
> >       local word c="$__git_cmd_idx" show_idx
> > +     if [ -z "$c" ]; then
> > +             c=1
> > +     fi
>
> This is not the correct location to fix this, it's here:
>
> diff --git a/git-completion.zsh b/git-completion.zsh
> index 0ef15ff..df98e68 100644
> --- a/git-completion.zsh
> +++ b/git-completion.zsh
> @@ -233,7 +233,7 @@ __git_zsh_main ()
>                 emulate ksh -c __git_complete_config_variable_name_and_value
>                 ;;
>         (arg)
> -               local command="${words[1]}" __git_dir
> +               local command="${words[1]}" __git_dir __git_cmd_idx=1
>
>                 if (( $+opt_args[--bare] )); then
>                         __git_dir='.'
>
> Commit 59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more
> places, 2021-04-22) broke zsh because it modified __git_main, but not
> __git_zsh_main.
>
> Cheers.
>
> --
> Felipe Contreras

Sweet, thanks Felipe.

The resulting patch is much simpler now too. Please disregard the
previous patches, v2 is on the way.
-- 
David
