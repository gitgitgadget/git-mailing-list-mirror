Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61191188014
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494757; cv=none; b=CscS6I0oAANQR8Mj1xKucQ3EgMcM85SP32drv1VqK5Khf/Gu8oNCZNetlvKHM6Fe6ReUU1rme1zjJl0S0hMDZ2pn8G5K8MebxaWPAja7xmnzYeLJZpPNtJDB2Nl84v0woX/6u2xuE6bMZFVjwsdEpircSl6MmrMDtIP8bcxC0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494757; c=relaxed/simple;
	bh=71ybs4Qa3ShprK+6Co66d8WpLRihI1OwwQuk6zvawYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seZWFPK7++PNJ2y5GDtaxXTbW0EEBN+BF0PORj9ootjX9pj3/y5+R8M2g7Xzu9e/AMpOIQWMKrJtXb8ltlEwLhbcTV2ebNEr7DSPYji92vJomW2p26Y8grrDw7oxZOHdvIztzRfEX5GvKx5MvlqG9NyDzAUD2AsqXftj4k98zSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtlTBoHq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtlTBoHq"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so8176877a12.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 02:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731494754; x=1732099554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Nj89IQpwPNOc8k6s8LXokTtquO/2W7d0Lvk7qtE9Fo=;
        b=LtlTBoHq3r8guJf0QiBK/qmTDjZagl3RVq/xk3QU1JqJXJIfJxPbtGRSNGBUQuluvj
         s1kgECqZ3F8q9DANbbnSXpnfscIq23y8ruPWtCrkTpfeyHB3iT9qv+D3v7eu1CYq1NWG
         Edu26l3jfKP5YikwwJhv9uMEHrDFraWRDtNGW4f9dBUztub+KwOd8A5KQe4zkNIgOp4X
         bYMV5SwBs7bRTan8LcSCM5SCYdwPJ3NO74Qfb9c1zHfI5PMjW7ZDXlRZaE1NuP5EJHvs
         pnD+QeeQr6Uv3CVf5ds3VrdQnSwRGSI6FbAuVKwMsnjat4hA/JnJYAWziIf6/j+q/cyQ
         BjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494754; x=1732099554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nj89IQpwPNOc8k6s8LXokTtquO/2W7d0Lvk7qtE9Fo=;
        b=wFyWRO0uae6KSxNU06MaiD2mpNeTW4C/ih4JoAChob9/maJFr76fK6AowaYtHf/E0D
         170QypJQCM2ivcEmuwoxPJwNXW1UQCUUodGpKz7kEPN/e2oEStyGVrqsXX9l5YRen1Z5
         eC6oy4VxGuxb/Bp3hoOXQvqhyWrD6YQRbcfxm25d62s58/24T0SsBtJl9+QJMRG4W2Ez
         X/W9NIgNNJbrXWvWdMlv5yk7nEJjXUcHVLOQzl6PMwdqNQ8L3dTaygqmqz5lopw1hp3B
         xwNjSd0WqA6YGkXSU4qeRtUyDOww5HQRTWqnB/q34aZ5ALvw5N1vgw650WBb2tjiw2pv
         UzxQ==
X-Gm-Message-State: AOJu0YzEC5yhBIywdyVFHOq+XX1yrEiKg/3O5l0Eja4axCZrCI4r96ox
	VGV/EVRM6dlV8zW8pMiDPsl/uWqztzEf04zrk1gjEoC1fHMhFMoegWVWD+Ih/MLtSNlCzueaVQx
	x1Bxj6X/ZP4YWeBvKiLzGL2fho7o=
X-Google-Smtp-Source: AGHT+IGJ5TereKHLjmP0uCBBmWKLCGD9o22j21/PFSFOwVz2EP+1PFJGZz1l8uWBDexl72/cIxzv6+gc5yLssNWpFy8=
X-Received: by 2002:a05:6402:4406:b0:5ce:dfdf:a2a8 with SMTP id
 4fb4d7f45d1cf-5cf0a446960mr15758489a12.30.1731494753432; Wed, 13 Nov 2024
 02:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 13 Nov 2024 11:45:41 +0100
Message-ID: <CAP8UFD1qNyWbOvUm2q2ZTcV+Ut_=ZJkURYqF7PnJxyJsvkchEw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

>     ++#    The prefix into which Git shall be installed is defined when s=
etting up
>     ++#    the build directory. More on that in the "Configuration" secti=
on.
>     ++#
>     ++# Meson supports multiple backends. The default backend generates N=
inja build
>     ++# instructions, but it also supports the generation of Microsoft Vi=
sual
>     ++# Studio solutions as well as Xcode projects. IDEs like Eclipse and=
 Visual
