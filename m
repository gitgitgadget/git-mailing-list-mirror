Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318F39449C
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492574; cv=none; b=LRGZpnOiXb2aBMm2bERhVgbDfiRmiDjoBtoLsjsowESUwe3WQrgpgFmE7ycgVHT/TAlyUpTLJrRyc0AFPE+UTI7bhAiG2M99dYyRF7JEn7h/aWlhdIBGsxxXH5v7O/pDNmxGE6NKoN81Xt/EF7HYSIIiOCN90BmyqUPSu2GJ4zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492574; c=relaxed/simple;
	bh=h5dOYjxL/yXhwLiNgrR0u8GaKGBFuaN510k9RsQyoO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ik+4VUhsrHB4FJDJcT1hJ1LIDIMtA6XYxOIiJOrdoGH9S3FfntB0T7mUu5cP5heIPAaKxqXpBlls/4COq8P8etRpqr3KorCNDF7fZUrdjfuD3sMAX2KPSBYuch7jpNHFij8owZDLrYc96Ku3g2Kob66cb8U630WW6AJKMwpTI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcjFmTGQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcjFmTGQ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b6c905a46so1107938e87.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768492570; x=1769097370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zzlfzYMd2fA+Ku/JM1ZdOcfC0iIex5Kh9a3TobJKhE=;
        b=FcjFmTGQLp12CDQA9XhP/p7jG7ldBBUSA/2t6FTd0YO4iunLjua2TnVOZz/Jbjaild
         T/iFYLxUMrf8o3naOu8NHyQY9VqGuRNQR5gb5/3hxhqc6BV4HKkhQeihQEaiTPPq2AUm
         VG0IrIhndccoy1qhevNua+CAHLit0a1BnDZcREogcoEAw+A5g4l1fbbsDNyrnYvhIXuu
         xiQ7y4qE/NDw090hiBVOn+F6y5PnT94WwdvluL1lN1IihHYQrPvwxv6+OwxSgl+FsbPw
         ILxAOYGOuyc7S1i8nyHF9QTT5Sweia2K45Ze4v4ZtgZfYW9xTs5+d9NLRmpXG377R6Nz
         gp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768492570; x=1769097370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zzlfzYMd2fA+Ku/JM1ZdOcfC0iIex5Kh9a3TobJKhE=;
        b=SCAkiR5AW5IOSFLfwBl6yeaXIdm6OJ68DFH45+PHYvlE9IAYyWNTLNr0XlWkWhy9YY
         dtXQcfezrgzs6audy7o0qqzoNX4p9a5/1kXa6BDpReLSe9gfSXE3BUEh77XzYhkbZWD0
         +fTEAX51eGBDqgGTTjpf73sYN50hM3jke/mnzyYGaYRs9fIJIurWLVj9x/MQYl5qmJZW
         k0bc75lPn8sQbwLweHSVCwOJosMlzVuc2oQRGPo3ECOXLlmdHKOnX2/o2s+1jUA+b1nn
         oPfkxy143SaJoGx6K18/5X3/y9qsjVUK0RwBMhtgSQ/W5HYjKndFxQN24a1qVpsvQi11
         4I1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLfBzr6FIFNFd6ugjtZFcdwZxy7Anx/YV/UOGs+ztnE+0lWeD03nORQVu31D0VnkGsppk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkI9XLltRxfsNoCytOWw+QutiWQ+eMgJC68WQu4Yhga21BURM
	X+iUqTfw6dcaKz7A7puF9q6DdVCOZxMTZW3+HthzNCuJ1nfwmQWm1CpJgpoQVtptX/nMQNYsVHZ
	t/oNzxkyprcL/clLtSMS/Gr7TnOp09mo=
