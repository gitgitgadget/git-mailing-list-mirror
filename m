Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475F2F656A
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953832; cv=none; b=ZpHND5M0BzVIBooUF74aHM/QK8lauOHIRZj2NrymPfLK/dvrZxGnQH8dWAgrrCab0rBW+OhE+FHP8WHvTsoGUGsQ6DRw1cMo+Lw5SGZLWFjISVLocXIGarBUAFLV5xQHGfizEf806n2XpvjMJTxxgaEE0Bl9GRzUzTmnIlyneSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953832; c=relaxed/simple;
	bh=zEbBsYjcnnn5eYJaL0iuNciWl/rhMwI+W9ExtG8WkJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQPZYpWxNaPkMK/bx4HSOTLAxHTGuX1u9LaNxXlhrHA3U5VgHY0mcudLuZu3anL0WIfTGzWNpaPbk1mjiGuus+QWsSq4nDhvwGFtUSfDijEx7qEfTUrbnBg2Fq5ag56l7KAWIVAkSAnW20OTGsgw5azt0toGFhbtouWuo59N+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWU0qk0P; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWU0qk0P"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378e0f355b9so820171fa.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761953828; x=1762558628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVL24o/Mlcdwom695bhqpHHXZRCEcKrymncFC9CWVIY=;
        b=fWU0qk0PYoPqd4vJLhStFpS44SoAO9Qc73yRRws8aAIPDx4a6s97H3PBcJYXmJZ9S4
         4IHIPNS+l6XHGUphd9VVF5mnoYo+VbNP1LLB1LV6IyTl4/rk2AmiCXoBaLz2ya3SQxAM
         zXXNp9eMnMVlycrt8v7gxOJiQmX3rNUn5JqAZU8E0s5L1vb3uRoFELgDz/g/mSYYU8FU
         A63abSL6sO4tRC955FmvkOceddTHdh44JLpGEs1R7U43Rwjx5OrxxW+2kFvch7g4oyCS
         ACuRTWkR2JEafPK6qcc8F/gKWdMaQ02/HCY4KIH36WwNNxBtedS2w2lpse+vmat44wuJ
         Zoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761953828; x=1762558628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVL24o/Mlcdwom695bhqpHHXZRCEcKrymncFC9CWVIY=;
        b=rsU09LdEnphzXbeSzLmRmln73h00YpApzOxYLeYE6wZrrLGQ6on0Szfkj9fSNQxgIi
         A1d+DH/FrckfPGZDq0eaegFC+uixY94BIChjiQgfB5amxDnuaGPx6k88/ceiQp8MkXoS
         +hFUJdjASB1nsCad2ZbLZFPwyUMENIshOSfJacS8ezt+Htn53B0iyEthRVJzPguxFV9o
         yqQFhRHHQipSx0T4mNqVXLJK9yOtxsu0XLa6iIT8yBwccaM31KuxB2buRhQQcl4PNrKZ
         46FO25r5texBtMgXlCZdIB4EWhUd41xpfWGt4mniQWOf9XeIypGA1w8sp1mmmLCYHjOC
         Mgpw==
X-Forwarded-Encrypted: i=1; AJvYcCXnSh2Amtpk1nNe/+5Dmup+xwUje1RfnO/+D5K9TMU25nGYC7ckJQ1g2VyfzL64/ft6oZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKd+mB0JluTnweSg8L66HhgVaJkw7xcItHAnTjoJhxkQ2ZiACY
	ZI3iEvd6yDFh7MUFZMB/uU7I7H01fx27UaGB/s2LGnIt9AypBbMARExG0q1Y+SQMp5V3Cg+6Mem
	5xefA455mkFdMaZF3kTp8GFet+iC/p58=
X-Gm-Gg: ASbGncvbX9Wve5cD9Q2WYegCB3oX4JTmU1BinUoMcLTL/m0l/Hp00YVKxL8+UoxpXBD
	wDu8TH1B0svyT7Rdp33LLXHwEDuraiDDZliHXtPpdk+adV7jE8zepcuAVYAFkWKzwhi9besdKXy
	IxS4D2eGX9U5RC9UfNnqdhha5A2gz29IIlsmYpHr+b4iVsyq/aePDNN0WZC4FiseY72J8Mm71ds
	pGRdVe4Ktr32SDpTQiNGk7ofqrnrbbf8/+nyxQCq3o0Ctkap27uyAi0U99pBQ==
