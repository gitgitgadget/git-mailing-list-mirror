Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54471DB123
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927794; cv=none; b=rFkBkQVOj/2qtWXKNVQpblrEyU7i5HGmO9lN1zXJHiZVl42FMkJYOIoZUL/L+fgIV/pYnk2/Tbm9T0uIltJhbBdBRDcicYfg7dwFrQnvBDL9EepVH+QjpqiyTSAANPLvbr9xuU3BywTcZ+YgOBBr74X3VLFljYYTwCVKb81IlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927794; c=relaxed/simple;
	bh=F3qszXnlXUsAXMZi/2v9j0Q8DXFOjoV1J2J6HSLZinQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS1uS8CJ0g2i1oTvdzGX+nPeOqhu+bDJYv1DGeM4oR3y2NKMpQSUvlrlhs55VusVfJwnmN/dHOyux2bT9NwYx2L3+QT4enxM3HNJ7OestAtPEaXhoXDJREDhp8c2PhBbhFOMaKwEos7MPAZ/ohmIgUL4b9tHX0EqL0E9xbOtOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvtPjHSK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvtPjHSK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso8136615a12.0
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 23:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736927791; x=1737532591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KluS3tu2mNng1HVP6BP86W5+87kQUhEdqpgB5rxu0hY=;
        b=WvtPjHSKAZFiWcPtQOgIAdJgeX+DthS7FHTCZbGqaIY2AMKuAZ/lfFBQZUegqZQ8WW
         FaVqrP7n6xFL6DFjn8iarFNB65Y88AXtdM11gC6LC3NIdumI9I8xbc7vwuI+tjcE7MMW
         KvgrbDiw8NdDe1NSW5aUn+JasJ7HzQ5IwY9F+sEWm5DHrAneJGGNkUbtXu6B2T8Xma+L
         fZ1PU4f8TSeTVMk3ZyOzYoXakhKG68NEgjWMqOYg8c7tXwV1K7L064Ea4zO4tLDMCcqU
         GsR0pedd/dXJoie6Ud0ZJfDvgezYn0lzK2//KNKbAeQ0IiN3XCSG8smfGgii092RbZOD
         LdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736927791; x=1737532591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KluS3tu2mNng1HVP6BP86W5+87kQUhEdqpgB5rxu0hY=;
        b=ljH/AzLmGIiGjCv0lKwsXjSLkNAqewDbeOeiQhm3rNQa9ZFR6W0zM+0pkoOEbwCDKY
         w37MoMhuzH2Yn/5P8ikIMHDK9MkbHTxs23enolpZGl8N/6Xi5e9VxiTn7tFs1iiM13sR
         3cVMHhVK/PVX3vR+E517L68HqsvEuoNKnoV2XJFTgRC3LvpEl7st7LVuUuLx+uzMLRL6
         RbYNiyqQJ34tUhDmKeNB34HBRA14hLCBMjskP5mxb4ZbKGSsC+UvdKlgELkgkL+6oNDF
         rlfFgM+siklSW/5Co4C04J3+SrkOK+c/Qlnptr60PHv/ycthO5qBAIb5mE2IwxqqRAZ2
         NP2A==
X-Forwarded-Encrypted: i=1; AJvYcCUsrXBHBG+jxCSG18NjrxDY6lx2s4p8VF9i0oBSYR8+/jpY++Y0+EYGrjYrzN8lmIohiAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfYqCYfWo9lljseGkBvY0WDoRf4cbgy0xqRYTztUI/Ku+dh1W
	i1tguAF5Gr1QxjdOstgF7txqQtzIYI9Pbq+6154LLbwJQVcoklxryGWKZkSid5OU2PttH0nQHGL
	2OHMpLapIJ8Mp+HsPhvGiKCA+rLk=
X-Gm-Gg: ASbGnctNCe39PvsQb8AOLTMbMi1/XXYz7giTFgA3jhf6GZHntptZhtVFNsom+5WVrJ/
	IdFw6woCdi9ttAzRmMewd08BkTCkyn6KFg8pgfw==
