Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12585346AFB
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865153; cv=none; b=tFMTHivjg0Ud4siNbeuv6brP7ydqwKiFCRhMtrfjEpiuODEcOTi5g9ycnZxs732TMgjRSS6x1rT+gEw8woqK6xDK96L0uNGdPILa9jilpmKgl52X+NzqDd4iuKkDQj63W8Sez/hsYPTmUJNI7t9LjmcfyAXh7JDl7977Xe2xZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865153; c=relaxed/simple;
	bh=798pX1WaLxpweCwH5g5OiRtKK+2PrcvO43XRRC2YY9o=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=pYp+ci8oLN0CyRT7PWmc2B3vl7LKpOulMrP/l4WK38lJOC3p1BuQofIqz+bqkX4H1Iknc5449ccCumPZI9rk7aJ6rXWCLaR2cJLrkfwiaFjmSP+I6XbZYVyI/DvSyFHQS/OWoeB73XCCKCW8in5l2LLxB6NMasDSUVNQYmQIt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOfdylBE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOfdylBE"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ff05e5d009so4727417b3.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787865151; x=1788469951; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG7s2TDc/K5397cEMi6KYwLmYjDKV5w/gLd5J1ZP4uo=;
        b=eOfdylBEQC68yW8vt9HJgJV1nrjtb0M6C91NCpWcpNJP7TStZhHPXul5H/fVX5ASM1
         dhvSg8jzDqEQbgwNGKe3Yt6iWDoECRyPmdAHPBG+DaxEIRL5I6t4ykx0lLiN2QQM8+77
         23mLAX12AXx1E8a4s3klfeNHABKiQfUva3yDjtfZK4cz7ncBzCWxzhQpUtCzBVNWvGhs
         wovhMGxyPECTQZQbotPrcpARD2R0bFAN7bJMulsfV1E88+2k1Jscf7PYV99FWQ+OaYoQ
         lnzRyPRNEMvpKvRBeeCOPfyhI1s8P/229v61lP7AzZSu99lwFE4CD71JC5kWQSGTGBdk
         1p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787865151; x=1788469951;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hG7s2TDc/K5397cEMi6KYwLmYjDKV5w/gLd5J1ZP4uo=;
        b=gyDKfyLH7w+w/Q7Xhn3PLQS2YnGEm+y0N9dsU/Il9UFWPT/Gj6sdIumrIfK05M8Fh2
         L63URPyKY02LRgF3LLHrN0KB26q4zbSKC1xPGGP0ebbvzZfBvcIXYmPaUEkBkqIldH1H
         VyVlNFyQfW8dg/RNTBdj9H/6cFuRTaGXrBfTO6xMjoTm5gngrJhNLU/7E+sPhTdmwhun
         fL4x5o0TEpKw3l2IwYRY/TvkD5gvacaJmYCz1qvp8nt6r+vZKTPRxEkM1KZqn8OckPmb
         36lgGJgsvQ4poxcm2WaCZVMM3sHe4Uxe7JbxjyKS61v/Yn8QrblKYIL690T/RA3ONnwP
         PmVg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/x6bQOi64TyhJVXxvnR0UIINrhUYcfoS2rQCWRbioqGCxrI8W9kXAksYVtNv/EN0pJ4A=@vger.kernel.org
X-Gm-Message-State: AFuF++kh6huOFpRe9KalHGipkb3rlW+Tfxi4uUO06OYV8VvedgjMQVJU
	hWXNKB+OCgNKHlMw6qJHw6pPTD0mdIQu5eBW3wGTXrZ8f5BgEOnt5lED7aDVjNBn
