Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205A22EF4
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642710; cv=none; b=CbGBdyZDw6jOOxC3F2cJbAB+oCiaDPFlN4eGNQxQTcCGtY6WjhzLCt748YFHKh81jJyT1nxPAtfRQDLTDNFWIRjo6IecDw9Pj2fvlrdFiJxIgZxUeXp1xG+6f9bkSLfKjVVhiEKyV6JP7MmAsWYm0GZbbW9gJvKyIGaoItP8kK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642710; c=relaxed/simple;
	bh=rSRlQmWkzRZFTi+wTYHasc5IY7pyIAXzMJA6JErZZso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gr+3xxD1Q1hM48tC8amv1ovXTh2ErZIo+g+bEIYbHqpNGjpMIVDI2YbKL1PIkbMpZl5mFmc4cunl+/+Lx5n+lxzaILae0no8cldfREVuiEPo8Ct3H1Jq52bg065GHE6hKJURFXmb7BgtC44Eicu68tUJlyuXNP9rBQkMxYiw858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zc5tL3qH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zc5tL3qH"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aac70e30dso213906966b.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722642707; x=1723247507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRfG27PSN4nMkyPHx8JXZKXmfX/LPlfGYWun72umwI4=;
        b=zc5tL3qHeCpKJfjDl1WlPbh/EcWTBRpA75GjyS0liLFNqiLlnToeA4CwD0ah3YEKVq
         mb1V0ut6mapdaf2dO4dvU+lPx1uDHU/nss+QJ43iVBdPWvhyoQb6WYZbMsFMGsII89Th
         dtTY+nBGASoVcxNFWqGkFkC/XPMMDWXmEjHr0lAQoL1B8MEwNyBSXfPfubdvwdSpryMv
         nE8xNchHxNiJGv739jpULpz1M7+Hhjv2mrwP/vJ1V5Kkn2qae8LqejtR+sCjaknNp1Dx
         X/BQxhTHgs/uehNQ53bECMldhFC2uKIaXrrsoUfvyXcxDRTBsfTIXDSnqy2jHCJE7S5w
         FguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722642707; x=1723247507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRfG27PSN4nMkyPHx8JXZKXmfX/LPlfGYWun72umwI4=;
        b=GK2+6iR5y91ioUm4dxXY8IaqB563ApB7KA6psYRZE3Q77cv31V25YfeAIW2aq1qrIL
         sEdhbTqyxoH0hFDNWBan0TD0kPq92yedGR7BJMxaG44g3JBEL4IbVg0Y/tCeh06uK6/O
         pk2D19HlOMGfj93gQcntmiVj9au9TfrYjKV/jNs27FIV7QUC+2Sd8D/16hCW50e5TZeM
         bikVDr451W4Uiz30pq2GPvuF2CSTtezogAp2QC3UjRGr6fAscUCx2pBodazJPpjbv2QC
         xWjwgdoA9Ip6VBZUjrl1DCh6TWrB0YTkV6XJJzyodPc3GgqOtRBoBXGC+PKCvEhOLb1z
         4Iyw==
X-Forwarded-Encrypted: i=1; AJvYcCU+e67TxBSMlYJSMLnVaiA/a/ZUqFAZfEtgyle+4aqwt4Re86fEA2vgU7qAph5hY5Dk+e2DxNpKAh8GATThEvK3OMUu
X-Gm-Message-State: AOJu0YysNrx0GX+/d1e9zu6AJT2O+N8aWGdzt4xrfOSb9En+b3DCiwoT
	9zKyoGE61AzPvx8SVmB2X3nhklxWIO4Y/KArhsURemd2AlMa7ItCeyKlyKA4BgnuVtrekiyigZM
	dZVIwWhQ2Yrr6QrOq2TjzF/QXZ/5NtEZ1zH2VsCIgVKI3LBt0e6t6
X-Google-Smtp-Source: AGHT+IHqaucmKJi8kFuuvSSyaZEVV6z+4WhKgZeWD+BgrXWoDTfxCM+d9snXZCBFJVqDNXYq1MMQDT7IPEt/t6HYbS8=
X-Received: by 2002:a17:907:2cc3:b0:a7a:a0c2:8be9 with SMTP id
 a640c23a62f3a-a7dc5016722mr371889466b.18.1722642706912; Fri, 02 Aug 2024
 16:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com> <0ed09e9abb85e73a80d044c1ddaed303517752ac.1722632287.git.gitgitgadget@gmail.com>
 <xmqqv80ia9wf.fsf@gitster.g>
