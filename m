Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6272EA17E
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754499; cv=none; b=S71YfUW40x8l+TaJI0dezTxccTn3/1lThrRCTMotIBJO4Z1skR3jVpPsHNAEZdmaP3p4yGz6YrHKKiSBzm5m599zUlHu2CijhGaJX053alrVdOW60vUADhkYULkNIx+FDHEWPMRYxhTNThebX8XbSrKhmJJi34wy0MtHWa5T2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754499; c=relaxed/simple;
	bh=GmMe6qZKZ3yNC5Fs6X3YzF0KoJBrP1VYoJcUjSP8q4w=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ERZ95kw/UpojWvCXMKl9VLp1lR3c9/1H25nsws9j/pa3ASpK8IfNDqWywnRnbuSUPW+9bzpytlRB9zlKEkXXdEMmlBuVwFyjoxTgX7aLR0WWtTKTpWQpVeizLMho27Na8JKli2h9x+kKtKFkgD/o1704kPYbz/Zz3s9ha1KM8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOdn1wI+; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOdn1wI+"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63e35e48a27so146160d50.0
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761754496; x=1762359296; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiYm5tm0EsDIVWA8j8UGiPwI7FICjr7ZbhzrHvoFVOQ=;
        b=jOdn1wI+axYKSb+SoJ9EJZOwUk2y2AsiFe+UkpEjMtwu2Rg58LV49fVJX5IiIP4HkG
         RIMxqgDHKhd6+fx7nYANTy3GeZvgHdEJZ1A/sIGJtxWOm5HhdnlvC39yhlYddtE6GXL4
         gW9IPczIb6LzJyYgiKVEqgotvSMRwKHvCI4mgiTwa8g4FidwNNA6cyIWjc5qwu/JMoUW
         liPfjy36diEDdCWQG3g2pu0jsX01BmjCI9Lx/aITlAeXfXNoJSHb1BpK+IS313dPKT7L
         Sf32DSI8lozzHe1vSaX6BCOAKfRk7cVaabZ2obCBH+TpnYbwU9W2uAawnI06Qpw9fdwO
         7ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754496; x=1762359296;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiYm5tm0EsDIVWA8j8UGiPwI7FICjr7ZbhzrHvoFVOQ=;
        b=uMwpXywEvyfMylWrrF23l4F8KyWvHtsY3PsNz0EHP6IooqwCHRHqGRxzlOYJL+yVNF
         6Q3Cm7sRQsNO15wGmEXsSSenKUY8fLpqaZNmkGe1uLMk5sWk2NfaGUQjI7LzHS7K8/i5
         h5WDUyGwdvsEOMVA0F21yG/xArN72+zuzV7XK8vE7gghi0hKe/w4poeYa4+vtSjYUFbk
         g6sUnYxsmXMAGSnjqTXTlBp6SXqU3d4+5CLgiyViUhgrkyiRSTdqdFud56atIS6JFMqP
         jjl9WJgG7BeY+fvsm7hZbiJ2Z5VfBFsTxdcbjcXdBwC8CSp8I78eF7ij4ydnvVo8oWjI
         cE6g==
X-Gm-Message-State: AOJu0YwVTJoqZTJPXGIc+LuGIVgQfTG8QuGCp8yJuy0M8lOzAa1L+mWw
	qvdEZ+4jPr3ZuoVUPdPAs/r2YJ9B+JT7gcUC3d3lAunJ04qRHSTy2Kcc
X-Gm-Gg: ASbGncueTAaYCYvq54G9Eca5nxoaUtxNhn6Gxq1xrzN3qQ+PZj4xxRqjIyMiP36q3kk
	6Z410oopzOKEeT0BUXZLT8wPSdh7Pc50b/nIc3+YgTrWLXeenz5ydCxY2vIFj9/7cx5AqE831cw
	mWHjp+GVoqNbnLjbTUtO46gVioF/NjvKwnyudfd/cpjy63dDsJds/DN8GEXxHPt3fzx3gFYNtlT
	zEFTr+5m1uZ8eatLKOHGkUOljRPZg7Ek3PcLqZ0TAHC3zz9Qr8kL1osXAfqo2Y0JBURqelSQwhq
	FoF5ESeezAm4KMvBN9hPe5+DnauiWxmOCwVHvWKMcRpWkp/ZRx32VhPBfhT8Fg0hhRfjh3yvjUN
	m5//+RLzOB1HlkLI99H17BLvwLM4MYKlaI19rtf21szRmdLM1jv38ok9zJp/EI/XaqdxYejUr/l
	geeVnn0uhw8d3t6EI634gWunbvew==
