Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203161519AB
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739507324; cv=none; b=cx/KZ91qqBPiJo4AtffrJmtlv0Ei8hlk8VUdC9YMoArng0WYCX6vGrP9A5itA4j2uDpCHXbpgIhR1V/MwvRZ/sk0BRJbPPJGVU7MVwDs2LKxe3oqZh4FLOPDcySS2B4hkxD87bXEV61ryox/QEv7afrgvFhgCEGmxSn26PlBPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739507324; c=relaxed/simple;
	bh=LHl0S0T0QrP4DvYSMkMZVJh7nwG7u3ECSFSizef1Dp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMaLw0UDJaWV5oFDmtBP737ommghIN6PHa8LPjl7okAp6OaD5yIliRooqbMrZoeo+UUfpG91PKuMKifnSkSh17ZqNWxDYVftUTB1Dl/Bjn4Ia+zJ9sFaKCMYd6JxuNJpi2OvYEclUNk0vjYaCJxzVxpf1+QW7DeqrUQ5mZTcPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDYCtcaA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDYCtcaA"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307c13298eeso15900941fa.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739507320; x=1740112120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32Qu8UOOIrTL+acmnPU9TAvsC8kdjPZYcxOhczear2E=;
        b=TDYCtcaA13RdrmCzSGOm/vcJR8Ts0q+drfXVx2Fu1uN/ecYS57NBiBgdJtnVNtM5oq
         +fsGmYbvOj7PFcWRFtp6A1AE3NMg1x1n46mCXjWAELTBqQptUmhZoH1wPAjHLg2N5M1R
         Gti7ZIoi2mqtfN6XkX/p94eXeTT9RE6PaCeg9g1nrLJmcWD+UMT5BJTmQ/MMsx5OrOtc
         XgxvndI88wsANdYbZbD1/ykUX36Bj0PscDhO3Et4gHzrXmcvo7SOc5J0gWOkmj3Ek466
         c/beHmZqZgFFBEZmF2YghPWLt6Pj1+X7L2c6kFtIeLUFZUayolN1kT1jVEDDjV8pjZRY
         8Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739507320; x=1740112120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32Qu8UOOIrTL+acmnPU9TAvsC8kdjPZYcxOhczear2E=;
        b=cygwZzgzpJCN5DPBh35MBIqiq4TLNe7r6GKpLX1Bv7tRnl6zUCUhe3ly2D8bseYQ01
         wdEbJSGgOro8zncByHqcRf1PTtovIAZr186bzK0szVOatBepR8Mj0X2G0aaSY6/qY7Js
         hlUeCsE58EcTrtrbENvMDLBOGtvTO3xqIvQJN04Bl5MqC6uQb+Zs4qyFUCN+G1yJXW5m
         C3g7pUZYH33YhVh7mU/nwtJSzcBStdrG2W53bKNhhLoOk8Qg+1t4iJmxrMkXlTBDYKmz
         4g/XYDmz7jcMjEepL04JSvIB1WEmE3qIs2P9QBhzHvKjTVjV7TuUEdBDcNmjWzhE/igE
         8+mA==
X-Gm-Message-State: AOJu0Yy5IeI9QHgPm6yVW6NzSfU3il8g4+kIxEc4vSz79Adzi/ekk4Zz
	eLoqwjeU2R/WS6xLDpuxWpWjqx2HnK4IzndlWcqtPmaRDwlUPjU1uahCPgwPv3Zq53/gkayEy8C
	WD0CecA77IysttvatvqoeqXp6PiY=
X-Gm-Gg: ASbGnctQw42iQsOV4QZTQFSvDmXkAqiC1uIDv0jtoE5mrNujFGiLcWz0UC+D7b7TP6f
	Y0g6vHyMWwlB9Y/+STZYIhvAkwyXKKuvQ0p7uqgul6ETpD6gaLr5hsmJFo3lPKUuI3qo4vVgSKu
	8=
X-Google-Smtp-Source: AGHT+IECg0JaMnE4v/xl/5iU4oN/EYM8k78DX8IYOjTnLeLshwI42yHDJS/TPgXwQuErNkaFsvvcgTnvqT59YmsL4vI=
X-Received: by 2002:a2e:b285:0:b0:308:e521:591 with SMTP id
 38308e7fff4ca-3090f3ab62fmr14528091fa.16.1739507319748; Thu, 13 Feb 2025
 20:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
 <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
