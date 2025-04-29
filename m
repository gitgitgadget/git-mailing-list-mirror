Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5121CFFD
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939583; cv=none; b=I9wDRaOJ+CBk2uXAEvpTFw0KqR2T2n3xXEfKeztJhB2e5OsdXf7SHjGls4WgEpKU3jwYfujp4vfrMh+RbT8sbdEifI/MC6Z25cQAYEZpY4T/Ab+QLOLp2MbrFMb0+wBnITi6r7UvlzM5E/FAjtUXq794AY91VhwgwtA10LcmHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939583; c=relaxed/simple;
	bh=qAs35rkmfKFOFvhoG5BCbDW6Qz2tF1oVGwv2uLMBrAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzi+HcwNqdDpiED5PXoqJTQsB2HDTEyRTvvQ45c4QobzsvZ4UiPSqmOzvY8Z6jK83oY9KyCXaOrtP/g3IxyUp3NnCQ0w5sTVwAtOQO5Pn0VDQ++wOyUeqzGYzLAdjx+J3JSCu1bU5WuJ7BgF7GG9G9n15IHFxX1VMdW2jPss2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAxXSokm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAxXSokm"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so9001973a12.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745939579; x=1746544379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs2l1h7BZP7fytyZm9WdZaOUUh+eCY6J8LEQ9pBfKZ0=;
        b=RAxXSokmaTE4fqnuFOFrZFY+4xmTdXXh0CHKsxTKc+clek/REfp5VLZM7dkQ3usObG
         XOOJVtA2sb4NkALKuxF4G2BivpW5gyDMV0mVhGGENLJymgCYkBXTqJV4JIlJlwYbU3/p
         K1c/x83LGO8gzurdqZH6uOSDyC58wt4r4hyS/9PysC9KMMPaYC/pgx00wopK9nC9XMH2
         3+06OCt8GVRMS9Enl6TayUlLIc7FGsfXHVyrE73q7fCLeRru3Hy01wrWBc1OcGFTfOBU
         gBfQDMd0PH8FJvnLZ3bkXp3VwiMalVvZjiYT+SOsmK/R46BVCson59cB+Af2fjQbH3W6
         t6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745939579; x=1746544379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs2l1h7BZP7fytyZm9WdZaOUUh+eCY6J8LEQ9pBfKZ0=;
        b=MDu7bEKduXM50crwKaAeJCRWNYOOD6jCS7/yXqncSEEklt95BAS4TfrdTLqnZvJIQy
         HleUQTkGi48VJi3DLyR50sZeg4tV2ZJ+owGavEbs+MiK4XnWR6zb0cJhIHdUYLJNSusB
         8Oc7gYwFzcaLbJatksV3oD4di3Ti5uWm2ZTyS0rm9sIAP90hnx1hEuXO4pgdJkUKj5oM
         bZdbWPTlMxHsRuA6EdJetYeAyXUfGaeJSnH0VQsN2HUjOlJN4PRBIsDg2NpolqflZRfS
         2KUP/n151diaGicPUPHBNKQtZumYCV27KawTVNhhoidM9pvMnZZ2IB7WpYAS+JJkNtj9
         3kdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlK0AsgD6D8Ap4RJuUCG2rV19QlFnl6j5C/xZbZ3t/pgjsLgAw9Xi3A+hMgBTT7MRk2MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/T/fmebQmIS41+FUoOGQ88PcSAgSw3oyYFDih3llXK70vp6mu
	reIqKxfi2nwKRWJgd/VxQvUhO85riZlLoQpnRlfRShaVeBsOJ02M4VvvMnHSR2HA6aFJm5hh0/i
	lq4Fln2wQbwNZDm5fXAbTCMGt9AA=
X-Gm-Gg: ASbGncuuxS4VriXrQ5cikTHzRMiUhb58XOI5vKRs1XB3x9naqrgU7EpPqzAkqKkAQsd
	KL2ktdO7nxp7j655rN/F5RgcNiBrnJ4OR73YlmtyhygrD+T/dljL/7bh4+okUkB48e0e9o5CHUg
	QZGVunGKR13L1CH2HfcggDPMEkDuS90q1w+96/j56zuoou6+YJylevqA==
X-Google-Smtp-Source: AGHT+IHH41fMWydFveMjGe38nRfg0evaHGrSMA6Y3pw+faugYwOHHR1JZX2YIXsz0/iuICTlZ1CRPMiRfMuUnr0LUIo=
X-Received: by 2002:a05:6402:5112:b0:5ed:bab5:3093 with SMTP id
 4fb4d7f45d1cf-5f839b24397mr3432394a12.16.1745939579309; Tue, 29 Apr 2025
 08:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250414160343.2216312-4-christian.couder@gmail.com> <xmqq34eapfhk.fsf@gitster.g>
 <aAdr2Q9jthNV699i@pks.im>
In-Reply-To: <aAdr2Q9jthNV699i@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 29 Apr 2025 17:12:46 +0200
X-Gm-Features: ATxdqUHCPZvGBfaAFxWYEhbgECJC8SDff03gO27fhDLl--SL2y8Kt7JEyPsuU2I
Message-ID: <CAP8UFD0UzX1-WsLzo0R6mND_dTpF6hPgD97Wvg4h3fqXO5-Bmg@mail.gmail.com>
Subject: Re: [PATCH 3/4] promisor-remote: allow a server to advertise extra fields
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:13=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:

> I agree that we should properly specify which fields are accepted and
> what their respective format as well as semantics would be. Otherwise,
> without such a definition, hosting sites may eventually end up with
> slightly incompatible semantics. I also don't expect that there should
> be all that many fields.

Yeah, I have done that in the next version where only
"partialCloneFilter" and "token" are accepted and are documented.

> This raises a question though: what would happen if a field was
> advertised that the client doesn't understand? Should the client simply
> ignore such a field?

Yes, for backward compatibility we need them to ignore fields they
don't understand.

> Should they bail out?

No, this would prevent clients that are a bit old but could work with
a server to just not be able to work anymore as soon as the server
tries new features.

> I think we need to also think
> about this edge case and specify client-side behaviour. I think in the
> end, both ways would be rather limiting:
>
>   - If we simply ignored all unknown fields our hands might be bound if
>     we ever had to introduce changes that aren't backwards compatible.

Yeah, but that still leaves backward compatible changes as OK.

>   - If we always bail out on an unknown field our hands would be bound
>     equally, as we cannot ever introduce a new field.

Yeah, that's worse.

> Which raises the question whether we need to be able to dynamically
> figure out fields. This could be in the form of capability negotiation
> or protocol versions.

There is no real negotiation. The server advertises some remotes and
associated fields, and the client just accepts some of these remotes
or not. We would need a separate protocol capability if we wanted a
real capability negotiation.

> But in any case, I think we need to have something
> ready so that we can change behaviour depending on which features are
> supported by a client.

If the client ignores fields it doesn't know, a server can provide
both some fields for old clients and new fields for new clients. Then
the client itself will be able to use what looks best for itself.
