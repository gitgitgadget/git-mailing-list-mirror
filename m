Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720AFC0B
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374024; cv=none; b=MTLf/xuLQuET8TllqlAqbuBSNi8IXgHGpmR2i3eEnmBn093Tv1pZxBY60UJWIqdidQ5Kf+ImbSFMny+msdxQXmf5y5smHRNSDmR7rhr6EhVXJMnqW3Hw8UFopi6/Prj9YBkBnjE0VofZOCBODLYaGdV9v6kNp33Sc/cM1r31Lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374024; c=relaxed/simple;
	bh=l5B93cyPm3OTmaLgU5te1qK44Nhsp9PfsuS5ezNNQ3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZawDKPlkfQYwxQIYdazRs5F3/05KzacWl2mOUUiH4QNCOSGyAjwufXCDt4G3fwIaf7Omv02V/SSI/GM3Nx4SMVctnq2e1s8ipx65bP9LVNRqXilLtsJB7f+FWaBuXKW+GepfRJKERrSWLmLflRKu2uz4O2opbFSrCBNX7kJCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhd9vM8o; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhd9vM8o"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so2635957e87.3
        for <git@vger.kernel.org>; Fri, 10 May 2024 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715374020; x=1715978820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEjZE+WFBjeXzGpXmeenqDI6bzqF26txJnZ6+S0Znhs=;
        b=dhd9vM8oaADV9iUwHrIjHwVD39toLdRdr5eK+Wl/hRQTLeKUW1neNgrkkVvAIcB+EU
         IQwXklYxaqNnm+/ZzRXFDybnNJW6Bx/p94oMdA75Ujzcq8/r/a/2R8DKA22gwit6uKcF
         t+u/teKKwf5Mor5fXiMB9hDcCQXi7bevW60lUeApAwAlcSjIT7J5zqCZExNBPEPOFyzS
         gK+Cx/fi/ohQn1j1yFx+5ovCSmW17+9Cene0fy/isozuQW+I4RsZBX3/eLtNaYluu1Er
         MLUWjhaPhV/Rc1mpX1aCBAXelRiAWCJqoXMisdw4XWnbcd38deNyLQ2Qd0K3jpHsn+pK
         sJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715374020; x=1715978820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEjZE+WFBjeXzGpXmeenqDI6bzqF26txJnZ6+S0Znhs=;
        b=wUItmySMhmpL8GWRQ1z53LSL4czZr9ycaSuEtC9HwumGYfbyvojSt4U77L+8wNwl+B
         OvIGy6Nwv9KAuuvYgxwO0jmWZMEDfg8mnDGLcPURvUyWAAnm59BlcCEy7HDH5/jilwg8
         Xp9p/wA84Mr6B3t/Jf2rcE9OyYcB9Ckn0v1L4p6Ms2590sk+fJy4ZIIMtBtFmOCRJGlw
         Viz95kqEgX7a1as3OX1pU+rgmVLCNUttKStwQ1WZdPezhAUy6Wm983r/MgEo7ZnDiW4I
         MxFhfvEbHblv4emosgyw5U0Es9OkZ7vx+cHj3r6CmpVT5sZE7PUcI3TryoDpQv1k+7Ca
         YoSA==
X-Gm-Message-State: AOJu0YxuxRxknuJGL8vNAdk/uRZmtNG1i3ezcWENuUBoFzos+D1/ufxX
	fc+JQh9Yjp69Bo0ZAG5cV9VsXwRhOoLkmtSZA3cNBpeb4j0FFPKG9xP+1aJi+v8aOnMpvHhBYyJ
	Ly3zdrpvGk3EHvBzlPnq6yx6GLgmHHPrxdo3UOK6ePqbb88SW4g==
X-Google-Smtp-Source: AGHT+IH1X2fuuO9cf6Kql9mCkIXYfHegusgHI4xP6kLLGYXHNK8nonqG7W6Hlc6Q9KhjY2GrT6nmo9fQyAudAAxVdIg=
X-Received: by 2002:ac2:5207:0:b0:51a:cc00:951b with SMTP id
 2adb3069b0e04-52210074a08mr2201260e87.49.1715374019968; Fri, 10 May 2024
 13:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715339393.git.ps@pks.im> <edfd7caa39ab990faf5b49a6c572a612a35dbdd5.1715339393.git.ps@pks.im>
