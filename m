Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA037031D
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656113; cv=none; b=k8pfZzxFdemrwYYDjoCZQvfMvwcgp+W+d9xb0H68uKIbJra8mvjR4wTbDfa7iY1EYbF3tda8OZxDHsabE55v+nMWehMO9OrJeeszRuTINSSmDLq5XHLvr4SVA6+smLlsyXOu6sMu87T82JLG91YXIE8z6PjbG/H/EL2HIqlYaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656113; c=relaxed/simple;
	bh=/HCAeBwMH9YY8xJmU/XJ9RiHTvuhmAFI+KoM52NMLfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijckuNn4qiyHdJTLtZdSscPzckgowRrwcWCnCEEgGLIpO0fmqDsi/k+zBGkoBxyw8nmwqaGKxKtwr7gXH+8aEDfCA2vdgDHQHazzT2vNVPFhviKW3xocz82BdTdJ91kgsS2dX0Hkqz1gaBNZDJXEk8hJ8bMzTyV9pTiOnUfQxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iryPgfPd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iryPgfPd"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso783530a91.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763656110; x=1764260910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km96ZsWMhzOncWnGP5SFffmCGYu2Vmt2jdm2VYjY+VU=;
        b=iryPgfPdcjHWtCiK/c7uDWasNNFBFhiEZjdANGAvZ96SKoVYdAwOtxOIiw6mrtubab
         YUnaGF3vvYvifBTqw28XvXWXGmHNrzsTvePG6gEYyV6RAL+kLH7lOqxjR7+Zcq/Q9C21
         BvUdqIWikYPmjvC4zmYUO1vGwIpDSGsT80zdYC7eq/4lAFrseZOLL5X6ScPecozLImgi
         XSJOzSwDX1jdJar2C24S9Pzm3NyYigL69aQJDC3nwYHuplvq3OnT+QriMwsqkydt7dJn
         GdefkSuszEYzVnKBIhONTJFokHkhbmA1SmXvouTgcdugjaSsiPPn/9usoJfnG5XIqG2L
         40JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763656110; x=1764260910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Km96ZsWMhzOncWnGP5SFffmCGYu2Vmt2jdm2VYjY+VU=;
        b=cUAxryyIpkbDLX/hl/fbV8yuqMByt2n4d3O4NzE1tRhVuMD3OihchiEWQOu4uk5Jac
         D3HF3wnNpI76N0OATvkoxuV1M5poCtHlndWspc86pbniF/UVutFCTKxj/+sGkHSQKPtc
         wDtB0kTxl3tupn0KAUkdXWsZWZs8vf0RqWr0hp70bXUzH8SFo3o2+UIqDabh612QRFHa
         h3W2CGg0MKDDle0Th3pRE8aASIBxPlm4NZGnMq41649OGrBnC9u17//Jxtc0/qRnfodO
         Z1g60wCDWtpwPcJLXp7bH+vIvngvsexyGOubPQy991Rs5HDa8e+IpOfKMKbP33f00azE
         O1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVhj23rntkpA8HYzBizuGUSwJdb6JI/MHIels0YmaKMBUihsi4CkbeKo+FxB1K1xSobuHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAJp925q2eEa8yM+fpdGAlz60cBugdSFxRylTIBHvGkkgRZB6
	gpwQJU8lUq1/JNJWHgJ9/xF/9MelNynWtH8KxPGmneEg1KVKEM4jcIeDgy8z4SEgBM+gi8MZq2b
	toOkbl367jF7H/lYVsrrhlV7lXZ/lnkLp2LsYSWg=
X-Gm-Gg: ASbGnctpJg1sxg3gz5khhkREO4X1ktn9ZgrTGu5NlRaOfXXLJE1WclO9Nx2yA5roi9/
	fmIt43X2tFwsBSjbrdxd7XVrJKJXynQfqtpKky3L1nyWb/k8P0z9/XdEh5b3a1BvkDRls4yQ7Tb
	EHC+zBrH7o9L50JcVUYL0Dnwr6+/fyyEf1qXlU2q8RICITsx8ggUlRjjP5Ft/KV0U8Dd+S7qRcD
	8tMyOBEK20cqe3B1OlR0fX7YAEsOPU1ADZ915KFk+K3ZUv5rVz+J1GIcTXfAElKLLx2jtTQYB69
	UeT837k=
X-Google-Smtp-Source: AGHT+IG73ixu27CE3sKBk7nr5fx78BO2sKTr0/zgTY3iNybe12H8XQNysXklBCclLEkFcU5YCcgwwtwnXgupm4mPavc=
X-Received: by 2002:a17:90b:564f:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-34727c39591mr3895143a91.21.1763656110564; Thu, 20 Nov 2025
 08:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL4-wQrgD3nnW2BfNf6e9d7tDANE60dYBRRP_0FW3Z-LvQrZmg@mail.gmail.com>
 <0e971281-d1c4-4030-9297-f5e2c0765431@app.fastmail.com>
In-Reply-To: <0e971281-d1c4-4030-9297-f5e2c0765431@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 20 Nov 2025 11:28:17 -0500
X-Gm-Features: AWmQ_bnMoEqdfMsyxQDxEIIqBZL02yM-FLewQLrFhcqbni1kA6pplx0vmRQPVog
Message-ID: <CALnO6CDBQWXSvJeXOtVYdM83vibuqDbvjAXn6WfpgsAp_Ky+xg@mail.gmail.com>
Subject: Re: Feature request: git cp
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Martin Guy <martinwguy@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:34=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Nov 20, 2025, at 15:56, Martin Guy wrote:
> > I am splitting a large source file into three smaller ones (mp3.c into
> > mad.c, lame.c and twolame.c)
> > and would like the history to track the relevant lines in each file,
> > like "git mv" does,
> > but I only seem able to do this with one file by "git mv"ing it and
> > copying that to the other
> > as a new file.
> >
> > So what I'd like is "git cp" that is like "git mv" but where blame for
> > both the resulting files
> > goes back the original one, if that's possible and unless there's a
> > way to achieve the same
> > effect that I haven't figured out.
> >
> > A fairly rare thing to wish to do, but may be useful in this case.
>
> Copies and file moves are detected dynamically when you use things like
> `git log`.
>
> Try `git log --stat --find-copies-harder`.  I get this output after copyi=
ng a file three times.
>
>      README.md =3D> rm1.md | 0
>      README.md =3D> rm2.md | 0
>      README.md =3D> rm3.md | 0
>      3 files changed, 0 insertions(+), 0 deletions(-)
>
> I get this output when I change one of the lines in the same commit on on=
e of the files.
>
>      README.md =3D> rm1.md | 2 +-
>      README.md =3D> rm2.md | 0
>      README.md =3D> rm3.md | 0
>      3 files changed, 1 insertion(+), 1 deletion(-)
>
> This is the first time I=E2=80=99ve tried this option so I don=E2=80=99t =
know
> more about it.

See also https://lore.kernel.org/git/20240311213928.1872437-1-sam@gentoo.or=
g/
and related threads (Gentoo's Git still comes with these patches for
ebuild developers).

--=20
D. Ben Knoble
