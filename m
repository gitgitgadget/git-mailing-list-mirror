Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F082DF147
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155578; cv=none; b=rbvB4tQHNYfN+h0LU/o8jtm6+OuglFJyDo6eGyaQhXPL7kZ1qLQ1jg9467+BC93rjEJtD0C68PjhxBL8ZkQvP6ZlDDj6YrW3FioxXcTQ8i5izDlp1d2hmogFLdy8oiU4gGY6aI4H5GjnFB2Y+VzYg9JZdxf+DemUw80DtiDTltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155578; c=relaxed/simple;
	bh=mvn9ieY59Nok+/vAQWTnVI437yDj/GCpag/WWA+YsTs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=LNGyW94Q0GZ/rVxIaZeELJ5PYGTuwlcAXc7wRTwAyUm6wHyaXC31Hqmf96Pc82b90um28Z4ZMWG+Sun+nQXgISYeyN3DsaLgVMH2AG63qYq/25GRRsGx1WlX3jV43Cu1sR/3sO/C/iItRJbgGyGMOYIvk25P5Aqr2WhRlWWgiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kurFmjyo; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kurFmjyo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-783fa3aa122so18989747b3.0
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155576; x=1761760376; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIQEfJCgwyNYrIlIWdedpu23kLlvleqPtozd9df0big=;
        b=kurFmjyosRHthfQRISm83ZDB6ZcKqtHxlTazv1A80n4HNJiIxc6FxpvB2Ejy374Zjq
         QPqno4boueY0FOfS4/TlSGeCEP9kck9YfpWhFgWw3+jqM+BgDB53UUfGFoFem7evu15J
         LVfC2g5m1WZRAxJvENrZrtE2/mVjjCZlycAvYlH4e7i1SEGj2OtEGSj1Fkk88Pc+ZyEc
         2Vfo9CTngUFhM180rbKQ+SU2Js5QcroMmRljoWGLjHvGUuhTPgorPy49X7/lUcWouIJp
         47hgBIWgcNXOUc/ja92PEyKm61uNdSzkDDSCjK+rzq3L5h1Dq9GRJgTjfCToDcJMdOpj
         VwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155576; x=1761760376;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIQEfJCgwyNYrIlIWdedpu23kLlvleqPtozd9df0big=;
        b=DeK6AI+BnG/wJlIaaO+I4BnO/ltQT8MYr1o1Egfi6jawcWiiNYKCs4GaWsIJ8qsrvX
         WWUy+5POq3sFP2Cisd3N9XslOfIHv2eKsvCxYUJC7m6hHiPWyaXRP4M8+i0I92R3Q6BX
         XgW+2R5z4jxp0PwYHmeDEycy8Dy8Hmp62eNCJt8ppAH7BSz9HFvUE6Mj4kXEyPBCJKSA
         XpB6TWlhNbi6L4GannkmrvDZsKjMDl73MKrTRBa7URBb4+lniuBRXQQAgeHf6gJeYKPG
         p+aszLV+AQD9Nn5VTYVuT2zNJfxmpWrEj8h/s2cvKhDJ8rAYvNnZ2zUi8zx0SX8o4dw/
         cQ/A==
X-Gm-Message-State: AOJu0YxOAT0Rj+5ZAe1PoyyJ1Uk/DJTO/GGqAuQ8vQ+omrLf6iajA95B
	lE6NhLa/zIeb1YvzIyTig9X79FrrDYGN9Eawfm/BFfYMWIWVlqbS5sTL
X-Gm-Gg: ASbGnct5lkKhgwYwPFJkmkLDPpuNgZT5YVzyqFXUPnhJwnVvZmfh763peM0DeWEay0i
	d3mCvHkcEohRRSwxh/YAYelJhk3abfwRmB59i7kxG4Wq06DvMk+LaJt5QEU1W7HdmlumHaZnEF7
	wiOvScnoxtcKnWMbXV/Yr8hNAQAZkGEnlP06wLVY5xlVSnf0sTgo8lww9jtClgrUtcsBCu/O0Hg
	PIXB8IgJz4lL3VTVD0nVLGhGX5daaBKEN2G4L8lWZtjChWRq+mQ0/fiAMe+BSIedrquGppP2F4I
	ZS65B7xhb0y6jznHIforBJ9rmFjHJYB6WeLxrefI6RTWJ6ZC/i+oghN0kwPaT8bmx57H3N/7+EM
	Zax5NgqE3L56lyri2dhqup3UEiKyk5L4wV5zOHSr6lN06Cy0xN4gaYRUu5HdthY9PVPIvVMDE0O
	0FN3/u7F9feIb5qyatUFPs/DO5K2vqBiZQ5FMPxn8CBkBc
