Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAC3595F
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735416829; cv=none; b=j7FK8c1FYJY/CR7QFr0dmbq2R9xcxA9+xzTxGXNfk+aJHG2XeFN09T5iGEDg+/32Mx7TTvA+IijVAuDgA8gJue9P33QjzN8Kf7t/dy0wZXrvfZ5WC9nD6ymKKG9YveIPZNJZDYp8ppPKlrMx4f0u5dZlODhxn9DOCvZSVeE2Aok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735416829; c=relaxed/simple;
	bh=YpmMLK+FohC46Lmys0VeksoUkEMyqU70gyphe+iGxWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQwu4sPy/U+Dl4EDK2MsAmtxC/CITRvF7iGTEiWYdLXb3ARj15+4tHA8XI1yuuGGxtjDtghYIrl7MbVktUnqKzcBvLddC+HFjpNzbzOA3PLouSg0REcBe3cYnHxh3TRpOX5aDzhmaBYFywGzs134QFfskkh3SjZw96qHKnfvp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1V+hJmk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1V+hJmk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21654fdd5daso96856775ad.1
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 12:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735416827; x=1736021627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpmMLK+FohC46Lmys0VeksoUkEMyqU70gyphe+iGxWQ=;
        b=d1V+hJmkwRhoGctwv0pM58Ga9QgLHIrYJ3bXGFcmnsv2eN1SGdEIeRy+2anM8ZaXqM
         gWw6THmjumHNm/41pEzXCHYJ0XI+cxMz7/TSoCnTFB9iL5iu+lu8kfrEVwuV8S5pjQAc
         b6Nc6OaVc6eJ2EmM0RYhHZjoINh6FJQ7D99EebrckvI7QcnGT+Jt4HnlYZJ69/SRkURR
         aMvvpaQpIHkMiyVwRiY3t/YApmkXi6XSmY2DOjJsLwHTuna10j9wM3lhaMtEtn5NUZd3
         oV6VHb57tV1Zkx2xUpDQNJ3roOSP4tZJvBGcstRm9eBxQuKuBX4/MloTaIfExTqDA3FJ
         +4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735416827; x=1736021627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpmMLK+FohC46Lmys0VeksoUkEMyqU70gyphe+iGxWQ=;
        b=vbeliOhsUDjlWf717Slr8hHQflX+nHQ6QR/byAulVEdH/QF8XZEOU54JZDFsIoYwVD
         XlVjmRNCnrt20UeCFgiIwveE4u2abZOlJQB2n1XCcWAfICcZt1Z1/79887Mn9NJ87onu
         llPnawWm4tP/yZEI4GTeZtYD8HSDYiBwHYdymzKRA3p81lICXdHc6JCOo+j9ZKEIg2bU
         BMo3A0jtMshsBt9oirxg7JHxIEWIu3SOn977/IcDjXbpL8IymKxuHbfe3dtoFzQKhLgI
         8ttMqQRdAs+mQhdjPfrZuwutx5BaiVgiHvSxr1XB8aHCgL2sgoJp1Yyf00YtTeA5qZWT
         q3DA==
X-Forwarded-Encrypted: i=1; AJvYcCVJofYZdVDZ235aqMkDQMc3CYWTATBAzes8VZ/5ifVyKE3gdOsqyP3BYz4hRTgcM4f7aRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmVGrhwyWGdVkVnuinc7R3t3/NGwGZhr+nkzUyzDqbekmCpSx
	Dq6Ft2lFKM1RkhyrErqg9f9ugoqeQM2jb5RWHzIvrlIoI5Ob9Jke9Liq7quFRub+5pljA8Xva86
	N7k4e4e0es0nO9V3cpqqZ5HFzCGQ=
X-Gm-Gg: ASbGnct2vHhHfchqzjmydlmQJCfIUnZQbgHStxPAokUYWAUH4ZVJ2iMqki+c6YknNyi
	K0svvq/13dIMorVzNCsUBAZOf/tqjkTSB9GVaEg==
X-Google-Smtp-Source: AGHT+IFr16hEWZcTdFxVLYgn8/gk5A1AfuQHNcYUlIv0vNa84L/RJPDMb+FvoxgwwNVyG/j1KDnUL00CP6I3yBJDp2Q=
X-Received: by 2002:a05:6a00:414a:b0:728:e745:23d8 with SMTP id
 d2e1a72fcca58-72abdeb53f3mr48359397b3a.24.1735416827340; Sat, 28 Dec 2024
 12:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
 <20241219054222.GA2310556@coredump.intra.peff.net> <CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
 <xmqqmsgrncr6.fsf@gitster.g> <20241220090533.GC133148@coredump.intra.peff.net>
 <CADMKT2_QonR_XbZ5297Df34FrrTpbJp04Qy5BGjPb_Ov=uFF4A@mail.gmail.com> <20241228194428.GB1535629@coredump.intra.peff.net>
In-Reply-To: <20241228194428.GB1535629@coredump.intra.peff.net>
From: Boomman <boomman37@gmail.com>
Date: Sat, 28 Dec 2024 12:13:29 -0800
Message-ID: <CADMKT2-kK=CNp4aeL2JciugQdNWed62VRmkc-CTaUNxoMxZNwQ@mail.gmail.com>
Subject: Re: git gc does not clean tmp_pack* files
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Right, but you know the *intent* of why each pack was created, right?
This is push, this is pull, this is gc. Clearly some of those are
expected to not run in parallel in normal scenarios, like gc. I
imagine there are more: fetch from a single remote, push to a single
remote? Why not make their packs names contain an operation identifier
that's supposed to be unique by default instead of a random string:
tmp_fetch_myremote, tmp_push_myotherremote. This way you can reduce
the number of trash from failed operations, since the same location is
going to be overwritten each call, plus the folder contents will be
much more comprehensible at a glance.

-Vitaly

On Sat, Dec 28, 2024 at 11:44=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Dec 20, 2024 at 05:17:50PM -0800, Boomman wrote:
>
> > For me, two "git gc" on a same repo fail to run:
> > fatal: gc is already running on machine 'WIN-blah' pid 40304 (use
> > --force if not)
> >
> > If you're already colliding on this, then I don't see why you can't
> > use a normal looking name without a randomized string like
> > "tmp_garbagecollecting", so that each execution would at least
> > overwrite the same location. In this case --force could append _1
> > probably.
>
> git-gc is not the only thing that writes packs. There might be
> simultaneous packs written by incoming pushes or fetches, for example.
>
> -Peff
