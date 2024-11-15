Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8615C140
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731673271; cv=none; b=ZAS13G7BZs1YGnrQObFpXlaS48W5BquuNUsRvY1nnSY4d8SeaQ45jreNUpw8pa+3plQt2ucUHHAXwR9dmckcGWL2F6LXxdQgtr2JBhA7lqfDlpbyv10aQAZHgsFdiUwPsUspUTzG8BCXcU615Te6irHC4rqsLRf1ii6a+/QWacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731673271; c=relaxed/simple;
	bh=TJmFW+q7d6/NhGJeONxFDSri4/IF8/jSVdmxki90Wu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jU9sEAnLUwE2PrbhHqmG3Da5tazZJHRXOqUt/T7QT1DS6mecCHnZGK0Tb+6nHTas14+G0OseOk0/ka3ANS3foaJ7JOzbQq6lc2Wf0ayltN//yIYmHX6mp77aa4GCFmQ8WksoWTRHMg8DB4C9vdLGjjaT/K6MoSy/JEe8i0VdSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgEcEfjv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgEcEfjv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cedea84d77so830494a12.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 04:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731673268; x=1732278068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E42wmeGnCjNP+l/vVhhEUiE3KVwICHuRv8YJxg4e8X4=;
        b=AgEcEfjvylVtc9N8vtkyIvTORdTX0Wbh695uQzTEa4USeCriYhcIqPDRjw6ui/tD5e
         TXbkuOizcd0HlCHl3M9iGMMWvHLgQTGkzKebUu5znzWtIW2QxGI9Hs6qIKbk+HyiXBHX
         I1+k9g/mSdxtGVqn6c4cVW2K7lcPALAItg0OCvSJIpKrPg4qazjt+ioM7AosAnTuTf0R
         Q5V7H6Vy5s4cHFQZzbWZnXPz1KuYIFAf6KkyFQ8OBO88uGhQVyDyQtQ61g69Cx8mtLgG
         TdDAGdn/YBQxHYjR5193q1yF8O0HQxi6qXwg2RTRc20v6uQAlRYTA51zG104CCg7XFUK
         vMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731673268; x=1732278068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E42wmeGnCjNP+l/vVhhEUiE3KVwICHuRv8YJxg4e8X4=;
        b=DL/Fr5mnxMv/fIXZMi3LB7qxZeIx3SRpjH0pto7snQeP1vi/Y4s4uPCU2bPHkKBG36
         ObAHxQI9Gvlasm9ZJ5kP5zArw4UaDgGmp5dpNFFjIW7x/Gh5t3exuT4nFLdKYxXPXlwN
         8ET7YBaSRUfS5za14xeLC4QiUtM6NTyaZQZxCAhH97CSiBbrjg43X3cq+zo/PTHcB6C/
         2u9w4f35NsjIsocP7S1suwG6BZQll90maI419DPYCUWh7BR4efDW1l9IGdBxd/lazou7
         XlmgczyNNqpCHYMwlYN3QpYmFZ/iZJcOlzT376+Fgu5rim3lBol4CUn4bWJOxk6iGfyV
         eloQ==
X-Gm-Message-State: AOJu0YwUzx7YrN15MCYjkQDqiC12xFLW/NmhWie4VL1mnnSNG7xGbfgS
	fXyfxMY6BrOmDtTCkguRfzNhgUyMFxxsf51Q0eTCGwGcP/PbvOejwOys2V6wKNTR2NrKOacE2Rf
	wJ7KAI0hr6MD21EoxHxAjPZe8Ylw=
X-Google-Smtp-Source: AGHT+IGMloL5iXM5m00oF6elNIw5b2E0iWC0Ak0XaXF7Tcz0jFyVMpFazalyALOGCdlzEWq44uuonMcGfkaajzlyrVs=
X-Received: by 2002:a05:6402:34cb:b0:5cf:6006:3ca4 with SMTP id
 4fb4d7f45d1cf-5cf8fc9e956mr1826138a12.19.1731673267765; Fri, 15 Nov 2024
 04:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im> <20241115-pks-meson-v7-21-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-21-47ec19b780b2@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 15 Nov 2024 13:20:55 +0100
