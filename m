Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA51FCFF8
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795460; cv=none; b=oPW7FjBoB/Zav0OHHc6T4Tcf09bZE5aP71zwopWTFB28kkaIq3AMM155RiLMxByA5e6Y7Tt1kRvO9MPf7pqbNruMrY0d9v2v/Qyt50qvL5xJnNvdfn6MIzJTqtycwTz+/MVqIr/WyUDPx8+jOXDUxez8k3e9mdPgRy0WRwrlP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795460; c=relaxed/simple;
	bh=b6aPce0L6FUr9bc0eJPLAqSGgo9Ip2NkJPklUgcbJAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j2mI4iT41HdNEOMt5e83HGGIQZpXh/vz9wefbEp2rCAEroqIpf14wil2rmeebEQCodaRNPe5XiYUKv2IeYZ5zOONv7x0WVenoHS5FBeBHbR5RaKpeAsi883hdHJ+l8S/NyyvPJRVlqlZT0F6JjKrzAEMmgLSWhmLvhlVSlD3l30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpR4bbsw; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpR4bbsw"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e28bf4a350so8565085ab.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752795457; x=1753400257; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKR9TQ0ub9BFz3uStaEWhfxGGB1t2apEGEbC9M/SAP4=;
        b=kpR4bbswRGEDf57C/3IeffQse0F8pS1gOPte6gmwreXreUXg86qJYf3eKmLIvNM/8F
         81DeQG8TtHLqkkGOeZW+lTy1W0uHvpf95nLo+Ek/AjS1qsVrRHcQ0krQg5xvhE6s8Vo4
         JQvYgIhidudCuHokuuDuceVjpwB+eBnch36tC5Jel72HCxnNozifzA8TKPkKniknymeu
         q9lDgq9hZftbZDPALZjF6TnPnmgXM+8aZjpKzkq2P3MhvNri+U7nr8JAi52tCxlvTPsk
         WL+xrM13zIHgU/u1ld+TwEmhKKn+YSiOw43ZSwzQATjfnv19WOKctvBBZu58FSBWpEtY
         QBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752795457; x=1753400257;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKR9TQ0ub9BFz3uStaEWhfxGGB1t2apEGEbC9M/SAP4=;
        b=lOHn1x3e89p2/e6TWhvm+TNCqd84idSl1XwahX9nrJlBFj5QaYS2SSMXIY0YrihqRM
         ATBzN7lC4Xzcd8ZXonSfwM+MtJN7Ac6cnSX/SHGtmvqEXjPqShPVMEhfAXo3sGJw1F2L
         IXJDTj3sd2mf4ANITDOilr4PGG0zKF2iUa5MgWWz1mPedPQbPAcMQ2hGPLD8Gof3J2EN
         DJiVOZXvkTQoCxctiHHlufPK5pFMwqt4G4sIFrDS3mczrIuAJWATviT4vdj5Avc3q0ww
         TL6ZUMpmgcxXBHirWkz7Ow+ieW5UbBi+HYFFBYUWN1wb3gamhlMJV636etSIwazHMi8r
         Bk0A==
X-Forwarded-Encrypted: i=1; AJvYcCVhzzVfSRvB/Q5sHWNYF1Kz+ZxrsfXADYb9+5ztkZTs0ffGKz/KOK3XJvhJERsCwQUmQjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WQsNjQBipnk3ECOX8nXjUkyinvGTsE8y6f1K2AfNI8A0+rB9
	/c/3y/NlhepA/0zGYgMQxFQGG3geYtAquVubWPhHIBW5Y99iGuhGQ+wKf/ZaIf3SXHKfsJhKMHE
	ZWOhbBiPnq6jtaCPyyXJTDvUpM+19BVw=
X-Gm-Gg: ASbGncuoKc+lz6h3KGDkWwqbYLEAABvkvriTYwg4UuJEw1XE7wHY5kDP882gW+ff/9U
	2AEQkZlMrlWKu6RZOXtebRO2GrggoEsf77t8jID1WgwTjDpS29B6Pnu8QnKJmmlFgB8/nF5CK7O
	x86u5MHM45X2i7rt+XI9elKNPl65cqOwYjtNfgL0QpRQOR+kM1Qgy7BIwji04Y4tFw59oLxwDqP
	4sVpA78jZ3J3iKCN0edL/RCZwhgBXJPy04Lgmn0