>     ++# Studio Code provide plugins to import Meson files directly.
>     ++#
>     ++# Configuration
>     ++# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     ++#
>     ++# The exact configuration of Git is determined when setting up the =
Git
>     ++# directory.

Is it the "Git directory" or the "build directory"?

It might be helpful to repeat that this happens when `meson setup
build/` is run (as far as I understand it). Maybe something like:

"The exact configuration of Git is determined when setting up the
build directory, so when running `meson setup <build-dir>/`."

>Unless told otherwise, Meson will automatically detect the
>     ++# availability of various bits and pieces. There are two different =
kinds of
>     ++# options that can be used to further tweak the build:
>     ++#
>     ++#   - Built-in options provided by Meson.
>     ++#
>     ++#   - Options defined by the project in the "meson_options.txt" fil=
e.
>     ++#
>     ++# Both kinds of options can be inspected by running `meson configur=
e` in the
>     ++# build directory, which will give you a list of the current value =
for all
>     ++# options.
>     ++#
>     ++# Options can be configured either when setting up the build direct=
ory or can
>     ++# be changed in preexisting build directories:
>     ++#
>     ++#      # Set up a build directory with optimized settings that will=
 be
>     ++#      # installed into an alternative prefix.
>     ++#      $ meson setup --buildtype release --optimization 3 --strip -=
-prefix=3D/home/$USER

It's not very clear if the above instruction should be run inside an
existing build directory to modify its configuration, or if it creates
a new build directory. If it creates one, it's also not clear what the
name of that directory would be. Maybe "build", but then what if an
existing build directory exists with that name?

>     ++#      # Set up a build directory with 'address' and 'undefined' sa=
nitizers
>     ++#      # using Clang.
>     ++#      $ CC=3Dclang meson setup -Db_sanitize=3Daddress,undefined

Same as above.

>     ++#      # Disable tests in a preexisting build directory.
>     ++#      $ meson configure -Dtests=3Dfalse

As here the command is "configure" instead of "setup", I guess it
doesn't create a build directory and should be run inside a one.

>     ++#      # Disable features based on Python
>     ++#      $ meson configure -Dpython=3Ddisabled
>     ++#
>     ++#      # Disable features based on Python
>     ++#      $ meson configure -Dpython=3Ddisabled

It looks like there is some duplication above.

>     ++# Options have a type like booleans, choices, strings or features. =
Features are
>     ++# somewhat special as they can have one of three values: enabled, d=
isabled or
>     ++# auto. While the first two values are self-explanatory, "auto" wil=
l enable or
>     ++# disable the feature based on the availability of prerequisites to=
 support it.
>     ++# Python-based features for example will be enabled automatically w=
hen a Python
>     ++# interpreter could be found. The default value of such features ca=
n be changed
>     ++# globally via `meson setup --auto-features=3D{enabled,disabled,aut=
o}`, which
>     ++# will set the value of all features with a value of "auto" to the =
provided one
>     ++# by default.
>     ++#
>     ++# It is also possible to store a set of configuration options in ma=
chine files.

It's not very clear what a "machine file" is. How is it different from
a config file?

>     ++# This can be useful in case you regularly want to reuse the same s=
et of options:
>     ++#
>     ++#   [binaries]
>     ++#   c =3D ['clang']
>     ++#   ar =3D ['ar']
>     ++#
>     ++#   [project options]
>     ++#   gettext =3D 'disabled'
>     ++#   default_editor =3D 'vim'
>     ++#
>     ++#   [built-in options]
>     ++#   b_lto =3D true
>     ++#   b_sanitize =3D 'address,undefined'
>     ++#
>     ++# These machine files can be passed to Meson via `meson setup --nat=
ive-file`.
>     ++#
>     ++# Subproject wrappers
>     ++# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     ++#
>     ++# Subproject wrappers are a feature provided by Meson that allow th=
e automatic
>     ++# fallback to a "wrapped" dependency in case the dependency is not =
provided by
>     ++# the system. For example if the system is lacking curl, then Meson=
 will use
>     ++# "subprojects/curl.wrap" to set up curl as a subproject and compil=
e and link
>     ++# the dependency into Git itself. This is especially helpful on sys=
tems like
>     ++# Windows, where you typically don't have such dependencies install=
ed.
>     ++#
>     ++# The use of subproject wrappers can be disabled by executing `meso=
n setup
>     ++# --wrap-mode nofallback`.

I guess this will make the build fail if the system doesn't provide curl th=
en.
