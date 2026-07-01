Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2791938F259
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885657; cv=none; b=YLSDkEikkjUnsu1F8Nl1BXnq8FSBx3j22tFW/TvOn4HusUzSx91rndYD7ZE6RWiC2S+krwJPb53uvyMGc5JDONyoOv9Sh5jmBqTRNhDNOHhM7QqMf0oGuNPTmFn49jKI0aTsVqZ419cYJJBiyhjnZG4gYW1u8z8R6nyzwtJmFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885657; c=relaxed/simple;
	bh=KAPXua6PL0wDD+0JdC+MxINoGEjMOfx9Ds2NwZa3zFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP0WbtDqiRGEaNwQncO0rfj4NanliQZt3hCS+hVF3fICv4HPfNXzv/I/1lJzBIpMFFDVXZAzyJ0hk/+QH/FWNBcdaiIrhfG8Auc467/Xa9M0/xOM/Okp4eVBewx4dvZ9wbOAMP23rBUCa/FcC3CSGi+nmJIUNggmA/Gy/qTJHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Fv9kLUZ0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Fv9kLUZ0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4939a809b24so2314905e9.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782885652; x=1783490452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YlQR8NzsKnQXgBQxLnJ0EpyP3/eGkpEI4sShZuDz3Q=;
        b=Fv9kLUZ09LAqxsgsIRVnh9HWHZs9sGpvUFM1LuHwP1XfHxXUQZ0o0mevG9UAzcjzlB
         fSkAPKvWVwIAPsIyXV1kN/OJiMKAHAho9YLKL95yY2sDizdbjsQQEgzSJx1UwV363UrU
         lpLP3PoaufBleXb3phVX7iXQPGMl1z6kVIFly/OKrfQq503T8rRV/Ap4SJ7gnw6CWRan
         g1tBRUuImQHdlaWgIyzPNyOyEdzHq2f5RerDZow764l/oEkfv25ayIxSyZcLaZ7cveNX
         fnI9kZmpTNoh9OSrZ2M0mnwWtbo77YJETJpzttV69j3ns+eEh2/VZLwxcS5eYNDv84Rz
         dc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885652; x=1783490452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YlQR8NzsKnQXgBQxLnJ0EpyP3/eGkpEI4sShZuDz3Q=;
        b=FxTZuJfPlOm+QVDQWDUSWpA+OzHmXUy7/jDqUYOMt/vDW6xsw9HQaMTpCsTRJZQyuC
         +ocZCSj9qwb/+tX3eiMqipXdFuJoIuufQozZGVcbuzVmUnQYlAPdJdBaoCLfALMRK1iR
         dhvJsOkI5xsaCAe3ZTKW4tsDXhGz8fMLED0isMz5Qf3/0luLKGgjnqRP4OLpp78VynTo
         RygC5Upj/PGHoEfLF5bAy9COjZHU1ZaiX0l7NSZYw+KtrbmfUnWSTdBAeQpXYRLlVmWQ
         mmk2PyPdfe2L7pcIb2op60f/YDbslDN64ORsaSXur7Ew5MaZTWjppEd/4f/F8vkNjGVS
         i5ig==
X-Forwarded-Encrypted: i=1; AFNElJ+UfYFBO5yD8Rtbpi3gBq0pH6LxOAko3fcz+zOyzALqfBHgxqS7WFVvBL9msK7TZ3ZryJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1jgdrJc/gYZ878SpJd2DikVWFye+jtLXmpSFBIen5MZjVfaU
	0dC8DqmWQzl9V2VoPairIs5wK7RodBfDMwT1iMw9A9WaDuGA0aUjc0eY7NpgJ//9ysU=
X-Gm-Gg: AfdE7ckCyHEIbUzJIsqJG87DJgBgW/PUYYXh08Qceolf/x/bxAAN0xjnQMmT+ly4OIn
	aOguGTcB4+SjLk8p/9pHpuEZJjeIolmqlHolyNHcCpYOgCpnAdIP+Y93gnyYjlTaT7lgYpJjPAP
	VJJF5Y0VzgcdsYiricllG6zvKqxyFCKyvO2auqHEPAUXyqzqkx20eAw9VCsB0gAgBznz0D5uuFV
	/r0UNg6LClvtNvRA4kpXBfNoOBLyTaJ6a6tYOGbsEbOtJBd4Enmoe6jhgnyhTddm7JsL2dX6HXv
	XfIieYzqik2NJetHfwXE3SF96upz3WNqlMO/wtkVYNla/MryGPp74u1VD6NFJt2ROFPYAjCNRct
	F7UvaFkJCPCrDv0UN5IEDwvkPI4puVU8mRDpCVBbEuw5+lusTIbVPHsi9maKS/fSgB0ccL0PKu2
	9WGrB7F5IrSlB+rSMBKwvqeRKwhM9YpCY5kE/cD8JHAuU+qD/lnVJkQla4nW0K5IhoXo/ap32dX
	2OU
