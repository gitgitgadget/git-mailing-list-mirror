Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86429A2
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757219478; cv=none; b=HTIg7Sp3PSBcm0g605Ezs46X/WVIBDNvgFOGj/lKPBgbi6kBRXeirL5ee+FM6LGQCLzkbUZEhbhDlw/TEkJ5knSlYeu6Vp6M8aJ6/3o7Nbe0ZSjlBEZwZsQyy++3DgYMhrTs87HGnGcgb4nGTyetfz2zvIJKyGqcFIk5iQ7lFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757219478; c=relaxed/simple;
	bh=SEFGV0+QkxRhAP5K/zf0WOsAGtJVw6Oi5Ld/AfrGauo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGSRRW5jo3gqvCQ4X0DGNVJJ6G1/IzB7oYUhThKhU1C3iJHrXiw6fHB9RS8RPZGmdJiFLPsm74c/MUBT6rPQhrSCtApNW00HxAWOosW/W5ujzo8j/gd6sztaANt9KzhIweOopO7/KXSUh8ZtQJwgC0ITVAUR60giDDjGBK5olwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2kclLuq; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2kclLuq"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432ccadeaso331490639f.0
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 21:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757219474; x=1757824274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUgm3yfTZTaWOKh3E1BbIAZczleQULHSIyW/d6wV69U=;
        b=i2kclLuqUTYgI41JHLM/4Y/qEvlyWyEv9dtuPhYiPxStvd0VKSCHaiOJhpp1G2ptWr
         /P6UCtTx/5rmk+S9B+ncDk7sONvqu7dAQdZ8pGbwDHAt2JMKKXE8eTiZVSmrh8LIQL2S
         o1JdenVhrI03xAZWabUSLlQzK6AFDIWA5ANQ2gmFj1pwrnZr2AutmIzwgjUZQArS/KwX
         JjFAHTjrt9o6vQ2hVclJysYtt4zNJTWJ48LzuMxP/HyiaG0BvFd6ulNjIIztrniUKhy3
         Lq2eeagIm8OKBXTy14KcwUsVgXZ1u+wV/6M//1WAGSzmdxy5nLm5aE38lHeBV+fgJtYe
         0A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757219474; x=1757824274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUgm3yfTZTaWOKh3E1BbIAZczleQULHSIyW/d6wV69U=;
        b=wsD1zoJ37NRiK9OujZwTMztoIQQ7BrzFpQeikzMBcK6wsbxPOUUhaYJw/HYV2kB5lm
         usV6sObyR8ks8a7UfoRCZOC9LyI/S/IM3G7soPpv1nEBn9D4+3DqSXC/ExcPAInb7Jrs
         CUGWyrk/Yv0Boiuo0LqbfOHX0Pirl3KgHJIoZvzq7bKpXxBxIkqvJEokY+BikPfYETlm
         NQzq104zReyxvMMJAPVuDezOZ0q87lvifK/gx20H7p2kSRVuTPyAWuVxciwEyGtDprj1
         vozlQVQk25GeB+i8qwuyWzBQqBepyKSUi28DzPJfYl+IfzuohZRBmupf/qdWz9xhQUrG
         z11g==
X-Forwarded-Encrypted: i=1; AJvYcCVZQKRgbOKGSd2InZxC/LqC2L3lE4PjUJg358BC2rgI0sfu59EKBl8sfRwpvo6mVZxXkW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBEsInzwN+K104sneI30JAKtXYmdfBu0KbEoQkw6ER/3xgUbW
	xujSP85zr/FtDjjjdB+tFrjJ1FZzPGQ/fVm/mXpBOvaxIgBMfKIVZ2uGl/CJ9YEJgNvz2qHImqk
	4/PHYX++BrfSYhDOZO32SqqEaUn8J8og=
