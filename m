Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959265A785
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921202; cv=none; b=WfAdniJ865Cd2kzdkQQMrsiLOvlzcu6eIDkV/mNlmNhBkh3gN8Fb3sfLK00DZf92cgu3gQcAX7Qz1h8y+rIOni0tcytxsaH5ml59POAiPzjIKo7saqnFnF3EtZriJIA6CrIS+maS9DS0JpLgAI0ttKKv9HvOXQ11b41Z+6lQw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921202; c=relaxed/simple;
	bh=ktBz/d7IIVmoJe5xNYTd2WGq6esJnJnw8V3i32w/T/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCYNjCSNl7EjbABmvtVLr09yijO2/ZR1GzkH3s3z3RfCDBK49v+mBGRbB9BBmJYsqG8aNHhSLMV5s1FyikuiE+m7tn0RMdWGFnXfT1koCwFC5+inY5mnzOJrxh0I7KCFkPsrm0vug4p0kXcXmuP+9yrI+MVuPt5DFyj/T3gi4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6zn3kAY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6zn3kAY"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26fa294e56so755104366b.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707921199; x=1708525999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSS2zRrBniwYGPNqe/WMwtzmAx04vUAJEHoPAgQlaR4=;
        b=F6zn3kAYIIl+Afcy4qImgkIdRfUcfluQkcA1KOImwL0aWMvDFRKxX4SjWHdbC90i3Z
         53BCCFAGhoWW3+aQ8Z+1OiK9D/dmDaWBPlMSVJvjKQ9/WgbfJJ5BP0zB3K1J85vJyjFF
         2RjKORuGfPRhexeNbFIrHYfYeX4yTqG0hdZqTuRP1NlcT7p1L7d4LqX/dAaxKHUz6Bfg
         UaZqj6N5WGdwPrFsG95LGW9xsWlG7k8AzIbpjxv4hzgMOSa5kDC5LOKxIwMr5Wl9Xlaj
         yAzGLvTZTBnnS7wjRT+D/zRAuYMiJOmrfRkwRMIjGmwNwvI5CkOYcQUkK0dpr6y8q0Fn
         qz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921199; x=1708525999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSS2zRrBniwYGPNqe/WMwtzmAx04vUAJEHoPAgQlaR4=;
        b=gRVS2Plc0ETICLSZS6sIY4NVkM8ug7l4MpuoU1cyrbJcSDTb+bn4nBeTCugeg2cF7t
         Y5a1Y7KO4oAfDGIRnpN2OnOzbXhhtejxjiqkty0CX25scOQsZte6ZcH6c6OsQktSJ9r3
         tz+2iO46WlC3aVhRRE1lznbJ+EGzrNxGKZJfOO26owJ5/qaAWD0BbKTG0dp60yBJcCrE
         QkszChQMGzrNND7NNir0ot0ykjdchyXprCyc4VgdSDF80OZz0e1gJ8L0eo03KbU67paW
         9M1/LIioYwkBGRAo/OdWADj4rNJaP0dTw3evF1qGHOSxKgXLCsXo2O3XDbLFdkytXRcd
         i42A==
X-Gm-Message-State: AOJu0YzAz2Tcv+7wVntVp341M8CSmrz9Cj1JYPbEUxY6mMInwbX/v+1H
	QuZLu5iCeiIfclr0mC7q8IL0i1IlKA3ldUusYMnOTRUGfDMXG6WtVzza2VEnhXfIc5Ke9F+eJS4
	fJ3XU9HHZWzDhW4hQdUC4aMHIGYrrG/C1xe8=
X-Google-Smtp-Source: AGHT+IE24qFU6LOBTZaZ4dQDCgJsGsgaSC1nHA5OSn3ocBQUYrRJQQylfTPosP13n6Z+7EUgY0W6KukSthXTLl6i86M=
X-Received: by 2002:a17:906:f2cc:b0:a3d:6eb4:9769 with SMTP id
 gz12-20020a170906f2cc00b00a3d6eb49769mr265862ejb.15.1707921198489; Wed, 14
 Feb 2024 06:33:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-3-christian.couder@gmail.com> <owlyle7o9iyf.fsf@fine.c.googlers.com>
