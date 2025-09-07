Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5DF9D6
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757221140; cv=none; b=dFEJRsnW1VF1NnFv/ZpL8Tf+48OARWnfgzrQ3Rlb5R/4oP3pZtYYFgddBA9vp3vZC85IqzZkpBAm+6VhBak14atbbu1OILtS4F1MhuY266Yo/iIN+alxkGaptzFMnSvQDrnUYdkjz9NjNVCAWJbMgmxAVeC87v2n1jXzjEtOER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757221140; c=relaxed/simple;
	bh=a1t4rF6r6G6US451pHun1cZEgenqgj5po2BlZnbvDTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGYnnTunJZFyYsOuD2uEtp3uaFchwm76fesFTqaVpuDVeLv9kUOhuR7AElaS9ulTJlg9FivuCrn05HBGfwrshxxhCbo7jmk5qkI9w5rec569pXvV7mhySzGNyNu5WgrrHtgC+X6WU4RkOmf5hWECtB2AY/SLwQXJ2G2Ga00msmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdT1LQBr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdT1LQBr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32b6132e51dso2570011a91.0
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 21:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757221138; x=1757825938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gZfCC/xDnb7ivqMSnp+A7iKnwvuzL3fryywmqqn1O8=;
        b=kdT1LQBrgapWgmONYnioe03Djd+H+Q/VFn8oBETonp5CxMZiQAs/mNJVJ6Yq6PSMND
         w/wDrgUl0UIlAs3gqrDUaqEeWTZC21Wc5XGUMKv99JKzhr763X25mFSvhmNq3TsFHZt8
         lhHkS8QCYaGanm4jevuNZRc3uBZfdwJ2d53EYcMXAJMIKTXM+b9rnZ0102rsP4Egd48p
         7PPfo8dMNM9o4bCK0mYP1bojO+/SSEolmIgezn+T9tMau8Et+NcVqyDuo6BXnizBjHqf
         vtRUgXYKBWvKCFVs/R9vU2y/9QUrfK/P7rJiS3ngo1kkrBDTiGDRq/hiQitRouQjOcdK
         jj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757221138; x=1757825938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gZfCC/xDnb7ivqMSnp+A7iKnwvuzL3fryywmqqn1O8=;
        b=MLhds7kvgiEBOl6Mr574ZDWgMcpDbAFCrjKsUIH0M6AXYxNSW9HYLxGdqrOLLmA/Q5
         NmvyrK2k3uCSD77zZW9d0FYkSMfLmiTEbf3Bg7ObS2XTgBGqkruLJXsSBGPIVHFh5N2u
         yoAeDcLCmsaSIJdqY+/i1EMNY7m3ZXiWQPaVa7K1PLVcg+9nb6B/jmrs2DR7tsQc4vQk
         n3VPFyASDLLsaHL3F+ElSE4EI/BdaeyZ0z8RqA5j7WPv2sPtzNcqw6bR75aZdayLIH4Z
         qAYS0H3RoJwMCDD/2lsdmEXIGA1JP1CfdASLGmvQ6jQWcxQgGIq3ivLvibxXKB4ElaQF
         zlCA==
X-Gm-Message-State: AOJu0Ywvfh20TYdRb1vyf/cCYBOpc+FQxt1fL+6hItL12BcZ/WNKJxU3
	vQs4hw+zM+RmdsS27C5nwQ8krYbndFcdL/khbTQINiSmg8vXNoEmpZUqlSkFO6buoegOy8yhwSa
	xmOjQsYFd+Zxx6sqlWqT0uoyp0Zl7DJ4=
X-Gm-Gg: ASbGncs76w8iuvMlT65byMLvQcirTlz4V2J3FaaY48iXd2udKWY5ci34lngZuFiYxJl
	wd0DtBQgHNQo8GYRCso4iiXpt23eDnb5/WGXYoRbGgcBrBERQRLWA1QtAKhbuipi0PBHoB5FC/9
	ztCourBeSZzHcmko8Gyr/ZgqSPEVTeeQZjWe2onyD5v7+QYFBxixXUUeRmwnorBOEmI2BVzVkq1
	a4Hd68h+BwkgyMqdC0=
X-Google-Smtp-Source: AGHT+IFKQqyCCJ5PHpt1QbwpyL2o8gco/+OkHmTrySLrThHN2Ih/nIv/+8tn9oyHFR8lrTqD3hWWqh21s9rqS7P28xQ=
X-Received: by 2002:a17:90b:2f8d:b0:329:e407:b536 with SMTP id
 98e67ed59e1d1-32d43ee7729mr5630058a91.3.1757221137806; Sat, 06 Sep 2025
 21:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im> <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-2-6939cbf4a0b8@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 21:58:44 -0700
X-Gm-Features: Ac12FXx4yfJ8SIuU9-oakF4HmTGv9a4lj9qgHXKjlttxBK2mifBVux9smTjtHlU
Message-ID: <CABPp-BEWS2=uHAjEf5YdahC3gxbjJ5L3NpYEgSSmsUa1dK=aeQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/7] Makefile: introduce infrastructure to build
 internal Rust library
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
> Introduce infrastructure to build the internal Rust library. This
> mirrors the infrastructure we have added to Meson in the preceding
> commit. Developers can enable the infrastructure by passing the new
> `WITH_RUST` build toggle.