X-Received: by 2002:a05:600c:3f07:b0:492:4a56:690b with SMTP id 5b1f17b1804b1-493c2b9e2a0mr1913865e9.35.1782885652428;
        Tue, 30 Jun 2026 23:00:52 -0700 (PDT)
Received: from localhost (p200300f65f47db04b57d767ea7d78287.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b57d:767e:a7d7:8287])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493be493c24sm33080865e9.0.2026.06.30.23.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:00:50 -0700 (PDT)
Date: Wed, 1 Jul 2026 08:00:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
Message-ID: <akSqjIzdvsjK0yoM@monoceros>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <xmqqpl17rec3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zvakimewljqpvvvy"
Content-Disposition: inline
In-Reply-To: <xmqqpl17rec3.fsf@gitster.g>


--zvakimewljqpvvvy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
MIME-Version: 1.0

Hello,

On Tue, Jun 30, 2026 at 12:57:32PM -0700, Junio C Hamano wrote:
> A tangent (I Cc'ed Konstantin for this), but
>=20
>     $ b4 am -o- '<cover.1782833268.git.phillip.wood@dunelm.org.uk>' >b4am=
=2Embx
>=20
> failed to produce a usable mailbox.  It somehow did not think [2/11]
> existed.

FTR: The mail is on lore.kernel.org.

Also to yield a usable mailbox my patch shouldn't be included.

> I manually examined the References and In-Reply-To headers
> of that particular message and compared them with those from other
> messages but did not find anything suspicious X-<.


>=20
> I have a bunch of typofixes queued on top of these 11 patches (made
> with "git commit --fixup reword:<sha1>"); please double check when
> you reroll after seeing more substantial reviews than mere typofixes,
> possibly from others.
>=20
> Thanks.
>=20
>=20
> Here is the transcript of failed b4 am invocation.
> ---- >8 ----
> Looking up https://lore.kernel.org/all/cover.1782833268.git.phillip.wood@=
dunelm.org.uk/
> Grabbing thread from lore.kernel.org/all/cover.1782833268.git.phillip.woo=
d@dunelm.org.uk/t.mbox.gz
> Analyzing 17 messages in the thread
> WARNING: duplicate messages found at index 1
>    Subject 1: sequencer: Skip copying notes for commits that disappear du=
ring rebase
>    Subject 2: t3400: restore coverage for note copying with apply backend
>   2 is not a reply... assume additional patch

I think here is the origin of the problem. It guesses that the t3400
should be added, and it takes the place of Phillip's second patch.

>   ERROR: missing [12/2]!

This is irritating, I would have expected "[2/12]" here?

	b4 am --no-parent cover.1782833268.git.phillip.wood@dunelm.org.uk

works fine for me.

Best regards
Uwe

--zvakimewljqpvvvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpErQ0ACgkQj4D7WH0S
/k7nkQgAp1ZQozcF2nob8nuFhPWMtHNUF77ikAnGFKuSv32CJm4HClOvHOmaBX+Y
yS6Ws2nK4iJFkM0ia+tsxvsVZ6LmW1ge8DCx9tR6RinlW68XKkxxE3ixK1pR0xun
oLg7sl1ZMchyyHj0t0DNh57/hiKZTkhyYKvUtbpGpBK2HfRLSGfsTtbDjGgKF05z
wYEVdMPLSHLb+Cxl/PDze/bHoT4i85KKXiagDUS56EOY4G5dFHrD2/MkgIRvWUgu
DrgPm9Sxf+Wlwll4jh7WE9tnuf5397CdSfaLyuCjyYexiLoA2GfMzT3h3fHNJeU7
5D0pMjw5abxq5HlK9pBKpSqQfKeRsA==
=QLuY
-----END PGP SIGNATURE-----

--zvakimewljqpvvvy--
