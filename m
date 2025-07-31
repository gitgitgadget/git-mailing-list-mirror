Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC920B22
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995503; cv=none; b=H5Vnx78PwvpvZV+61zUPyuea/Fpad7XpvCXVwtw+aq06HdJIY2z9KvX6lrcAMKcIJVspXad5yE994MmOg/+xi+QyUMBANROpLNbzKCj+mXDZqPLOemRCBbfL7FZB3/809XXHN4XJOpSw1w9Fk+ib3ZB7wRSeJaefOc3eBGYIo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995503; c=relaxed/simple;
	bh=eBziyvspiAg8pcMJMvK8jHe6f9/5mW4wJCjI7hXROts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhuOndjVaPap1naKLCtxs0A/f7E1XTVKJ+DxlduHhfUdhfSv8owm7I0iSO92eswV9cMVZbWlKp6J8DIuArDU5ZUEdyesK3GzETz0DtPEZNBsd7FSZxTTw8OWnNQKAOge+24fT+ec2cevK18azfpduWy4oZoYW/LrXIjKb0/sMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1NNI8cf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1NNI8cf"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so14150341fa.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753995500; x=1754600300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyy9ucTuk7hYqHndT0P5pMcKYjM/GT5bZkM4lo2nUXE=;
        b=N1NNI8cfPW1XboQLTc08qhVqbQjczsJV7z2ecPCns7ZeTXz463kxxxrFxsYpwCrwcy
         fX7DbqKFI5iDKrd3xAepuS6AGAnFq+9oK3YInsFUxPFd99Q+CEcw6buzLk24+pQ5lNjp
         rxmb3l1d4WkAAbo4cjLTli5ELxUhICC6aLews3nDu+CBIBzrCiG/kJ5FCnYrHC2VVNfd
         YiI5QOghDhSDB33mQlJCnBJSkJTSbJbbezzaLF/10fEnpS3QoFMba6hJuCzSgbC7skCl
         dYqZ9NweOslCq93EDBjWbB4kFSPhm0irR0I2iY83lHxOYf/eB+yl6AQ7E/0LEmEwyHpy
         zP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995500; x=1754600300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyy9ucTuk7hYqHndT0P5pMcKYjM/GT5bZkM4lo2nUXE=;
        b=F/ng7hDZlllW0YLqojgm6QYL3xyzrLdHD38Ve/ZeeUjAxKmJcKd2LPXY0d144JAHHR
         bZPKFY9EajAHahB1TbH4u1VbD+p+ppoXCuhcoopQS5hPVzIuXCscaAtsFLyi364/CL0r
         UnffHygxNBkt7GnlfO0RdcejTXxiZALTOJEbHf/NrW+TiYaBXQS1F6dcmd0QxZxDQdji
         8MaI8kWvCLQPLqj/mvdKsdNpGsBkZ9Rgj8H32ronE0niwskrSIld9DYnwnOLvqRTSiDe
         EM9MC5NWml3U7fnKyNxdubidqLVEQhLwhGjkVCsYtxPWZehWXXASYSKWrZf1weE5/fik
         zBRw==
X-Forwarded-Encrypted: i=1; AJvYcCWddqZ9CR9V/JV5nY+NZcaP/MQUbj0coMpBbJrRQ43oPIAnPlz4UcDQlBcGN49g9xkQ0es=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+fXZtsf8xV6sPF9CfXx7c8VTTJrdN3piK/fkSWaQ6UgpzmKT
	Lr9aawbckatlMSljcSGsU/VYthYlbhMLK7yWxf0offQqZQw/hxNNdLRelMOu1LqNF2iYpW5d0Os
	qla8hBHxSVtmEvZCHJk756MMMpP/UQgf72DT5
