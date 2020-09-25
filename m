Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10526C4727C
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B196A21775
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lajj4Zco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgIYWyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIYWyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:54:05 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B3C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 15:54:05 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id e5so143187vkm.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k6GSn2XxvKQouL+bvyK9hyxQM8aI3+je4qlOXLbitxI=;
        b=Lajj4ZcothnTMjVmn7gPLTm2qqfrDGEEQw5+XRzIH8u3xbhq5ApXxk4M+G/Ld1jWX+
         thODWetqsoiVGa51U4JWaOEwM/UmoC+0ZxhD6dfu7/RUL3CiV6hsroHrJqnNJGdzSZVv
         w18hxnuLaYkDekEm4jRFlgAWyqfyNShYkrXjs/vghKRRYyfb7UZLcrSi5oGegtXZim67
         FzWP4vBeGHDJhrZMS86KVujExQnhrB5L8RPYPQmtUR3p2fCx2lcKgNzbXZDMpL5IcI0+
         1WWom5TXqTJMde1sNmN0Cv0GnetqCWpqAxkd1ZE0yudHUp2Qz/duo5iFeXYjen8Qk/Od
         hcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k6GSn2XxvKQouL+bvyK9hyxQM8aI3+je4qlOXLbitxI=;
        b=uMYqNlh66JfBAP3YYfd3CQR35eQ5VLDuRkdKsmIlK6w/aiIvNVH4l/A1vuKI5/A3Zo
         6uSB+HgNDXCjIcK0SCp00wU2C3fmONe5rK6LFpv18QxEcuUbTo6MTlkc2dpcy5dc7Uy1
         ior7hEEuEVnuuBZfZh31EnA4wfRDHoIizMiHzHk8m09OoMBgiWm7giSg0Y/7B3bJRTHX
         kNsXmq6vkpwZq88p9aqOyXbyOtD8ed2bvuDPZSN6/bH+epYK885Mh+kEscaVstdrpvlu
         Jj6/JRAIXHH/zDNNr4pNWQp9C7pWdfDvbY1aHqrMoDYBOybIm/Y7NNt2X8376OQJ4Hxa
         ek3g==
X-Gm-Message-State: AOAM533tBb19g4hUM/GpzagDoeUUaKBMNvfPo5yCaBt2g276w54HaeTx
        MlOfIcRMUpfpDC1vYRCCqUyz4q3EjQwRR/jTGiw7F2EvK+A=
X-Google-Smtp-Source: ABdhPJyfmcu88BpCdNc7kE8+lwugCTFQbg0RMJTilXrqxSuUvLW3JPVcHc1vowKD/uDw28uc/yMXkyeGP3q+pwDRDw0=
X-Received: by 2002:a1f:7886:: with SMTP id t128mr487982vkc.17.1601074444461;
 Fri, 25 Sep 2020 15:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200925211124.1673337-1-uzonyi.akos@gmail.com>
In-Reply-To: <20200925211124.1673337-1-uzonyi.akos@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 25 Sep 2020 15:53:53 -0700
Message-ID: <CA+P7+xrBcKpDgFfDyp8=f_AaqqcVzjo3MV38=6geJ6bavZSTDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] completion: use "prev" variable instead of
 introducing "prevword"
To:     =?UTF-8?B?w4Frb3MgVXpvbnlp?= <uzonyi.akos@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 3:00 PM =C3=81kos Uzonyi <uzonyi.akos@gmail.com> wr=
ote:
>
> In both _git_checkout and _git_switch a new "prevword" variable were
> introduced, however the "prev" variable already contains the last word.
>
> The "prevword" variable is replaced with "prev", and the case is moved
> to the beginning of the function, like it's done in many other places
> (e.g. _git_commit). Also the indentaion of the case is fixed.
>

Ahhh... didn't realize $prev existed.

> Signed-off-by: =C3=81kos Uzonyi <uzonyi.akos@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 66 +++++++++++++-------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 8be4a0316e..3d02bd4de7 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1508,6 +1508,22 @@ _git_checkout ()
>  {
>         __git_has_doubledash && return
>
> +       local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
> +
> +       case "$prev" in
> +       -b|-B|--orphan)
> +               # Complete local branches (and DWIM branch
> +               # remote branch names) for an option argument
> +               # specifying a new branch name. This is for
> +               # convenience, assuming new branches are
> +               # possibly based on pre-existing branch names.
> +               __git_complete_refs $dwim_opt --mode=3D"heads"
> +               return
> +               ;;
> +       *)
> +               ;;
> +       esac
> +
>         case "$cur" in
>         --conflict=3D*)
>                 __gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
> @@ -1516,23 +1532,6 @@ _git_checkout ()
>                 __gitcomp_builtin checkout
>                 ;;
>         *)
> -               local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
> -               local prevword prevword=3D"${words[cword-1]}"
> -
> -               case "$prevword" in
> -                       -b|-B|--orphan)
> -                               # Complete local branches (and DWIM branc=
h
> -                               # remote branch names) for an option argu=
ment
> -                               # specifying a new branch name. This is f=
or
> -                               # convenience, assuming new branches are
> -                               # possibly based on pre-existing branch n=
ames.
> -                               __git_complete_refs $dwim_opt --mode=3D"h=
eads"
> -                               return
> -                               ;;
> -                       *)
> -                               ;;
> -               esac
> -
>                 # At this point, we've already handled special completion=
 for
>                 # the arguments to -b/-B, and --orphan. There are 3 main
>                 # things left we can possibly complete:
> @@ -2392,6 +2391,22 @@ _git_status ()
>
>  _git_switch ()
>  {
> +       local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
> +
> +       case "$prev" in
> +       -c|-C|--orphan)
> +               # Complete local branches (and DWIM branch
> +               # remote branch names) for an option argument
> +               # specifying a new branch name. This is for
> +               # convenience, assuming new branches are
> +               # possibly based on pre-existing branch names.
> +               __git_complete_refs $dwim_opt --mode=3D"heads"
> +               return
> +               ;;
> +       *)
> +               ;;
> +       esac
> +
>         case "$cur" in
>         --conflict=3D*)
>                 __gitcomp "diff3 merge" "" "${cur##--conflict=3D}"
> @@ -2400,23 +2415,6 @@ _git_switch ()
>                 __gitcomp_builtin switch
>                 ;;
>         *)
> -               local dwim_opt=3D"$(__git_checkout_default_dwim_mode)"
> -               local prevword prevword=3D"${words[cword-1]}"
> -
> -               case "$prevword" in
> -                       -c|-C|--orphan)
> -                               # Complete local branches (and DWIM branc=
h
> -                               # remote branch names) for an option argu=
ment
> -                               # specifying a new branch name. This is f=
or
> -                               # convenience, assuming new branches are
> -                               # possibly based on pre-existing branch n=
ames.
> -                               __git_complete_refs $dwim_opt --mode=3D"h=
eads"
> -                               return
> -                               ;;
> -                       *)
> -                               ;;
> -               esac
> -
>                 # Unlike in git checkout, git switch --orphan does not ta=
ke
>                 # a start point. Thus we really have nothing to complete =
after
>                 # the branch name.
> --
> 2.28.0
>