In-Reply-To: <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Fri, 14 Feb 2025 09:58:28 +0530
X-Gm-Features: AWEUYZmv2ZhQwk_M3FNkDmCdHN08dcXiyqngdVUYf5WVjHo5Go7_cZUiNyBTjaA
Message-ID: <CAPhwyn0hz16mZ-UoVAczC4qDLx2i0LwfFhhDjdTahe0=4TO57g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 at 22:41, Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Feb 13, 2025 at 1:01=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com=
> wrote:
> >
> > Previously, `get_unmerged()` used `string_list_insert()`, which has an
> > O(n^2) complexity due to shifting elements on each insertion. It also
> > called `string_list_lookup()` before insertion, which performs a binary
> > search in O(log n).
>
> Okay.
>
> > This combination made insertion costly, especially
> > for large index states, as each new entry required both a search and
> > potentially shifting many elements.
>
> Why does the combination make it costly?  O(log n) + O(n^2) is still
> O(n^2), so I don't see why it matters to mention the combination.
> Could you clarify?
>
> Also, does it actually make it costly, or do you only suspect that it
> does?  O(n^2) worst case sometimes behaves O(n) or O(n log n) in some
> cases.  Since your commit message says "made insertion costly" instead
> of "might make insertion costly", I think that would suggest you have
> some performance numbers to back this up on some interesting real
> world repository.  Do you?  Can you share them?
>
Sorry, I should've specified, this patch is purely theoretical, I was
aiming for a trial
and error kind of approach.

> > Replace `string_list_insert()` with `string_list_append()` to achieve
> > O(n) insertion. After all entries are added, sort the list in O(n log n=
)
> > and remove duplicates in O(n), reducing the overall complexity to
> > O(n log n).
>
> Okay.
>
> > This improves performance significantly for large datasets
>
> That's a big claim; it may be true, but without evidence I don't
> believe it for three reasons : (1) n here is the number of conflicts,
> not the number of files in the repo or the number of lines being
> merged.  Thus, n is typically small.  (2) Other O(n^2) behavior in
> merge-recursive likely drowns this particular codepath out, so any
> gains here just aren't going to be noticed, (3) After looking at the
> code and knowing the specialized structure of the index, I think that
> while string_list_insert() for n items in general is going to be
> O(n^2), it will likely functionally be O(n log n) for this particular
> code path, meaning you haven't actually improved the performance.
>
> > while maintaining correctness.
>
> More on that below.
>
>
> > Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> > ---
> >  merge-recursive.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 884ccf99a5..6165993429 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -547,15 +547,15 @@ static struct string_list *get_unmerged(struct in=
dex_state *istate)
> >                 if (!ce_stage(ce))
> >                         continue;
> >
> > -               item =3D string_list_lookup(unmerged, ce->name);
> > -               if (!item) {
> > -                       item =3D string_list_insert(unmerged, ce->name)=
;
> > -                       item->util =3D xcalloc(1, sizeof(struct stage_d=
ata));
> > -               }
> > +               item =3D string_list_append(unmerged, ce->name);
> > +               item->util =3D xcalloc(1, sizeof(struct stage_data));
> > +
> >                 e =3D item->util;
> >                 e->stages[ce_stage(ce)].mode =3D ce->ce_mode;
> >                 oidcpy(&e->stages[ce_stage(ce)].oid, &ce->oid);
>
> Did you run any tests?  I'm not sure you maintained correctness here.

I didn't run any tests -- I wanted to, but I wasn=E2=80=99t sure how to do =
it
for this change. Since you suggested dropping this patch from the
series, I=E2=80=99ll do that. But for similar changes in the future, how sh=
ould I go
about testing them?
>
> >         }
> > +       string_list_sort(unmerged);
> > +       string_list_remove_duplicates(unmerged, 1);
> >
> >         return unmerged;
> >  }
> > --
> > 2.34.1
>
> (As a side note, due to the specialized structure of the input, I
> suspect this code could be modified to run in O(n), i.e. we could skip
> the string_list_lookup and the string_list_sort and the
> string_list_remove_duplicates...  But, it'd make the code trickier, so
> it'd need to be carefully commented, the change would need to be
> justified, and it'd need to be carefully tested.  Even if we weren't
> planning to delete this entire file, I suspect it's not possible to
> find a case justifying such a change without optimizing several other
> things in merge-recursive first, but optimizing those things probably
> results in a significant rewrite...which we've already done with
> merge-ort.)
Makes sense.

Thankyou for reviewing,
Meet