X-Google-Smtp-Source: AGHT+IFaB3Z9dvTK0JD/+x4+pdTC7EBBsUuadg6ETN3Y3SBp1fdLPy5n9muyhsqqANEC2y8ZAaU+PA==
X-Received: by 2002:a05:690c:6886:b0:781:64f:2b6f with SMTP id 00721157ae682-785bd2c3fdemr38830987b3.32.1761155575779;
        Wed, 22 Oct 2025 10:52:55 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:c453:ab75:b1b9:2303])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784673bc188sm38278717b3.18.2025.10.22.10.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:52:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] bisect: fix handling of `help` and invalid subcommands
Date: Wed, 22 Oct 2025 13:52:44 -0400
Message-Id: <3DA38465-7636-4EEF-B074-53E4628F5355@gmail.com>
References: <pull.2078.git.git.1761122173126.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ruoyu Zhong <zhongruoyu@outlook.com>
In-Reply-To: <pull.2078.git.git.1761122173126.gitgitgadget@gmail.com>
To: Ruoyu Zhong via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 22 oct. 2025 =C3=A0 04:37, Ruoyu Zhong via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Ruoyu Zhong <zhongruoyu@outlook.com>
>=20
> As documented in git-bisect(1), `git bisect help` should display usage
> information. However, since the migration of `git bisect` to a full
> builtin command in 73fce29427 (Turn `git bisect` into a full built-in,
> 2022-11-10), this behavior was broken. Running `git bisect help` would,
> instead of showing usage, either fail silently if already in a bisect
> session, or otherwise trigger an interactive autostart prompt asking "Do
> you want me to do it for you [Y/n]?".

Good catch!

FWIW, in this project we describe the buggy behavior in the present tense (=C2=
=AB is broken =C2=BB, =C2=AB Running git bisect shows =C2=BB, etc.)

>=20
> Similarly, since df63421be9 (bisect--helper: handle states directly,
> 2022-11-10), running invalid subcommands like `git bisect foobar` also
> led to the same behavior.
>=20
> This occurred because `help` and other unrecognized subcommands were
> being unconditionally passed to `bisect_state`, which then called
> `bisect_autostart`, triggering the interactive prompt.
>=20
> Fix this by:
> 1. Adding explicit handling for the `help` subcommand to show usage;
> 2. Validating that unrecognized commands are actually valid state
>   commands before calling `bisect_state`;
> 3. Showing an error with usage for truly invalid commands.
>=20
> This ensures that `git bisect help` displays the usage as documented,
> and invalid commands fail cleanly without entering interactive mode.
> Alternate terms are still handled correctly through
> `check_and_set_terms`.
>=20
> Signed-off-by: Ruoyu Zhong <zhongruoyu@outlook.com>
> ---
>    bisect: fix handling of help and invalid subcommands
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2078=
%2FZhongRuoyu%2Fgit-bisect-subcommands-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2078/Zh=
ongRuoyu/git-bisect-subcommands-v1
> Pull-Request: https://github.com/git/git/pull/2078
>=20
> builtin/bisect.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 8b8d870cd1..993caf545d 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -1453,9 +1453,13 @@ int cmd_bisect(int argc,
>        if (!argc)
>            usage_msg_opt(_("need a command"), git_bisect_usage, options);
>=20
> +        if (!strcmp(argv[0], "help"))
> +            usage_with_options(git_bisect_usage, options);
> +

=46rom an extremely quick look at the code, this might be better handled wit=
h a new OPT_SUBCOMMAND, though that might mean making the options array stat=
ically scoped to this file rather than the function.

It would also be nice to update the usage to match the manual while we=E2=80=
=99re here, which presumably in turn affects the test between command usage a=
nd manuals.

>        set_terms(&terms, "bad", "good");
>        get_terms(&terms);
> -        if (check_and_set_terms(&terms, argv[0]))
> +        if (check_and_set_terms(&terms, argv[0]) ||
> +            !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
>            usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
>                       options, argv[0]);
>        res =3D bisect_state(&terms, argc, argv);
>=20
> base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
> --
> gitgitgadget

I think this part is OK, since we only intend to check this when using the =C2=
=AB git bisect <term> =C2=BB form.=20
