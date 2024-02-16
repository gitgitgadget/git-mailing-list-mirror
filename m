Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E01772D
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045845; cv=none; b=s61Nnidu5wfv+DSfKH53NO0Ucz2wKZnSPY5jIQDIztR71hlSq0E+8s3l5lYLM3p8ZF9UxymkFwW4+xgVKpGoYx9MFcejX6ZWXa4QmNQZ1Db0U+aiD1rglil3dyp8I4leY9MuCjgCay4WlXC5cHzhWyCK6x3BJs9/59cDlGjyaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045845; c=relaxed/simple;
	bh=Kax+vRGLATXKQdwYWVE4kpRZqrNC9HjcCvyZXADymaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cmPpGq96hPJdIg6MbAGlNldoG0GifVlFEtwRDKs3ZVBgh4sgLPRkOlbwHSs4BYzOtIvxqBZmxUFG3TvGZ8zMPZ6iapPzl6uWu56VP8BgdwH9p/iL+PbcMgCOw+3F9Y7+lhJ7y5EaWv7TMfAai+pdUUu4gN09SsLcRMiQaObZW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2OX03Qr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2OX03Qr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e0eed3a0feso1701227b3a.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 17:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708045843; x=1708650643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EghtN5GTWosuLPZC6vdlieKUb2Rjd1U59JoJ/dL9NiE=;
        b=D2OX03QrL9Lt8AORQPGwIAsHRjrSifJew5FJBujuQdCQCIs/TdzTV9/YbBqhwOPTqG
         9+cX/SynTdti2CWVY7hydP/Pr0iT5Yv8qwTG1OBM1hjwbH3JSFM4aRgWyFrf4JHxpTXI
         hLc19T/f8R0FNsq3YFY90dwl1iU7l/a3bbCDv7EYwzvPdhdg4d/8XIzORd+wjeFawEUo
         eTDHqPnepzeVfW3ST+i+AsLH0D1KURHNXEHzdh0lUvD4E+zilCKWhUsOM2UYAy2lRHns
         eoyHDrwPNf6GaSwGsYjumuUKEeBfFTuVga9VLyp7+s89sNfx1VZj7b884LCcRER8MeKz
         vJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708045843; x=1708650643;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EghtN5GTWosuLPZC6vdlieKUb2Rjd1U59JoJ/dL9NiE=;
        b=BRPEdW/gUMvKDAHtJYSssJHTpoyl1Ql8Rhswnha5qla2xSdcCYUB4l+FbMl+Q8fW5N
         27L9dA7hexgk4FFUdNaMzz0OdyqZLKQ4GEAHJHa6ZzoSZfsj1I8UTcUxzjBfczXTUkPT
         041qWwyzWD3OatekustR3Zv0/E6E428PbjuH9IO1lJrLMiSt3bbSyqDbWXhVza+Pb6vx
         ivM7N7yVdWnFNiIf1SVqNVY6SMRdQBEF5PPNG2AG+n4fqlatL+D9fcIyfjVjROb0h+yt
         tLoOGtCwfiiH1W5RkIWre5NJH1PhxjarMb7m7XWEnrrlz1Gdkim0wPCcGU4YZkNQ6IgY
         uurQ==
X-Gm-Message-State: AOJu0YzfBv3qvNfvg6PVjBztS+9bU79DyHhQPtxdDvrUD+fPF+R3aL72
	CiRg5q1keGWJTaOoVl/lNNUqb86No/dS8EIIQhhn21HruxAF+8xtI/Qg/j8HZwGvA8wrAAdX5sJ
	tKA==
X-Google-Smtp-Source: AGHT+IE4YtW45Fjt+091y4+HmL8LVX/hl0DWTSPb2/1UXNWMnWBKAGsPPKxVM3XyZXDVZPVs7rsQnNcOTSE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:99d:b0:6e0:ab5f:caf2 with SMTP id
 u29-20020a056a00099d00b006e0ab5fcaf2mr179838pfg.6.1708045843225; Thu, 15 Feb
 2024 17:10:43 -0800 (PST)
Date: Thu, 15 Feb 2024 17:10:41 -0800
In-Reply-To: <CAP8UFD1aJD5i68ekHuq0UG14X19y=Eo6qKPianF8MKNf6iZ_WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240208135055.2705260-3-christian.couder@gmail.com> <owlyle7o9iyf.fsf@fine.c.googlers.com>
 <CAP8UFD1aJD5i68ekHuq0UG14X19y=Eo6qKPianF8MKNf6iZ_WQ@mail.gmail.com>
