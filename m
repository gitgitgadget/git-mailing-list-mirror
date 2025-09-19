Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAE21B199
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314113; cv=none; b=qETE6Jz4sFDwo5wobJKorFQNSAo7jrnDvZUjQ49r1o4gi1wFcTH4qeiX1HVrbcmthrrsy22xD94P25/62wqZ7CpA3LxwDw1/fp+e+M+BWp9KqaLGucXZcsoUhtbtxy+89Wkp2L+FP50fHRuC07kh81TnCATFgtxO/9E2j0EZzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314113; c=relaxed/simple;
	bh=bp9POUhb2azsVFFnvW1TNbP0QfNfU4gtqrs2Tp88im4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTbF4thmG9A9tt0jBSrOKH3iMwJfTuS+NsPi17fI6z7aZBqHNOvhmJ/xp3w8t3mpanGp8z34Wv3Tipqum4YJJtTHQK9xumML2P6XmHjTrKIOfXPahnVZbFvOFNj3vFizo+u5GIXlBTgR5eVHjgzVjQ4sBzu5xqkdfKsbbUZo8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM5oKhJf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM5oKhJf"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso2977714e87.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758314109; x=1758918909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0kgZVMfbVOpazw2M0WSXmkPhtqZ3dE5kdxMZneQH0g=;
        b=eM5oKhJfW7J6r/R5MQOZNiPsIpEQ4f9iPwJr6YZxGjrfAxSRTUvmreGeIq1cnizNhw
         iJMo5WnImn+oRgrqTjijIhNZsfwh4cNvLiPlPlSQgneUfxW5Tu/q/RyTUuA2WJ08WZX7
         o15P7p8BXzcnWUYudeCumh6zuZSzm/EKtn8W3NQUvzqnVkB7n/kVhvFhvkpzO5vVex2A
         2lhvLhf12wl5afvV7lrxxs9KFMeB86nujYjGcMa9k4/9lS00qa/DkjgoSllFZZyxf6VQ
         7+2CZS0oTD2Vvl5KHlAHLfwkAF6wDUexAoBsjzzvs3U4aEW6J8RSRqkOvQDRDBvxbK3x
         5F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314109; x=1758918909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0kgZVMfbVOpazw2M0WSXmkPhtqZ3dE5kdxMZneQH0g=;
        b=QIyhCiEUe8UjQ0RBBVuKbrpWWQZbbru958dfENXbUa5XvwuDndiD8w4lHyD9rKHEWt
         QLhvufnb6imQjtP2Efai0Var9Z0Fz2xqzqyRHPZzse8Bo9bSS84IrVm07pzbKB2VTKsC
         KeLJVifj+g+cKmYhJ+jQj5fLPClhQn+VM5AYPjzq5827aIG1uWfDvtpJydevVC6NhaTG
         Mdrqq9yDHXUjy/LrE1x+4hSRhh411022vkH9KwpTgWhDi6acPvvxXWInnyej8V7xToKO
         EgZrgfDVjM4H8J0Ui3YfH1mO+pzeBGtJmm/dijxXnI0vjL/M5D9FGA0IAGvrACWyUEak
         EY+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBBmhEH8frX4JCix3xG2bEcanuX9ZGOEMbjQ5bQo10nfZEyC3jYVHWxqvcWix1/H+S9/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaYzGHdYMyA5jtLjMvgcwCU0U4+ugdHbzaNjaOzlvA65p+4Qp
	t8HMGfNMCV4vn7lzqbm+6R7iJUZfUlEDkUPytIA83yEyDz5x+fOPTI9vlJvvp78IVkO0V3RsGAk
	D2/mhGeuhM3rSNAtt8gdywOmZhVShyhQ=
X-Gm-Gg: ASbGnct/lwhAnP7kDP0MA+uIFzJ77+IbjjRc4tumhP0wpjR2QOUAC5rgftscZiKFlNt
	+kfwmt9J0jhUuv5AG1+l1P07V9h9YyJ5UJ1qfrXa8OOd5VHnzZaI8WJIRa9qLTvd6fS44TkhAcC
	GZ2C+JCpOb2UYfA4kHF7Yn5dIhjxzySu61Mek2TJaClgg+qvZWKRsOmjGDLEF4G5ocPZWmcruyr
	4cMoPIZ