Message-ID: <CAP8UFD17rBAg6xYdA6BsNCgYtqBv_gijWj3EG_JZV+RL8ZaNnQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 21/22] Introduce support for the Meson build system
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>, 
	Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 8:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> +# Basic usage
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# In the most trivial case, you can configure, build and install Git lik=
e this:
> +#
> +#  1. Set up the build directory. This only needs to happen once per bui=
ld
> +#     directory you want to have. You can also configure multiple differ=
ent
> +#     build directories with different configurations.
> +#
> +#      $ meson setup build/
> +#
> +#     The build directory gets ignored by Git automatically as Meson wil=
l write
> +#     a ".gitignore" file into it. From hereon, we will assume that you =
execute
> +#     commands inside this build directory.
> +#
> +# 2. Compile Git. You can either use Meson, Ninja or Samurai to do this,=
 so all
> +#    of the following invocations are equivalent:
> +#
> +#      $ meson compile
> +#      $ ninja
> +#      $ samu
> +#
> +#   The different invocations should ultimately not make much of a diffe=
rence.
> +#   Using Meson also works with other generators though, like when the b=
uild
> +#   directory has been set up for use with Microsoft Visual Studio.

I think it might be helpful to say if the above commands are using
multiple processes in parallel (like `make -j 10` for example) to
build or not. If they are using multiple processes, it might be useful
to shortly say how the number of processes used is computed. If they
are not using multiple processes, it might be interesting to say if an
option exists for this or not, and if not, why.

If the above commands use ccache or can use it, or similar tools, it
could be interesting to say so too.

> +#
> +# 3. Execute tests. Again, you can either use Meson, Ninja or Samurai to=
 do this:
