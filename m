Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331918E20
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356759; cv=none; b=LbYK6lOwHSzcq5GoqoGs+H7NH3hIP3rS+x0pKHITppn7gK9FkVzHjD2/AhBTDEyygBD4hnfVbT676XSgUWwT8cFwafGR2bJfJVPGDFTlMfROvV2568ed8yCM/srvEHA+TLglhJUwo1i0xtA9HV6oyWVuaFLZ5x75oOkZOXGWZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356759; c=relaxed/simple;
	bh=M5l44AOAwTV2D+iuw0Ucukm1AU+965OcLwPtWhiKQXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWrE2Hmkjv1Bvns7Pz6jnU12gsvZusb0ZKnOSClmosjpqVORcD5Ze9Lfu3ZeJUAJCWn2kN7Y3MF5Kz+X+8r217jdo3c16YYYmIChk87RDQw3JNMEugI9mKfgeJtTaFtuqUPI/d50G6GSt39yiEUK7l4Jd7vIpBnUMVNOlkoMbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8Nzfzoi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8Nzfzoi"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b403bb7843eso890996366b.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 04:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760356756; x=1760961556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4pR2RNhRtD58JD775UNUIFxcUc7UnbY+0FyyHOL57A=;
        b=W8Nzfzoi//mNCzBi72s4TbXG16mcHJAW30dryCxYPegie2IzTouzM/ImaqgPSE2oeT
         E9vJ7aoJOCaGH8KyZe2apx52CtZtCcgpIs/SwhEiLaZv6qLXESIYiUdG8oIUxbW17njI
         xC5QRHX35BgMhgkeSGnWTX3Ofu4ixCkkH0HYq5jfIdxLL4tChAF9M0NwH60D451WaUd6
         slNjXZ8VBB8ehlaWkLY+9gAIxv4mW87/npJsvJRnMAbKTtAFbcc1s+vyvwp07f8IVK3x
         mio0d7eTGE/jpjjG1TdBHOX4rQPYiw/fYaMtGiZvZLsG4glih+bneT64PZyJudUj+y8B
         Ut9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356756; x=1760961556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4pR2RNhRtD58JD775UNUIFxcUc7UnbY+0FyyHOL57A=;
        b=Nh9GeGaFe99dVh3hq8ev0h56u8RGLnz+wMT3H7aTxMAAvftlY0UwPEPIo/ABex+H0c
         jea39GgKBE1jPHIVOyOBgrt7NS65QqLxPlz9I37tVyNTGoOGTJx7nvn75GKLjOt/q5qz
         aUQttJT+gp2yDOLcESmrPrOq4936Xi2KWsxfEtspuHn7PyGQXeI8t7GL30SuZX4aj53Z
         utmJtQCEc2K9AqKoO0dBwKhg5jAMarvSpGILzwI9guqrLEEwiqpE88WBOuNrhgnUGWBY
         dFX1ufAHm0PWl80dugf9Rh2lOyLdzoMvzMF9u2eN+6FLhLse0Nq6wMKVeP6JQqdlssSk
         S00Q==
X-Gm-Message-State: AOJu0Yx1A7xwD7RvMJ7ERwUktGsc5AIEkaQogfZ9USxHhMcmwztup1jZ
	weqN6I4Sy8Cs5B+huSR/SqBnCf1PJ6oRMLMHz3CojAwlfL3duYLwkI7YaZWYkPY/4fLrOChOrtA
	0Y3/2S/doXDlXT6SEKpup8k5CiQ5sW5gYVbS3
X-Gm-Gg: ASbGncsIodA0KniBKmH4RIyKV1DgF8zXgaXl8q8xORxU7cUIpJ3BiW+pUEA8Lk1a8Ps
	QWlW3OoyRBf0FR5wjpP+M0+cu1BIpHZk4Tm8BByeJ5kEBnoxriB4Fm5iGwOgjiq+6fBEteqYK6W
	yTaR6nfmjzMREggAgCB32CExkoifYMKAbhYZBg+0EXV/Vq1woQxgKgWWUtsDqIvfykfBRft4hqA
	r7UuswVpD1d+hJkq5+E2Ibq4V+EhO7IgsUhUrtbXnHudDRDA8N6PWusXGB7gLV/y+Tow3EJCX7n
	xXLZvg==
