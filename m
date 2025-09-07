Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0C18EAB
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757222741; cv=none; b=EG762eSVriDOxZPpz83jmyZUojBxKoKtUZgvklbcEjolT3qQ87EctSgZbe74K3leUBR23elbSBeOBxT5uqz1tqAm1PULs4XevxMhLFmsEWcXy/qMOpsG+DRHnD0ZR4uRes4Kd/J9LPeSj5X7bCWshgKKbWo7rmlU76r9lcHkyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757222741; c=relaxed/simple;
	bh=z+LrCwoIZ018PsvN8OKRPOml/ahc/Hu/3zA0w1cCuf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sE7h51t0gV1QwQgsj3aXEOuXH+KKl3Pfu0v5y1ixi0MA8+pmw/1A9EI16+4UPXEb7gxJp3WsvISbhTRZA7lGBfa/G98kJ0UR9OxrBj/KlgYLO3RYorQiEVxycVFcy0Z2rUVrcHb3A/ANMuR75T8pWTijriAAlnsq0FlaLxNAeXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVAO26t4; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVAO26t4"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3f65d600d35so36403765ab.0
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757222739; x=1757827539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FlmPSrJOFGRwTy0+A787WYGK3HrsDybSuF2hY8I7M4=;
        b=fVAO26t4qM0/NoqHj2EEJ0XAHBOSRaG5Nt1/Y9egtFOro9odjIZxkq8zgkVUjXorxZ
         Z+jpfAy+xyxPXQmQMmZ6SK/xMf9BV/GdpKA7yOtVriZ/VjPK5JAnQa2K5kiKnz4eY3aD
         D3COUqSXxgjpS0GZIQfd+nVR39LvbRkKiSiNXhgiHTqurT16AMeZe/cU7mGOzdUND+kK
         +B5HYHl+Ntnj14/RzR/h15AgFv0/mwoOULu3okoxSknny+JcOJJmSIustdgB4ZCktg7i
         K4ywH+X0dz3ZKn6Qu9md/9mCt9I0CMb0UE9i7ivYX5SUP7/PESVceR680Kf8J44AX7Wa
         PQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757222739; x=1757827539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FlmPSrJOFGRwTy0+A787WYGK3HrsDybSuF2hY8I7M4=;
        b=gA4i9sao/YcD125Gimik4p7VWALwvGDyDr0Wvt+rbbrJNMKL+aqOVozj373RWk6K4M
         0LNSSDI3wz+7WdBcTT80EXG6BJbJJmZbMxrw6tIShAopnIIEEK4YNB23xYpRn11GNRH6
         I4efOdHGa/+O/0X8zzT7rh9qn9KvOx+vTgjXPwVtvLzr3XgcmTMDa1DulpHCAvIO05tL
         mk3+DyQICISrDzOkNL3spRjzgJRIhbgwvl/LmNWuFmV+Jvpz9dFXJgk8NG8QHrYtNrq/
         bWEVxrA0FB11rJbkNJirWI4MO6fYVLYTWRVoOFPbQAuZ0fqihlD3efaUgdQ9+4sGY732
         duYw==
X-Gm-Message-State: AOJu0Ywv1AFJFBGejwdgRcEr/E3tz+WTNjHXsfHQ7IMVK5N5y9zT6Jyk
	oXN8px+0FLXlZBOwyE5gvq7jUlY5aCbBFTCisx8XIx++OsZZSBv4Dp9IEbvPCHp2Nh1GjvXYPD+
	j1rjFr51JqMyc0qFWUpXh/XyZzScRwy0=
X-Gm-Gg: ASbGncs+kjVMbvOuL8j9UWGYp9ALCYXCDzio6PDqbx99YPcqxvel9AZVPEb9qiqZdh0
	9WxfEnV3jjlfi3AmzaErMAF+pPqweaqGaSqRudcM84ida3JVHNUn8r6p5EIC220BPVK/P9knpgM
	NiXmFxOdefIBbY/cxXJjCevQP7Y+NmvE+7Vgf3FjittPkcI/Lz5MW2bxWeP4/co3Dcd+B/2BnMl
	w/TNDtA9k2+pIJTa34=
X-Google-Smtp-Source: AGHT+IF0hecwuQfxuQ3UzEeXqMLtZuc5CsVtT3gCppfJ0C2z7rG7yGEdFDOe/MNR4oxn2x5ePc2EYZoHQqHUEyrziXM=
X-Received: by 2002:a05:6e02:2169:b0:3f9:8b63:9269 with SMTP id
 e9e14a558f8ab-3fd94a12994mr72703315ab.18.1757222738605; Sat, 06 Sep 2025
 22:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im> <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 22:25:27 -0700