X-Google-Smtp-Source: AGHT+IFsnlDzuYNDyHW4wq732u3zPdvDtJWyh4QCeT36XjRgTLJX0dYEM676pAuclj6AN8MWtJ94BaWcu6e5DbrYsgo=
X-Received: by 2002:a05:6512:158b:b0:55f:62c1:c0b6 with SMTP id
 2adb3069b0e04-579e4ff89b7mr1584782e87.55.1758314108537; Fri, 19 Sep 2025
 13:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <fa334405686a329dd1508bf8d8cbfa12dc5dc7bb.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cQP-7z_TNvq7mM=kFqxeZYDg4CzvJLLV+UGyebywcbuGQ@mail.gmail.com>
In-Reply-To: <CAPig+cQP-7z_TNvq7mM=kFqxeZYDg4CzvJLLV+UGyebywcbuGQ@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 14:34:56 -0600
X-Gm-Features: AS18NWDGTz36M9oyJXEcUyBKWmGZoJijXw-9Aoelt4W32GOF7k2kXgUrFiSET-g
Message-ID: <CAH=ZcbDcvDJ1syZEonnwoWTw-677y8+cG3Zpc8umiHKtVeEAcQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] build-helper: cbindgen, let crates generate a
 header file
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:09=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> It would be nice to have a bit more explanation of what this patch is
> doing and why. I presume that this is adding boilerplate functionality
> but that there are no clients of this functionality yet. Is that
> correct?

I included cbindgen at Brian's request. Its job is to generate C
header files based on Rust code. This eliminates errors of manually
keeping definitions in sync between Rust and C. You are correct that
nothing in my code uses cbindgen yet. I wanted people to see what
would be required to make cbindgen exist in Git. I think I'll drop
cbindgen for this series since varint is so trivial.

I think it would be worthwhile to go over some Rust terminology:
[rustc]: The rust compiler.
[cargo]: Canonical build system + package manager. Even rustc uses
cargo to build itself.
[rustup]: Rust toolchain manager. This provides rustc and cargo + other stu=
ff.
[crate]: The unit of compilation. In C it's akin to a single library
file or executable. It follows the structure of
my_crate
=E2=94=9C=E2=94=80=E2=94=80 Cargo.toml
=E2=94=9C=E2=94=80=E2=94=80 build.rs
=E2=94=94=E2=94=80=E2=94=80 src
    =E2=94=9C=E2=94=80=E2=94=80 do_that.rs
    =E2=94=9C=E2=94=80=E2=94=80 do_this.rs
    =E2=94=94=E2=94=80=E2=94=80 lib.rs
Where src/lib.rs (the entry point) means it's a library crate and
main.rs (the entry point) would mean it's an executable crate (though
you can define both in the same crate).

This means for each crate there will be lib<crate>.a and optionally
interop/<crate>.h. So places like xdiff and reftable would be easy to
fit into the concept of a crate. The rest of Git would take some doing
to organize into crates.

> > diff --git a/rust/cbindgen-template.toml b/rust/cbindgen-template.toml
> > @@ -0,0 +1,16 @@
> > +## compat/posix.h includes stdbool.h where git-compat-util.h does not
> > +## this is mandatory for correct bool C <-> Rust interop. Though the
> > +## 'includes' (and all other variables in this file) can be
> > +## overridden in build.rs.
>
> There seems to be some missing punctuation in the above comment, and
> the final sentence seems to be incomplete, both of which make it
> difficult to understand what is being said.

I'll fix that wording.

> > +sys_includes =3D ["compat/posix.h"]
> > +
> > +autogen_warning =3D "/* Warning, this file is autogenerated by cbindge=
n. Don't modify this manually. */"
> > +
> > +language =3D "C"
> > +no_includes =3D true
> > +usize_is_size_t =3D true
> > +style =3D "tag"
> > +tab_width =3D 4
>
> It's a minor thing and probably not super important but I'm wondering
> if it would be a good idea to follow project guidelines and make the
> TAB width 8 rather than 4. Doing so might be appreciated by people
> reading the generated header files.

I'm fine with changing this value.

I was aware that Git uses a tab width of 8, but the problem is that
Git uses tab characters instead of spaces and as far as I can tell
cbindgen doesn't support using a tab character for indentation. So
tab_width in cbindgen-template.toml means X space characters per
indent.