X-Google-Smtp-Source: AGHT+IF8a2dqVlt51OMWryxxE6OpJ+hBtG9CgHdb5oK6qgGXs+/Mz3dgwwoSVZf3VVsXXU+XFQIOjzbGuyIeSOR9lqI=
X-Received: by 2002:a05:651c:23d3:20b0:378:e055:315e with SMTP id
 38308e7fff4ca-37a18dc63d8mr13830171fa.24.1761953827858; Fri, 31 Oct 2025
 16:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im> <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im> <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net> <aQM0_6uRZcQYfO8R@pks.im>
In-Reply-To: <aQM0_6uRZcQYfO8R@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 31 Oct 2025 17:36:56 -0600
X-Gm-Features: AWmQ_bkuYTLf6ZGoGI2LSVU9v6Qtt2ATYnkwndMb8yWKdAUbmNmRf3ljnbSMwt8
Message-ID: <CAH=ZcbCq98m-yBcpoQG=iVN9EgRJrpjSWMq0QESs-1xSdRQu6Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 27, 2025 at 09:14:51PM +0000, brian m. carlson wrote:
> > On 2025-10-27 at 20:35:59, Ezekiel Newren wrote:
> > > On Fri, Oct 24, 2025 at 12:37=E2=80=AFAM Patrick Steinhardt <ps@pks.i=
m> wrote:
> > > > > cbindgen is a Rust crate and it should be specified in the Cargo.=
toml
> > > > > under [build-dependencies] block.
> > > >
> > > > What is the benefit for us? The generated code is not a dependency =
of
> > > > the Rust code, and neither do we use it via "build.rs". And if we u=
se
> > > > cbindgen via "Cargo.toml" we'd be forced to build it first, which s=
lows
> > > > down our CI jobs.
> > > >
> > > > Please let me know in case I miss any reasons to have it in our bui=
ld
> > > > dependencies instead.
> > >
> > > You're targeting a very old version of Rust (1.49). I'm not even sure
> > > that cbindgen will work with a version that old, but if it does then
> > > we should use it in build.rs to make sure we're not using any feature=
s
> > > of cbindgen that aren't available until later versions. If we use
> > > cbindgen that is packaged with the platform then we can't precisely
> > > control which version of cbindgen is being used. This is a matter of
> > > reproducibility. There may be platforms that can compile Rust, but
> > > can't generate C header files via cbindgen because cbindgen hard code=
s
> > > that a certain minimum Rust version is required in its own Cargo.toml
> > > file.
> >
> > Yes, I agree with this.  Not all systems have cbindgen and it's not
> > guaranteed that the system's cbindgen will work with the version of Rus=
t
> > that you want to target or that's being used to compile.
>
> Okay. In that case the question to me is how to drive cbindgen from our
> Makefile and from Meson if it's going to be invoked via "build.rs". It
> doesn't make much sense from my PoV to make generation of the C headers
> depend on building the complete Rust library. Doubly so because we'd now
> have a chicken-and-egg problem:
>
>   1. To build libgit.a we need to have the C interop header.
>
>   2. To build the C interop header we need to build the Rust library.
>
>   3. The Rust library depends on libgit.a.
>
> So am I missing anything obvious here for how to declare cbindgen in our
> "Cargo.toml" file and invoke it directly from our other build systems?

You would need a separate crate whose only job is to generate the
header files and then Makefile or Meson can be invoked. But since we
only have a single crate we can't do that.

As to why version 1.63.0 it's because of Debian [1]. "Our discussed
plan is to support the version in Debian stable, plus a
year.  So we'd be supporting 1.63.0 for a year after trixie's
release." - Brian M. Carlson

Rust version 1.49 can't use cbindgen newer than 0.1.0 (the latest is
0.29.2). Any cbindgen version newer than 0.1.0 requires a minimum of
Rust 1.68.0. The way that I got cbindgen to work with version 1.63.0
is that I overrode cbindgen's dependencies in Cargo.toml. That hack
only works so far because the older the Rust version the less likely
older and older sub dependencies will work.

Since you're worried about build times I think that cbindgen should be
in its own crate whose only job is to generate the header files and
then have the subsequent CI jobs copy in those generated header files.
For local development cargo will need to be invoked first to generate
the header files and then Makefile or Meson can be invoked. If we put
cbindgen into its own crate then we won't have a chicken-and-egg
problem. That's why we need to convert to a cargo workspace in this
patch series or before. It cannot come after.

[1]  https://lore.kernel.org/git/aHlp1joMwexLZAAb@fruit.crustytoothpaste.ne=
t/
