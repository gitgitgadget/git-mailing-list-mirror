Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FD30215E
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167585; cv=none; b=CLAnMYuQ/8Dpza2b+ZHGxGW69sUdEikliwXgsrj8Nh79vTZMC6ZrlXPtyajkZpJKepnyeSsyoXOu38HnZBtOjakRnGtxo7Tnajltfro+VGXShJ1NzdrMgCFwM9xO64kKB4KbTr27iYuYAXugCGjbrHftGwCATy7Kg518fK6T5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167585; c=relaxed/simple;
	bh=TKqHuTdc4vV21ADJAW2qEpmyegeWot10gqNrIuoaWFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cE3p82LZuc6Rb185VqX28rjohU/z1DUrCyAJwjqjiSs/yisLy+mPdNramuqmBnppjT5Ja5xiiMDATIbOzHd/ES+mnml2SIRpew3DGztM0fy/9MpFl5hgmnRmwROUxjYv6BDYR454GWUHxS9rxycFD4fUJgjFQKLZrh7gUugbXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI+MxNiL; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI+MxNiL"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430c6eef4b9so670065ab.0
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761167583; x=1761772383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4UVYUYQMZcP12r2q4ceaabpv+9D0pM9i4JapTZen7Q=;
        b=SI+MxNiLfIIiiJPaNvFiS6kxI6kW9VcZOWYw/YJxzT95gXOeWAgJ5veLvi97mENd42
         +40QZk+2YveOvjK9zJegde7NjPMMIJRVOFzr2xRA9jlUaWFyAnVFK1pdmR/a5sm16XEc
         7KnIgjaN1xnXtYWE0sARTYLDEvwLXBcFMVEqeG0u83j4f6x5PorBvze33DJZPjVGcz8i
         mrnqiXuEAfOZ87SFV45AumdGpjH2JEvEmxf2WfLV4zIEjGqR8LnvzhoB7beT6uKcn278
         3JA5UPdxG6SoYunlEvbL1/hDMV9n3c4Dne9WGsyPf89eCim/bh8b4wOe4uX7RMQ/UIqH
         siEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167583; x=1761772383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4UVYUYQMZcP12r2q4ceaabpv+9D0pM9i4JapTZen7Q=;
        b=Br1fqNb0xaEgdViIByuaQKahqcyxA/UK5yO29g1yEJkaKXcNpfJEbnQT+liea6o6y4
         WWJHhSUdXCndKdwcCXbQliJjeA6GDMce0AZmYlSYg8nDRpM/nTAtyzGHcROoI6BltfwK
         Y3A9V44N6iAka0/fi68gM7oocYmR3xetMN9RRVtt9wZ5+h07ZYwp1gQHEw3YPaSjJpYc
         NQmgPZkHl/ql+2H6upfBCRwpHPRfmoLwuPSxrHZVSFxQHDk1XRiGnY4TAdgr3YTtp22l
         0x8klLb9euPpsFVWuF2hUGZgCQ9pNv5M/O+cCrXxH/j8hvYxCv/I1lCeB1yuRJ49muPa
         GP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkZfkk7NkFKTYGa78uDlWWIPIkQZJYQ0xiw0vnogf0Ay3IzDkMedx+G4rKU7wUmJojzhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP651zm8XNhNCgDlilyAEP4nNVPhPVSM+fSHG+uVSYN5f5eu+S
	3PbcbOKdPed+K/Bdhms1ikqBV3vbsXL6WVPmMo1H/drCK4woujH2kBjqchQmbIpknl7Q7vDR8mG
	68Py415XvBvOR/BELBYACjVKc9c/m1vs=
X-Gm-Gg: ASbGncudNjx2Adu964KkfyF40MjMr4bGU71fNsHmljQBMGnAkcgEqnoqrnMOl1ArnQq
	9eNiKSQKTzhfMhv3rXe3YEWnYm7iv48TRfABJ9+Jo+0Occq0ZwrLiaRqiKVOL4eIj5WtGJTlbQ/
	Hxve9m9xvTcd89cJzMyRPF/UNjpBEp0navSyYXkW/uo8+E1tgKeqp+nGvKy33QgNjzLpvUSw+uk
	5oCT1CIOaKeF28fv9V19c3AXqKaVCwLJpx4oN4v+kp22hkJT1EXh/XZZX4iISF8f/0ppTgI
X-Google-Smtp-Source: AGHT+IGGN5qhiMl/eb6LQDyCAz4fb0Do8d2jQyubtDF57Hk0rQsBaGYAeV2eaK7n/3+WReTB/FSuE3ubbb2JLqnjmUI=
X-Received: by 2002:a92:c26c:0:b0:431:d864:3658 with SMTP id
 e9e14a558f8ab-431d864382dmr27405635ab.20.1761167583250; Wed, 22 Oct 2025
 14:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <7b9e8961d42e0f367ba0782e7d932607aa7e0b0a.1760563101.git.gitgitgadget@gmail.com>
 <aPdFZp8GokGoshol@pks.im>
In-Reply-To: <aPdFZp8GokGoshol@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 15:12:50 -0600
X-Gm-Features: AS18NWABFzzSwJOJ-PPe0ATQWyZUOHpKKi1NS4gdwKBuw5tXM2muKI4-rMNhTIQ
Message-ID: <CAH=ZcbDOY2yDQbBJeoKHesZzZCBvscqf7SoqbX4j3oHCBY5p8g@mail.gmail.com>
Subject: Re: [PATCH 2/9] xdiff: make xrecord_t.ptr a uint8_t instead of char
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Oct 15, 2025 at 09:18:14PM +0000, Ezekiel Newren via GitGitGadget=
 wrote:
> > diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> > index 6f3998ee54..411a8aa69f 100644
> > --- a/xdiff/xdiffi.c
> > +++ b/xdiff/xdiffi.c
> > @@ -993,11 +993,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *=
xscr, xdfenv_t *xe, long flags)
> >
> >               rec =3D &xe->xdf1.recs[xch->i1];
> >               for (i =3D 0; i < xch->chg1 && ignore; i++)
> > -                     ignore =3D xdl_blankline(rec[i].ptr, rec[i].size,=
 flags);
> > +                     ignore =3D xdl_blankline((const char *)rec[i].ptr=
, rec[i].size, flags);
> >
> >               rec =3D &xe->xdf2.recs[xch->i2];
> >               for (i =3D 0; i < xch->chg2 && ignore; i++)
> > -                     ignore =3D xdl_blankline(rec[i].ptr, rec[i].size,=
 flags);
> > +                     ignore =3D xdl_blankline((const char *)rec[i].ptr=
, rec[i].size, flags);
> >
> >               xch->ignore =3D ignore;
> >       }
>
> Okay. Seemingly, we convert the structure itself, but we don't convert
> any of the functions to accept an `uint8_t`. I guess you drew the line
> here so that we don't have to also touch up dozens of function
> signatures?

That is correct. I wanted to avoid _boiling the ocean_ just to change
the type of ptr.

> And how did you end up verifying that you added all casts? Does the
> compiler flag those as warnings?

I used CLion to search for all uses of that field and then added casts
where the types differ. Another way to do that is to run `make
DEVELOPER=3D1` and address all of the `uint8_t differs in signedness
from char` errors that are spat out.

> In any case, it might be nice to explain both of these details in the
> commit message.

I will update it.

Thanks.