X-Google-Smtp-Source: AGHT+IEUUZ527369i+0mZEFJA8yjp6vErx+1qll3aJkfDU+o+crQMzww9ZXs730h74z+IYljRoQmqSZ/8vPAYseb9vM=
X-Received: by 2002:a05:6e02:3307:b0:3dd:d18a:2d71 with SMTP id
 e9e14a558f8ab-3e297331733mr6476435ab.2.1752795457033; Thu, 17 Jul 2025
 16:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <aHl9YLc823uWwgIp@nand.local> <aHmDiqsBsDJJ6m8C@fruit.crustytoothpaste.net>
In-Reply-To: <aHmDiqsBsDJJ6m8C@fruit.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 17 Jul 2025 16:37:24 -0700
X-Gm-Features: Ac12FXxPKH9v0ds7kUwH89anM6t-sGKH3p4yAwKO5ekbSaJQA5qW6K_9V9Ok9V0
Message-ID: <CABPp-BFqruHDF5He=iqrUe9sYJ3XdXBcthY8i_eKMXS9tAa0oA@mail.gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:13=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-17 at 22:46:56, Taylor Blau wrote:
> > On Thu, Jul 17, 2025 at 08:32:21PM +0000, Ezekiel Newren via GitGitGadg=
et wrote:
> > > From: Ezekiel Newren <ezekielnewren@gmail.com>
> > >
> > > A few commits ago, we added definitions for Rust primitive types,
> > > to facilitate interoperability between C and Rust. Switch a
> > > few variables to use these types. Which, for now, will
> > > require adding some casts.
> >
> > Hmm, interesting. I am not super familiar with how people typically
> > handle interoperability between C and Rust, but having to change types
> > on the C side to make it work with Rust is a bit surprising to me.
> >
> > I would have expected that the Rust side would have declared its types
> > using libc::c_int, libc::size_t, and so on. I think I have a vague
> > preference towards putting the burden of casting on the Rust side, but,
> > again, I am not super familiar with how transitions like these are
> > typically approached.
>
> Rust normally handles byte strings as slices or vectors of u8 (that is,
> C's uint8_t).  C handles them as char, which may or may not be unsigned,
> as we all know, which leads to some "entertaining" problems from time to
> time.
>
> Also, in general, Rust doesn't offer generic system-specific types, such
> as `long`, except for C FFI.  This is actually a strong benefit, since
> it means we're not inclined to write `unsigned long` and then wonder why
> things are broken on Windows: instead, we write either `usize` (the
> equivalent of `size_t`) or `u64` (for things like file sizes).  This is
> much more ingrained than it is in Go, which has a tendency to use `int`
> (Rust's `isize`) a lot and much less often specific types.
>
> If we're going to move this code entirely into Rust, then it makes sense
> to cast temporarily, and I'm fine doing that in C, since it's C that has
> the weird system-dependent behaviour (arbitrary decisions on the
> signedness of char).  That actually allows us to have more confidence in
> the safety and maintainability of the Rust code since it is less system
> dependent and leave the suspect pieces in C.  It may also, interestingly
> enough, also allow us to easily get rid of the weird 2 GB limit on diffs
> due to the unpleasant dependency on `int` in the xdiff code, which I
> would absolutely love to see.
>
> However, I'm not dead set against casting in Rust if that's what
> everyone else wants instead.

In general, I too would prefer to do the casting on the C side; after
all, part of the reason for Rust is the language safety, which we
compromise if we force it into using ambiguously sized variables.

However, I think it might be somewhat case-dependent...

Here, we have C calling into APIs that will be defined and implemented
in Rust.  Further along the road of adopting Rust in more places, we
may have future cases where we have Rust calling into APIs defined and
implemented in C.  I'm wondering if in such a world the rule of thumb
that makes the most sense would be to have a
caller-must-cast-as-necessary guideline, rather than specifying the
casting side by language.