Message-ID: <owlyy1bl8b8u.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	John Cai <johncai86@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Feb 13, 2024 at 10:02=E2=80=AFPM Linus Arver <linusa@google.com> =
wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > In a following commit, we will need to add all the oids from a set int=
o
>> > another set. In "list-objects-filter.c", there is already a static
>> > function called add_all() to do that.
>>
>> Nice find.
>>
>> > Let's rename this function oidset_insert_from_set() and move it into
>> > oidset.{c,h} to make it generally available.
>>
>> At some point (I don't ask for it in this series) we should add unit
>> tests for this newly-exposed function. Presumably the stuff around
>> object/oid handling is stable enough to receive unit tests.
>
> Yeah, ideally there should be unit tests for oidset and all its
> features, but it seems to me that there aren't any. Also oidset is
> based on khash.h which was originally imported from
> https://github.com/attractivechaos/klib/ without tests. So I think
> it's a different topic to add tests from scratch to oidset, khash.h or
> both.
>
> Actually after taking another look, it looks like khash.h or some of
> its features are tested through "helper/test-oidmap.c" and
> "t0016-oidmap.sh". I still think it's another topic to test oidset.

Agreed.

>> > +void oidset_insert_from_set(struct oidset *dest, struct oidset *src)
>> > +{
>> > +     struct oidset_iter iter;
>> > +     struct object_id *src_oid;
>> > +
>> > +     oidset_iter_init(src, &iter);
>> > +     while ((src_oid =3D oidset_iter_next(&iter)))
>>
>> Are the extra parentheses necessary?
>
> Yes. Without them gcc errors out with:
>
> oidset.c: In function =E2=80=98oidset_insert_from_set=E2=80=99:
> oidset.c:32:16: error: suggest parentheses around assignment used as
> truth value [-Werror=3Dparentheses]
>   32 |         while (src_oid =3D oidset_iter_next(&iter))
>      |                ^~~~~~~
>
> Having extra parentheses is a way to tell the compiler that we do want
> to use '=3D' and not '=3D=3D'. This helps avoid the very common mistake o=
f
> using '=3D' where '=3D=3D' was intended.

Ah, so it is a "please trust me gcc, I know what I am doing" thing and
not a "this is required in C" thing. Makes sense, thanks for clarifying.

Sorry for the noise.

>> > +/**
>> > + * Insert all the oids that are in set 'src' into set 'dest'; a copy
>> > + * is made of each oid inserted into set 'dest'.
>> > + */
>>
>> Just above in oid_insert() there is already a comment about needing to
>> copy each oid.
>
> (It's "oidset_insert()" not "oid_insert()".)

Oops, yes, sorry for the typo.

>>     /**
>>      * Insert the oid into the set; a copy is made, so "oid" does not ne=
ed
>>      * to persist after this function is called.
>>      *
>>      * Returns 1 if the oid was already in the set, 0 otherwise. This ca=
n be used
>>      * to perform an efficient check-and-add.
>>      */
>>
>> so perhaps the following wording is simpler?
>>
>>     Like oid_insert(), but insert all oids found in 'src'. Calls
>>     oid_insert() internally.
>
> (What you suggest would need s/oid_insert/oidset_insert/)
>
> Yeah, it's a bit simpler and shorter, but on the other hand a reader
> might have to read both this and the oidset_insert() doc, so in the
> end I am not sure it's a big win for readability. And if they don't
> read the oidset_insert() doc, they might miss the fact that we are
> copying the oids we insert, which might result in a bug.

When functions are built on top of other functions, I think it is good
practice to point readers to those underlying functions. In this case
the new function is a wrapper around oidset_insert() which does all the
real work. Plus the helper function already has some documentation about
copying behavior that we already thought was important enough to call
out explicitly.

So, tying this definition to that (foundational) helper function sounds
like a good idea to me in terms of readability. IOW we can inform
readers "hey, we're just a wrapper around this other important function
--- go there if you're curious about internals" and emphasizing that
sort of relationship which may not be immediately obvious to those not
familiar with this area would be nice.

Alternatively, we could repeat the same comment WRT copying here but
that seems redundant and prone to maintenance burdens down the road (if
we ever change this behavior we have to change the comment in multiple
functions, possibly).

> Also your wording ties the implementation with oidset_insert(), which
> we might not want if we could find something more performant. See
> Junio's comment on this patch saying his initial reaction was that
> copying underlying bits may even be more efficient.
>
> So I prefer not to change this.

OK.

>> > +void oidset_insert_from_set(struct oidset *dest, struct oidset *src);
>>
>> Perhaps "oidset_insert_all" would be a simpler name? I generally prefer
>> to reuse any descriptors in comments to guide the names. Plus this
>> function used to be called "add_all()" so keeping the "all" naming style
>> feels right.
>
> We already have other related types like 'struct oid-array' and
> 'struct oidmap' to store oids, as well as code that inserts many oids
> into an oidset from a 'struct ref *' linked list or array in a tight
> loop.

Thank you for the additional context I was not aware of.

> So if we want to add functions inserting all the oids from
> instances of such types, how should we call them?
>
> I would say we should use suffixes like: "_from_set", "_from_map",
> "from_array", "_from_ref_list", "_from_ref_array", etc.

I agree.

However, I would like to point out that the function being added in this
patch is a bit special: it is inserting from one "oidset" into another
"oidset". IOW the both the dest and src types are the same.

For the cases where the types are different, I totally agree that using
the suffixes (to encode the type information of the src into the
function name itself) is a good idea.

So I think it's still fine to use "oidset_insert_all" because the only
type in the parameter list is an oidset.

BUT, maybe in our codebase we already use suffixes like this even for
cases where the types are the same? I don't know the answer to this
question. However if we really wanted to be consistent then maybe we
should be using the name oidset_insert_from_oidset() and not
oidset_insert_from_set().

> If we start using just "_all" for oidset, then what should we use for
> the other types? I don't see a good answer to that, so I prefer to
> stick with "_from_set" for oidset.
>
> Thanks.
