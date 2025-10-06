Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151C7E0E4
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787735; cv=none; b=EIkWkbBI3bwT8lKJxwebTde7qcnghVWIFCYnCf2xzxO5L4Dde2yC57Z6g0DYw9ZPIfW0aSzmwjHB+mho2Ad7jfJXT+cewKAJ4RPGHnJOaJMIYTfXn6mSdxQzbSmyot+HvDAonW2GE5sYI/0wlTrW2xAmPXFGbTcVgFYAXGnMhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787735; c=relaxed/simple;
	bh=nPwRItWvkTUEY5fDwSDzhiSOyl9oaPPzCD66sc7Xqh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDu7bubVyZgs5uEaRk0sbOmk9TU7zuxl6KhNTqip0TD/StJhMC31Tc+uummdB9qXGugpXHWt2WFBS+QLmgOpb2IB3ui8Lb6o3wumIft2gyRWrhvzNSC2ADcCrUIRq6eIgpV7GS1QCVUJjrxTXD0ypuxxktDZTt/HS0GHKHZaIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNST3pIZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNST3pIZ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso11330630a12.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787732; x=1760392532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQs/O36ggQklw0zUSauUiUtl3x2Jqg69RjadNSont+0=;
        b=mNST3pIZJc8oyaUO8FNdf9eMmrMysnDp5ZOcJrLB+L11yjlYmGhczXGTIStNUQ5ZIg
         vUfR4Fsw26qlYoGXddeFl5uh8eGR7DS9wpj0puflimcDtpREzYWMMtUEboLv/BjoyRCA
         qGHtA+H8SvAp0aq/lVDbB9dhgKX0X2Lrw6PqvjIbBqcvHsJlsLRIlyvJlATFBX7aqWaX
         isOPP+Ud2WoZ0t0dlZWYcTR5XaJsbX9iWojup982bTK7wvIa0R8y4wDsWNOgGeLHr0uA
         QKi/Yny/8mt3A8AQ1unmegKCj80GB+pAhfqUjrRzkfnm0kiWlmwAyEDrbK7nB1JhaGvu
         wlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787732; x=1760392532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQs/O36ggQklw0zUSauUiUtl3x2Jqg69RjadNSont+0=;
        b=fm5ttN0TutgwpV4q/WnmBjb6jFpUxtUUbvFVGPdOK/Jxot2DuzBCqmISzVZ3KlC7Qm
         IG5aeycIOjlZ+KdlQLAYoaPF8iQKhrJpjG+ZAW01mrXZVo+wu6Ue0xewbnl4izHV/8Xg
         jrtD9WXeDqToqswITN98ETDEOc2pLNzYEAxh5B68vowdL5lZn3aFyj9VFieeUeZ5kM9S
         oabQijk39heO03t7C/Akf7SAFCAv9OVob86ALlTa8fle7RDMouukzLYwNdUA1SVx2f8l
         Qns9a8dSuquomCzkkCYS4QYvHijz9qNq7Z0kbArhCyPJC/O65RKOKDxp63in6LUXOVcy
         ZuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoFj+yUubtLg2tJFSQ0mL8Aa5DeGXkqS/5LMRJbVmVvKh9QPDviqwswY5zkm6Os5SLi1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs97erhPXGCBcC02WVIf8Zvogc+qBJA+tgB4jP+r4AU4opt7WT
	oKEJsTkpdrRGAU+ygYTJW8Sigtzvt38vPpNUu/Ko+6Q3QyHNkl8rDVIiuP0B+3DOEooFaOgBYzI
	cHeV4p4i+rGg3IEUEgH12wnYyExlcGvB2uFof
X-Gm-Gg: ASbGnctwgVOPJvbWc+qPrKHGzOe5V+XkKZNgIuHoJec6GwmG3kTP38/9qsN95efqgFR
	n/Td1eSnhCMKjh+cQOL45D7UceDFEQoX3jwq5ivHNcHce5k6Bz0PgR+3OjDNt590GfJ608LwUxB
	R2MpB9Hvz/t6AQ6iff6TttxCLI7AAI3k7AU3oIhkZXEIDpk6M4rHgf+uI1mny2RWv3JL6ShGDN+
	DHQtnbbIFnOH+UE4P6+qcAoIR5clz88Q8dZtiP6RbNkiHawkAGtw7Hc5jO9DXD3pQ==
X-Google-Smtp-Source: AGHT+IHVwZiQgmwYR9Hnr9xg8z7SFsSis/a6+VgCl86OpSzlSV0js7q+Hoa576WWbBoXgtD0UxPisdLHkXtkXEGeZZs=
X-Received: by 2002:a17:906:9fca:b0:b45:913d:f523 with SMTP id
 a640c23a62f3a-b49c1977591mr1843963366b.18.1759787731782; Mon, 06 Oct 2025
 14:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com> <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
 <CALnO6CA29HA_FOQAJp_bkskKF-6Vy0_SKVL_OyJASByvKEZTqQ@mail.gmail.com> <1241cb86-9adf-4c52-87fb-028406ccd8f0@app.fastmail.com>
In-Reply-To: <1241cb86-9adf-4c52-87fb-028406ccd8f0@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 6 Oct 2025 17:55:20 -0400
X-Gm-Features: AS18NWD2lv2V5fVIB4ubB6m2ah6Nftcre68aNSjlmBDVgfAj1jO3TpJ_QaeTKi8
Message-ID: <CALnO6CCsGtjcWBkjV0vsJHDCwiwt9eO2CsA1zFgwFiwJ-KLhew@mail.gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
To: Julia Evans <julia@jvns.ca>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:47=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
>
>
> On Mon, Oct 6, 2025, at 5:44 PM, D. Ben Knoble wrote:
> > On Mon, Oct 6, 2025 at 3:37=E2=80=AFPM Julia Evans <julia@jvns.ca> wrot=
e:
> >>
> >> Thanks for the review!
> >>
> >> >> 2. Don't mention that the full name of the branch `main` is
> >> >>    technically `refs/heads/main`. This should likely change but I
> >> >>    haven't worked out how to do it in a clear way yet.
> >> >
> >> > I think this is worth getting into.  This is a pretty
> >> > user-facing concept.
> >>
> >> I think I'll see if I can figure out a way to mention this and at the
> >> same time remove most of the rest of the references to the `.git`
> >> directory when explaining references (which you talked about
> >> further down), including packed refs.
> >
> > A colleague will be explaining reflog for an audience tomorrow, and
> > decided to briefly explain refs, too=E2=80=94which tells me this is
> > much-needed.
> >
> > For refs themselves, perhaps "git for-each-ref" is a reasonable place
> > to start? Since it tells you the refs you have and how to spell them
> > explicitly regardless of how they are stored?
>
> Interesting, do you use git for-each-ref?
> What do you use it for?

Ah, yes, but primarily for scripting.

What I should have clarified is that "the tool (I know of) to
interrogate the refs you currently have is git-for-each-ref" (like how
git-ls-remote is the tool to interrogate a remote's refs). It avoids
the issues with assuming "tree .git/refs" or similar will capture the
actual data.

--=20
D. Ben Knoble
