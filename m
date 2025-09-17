Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701E2FFDF7
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150477; cv=none; b=B/fUXBEiFj462vdc39CYW4Kw59usZXiS5ikCj2wYkc3kgPxkCzMnS28FsA0lmE3jbRernuPcpW0icauAeq08naeckNIB3Rb+L+8wBEneL9+EKDIjhbLLEqh30LRADG6hqJiQ4YdVovaA1RF/FzCwdd/A0atFOluGPN4GDQHXbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150477; c=relaxed/simple;
	bh=2rdofsvNDxwsQcB+rdTJHBcX3xGMdAG6ny9bf8X6RF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nT0RVu0Kh/Kvkvll7YQr9WSK6uIWKhDMxOPad3w9zVP3SqhGmBDyQh9KsnlHpNs5xVFHfkj70VmVBM2LZ5Ssn3rroG0a3bQQEcVLaECYHZujYVA/3M4tq8C+KK57nGOW/Yi4IN6Bi/LCUhEyd9aZMUjTNXX1AgyQUK091HpRmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/BTBMKY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/BTBMKY"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so73878966b.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758150474; x=1758755274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n1cgZ0A5r3GTDp2Zn7axQr/tVFa6KmqOjJWYol3C2s=;
        b=A/BTBMKYjQk7bFbmINp9SfZv27uyzKoTAEaNegOrIV2YAxOuXgP0oZS77z423//z0/
         pDj4LHK1ljZXJYMZGDVjpyzwNJaaDblaJrlNFbrEWN1A5y/KU77t1a4IWfqSspd1HLKK
         ED0dRmqM1Idun2zN5YvVIHVUgrYV1cIRmyTjuq3omXL8LRyVAPeqlmfwewtnklND1wmM
         p+ZED+EFIJDJKLsGezjTyqEp6VX+xapkfR08ZvjMNDJmHsFsVWSmZvvZKrmhTLhAzQq1
         r2mWTvF1u4MMW17U+vphU9EBAhI8KVuCN5j+AdXPai9oFnFEBGXOaVm+akjIMJOfH/SR
         WkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150474; x=1758755274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5n1cgZ0A5r3GTDp2Zn7axQr/tVFa6KmqOjJWYol3C2s=;
        b=UgjR7Y+HtPv24cztUJkrvpw3KJZGKxt2FniRRywUJ+9RInrb273ZMdavicDsCbHrph
         GGHID2RO1eH4BEZpef1UFPw/F0Amf5Au8ae3mMC4LgBoyQPD08QiV/mkIbXUYMpzaDBA
         +V1B3wewl+aBZng0jcROCWf4McD1KYO6k1NLKL66MVzVZ37fdJp8k1kJRyw8Zmjqgs5b
         W65S8zL2gSkSZ+HbWE0o/eGi73SKREodIAzWUc5Q2TX7ONp5UTW7nPGNBuO9Np4QYcxh
         x1TZXA+5n74byARY2Kod3s8sPchwwm2GzmzRVEaGtbij1yQDSbolgB4HquhGTEBcCEp4
         Qdlw==
X-Forwarded-Encrypted: i=1; AJvYcCWWmzsnZ3wqaYGgKm4PARI76w6zcUTCcfaKeGA9NJYigyRXM++DEqMWgg6Fd1OBU2b50G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaat3FutvOZ6ATh70qDgaiPKnJ943ni029G9rv6auO4wk6U6fj
	TURA5vjEgquJFkYLZHhbqO+oNSbWnb2Yyu+mWc0i1JkXBMQlV9sErxYlalh23fsDQX3E9Ro9tjz
	8AG2QDs6I1u/OeFLwXIpIuD3jWyCAGUCGH40z
