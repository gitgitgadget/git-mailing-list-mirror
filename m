Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B0443AA9
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319429; cv=pass; b=lEzWLFLcCoitu5/+jXsar2MSivlxF4LKYpfILeG+bprs1XzDHmT/i9KmigNKKqjyZIgbwhxv7U1V++tDWNbSIB3lPP/WmRpk65/Gk/Huerl0ObfukLWfc8BAz9ccRf5hHOeNn5TCFcZtFO3ZuJ0Qnmo0theaLoYjAY64oGqN29A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319429; c=relaxed/simple;
	bh=ow9dRM1MREAlI9rrvVlP+1aYmoytl/DD40dnleJL8Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzjSB4GXGZdmvgAEWefTHeHjB+W+dve68bejkyOmJMUkKGWPbku8vhsjGYhDtqS49vSDaTEBfvjJRCKgz79HHtD4Wo5KmkIjePVlvblVRur+qyL4bBnVrQd58xVvGObPMs4zjwIHML6zqwkMRPfY0TRwyDBBU/Y46yX/PFm+tlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=source.dev; spf=pass smtp.mailfrom=source.dev; dkim=pass (2048-bit key) header.d=source-dev.20251104.gappssmtp.com header.i=@source-dev.20251104.gappssmtp.com header.b=rZLXvToA; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=source.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=source.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=source-dev.20251104.gappssmtp.com header.i=@source-dev.20251104.gappssmtp.com header.b="rZLXvToA"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66854eebf60so36638d50.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 03:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785319427; cv=none;
        d=google.com; s=arc-20260327;
        b=H3f1eL6HjeEIB//6RxN1ZpXKloNbRCuue+FLbC9m5F/UFoQptBZzIWvLgDpuyvV0Zf
         1SyzRv/KajT9w+beez3u/jBXdozeN6hFhXT7ysqNj/XIKLdp893SUFCIn/d143bo/5/v
         DvJZtx/ZqJeaBP80Czp8lGZ/2O4vriEDT6SlJcgj2UCBoZRHO1mcFPNWAT8Q/EHPbs+z
         WyqKobfbQOk7km09QMOLTcFJOs7j4MNWZ6YvSKmNzdZ4aO82nH6L4O6vxjyEFSjqpiQW
         drmpSfhpY/er7rbk/CuuMrRoAS+5vRRUZPT2i080jn3axR5YNTO8lNy9D1muGcgz2t9Z
         hW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8ksRIFKNms4qM0BTh9KUYq/fYx7FjuyVS8y9/B2hv3Q=;
        fh=1T7A0knhF3NoyC/gy/gtHBVIPmh8UUtkm3PMSb2CMpA=;
        b=k5TMqw9e+KgSVIi/hCSW+tCclbZOd73g/OykJj/RrzT9IGOzHfQb4C6Ho/koND053f
         IuRHAFlzsUc7cv6JK+5F90Fg3s0yDjuSuP7e5/aLZ0U2q8OEt11sIsSnI9yJYsSR3Phe
         AKj7CAIwsAR25hbcLlBFCNrMqQev1MNG6a2YqYNBjbRWaiXLjWx1x+rLovkxd/mzC3dO
         sdaH7HVS093gin3SsiGeh+aJqL+cH6byTI5q2auG6h/Sx54hpIgxVMuym8fhd0LrXieh
         1wiugQtjbOdDygzR/1Qy5L1m5SrmtMcfgboAoTOHilpMudFO3Tm5of60Li111euu4604
         Y2Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=source-dev.20251104.gappssmtp.com; s=20251104; t=1785319427; x=1785924227; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ksRIFKNms4qM0BTh9KUYq/fYx7FjuyVS8y9/B2hv3Q=;
        b=rZLXvToAQ01AVqCu3uQC2Xuy5OClZpq7aIufoSUnHH+cPRCoFbbf/INAAzd+/XlOCA
         aB/CFgb6KZz6IzUfuGJ1KxPhWWk5D8JGb+yo0DsgD2Q1jsljszpggDUELet2GMuTc70H
         BBBWZtCnjFOlUnJOFfczWyYMEj4wevSqNjoYz1TyIAVKbctciiW+kdfFUUmMg032PjtU
         WgPrW0h+ZuaRvLJgdvPMzvZTBhS+KdmUNCLxjp0vyi5Oyc9BU5c8DMJSM/x3UaZyC55r
         vtjlXVnQP3o9/TOne6MGlfg3xSDwN1/cZ1gVnvH3+NOmt4gxxJmv+Fzh164cxuaoPu9F
         ZY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319427; x=1785924227;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ksRIFKNms4qM0BTh9KUYq/fYx7FjuyVS8y9/B2hv3Q=;
        b=QScFyyUNS6JjzAzG0+YGRGs3H13KIanpiLtH/bv5nd7I4fYiuxv0jUg7nPuQhP3JTm
         BAsduuGCXl+fTKGih6XHLDi5DWTL/ttPP1nF2n07FfwGXzJPLsE+es6zvL2vZk/ysl6F
         VPaSfqA1zuEYR9cE5kyjwTegLLex+IgBZJL2k8rEgW7NHmBNXeqIiAPfQzgZgk04njCy
         qKDIOXZxZ4nlgLQjzVgHo6VOOEeu1zVoGbqvTMgqzZc20q5AqbaNtBUkVe5xBCMmtchP
         8UxkiEVKJKGAORPf0aFP8KEUrPjGCPfl79pSXIpxRnKQ9GwJQCT3b7CLjASzcUYJNoJ+
         B75A==
