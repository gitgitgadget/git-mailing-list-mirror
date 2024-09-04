Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9D6E619
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473450; cv=none; b=OzA+EeihrUGgJ0hump37LtW96oYHoMXVGiBbr5QUwkeUl8o17Q3fwomUcXVkA4Irv8b6xjkHirRsrTOl8Au/A3lJ0M/g2fOUTpW1WnEJoWJ7R6+NA86fRbmtn79hhLJ0bSDkld+snB9Xvzo49G5IvzhxUrnm8bHoWqBiFq5FbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473450; c=relaxed/simple;
	bh=02DxaEMEsFn6lf8hY73f/wtaM57UBGN2fOy4fFKFLMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTRvvnbilanR+ezPkxE9rWShRAFCcf9Nnwx1hWNRidi8PwFAyTqcZ2hHuXUVo3d5AIoC9ek5XEpiRXBt3fcmQwqlmqAUW5GnHTjTirF/to6+4/+in0O3r3OL0ltbbJSbFq9koDsyGaSY1uWcareoH4LTABwzBkbPOxXVf/uZzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VczQgSyy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VczQgSyy"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd835872ceso4819105a12.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725473448; x=1726078248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZSyW0Kx53jO94nUIW5jnst5WniS5lQOS1EGrjfyvqU=;
        b=VczQgSyyNUTOgDhVZzM7NHvyihRKGgkesVVr7NVsFsQwsvY9xdYbVim3Yv0x0fQdjK
         LIzCT8OdNAptA4PFhvbwR86W9fidVFpWfpfZOuz6tFztOYsKbwh54Jks0ZXgJQF+EiH5
         LkvYBfril5I02cUVs3Uukh8oFCd+ClRBAOWYgyfUGt4acLFrZsDY93eYfJPy63Bnyi+H
         h8zQEcbfbzFHCisq27rOoetAJm9TDwvG56smSLHte8ppiL330ryZzwIfk8NCeMDomwvS
         5wIcqOlZ/BnxmNFy96B7CT1ZFL76oJnK1efQkxdru1MRoZuFyA3HbppsrpeL+iNS5T0+
         yFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725473448; x=1726078248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZSyW0Kx53jO94nUIW5jnst5WniS5lQOS1EGrjfyvqU=;
        b=rOqrjfwzBtSQR0+TjlQfEzJN3uqHAwzighfLLVhQ6kIdi67gq3IS1fT0Ai0bn092oN
         jJjuzos8/upS070eHpGSllMZjNq32zT1zqDc9yIx6aI+Y1w/c/XWzCQgNtchp9M25uB0
         G0uDAxwVaof43bVekaFnd/kTUwxTanyLikmrWteBxRDvdXCkLcdeE1HMVeObNRQuGjLD
         mhebmZU0enfFrfoV+MVu7k303VFJNwoNCCFCTgnAn+wg6zQb3Yz0aBlP/PozSSiLkqr2
         uygScSTf77whXYp0HSNfrSmY3h+VcokPRbMTmzGkb3P1qstZvC4x/k5PlBxZz2aus9eG
         IhAg==
X-Gm-Message-State: AOJu0YxY/GX9+4GFT8pGph9m/NbmGq+262WxR4h+/yXZOyxuir+4aA+H
	b8KAv01MTL1o1VVwOlR0IBC/rlv5f0Kmudgbb7ich2HxZlbC56YpD78G3iQaLMfLpCCo+LX8i1h
	6gOOCcyJsbWwGLfn0r/qgPe2EHDAZSC+cl3g=
X-Google-Smtp-Source: AGHT+IG1qZgkpb2vodA/5PpNGnVBLtq7C0O/JNbCK6hyVb+fu22TdwR6OLb++n8ScQMabmW3ug76bj0L6+yZ8+TNZO8=
X-Received: by 2002:a17:90a:f192:b0:2d3:c976:dd80 with SMTP id
 98e67ed59e1d1-2d89467ed73mr15003164a91.39.1725473447776; Wed, 04 Sep 2024
 11:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
 <Zs8KzG0vzCEDvkvx@tanuki> <xmqq4j7438yc.fsf@gitster.g> <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
 <ZtacHCuql0pX3V2u@tanuki> <xmqq5xrcn2k1.fsf@gitster.g> <CAG=Um+3QtRkNcSq68iOWW=HWJytDReaikAfjX6MrgOY5n56gFg@mail.gmail.com>