X-Google-Smtp-Source: AGHT+IGfM0OnHzFv2145z7jqMa1WhR92BQWfVwmJie37vqDHk8phhSwe6vKqfWzcTLOsjVf4Qp7AApFiDDUOqNWbT2I=
X-Received: by 2002:a17:907:843:b0:b40:98b1:7457 with SMTP id
 a640c23a62f3a-b50ac5d0901mr1948307666b.47.1760356755313; Mon, 13 Oct 2025
 04:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013094152.23597-1-git@lohmann.sh> <20251013094152.23597-6-git@lohmann.sh>
In-Reply-To: <20251013094152.23597-6-git@lohmann.sh>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 13 Oct 2025 07:59:02 -0400
X-Gm-Features: AS18NWDgEpP1O2vhJ7dSz0b2cVHRKvQcFoLWfm1V8IKAF2jtDpCE7INfuos8CWU
Message-ID: <CALnO6CBLr2iL0r+ywM4Vjw0=J2DNFv9Nhhq_PHuxt4eK=Z95ww@mail.gmail.com>
Subject: Re: [PATCH 5/5] setup: allow not marking self owned repos as safe in `ensure_safe_repository()`
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:43=E2=80=AFAM Michael Lohmann <git@lohmann.sh> wr=
ote:
>
> Git considers all repositories as safe, if they are either
>  - explicitly set in "safe.directory" config, or
>  - the user owns the repo
>
> Since a user could unzip a folder they downloaded from the internet and
> unknown to them, it is a repository with malicious hooks/config, an
> attacker could easily get code execution. Even a command line prompt
> would automatically trigger this if executing `git status` after
> entering the malicious directory.
>
> Allow not to automatically treat all repos owned by the user as safe.
> This can either be done by "--assume-unsafe", the environment variable
> "GIT_ASSUME_UNSAFE" or by setting the configuration "safe.assumeUnsafe"
> in a safe context (so not the repo config, as it should not be able to
> allow list itself).
>
> Signed-off-by: Michael Lohmann <git@lohmann.sh>
> ---
> Question in setup.c: is setting the environment variable inside of
> safe_directory_cb the best way to "communicate" this result?
> Alternatively one could add a new member to the struct, but I thought
> this was not the best either...
>
>
>  Documentation/config/safe.adoc    |  9 +++++++
>  Documentation/git.adoc            | 14 ++++++++++-
>  environment.h                     |  1 +
>  git.c                             |  6 ++++-
>  setup.c                           |  9 +++++++
>  t/t0036-allow-unsafe-directory.sh | 42 +++++++++++++++++++++++++++++++
>  6 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/safe.adoc b/Documentation/config/safe.a=
doc
> index 2d45c98b12..2ac5d94762 100644
> --- a/Documentation/config/safe.adoc
> +++ b/Documentation/config/safe.adoc
> @@ -60,3 +60,12 @@ which id the original user has.
>  If that is not what you would prefer and want git to only trust
>  repositories that are owned by root instead, then you can remove
>  the `SUDO_UID` variable from root's environment before invoking git.
> +
> +safe.assumeUnsafe::
> +       Boolean to indicate that the ownership of a repository should not
> +       be taken into account when checking if the repository is safe. It
> +       will prevent against accidental arbitrariy code execution

s/arbitrariy/arbitrary. (fix typo + add period)

> ++
> +To temporarily allow git execution in case of an assumed unsafe reposito=
ry,
> +run the command with `--allow-unsafe`. To permanently trust this path, a=
dd
> +it to the `safe.directory` config.
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index 7df51c38f9..162350f3db 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -14,7 +14,7 @@ SYNOPSIS
>      [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-laz=
y-fetch]
>      [--no-optional-locks] [--no-advice] [--bare] [--git-dir=3D<path>]
>      [--work-tree=3D<path>] [--namespace=3D<name>] [--config-env=3D<name>=
=3D<envvar>]
> -    [--allow-unsafe]
> +    [--allow-unsafe] [--assume-unsafe]
>      <command> [<args>]
>
>  DESCRIPTION
> @@ -238,6 +238,13 @@ If you just want to run git as if it was started in =
`<path>` then use
>         execution by hooks or configuration settings. Equivalent to setti=
ng
>         the environment variable `GIT_ALLOW_UNSAFE=3D1`.
>
> +--assume-unsafe::
> +       Prevent arbitrary code execution by hooks or configuration if not
> +       executed in a "safe.directory". With setting this, filesystem own=
ership
> +       of the repository in question no longer satisfies to mark it as s=
afe.
> +       Equivalent to setting `GIT_ASSUME_UNSAFE=3D1`. This is overwritte=
n if
> +       `--allow-unsafe` is passed as well.

Here and later, I think you mean "overridden" not "overwritten"

--=20
D. Ben Knoble