In-Reply-To: <owlyle7o9iyf.fsf@fine.c.googlers.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 14 Feb 2024 15:33:06 +0100
Message-ID: <CAP8UFD1aJD5i68ekHuq0UG14X19y=Eo6qKPianF8MKNf6iZ_WQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:02=E2=80=AFPM Linus Arver <linusa@google.com> wr=
ote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In a following commit, we will need to add all the oids from a set into
> > another set. In "list-objects-filter.c", there is already a static
> > function called add_all() to do that.
>
> Nice find.
>
> > Let's rename this function oidset_insert_from_set() and move it into
> > oidset.{c,h} to make it generally available.
>
> At some point (I don't ask for it in this series) we should add unit
> tests for this newly-exposed function. Presumably the stuff around
> object/oid handling is stable enough to receive unit tests.

Yeah, ideally there should be unit tests for oidset and all its
features, but it seems to me that there aren't any. Also oidset is
based on khash.h which was originally imported from
https://github.com/attractivechaos/klib/ without tests. So I think
it's a different topic to add tests from scratch to oidset, khash.h or
both.

Actually after taking another look, it looks like khash.h or some of
its features are tested through "helper/test-oidmap.c" and
"t0016-oidmap.sh". I still think it's another topic to test oidset.

> > +void oidset_insert_from_set(struct oidset *dest, struct oidset *src)
> > +{
> > +     struct oidset_iter iter;
> > +     struct object_id *src_oid;
> > +
> > +     oidset_iter_init(src, &iter);
> > +     while ((src_oid =3D oidset_iter_next(&iter)))
>
> Are the extra parentheses necessary?

Yes. Without them gcc errors out with:

oidset.c: In function =E2=80=98oidset_insert_from_set=E2=80=99:
oidset.c:32:16: error: suggest parentheses around assignment used as
truth value [-Werror=3Dparentheses]
  32 |         while (src_oid =3D oidset_iter_next(&iter))
     |                ^~~~~~~

Having extra parentheses is a way to tell the compiler that we do want
to use '=3D' and not '=3D=3D'. This helps avoid the very common mistake of
using '=3D' where '=3D=3D' was intended.

> > +/**
> > + * Insert all the oids that are in set 'src' into set 'dest'; a copy
> > + * is made of each oid inserted into set 'dest'.
> > + */
>
> Just above in oid_insert() there is already a comment about needing to
> copy each oid.

(It's "oidset_insert()" not "oid_insert()".)

>     /**
>      * Insert the oid into the set; a copy is made, so "oid" does not nee=
d
>      * to persist after this function is called.
>      *
>      * Returns 1 if the oid was already in the set, 0 otherwise. This can=
 be used
>      * to perform an efficient check-and-add.
>      */
>
> so perhaps the following wording is simpler?
>
>     Like oid_insert(), but insert all oids found in 'src'. Calls
>     oid_insert() internally.

(What you suggest would need s/oid_insert/oidset_insert/)

Yeah, it's a bit simpler and shorter, but on the other hand a reader
might have to read both this and the oidset_insert() doc, so in the
end I am not sure it's a big win for readability. And if they don't
read the oidset_insert() doc, they might miss the fact that we are
copying the oids we insert, which might result in a bug.

Also your wording ties the implementation with oidset_insert(), which
we might not want if we could find something more performant. See
Junio's comment on this patch saying his initial reaction was that
copying underlying bits may even be more efficient.

So I prefer not to change this.

> > +void oidset_insert_from_set(struct oidset *dest, struct oidset *src);
>
> Perhaps "oidset_insert_all" would be a simpler name? I generally prefer
> to reuse any descriptors in comments to guide the names. Plus this
> function used to be called "add_all()" so keeping the "all" naming style
> feels right.

We already have other related types like 'struct oid-array' and
'struct oidmap' to store oids, as well as code that inserts many oids
into an oidset from a 'struct ref *' linked list or array in a tight
loop. So if we want to add functions inserting all the oids from
instances of such types, how should we call them?

I would say we should use suffixes like: "_from_set", "_from_map",
"from_array", "_from_ref_list", "_from_ref_array", etc.

If we start using just "_all" for oidset, then what should we use for
the other types? I don't see a good answer to that, so I prefer to
stick with "_from_set" for oidset.

Thanks.