In-Reply-To: <CAG=Um+3QtRkNcSq68iOWW=HWJytDReaikAfjX6MrgOY5n56gFg@mail.gmail.com>
From: Shubham Kanodia <shubhamsizzles@gmail.com>
Date: Wed, 4 Sep 2024 23:40:11 +0530
Message-ID: <CAG=Um+0EBDREtFxW8Fd3ktQ-ZtwAmhuiur1Y-J_BtW7u3HhM-A@mail.gmail.com>
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes to fetch
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:59=E2=80=AFPM Shubham Kanodia <shubhamsizzles@gmai=
l.com> wrote:
>
> On Tue, Sep 3, 2024 at 9:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > The prefetch refspec would be rewritten by git-maintenance(1) such th=
at
> > > the destination part (the right-hand side of the refspec) is prefixed
> > > with `refs/prefetch/`, same as the fetch refspec would be changed in
> > > this way.
> > >
> > > An alternative would be to _not_ rewrite the prefetch refspec at all =
and
> > > thus allow the user to prefetch into arbitrary hierarchies. But I'm a
> > > bit worried that this might cause users to misconfigure prefetches by
> > > accident, causing it to overwrite their usual set of refs.
> >
> > I agree that it is the right place to configure this as attributes
> > to remotes.  It would make it handy if we could give a catch-all
> > configuration, though.  For example:
> >
> >  [remote "origin"]
> >         prefetch =3D true
> >         prefetchref =3D refs/heads/* refs/tags/*
> >  [remote "*"]
> >         prefetch =3D false
> >
> > may toggle prefetch off for all remotes, except that the tags and
> > the local branches of the remote "origin" are prefetched.  Instead
> > of a multi-value configuration variable (like remote.*.fetch) where
> > we need to worry about clearing convention, we can use a regular
> > "last one wins" variable that is whitespace separated patterns, as
> > such a pattern can never have a whitespace in it.
> >
> > As you too agree with the position to consider "prefetch" should be
> > invisible to the end-users, we should not allow users to specify the
> > full refspec at all, or if it is forced or not with "+" prefix.
> > Only accept a set of patterns to match, and keep it opaque where in
> > the local refs/* hierarchy they are stored.  It is an implementation
> > detail that the users should not have to know about and rely on.
> >
> > Thanks.
>
> Right so I have good direction to start working on this. I'm going to
> tackle this in a few parts since this is my first contribution =E2=80=94
>
> 1. adding a boolean `prefetch` attribute to `remote` =E2=80=94 allows con=
trol
> over remotes that prefetch
> 2. adding `prefetchref` =E2=80=94 allows control over refs per remote.
> 3. Check if adding a ` [remote "*"]` catchall is a possibility
>
> For the boolean `prefetch` value the =E2=80=94
> 1. The default would be assumed to be `true`
> 2. No changes in behavior to any variation of  `git fetch --prefetch`
> command itself.
> If no remote is supplied to `git fetch` then it means default remote,
> or if `--all` is used, it means all remotes and `--prefetch` for both
> always
> prefetches irrespective of the config value.
>
> If I understand the codebase well, the changes would primarily affect
> `remote.c` and `gc.c`.
>
> Also much thanks for the feedback both of you've given thus far.

I've published my first patch using gitgitgadget. I'm still figuring
out what the best way to link to that is but
I'll add both for now:

https://lore.kernel.org/git/pull.1779.git.1725472799637.gitgitgadget@gmail.=
com/T/#u
https://github.com/gitgitgadget/git/pull/1779

--=20
Regards,
Shubham Kanodia