X-Google-Smtp-Source: AGHT+IHG2aonxVSffm0q7CzPRKIRjWRzfLbyhsupuWiCrlBmfuqdkTNfbnXNtzIdNlETBVMDggbipg==
X-Received: by 2002:a05:690e:251c:20b0:63e:2906:e811 with SMTP id 956f58d0204a3-63f76d0e982mr2591495d50.2.1761754496001;
        Wed, 29 Oct 2025 09:14:56 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e43d:9f0:7b52:4db])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1b24e7sm37092767b3.35.2025.10.29.09.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:14:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] bisect: update usage and docs to match each other
Date: Wed, 29 Oct 2025 12:14:45 -0400
Message-Id: <A3B6994C-508A-4052-AD19-C5D773C0CC9F@gmail.com>
References: <pull.2084.git.git.1761690461697.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ruoyu Zhong <zhongruoyu@outlook.com>
In-Reply-To: <pull.2084.git.git.1761690461697.gitgitgadget@gmail.com>
To: Ruoyu Zhong via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 28 oct. 2025 =C3=A0 18:27, Ruoyu Zhong via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Ruoyu Zhong <zhongruoyu@outlook.com>
>=20
> Update the usage string of `git bisect` and documentation to match each
> other. While at it, also:
>=20
> 1. Move the synopsis of `git bisect` subcommands to the synopsis
>   section, so that the test `t0450-txt-doc-vs-help.sh` can pass.
>=20
> 2. Document the `git bisect next` subcommand, which exists in the code
>   but is missing from the documentation.
>=20
> See also: [1].
>=20
> [1]: https://lore.kernel.org/git/3DA38465-7636-4EEF-B074-53E4628F5355@gmai=
l.com/
>=20
> Suggested-by: Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: Ruoyu Zhong <zhongruoyu@outlook.com>
> ---
>    bisect: update usage and docs to match each other
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2084=
%2FZhongRuoyu%2Fgit-bisect-docs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2084/Zh=
ongRuoyu/git-bisect-docs-v1
> Pull-Request: https://github.com/git/git/pull/2084
>=20
> Documentation/git-bisect.adoc | 43 +++++++++++++++++++++--------------
> builtin/bisect.c              | 21 ++++++++++-------
> t/t0450/adoc-help-mismatches  |  1 -
> 3 files changed, 39 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc=

