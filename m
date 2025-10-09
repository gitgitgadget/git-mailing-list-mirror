Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822F86331
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052958; cv=none; b=btrxH4ZCHnd+2wvVs4oG9Q5sVZWxBG7agKem5Xkn4EcL+6UT8yWxJsQ2KBHpmgPKqzrxwQf/eCcOW+uv0R3HAGXKPKnLQf/sbQUkLgVtfgYNQNH3SzVG+Xp0w4DyYPAmh5rMGYdPTjdMLLdxxjRSWyFjjWYUdsjxf3DOuc3+DlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052958; c=relaxed/simple;
	bh=xas0rtC31zf4+pH5UEEKKd5hKjy0hjSN+zaNHKEYODQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0C3Kvrv4OG2w8W7whx6rjjn4tXjeUpD2fGGAnudK40G4ORv27TR/JPH7d3EA09i1UzsbIG/5dn3NT9Iis6cdahHa6GV7vmL6osIBIhjn0YEY592L5haY4NumAdMiDtORCsavIBy89ehKb/5+uQwTa3azEi1nVAD0fpfjOOvHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5MShJy5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5MShJy5"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso2134410a12.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760052955; x=1760657755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xas0rtC31zf4+pH5UEEKKd5hKjy0hjSN+zaNHKEYODQ=;
        b=F5MShJy5Nt121NCUqZsINZwwmcQMl6VYNevZQ808hVLrGOZKN1ScVc8Y1stmoXV642
         GsWKegDNZMAZ0vP+sGQc8JmBX3CyMRaZw2kdzPqsfsJUxXnP2xNbdnL+kujH+auMjhBY
         TLs2sPrslWjMChw3LmV4pNVfxD+i6GRsQ4zOS6mr13AB8A2vlgB3l8HYt87RmWC75qEF
         7KrD45TklLMMs8vMApWGk6ITlyPn5srlZmkcOxwBzw9O4G3RLyi5ggCKmK2KHMo1ZY+q
         69RvUKXclF8d0PCE6ykstucuScHPqHuYjL6DYh/ReqRsUyzOAEdiBIMjJ/nj7xMu6tT5
         kjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760052955; x=1760657755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xas0rtC31zf4+pH5UEEKKd5hKjy0hjSN+zaNHKEYODQ=;
        b=FHH52HJKMcI7BwyTtkzhHAHtVKjf3g+jlTIXy7Z7p+fj4bV72K/O59Jl6Rh9svq+kP
         BMYb3W9JMVL4+3spOTlQFqIZdcg22EgvQrPspaktHXJ7z2x5s9EDA329GXcG+0L+eUuQ
         sv69kcqZjTZm+rf76HA5rIDnJU4ETXyUtV94qL1yK0l3ULSsMpoIj4Y9dJM3QiBR6l6P
         bfRgPOSthdslbhJ0/RHSTEg1UTWorIAt7Gvroz0YJm6B+C48gB+eacn3Qjon9lD3SIJD
         x0/W7btj+8bgPt2tuVxJwvqyl0KHExORAkrDtkaDXP2UVWY+hMgrRFv9MfdULNwEahmJ
         M5qQ==
X-Gm-Message-State: AOJu0YxP7Ape42Pm7O2dZhV6y4YActgyEIx12tZlTTmWM+7S50DFmDHW
	x7fvGod1nmJpq6ms1EwRnBEK1y4SrdDDFUCaKwKIJu1rW/7jxlWtFRXRRGvFbIgaIFtAqJGoL+k
	u0wl1QFPp/FKR2YECiaWK+mZnvLs0xLI=
X-Gm-Gg: ASbGncvAJ+mf17haJ7jTFEiWZt/grGnu4f2KOFP7NAXWAEnvEfgandb8hJ/poApe5d1
	ESlgE7/e6Bse6GjeTfWA/28kCs3UgMoIdgQzE8jSSQuM2Ur7+absUs8spvOrf7SeapxFwsUKEJr
	ETwm/qKQcjFRhjlwKAnyb4vjCWfQh9hA0S4NI3vO0pCdvdkOqGVj94iOHZUeVf1VKEt4ipTDHTc
	0QL4zRFISSBf7g5mM0gnns1MFVmckb6Xh5kr5JZXosH
X-Google-Smtp-Source: AGHT+IFbtg41e3W3+y5OF7rW7jqGZyYK8UckoONiMFRL3agreAAcSJxDRJLaag/h4TC24Q5K2OnY8M24Q6737i75P+A=
X-Received: by 2002:a05:6402:d0b:b0:637:e581:714b with SMTP id
 4fb4d7f45d1cf-639d5c44856mr8226001a12.21.1760052954942; Thu, 09 Oct 2025
 16:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
In-Reply-To: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
From: Immaculate Atim <immaculateatim56@gmail.com>
Date: Fri, 10 Oct 2025 02:35:42 +0300
X-Gm-Features: AS18NWAIoL0kBI9q76URpPaqj3NACZUHMeNZLdZ6Q7Jw_xI0WnzzOB_pv5R8s8A
Message-ID: <CAJXmEzTVJiDLe_9gv-6MkNcztAezQJob90S=HW7r_AkVZUMukA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtPdXRyZWFjaHldIEludHJvZHVjdGlvbiAow4FnYXRoYSk=?=
To: Agatha <code@agatha.dev>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Agatha,

Welcome here. Please feel free to reachout to this mailing list or the
mentors in case you get challenges while working on your micro
project.

Best regards,

On Fri, Oct 10, 2025 at 1:15=E2=80=AFAM Agatha <code@agatha.dev> wrote:
>
> Hello!
>
> My name is =C3=81gatha Isabelle (pronouns she/her) and I'm (yet another)
> outreachy applicant for this cohort. I have some experience with C,
> developing mostly device drivers, a couple of patches in the mainline
> linux kernel, etc. I also do some assembly (x86/x64 & riscv a little)
> and C++. My goal at outreachy is to regain experience to work in
> software development again after some personal setbacks took me out for
> some years, while also contributing to an interesting open source
> software project like git.
>
> I'm looking forward to interacting with the git community once again
> within the next few weeks during the application period.
>
> Currently I'm looking through the documentation to get a better grasp of
> what is expected of us during this period. The doc says I'm supposed to
> send an introduction e-mail, so here I am. But I don't want to just do
> that, I would like to let you know I'm also working on choosing a
> microproject -- right now I am exploring some intersections between
> git's object model where objects are immutable and tightly linked to
> author metadata, and possible privacy concerns. Especially for people
> who would like to exercise their right to be forgotten and transgender
> individuals who might fear former name exposure in places where this
> information is protected by laws, tackling cases where a simple mailmap
> entry won't be enough and rewriting history would be way too disruptive.
>
> I want to see if I can work on a microproject that helps to tackle those
> privacy concerns while keeping objects immutable and preserving git's
> design principles. As it's supposed to be a "micro" project, I plan to
> explore a small, concrete first step rather than attempting a full
> solution. Yet I would appreciate any input on that. I have a couple of
> ideas in mind to check if they are applicable too.
>
> I think this would be of actual significance for several groups of
> individuals, especially for transgender software developers who face a
> lot of challenges to get in the tech industry, even when they have years
> of experience. While in some places linking their current names to their
> former names might even be dangerous, or at least lead to embarrassment,
> losing credit for their contributions to avoid exposing deadnames could
> also be a limiting factor towards obtaining employment in tech.
>
> I=E2=80=99d be happy to discuss whether similar ideas have been explored =
before,
> or hear pointers to related prior discussions.
>
> Best,
> =C3=81gatha Isabelle
>


--=20
Immaculate!
