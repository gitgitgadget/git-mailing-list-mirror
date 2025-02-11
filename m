Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD726E626
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302278; cv=none; b=BhOB7lW9KpRBzh8hzhypqFI3TGcHKJO68rSP7BKR6yP8b3/BF+KSAaJCRJVoaQzBviH625CXWyFNT++hm0JfOYOYEKSe3qt/OIc95luM05HtPBEJzOPsvVAFFMXxtYOYI+YIehDQt46zK3hhAlnjkxC0RqxKwqGTDsLum8lThg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302278; c=relaxed/simple;
	bh=h6SwCzFdXQqcSOIhvgx9LNI11HA5NA3jHXF8/L504Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDv3AVxvwE8HlDqicoQf0CJR8KoMfOm3E/R+k2XxgspQzErSL+og/ACI97PQwe6vpD4UdJlHRr3wpqPEus9GJ/FpvEecAgowYSO2CrO8QbQBU7pECySNzGgJ60qoawRcqSirqlOaishsveRO5ITHZkM7LODge3CqPf7h3F5nW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2387HIW; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2387HIW"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so6686416a12.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302274; x=1739907074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6SwCzFdXQqcSOIhvgx9LNI11HA5NA3jHXF8/L504Ps=;
        b=M2387HIWDOQ5BFpYpuT1PpqveldhDv8WUNQjeI3IQ0IZC9TX+6oMZ8LgoJ+JUMGY4F
         37zY4UHT0SOAVo+xw+tQgFVKt/LSnia3AhYDkYZdZ/RSQWQSw3baW2QZArFvLyl4sor+
         gILZYlFu411PYJOxxRw5759tg6VEbubA9BjLqWL7W3Awv5QxTltEDfCD24MiuRvpCsvH
         qU9CXAiZ2LIrE2ouA8QpdKzlfJTjtovNVImfUfRUakodfXaO3uxXqiAXq3U0S25sz68E
         9EFbfUFyk7W8+YfHm2rsslOdbuCwwWDGmoT8K5zZglKQMgGfHtdyHzjuuBfpV5ST/vVC
         Qgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302274; x=1739907074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6SwCzFdXQqcSOIhvgx9LNI11HA5NA3jHXF8/L504Ps=;
        b=p8gPlswpr0VwjHrenLSXCf9RYVuNYebCKazlEw1ptLKO3gSve2U/8x6GKaa3zLRzyc
         cy5Qi6XFuKEzJFYxOKQATRI7KmAtR8F4no/xxnny/J3KTvOBE+2iI63bbA7bBmp3/xi6
         gElyT2z3aOzVuCTWjCfdcON2D+20q47+RVfLQMmuPDLj/UjcsQpS354WaBkrD9Fl2Ktt
         Rveo/fkZ0mc5DWi/4Za1x2zNY639aDsdmo5oQjBrii4+x4pFkhyS9XOMQUZCUlF/SDet
         AK7jYBchs29miX5wNF2GaGhpsPKz7Qa9bTR/6C0A75BPIdYvSfiqlDVsJcDRvTUXHctS
         gX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQHHvC/a+oMTmrq4AZy6nQvpBbg6WSzKn1As34k5yEXuZA9Xlja8EBM/XOla4UPdF4aRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QppuepH5QDF65LFS4Y57cTiBelUSBouXKVqFD/dcwr3J7Ali
	IFct2YHjQ1aslLOCB0rido/gZtTC9+nL09oP+SM3POqsdF5Rk3A2S0TOOhbPfKGHLIE4seXbgwg
	LGscA2VBK9fWF1VTpoGZIt8+/E0Q=
X-Gm-Gg: ASbGnctjWc3j4r7Gj+8qiyZxVrQrkDU6l9eYjD8e8u04AMjQ6ra0fUSdegEC33yCWup
	utIBH7TYjjAu86ibviiZf51M9QW4GDL2wJcJ+x4HOwJpVeLiGohKrzXLnyUZZy70lIXjtzjD7Fc
	mPGzPej0bYvTmenRPrzZQF1AL7+faH
X-Google-Smtp-Source: AGHT+IFjj8jUB+1eK15B8GCnfQB150IPbTu5mwhWs310YYidGRsglEIf0XHCHE69TmKI5MaYGHnXAWKgzc6tf0BtcVg=
X-Received: by 2002:a17:907:94c5:b0:ab7:c6f4:9529 with SMTP id
 a640c23a62f3a-ab7f33781f4mr19813066b.7.1739302274281; Tue, 11 Feb 2025
 11:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208061702.88469-1-forivall@gmail.com> <Z6sCeYmljrqWRFnS@pks.im>
In-Reply-To: <Z6sCeYmljrqWRFnS@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 11 Feb 2025 14:31:02 -0500
X-Gm-Features: AWEUYZlJEpa8zDt8abXL7o2UBssc4SMPZ7_UdTJVPzyj67KEhP9Dp3xKBZrvHKg
Message-ID: <CALnO6CDHZerHKaWwGc-9CmwEMiFVY+Ds5-GNWYKUi1yO7=U_Rg@mail.gmail.com>
Subject: Re: [PATCH] revision: fix missing null for freed memory
To: Patrick Steinhardt <ps@pks.im>
Cc: Emily M Klassen <forivall@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Feb 07, 2025 at 10:17:02PM -0800, Emily M Klassen wrote:
> > "git log --graph --no-graph" missed cleaning up the output_prefix and
> > output_prefix_data pointers. This resulted in a segfault when using "--=
patch",
> > "--name-status" or "--name-only", as the output_prefix_data continued t=
o be in
> > use after free()
> >
> > Signed-off-by: Emily M Klassen <forivall@gmail.com>
> > ---
> > I previously reported this a few hours ago, and ended up digging in and=
 figuring
> > it out. I'll make sure to bottom reply in the follow ups to this patch.
>
> Do we know when this bug was introduced? Is it a recent regression or a
> long-standing issue? Might be nice to point out in the commit message if
> we do know.
>
> Patrick

Out of morbid curiosity, I've started bisecting this, but it's proven
slightly more subtle than I anticipated. If nobody beats me to it,
I'll post my results when I have them.

--=20
D. Ben Knoble