> +#
> +#      $ meson test
> +#      $ ninja test
> +#      $ samu test
> +#
> +#   It is recommended to use Meson in this case though as it also provid=
es you
> +#   additional features that the other build systems don't have availabl=
e.
> +#   You can e.g. pass additional arguments to the test executables or ru=
n
> +#   individual tests:
> +#
> +#      # Execute the t0000-basic integration test and t-reftable-stack u=
nit test.
> +#      $ meson test t0000-basic t-reftable-stack
> +#
> +#      # Execute all reftable unit tests.
> +#      $ meson test t-reftable-*
> +#
> +#      # Execute all tests and stop with the first failure.
> +#      $ meson test --maxfail 1
> +#
> +#      # Execute single test interactively such that features like `debu=
g ()` work.
> +#      $ meson test -i --test-args=3D'-ix' t1400-update-ref

How about executing tests in parallel? I am asking because it's an
easy way to speed up test execution.

> +# 4. Install the Git distribution. Again, this can be done via Meson, Ni=
nja or
> +#    Samurai:
> +#
> +#      $ meson install
> +#      $ ninja install
> +#      $ samu install
> +#
> +#    The prefix into which Git shall be installed is defined when settin=
g up
> +#    the build directory. More on that in the "Configuration" section.
> +#
> +# Meson supports multiple backends. The default backend generates Ninja =
build
> +# instructions, but it also supports the generation of Microsoft Visual
> +# Studio solutions as well as Xcode projects. IDEs like Eclipse and Visu=
al
> +# Studio Code provide plugins to import Meson files directly.

So I guess it's not necessary to configure Meson to make it use a
backend that generates VS Code or Xcode projects.

> +# Configuration
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# The exact configuration of Git is determined when setting up the build
> +# directory via `meson setup`. Unless told otherwise, Meson will automat=
ically
> +# detect the availability of various bits and pieces. There are two diff=
erent
> +# kinds of options that can be used to further tweak the build:
> +#
> +#   - Built-in options provided by Meson.
> +#
> +#   - Options defined by the project in the "meson_options.txt" file.
> +#
> +# Both kinds of options can be inspected by running `meson configure` in=
 the
> +# build directory, which will give you a list of the current value for a=
ll
> +# options.
> +#
> +# Options can be configured either when setting up the build directory o=
r can
> +# be changed in preexisting build directories:
> +#
> +#      # Set up a new build directory with optimized settings that will =
be
> +#      # installed into an alternative prefix.
> +#      $ meson setup --buildtype release --optimization 3 --strip --pref=
ix=3D/home/$USER build

"build" is the name that was already given to the build directory
above in this doc, so it might be better to use something else, like
maybe "build-optimized/".

> +#      # Set up a new build directory with a higher warning level. Level=
 2 is
> +#      # mostly equivalent to setting DEVELOPER=3D1, level 3 and "everyt=
hing"
> +#      # will enable even more warnings.
> +#      $ meson setup -Dwarning_level=3D2

There is no name for the new build directory in the above command,
maybe something like "build-warning/" should be added.

> +#      # Set up a new build directory with 'address' and 'undefined' san=
itizers
> +#      # using Clang.
> +#      $ CC=3Dclang meson setup -Db_sanitize=3Daddress,undefined build

Maybe "build-address/" instead of "build".

> +#      # Disable tests in a preexisting build directory.
> +#      $ meson configure -Dtests=3Dfalse

What happens if we run `meson test` then?

> +#      # Disable features based on Python
> +#      $ meson configure -Dpython=3Ddisabled
> +#
> +# Options have a type like booleans, choices, strings or features. Featu=
res are
> +# somewhat special as they can have one of three values: enabled, disabl=
ed or
> +# auto. While the first two values are self-explanatory, "auto" will ena=
ble or
> +# disable the feature based on the availability of prerequisites to supp=
ort it.
> +# Python-based features for example will be enabled automatically when a=
 Python
> +# interpreter could be found. The default value of such features can be =
changed
> +# globally via `meson setup --auto-features=3D{enabled,disabled,auto}`, =
which
> +# will set the value of all features with a value of "auto" to the provi=
ded one
> +# by default.

"globally" here means for all the builds directories of the current
system user, or for all the build directories inside the directory
where `meson setup --auto-features=3D{enabled,disabled,auto}` was run,
or just for all the features in the current build directory if this is
run inside a build directory?

> +# It is also possible to store a set of configuration options in machine=
 files.
> +# This can be useful in case you regularly want to reuse the same set of=
 options:
> +#
> +#   [binaries]
> +#   c =3D ['clang']
> +#   ar =3D ['ar']
> +#
> +#   [project options]
> +#   gettext =3D 'disabled'
> +#   default_editor =3D 'vim'
> +#
> +#   [built-in options]
> +#   b_lto =3D true
> +#   b_sanitize =3D 'address,undefined'
> +#
> +# These machine files can be passed to Meson via `meson setup --native-f=
ile`.

I think it might be helpful to say that "machine files" is the name
used by meson for basically "config files".

Also it's not very clear which build directories will be impacted when
`meson setup --native-file my-machine-file` is run.

> +# Subproject wrappers
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# Subproject wrappers are a feature provided by Meson that allow the aut=
omatic

s/allow/allows/

> +# fallback to a "wrapped" dependency in case the dependency is not provi=
ded by
> +# the system. For example if the system is lacking curl, then Meson will=
 use
> +# "subprojects/curl.wrap" to set up curl as a subproject and compile and=
 link
> +# the dependency into Git itself. This is especially helpful on systems =
like
> +# Windows, where you typically don't have such dependencies installed.
> +#
> +# The use of subproject wrappers can be disabled by executing `meson set=
up
> +# --wrap-mode nofallback`.

It's not very clear which build directories will be impacted by this comman=
d.

Thanks.