X-Gm-Gg: ASbGnctAhZxcxsMTD6iX+uyX/ctUgpA3kfS0y7U6xZGq5dDTFBgN83UJSdHm2917+6/
	fW6coCQgFpyXTqufcPBkt5F2t3AQWjOxYjIzvlDxvamgSUMcO1dxpCki5BL9DiJadCN+HJ6ZVwp
	TozovI4oGXyE37tuD0/iYnarblJXt7lsk/6T16nVNNc8/i1UuWbLtV/a3MLeFzIPPbLNG+zfAY3
	tY7i2/SgZKvnE89vaU=
X-Google-Smtp-Source: AGHT+IEM/hkkOttFbxW+ZUJxWg750ytGWZVKA6qM39N+gf95dHgjU+NozJjUTnsu5ZXUutvT8fU3JTZ+OTfuIKUZSA0=
X-Received: by 2002:a05:6e02:b49:b0:3f6:5fb9:71ee with SMTP id
 e9e14a558f8ab-3fd862649ecmr71460725ab.15.1757219473591; Sat, 06 Sep 2025
 21:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com> <aLrzqR2Z9jz5CuJu@pks.im>
In-Reply-To: <aLrzqR2Z9jz5CuJu@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 21:31:02 -0700
X-Gm-Features: Ac12FXxlZjCL61r9z498Rvcdcu4anR36O9lORiY8exMDaDC_PKbtxYa_lv_fF-k
Message-ID: <CABPp-BGpdEP9+CTApknmGNO=b=66bFKVzWL2s3gmgCMtTBTjPA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:29=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>

> > It looks like this version does include the necessary Makefile changes =
which
> > is great. I do think though, that for the test balloon to be valuable, =
we
> > need make building with rust the default with an error message that tel=
ls
> > people how to build without rust if that fails. Otherwise it is easy fo=
r
> > people building on platforms without rust support to miss that we're go=
ing
> > to be making it mandatory soon.
>
> I have a plan layed out in the BreakingChanges document that mentions
> how I'm proposing to do the transition:
>
>   1. We introduce it with auto-detection for Meson and default-disabled
>      for our Makefile in Git 2.52.
>
>   2. We enable Rust by default in case WITH_BREAKING_CHANGES is enabled
>      in Git 2.53.
>
>   3. We always enable Rust by default in Git 2.54.

I don't see how steps 1 & 2 help at all.  We now know we want to make
Rust mandatory eventually, and should provide distributors and
platforms as much notice as possible so they are aware.  But what
you've proposed is another libgit-rs or libgit-sys -- an optional
component that no one will know about unless they go looking for it.
I don't see how those two steps provide any incremental help to
anybody over what libgit-rs and libgit-sys have done.  From my point
of view, Rust should be enabled by default in Git 2.52, with a simple
knob provided to let distributors/platforms/users turn it off and
build without it.

>   4. We unconditionally enable Rust in Git 3.0.
>
> This is basically gradually tightening the screws, which both gives us
> time to build the infra and gives downstream time to become aware of the
> change and adapt.
>
> I think making it mandatory in Git 3.0 makes sense because I also
> propose to make the last version without mandatory Rust be an LTS
> version. And if we connect that with it being the last version before
> 3.0 I think that's an additional benefit, as there will be other
> breaking changes in 3.0.
>
> In the end it kind of hinges on when we think we want to release Git
> 3.0. If we can agree on the above plan, we could also think about making
> Git 2.55 become 3.0 instead. That'd be in a bit less than a year from
> now, which I think is a good timeframe for that breaking release. I
> personally don't see a reason to push it out into the future for way
> longer than that, and it would be good anyway if we built some consensus
> around its release date.

I see your plan, but I agree with Phillip that I don't see why it
makes sense to lump the Rust transition with the 3.0 transition.

Setting that aside for a moment, the idea of Git 2.55 becoming 3.0
seems like a good idea to me, assuming that doesn't rush brian on the
sha1/sha256 interop (since I think that's probably the paramount
feature of 3.0).
