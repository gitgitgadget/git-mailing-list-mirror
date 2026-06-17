Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9112F12A1
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716654; cv=none; b=qiYN4xIpFb9pu9H5XpUab561enPQL1Wu9JhtFUGaWGNPmV1ea084U8GvsNoRv3SeeiR2Bw3NYBOGwTA7ioEpj75fbBOc44j6XB/SLQ75zJl/OGVd6+cWTSteB8zi2GEbIjfniB78i4eTHqZWctbexdWHCwEeJzxxOvkYtbbr1Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716654; c=relaxed/simple;
	bh=afnWi2YzyJ70hzyTsIb5FtSdh68GjHCvcxIYX+1GJD8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sLfDkrKLULtcQLXa3WmWTCORd5Qv9oW2vfXWd8WpqK/cxvKNaRmHOXxFhLWMHnbLKzsMOohJ5x70kgjs9XG6CatnFl33vM5mw4/tvyhrEmiSuFCsOEBK8VIk/s4KiDma+PaSx4WIUIf82/RSzZKVRjKNmmWeuE+WrYq6+l9h3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQRlKKlr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQRlKKlr"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dd3f176f84so938697b3.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716648; x=1782321448; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAbxKOUcUuR2NOmqyDPQk/0DmObuO90OvbwRFVuyVWs=;
        b=GQRlKKlrDa5oxM1FB81wi+G6JWS3v83KSMeVkI9GUU2u4T0EANgpENZy4nLXMUv4RD
         8YWBfwkTgq7uaGdB26yC3at4pufvqeFEXE0bKZoQDsPXXFjfRva43cy/PD16JeAhU1iZ
         wH7X2cwxHwUHOI/O/YBdbudm8kB6IUdGbbgZ8v2b7HJq6EHiNqPtc7yKhqEE04jaYrKs
         J3km/CWlT2oKOb/Sss2RC9pTPBiGZUy9s0sLlqWceoB2otAKMO8LrRxD65chCxwU+INW
         nUtAc/ydqlvxxuslgHdBWlzuUjTk0RRIEEhzssLzEwSDEZ/RqrMRSgekn5f+AJNDDKAg
         NWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716648; x=1782321448;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAbxKOUcUuR2NOmqyDPQk/0DmObuO90OvbwRFVuyVWs=;
        b=EezH4AqgaOJ/lHQMduh6WgkbTWVEx1VpIzQYCqMoFy56sMJ6RlexLOWur5Lc3Vquih
         O7He8nKIUiMBDBxjAhTVY2USW1u59dCwn916DTUkHYpd7YEwJFwLTAdSsUXagm8oAdVc
         n9P+n28OaFO2Lp8r/SbxFz/PKMV6hZT5382HVAYNOcEdg4dySEhVDF4ubrgUCqKhXoJe
         EHfrFk/D2DWqo45AQy4gJ0CnZ2IEW2nIypD86eeTm2gAMIgVpXoSObRKpKQLBccZNL9v
         wdZ2zBC1Gwmu5mopcMydNh1NcFqP9ZPlxnOsEv57U3CSLLHKiC6quQp5dB0iny8Zl2T5
         hkzQ==
X-Gm-Message-State: AOJu0YzHGKWBcOlDEynvvCHqiJMMyQ+NmqdePEZLq8CGRixsIHuJuRQY
	vUTWr9TF+s5DnTed7Dcb+mx5oNNB5knNZ5LTnxR9LadI7ghAvNlnnspfSzwnKF/N
X-Gm-Gg: AfdE7cmY6GzK9Nwv/4nJ4lft/qWYTvh0mXRbLEp6EMmlHMZlzMSfLINndlwtMKjYtTe
	vM8pFUkxXzLLLo3N4PpOp/aS4xtzNvk01ExqXU5bWDdQJ75GkY5hEZeHo33hT8F9eM9cDJfY2cg
	efZzQ6FK+7jMJU7hunkyjeizyzPo7mH5XMyjy99KlQ9dmrZt3TAFLXtdxrc/44JZST297TCh1JK
	y1ry+jSGLIZz0M+51SiNhT9EmRQ6UEqZia3LOIS5ixps8dF1NwbWuPnJDReaWlTJYpiV3CTzEpg
	Tei4dQ3CINt+H+rRsqmMGWv0eht1oRsWxgYrAIYuylxV3t3nDuexRuXlFCEl/prQ+F0DrTn0IqV
	Xq7HxPbT/tFOJDJd1h6R5mEwyKGbtsNr+tQKNGYszgOO44V1MCJHRrd4ozrS8o19W+J4x8lE+8F
	4I0AnrlRbJ9Q0Yvs/fFaW0RhM9YfNExofeXjXAOZpWr3DEl3dBEv02NBRBM2lwCvD2WKbP8Tnr0
	39I2Cirkjap88v3itqiTYBePPIHidSfZeU=
