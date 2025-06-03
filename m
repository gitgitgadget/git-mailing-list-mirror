Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28417C224
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983368; cv=none; b=RuDIs6v3YV521jDjyvEDaNtNwcUJJx/VmAfKgb1k735qDRj6C0Aa4rsZGQbBFQc5aSfHeDG1r+EhgPtCaSjR2ACzvAItoVJrpmCQUQJFa5ljKj1qHfXQ7yzt+p/NoEQa/fnKkmxAUbbRCko8Hd/JCSdGZTYnBC8+WuD4kzpJQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983368; c=relaxed/simple;
	bh=SthS5Wny+XJff8aDLI6vNUQ2WE6cf2cvU6aDXXIaIZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gncR87826g+uWDdLbzIFwP9IK/MGFHg1nYwEkPT48YjRGC1Nw0iavg0XsHvyGdG9kgU726IKGCJBosyLTu0pAw4K/2hstruODK30KhNoyh+nu+k99Xp960MY8kHwPGQpie74AHC8SeZjE93mA3EeoV/6rn7zv1oZ6fW8sHbkPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbLAeSVS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbLAeSVS"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so938746466b.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748983365; x=1749588165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO6aoYEE7Quf0oDSm0nRVV5di+kasb2hFP3fkQ5r6es=;
        b=ZbLAeSVSs9rNW12R4PUb7/9J3q/UC/IWjs2AezahTuVve8IA1wvp9UrusI3CAvYedk
         Lx1TUr9xYzhOflEY9QrUj4yUqcVsmM3nRwx88M88LU19+TMv6wHYsLLW6S85l3Z3fuLg
         a9Y0IisTSgrYc+Je2Esx7tyXYUVZ3eZpgmW+3xptrZjwF7HkAXsnBxQ/elhh8dg71Lu6
         bD3b0JNS00mk60rTQtYs4EZgEKB9PJmsm/MTN0oPl6/bUWItXc1FGZ1eBnLYWyCuE7nl
         y/twyM7W9+TwriK3qOMYQkLKJeD4HNvvS0c5MzjJlPsL7p8SQ1o1LWhU9pY4nYrkrY1o
         1LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983365; x=1749588165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO6aoYEE7Quf0oDSm0nRVV5di+kasb2hFP3fkQ5r6es=;
        b=mRo1puXxIKQ1QqVnBTCNbprq+rRyXG8ucsiIfbBRt0g5LDBbi/SvXn7/OihoqhxBkH
         KraRC0UXC5IzTp+uL9NdsUyvCjo44cg7nf52BtIZLE6jJiECElezgEdsI/uqrw4eoTas
         wmZ3dIi3KtXDUJNL/XDxLhVi0T4vsI/w97T4VMoYgipTyoXLQ7c9XS/fwrlKrXErixUY
         mbrbuGBrHrBZCFJantp8gW3ulS4cUSaecBlOhC7u40X8veWaprlG/B2CUQi6J28ymwZS
         ZaDFPeABqW8EKCUyZy6dL/a+WP0ulzZ/E7/iCEOllcJ2ztMTDGI52c7JqVRmfK3q4Kwu
         gX2g==
X-Gm-Message-State: AOJu0YxamFupqijnE3KH7o+e/K4Tg7Gr+1Ap5U7zpg9w19coOnov8LcE
	399JYUnmWc9U14KNwkW/IXLLR38HvJ2V6ySqOaEyN3qhPxVLYDSX2AonfA7HQQKsxpYf7zsgNxB
	ZsCTo9vJ6k5zeVZPa9qwi6kBeBVzWQgYXJYRLvfg=
X-Gm-Gg: ASbGnctcsSBM+joQEokIDJX7hkOiSPp11O4TCRqIIeP1T8MOWE4rsATd+eM7bDn9DcS
	KX0wJBq05v+bZ/Icks2y2hUTwyT1cnMz14Adwpof68gVDGd1QgCtsLH6iwG0knuCqd/LgY7H1aQ
	jrseHVI60/hr0IP40LSLCh+8L8M5W5w/W9EXRFkF+vUte6wVQfY5zW+/dH4yMo8+x12KKWZAP6g
	PxWQWPiO9lJk2s=
X-Google-Smtp-Source: AGHT+IGU6EhXSh01ve9qWsziUytvDznNvpHeC+4v5tyJ4tOR0Z90gOth2/6D/XDwEGxZtS6oD0TukPEBmQ4dIRnSsiI=
X-Received: by 2002:a17:907:6ea6:b0:ad8:9645:7965 with SMTP id
 a640c23a62f3a-adb49510b75mr1124781466b.42.1748983365097; Tue, 03 Jun 2025
 13:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1928.git.1748882439.gitgitgadget@gmail.com> <fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