In-Reply-To: <xmqqv80ia9wf.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 2 Aug 2024 16:51:31 -0700
Message-ID: <CAO_smVjYYaE3UZd0M28j+=uYMLdDPRAN08X1Yb_=5+nU4GrkSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] strbuf: set errno to 0 after strbuf_getcwd
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Kyle Lippincott <spectral@google.com>
> >
> > If the loop executes more than once due to cwd being longer than 128
> > bytes, then `errno =3D ERANGE` might persist outside of this function.
> > This technically shouldn't be a problem, as all locations where the
> > value in `errno` is tested should either (a) call a function that's
> > guaranteed to set `errno` to 0 on success, or (b) set `errno` to 0 prio=
r
> > to calling the function that only conditionally sets errno, such as the
> > `strtod` function. In the case of functions in category (b), it's easy
> > to forget to do that.
> >
> > Set `errno =3D 0;` prior to exiting from `strbuf_getcwd` successfully.
> > This matches the behavior in functions like `run_transaction_hook`
> > (refs.c:2176) and `read_ref_internal` (refs/files-backend.c:564).
>
> I am still uneasy to see this unconditional clearing, which looks
> more like spreading the bad practice from two places you identified
> than following good behaviour modelled after these two places.
>
> But I'll let it pass.
>
> As long as our programmers understand that across strbuf_getcwd(),
> errno will *not* be preserved, even if the function returns success,
> it would be OK.  As the usual convention around errno is that a
> successful call would leave errno intact, not clear it to 0, it
> would make it a bit harder to learn our API for newcomers, though.

I'm sympathetic to that argument. If you'd prefer to not have this
patch, I'm fine with it not landing, and instead at some future date I
may try to work on those #leftoverbits from the previous patch (to
make a safer wrapper around strtoX, and ban the use of the unwrapped
versions), or someone else can if they beat me to it.

Since this is wrapping a posix function, and posix has things to say
about this (see below), I agree that it shouldn't set it to 0, and
withdraw this patch.

I'm including my references below mostly because with the information
I just acquired, I think that any attempt to _preserve_ errno is also
folly. No function we write, unless we explicitly state that it _will_
preserve errno, should feel obligated to do so. The number of cases
where errno _could_ be modified according to the various
specifications (C99 and posix) are just too numerous.

---

Perhaps because I'm not all that experienced with C, but when I did C
a couple decades ago, I operated in a mode where basically every
function was actively hostile. If I wanted errno preserved across a
function call, then it's up to me (the caller) to do so, regardless of
what the current implementation of that function says will happen,
because that can change at any point. Unless the function is
documented as errno-preserving, I'm going to treat it as
errno-hostile. In practice, this didn't really matter much, as I've
never found `if (some_func()) { if (!some_other_func()) { /* use errno
from `some_func` */ } }` logic to happen often, but maybe it does in
"real" programs, I was just a hobbyist self-teaching at the time.

The C standard has a very precise definition of how the library
functions defined in the C specification will act. It guarantees:
- the library functions defined in the specification will never set errno t=
o 0.
- the library functions defined in the specification may set the value
to non-zero whether an error occurs or not, "provided the use of errno
is not documented in the description of the function in this
International Standard". What this means is that (a) if the function
as defined in the C standard mentions errno, it can only set the
values as specified there, and (b) if the function as defined in the C
standard does _not_ mention errno, such as `fopen` or `strstr`, it can
do _whatever it wants_ to errno, even on success, _except_ set it to
0.

POSIX has similar language
(https://pubs.opengroup.org/onlinepubs/009695399/functions/errno.html),
with some key differences:
- The value of errno should only be examined when it is indicated to
be valid by a function's return value.
- The setting of errno after a successful call to a function is
unspecified unless the description of that function specifies that
errno shall not be modified.

This means that unlike the C specification, which says that if a
function doesn't describe its use of errno it can do anything it wants
to errno [except set it to 0], in POSIX, a function can do anything it
wants to errno [except set it to 0] at any time.

What this means in practice is that errno should never be assumed to
be preserved across calls to posix functions (like getcwd). Also,
strbuf_getcwd calls free, malloc, and realloc, none of which mention
errno in the C specification, so they can do whatever they want to it
[except set it to 0]. That I was able to find one single function that
was causing problems is luck, and not guaranteed by any specification.

Kind of makes me want to try writing an actively hostile C99 and POSIX
environment, and see how many things break with it. :) C99 spec
doesn't say anything about malloc setting errno? Ok! malloc now sets
errno to ENOENT on tuesdays [in GMT because I'm not a monster], but
only on success. On any other day, it'll set it to ERANGE, regardless
of success or failure.

>
> Thanks.
>
> > Signed-off-by: Kyle Lippincott <spectral@google.com>
> > ---
> >  strbuf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/strbuf.c b/strbuf.c
> > index 3d2189a7f64..b94ef040ab0 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -601,6 +601,7 @@ int strbuf_getcwd(struct strbuf *sb)
> >               strbuf_grow(sb, guessed_len);
> >               if (getcwd(sb->buf, sb->alloc)) {
> >                       strbuf_setlen(sb, strlen(sb->buf));
> > +                     errno =3D 0;
> >                       return 0;
> >               }
