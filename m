Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B112D1F1
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757220872; cv=none; b=PfBvAHtKFNywomSOGoj5S+FK7bpy1UbI3bWithulbkqZnCVYfLGo5mTsj6tQY/JE9yMNR2mlwColvVc3D8CUnN36iradaspTq7HvdQPzY6eSfZvoMDCvGSfrJs+otBye1WymhsbcQMG06mumAN0lK3h3BKX4BYARDvkkYekvWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757220872; c=relaxed/simple;
	bh=SDHP7Dgxq8jJWLAbq11HH4CisImwq4TR+rtCDkGz/lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh3akpO964r7pvFOn83rh4h9+lenw0mVkfz1yC9XqjYBebyrpFUzSeyitQJxUqNJPWgZWcPIDs54vQEdRjaKokXEfjVXyxf6s7YdjGGr9x5BKnYPje+SROdVy2CEpbnFNS9oF3XA1MxfXQDtzYmBuYZw23NVJs8I7ZguQOA7D0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8dLScIj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8dLScIj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso3059190a91.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 21:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757220871; x=1757825671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt66kt/eH3SL2cDcMcfd+aVktx6qHoWOybbOoyPmofg=;
        b=h8dLScIjkQw16B9zKcXC5sfIykQSV9Y/SPUGrQnNWvMDor8rE+x4mr1Y/x1QXv5sXt
         wb13EdjPFatqHexPf5gOlhBBduVu7sfr0KV/72VHdc15QD3f7YzGG3y4LEaSaRgPkhD/
         S83qjOIL1A54bgUSymQcjc3B0/5Bg32HJuj7fSWQOyzTPJXawEeDu6DtHz9yTBpViYyl
         ZlTglLVITiPxnhfCLtZZBguqkysZtmWXTYAUa38tJZ02WDHA0W4OBxBFcKlSI6SiB4WJ
         pAFVORdUesKIoN2YuYwVXUPIRIWTRiF0UxNzrKaETMOPEf23okz44RNQL7885scpiWZ1
         wA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757220871; x=1757825671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt66kt/eH3SL2cDcMcfd+aVktx6qHoWOybbOoyPmofg=;
        b=l6iAfKjeZ7aw4K/dWxBhicGJVqsSVb2pCThVjkBuAf6XVCCaDtJg9TxZd7SzasEP6V
         V92OASTHCTX7+7zFoTP1j1Ef8pGqnNqDlix+KfNpfE105Yh+16UW3h59V1Y5MYBgIEyT
         8btAzBZzx+J9lGZEC88kSg/fscdEy5ikmML3aPmv7aSZngh/jHVu3c8on2dFtbvfcJsM
         SF9ctLYGK0JRbeM19wUJlHamkYYqiVE+vO1iMZPoTkaiLGTjbSQWFiZJ99gMU6ZwwoR3
         PQAENUf94t8yOSdtGCQgGAtFeZVxHEGqHC0MSkTHx2ROV1Z9ZZEALoAq7jw7mD5a9yQb
         nUZw==
X-Gm-Message-State: AOJu0YxDKXvkB5dMMh+bNHfVoy/d1Y26KcXN696hrDlgO415WyX8BQjg
	p1T8GA/Dg+eThdwjE1msztK3Qls2aAePwV8WoOvnKDbBhwu7cdrA7gbPI0xwJM5ENAYpv22V03Q
	BvhUDOVVbj/D1j4OcSOSFERmoK6gosJo=
X-Gm-Gg: ASbGnct+JA+X3r4y3WytXNs4bynDm+B8ve6BYKtgEHHVE3dkEDCIgCjRAATjMnXY8Ca
	T+3D9kOs07heXObEqIkYUk6t0vpXg4Ax2q2MAjdwvMDSiJ0eo9P8SohnQuX6yVdzJW178P4dZo8
	x0r5NwF0B2YTUB6TD9XgY5ZalJ3dzcGi5f+/BxeyIbp9r763E8mccFLUX+2w4+aAcD/0l6EYzJk
	fgG3BP3GfYqnTTPbsw=
X-Google-Smtp-Source: AGHT+IGEiS8w0bboJEjdEExF3XuAAU2IrnGGMoNaHd55ULbqeGHDC0VZGFkjlcImnn2EegpnO0KH5K4mtr763DXWrdE=
X-Received: by 2002:a17:90b:48cc:b0:32d:439d:2aaa with SMTP id
 98e67ed59e1d1-32d43f1b4bcmr6378091a91.15.1757220870524; Sat, 06 Sep 2025
 21:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im> <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-1-6939cbf4a0b8@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 21:54:18 -0700
