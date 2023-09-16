Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F3ACD37BC
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 13:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjIPNbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjIPNbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 09:31:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C4195
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 06:31:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso396962066b.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694871064; x=1695475864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpSoQyfdzHZ6MUhjDeUY2/p7uUmLmIt12ORarAwQfis=;
        b=SxY2GQx2GA4maWhk0tJ00E5qCwscMHTqKfy/K4Jey4HO5rh/T6ny8jovdgoCIBzJPf
         Vava98vBDzPc6dOyxCbMzFe3qsVfCGdln0aDjYBxQip+t0m95iV9DMhlsP6PIfD71fdJ
         Z4uYDglTL3I6tdqooxpA8VicHLuoqNqLR8Y7Kvlq9JMmJb4x/17+LX2oGr3Po+H9y2wV
         669v7HM0NG6EQ7SI3lBw9d9r7R/RaKUezP7UMvYRD80b3EYBmMy+Z86+eS8btEZ39c0i
         dyVWQ07HQ7XjC/CJskDYfvEKhsN+suZHqs05P5Sh2VBfie+RuaxbNZYWeJpmqXhQH/0I
         G1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694871064; x=1695475864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpSoQyfdzHZ6MUhjDeUY2/p7uUmLmIt12ORarAwQfis=;
        b=QrZC0g/VncsbpmrMxItI5iiKvptkWrPC/s4TJWbAaQwAXDgHrLez7wt24isPGmD4/j
         d3epm1U2Ndsua/F7kqWuoV5cex4xqPB2NWPgEdUI40oLV7s9Vvkw45u6b7IvasRj/bOd
         HvKJ7vDpypnLPahVEWzh4VL/jvvM6ORIJP+F58ChNf5/XbGHIsmTWn1eKSO65CIWfpjr
         2tVDeoob70I006d8xb9vkctkjEHLlgB9vmvljYbmxKD9Rrl5+MBswapzmODHhVJv+Kpn
         TX08W4DxwfiEBY4uDb7TuPnpTY78x8pOOgZQrakYA6W705w/afebbvelKGcIFyidGS57
         mabQ==
X-Gm-Message-State: AOJu0Yw8Lh/SJ3FUGD/vQxvAmH5bX57uCI6U1hlqA0jqObGl6c9FPGHK
        LMEZkj63aPpsHqG89kqKHPWJs3ChwJrKzVOlR0s=
X-Google-Smtp-Source: AGHT+IF+1okJ/m3cUoMl/Igx/aAhRe0FNzPfboNRY0QlTZsW4rg0ZPBW/xzWodApy+eS6o0cG8sy/vQumPjZygOS0lA=
X-Received: by 2002:a17:906:1baa:b0:99d:ed5e:cc79 with SMTP id
 r10-20020a1709061baa00b0099ded5ecc79mr3756910ejg.31.1694871064174; Sat, 16
 Sep 2023 06:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
In-Reply-To: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 16 Sep 2023 21:30:52 +0800
Message-ID: <CAOLTT8SxSXgHxQiT4LYy2kKBpwwRPvJguukKS36GOm73JbtzRQ@mail.gmail.com>
Subject: Re: [PATCH] completion: commit: complete configured trailer tokens
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the improvement, I believe this interactive mode with tab
completion will be very useful.

Philippe Blain via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=
=B9=B49=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=94 01:42=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
> commit' can add trailers to commit messages. To make that feature more
> pleasant to use at the command line, update the Bash completion code to
> offer configured trailer tokens.
>
> Add a __git_trailer_tokens function to list the configured trailers
> tokens, and use it in _git_commit to suggest the configured tokens,
> suffixing the completion words with ':' so that the user only has to add
> the trailer value.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     completion: commit: complete configured trailer tokens
>
>     Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
>     commit' can add trailers to commit messages. To make that feature mor=
e
>     pleasant to use at the command line, update the Bash completion code =
to
>     offer configured trailer tokens.
>
>     Add a __git_trailer_tokens function to list the configured trailers
>     tokens, and use it in _git_commit to suggest the configured tokens,
>     suffixing the completion words with ':' so that the user only has to =
add
>     the trailer value.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1583%2F=
phil-blain%2Fcompletion-commit-trailers-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1583/phil-=
blain/completion-commit-trailers-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1583
>
>  contrib/completion/git-completion.bash | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 133ec92bfae..b5eb75aadc5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1677,6 +1677,11 @@ _git_clone ()
>
>  __git_untracked_file_modes=3D"all no normal"
>
> +__git_trailer_tokens ()
> +{
> +       git config --name-only --get-regexp trailer.\*.key | awk -F. '{pr=
int $2}'
> +}
> +
>  _git_commit ()
>  {
>         case "$prev" in
> @@ -1701,6 +1706,10 @@ _git_commit ()
>                 __gitcomp "$__git_untracked_file_modes" "" "${cur##--untr=
acked-files=3D}"
>                 return
>                 ;;
> +       --trailer=3D*)
> +               __gitcomp_nl "$(__git_trailer_tokens)" "" "${cur##--trail=
er=3D}" ":"
> +               return
> +               ;;
>         --*)
>                 __gitcomp_builtin commit
>                 return
>
> base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
> --
> gitgitgadget
