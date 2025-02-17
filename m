Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9391A3148
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782647; cv=none; b=gTvnQXLUm9Gsyi9HNMV/H0+/UCFZzcaekJ0CVaMOAe+v8zDKl5dw8IUin62PvX6Vopw5Mpeg2SQoChzKCoMWmejewfYXSNP1BnJKOllaLrCFlX6n2XgH/vbUhmGX+CyGGf86V6ShhlZmoJCTtdAE0CLQppbH+eabiB3Dt6posbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782647; c=relaxed/simple;
	bh=1aGK67yy75Vspn8b644RxIemKrQyzeZpkheXt84bn/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGzDo0uPhsLgBNe88lMjp8ifkr7ykY/KzK6pIVx5MGYrz023oeveRgw5TVW6wU59C4HrAl+mhPDhHWFwVMMGPTAIxN91+LMoYihnrl9N6Y37KkJpUxH6tVM5ATn/LEeSGYIE9q1m1Ow7z2QV3Rjsdqzg3RxGa8NKf1a8FGE6mRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ8zCggu; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ8zCggu"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4be5ec1262eso128076137.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 00:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739782645; x=1740387445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geL+n+C7SZ6bjFrcHSng09AzsCtbFHYf///chV2uRjw=;
        b=aZ8zCgguleFGWEedt2XeE/PZoISZl/TFQ5p1WftoLGMpqrnMvUuuzriRNEyez3vMki
         P2MFKZ6DbArVJAofbejRLGT5iP4OmLOjN70NCaFHWyO94QZlxgSafBw+f/8EKNCEG4MK
         W812s9nMW1GRSKUtPYrzqA/X5Ti0DPRUY04CS2F1oIMSPU/gGrpIWciIfX2aTYdfzpVo
         Be/1U8o1YmTp6gBn52zTKJswkla5pJyzkA7Rask8nFfhazwBpMZ8gYjdaTzL2r4sWQOV
         +MeZUkqVctsoUH2tjyKdiJp9AM/KPKLIETBwxMaz6KNrqUC0OXCN4xdbWaISnnN5S1G4
         gvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782645; x=1740387445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geL+n+C7SZ6bjFrcHSng09AzsCtbFHYf///chV2uRjw=;
        b=ER2tOZvhgrlLIOKVjPnq0HNwa0rSYL2xCgHqBXGCnjf8lXbDKBhqh/Gl0BnjieZLyx
         U2H6KDsFtjW0TOkie4B9mWitwf1U63yDx8/pe9vDaA6r8SnoAumyqanspfCC12cl+luq
         DZbUIgt/QHXKvpoUdUCWwW5SDylrIKajSa65iEMi5XTYN14rSLLv+MUnL3vUbUQbxRkC
         R7b/KzLhpDkdr1l9RHGqdP3p8Lx2r1RtuRCuwZPZi7Q8lG/Fum1IFmhKjxSXUho3+dv3
         F4pVumuOlkeSM5TwVgNFCx8Y7XS4ebha1/TVsuOOjXg15aSKP0weKK0WDkunaAsAJl6n
         ZkjA==
X-Gm-Message-State: AOJu0Yweq1jEH+3JW76qL+lHLXvsxpTOXz6hoSSht5M+8ZtKJEkXVTsT
	eJYGvn88uC1XSN/go57WZ45k/rAK+1iHy7SQ9SInYUF8IqoFGO+vFRVUejSMQOM3SZmJEmNWZW6
	yYaDhgj2MbkcV5DdrrnuJGD5Cf6w=
X-Gm-Gg: ASbGncupgooP3rq2TUOfTVAUMRitLWCXzdw+dM75y06GTQbkOvtEYEsu66TxDAzAYY6
	ptanoFjrlAUnFzgumcemeHj4cIqlTLhHE/JJIUVBQWjgTkSUe3Q6XkQy5LQ1uOlsLGXFO8V+9
X-Google-Smtp-Source: AGHT+IHqUrEf5y3pTgWGD0fVm8X+Yro2Y8ZZ6KkppJs24FTlsgvrXNv/kejc0KGXPEUWcUjExKWOCilG2U5cEBQrwRA=
X-Received: by 2002:a05:6102:2c88:b0:4bb:d7f0:6e74 with SMTP id
 ada2fe7eead31-4bd3fe4fbf8mr4157503137.21.1739782644924; Mon, 17 Feb 2025
 00:57:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-6-usmanakinyemi202@gmail.com> <Z7Lddaa3SLSEziMx@pks.im>
In-Reply-To: <Z7Lddaa3SLSEziMx@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 17 Feb 2025 14:27:12 +0530
X-Gm-Features: AWEUYZlMUaZNdRfDpmnAAS4HZ1VnnkmgsHYuavS48QinWuOIwDD3L7luMie9v9g
Message-ID: <CAPSxiM-XmHepeWuOOU4RNj6ce_K3zmUYS=gmzUKqtnoKwRE1Xg@mail.gmail.com>
Subject: Re: [PATCH 5/7] builtin/ls-files: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	johncai86@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 12:25=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sat, Feb 15, 2025 at 04:27:21AM +0530, Usman Akinyemi wrote:
> > Remove the_repository global variable in favor of the repository
> > argument that gets passed in "builtin/ls-files.c".
> >
> > When `-h` is passed to the command outside a Git repository, the
> > `run_builtin()` will call the `cmd_ls_files()` function with `repo` set
> > to NULL and then early in the function, `show_usage_with_options_if_ask=
ed()`
> > call will give the options help and exit, without having to consult muc=
h
> > of the configuration file.
> >
> > Let's pass `repository` argument to `expand_objectsize()`,
> > `show_ru_info()` functions to remove their dependency on the global
> > `the_repository` variable.
>
> This paragraph made my reading hickup a bit. How about:
>
>     Pass the repository available in the calling context to both
>     `expand_objectsize()` and `show_ru_info()` to remove their
>     dependency on the global `the_repository` variable.
Thanks for the suggestion, I will use it in the next version.
>
> Patrick
