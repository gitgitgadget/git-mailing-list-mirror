Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D35481A3
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483419; cv=none; b=gmqm08rfPaV4nlKgp9dz8+mbVQpDNo5DgKq2blFevZt34xHCJgcrvat2m0eCsb8/eRA86Jy2+/aioITP9PKLfaoUapsiT+d/ue4x+9wb/1u7w5sn4ZfWUCysRvy+59ecQP8GOjlWiRPgeIwJWOcFfDco/Bff4Ibl1gHEfwjcb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483419; c=relaxed/simple;
	bh=Bw8GjuN5iyiMQZM9OFu+Hs4pE0DE0401P9xHbcutpjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhM894+m/T5/k/tmlFg+q/utIU1Pc4Jp5o5iRV84J495zVWvM8rLvtOgyB6NsKP1A93ZTOLDWyoUQicAsLfPMIiEI52AXJ9ZU3Z5b7WExqkPq6nd7nzmmL6M3H7R7rHSevUs6H4NC7mz4Tmrio9YDJwcVaV0P8Cwn3PBa0LJAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbHthqtk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbHthqtk"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29c75e348afso4351986a91.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711483417; x=1712088217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6nL3TxTAwRdqrSKOGiRwbDYS95p6dKtG+oYbucoZRU=;
        b=jbHthqtkKopZgh3CRRgPJgcTGdiLhKpOa7hVrvlriyhAf8D20zhf1C3RWN/ep2T+nZ
         Nusdxd1ysbBUwHCcKVzKSeouU7hfqry8va6eVcCPF7F3pv/6auzLEScFaJ6xado3ICJn
         xIcGHlqSVp1AaiCuh5W80PbHWZEw9EP/0MHA/Obxy/W3ySR/DHKvO81k06LcyqvC01z7
         5dtzSok5rZAkGNzluV2zTrdweujFCX4++7CmiZxi+RlbZTNcrvLVKYBUcokh7xXOrrhL
         9/1dBMGbhPAtF6Z9TRI6oyuPstmfRbDg205476C6BZXwj+RYFyzpuoHDXXWwj29JF+Sn
         GfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483417; x=1712088217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6nL3TxTAwRdqrSKOGiRwbDYS95p6dKtG+oYbucoZRU=;
        b=BeGwtHrFLydLyL0wyZXhqnu8Yxed0MJv0a692a7pHbgtjmUafDtsbRabOp924jjSiE
         u2iHCfuHoZ12ViTArahXNV5sG9mKnB72yeQy+RwnfU2SG/RG5LmIReyLklru/3AZ2GRJ
         SLX9idBHGp3wKm8/3jimk8cyjmlVueHwAkj9Ojqg/55+aUNElYsBBHqmZOHDIi2xXcc1
         R36qkjsuq+ErFt/9X2+Ew7JLctdwv2dC9YoTK+cmQVFFvymia2Ddh9jRKMEw/xwrbv+V
         Kdkatjw30tfNmjhv4Ern7PVFqiYfMSdkPFD6R6D8FaaZRnP13sugZ0cqmsGlpAoy7d9o
         Htag==
X-Gm-Message-State: AOJu0YxsjbebMEFgwqxAX4VFgjT3Vs1k5DN4csrXg7wlppUOtRIXnY5u
	b2sV367pbuoCn4ro8d11VxG7EG4tMSPO9h8mEkQ5alCZRDehmoX1/9ZsXSBLR2lsAmJsqYq0BYm
	t1ZSQoFxUINSAoLVV1V1zKpiLhts=
X-Google-Smtp-Source: AGHT+IFetTxc8pSb0xrWGT8CPJSHtQNPZ54YJosrNSQMOE2pbEvDdd4DIxxOiBynOzDLzb0Mohr92mYKJpPbwxe/k7I=
X-Received: by 2002:a17:90b:1107:b0:29d:51ce:607d with SMTP id
 gi7-20020a17090b110700b0029d51ce607dmr8416239pjb.27.1711483417198; Tue, 26
 Mar 2024 13:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com> <5ae83d3f799e9ab84d5233f77cb91715415ae167.1711318740.git.gitgitgadget@gmail.com>
