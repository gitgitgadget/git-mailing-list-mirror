Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4579CD
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268214; cv=none; b=l+T2JsoyaEWqdLuj+TYBbRq3O+yBYw4MGfAtyvTIculv4P4Hs1Mqyuj8ZEcpMfEcjdklUxKuRyuZCW+W6r8/sLEmK9+bIOdPPvSVE89olDvvXer7vMOD3Ybs2RwFo1PiSfEqnXTWg9KMrHl8+T5tP+BcPdhE7jfZ0VFOrOP01No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268214; c=relaxed/simple;
	bh=IERbAYLNqhNPxEX7VQRCGD5xzAbo0NmC5PrGf2nZhq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2DqqoQdGA2/T4LcRIG7Dg/IEjMaaASjJOBZtB9NbwkwOeRZbfsdautBO4aFTbbc+r0Sod9+SReg41kWt7MQRWXXbpB0seW7l1l6mUgKFiDK3l3SS+Q8Vxq7ySrZIaK3dELR06Qyn3WLtTMFK25zTcHFTTDnSK+ojEm5K4js9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXJ47J/s; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXJ47J/s"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aada2358fso188299866b.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724268211; x=1724873011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6DHZirgGzw1KQvZmzHcQ6MhT/OT+XvZdz/EGsqqZzQ=;
        b=tXJ47J/sWteOOLI51BX/J3tSdMadZGqiLkffiloVNuz1URVyA3JMwJ8KON3DT5DgnM
         KJvE2qz7Gihdm11T4XGyWC0anom/hf7uzciVb++pSobFmVUt8Ga2LcLX12rnrgmhyr9L
         +LjjtH3GIWVSf7YLObJAYNPEOriS3wyUriHfhyqXqDPXUkILo4RqnscDopcwT9vZJHe3
         9kji79pHWpd35Zc8Gwtlqaat7d3wgzKJ9rWVmrVeXHSSiNx3KdG4N54VUV2HAGLGrVi3
         b718zOx6GVdi8KUuHAFNiwdO0JK1zOIFLEePrQ5NSZNnnlmr3qpI3mqyIvqzdDclBk64
         PbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724268211; x=1724873011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6DHZirgGzw1KQvZmzHcQ6MhT/OT+XvZdz/EGsqqZzQ=;
        b=Un+L7YM23+lTcoefnhRyszDJcZGWwisDreCHk4NXv0J2qvR1pSpfa77BUXcPT58HXs
         1Q8Lsm3tt94QBCv6ILQs9ZPc92hFAzjIr3/ICm/jb8+hsTOAJULW6Ru6buWhhZTU0Bep
         X3HNbem///Aj9OoXmPbR+A0Rle4ZWeXFww4+GRCiovEwdcB8wCclg6HqJh76iiyyeqSx
         3+5tU8Gb79ABzkdqTzd3lhKayXVIeh5MzOCQ5wyqP9lH7jln6y1uKdJNZaqcy+34gkts
         xkVi2jDiigMzrbEVr4UQyRZzLDPi7f/rJ5Coq3ScZVeraRJO0ERRqTfwHt973PXvyrYm
         WoTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw18Xby7JfC6Zdv7SOfHKeo6kTv/IvVvHjGLCgw2iq5bDvizbPgPhz6PMLJiQhtt+5fDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMedZb324YQtQ+S6zTlmEEQoD5mkbouFq0H/qgNsUcvjifPeA
	hbaj/ndvbJdDcBlOCEiWnNEzoRnUHgFRvxeOO7cxgBARBi2kJdkt+D3+PsnxTPTHErDniuktPzb
	lW8cidSzILir0wF6B+jmrz+RlaqZbwJ1haDMd
X-Google-Smtp-Source: AGHT+IFti2BhsVHMT9vAsvDhIo6E1GYDqduRBCbPBxgBQ5fdata1gqF+AGM0H/yXCYIdAQIYJFPGC9Mt2St7vApWPfA=
X-Received: by 2002:a17:907:9708:b0:a6e:f869:d718 with SMTP id
 a640c23a62f3a-a868a89ab65mr60517066b.21.1724268210027; Wed, 21 Aug 2024
 12:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3f7d292-ee51-4784-8c85-14b5223c380f@gmail.com> <20240821184605.341205-1-calvinwan@google.com>
In-Reply-To: <20240821184605.341205-1-calvinwan@google.com>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 21 Aug 2024 12:23:14 -0700
Message-ID: <CAO_smViznLAxxGH+rfouUquq8tNJn16-CSoLbbGosy3fuYzTgQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] cgit: add higher-level cgit crate
To: Calvin Wan <calvinwan@google.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:46=E2=80=AFAM Calvin Wan <calvinwan@google.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
> > Hi Josh
> >
> > On 09/08/2024 23:41, Josh Steadmon wrote:
> > > From: Calvin Wan <calvinwan@google.com>
> > >
> > > Wrap `struct config_set` and a few of its associated functions in
> > > cgit-sys. Also introduce a higher-level "cgit" crate which provides a
> > > more Rust-friendly interface to config_set structs.
> >
> > Having an ergonamic interface is a really good idea. As far as the
> > naming goes I think the suggestion of "libgit-rs" is a good one.
>
> Agreed -- we plan on renaming it to "libgit-rs" in the next reroll.
>
> >
> > > diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.h b/contri=
b/cgit-rs/cgit-sys/public_symbol_export.h
> > > index 64332f30de..882c7932e8 100644
> > > --- a/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> > > +++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> > > @@ -9,6 +9,18 @@ void libgit_init_git(const char **argv);
> > >
> > >   int libgit_parse_maybe_bool(const char *val);
> >
> > I'm suprised the compiler does not complain that 'struct config_set' is
> > not declared in this header - I was expecting to see
> >
> >       struct config_set;
>
> I'm surprised as well actually. Removing the forward declaration of
> "struct config_set" in repository.h doesn't result in any complaints
> from the compiler either. Will add it in the reroll, but am curious if
> anyone has any ideas why the compiler isn't complaining.

C doesn't require structs be forward declared separately. You can
change the name to be anything you want, and as long as the forward
declaration of the function and the function definition agree, you're
fine. If they don't agree, well, let's hope you don't encounter that
(it's the same problem as if you have a forward declaration that's
*not* visible from the definition that disagrees with the definition:
`void some_func();` vs. `int some_func(int arg) { ... }` -- if the
forward declaration wasn't made in the same translation unit that
defines `some_func`, nothing detects this misuse in C).

For this reason, you should only ever use forward declarations that
are provided by "the code" that's being forward declared. i.e. if
you're trying to use a function from foo.c, please forward declare it
in foo.h, and only there. This way, assuming foo.c includes foo.h,
you'll detect mismatches.

[apologies if people got multiple copies of this, I sent with HTML
mode enabled the first time]

>
> > before the function declarations. As I said in my comments on the last
> > patch I think we'd be better to namespace our types as well as our
> > functions in this library layer so this can be resued by other language
> > bindings.
>
> Are you suggesting something like "#define libgit_config_set
> config_set"? I wouldn't be comfortable renaming config_set in git.git
> just yet until config/config_set can be a standalone library by itself.
>
> >
> >  > [...]
> > > +    pub fn get_str(&mut self, key: &str) -> Option<CString> {
> >
> > If we're adding an ergonomic api then having return CString isn't ideal=
.
> > I think the equivalent function in libgit2-rs has variants that return =
a
> > String which is convinent if the caller is expecting utf8 values or
> > Vec<u8> for non-utf8 values.
>
> Having both get_cstr() and get_str() makes sense to me.
