Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071928643C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775842; cv=none; b=Zn73ptJIYqGrdbV4VSbuOGUZRPH9TNEkEMgDh2xi/wl8E5HNGtbyhvvBM4w9UaKJ5iY1LfwnNxHG9luH17hK80H9xo56t7fS8vfXAaqHtPpsyXZFtIiQLXnlSPxmNCEZOzw1Z1kv/DiXImc1F1UjIztxuOZjXtJuqvlOsg1agjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775842; c=relaxed/simple;
	bh=LteWfTJr/pcie9KUTa2GsAfR4zCadirZ6sQqjLjfzLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfuPqoNxPTp63LwF/2TRdQi4rm0CljnukydRn6cLbPYCfNjkYoimTjAs0qbu79vwrxi81sjoePXDfcckW0r9kscxsE7pAsQ0eSkSLY9fFNH9OWZtBgjF+IFe09lbTokvAvSUhpqMdVRkmT0te1436W0xzAVBPEweCRGEYihjPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPsXZd6r; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPsXZd6r"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378d6fa5aebso3361351fa.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761775839; x=1762380639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0chLyyuHcYKWHBlR0HI0qToZbVFAkU0/aG1UiXNkRX0=;
        b=fPsXZd6rHoYrTITd9tg/mYivTHPEf6VAVAj5Xg8yFlsK36MzUbeYVfqitJOTlhE6rW
         NjmLHImvphuXCuKwWyHq2hoE/F4AMS373fVrKBf9K+AqTWJ82y5PYLqyBnIR+Cqao+e2
         2SSSIBkFKxCM5wK72EFeM09sJcveX9GEIISNC4zDBoZ5BmG0zFms4OBXwExrAsJp3O1a
         fNmC3GX5QjaBofeFhXaWiJeFBUxQ/MeJW7MIbqQqixAKGQvVa0AJBr42vIUwMa2DKv+6
         +dMEKTsO0keNBpZoWjJetvGh7c61rQ6Xt0LwYT5iTBwN2MvmseIMWfH5r+aSQhszV4XQ
         vcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761775839; x=1762380639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0chLyyuHcYKWHBlR0HI0qToZbVFAkU0/aG1UiXNkRX0=;
        b=bXAFrcXaO2njtsvechfGrZe6oIv3M1QxGmR5sX/3Ok4Gs+y+hFLGadKUCTfuHJ9L0y
         UFKy5wwVPpCTzfq0B0b1/TvAMZYDbcd4CNsjm6flnGhKZ6J243laA5bH2MYQ0bo7KHUo
         RFd3NxjdAbAK29c/nu3ZnYVsA6kjcAOUkK1h3QxwhKBVmT41gBBBC+DuXgjCPan6AvKV
         MoFBBEWoTwVokkEbA/NaIIYStiEslNkGo/fOdWenAhZk8x/ZlK6NRQFF9n2AXMV2wpZ3
         vDRM31BkXdiNHrOar90MkS56MA+adkXZ3trFYwGNZUdKm7DDkhlBwMx6u1FhIbi2ob/+
         fpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOZE7sUkvCcAUxQzlCyUDEmODFPDAvTz4gVAv7F9HWEQQFF/41MR0PdL3MBSV7RgaFIac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTceHH7FCFdkZJNwY0iIEpOqtUgYdhJ2WgXnHY2fvlMuyFRmD
	tXSrFZaK6CdL3MBjJOSQlAUspZPIKDp5i8cgbuRkOA3UlBp/NLAiedOoVPkOasotq3urej4as7G
	bZR0Yu0moq5g49oN5JgAHQ+ZE2VXiHMs=
X-Gm-Gg: ASbGncuVp4vaI7UNzkFXBH70AGbtSSypw8azy417+nBlBKnX9VPiMbQDPJ9NjA9WFBn
	Hj1P7cEXXLEoVWnkW3MlO+VplRYfKCyCi1R9GH/Z/2WbSM2iMlf6wGOJSUfLhFlBZyMO7i1/IQY
	hMhzIWcJ8ZmocoRjpZ5QCr4qLTSZjrV8q1MFqzXtmc+pjIaW/0AdjK8VfVKH4jIGpX9ubonZhpi
	Uv7JBcZGdvaCA/QpCeSnPV4FNg9jueEK2f6ReVwsFq3w6nABvvSl0+Gp/DudQ==
X-Google-Smtp-Source: AGHT+IHsrdwarp7sWAxQnbAilVzKBWvKXUJzsqY7whEHqx7euUl7wUxg/IkGqv8Veei+0pQrMvY5PoXSo830UEtEUgw=
X-Received: by 2002:a05:651c:881:b0:378:e465:590a with SMTP id
 38308e7fff4ca-37a052e42a1mr15116421fa.44.1761775838363; Wed, 29 Oct 2025
 15:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-11-sandals@crustytoothpaste.net> <xmqqms59acak.fsf@gitster.g>
In-Reply-To: <xmqqms59acak.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 29 Oct 2025 16:10:27 -0600
X-Gm-Features: AWmQ_bnp24xiQNTVNkA95xkFJnwmoKi5-cmikhtwn1fgtFAltVDQvAyjeqPiBe4
Message-ID: <CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:43=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > Cargo uses the build.rs script to determine how to compile and link a
> > binary.  The only binary we're generating, however, is for our tests,
> > but in a future commit, we're going to link against libgit.a for some
> > functionality and we'll need to make sure the test binaries are
> > complete.
>
> OK.
>
> > -$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
> > +$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(XDIFF_LIB) $(LIB_FILE) $(REF=
TABLE_LIB)
> >       $(QUIET_CARGO)cargo build $(CARGO_ARGS)
> > ...
> > +fn main() {
> > +    println!("cargo::rustc-link-search=3D.");
> > +    println!("cargo::rustc-link-search=3Dreftable");
> > +    println!("cargo::rustc-link-search=3Dxdiff");
> > +    println!("cargo::rustc-link-lib=3Dgit");
> > +    println!("cargo::rustc-link-lib=3Dreftable");
> > +    println!("cargo::rustc-link-lib=3Dz");
> > +    println!("cargo::rustc-link-lib=3Dxdiff");
> > +}
>
> Hmm, I recall Ezekiel earlier arguing to roll reftable and xdiff
> libraries into libgit.a as it is a lot more cumbersome to have to
> link with multiple libraries (sorry, I may be misremembering and do
> not have reference handy), but if the above is all it takes to link
> with these, perhaps it is not such a huge deal?

I think Brian might have written this before my series was merged in.

> I am a bit confused.
>
> XDIFF_LIB and REFTABLE_LIB are gone from Makefile on 'master'
> already.  Perhaps we should revert earlier series from him?

I don't think we should revert my series. Brian should delete certain
lines like so:

 fn main() {
     println!("cargo::rustc-link-search=3D.");
-    println!("cargo::rustc-link-search=3Dreftable");
-    println!("cargo::rustc-link-search=3Dxdiff");
     println!("cargo::rustc-link-lib=3Dgit");
-    println!("cargo::rustc-link-lib=3Dreftable");
     println!("cargo::rustc-link-lib=3Dz");
-    println!("cargo::rustc-link-lib=3Dxdiff");
 }

Also the makefile needs to add the flag -fPIC or -fPIE when compiling with =
Rust.