In-Reply-To: <edfd7caa39ab990faf5b49a6c572a612a35dbdd5.1715339393.git.ps@pks.im>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 10 May 2024 13:46:43 -0700
Message-ID: <CAO_smVhahWTvH4ycDGoRd2WeUnbNs=8Ukq5L17gRYn9kdE-zjA@mail.gmail.com>
Subject: Re: [PATCH 06/21] builtin/config: check for writeability after source
 is set up
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The `check_write()` function verifies that we do not try to write to a
> config source that cannot be written to, like for example stdin. But
> while the new subcommands do call this function, they do so before
> calling `handle_config_location()`. Consequently, we only end up
> checking the default config location for writeability, not the location
> that was actually specified by the caller of git-config(1).
>
> Fix this by calling `check_write()` after `handle_config_location()`. We
> will further clarify the relationship between those two functions in a
> subsequent commit where we remove the global state that both implicitly
> rely on.

Minor nit/question since I'm still pretty inexperienced w/ the project norm=
s:
Since this is a bug fix/behavior change, can we reorder the series so
this comes before (or after) the rest of the cleanups? I'm assuming
this fix would be something that could stand alone in its own series
even if we weren't making the other changes.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/config.c  | 10 +++++-----
>  t/t1300-config.sh |  6 ++++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 8f3342b593..9295a2f737 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -843,7 +843,6 @@ static int cmd_config_set(int argc, const char **argv=
, const char *prefix)
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_s=
et_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> -       check_write();
>         check_argc(argc, 2, 2);
>
>         if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
> @@ -856,6 +855,7 @@ static int cmd_config_set(int argc, const char **argv=
, const char *prefix)
>         comment =3D git_config_prepare_comment_string(comment_arg);
>
>         handle_config_location(prefix);
> +       check_write();
>
>         value =3D normalize_value(argv[0], argv[1], &default_kvi);
>
> @@ -891,13 +891,13 @@ static int cmd_config_unset(int argc, const char **=
argv, const char *prefix)
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_u=
nset_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> -       check_write();
>         check_argc(argc, 1, 1);
>
>         if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
>                 die(_("--fixed-value only applies with 'value-pattern'"))=
;
>
>         handle_config_location(prefix);
> +       check_write();
>
>         if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
>                 return git_config_set_multivar_in_file_gently(given_confi=
g_source.file,
> @@ -918,10 +918,10 @@ static int cmd_config_rename_section(int argc, cons=
t char **argv, const char *pr
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_r=
ename_section_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> -       check_write();
>         check_argc(argc, 2, 2);
>
>         handle_config_location(prefix);
> +       check_write();
>
>         ret =3D git_config_rename_section_in_file(given_config_source.fil=
e,
>                                                 argv[0], argv[1]);
> @@ -943,10 +943,10 @@ static int cmd_config_remove_section(int argc, cons=
t char **argv, const char *pr
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_r=
emove_section_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
> -       check_write();
>         check_argc(argc, 1, 1);
>
>         handle_config_location(prefix);
> +       check_write();
>
>         ret =3D git_config_rename_section_in_file(given_config_source.fil=
e,
>                                                 argv[0], NULL);
> @@ -997,10 +997,10 @@ static int cmd_config_edit(int argc, const char **a=
rgv, const char *prefix)
>         };
>
>         argc =3D parse_options(argc, argv, prefix, opts, builtin_config_e=
dit_usage, 0);
> -       check_write();
>         check_argc(argc, 0, 0);
>
>         handle_config_location(prefix);
> +       check_write();
>
>         return show_editor();
>  }
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index d90a69b29f..9de2d95f06 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2835,6 +2835,12 @@ test_expect_success 'specifying multiple modes cau=
ses failure' '
>         test_cmp expect err
>  '
>
> +test_expect_success 'writing to stdin is rejected' '
> +       echo "fatal: writing to stdin is not supported" >expect &&
> +       test_must_fail git config ${mode_set} --file - foo.bar baz 2>err =
&&
> +       test_cmp expect err
> +'
> +
>  done
>
>  test_done
> --
> 2.45.GIT
>