X-Gm-Gg: AR+sD11wyOtc4UlCfkViAyWVYu3RpFcOQpILTpVsLtmBF6qiJAdYVRb+NJFjJXkDERT
	cs2vW4VHOpKuyv6ms5//u5e+3WLsfugcloct9BmOgjD+7RvuIKnJ7Gzg9zA2h4DQkTSAFO0X1ql
	lHYUrjHTPdk7tbBrXRoiIjoXYgKNJdrAS0cpqHsLzEGC5nVtUpzih41p+Dr4hOYbCaFN2Icw0BL
	UtEtVgqBB9/C+QT1u3WI2lYP3ZGEXAr3H4maSRbOpTjjNL1eJxcaSRiWDmpEttjAV3YeRADn5bl
	wZTcPuFZlzHnqPbknkRTNBuOKRzmN+rmA7LzKIK2yjCnVOAqag6sloH8+XrDXRH1Pwd4ndE+g+Z
	FguMQaPZrDHaD7g/uWALPd1szfYtlBIBe/v2ShuLvBg3vgOu3ONmFffis+VBnXmNKgSfcaJGa0i
	XISlq/rln+MdfejurtYPomTHuDGgmN8HzdNTKvyO2RckAnaSjBUh808akp7OlYZ45ylsElOSx8B
	XE5IkLdfi+z7YapktI4ze6ynMOt99rNKR+xwmoFZhQZ5+eDIkL2z2V9nZfKIom3Bo9GZutBRbrO
	N7mjIrQN4fk8qdHk/QIls16w0+QNFQVVdrbusg==
X-Received: by 2002:a05:690c:6606:b0:7db:ccda:a409 with SMTP id 00721157ae682-85d69e05e99mr10400867b3.9.1787865150677;
        Thu, 27 Aug 2026 14:12:30 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:a192:5f4d:1ead:cad5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b6144694bsm16619817b3.30.2026.08.27.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 14:12:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] builtin: replace the_repository parameter in is_bare_repository()
Date: Thu, 27 Aug 2026 17:12:19 -0400
Message-Id: <F276C11F-1904-496E-AA77-953724362C9A@gmail.com>
References: <xmqq7blb8g04.fsf@gitster.g>
Cc: Hardik Kumar <hardikxk@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqq7blb8g04.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 27 ao=C3=BBt 2026 =C3=A0 16:30, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"Hardik Kumar" <hardikxk@gmail.com> writes:
>=20
>>> In general, builtin/foo.c::cmd_foo() are concrete programs that work
>>> on specific repository (i.e., the_repository), and there is not much
>>> reason to rewrite the use of the_repository to use "repo" given by
>>> the caller which is git potty.  You'd also need to deal with the
>>> case where "repo" is NULL (hint: "cd / && git foo -h").

[snip]

> The utility functions builtin/foo.c borrows from outside builtin/
> directory are being "libified" to reduce the hardcoded dependence on
> the_repository, and cmd_foo() can call these functions with
> the_repository as a parameter.  But we have no reason to waste our
> time updating (and also reviewing patches that make such updates)
> the built-in implementations themselves to take a pointer to an
> arbitrary repository.

Hm. What if a program wants to do =C2=AB exactly what =E2=80=98git switch=E2=
=80=99 does =C2=BB sans shelling out? It=E2=80=99d be a maintenance burden t=
o answer =C2=AB open code it using helpers in libgit and the builtin sources=
 =C2=BB, at least as presented. Many builtin sources seem (at least to me) q=
uite complex! And it=E2=80=99s not immediately obvious how I could recreate t=
he intended effects of, say, =C2=AB switch branches =C2=BB with just one or 2=
 libgit calls. (Maybe that=E2=80=99s just me.)

In other words, the stance =C2=AB it=E2=80=99s not worth it to libify builti=
ns =C2=BB only makes sense if we also say =C2=AB we don=E2=80=99t explicitly=
 support precisely replicating builtin behavior via libgit =C2=BB.

Which is fine! I=E2=80=99m probably just not aware if there was discussion/c=
onsensus on that somewhere. Pointers welcome :)

(I for one think it would be nice to have the ability to call a builtin dire=
ctly through libgit, or at least think through what organization of code wou=
ld be necessary to make it feasible to say =C2=AB to do builtin X, you need o=
nly call these 5 lib functions in sequence with your choice of arguments =C2=
=BB=E2=80=94since perhaps parseopt=E2=80=99ing isn=E2=80=99t so relevant at t=
hat level=E2=80=94but I lack a concrete use case at the moment.)=