X-Google-Smtp-Source: AGHT+IHW7esOc152jsw4ou8mWl9fHLDa4oapGVUR7wI0ouWg0ziCdUdopMnjj55SnKrf+zKIS50LHhOrbi7KBKWj2o0=
X-Received: by 2002:a05:6402:2347:b0:5d2:729f:995f with SMTP id
 4fb4d7f45d1cf-5d972e6f957mr25159970a12.29.1736927790630; Tue, 14 Jan 2025
 23:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
 <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com> <579757957d21faaa8dd9228a191d82f663e93c03.1735611513.git.gitgitgadget@gmail.com>
 <20250113091750.GA794747@coredump.intra.peff.net>
In-Reply-To: <20250113091750.GA794747@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Wed, 15 Jan 2025 15:56:18 +0800
X-Gm-Features: AbW1kvaMINsxBWqIr8NLgxDELt5ySKLJFxsVi3mQDtOBSxfhNwnFqoX3qyuXfdM
Message-ID: <CAOLTT8TaDBtpgXRAj9yjiJB-h8vGjd6bEg29gOiOUwvQXbzZ3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fix(gc): make --prune=now compatible with --expire-to
To: Jeff King <peff@peff.net>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> =E4=BA=8E2025=E5=B9=B41=E6=9C=8813=E6=97=A5=E5=91=
=A8=E4=B8=80 17:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 31, 2024 at 02:18:33AM +0000, ZheNing Hu via GitGitGadget wro=
te:
>
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index 77904694c9f..8656e1caff0 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -433,7 +433,8 @@ static int keep_one_pack(struct string_list_item *i=
tem, void *data UNUSED)
> >  static void add_repack_all_option(struct gc_config *cfg,
> >                                 struct string_list *keep_pack)
> >  {
> > -     if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
> > +     if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
> > +             && !(cfg->cruft_packs && cfg->repack_expire_to))
> >               strvec_push(&repack, "-a");
>
> I expected to see a mention of repack_expire_to here, but not
> cfg->cruft_packs. These two are AND-ed together so we are only disabling
> "repack -a" when both options ("--expire-to" and "--cruft") are passed.
> Can we --expire-to without cruft? I.e., what should happen with:
>
>   git gc --expire-to=3Dsome-path --prune=3Dnow --no-cruft
>
> Looking at the underlying git-repack, it seems that we only respect
> --expire-to at all when used with "--cruft", and don't otherwise
> consider it. Which is what the manpage says ("Only useful with --cruft
> -d").
>

Yes, this is the current state of git-repack. The --expire-to option can
only be used with --cruft, which is why I use cruft_packs && repack_expire_=
to
as a double safeguard.

When using --no-cruft, the option --expire-to becomes irrelevant.
So leaving `git gc --prune=3Dnow` as is at this point: passing -a as a
parameter to repack seems reasonable.

> But if we look at this proposed patch for example:
>
>   https://lore.kernel.org/git/48438876fb42a889110e100a6c42ca84e93aac49.17=
33011259.git.me@ttaylorr.com/
>
> then it is expanding how --expire-to is used during the pruning step.
> OTOH, I think the way your patch 1 is structured means that we'd always
> pass --expire-to to git-repack anyway, and I _think_ even with the patch
> linked above that "repack -a -d --expire-to=3Dwhatever" would do the righ=
t
> thing.
>

I've taken a look at the patch, and I believe Taylor's changes are primaril=
y
aimed at extending the --expire-to functionality within the --cruft feature=
,
rather than expecting --expire-to to be used on its own.

> In which case the problem really is the combination of cruft packs and
> expire-to. Just cruft packs by themselves do not need to override using
> "-a" for "--prune=3Dnow" because we know that any such cruft pack would b=
e
> empty.
>
> So I think this logic is correct. Taylor might have more thoughts,
> though (and ideas on whether he intends to revisit that earlier patch).
>
> I do think this change should probably be done as part of patch 1,
> rather than introducing a buggy state and then fixing it in patch 2.
>

Yes, I agree with that, and perhaps a single patch will suffice.

> -Peff

- ZheNing Hu