X-Gm-Features: Ac12FXwmxDeGY5N8EmI0ZpWx57Keadtbd_g9L7RTaS74hYjuaCQB9IvfI1K2gac
Message-ID: <CABPp-BGF9Ds=9bLKbWFEuatGmGycemwTMiyez_s3XMJR=M6xQw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/7] meson: add infrastructure to build internal
 Rust library
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Add the infrastructure into Meson to build an internal Rust library.
> Building the Rust parts of Git are for now entirely optional, as they
> are mostly intended as a test balloon for both Git developers, but also
> for distributors of Git. So for now, they may contain:
>
>   - New features that are not mission critical to Git and that users can
>     easily live without.
>
>   - Alternative implementations of small subsystems.
>
> If these test balloons are successful, we will eventually make Rust a
> mandatory dependency for our build process in Git 3.0.

Okay.

> The availability of a Rust toolchain will be auto-detected by Meson at
> setup time. This behaviour can be tweaked via the `-Drust=3D` feature
> toggle.

This goes against what you said above, because it turns it into
something other than a test balloon.  As I've said elsewhere, I don't
think this part is helpful; it reduces the amount of notice that
distributors and platforms have about our intent to make Rust
mandatory.

> Next to the linkable Rust library, also wire up tests that can be
> executed via `meson test`. This allows us to use the native unit testing
> capabilities of Rust.

Cool.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build       | 12 +++++++++++-
>  meson_options.txt |  2 ++
>  src/lib.rs        |  0
>  src/meson.build   | 15 +++++++++++++++
>  4 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index e8ec0eca165..5b2e9af1bf1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1702,8 +1702,17 @@ version_def_h =3D custom_target(
>  )
>  libgit_sources +=3D version_def_h
>
> +libgit_libraries =3D [ ]
> +
> +rust_available =3D add_languages('rust', native: false, required: get_op=
tion('rust'))
> +rust_option =3D get_option('rust').disable_auto_if(not rust_available)
> +if rust_option.allowed()
> +  subdir('src')
> +  libgit_c_args +=3D '-DWITH_RUST'
> +endif
> +
>  libgit =3D declare_dependency(
> -  link_with: static_library('git',
> +  link_with: libgit_libraries + static_library('git',
>      sources: libgit_sources,
>      c_args: libgit_c_args + [
>        '-DGIT_VERSION_H=3D"' + version_def_h.full_path() + '"',
> @@ -2239,6 +2248,7 @@ summary({
>    'pcre2': pcre2,
>    'perl': perl_features_enabled,
>    'python': target_python.found(),
> +  'rust': rust_option.allowed(),
>  }, section: 'Auto-detected features', bool_yn: true)
>
>  summary({
> diff --git a/meson_options.txt b/meson_options.txt
> index 1668f260a18..143dee9237c 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -71,6 +71,8 @@ option('zlib_backend', type: 'combo', choices: ['auto',=
 'zlib', 'zlib-ng'], valu
>  # Build tweaks.
>  option('breaking_changes', type: 'boolean', value: false,
>    description: 'Enable upcoming breaking changes.')
> +option('rust', type: 'feature', value: 'auto',
> +  description: 'Enable building with Rust.')
>  option('macos_use_homebrew_gettext', type: 'boolean', value: true,
>    description: 'Use gettext from Homebrew instead of the slightly-broken=
 system-provided one.')
>
> diff --git a/src/lib.rs b/src/lib.rs
> new file mode 100644
> index 00000000000..e69de29bb2d
> diff --git a/src/meson.build b/src/meson.build
> new file mode 100644
> index 00000000000..eb752651d35
> --- /dev/null
> +++ b/src/meson.build
> @@ -0,0 +1,15 @@
> +libgit_rs =3D static_library('git_rs',
> +  sources: [
> +    'lib.rs',
> +  ],
> +  rust_crate_type: 'staticlib',
> +)
> +libgit_libraries +=3D libgit_rs
> +
> +# The 'rust' module was only introduced in Meson 1.0. Furthermore, the m=
odule
> +# does not seem to work on macOS as expected right now. As such, we only
> +# conditionally enable tests.
> +if meson.version().version_compare('>=3D1.0.0') and host_machine.system(=
) !=3D 'darwin'
> +  rustmod =3D import('rust')
> +  rustmod.test('rust', libgit_rs)
> +endif

Would it make sense to invoke 'cargo test' as one step of 'meson test'
on mac as an alternative, so that mac users also can run the tests?