X-Gm-Gg: AY/fxX4tbtnwrNw3o4NY/TW0RgA1njSBRW+f0W+pgCWFRavPcwwXm78i9FuIpxROEIi
	K8eOrRg+oEI3qEAZKfxgG1OLgVSQC6BcgabwSEvlXeSk4Rv4C+ZC4704GdU4NdS0kJstqwGG/cc
	iHYWL4LbmhjuHhzAd/R2LIfRbMhMCZXYIoe5nmQ6D3RQ+lfddwyWPYDFss1Lo7hCdlCigfsSpbq
	qTWqfWMFfZGORdFRILf6jyToGsM9RD56LVS6meruHFbYpg+KoBjzRGZMEDE7YBiLYdVBY3o
X-Received: by 2002:a05:651c:2112:b0:383:1565:628f with SMTP id
 38308e7fff4ca-3838417cc64mr622131fa.16.1768492569377; Thu, 15 Jan 2026
 07:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
In-Reply-To: <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 15 Jan 2026 08:55:58 -0700
X-Gm-Features: AZwV_QhL3C1cs_o1catbjCpLhcQv0rC4gciBLQ1-u_vuvJhXvKOpDPcsJI5-BV0
Message-ID: <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 7:34=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
> > diff --git a/compat/ivec.c b/compat/ivec.c
> > new file mode 100644
> > index 0000000000..0a777e78dc
> > --- /dev/null
> > +++ b/compat/ivec.c
> > @@ -0,0 +1,113 @@
> > +#include "ivec.h"
> > +
> > +struct IVec_c_void {
>
> We normally use all lower case names for structs but as this is shared
> with rust it maybe makes sense to use CamelCase so the names are the
> same in both languages.

My preference would be all lowercase, but cbindgen insists on using
the same casing as was used in Rust. I don't think there's a way to
make cbindgen use all lowercase for structs.

> > +     void *ptr;
> > +     size_t length;
> > +     size_t capacity;
> > +     size_t element_size;
> > +};
> > +
> > +static void _set_capacity(void *self_, size_t new_capacity)
> > +{
> > +     struct IVec_c_void *self =3D self_;
>
> Passing any of the ivec variants defined below to this function invokes
> undefined behavior because we're not casting the pointer back to the
> orginal type. However I think on the platforms we care about
> sizeof(void*) =3D=3D sizeof(T*) for all T so maybe we can look the other =
way.

If someone finds that this code does not work because of this
assumption I'd like to know. But I can't fathom a case where it
wouldn't work.

> > +
> > +     if (new_capacity =3D=3D self->capacity) {
> > +             return;
> > +     }
> > +     if (new_capacity =3D=3D 0) {
> > +             free(self->ptr);
> > +             self->ptr =3D NULL;
> > +     } else {
> > +             self->ptr =3D realloc(self->ptr, new_capacity * self->ele=
ment_size);
> > +     }
> > +     self->capacity =3D new_capacity;
>
> Not if realloc() returns NULL. We should check for that, probably by
> using xrealloc().
>
> > +void ivec_zero(void *self_, size_t capacity)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     self->ptr =3D calloc(capacity, self->element_size);
>
> We should be handling allocation failures here probably by using xcalloc(=
).

I've changed it to xrealloc() similar for the calloc() call.


> > +void ivec_reserve(void *self_, size_t additional)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     size_t growby =3D 128;
> > +     if (self->capacity > growby)
> > +             growby =3D self->capacity;
> > +     if (additional > growby)
> > +             growby =3D additional;
>
> This growth strategy differs from both ALLOC_GROW() and
> XDL_ALLOC_GROW(), if there isn't a good reason for that we should
> perhaps just use ALLOC_GROW() here.

XDL_ALLOW_GROW() can't be used because the pointer is always a void*
in this function.

> > +void ivec_push(void *self_, const void *value)
> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +     void *dst =3D NULL;
> > +
> > +     if (self->length =3D=3D self->capacity)
> > +             ivec_reserve(self, 1);
> > +
> > +     dst =3D (uint8_t*)self->ptr + self->length * self->element_size;
> > +     memcpy(dst, value, self->element_size);
>
> If self->element_size was a compile time constant the compiler could
> easily optimize this call away. I'm not sure that is easy to achieve thou=
gh.

The problem is that I didn't want all of ivec to be macros that looked
like function calls. I wanted to minimize use of macros so that it was
easier to port and verify that the Rust implementation matches the
behavior of the C implementation.

> > +void ivec_free(void *self_)
>
> Normally we'd call a like this that free the allocations and
> re-initializes the members ivec_clear()

In Rust Vec.clear() means to set length to zero, but leaves the
allocation alone. The reason why I'm zeroing the struct is to help
avoid FFI issues. If not zero then what should the members be set to,
to indicate that using the struct is not valid anymore? In Rust an
object is freed when it goes out of scope and _cannot_ be accessed
afterward.

> > +{
> > +     struct IVec_c_void *self =3D self_;
> > +
> > +     free(self->ptr);
> > +     self->ptr =3D NULL;
> > +     self->length =3D 0;
> > +     self->capacity =3D 0;
> > +     // DO NOT MODIFY element_size!!!
> > +}
> > +
> > +void ivec_move(void *src_, void *dst_)
> > +{
> > +     struct IVec_c_void *src =3D src_;
> > +     struct IVec_c_void *dst =3D dst_;
>
> Maybe we should add
>
>         if (src->element_size !=3D dst->element_size)
>                 BUG("moving incompatible arrays");

I'll do that.

> > +
> > +     ivec_free(dst);
> > +     dst->ptr =3D src->ptr;
> > +     dst->length =3D src->length;
> > +     dst->capacity =3D src->capacity;
> > +     // DO NOT MODIFY element_size!!!
>
> As the element sizes must match maybe *dst =3D *src would be clearer?

That seems fine.

> > +
> > +     src->ptr =3D NULL;
> > +     src->length =3D 0;
> > +     src->capacity =3D 0;
> > +     // DO NOT MODIFY element_size!!!
> > +}
> > diff --git a/compat/ivec.h b/compat/ivec.h
> > new file mode 100644
> > index 0000000000..654a05c506
> > --- /dev/null
> > +++ b/compat/ivec.h
> > @@ -0,0 +1,52 @@
> > +#ifndef IVEC_H
> > +#define IVEC_H
> > +
> > +#include <git-compat-util.h>
>
> It would be nice to have some documentation in this header, see the
> examples in strvec.h and hashmap.h
>
> > +#define IVEC_INIT(variable) ivec_init(&(variable), sizeof(*(variable).=
ptr))
>
> This is a bit cumbersome to use compared to our usual *_INIT macros. I'm
> struggling to see how we can make it nicer though as DEFINE_IVEC_TYPE
> cannot define a per-type initializer macro and I we cannot initialize
> the element size without knowing the type.

