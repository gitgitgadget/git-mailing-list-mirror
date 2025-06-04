Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B403D76
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749080908; cv=none; b=Mvzipl59FVLf1TpG3kPyj4cbfTlFAsE8PVeNL8PQSnIFefdcO9dKHHsnGgWBlmG/rDgAFlMOZvv4ObInv6e4czSLTJZ8S8v3K2P8MjDpp/zeJVAqquSdvouB6N+61jdt7lclpL1WVSt0ItdN+SkitKHBH/jTpMSOT6WeO2o16Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749080908; c=relaxed/simple;
	bh=nclmDNDPgjjVN1wU9sZ3w7tppnbVDObRgI7eeq6nFeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiXFmS2qL0RgIdsK8+Fj8eJAClm50Z5hj8gBtLpYeroV8YZ1HuvgRm3UZVKOuG1optntbYrEkcETw6wM04PU7JGC/9ftEiEBVIsRhipHKZ7PAWLqf0T3a21VH7Lj3B4gKjMuoJIx5dTF1qK2IIPqfBtRxVPWK2RxzWLaQNlfbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT0s6/dj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT0s6/dj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235d6de331fso4578825ad.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 16:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749080907; x=1749685707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql5fcrL9tihuvqMX4Wfu548T2OAoxKz/DWhg3zmxMmA=;
        b=dT0s6/djqSk3tiOOGYppYoZKlec5LWwelo4WxctwhDaX/RRVaKWs3BYreCWqZyoOcp
         xJUp5EYkR4mDn89LchE17Yg7YL27Qip0dgSQOwFkLidmEOcZHgrhI5K4Q+OkLXPp5y1E
         9suu1T6yVFKeffrPyM2BqanRxAgeQod7Ni3n+laWkN4VzCxABkv0cwrYzIWpA0OvTgLS
         HvE2InVH+W8kskl0R1mdEF9jR9vG5fIWjjOp599C9bIOWRzhfq8DHg3xAmDOtWqFo1nj
         NmTz4cbEYqjOx/DlS/aGNSLGo5MAkvmz1qFq73Z2ioafgwi6yBzCX43sa3JrvUTUY0Gz
         o5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749080907; x=1749685707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql5fcrL9tihuvqMX4Wfu548T2OAoxKz/DWhg3zmxMmA=;
        b=KwZXp7kuFIA+d6804E8oJNsH3Sy9FvSfL0BFOa6BLks+xhBT4HemiwRtx0OiecrlVu
         Mc/nwzHODkuGjm/HhqrHOhJtMD1Uu5Zc/Tyj444PbS43DH/zwGYXCquSEjQhHyXzLUEW
         auzXOkmx1VvoF1Ih3AuS5cI3vLZJYP1ogeWU0AFSv4oknM1XHDpAnP/BNcoDy81quizl
         xJ/sdB02d66cuU6fcP/naqWeLx+LcDMlEt3CcRK9bidexYJoOm4S/P6jRhBcJATA8NkA
         hixYOANzCXf7Q4XZP1MjjZYDhEz9zvWkBnrxFThtjTT/I1JZcass4oZK/G2qQNQdp7xt
         U7ww==
X-Forwarded-Encrypted: i=1; AJvYcCUzB8jsI/es8OS/eEbCQKk6w/Cvu0vOVkC4ysyNfKmRTH0MDJPvNhTm3CFCpWCxsSxWKxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTmBm/YqgBNfa1pSo5K3it5Kjudce54nuPZaTI3wnhoXQaSAw
	p5oTLqx+0GCP+cI5RelRJ/773wNhOGntWuoeF5iKLqmx8td14LggFyx+ZnCtEaPd7o+VGhwdsT6
	NI2Jq/fNZ/B6nORkSyrFFhh0MbTKdM6E=
X-Gm-Gg: ASbGnctJfTj1SUlzguGQ6Tfm/F8p01HEyzgtKNXdqFIaZXdGBwx8dkKGGsuUwnPrDpf
	YxnW2dnoW8wKrVhA4zQcynvnb8WhY7B94EiVqd/J7hqlSZjjXDVlUtRhiwHKQDQ187GAxtu6LZP
	EjYWWp830GPZ4Z7G2KGteEW0sbgnXUILMPgW2is7yccvUdIGef+AZmyDjA7uNwm7k8fJs=