X-Gm-Gg: ASbGnctC0HJJovfsquYwhiWoJmZGOEHkr+dbUhFIQdwCIRJYHGwZ+4kDh0XZK2YmOf0
	fGuZNKkCJg5BcR0FXxO60uI0hw5kgnCxJPSnojLadeYb76LN06KiEAmzVb/IQpRDw8NoCULNBLN
	I5FMu21rL7AH+weiqeVeY67BDN0xYzuP6gr7w9BaMPiqRjhn/ABbfO0lV3z6DzhbtNsihYgyKq/
	m3mMqlg
X-Google-Smtp-Source: AGHT+IFamtnMKl3kymSUSNSwKLnZjl5TAS6DLDFa5PorwmLOivLXTWm24Vkbte3m+AvxzMgpGPIlkbFxorPIPaScAyo=
X-Received: by 2002:a05:651c:4101:b0:32b:755e:6cc7 with SMTP id
 38308e7fff4ca-33224bd2283mr24441911fa.28.1753995499640; Thu, 31 Jul 2025
 13:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com> <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
 <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com> <CAH=ZcbALsQqTrvNJ4ZKmVWc6PHtTA+8k8p6_D=x=BfMXxnayfA@mail.gmail.com>
 <ad453eee-23cd-42fe-97bd-1ff0fc2f3edf@gmail.com>
In-Reply-To: <ad453eee-23cd-42fe-97bd-1ff0fc2f3edf@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 31 Jul 2025 14:58:08 -0600
X-Gm-Features: Ac12FXyaHfqMyI6UEV_LbHUbRI3ZKm8Qw_LQejlVoy3RyiXp74XouLkkFJXBk_Y
Message-ID: <CAH=ZcbBa=1iUTcxaBOvG_kcuWsF_nJQiWGkL+BUzsNYLpzFG5w@mail.gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 8:20=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 28/07/2025 21:14, Ezekiel Newren wrote:
> > On Mon, Jul 28, 2025 at 1:52=E2=80=AFPM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >
> > Ah, I misunderstood the scope of your question. I could not fit an
> > example of why this design pattern made sense into this patch series,
> > so I'll explain with an example here:
> >
> > If C defines a struct like below then it's obvious how to translate
> > that into rust for ffi purposes. It also makes it clear that this C
> > struct is expressly for the purpose of C <-> Rust interoperability.
> > struct some_struct {
> >      u8* ptr;
> >      usize length;
> >      u64 counter;
> > };
> >
> > This is how that C struct needs to be defined in Rust so that it can
> > interoperate with C, and making C use the Rust types reduces the
> > chance of copy paste, and primitive type definition mismatch errors.
> > #[repr(C)]
> > pub struct some_struct {
> >      ptr: *mut u8,
> >      length: usize,
> >      counter: u64,
> > };
>
> How is the pointer, length pair used in rust? Normally one would use a
> slice so do we have to construct a slice every time we want to use the
> data in this struct, or do we copy the data in this struct into to a an
> idiomatic struct with a slice member? If we end up copying there doesn't
> seem much point in changing all the types in the C struct as we can
> define a rust struct using *c_char, c_long etc. to interface with the C
> code and covert them to an appropriate rust type when we copy the data
> to the idiomatic version that is then used by the rust of the rust code.
> I can see the value of the typedefs for documenting C<->rust interop if
> the same struct is used by both but if we end up copying data on the
> rust side I'm not so sure.
>
> Thanks
>
> Phillip

Passing pointer + length from c to Rust does not incur a memory copy
overhead. Take a look at rust/xdiff/src/lib.rs wich has the following
rust function defined:

#[no_mangle]
unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
    let slice =3D std::slice::from_raw_parts(ptr, size);
    xxhash_rust::xxh3::xxh3_64(slice)
}

Creating a slice tells the compiler what assumptions it can make about
that memory. On the C side in xdiff/xprepare.c:

extern u64 xxh3_64(u8 const* ptr, usize size);

and then it's called like this in that same file:

rec->ha =3D xxh3_64(rec->ptr, rec->size);

I really wanted to show my ivec type that made passing an
interoperable vector type between C and Rust easy and fast, but this
patch series is already getting very long.