X-Forwarded-Encrypted: i=1; AHgh+RqMQ+QK8vTiC5RlTFBxARBHf9re3uN2cX7sPQKcQI+7QMUenSDar2ZwVwo5/uPAHbWxOyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKz9ZrRTKdOpHfRz7p5x1GtdoYnbQHXZYcS/t1VH13XnJSJhvj
	nobXaAEsYNT/5NSgMPE+9A8AtdmMbNGKIIjS9ldu/RrNIjMzXyLZiRy5eEm1wFaDJB6B1AvRpW+
	lIteiq1WAO3ognSKwsssfbbOgx5Xcp1WVNamIQlt0IA==
X-Gm-Gg: AR+sD12HMx0FWzy+KUqx5kXmPyzVsTk5Uue16K3pQQQrP4/n0N3bqWaFDiyZ6wC3Wk3
	JqUFyRuW8mBkOyO6C2hsqCx/MTDOXYCFCjZWCL2Pq33LjNt5U3U4sxsB6IHwmOXIEC1DbGkRr6B
	w8CHdr1JdwJfhBjWuFHfmaYKo6Def2cpg/VwFkwVSThxHQB0gmarf3Eh6KXuSpJ1L5h1WXx0swW
	rVLHUwV8821TnP/HqGA1paIVCFspaJeXK3naOcOD7UgmETBSwZEDNM+wE5emXV16aadQ1rBlZlk
	f0tthCVX5tGfVZfpWuDEVgRi+6ChhKsO2Y8fEkH35QeJSw==
X-Received: by 2002:a05:690e:b8b:b0:668:e1:629c with SMTP id
 956f58d0204a3-669057c84e6mr2715501d50.4.1785319426620; Wed, 29 Jul 2026
 03:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
 <20260727095735.GA1153453@coredump.intra.peff.net> <DK9MX0YJ07S0.1TOBLIA6ZNSEN@gmail.com>
 <CAFZW3h3xyeJJwHfVK2mB2k1=e-0he9_gbTetJ1RdB2uUM1rp4A@mail.gmail.com>
 <20260728150031.GA41931@coredump.intra.peff.net> <xmqqjyqfdnie.fsf@gitster.g>
In-Reply-To: <xmqqjyqfdnie.fsf@gitster.g>
From: Alan Stokes <alan@source.dev>
Date: Wed, 29 Jul 2026 11:03:34 +0100
X-Gm-Features: AUfX_mw2lqSb0CVwJ1sOlWe5538jLS5sX8S2CQ9LdIdCBphzrI-GzQ1RA793qxQ
Message-ID: <CAFZW3h2hVMaVy12uO_5k5cwN=N9LDhrxuVSQPNmPWxB4j+kRwQ@mail.gmail.com>
Subject: Re: [PATCH] cat-file: handle content request for --batch-command
 without type
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 18:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > We can fix it by tweaking the object_info on the fly as we receive each
> > command. But we should be careful to restore it afterwards; otherwise a
> > sequence of commands like:
> >
> >   contents $one
> >   info $two
> >   info $three
> >
> > will pay the type-lookup price for $two and $three when it does not need
> > to. This wouldn't be incorrect, but just slightly inefficient (and hence
> > there are no tests for that part, because the externally-visible
> > behavior is the same).
>
> Woooo, tricky.  I love this kind of attention to details.
>
> The patch text obviously is correct.
>
> Will queue and mark the topic for 'next'.  Thanks.

Thanks, Peff and Pablo. Sorry I wasn't able to contribute this time.

(Peff: for some reason I'm not receiving emails from you, although
I've got the other ones on this thread. I'm assuming that's due to
some over-zealous filter at my end.)

Best wishes,

Alan