X-Gm-Features: Ac12FXxcPCtiKi_VIJUHFn5rfH8jwg-2ExnTnsf_pR6hlsVzeft9E5_-R8lNdWY
Message-ID: <CABPp-BFXRbaHk9U3BX+d12bZ+ryGOp+btR0ODMw+HtD7xd+MBQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming mandatory
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
> Over the last couple of years the appetite for bringin Rust into the
> codebase has grown significantly across the developer base. Introducing
> Rust is a major change though and has ramifications for the whole
> ecosystem:
>
>   - Some platforms haven't yet been able to implement a Rust toolchain,
>     even though it is possible in theory.
>
>   - Some platforms don't have any support for Rust at all.
>
>   - Some platforms may have to figure out how to fit Rust into their
>     bootstrapping sequence.
>
> Due to this, and given that Git is a critical piece of infrastructure
> for the whole industry, we cannot just introduce such a heavyweight
> dependency without doing our due diligence.
>
> Instead, preceding commits have introduced a test balloon into our build
> infrastructure that convert one tiny subsystem to use Rust.  For now,
> using Rust to build that subsystem is entirely optional -- if no Rust
> support is available, we continue to use the C implementation. This test
> balloon has the intention to give distributions time and let them ease
> into our adoption of Rust.

This paragraph appears to contradict itself -- it says we introduced a
test balloon, but then explains how the test balloon isn't actually a
test balloon (i.e. that we simply silently use the C implementation if
Rust isn't available).

> Having multiple implementations of the same subsystem is not sustainable
> though, and the plan is to eventually be able to use Rust freely all
> across our codebase. As such, there is the intent to make Rust become a
> mandatory part of our build process.
>
> Add an announcement to our breaking changes that Rust will become
> mandatory in Git 3.0. A (very careful and non-binding) estimate might be
> that this major release might be released in the second half of next
> year, which should give distributors enough time to prepare for the
> change.

While I disagree with lumping the change with 3.0, I appreciate the
goal to provide additional notice.  I think it really ought to be part
of the release notes for 2.52 instead of the BreakingChanges document,
but having some kind of announcement is the most important part.
Thanks for proposing some wording.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.adoc | 36 ++++++++++++++++++++++++++++++++=
++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingC=
hanges.adoc
> index f8d2eba061..dbb15b6a57 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -165,6 +165,42 @@ A prerequisite for this change is that the ecosystem=
 is ready to support the
>  "reftable" format. Most importantly, alternative implementations of Git =
like
>  JGit, libgit2 and Gitoxide need to support it.
>
> +* Git will require Rust as a mandatory part of the build process. While =
Git
> +  already started to adopt Rust in the Git 2.52, all parts written in Ru=
st are
> +  optional for the time being. This includes:

This isn't quite accurate; perhaps:

...While Git already started to adopt Rust into the core in Git 2.52
(and as an optional "contrib" component back in Git 2.49), all
parts...

> ++
> +  ** Subsystems that have an alternative implementation in Rust to test
> +     interoperability between our C and Rust codebase.
> +  ** Newly written features that are not mission critical for a fully fu=
nctional
> +     Git client.
> ++
> +These changes are meant as test balloons to allow distributors of Git to=
 prepare
> +for Rust becoming a mandatory part of the build process. There will be m=
ultiple
> +milestones for the introduction of Rust:
> ++
> +1. Initially, with Git 2.52, support for Rust will be auto-detected by R=
ust and
> +   disabled in our Makefile so that the project can sort out the initial
> +   infrastructure.
> +2. In Git 2.53, support for Rust will be made mandatory in case Git is c=
ompiled
> +   with breaking changes. Breaking changes can be enabled for Meson by s=
aying
> +   `meson configure -Dbreaking_changes=3Dtrue` and for Makefiles via `ma=
ke
> +   WITH_BREAKING_CHANGES=3DYesPlease`. It will still be possible to comp=
ile with
> +   breaking changes, but explicitly disable Rust.

As stated in https://lore.kernel.org/git/20250904-b4-pks-rust-breaking-chan=
ge-v1-0-3af1d25e0be9@pks.im/T/#mf9283df5e7724fd00a6fe23e1777b77fcdf0c12d,
I don't see how these two step help at all, and think we should jump
straight to step 3 with Git 2.52.

> +3. In Git 2.54, both build systems will default-enable support for Rust =
so that
> +   builds will break if Rust is not available on the build host. The use=
 of Rust
> +   can still be explicitly disabled via build flags.
> +4. In Git 3.0, the build options will be removed and support for Rust is
> +   mandatory.
> ++
> +You can explicitly ask both Meson and our Makefile-based system to enabl=
e Rust
> +by saying `meson configure -Drust=3Denabled` and `make WITH_RUST=3DYesPl=
ease`,
> +respectively.

I think we should instead allow folks to ask Meson and Maskfile to
disable Rust, otherwise we haven't provided a test balloon yet.

> ++
> +The Git project will declare the last version before Git 3.0 to be a lon=
g-term
> +support release that is maintained until alternate Rust backends like gc=
c-rs are
> +able to build Git. The Git project may need to rely on distributions to =
help
> +with identifying and backporting important bugfixes.

I disagree with tying the timeline to gcc-rs being able to build git;
I think that part of this paragraph should be stricken.