In-Reply-To: <5ae83d3f799e9ab84d5233f77cb91715415ae167.1711318740.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Tue, 26 Mar 2024 21:03:25 +0100
Message-ID: <CAN0heSoSNxuoObvO_xtu1fXb+XYH+gBvVOWfJVBkpXouR0cmWQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: git-clone: apply new documentation guidelines
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for working on this. This renders really nicely.

On Sun, 24 Mar 2024 at 23:20, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Heavily apply literal and placeholder markup everywhere.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/config/clone.txt |  23 +++++--
>  Documentation/git-clone.txt    | 120 ++++++++++++++++-----------------
>  Documentation/urls.txt         |  22 +++---
>  3 files changed, 88 insertions(+), 77 deletions(-)
>
> diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.=
txt
> index d037b57f729..0e0a8a1ae4a 100644
> --- a/Documentation/config/clone.txt
> +++ b/Documentation/config/clone.txt
> @@ -1,13 +1,22 @@
> -clone.defaultRemoteName::
> +`clone.defaultRemoteName`::
>         The name of the remote to create when cloning a repository.  Defa=
ults to
> -       `origin`, and can be overridden by passing the `--origin` command=
-line
> +       `origin`.
> +ifdef::git-clone[]
> +       It can be overridden by passing the `--origin` command-line
> +       option.
> +endif::[]
> +ifndef::git-clone[]
> +       It can be overridden by passing the `--origin` command-line
>         option to linkgit:git-clone[1].
> +endif::[]

There's a bit more going on here than the commit message claims. FWIW, I
think these changes are good, even if maybe a bit surprising.

> -'git clone' [--template=3D<template-directory>]
> -         [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
> -         [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <reposi=
tory>]
> -         [--dissociate] [--separate-git-dir <git-dir>]
> -         [--depth <depth>] [--[no-]single-branch] [--no-tags]
> -         [--recurse-submodules[=3D<pathspec>]] [--[no-]shallow-submodule=
s]
> -         [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reje=
ct-shallow]
> -         [--filter=3D<filter> [--also-filter-submodules]] [--] <reposito=
ry>
> -         [<directory>]
> +`git clone` [`--template=3D`{empty}__<template-directory>__]
> +         [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--m=
irror`]
> +         [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--refe=
rence` _<repository>_]
> +         [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
> +         [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`=
]
> +         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]] [`--`[`no-=
`]`shallow-submodules`]
> +         [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] =
[`--`[`no-`]`reject-shallow`]
> +         [`--filter=3D`{empty}__<filter-spec>__] [`--also-filter-submodu=
les`]] [`--`] _<repository>_
> +         [_<directory>_]

Don't ask me why, but I need this on top (whitespace-damaged)

-         [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
-         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]]
[`--`[`no-`]`shallow-submodules`]
-         [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_]
[`--sparse`] [`--`[`no-`]`reject-shallow`]
+         [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`]
[`--no-tags`]
+         [`--recurse-submodules`[`=3D`{empty}__<pathspec>__]]
[`--`[`no-`]{empty}`shallow-submodules`]
+         [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_]
[`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]

i.e., some sprinkling of "{empty}", to keep each of these "[--[no-]"
from simply disappearing. This is with Asciidoctor 1.5.5, which is
admittedly starting to get old, but still ok as per our INSTALL
document.

> ---bare::
> +`--bare`::
>         Make a 'bare' Git repository.  That is, instead of
>         creating _<directory>_ and placing the administrative
> -       files in `<directory>/.git`, make the _<directory>_
> +       files in _<directory>_`/.git`, make the _<directory>_

This should be __<directory>__{empty}`/.git`

Thanks. Apart from the small mistake and the misrendering of "[--[no-]",
this looks really nice to me, both HTML and manpage. The source .txt
files do get a bit messier, especially with the {empty} trickery, but
ok. (I haven't been paying attention. Maybe this has been discussed
before, and TBH I haven't even dug -- I don't mean to start another
round of discussion.)

Martin
