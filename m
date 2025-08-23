Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1C15C158
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755980974; cv=none; b=fHxq4iA3oX4oSTK2zKZHxpV3nxGobXt6E1Anpfnmpam/4zjteUNTSZI03k/K2J3OdlwdocX19wdRvpH0JvxCTyoFo9H1l5SuD1LhDJCvvoQHv5FZ5eF1hEHyOMPeztQpj+RZ3B/bEFKXR3eRcxK7mJGh7mfbfSnXXy8/ZzKzJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755980974; c=relaxed/simple;
	bh=ZeyKdB36SaipdJle8uhPdB/wsIlbqG+vbh/v7HhPFGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxjIRRiNvMrFISdnx5r8j6fmQjwt+/FZI5ZQKMxPe3mvgk7GmOUhhYInv/yF3VFybhdrw+YSuxWfH+d0QSmZlMY6hQDIU5dg7GAhp4yhpYB4GR69bnmhEXnIILGwQe3DaO/ovJOwvCocOkOepJ9Sxz/yy5o1rN3HsXhnQ0k7Dr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjTkIdEr; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjTkIdEr"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3366f66a04eso327591fa.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 13:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755980971; x=1756585771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSQX51dCjQ6R0fJoHi/teAufv2avaRJX0JaZnQRf/kc=;
        b=SjTkIdErkUTWIZaqi1df+2hVHUDyT+3i91EsG0EdEKNhtj61VqCClTGiEQ/hSTwS8S
         PEJwCFqt2NuOezEbqhDqV1ImC/Ixk5JUrPrYcGjUZJEa3WI/YIlKBVaMoXputQ9FWIFy
         8iDAGFC0B/RIXBXFWzwtGMkF6sztXbccV41KptgIL4Zi1Iz8+3RYXjZ55UJJ3qSBWzBZ
         VwVejaLLq1AWz9egzRQsdUxDLTPr/1KYI3ebecV5KGK9MoMUdoYDNDK2IPkkHiGUSEwV
         gjaySHda63IxzhBUqD79NgmBsNZF5/5B+OpY38e89htdmNCDQjibMxxSZbNtg/TVo8GL
         KR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755980971; x=1756585771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSQX51dCjQ6R0fJoHi/teAufv2avaRJX0JaZnQRf/kc=;
        b=d5SmUAJaG3ndBRGRnYB63wLWwC9ys5iiJ627/pRHcP4KMBYLSMr4SLIraL7uB+7U+g
         0KQ/2M3Vq0JO2/BSufKZmSx088afQW5FNBmwYavpQPrwFGnHHIHNVFPZIOKau9pIEPX9
         W2M8rxjNXNgt2y2HfLYM4NwAUwkcdh7ogV9v4htLAO3wyvsc+nyd7wjDNr+sUwcU9CB/
         wcaFjNzslgR70Y383lbASFCl6aHf7beTHsFCl0O6hy26ggeK7oI9p+9MO3mbyEb8irqF
         9dqmqOAXZgcmp9X1poveDbaUMgmxaW9olFbZcCfDWWMVdQUI6nunBxvCdAi6Pj9vlkaa
         pbiA==
X-Forwarded-Encrypted: i=1; AJvYcCWdhMcjnlJfzTj54gGCtK5pqZXfgXGU4//uCHg2nplt2GlxIoTzKsNWrK/Nui0rwzdDF5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLD7edAYcE2CiLkTUK7cv7spH/lNwHbZWqGBVsyEM1OhQk9xS
	hJyK8lmIRMvD1RWCd2wOl0qjeRFVuou/yhrWGVKKbrPBqiU6Zgr9YX83yC0MuTy0kawvvOdvo7J
	w8X+fXyt8BwPGqqB1WEylZTw6lyHk6cc=
X-Gm-Gg: ASbGnctIYcZKNqvpUZipbn0Ri7JoqOIDTbr/Wu3Z6g059DJ3EQn9LOjF6RoVO0Oykmw
	o0Oa08WPDBAqBbGiNnkkPUHmRyL607+9to1WgPLDNAgKEeV8ZbJPgbtYHQEphOLKXlZp+zgYCGn
	qNo/xR3E394wD1su7rsuPi/43/vr3DXQkcFHtG3LmDJsjGuBx43mu+1IVgedy6KIN0i6kdPXLw+
	a9Ub0kU
X-Google-Smtp-Source: AGHT+IGvjbIjXpG8Tt7OBsZkIIGhAbarAUo+aGFmMscxSAHHw/bfinFJqZBio0vnbFXWNG45mBgnHjgm8LrDnxay9MU=
X-Received: by 2002:a05:651c:e09:b0:335:40e6:d059 with SMTP id
 38308e7fff4ca-33650ff27a5mr21802331fa.43.1755980970487; Sat, 23 Aug 2025
 13:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <xmqq8qj9vrpf.fsf@gitster.g>
In-Reply-To: <xmqq8qj9vrpf.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sat, 23 Aug 2025 14:29:19 -0600
X-Gm-Features: Ac12FXxiCSZImN0wY7FWproxddUPfCN21okhXrfuQAqHFDUpSZvZKlGu3si-DV0
Message-ID: <CAH=ZcbAvhxVdg_LBPj5XQMYCYi+cqxMavJ8uUi-DoGs85Biu3g@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Ben Knoble <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 12:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> > To address these issue, introduce a new type, ivec -- short for
> > interoperable vector. (We refer to it as 'ivec' generally, though on
> > the Rust side the struct is called IVec to match Rust style.)
>
> I however was hoping by now Rust getting used more widely, somebody
> has already created a generic "this is how you make C-array and Rust
> vectors interoperate" wrapper that latecomer projects like us can
> use without inventing our own.

