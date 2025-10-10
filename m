Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1EA28F5
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760055217; cv=none; b=ArK2jyirc5IEggiAGu3NytYwRVCiwN+nCOJprL9GtoJ6dntqQ1kVptI4J3u+ldNXPOkkffIehR/Atr+xfu38V04hFAzsQ+pe+ZRdmD8qrYQLvHXzkJZ2iyw8SU2P2j39sVremqu7i12wYpQ3CBcIGmWjrtwQjM3DwL44SbJ3EmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760055217; c=relaxed/simple;
	bh=ihmE7UXLDGfKQH6k2hoP0+skGCouGjnauwwv/NiiMLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0h7dJ75myBjKWLybfhap9Lv/PMVBaxmLorOYZsaaZgIZ1Fgb0Sffrp12wLJ35w4iKqJdqeQUmg4SwCVKZ8eDvITU/55Hzk4UekKjmHa/pNjwR7+iUpjI52UCZb4pflEKq04EGa31Kc88E/ZyV6FY+7o+MRaqkhvwTnr8Am100g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr0uo4Tn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr0uo4Tn"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so290858766b.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 17:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760055214; x=1760660014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyDC1ie8B3oILTcCsslcBAnJjiWRWRVBnLrrDbtN9tI=;
        b=Dr0uo4Tng5veKJJraquZHcMhqTiBPxJbmyMsQCmkoAUhyQOZBxOodE3yehdvHf04i3
         yZsbANzZZA7UY6Yz6LN/YHn1Tm5p2ajBw9QjJD7Zv0cJgxCgX8AnrhdnRXOY4PfKhQQ9
         IIn3qAFuEW2YOeDMGp6PQAug70Yq3qeky5ev9SPxNwlXEHvNYnhyb04etjWM8hQfF5YF
         ttvfTXiNtHJ6fGyUG3EJcoIZiB0Q4LQ+2XBSllSWMfbN/DSQduadJ70n8XTIcvvJfG9i
         sG+P+/QEs9vv4T4e47WdMTalC4ldlQ7Tb0LEuvuHLNHdVFn7l+6zqsmiuCOu/KV8sK64
         SyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760055214; x=1760660014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyDC1ie8B3oILTcCsslcBAnJjiWRWRVBnLrrDbtN9tI=;
        b=w5ZFehbY9vji3g7n/RG24s1WJBn0FLmzZVPwzNrEt1p+YsJZ/BUP37Yv1hh4faXU5g
         uOna4I56I02IeYFM5mQCY8s9qVJxUI/5gMH71lUBCx7jedL2DC9SRwQqtPwSMaWc/GFO
         ZglraH8smK/cX1UWsW17F3GNSXWKLGChh9UDVI0l6M7xNx8CRHw5ztZBiDIGxyvmrjX0
         3rlL2XKELBq+oIeX4gGLB5POxpoxpXV+nnekz31hPUxXoqm2SqY63iwAdad3eF+Gl0z9
         TEdNXp1Ky5OeXdT4SPywqngPwhgDxvKGsClXezJHVRonU29/QOAq+JwrEpQeAvZ/vrRG
         vutw==
X-Forwarded-Encrypted: i=1; AJvYcCW9DGsiLZjsjZs1xx8UZvpi9IG7luDunfEEnxQNwN7xut7u+iDtFpHET8eOXBsf7zZNRq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ze5ZaZdiGG56FMiG/s++LaVgLNhapGUHdBZYK9Qn5ooo4X/4
	jC8YbcoimSQHEW4ZoJQ8iwYfTiRmyBTioafrFriCOx9J6d56Jvch9K/d7P10UXPpZKqOVUoFeeR
	7y/eOMCBjxbyIFjwdMtq2LJ0xX5iSElA=
X-Gm-Gg: ASbGncv4UWPSXdq0rHb4OlkOAu1nL6HCm/njiq7u+nDSZ4Iv24s/0JY7n4u1R2Sg6j3
	UJO4DQKzed1FNtOTZPUHgJp+iifktETYZ58dViocTaBfpIKPEuajwqEEpE5XeGCQAXiG8PlaU81
	p2eV9wW/HuUexSac8lXtW4tdM6qOSVUcKm2kljZIMtJB/5qg8TtYfsp4nuj3EmLbTPv6aEPPeJ8
	vBcdgyG4Nepr8LWlOIpC/o1ZIB74q1jmrOD42MxsR26pmvBYyH92y01mUUN42mEAiB+fWiu44/K
	2gY=
X-Google-Smtp-Source: AGHT+IFLGyVHh9ycQ3n0GrpgiKUTJKnzQxIiaVEjhhDSddOFubSUfAFcPRihHK5d2wkMl+KT64uVI0zVMrRJ+0e9OLE=
X-Received: by 2002:a17:907:3d91:b0:b42:f7df:a2ec with SMTP id
 a640c23a62f3a-b50aa391ec3mr995218966b.9.1760055213992; Thu, 09 Oct 2025
 17:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
 <20251009215737.1196464-1-okhuomonajayi54@gmail.com> <6n5vp3vkmk6gota27baejwu2mkuqppy65efsiimvjqnhjjqecz@uud5yaetl5l2>
In-Reply-To: <6n5vp3vkmk6gota27baejwu2mkuqppy65efsiimvjqnhjjqecz@uud5yaetl5l2>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Fri, 10 Oct 2025 01:13:21 +0100
X-Gm-Features: AS18NWBoXWSelEUMTPYS6zjCSyJEffDgaeADCTuKloojE4I7ZpRMqacNJ9cU6_o
Message-ID: <CAFpMFfAvSrm=LGdCkuui2aZoZW5+cq=8Hk1pug=1GB=ZRreuiQ@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
To: Agatha Isabelle <code@agatha.dev>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Agatha

On Fri, Oct 10, 2025 at 12:49=E2=80=AFAM Agatha Isabelle <code@agatha.dev> =
wrote:
>
> Hello!
>
> Nice patch!
>
> One detail I would add, though, I think the correct way to submit a v2
> patch is to prefix it with the `[PATCH v2]` prefix.
>
> See:
> https://git-scm.com/docs/SubmittingPatches
> https://git-scm.com/docs/MyFirstContribution
>
> On Thu, Oct 09, 2025 at 10:57:20PM +0100, Okhuomon Ajayi wrote:
> > Fix const correctness warning in patch_id_neq() in patch-ids.c.
> >
>
> Before the changes, I think there must be the `Signed-off-by:` line.
>
> > Changes in v2:
> > - Removed NEEDSWORK comment
>
> And this part of the message, the changelog, I think it's supposed to be
> in the email message but not as part of the commit log.
>
> > ---
> >  patch-ids.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/patch-ids.c b/patch-ids.c
> > index a5683b462c..b6b808332f 100644
> > --- a/patch-ids.c
> > +++ b/patch-ids.c
> > @@ -41,8 +41,8 @@ static int patch_id_neq(const void *cmpfn_data,
> >                       const struct hashmap_entry *entry_or_key,
> >                       const void *keydata UNUSED)
> >  {
> > -     /* NEEDSWORK: const correctness? */
> > -     struct diff_options *opt =3D (void *)cmpfn_data;
> > +
> > +     const struct diff_options *opt =3D (void *)cmpfn_data;
> >       struct patch_id *a, *b;
> >
> >       a =3D container_of(eptr, struct patch_id, ent);
> > --
> > 2.43.0
> >
>
> I hope it was helpful.
>
> Best,
> =C3=81gatha Isabelle