In-Reply-To: <fe7e918ba1831fffead46791441da350223998f7.1748882439.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 3 Jun 2025 16:42:34 -0400
X-Gm-Features: AX0GCFuwwNSOH7ub_Pm9NwyNOdnWOD7xTmwqLacli3bwf_9NvqbrHo1SBMEd4M0
Message-ID: <CALnO6CDk4cP1Mef07F6Z8Sm-1MxwWWd-rYEfL-e5_Nnq50B4ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] contrib/subtree: parse using --stuck-long
To: Patrik Weiskircher via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, apenwarr@gmail.com, 
	Junio C Hamano <gitster@pobox.com>, Patrik Weiskircher <patrik@pspdfkit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 12:41=E2=80=AFPM Patrik Weiskircher via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Patrik Weiskircher <patrik@pspdfkit.com>
>
> -S/--gpg-sign requires an optional parameter. Optional parameter
> handling only works unambiguous with git rev-parse --parseopt when using
> the --stuck-long option.

Here we mention "-S", but that flag isn't implemented yet, right?

Perhaps something like:

    Optional parameter handling only works unambiguous with git rev-parse
    --parseopt when using the --stuck-long option. To prepare for future co=
mmits
    which add flags with optional parameters, parse with --stuck-long.

>
> Signed-off-by: Patrik Weiskircher <patrik@pspdfkit.com>
> ---
>  contrib/subtree/git-subtree.sh | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree=
.sh
> index 15ae86db1b27..60b2431b8bba 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -115,7 +115,7 @@ main () {
>         then
>                 set -- -h
>         fi
> -       set_args=3D"$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@=
" || echo exit $?)"
> +       set_args=3D"$(echo "$OPTS_SPEC" | git rev-parse --parseopt --stuc=
k-long -- "$@" || echo exit $?)"
>         eval "$set_args"
>         . git-sh-setup
>         require_work_tree
> @@ -131,9 +131,6 @@ main () {
>                 opt=3D"$1"
>                 shift
>                 case "$opt" in
> -                       --annotate|-b|-P|-m|--onto)
> -                               shift
> -                               ;;
>                         --rejoin)
>                                 arg_split_rejoin=3D1
>                                 ;;
> @@ -177,42 +174,37 @@ main () {
>                 shift
>
>                 case "$opt" in
> -               -q)
> +               --quiet)
>                         arg_quiet=3D1
>                         ;;
> -               -d)
> +               --debug)
>                         arg_debug=3D1
>                         ;;
> -               --annotate)
> +               --annotate=3D*)
>                         test -n "$allow_split" || die_incompatible_opt "$=
opt" "$arg_command"
> -                       arg_split_annotate=3D"$1"
> -                       shift
> +                       arg_split_annotate=3D"${opt#*=3D}"
>                         ;;
>                 --no-annotate)
>                         test -n "$allow_split" || die_incompatible_opt "$=
opt" "$arg_command"
>                         arg_split_annotate=3D
>                         ;;
> -               -b)
> +               --branch=3D*)
>                         test -n "$allow_split" || die_incompatible_opt "$=
opt" "$arg_command"
> -                       arg_split_branch=3D"$1"
> -                       shift
> +                       arg_split_branch=3D"${opt#*=3D}"
>                         ;;
> -               -P)
> -                       arg_prefix=3D"${1%/}"
> -                       shift
> +               --prefix=3D*)
> +                       arg_prefix=3D"${opt#*=3D}"
>                         ;;
> -               -m)
> +               --message=3D*)
>                         test -n "$allow_addmerge" || die_incompatible_opt=
 "$opt" "$arg_command"
> -                       arg_addmerge_message=3D"$1"
> -                       shift
> +                       arg_addmerge_message=3D"${opt#*=3D}"
>                         ;;
>                 --no-prefix)
>                         arg_prefix=3D
>                         ;;
> -               --onto)
> +               --onto=3D*)
>                         test -n "$allow_split" || die_incompatible_opt "$=
opt" "$arg_command"
> -                       arg_split_onto=3D"$1"
> -                       shift
> +                       arg_split_onto=3D"${opt#*=3D}"
>                         ;;
>                 --no-onto)
>                         test -n "$allow_split" || die_incompatible_opt "$=
opt" "$arg_command"
> --
> gitgitgadget
>
>


--=20
D. Ben Knoble
