Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78112BDC05
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680235; cv=none; b=GC9u0IdgLZdT6LQ2FsDa3OhDK5/IkaHtDT/hUxC+rxs8ucnogh+P1KXCFrk7uT54ik0U185ixV8xpBTNcBV5GW/7agNGQbcdYtkbc6Rmo8a2KeZd7wxv262BTPIL0Rur1gZ5byqgsE+VShhKNyHGF9yeQaDQp47l5mKkTRjs6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680235; c=relaxed/simple;
	bh=IMTvDFYLV4ckdRHBiIKTRe+Ggvt0reK/Te4Ly2exzMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxAAne2vwneJetr1s+e+UCBDWY7BB8kTR0D57xVMuA0opMcFF7rlaMbe59TicNLqPyUnWCanfiNq2rp9d0iDHw6UFpSYkI2gVkLZQN4EerU0sqVKnb9k/mYTS8XY+Fn9x3/p6ItiNWnwVTtgDQEN08igvTFjAKuErewxKzM2FT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtPJVYD3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtPJVYD3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378de7d3057so57880721fa.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761680232; x=1762285032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3XvbWgdI7pRtfxjvi/BYafT69muSjbqvGPA3z3FgFI=;
        b=YtPJVYD3TdVfhVFuNrW0eKBdXT2e+Yk+A7qB/8coRl7VRQVhrYnVl1bvlTyzhItfrT
         WE1lo8pPylJuF9Ps/F4Ypz+jMlZhQvrljjy62KaM6xaUr9NCkDbBPGqRl0oy8nUvmzu/
         vtYGq6eE5OKjxqlNBr6Gu/TSA9SLE+od05kM96wkoPzDyswcreEJMVKux3y/k8gfahq7
         n8/dn9xw6pSKKQ5ZVldQEPJL6d9sxGfOXdbYgV7UkMzlbj08uMFZnzJ+y13Q1k8GFegO
         WIRFB1tOjHwGKtn2/yGxyp1CsSxguclWG2IoZzLWBONZCX5BJI37MoUtREbxplx6NPoj
         KSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680232; x=1762285032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3XvbWgdI7pRtfxjvi/BYafT69muSjbqvGPA3z3FgFI=;
        b=roUh6m4xMpx/JCsMN+U467mQwFF+ssfq+44hdRXLOCFYAcagYuTUKUefwi5C9COecf
         hhnqenPkasALYzZgGUsuk+KKm31HEjfr1uN+la6u5HH3P2wOI60V4mmugor7XvLhooR8
         hXHP8kexiAmmFtMZCDSY/eUBQ9KMT4MgEKmEe+IxZQWwLDIfIvPF8C4EBkovtoR+eHMx
         YU/mEV+uEjWulcrxynTDsKSED87VZqlsNGMx65vuh6PkNf0fiCJgzg3T/2LqRIwS3pY0
         s5yS6ADb5LVovxlGwq3NCx1Z38dK4Chd2ZTaBexpBy/QzZ6uvz5oC4e4wSzhb5c5j3jG
         FL9A==
X-Gm-Message-State: AOJu0Yxyuu9ctFBdIlwnRT7QEgUSB4Fe9UuFrP4m/Fq4yp/wwwMIjKBy
	OwWPXZ6r/OnqOyzeMaG18spWQUMFICHMnowkMjhyOfGF59HQZlh3mBpE5VtzWLoqcDwE6RRzW39
	3AlOtRHKOcp7LioQtolHC4zU+oGG6QRIUcVo6
X-Gm-Gg: ASbGncu+JAFd6F2dc+o9vedpRutVvyGfLZlBd0XNw20PYPxQ5f45TTwryiHFEdo1IyJ
	34rip2Gn0vX/aeiQkKxlw34lkRgw4p4B64S//bH44NXaE7NX/6sqPjAZe4svMB7TkIFPy6Bh2EP
	W3otm1weX3SzM5jLhtiJbL/up0tN8jwFew5hvJVySiyAZLH/bTtqUqm8641BnSqy2gdMs6aboFM
	vFsLEuqcsuVJFgKFYWQMUjn5LJocf/j+XNdDovRVMn3ldEKI4OVOfEMLsVYXg==
X-Google-Smtp-Source: AGHT+IE1F08ApV/TJ9IBX0oKuGKEcQVE2TBeubB8bklVHXkt1Oresj4n956vfjx238n3LaU2N/Wr2D/pphdX2bEe874=
X-Received: by 2002:a2e:a016:0:10b0:378:d65a:9ceb with SMTP id
 38308e7fff4ca-37a023fac0emr1655911fa.24.1761680231686; Tue, 28 Oct 2025
 12:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im> <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:37:00 -0600
X-Gm-Features: AWmQ_bkaby5abXO1UfPqoNezJ_Fo3u3YqGb2RWq7wXzOmAGjaFbeAZaD1Y-aq1I
Message-ID: <CAH=ZcbAC_u88_cD33bRxAuAPhJh02zNOHAVnkhxthncDFdZOOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rust: generate bindings via cbindgen
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this small patch series introduces support for cbindgen(1). This tool is
> used to generate C headers from `extern "C"` blocks so that Rust code
> can easily be called from C code.
>
> For now, the only use case is to verify that our varint reimplementation
> matches the C implementation. But later on this can and will be used to
> call Rust-specific features from C, as well.
>
> The topic is built on top of c54a18ef67 (The twenty-second batch,
> 2025-10-22) with ps/ci-rust at e509b5b8be (rust: support for Windows,
> 2025-10-15) merged into it.
>
> Changes in v2:
>   - Take some of the pieces from Ezekiel's "cbindgen.toml" file. I have
>     not yet taken `usize_is_size_t`, as that option requires cbindgen
>     v0.16.0, which is not available on Ubuntu 20.04.
>   - Backfill missing jobs for GitLab CI.
>   - Fix CI failures on Alma Linux 8 because cbindgen isn't available
>     there.
>   - Link to v1: https://lore.kernel.org/r/20251023-b4-pks-rust-cbindgen-v=
1-0-c19b61b03127@pks.im

I really think that this patch series should include migrating to a
Cargo Workspace. That'll mean moving /Cargo.toml and /src into
gitcore/ and creating a new top-level /Cargo.toml with the following
content:
[workspace]
members =3D [
    "gitcore",
]
resolver =3D "2"

Along with the other cascading refactor changes needed to make this
work. Let's do this now while it's still easy.

If we don't do this now then we'll be locked into a single crate
project forever because there'll be too much momentum later. Having
the ability to define multiple crates allows us to:
* Easier to understand the big picture of Git as each logical
component will be its own crate
* Make Git more modular
* Design better api interfaces between logically separate code
* define a header file per crate via cbindgen
* avoid gordian knot problems from making Rust a monolithic component
* easier to reduce dependency sprawl as each crate only defines what it nee=
ds
* Improves compile times through incremental rebuilds. Cargo caches
build artifacts per crate. When only one crate changes, others don=E2=80=99=
t
need to recompile. This becomes a major quality-of-life improvement as
the Rust footprint grows.