I've looked for code that will do what Git needs, but as far as I know
nothing can do everything that my ivec can.

> > +INTEROP_OBJS +=3D interop/ivec.o
> > +.PHONY: interop-objs
> > +interop-objs: $(INTEROP_OBJS)
>
> What is this phony target used for?  No other targets seem to depend
> on this one (I am wondering if we need the latter two lines).

You are correct. I will remove those lines.

> > diff --git a/interop/ivec.c b/interop/ivec.c
> > new file mode 100644
> > index 000000000000..9bc2258c04ad
> > --- /dev/null
> > +++ b/interop/ivec.c
>
> I am wondering if this needs a new hierarchy "interop"; shouldn't
> the existing "compat" be a good fit enough?  I dunno.

I had considered compat/, but I thought it didn=E2=80=99t fit.  I thought i=
t
meant that the same API would exist everywhere, as opposed to =E2=80=9CWe
speak different languages, but we=E2=80=99ve agreed on a translator or comm=
on
protocol=E2=80=9D.  In particular, an example from ivec, a function on both
the C and Rust sides:

    void ivec_extend_from_slice(void *_self, void const *ptr, usize size);
    pub fn extend_from_slice(&mut self, slice: &[T]) where T: Clone,

The Rust side uses a slice or =E2=80=9Cfat=E2=80=9D pointer, where the C si=
de uses two
arguments (a pointer and a size) in its place.  The API is different,
even if semantically they are the same and they are interoperable.

Was I reading too much into the meaning of compat/?  Do folks object
to using interop/?

> Even though this is a shim to somebody else's code, it still is a
> part of our codebase, so our CodingGuidelines for C programs should
> apply.

Sorry I missed those. I will fix them up.

> > @@ -0,0 +1,151 @@
> > +#include "ivec.h"
> > +
> > +static void ivec_set_capacity(void* self, usize new_capacity) {
> > +     struct rawivec *this =3D self;
>
>  - Asterisk sticks to the variable, not type.
>
>  - The opening and closing {braces} for the function body are
>    written at the leftmost column on its own line.
>
>  - There should be a blank line between the declarations and the
>    first statement.

I will make those changes.

> > +     if (new_capacity =3D=3D 0)
> > +             FREE_AND_NULL(this->ptr);
> > +     else
> > +             this->ptr =3D xrealloc(this->ptr, new_capacity * this->el=
ement_size);
> > +     this->capacity =3D new_capacity;
> > +}
> > +
> > +void ivec_init(void* self, usize element_size) {
> > +     struct rawivec *this =3D self;
> > +     this->ptr =3D NULL;
> > +     this->length =3D 0;
> > +     this->capacity =3D 0;
> > +     this->element_size =3D element_size;
> > +}
>
> I notice that this reintroduces a variable named "this", which was
> eradicated in 585c0e2e (diff: rename 'this' variables, 2018-02-14).
>
> I do not think those who want to use C++ compilers on our C code
> would not mind "self", so how about doing something like...
>
>
>         void ivec_init(void *self_, usize element_size)
>         {
>                 struct rawivec *self =3D self;
>
>                 self->ptr =3D NULL;
>                 self->len =3D 0;
>                 self->capacity =3D 0;
>                 self->element_size =3D element_size;
>         }
>
> ... perhaps?

That sounds good. I will make those changes.

> > diff --git a/interop/ivec.h b/interop/ivec.h
> > new file mode 100644
> > index 000000000000..98be4bbeb54a
> > --- /dev/null
> > +++ b/interop/ivec.h
> > @@ -0,0 +1,52 @@
> > +#ifndef IVEC_H
> > +#define IVEC_H
> > +
> > +#include "../git-compat-util.h"
>
> As we use -I. on the command line, there is no need to add "../"
> here; just writing
>
>         #include <git-compat-util.h>
>
> should be enough.  Also, if this file does not depend on the
> services compat-util header provides (and I do not think it does
> from a brief look at its contents), it is better not to include it.

This file actually does depend on git-compat-util.h, particularly the
Rust primitive definitions (e.g. usize, u64, etc...).

I'll use the include style you mentioned.

> > diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> > index e69de29bb2d1..8b137891791f 100644
> > --- a/rust/xdiff/src/lib.rs
> > +++ b/rust/xdiff/src/lib.rs
> > @@ -0,0 +1 @@
> > +
>
> If this empty line in an otherwise empty file is absolutely
> necessary to make Rust work, then please arrange .gitattributes to
> tell git that this file is excempt from the usual blank-at-eof
> whitespace rule we use.  If not, remove that unnecessary empty line.
>
> Or perhaps remove the file altogether if nobody looks at it???
>
> In any case, given that our top-level .gitattributes file starts
> with
>
>     * whitespace=3D!indent,trail,space
>     *.[ch] whitespace=3Dindent,trail,space diff=3Dcpp
>     *.sh whitespace=3Dindent,trail,space text eol=3Dlf
>     ...
>     *.bat text eol=3Dcrlf
>     CODE_OF_CONDUCT.md -whitespace
>     ...
>
> I think a new rule to cover "*.rs" and perhaps *.toml files right
> before rules for each specific file begin would be in order.

This is only a problem for empty files, and we only have empty .rs
files to setup the basic Rust build in this commit. It's not a problem
later in this series and shouldn't be a problem in the future. I will
remove those blank lines from those commits.