> index 58dbb74a15..b0078dda0e 100644
> --- a/Documentation/git-bisect.adoc
> +++ b/Documentation/git-bisect.adoc
> @@ -9,26 +9,22 @@ git-bisect - Use binary search to find the commit that i=
ntroduced a bug
> SYNOPSIS
> --------
> [verse]
> -'git bisect' <subcommand> <options>
> +'git bisect' start [--term-(bad|new)=3D<term-new> --term-(good|old)=3D<te=
rm-old>]
> +           [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pa=
thspec>...]
> +'git bisect' (bad|new|<term-new>) [<rev>]
> +'git bisect' (good|old|<term-old>) [<rev>...]
> +'git bisect' terms [--term-(good|old) | --term-(bad|new)]
> +'git bisect' skip [(<rev>|<range>)...]
> +'git bisect' next
> +'git bisect' reset [<commit>]
> +'git bisect' (visualize|view)
> +'git bisect' replay <logfile>
> +'git bisect' log
> +'git bisect' run <cmd> [<arg>...]
> +'git bisect' help
>=20
> DESCRIPTION
> -----------
> -The command takes various subcommands, and different options depending
> -on the subcommand:
> -
> - git bisect start [--term-(bad|new)=3D<term-new> --term-(good|old)=3D<ter=
m-old>]
> -          [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pat=
hspec>...]
> - git bisect (bad|new|<term-new>) [<rev>]
> - git bisect (good|old|<term-old>) [<rev>...]
> - git bisect terms [--term-(good|old) | --term-(bad|new)]
> - git bisect skip [(<rev>|<range>)...]
> - git bisect reset [<commit>]
> - git bisect (visualize|view)
> - git bisect replay <logfile>
> - git bisect log
> - git bisect run <cmd> [<arg>...]
> - git bisect help
> -
> This command uses a binary search algorithm to find which commit in
> your project's history introduced a bug. You use it by first telling
> it a "bad" commit that is known to contain the bug, and a "good"
> @@ -295,6 +291,19 @@ $ git bisect skip v2.5 v2.5..v2.6
> This tells the bisect process that the commits between `v2.5` and
> `v2.6` (inclusive) should be skipped.
>=20
> +Bisect next
> +~~~~~~~~~~~
> +
> +Normally, after marking a revision as good or bad, Git automatically
> +computes and checks out the next revision to test. However, if you need t=
o
> +explicitly request the next bisection step, you can use:
> +
> +------------
> +$ git bisect next
> +------------
> +
> +You might use this to resume the bisection process after interrupting it
> +by checking out a different revision.
>=20
> Cutting down bisection by giving more parameters to bisect start
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 8b8d870cd1..a500993bcb 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -27,13 +27,14 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BI=
SECT_FIRST_PARENT")
> static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>=20
> #define BUILTIN_GIT_BISECT_START_USAGE \
> -    N_("git bisect start [--term-(new|bad)=3D<term> --term-(old|good)=3D<=
term>]" \
> -       "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
> -       "    [<pathspec>...]")
> -#define BUILTIN_GIT_BISECT_STATE_USAGE \
> -    N_("git bisect (good|bad) [<rev>...]")
> +    N_("git bisect start [--term-(bad|new)=3D<term-new> --term-(good|old)=
=3D<term-old>]\n" \
> +       "                 [--no-checkout] [--first-parent] [<bad> [<good>.=
..]] [--] [<pathspec>...]")
> +#define BUILTIN_GIT_BISECT_BAD_USAGE \
> +    N_("git bisect (bad|new|<term-new>) [<rev>]")
> +#define BUILTIN_GIT_BISECT_GOOD_USAGE \
> +    N_("git bisect (good|old|<term-old>) [<rev>...]")
> #define BUILTIN_GIT_BISECT_TERMS_USAGE \
> -    "git bisect terms [--term-good | --term-bad]"
> +    "git bisect terms [--term-(good|old) | --term-(bad|new)]"
> #define BUILTIN_GIT_BISECT_SKIP_USAGE \
>    N_("git bisect skip [(<rev>|<range>)...]")
> #define BUILTIN_GIT_BISECT_NEXT_USAGE \
> @@ -41,17 +42,20 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN"=
)
> #define BUILTIN_GIT_BISECT_RESET_USAGE \
>    N_("git bisect reset [<commit>]")
> #define BUILTIN_GIT_BISECT_VISUALIZE_USAGE \
> -    "git bisect visualize"
> +    "git bisect (visualize|view)"
> #define BUILTIN_GIT_BISECT_REPLAY_USAGE \
>    N_("git bisect replay <logfile>")
> #define BUILTIN_GIT_BISECT_LOG_USAGE \
>    "git bisect log"
> #define BUILTIN_GIT_BISECT_RUN_USAGE \
>    N_("git bisect run <cmd> [<arg>...]")
> +#define BUILTIN_GIT_BISECT_HELP_USAGE \
> +    "git bisect help"
>=20
> static const char * const git_bisect_usage[] =3D {
>    BUILTIN_GIT_BISECT_START_USAGE,
> -    BUILTIN_GIT_BISECT_STATE_USAGE,
> +    BUILTIN_GIT_BISECT_BAD_USAGE,
> +    BUILTIN_GIT_BISECT_GOOD_USAGE,
>    BUILTIN_GIT_BISECT_TERMS_USAGE,
>    BUILTIN_GIT_BISECT_SKIP_USAGE,
>    BUILTIN_GIT_BISECT_NEXT_USAGE,
> @@ -60,6 +64,7 @@ static const char * const git_bisect_usage[] =3D {
>    BUILTIN_GIT_BISECT_REPLAY_USAGE,
>    BUILTIN_GIT_BISECT_LOG_USAGE,
>    BUILTIN_GIT_BISECT_RUN_USAGE,
> +    BUILTIN_GIT_BISECT_HELP_USAGE,
>    NULL
> };
>=20
> diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
> index 2c6ecd5fc8..8ee2d3f7c8 100644
> --- a/t/t0450/adoc-help-mismatches
> +++ b/t/t0450/adoc-help-mismatches
> @@ -2,7 +2,6 @@ add
> am
> apply
> archive
> -bisect
> blame
> branch
> check-ref-format
>=20
> base-commit: 57da342c786f59eaeb436c18635cc1c7597733d9
> --
> gitgitgadget

Nothing particularly surprising here, I think. Thanks!=
