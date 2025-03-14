Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342517BA1
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915683; cv=none; b=re11VIbzveifH+95VC0sPTtY6kSHLwglrzbxuD0m3nr4jCFl8/dPvSs2mDNgObWEeTKaBGZy8/uSd4s5VrSYhPCShGOgDdOfEXCKH/ThrFIJwDLjfOqCrJpXu0/NOWTPKPE5LIuQqCeEP84/TN8xWNfIFwhK2yLxmNOen+XWeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915683; c=relaxed/simple;
	bh=rYvV4Xcr7d03CNE4lKYcPwvaFZb/Ndbxp/9Te6bQm7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyO4w/EzYmTtDSxKU4hxJVDFw/rC3zVRAJPwhQTkjmiPL6tjIIoMAZBN/AO6/jOxusenbT2oAzvG7HYLLkcRwhxO1gY0w00NnfvvabHvFaIKeFUFfIPetUuluAWvhhHSwVr5r1jroMzcl1u/qeDKjZcfY/APf9yO35ghLX7iiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmqFiu4o; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmqFiu4o"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85b44094782so48938239f.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 18:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741915681; x=1742520481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxTIrJEqpDWswH22yGtVa6NLIFbueixA9v8Eiy4KUlk=;
        b=hmqFiu4oqxmZZB2YGph3Fkfm/5u+jQCPmDUU0Akpdwv2FD1lsOe13SA8Ubs81lGr53
         CLsCYK3rE6VV+/SW+K4vDYyiEF3Y+sl4qsy4llsaesP5wg4+o4rYXrw0NtDpOtUtTtTo
         4ks2zi8xIf+8lXHSTYBkqjIQU1EtJlp4uqBSVTg0QVUFqiHuXmGRv0VzAK7yxBukCG7E
         LO9i+2yqxt3VsT3CPro61PPbTrRj+zth5FRm05YpbfqZ+p3u85ku35S/+SchiCwFlCk+
         TSjTDWE1QE++zB9a06MPaBlQwgCHz9rNBftPnMcMunVRndurwCtRG8j7eB3fFcNFocDz
         wggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741915681; x=1742520481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxTIrJEqpDWswH22yGtVa6NLIFbueixA9v8Eiy4KUlk=;
        b=MMcEVS2V4HyTJxeo6dxcfOeCsOJBoCBFw8JHS90QfiaAnfB6w0GjiSoObcr06IRUJO
         lhwcIZ5bQl+OFGdXxmWAn+iKDWEiFpXrr8KauFgeBvCozh3IMvkzvSr4sjc93xqirH0y
         /hZlAD2Kr4dDMhDj2eUvobuh+WnmycdfbTeugbnPsTfqUzoliXcUUB3suUnpRnDmVD6+
         7bZy3bFkjywRQ64q0mTHZCL2ycFmcQmMfARUNhoezx5pmnHIYkazF3bGXqGWP7p9DFud
         WgqOqETWtusjY4KpLpxGfmY/GPKewEXStACIDMEOMWOGN1aV7l0uG94CINLiqQiTtJIL
         MX6A==
X-Forwarded-Encrypted: i=1; AJvYcCUO36lFahQ+A/2e1biGHI3PWqN4D04hjBM5cSphGXGF1v3YSE7vpXHbTf8Hmb31ebYy7q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoR8lNxnehtC97s97c2lGLCQdxA1SuAtvDYxwQRPlJpuqHrJn
	vupI/delcx92BhugFE3Tzj27Xv3+ABThBiroGblp7xRkhv15HTGrB1YqMD52nZeLGLeOZW7KM7b
	nMBxBMNISO7bgXbxLS5LTYOsygD073Oyf
X-Gm-Gg: ASbGncsQHAjP/gQbUfg1fiI5d1KotpNU6gvMkslS+Mz4ebXnHgbhzHygK5KBGYOdpWW
	641RUSaVgc0WedhjKsWMax4vymGhctkVfaaeO7bKU/CjTXtHj4eehcWzcTXwXHB2Yp+avQfr5Mg
	eSqxIyfK1gHX6L1B18C1zzatuyhiZ6GerkL4BaDGbegdKuRyRlo8lpkyJmuBArZlfjp7fgVQ==
X-Google-Smtp-Source: AGHT+IGn/sB06D5ZWTMPlLxedfX5u+H2nEzw65u3D1kh2dNGqVD2RUzIQQXNQAMUiC2AO5IXM8n9UeD+aDgVkZWqN94=
X-Received: by 2002:a05:6602:3890:b0:85d:a235:e90e with SMTP id
 ca18e2360f4ac-85dc48abe9emr74510139f.13.1741915681110; Thu, 13 Mar 2025
 18:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
 <xmqqy0x8l8tu.fsf@gitster.g> <Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net> <xmqqtt7wl85l.fsf@gitster.g>
In-Reply-To: <xmqqtt7wl85l.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Mar 2025 18:27:50 -0700
X-Gm-Features: AQ5f1JqM1sCm1u2MZEXUAGU0l9rmedGQaZ9WnAYTR3UPu9AsoFPPw3QOTze00n0
Message-ID: <CABPp-BHRSnNE0zj9kRjrVm4-NXt33tYBT_iSgZU-5JU9Y2vp3w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert() calls
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 6:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> >> Is this something we can use in our project?  I am just double
> >> checking.
> >
> > I believe it's valid in C99.  Certainly some compiler might be bad at
> > optimizing, or a user may have compiled with -O0, but this is run in CI=
,
> > where we have known good compilers and can control the optimization
> > flags.  I doubt GCC, Clang, or MSVC will have problems here, and since
> > this is not on by default, users using something less capable (the Tiny
> > C Compiler, maybe?) or a vendor compiler won't even see it.
> >
> > Was there some other case that you were concerned about?
>
> Licensing, mostly, as clever things we see are not necessarily home
> grown.  I know the patch came with DCO sign-off, but it does not
> hurt to double check.

These two lines:

> +extern int not_supposed_to_survive;
> +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))

, which serve as the core trick, I had used elsewhere before.  Doing
some searches, it looks like those likely came from
https://stackoverflow.com/questions/10593492/catching-assert-with-side-effe=
cts.
And it appears that StackOverflow is CC-BY-SA-3.0 or -4.0.  Doh,
sorry.  Anyone got a clever alternative?

The rest of the patch was all written by me.