X-Received: by 2002:a05:690c:4c09:b0:7bd:5c77:1aa9 with SMTP id 00721157ae682-7fe57d77b06mr57050197b3.0.1781716647556;
        Wed, 17 Jun 2026 10:17:27 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:8096:ceb8:4ec9:be3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd3a4c53csm55305927b3.43.2026.06.17.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:17:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] completion: zsh: support completion after "git -C <path>"
Date: Wed, 17 Jun 2026 13:17:16 -0400
Message-Id: <BD572902-D8E9-497A-9B90-E6889675145D@gmail.com>
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lutz Lengemann <lutz@lengemann.net>
In-Reply-To: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
To: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)

I=E2=80=99d like to take a deeper look at this, but I=E2=80=99m not sure whe=
n I can.

> Le 17 juin 2026 =C3=A0 11:37, Lutz Lengemann via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Lutz Lengemann <lutz@lengemann.net>
>=20
> The zsh completion wrapper (__git_zsh_main) did not handle the global -C
> option, so "git -C <path> <command> <TAB>" offered nothing and could not
> complete a command's arguments.

One easy note, though: our commit style prefers describing the code base bef=
ore the patch in question in the present tense (=C2=AB does not handle =C2=BB=
, =C2=AB offers nothing =C2=BB).

The below imperative mood looks appropriate to me.

>=20
> Three things are needed to make it work, all scoped to -C:
>=20
>  - Add -C to the _arguments specification, so completion no longer stops
>    at it.
>=20
>  - Advance __git_cmd_idx past any leading "-C <path>" options. The index
>    is hard-coded to 1, i.e. the command is assumed to be the first
>    argument; with -C present the command sits two words later for each
>    -C, so the bash helpers otherwise look at the wrong word and produce
>    nothing.
>=20
>  - Collect the -C paths into __git_C_args, as __git_main does. The bash
>    helpers run git to resolve aliases and list refs; without the -C
>    paths they run in the current directory, so completion fails whenever
>    the cwd is not the target repository or the command is an alias.
>=20
> With these, "git -C <path> <command> <TAB>" completes the command, its
> options and its arguments, including outside the repository, through
> aliases, and with repeated -C options.
>=20
> Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
> ---
>    completion: zsh: support completion after "git -C "
>=20
>    This patch is intentionally scoped to -C, but the underlying problem is=

>    more general. The zsh wrapper hard-codes __git_cmd_idx=3D1, i.e. it
>    assumes the command is always the first argument. That assumption break=
s
>    argument completion after any global option that precedes the command,
>    not just -C =E2=80=94 e.g. --git-dir, --work-tree, --namespace, -c, and=

>    -p/--paginate. After those, git <opt> <command> <TAB> currently
>    completes the command name but not its arguments.
>=20
>    The same approach generalizes cleanly: instead of skipping only leading=

>    -C options, walk all leading global options and their arguments to
>    locate the command and its true index (mirroring the option scan in
>    __git_main in git-completion.bash), while collecting -C into
>    __git_C_args and --git-dir into __git_dir as today.
>=20
>    I kept this revision narrow for reviewability and because git -C is the=

>    case where I miss the completion, but I'm happy to extend it to cover
>    the other global options in a follow-up (or fold it into this patch) if=

>    that's preferred.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2155%2Fm=
obilutz%2Fzsh-complete-global-C-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2155/mobilu=
tz/zsh-complete-global-C-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2155
>=20
> contrib/completion/git-completion.zsh | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/gi=
t-completion.zsh
> index c32186a977..323049be8b 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -227,6 +227,7 @@ __git_zsh_main ()
>        '(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into '=
'less'']' \
>        '(-p --paginate)--no-pager[do not pipe git output into a pager]' \
>        '--git-dir=3D-[set the path to the repository]: :_directories' \
> +        '*-C[run as if git was started in <path>]: :_directories' \
>        '--bare[treat the repository as a bare repository]' \
>        '(- :)--version[prints the git suite version]' \
>        '--exec-path=3D-[path to where your core git programs are installed=
]:: :_directories' \
> @@ -252,6 +253,14 @@ __git_zsh_main ()
>        ;;
>    (arg)
>        local command=3D"${words[1]}" __git_dir __git_cmd_idx=3D1
> +        local -a __git_C_args
> +        local -i i=3D2
> +
> +        while [[ ${orig_words[i]} =3D=3D -C ]]; do
> +            __git_C_args+=3D(-C ${orig_words[i+1]})
> +            (( __git_cmd_idx +=3D 2 ))
> +            (( i +=3D 2 ))
> +        done
>=20
>        if (( $+opt_args[--bare] )); then
>            __git_dir=3D'.'
>=20
> base-commit: 0fae78c9d55efe705877ea537fe42c59164ccd94
> --
> gitgitgadget
>=20