X-Gm-Gg: ASbGncvUAF5l+retjWG7rjwBsD1kBHqE4T4KQw79KaawpQKo7042pSLTdfZnH5l05og
	C4QARGQCSqKpqP0fr7HJUB9ciOiTBjHT/U3Z1voMSzWzxdv9ozfFeUb3ylyjAI5TherfLPZSFu5
	6bSz/zbXhAA2e2FfoSIqQMlCPQmvh+Wt5riNkaMU4hzEAA5UfbkkO4v/N4FMii02fCGaTRLMuxv
	8DQU0n0bp4glUkEGKllNA4i6E7BkZlaa3CV/nWRLXPv1DX0GPkErz4cYTfT
X-Google-Smtp-Source: AGHT+IFHoqdhlXI/tCJJkXBgMSt/pnxVnBrcGIVhr9UF2m43xOnxHv3VFOWFkTs+Y7sl3FxrWMBMgSSxbD8LVH7yPXk=
X-Received: by 2002:a17:907:6d09:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b1fab243914mr132515066b.16.1758150474336; Wed, 17 Sep 2025
 16:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6a27e07e6310b6cad0e3feae817269b9b8eaed69.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mffjoXZ4eqcw@mail.gmail.com>
In-Reply-To: <CAPig+cTZch_pvfurtjBTNphMeRQL6jSBSjNY-4mffjoXZ4eqcw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 17 Sep 2025 19:07:43 -0400
X-Gm-Features: AS18NWCHEUqaJ1Fa6HppMEEXlwTSsEU6BcE5G1UN6WqqLQyjbJtAxA_O9GRl6_c
Message-ID: <CALnO6CAmNTAOj0wkkPoEMOhHB1bgM4xBKa1=4zuS1Cs=UAq_BA@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] build-helper: link against libgit.a and any
 other required C libraries
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 4:52=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Tue, Sep 16, 2025 at 9:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
> > +impl BuildHelper {
> > +    pub fn build(self) {
> > +        let use_linking =3D parse_bool_from_option(self.crate_env.get(=
"USE_LINKING"), self.crate_env.get("CARGO_TARGET_DIR").is_none());
> > +        ...
> > +            println!("cargo:warning=3D{} is not linking against C obje=
cts, `USE_LINKING=3Dtrue cargo test`", self.crate_env["CARGO_PKG_NAME"]);
>
> There are more than a few developers on this project (including
> myself) who still use 80-column editors and terminals. As a general
> style guideline, this project does recommend wrapping code to fit
> within 80 columns (except in cases when doing so would severely hurt
> readability). I imagine that the same sort of guideline would be
> appreciated in Rust code, as well, by those who still stick with 80
> columns.
>
> I bring this up because, although it hasn't been such a big deal with
> the existing C code, assuming that developers run `rustfmt` on the
> code before sending a patch series, then this may become an issue if
> different developers have `rustfmt` configured to enforce different
> maximum column width, especially since `rustfmt` is likely to reformat
> the entire file rather than just the region that has just been edited.
> So, if this code gets checked in as-is with these very wide lines, and
> then someone else, who has `rustfmt` configured for 80-columns edits
> the file, then it becomes a problem.
>
> As such, can we also add a project-wide `rustfmt.toml` which, at
> minimum, sets the maximum line width to 80? For instance:
>
>     max_width =3D 80
>

I believe rustfmt and Rust generally uses a 100 column limit.

See
- https://github.com/rust-lang/rust/pull/5340
- https://rust-lang.github.io/rustfmt/?version=3Dv1.8.0&search=3D#max_width

Perhaps you knew this, and are really suggesting we break with Rust
style for our own style?

For handling personal configs, we could try to maintain a config here
that repeats all the defaults, but that seems like more maintenance
headache than noticing unnecessary reformatting and reminding folks we
use the defaults (except where we have config that specifies
otherwise). Although the docs site doesn=E2=80=99t suggest the configs are
layered like for Git, so perhaps a blank config is sufficient to
enforce =C2=AB we use the defaults =C2=BB?

--=20
D. Ben Knoble
