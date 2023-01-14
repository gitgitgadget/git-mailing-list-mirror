Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E3C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjANI16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjANI1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:27:54 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6259F1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:27:51 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id a9so8313187ybb.3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOuBE5qFBiM/KiVzc6EAeaQjcgtBUdEP4gtRQ2ixl3g=;
        b=SMhTDrpFXt11JY7XfHdX4vjm9ydPmmglvRqS3JlB7/39jXK2CX9WCArJURn8fF0/TJ
         uiqEPXk5tA3M8EuXHutimmeAonKbuYJk5eGdxINsRVC4UAKBRjlQ9T4Z86NH4JjLl39s
         RpPmJRq7WpLWWeGXIraKveo+f3Qgg2zXGNG0i+SS8FrtOL4QTQyl7pB7KFK4Fu58OoE7
         TzxuIAiTEDbldzVgnmUUmI2KfiN4lC+PH61whuzOZinTNCldA8r6CjmteLs/OiaQfR1h
         25nhtbTMYY351iW/zDqTCfir+vG2NCtKEdg2S3lYH4Y1BVjONK8AxN/GbFAitZ2dn80P
         LC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOuBE5qFBiM/KiVzc6EAeaQjcgtBUdEP4gtRQ2ixl3g=;
        b=JWZ0ZFuZgpC5GbwMry1294jMmQr19T3lb7G973EHalizjzeuaaHTc/xEDEbE5T+sUL
         NDRtGRwI615jr1tpl1EO/OsSTgeRpcwVEVMkiK1B/ld3xxYcvyp32mgD5JCwQWVxw0Hn
         KPG9O+ciO0T2b5RdSa/4aIrVJSpvr9mHYLaqUFxocc+jM/zZdQN1XISVfDRJhDQFbzS9
         yL4tv/l8kSS6PkpG9NynYgHvrRa7ZVy+lSRTGTJ6RuBVxZLFpvLRJchHoNX1LWLXqFJT
         9sBIH319RkHU7qdGQcXxrNhFfq0UbUg+eFhzXX4OM8op54jJYlpdgrIfKvNuFaODzzsf
         HCtw==
X-Gm-Message-State: AFqh2kr9mjQ6KUMa9eLPgqx8g3CqKh01czK3zjrzsMjaGkj4v0BdBem+
        CKFWWxOKDRDInUA4qjW/MuE0tzlFWTHI9riwQ7rGYUlOTvM=
X-Google-Smtp-Source: AMrXdXu76IG1aTup9GZAArqN1quy7UCslM+pVR8oTgqa+PirWAxJzShmrBPGopc+vEaUaOd+i0bkKhXNElQlm8VrGe0=
X-Received: by 2002:a25:f408:0:b0:7b1:e4c5:fd37 with SMTP id
 q8-20020a25f408000000b007b1e4c5fd37mr2889201ybd.561.1673684827241; Sat, 14
 Jan 2023 00:27:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1463.git.1673584914.gitgitgadget@gmail.com> <26406a4d8797e68f0ba4fe097cf0973f60d67114.1673584914.git.gitgitgadget@gmail.com>
In-Reply-To: <26406a4d8797e68f0ba4fe097cf0973f60d67114.1673584914.git.gitgitgadget@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 16:26:55 +0800
Message-ID: <CAOLTT8RXgw0CC7TBUunCPnnk1=5gKkyYZcFQyWu29QM9bn9s9w@mail.gmail.com>
Subject: Re: [PATCH 3/4] ls-files: clarify descriptions of status tags for -t
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2023=E5=B9=
=B41=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 12:41=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Elijah Newren <newren@gmail.com>
>
> Much like the file selection options we tweaked in the last commit, the
> status tags printed with -t had descriptions that were easy to
> misunderstand, and for many of the same reasons.  Clarify them.
>
> Also, while at it, remove the "semi-deprecated" comment for "git
> ls-files -t".  The -t option was marked as semi-deprecated in 5bc0e247c4
> ("Document ls-files -t as semi-obsolete.", 2010-07-28) because:
>
>     "git ls-files -t" is [...] badly documented, hence we point the
>     users to superior alternatives.
>     The feature is marked as "semi-obsolete" but not "scheduled for remov=
al"
>     since it's a plumbing command, scripts might use it, and Git testsuit=
e
>     already uses it to test the state of the index.
>
> Marking it as obsolete because it was easily misunderstood, which I
> think was primarily due to documentation problems, is one strategy, but
> I think fixing the documentation is a better option.  Especially since
> in the intervening time, "git ls-files -t" has become heavily used by
> sparse-checkout users where the same confusion just doesn't apply.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-ls-files.txt | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
> index f89ab1bfc98..3886d58d178 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -137,25 +137,27 @@ OPTIONS
>         with `-s` or `-u` options does not make any sense.
>
>  -t::
> -       This feature is semi-deprecated. For scripting purpose,
> -       linkgit:git-status[1] `--porcelain` and
> +       Show status tags together with filenames.  Note that for
> +       scripting purposes, linkgit:git-status[1] `--porcelain` and
>         linkgit:git-diff-files[1] `--name-status` are almost always
>         superior alternatives, and users should look at
>         linkgit:git-status[1] `--short` or linkgit:git-diff[1]
>         `--name-status` for more user-friendly alternatives.
>  +
>  --
> -This option identifies the file status with the following tags (followed=
 by
> -a space) at the start of each line:
> -
> -       H::     cached
> -       S::     skip-worktree
> -       M::     unmerged
> -       R::     removed/deleted
> -       C::     modified/changed
> -       K::     to be killed
> -       ?::     other
> -       U::     resolve-undo
> +This option provides a reason for showing each filename, in the form
> +of a status tag (which is followed by a space and then the filename).
> +The status tags are all single characters from the following list:
> +
> +       H::     tracked file that is not either unmerged or skip-worktree
> +       S::     tracked file that is skip-worktree
> +       M::     tracked file that is unmerged
> +       R::     tracked file with unstaged removal/deletion
> +       C::     tracked file with unstaged modification/change
> +       K::     untracked paths which are part of file/directory conflict=
s
> +               which prevent checking out tracked files
> +       ?::     untracked file
> +       U::     file with resolve-undo information
>  --
>

Good to see these tags describe are changed, especially "K" (reader
don't know what is "to be killed")

Maybe we should mention which option will output these tags?
e.g. default -> "H"/"S" ,`--other` -> "?", `--modified` -> "C",
`--killed` -> "K"...

>  -v::
> --
> gitgitgadget
>