I don't see what's cumbersome about it. Maybe an example use case
would clarify things.

```
DEFINE_IVEC_TYPE(xrecord_t, xrecord);

void some_function() {
    struct IVec_xrecord rec;
    IVEC_INIT(rec);  // i.e. ivec_init(&rec, sizeof(*rec.ptr);

    // use concrete functions to manipulate vector or access the array
directly via ptr
}
```

IVEC_INIT() should be used on the concrete type.

> > +
> > +#ifndef CBINDGEN
> > +#define DEFINE_IVEC_TYPE(type, suffix) \
> > +struct IVec_##suffix { \
> > +     type* ptr; \
> > +     size_t length; \
> > +     size_t capacity; \
> > +     size_t element_size; \
> > +}
>
> I wonder if we want to define type safe inline safe wrappers for the
> ivec_* functions here. I think the only functions where the element type
> matters are ivec_move() and ivec_push(), for the others like
> ivec_zero(), ivec_reserve() and ivec_free() the element type does not
> matter. ivec_push() would certainly be easier to use with a wrapper as
> means we can avoid forcing the caller to take the address of the value.
>
> static inline ivec_##suffix##_push(struct IVec_##suffix *self, type
> value) { \
>         const void *ptr =3D &value; \
>         ivec_push(self, ptr); \
> }

I turned ivec_push() into a macro, but the rest will remain as
concrete functions.