So, again, this makes it not a test balloon, which reduces the amount
of notice distributors will get.  I'd prefer a WITHOUT_RUST build
toggle, so they get as much notice as possible.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitignore |  2 ++
>  Cargo.toml |  9 +++++++++
>  Makefile   | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 1803023427..0833453cf6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,4 +1,6 @@
>  /fuzz_corpora
> +/target/
> +/Cargo.lock
>  /GIT-BUILD-DIR
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
> diff --git a/Cargo.toml b/Cargo.toml
> new file mode 100644
> index 0000000000..17a4f4da0c
> --- /dev/null
> +++ b/Cargo.toml
> @@ -0,0 +1,9 @@
> +[package]
> +name =3D "git"
> +version =3D "0.1.0"
> +edition =3D "2021"
> +
> +[lib]
> +crate-type =3D ["staticlib"]
> +
> +[dependencies]
> diff --git a/Makefile b/Makefile
> index 555b7f4dc3..e7b3c8e57b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -483,6 +483,14 @@ include shared.mak
>  # Define LIBPCREDIR=3D/foo/bar if your PCRE header and library files are
>  # in /foo/bar/include and /foo/bar/lib directories.
>  #
> +# =3D=3D Optional Rust support =3D=3D
> +#
> +# Define WITH_RUST if you want to include features and subsystems writte=
n in
> +# Rust into Git. For now, Rust is still an optional feature of the build
> +# process. With Git 3.0 though, Rust will always be enabled.
> +#
> +# Building Rust code requires Cargo.
> +#
>  # =3D=3D SHA-1 and SHA-256 defines =3D=3D
>  #
>  # =3D=3D=3D SHA-1 backend =3D=3D=3D
> @@ -918,6 +926,11 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
>  LIB_FILE =3D libgit.a
>  XDIFF_LIB =3D xdiff/lib.a
>  REFTABLE_LIB =3D reftable/libreftable.a
> +ifdef DEBUG
> +RUST_LIB =3D target/debug/libgit.a
> +else
> +RUST_LIB =3D target/release/libgit.a
> +endif
>
>  GENERATED_H +=3D command-list.h
>  GENERATED_H +=3D config-list.h
> @@ -1387,8 +1400,12 @@ CLAR_TEST_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
>
>  UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
>
> -# xdiff and reftable libs may in turn depend on what is in libgit.a
> -GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB=
_FILE)
> +GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
> +ifdef WITH_RUST
> +GITLIBS +=3D $(RUST_LIB)
> +endif
> +# Other libs may in turn depend on what is in libgit.a.
> +GITLIBS +=3D $(LIB_FILE)
>  EXTLIBS =3D
>
>  GIT_USER_AGENT =3D git/$(GIT_VERSION)
> @@ -1411,6 +1428,19 @@ BASIC_LDFLAGS =3D
>  ARFLAGS =3D rcs
>  PTHREAD_CFLAGS =3D
>
> +# Rust flags
> +CARGO_ARGS =3D
> +ifndef V
> +CARGO_ARGS +=3D --quiet
> +endif
> +ifndef DEBUG
> +CARGO_ARGS +=3D --release
> +endif
> +
> +ifdef WITH_RUST
> +BASIC_CFLAGS +=3D -DWITH_RUST
> +endif
> +
>  # For the 'sparse' target
>  SPARSE_FLAGS ?=3D -std=3Dgnu99 -D__STDC_NO_VLA__
>  SP_EXTRA_FLAGS =3D
> @@ -2918,6 +2948,16 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
>  $(LIB_FILE): $(LIB_OBJS)
>         $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
> +$(RUST_LIB): FORCE
> +       @OLD_STAT=3D"$$(stat $@ 2>/dev/null)"; \
> +           cargo build $(CARGO_ARGS); \
> +           if test $$? !=3D 0 || test x"$$OLD_STAT" !=3D x"$$(stat $@ 2>=
/dev/null)"; then \
> +               echo '   ' CARGO $@; \
> +           fi
> +
> +.PHONY: rust
> +rust: $(RUST_LIB)
> +
>  $(XDIFF_LIB): $(XDIFF_OBJS)
>         $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>
> @@ -3768,6 +3808,7 @@ clean: profile-clean coverage-clean cocciclean
>         $(RM) $(FUZZ_PROGRAMS)
>         $(RM) $(SP_OBJ)
>         $(RM) $(HCC)
> +       $(RM) -r target/ Cargo.lock
>         $(RM) version-def.h
>         $(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
>         $(RM) $(test_bindir_programs)
>
> --
> 2.51.0.417.g1ba7204a04.dirty

Johannes provided some additional tooling (an extra library to
download from git-for-windows) that was needed for building and
linking against Rust on Windows, which Ezekiel incorporated into his
series.  Is that not needed here for some reason, or are we just not
discovering that it's needed since you haven't created a test balloon
yet?
