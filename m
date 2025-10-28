Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682ED20F08C
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678471; cv=none; b=GCYSyGz27WCQq+UhrhdtRpEVzwjJ18V6uh8PcoBUx6QusXlAkpYnFc1+A/8ItVxQofj8w5BMCQ1O6sBXMGmpNazFjidAo+xZDe+V52leuc7qeS006tWW2xZQ+uSovmrNRcW8Iyzn7BeV2qdeaqRlaia/SMsMPWz93V+9CT7D1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678471; c=relaxed/simple;
	bh=nie9UKV3UQXHAdb6obkhgwnnFnxr6aKDaW9H/YcHQCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWTY7pBja5Eq43D8saPxQqFpd5tl6e0w410dY8XJgPSSHn4j/5vb4Y30ejjHJmNl9KioRVAfGRJyChnSTWlgKjNtqMNFjoT0BAGp3254LYQoBg1dY95O2o0hZuKLsLp+3kYTXlSwzvLimDRr7k7xTv73LGtfdl3cXwKPSPlpAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkcWUCwS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkcWUCwS"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36bf096b092so60497731fa.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678468; x=1762283268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQUp399lCiOssgFIiIxjK4lyUmwkGn3DmnE7vy0HR7c=;
        b=EkcWUCwSDi4UtdSDeCdT7NXo+RNIZZu/CVgJVBWRenNFW5dx9IGJ3SlBYm1lpWWTFA
         gFesp2EYF7LEIyxUif2rJSBv/WTRxU1Zl45CQRapXTDoGMwBj/AlDopbU8vhx7rEgt1D
         EKG5JDM/BLl4oij8x79B1ryOqCy0HlcoTlvOcGPl00bSxstuJHAW5I7OI78aHgiz1bnu
         lJTb8urSJYXyK6akVPAEtcL5eaCXyI/OwJ0j9cndMxGNVfbAmAfRqnppHhKJ87dKYFg7
         lOCtI7sdciiKJX611X8SbXNsjGAfti2UCoIvk1LXz24AbfbSGK49lRcosuAhv9pq3/rl
         sNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678468; x=1762283268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQUp399lCiOssgFIiIxjK4lyUmwkGn3DmnE7vy0HR7c=;
        b=Drccj9ITvpKSNTIra4oVCezp5PgPqGHYEoYu1dY9TxLPh3LTEU4/+CM7OjYNsVIzbs
         3YtrgcN6R5FVKMn800EBBBZbZC6h0nr5I3Q+e4xDXn/bg/DotVEQUqBJUTEt3+OurZI7
         Be/ydwhE+anJMhk+ssjtTYGk2IoO+EiRH8dNqyOotf6AnEXgC8TrourXAAx3601jy8jw
         bG2Kf3o27rQX4zbtcHvq3uH8tFSD5h0XUu+2hxsuk4Kafoi8LYnDKK7lkDdkooK8YFR2
         BAUST6K2MRxrO4F8iBH0ITigpeulRqyjwYVa2y1AifoHvTAs6g30AXSRdZaZ1dLPVq70
         s6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjoBpKDa5kD1Ag6fJYwZVcG1vvsdBSdUH1M/xaTEmXDxPitaiZoN4b/LfgzT45/+nQP9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgT055kAtcz1Q2UdUnTDzDfC2Gtv/cGYzzIorl+OmEIT+T2f+
	dpKf44PX1ILgKwZ8XEBe46gpOcqpumR/Ir/lmGAJ/0XcD5JYkxwn+Mn2+t1p0bNQPMV7E3OkdZF
	dd1kPYrrEDqBb+8l3MfdblsbfiBsfP8E=
X-Gm-Gg: ASbGnctPQ/in/Nng4+SOCV5ZfXr/D3I7umwmPrijfA/YhsfPLxcZm3ZcHpMtVwL7C5P
	t711EllEEK9k7ZSxWenzQiLqQVLGPIu8DfOvAuSLPCDe6nb/XkjwOwfD4gyCbdSYy8NYoivaoZ/
	YiW4Hu2HynomKhvNXYIdkOhYfxdE1O8oKsZg9yf+QgYNP2XEXrq5GiQz4EXOs4IIx62p8ABbws7
	DnNT9/R9N27sfdmlKiznF6il/EAoRP62CAKrn50W+qfJS75nQdyg19ZJzdZ9w==
X-Google-Smtp-Source: AGHT+IFz6hbSYEhTLiWBi8IvnfZOn51POu17c8zRwYd4R9w3VQbWDaR4Wd7eSySFA2kvyaVEDbXNblsIsjP21wQaXGU=
X-Received: by 2002:a2e:9a0d:0:b0:377:78a7:9711 with SMTP id
 38308e7fff4ca-37a05316e4emr1439181fa.29.1761678467262; Tue, 28 Oct 2025
 12:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-5-sandals@crustytoothpaste.net> <aQCKD--ZmKnwBWs9@pks.im>
In-Reply-To: <aQCKD--ZmKnwBWs9@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:07:36 -0600
X-Gm-Features: AWmQ_bnB9fmGGyP57HS5rXtF8FMwHWQfHhS-TIt4aNurs4_9YaA8qNexJji-iPQ
Message-ID: <CAH=ZcbBnTAWe=2SihD5G63e6T__wWj870u3eRE+rueH51gpqnA@mail.gmail.com>
Subject: Re: [PATCH 04/14] rust: add a ObjectID struct
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 27, 2025 at 12:43:54AM +0000, brian m. carlson wrote:
> > diff --git a/src/hash.rs b/src/hash.rs
> > new file mode 100644
> > index 0000000000..0219391820
> > --- /dev/null
> > +++ b/src/hash.rs
> > @@ -0,0 +1,21 @@
> > +// This program is free software; you can redistribute it and/or modif=
y
> > +// it under the terms of the GNU General Public License as published b=
y
> > +// the Free Software Foundation: version 2 of the License, dated June =
1991.
> > +//
> > +// This program is distributed in the hope that it will be useful,
> > +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +// GNU General Public License for more details.
> > +//
> > +// You should have received a copy of the GNU General Public License a=
long
> > +// with this program; if not, see <https://www.gnu.org/licenses/>.
>
> We typically don't have these headers for our C code, so why have it
> over here?

I'm wondering this too even though you gave a reason in your cover
letter. I'm against putting licenses in each source file, and don't
see how it's better than having a separate license file.

> > +pub const GIT_MAX_RAWSZ: usize =3D 32;
> > +
> > +/// A binary object ID.
> > +#[repr(C)]
> > +#[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
> > +pub struct ObjectID {
> > +    pub hash: [u8; GIT_MAX_RAWSZ],
> > +    pub algo: u32,
> > +}
>
> An alternative to represent this type would be to use an enum:
>
>     pub enum ObjectID {
>         SHA1([u8; GIT_SHA1_RAWSZ]),
>         SHA256([u8; GIT_SHA256_RAWSZ]),
>     }
>
> That would give us some type safety going forward, but it might be
> harder to work with for us?

This would be fine if it was used exclusively in Rust, but since this
is a type that has to cross the FFI boundary it should be defined as a
struct in C and Rust. If you run size_of::<ObjectId>() you'll get 33
(but it could be something else). Without #[repr(C, u8)] the Rust
compiler is free to choose how to define the discriminant (its length
and values) to distinguish the 2 types. If you do use #[repr(C, u8)]
then you have the possible problem of C setting an invalid
discriminant value which would result in undefined behavior. It also
doesn't make sense as an FFI type since a Rust enum is closer to a C
union than a C enum. The point here is that Brian is matching the
existing C struct with an equivalent Rust struct.
