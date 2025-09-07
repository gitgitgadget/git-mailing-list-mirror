Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17610E3
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757223082; cv=none; b=eHdA9TmOKzP+dve2VMi/kKRzVpH4AvLEImIWq0na4VXoAqQYi8pASGcD783ZNTLo0vc6ENdVPwWuRBPme5ok00cmTq3oGgFOxtLrDReTOf23Op8afRamfPS8UW7Itn6O+Nb4/w1UeTl7osvlt9hD2y0IwpHNsmbT6lx40BY5Vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757223082; c=relaxed/simple;
	bh=PtTQTL/DwSJomNFmNkoMlOSzn8koBIRUKAUH6ECWXos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/ourOAZrOGDhnf1JRLpt3WeuktzRsYNKOZrV8h6aIyA78R6MHkH5A1nzwGa0kAIIWjUqm7M+fQCF5j0SZwFtR4IgjqVMPgj+KcR3Hzzv+DUuYHTagJlIMT4RBfb+phSPrb0vAsKZ8rx5xQONY9Avf6c4XPT224dxvAGhxJ5DKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3V7dAEP; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3V7dAEP"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3f663225a2bso22194455ab.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757223079; x=1757827879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHrHHdw2onk+PaEexeEdt85P1x543dzPLrmgbQ7QVuU=;
        b=D3V7dAEPymfzOJAvfRy4XmLGdmjZufVRDDq3m/s00ORiB74WZc9S/G+IbGUNfmM9bl
         cxGbkeCMJ+yyzoMs1I4Y+SjCiETHOGGbF8RLE/kk4RhEz1KETqRhtz5PfWuy2YvZGsN+
         3Xq+9GQilsKHV1ZWnF8FoQw8idZct/hDm1wAjfamjjjePJZ34MAcwClsIxUaqSeIQ1mq
         YU1csDhOCPnYhvtH1a/ilKEuCj0+LHNJBmvOA7lrOxjl+07Knp+WiOpC0LylvsjE6xmI
         Ape8R5gUvv5uCMz1MpaV5Hl9NwRX5dLfrV3qWOuNXzuL27aoniM+6e2PP95/6/JWCH+y
         nIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757223079; x=1757827879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHrHHdw2onk+PaEexeEdt85P1x543dzPLrmgbQ7QVuU=;
        b=FVtl9tQYm06wr8ytph7Cj/ZPPhQaAgiweLng8/18Yr31THorXufl3+EILC4GF5/MPu
         KaR+pklbYeIHnttyKUjLptwN2sJMDME4c7Vh4Pi0/2I/Iyqp29bfxD9TDC5bOFxiymf1
         hnYaeAIK//7VyKBARhVf9kZJrvHZNDOmaV1SyA6/tsE/Nwu5xXO7EUnutLJYLcVRMEt6
         4fSE1gP+TNUR/A2QGKhB5Q/w1cHZzTOdPqpnP+FmzRthU76vINHt8BeGO4lGVGqtpIe0
         NpP5PADtnv6hkncS4AoGbc+u2jorrO5b7Nah9G749z4SKcU2ezfw0AAJLtEgB17u7IjI
         uKLw==
X-Forwarded-Encrypted: i=1; AJvYcCUNDzGiRzf93EAM4+DQIgvEaMZUNm+kXPtsK38grEaqcuGw6RetLvPGAjMwDTr03oWc5t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUaFfTn9n7eufq2siuOf7t+hN8AZZElEdlMgPCYj0LW/nhD5X
	w9Mz2r8AQ5AcyDU7QxMmkn48skumuUhAGWWwttqIUki3VaIsNT2yGHMwzg3k5ZDvVEYUsGufABP
	hohV5BLI27vVpRG8870dgVAHeCE2UvVo=
X-Gm-Gg: ASbGnctVr1QkUdrwGy6jkSK4PnDob2WTPykyhrJsBfJR4XaGCa0UYpXZIfObjX4FOa4
	/OHSh1h3y1xlzVWMyY6U+b4ETi9vqQwNFcB8GaLyWmslAWJFc6DQFoqh22g2GvRjLUdu7a/vYEB
	3liFJYgzqbzJHOiF/Y9TG24GLBYR5BY9EM248/Gbcf/ahQIWjw5f3g5UlPGkZTaG8IRD/+lzCAk
	H2FqZSNfQXZT5eff/s=
X-Google-Smtp-Source: AGHT+IHYT33R964q6asdM2+t7gZsn8mfWupWJuVb7o+QhVii1eaQNBqzhuHKK/5hdbKcUFJMvo7qqJMiL1dAVnG+EIU=
X-Received: by 2002:a05:6e02:e54:b0:3fc:1aa6:d92a with SMTP id
 e9e14a558f8ab-3fc1aa6da80mr68125425ab.9.1757223078650; Sat, 06 Sep 2025
 22:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-5-6939cbf4a0b8@pks.im>
 <DB9P250MB0692264976781C194B7D6194A503A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <aLrnwOGKaAjLj0Bo@pks.im>
In-Reply-To: <aLrnwOGKaAjLj0Bo@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 6 Sep 2025 22:31:07 -0700
X-Gm-Features: Ac12FXxnsfWRSY7MIzdgUa7mE-BNBH1revTe6YmsCuI1iOCEAiX3IUcIe4y5lcM
Message-ID: <CABPp-BFw-Oqp71jW5SYCKYOWtjWFSQPOsUVWdF7EnzftwAR2vw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/7] BreakingChanges: announce Rust becoming mandatory
To: Patrick Steinhardt <ps@pks.im>
Cc: =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
	Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Fri, Sep 05, 2025 at 02:45:46PM +0200, Matthias A=C3=9Fhauer wrote:

> > Do we want to commit to promising support until gccrs is ready? What if
> > gccrs ends up abandoned? Or takes an unexpectedly long time to reach a =
stage
> > where it can build Git? It might make sense to give this LTS release a =
time
> > limit instead, or in addidtion.
>
> Yeah, I wasn't quite clear on that one, either. An alternative:
>
>   - We will maintain the LTS release for 8 release cycles, which equates
>     to roughly two years. It sounds like a lot, but recent security
>     releases have stretched quite far into the past.
>
>   - If there are still dependents after these two years we will hand
>     over maintainership of the LTS branch to dependents. So they will be
>     responsible for the backporting.
>
> This really only is a suggestion though. I'm especially waiting for
> Junio's feedback here to see whether he thinks that this is a reasonable
> thing to do.

Over at https://lore.kernel.org/git/xmqqplc43o7c.fsf@gitster.g/, Junio
said multiple years isn't something he's willing to promise, but
suggests 18 months might be doable.

I have a suspicion that if you want a promised level of support,
you'll not only get something less than what distributors want, but
something far less than we'll provide in practice.  I'm curious if the
alternative wording over at
https://lore.kernel.org/git/CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=3Da+=
42KT8A@mail.gmail.com/
is more likely to be realistic:

"We'll weigh the severity of each security issue and the cost to
backport and give the last C-only version significant extra weight in
our considerations"

I know it may not be what distributors want, but overpromising also
has deleterious effects, so...