X-Google-Smtp-Source: AGHT+IH1Bfhwyiah+n77W2GBKUOGms89fqJrD99iPg+Cpt7h7FKxl0RN3/FqtM5+IzRISdKJPVPxwu9ib91BMK6R1M8=
X-Received: by 2002:a17:903:3bac:b0:235:eb8b:9968 with SMTP id
 d9443c01a7336-235eb8b99d2mr37328495ad.36.1749080906573; Wed, 04 Jun 2025
 16:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE7as+Y0hzkPUC-q7dd-eSJVi0H_nwzQL1AGZJnKMyYcrX1dLw@mail.gmail.com>
 <4F074544-4E25-472D-A42C-C50A1E1CAC69@gmail.com>
In-Reply-To: <4F074544-4E25-472D-A42C-C50A1E1CAC69@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Thu, 5 Jun 2025 05:18:15 +0530
X-Gm-Features: AX0GCFuTqJrP5gbDNl_N0nSmds7-seNLdHrqcP_UFjMQvG5C29PmOow_ZV3BSfY
Message-ID: <CAE7as+bH5nDTPqQkE6ZFzTrQ7+CZndsni9Zy6tzuTbq5BZSFYA@mail.gmail.com>
Subject: Re: [GSOC PATCH] environment: move access to "core.sparsecheckout"
 into repo_settings
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, christian.couder@gmail.com, 
	shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 7:50=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> wr=
ote:
>
>
> > Le 3 juin 2025 =C3=A0 12:21, Ayush Chandekar <ayu.chandekar@gmail.com> =
a =C3=A9crit :
> >
> > =EF=BB=BF
> >> The config is called "core.sparseCheckout", so why is the variable
> >> called `core_apply_sparse_checkout`? `core_sparse_checkout` I would've
> >> understood, but where does "apply" come from? Also, for brevity I thin=
k
> >> we could just call it `settings.sparse_checkout`.
> > Yes, I had this thought as well that adding "apply" doesn't make a lot =
of sense.
> > But I thought since the global variable has this name for a long time, =
there
> > must have been some reason. I can change the name if the "apply" doesn'=
t hold
> > any value.
>
> Perhaps "git log -S core_apply_sparse_checkout config.c" or similar will =
reveal a reason? Or point us at a patch series that has some discussion?
>
I ran the command to see previous commits and also went through the
patch that introduced that variable, but there was no reasoning for
why it was named that way.
There was no comment as well for the patch that introduced it. I think
we can also get rid of the "core" (so it just becomes
"sparse_checkout") as there exist other core settings which don't have
"core" in their variable names and since we are changing the name
anyways.

> >
> >>> +{
> >>> +     return repo->settings.core_apply_sparse_checkout;
> >>> +}
> >>> +
> >>> +void repo_settings_set_apply_sparse_checkout(struct repository *repo=
, int value)
> >>> +{
> >>> +     repo->settings.core_apply_sparse_checkout =3D value;
> >>> +}
> >> Getters and setters only really help in the case where they actually
> >> provide a benefit. These don't though, so it's dubious whether we shou=
ld
> >> have them.
>
> My thoughts exactly; see below.
>
> >> Also, shouldn't these functions call `prepare_repo_settings()`?
> >> Otherwise we cannot guarantee that those settings have already been
> >> parsed at all. And for the setter it could happen that the settings ge=
t
> >> overwritten by the next caller of `prepare_repo_settings()`.
> >
> > Oh, yeah, you're right. So, if we use `prepare_repo_settings()` in
> > them, wouldn't
> > it be better to use getter and setter functions? Otherwise, I'd have to=
 call
> > `prepare_repo_settings()` everywhere I'm using the setting.
>
> Aren=E2=80=99t most of the consumers builtins? And from a recent look, do=
n=E2=80=99t they (all?) initialize the repo settings? I agree it is relativ=
ely painful to require developers to make sure that prepare_repo_settings h=
as been called on each (new) code path that reads this variable, but OTOH I=
 would expect that to be a straightforward audit during this change and the=
n (see following) relatively easy to catch going forward. Is already a code=
 convention that reading things in repo->settings depends on having prepare=
d them?

Yeah, as Patrick said, we have to call the `prepare_repo_settings()`
before we access these settings.
So, either we manually call the function or use it inside a
getter/setter function.

Thanks
