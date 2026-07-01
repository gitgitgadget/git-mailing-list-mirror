Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86533A1A3F
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898711; cv=none; b=WI0urieUFi/4hxnc6T2Sf7AAGULg4yyfwOhgOcXV0i7Xe7B0S9J3Pdz8y52P5X6Pg34HyO6mYppv8bpsBcrd83K4AIQAk18wQ0SzyWTz69MLysCVYRyAkzKhCptfyomawWQRPLtHjB6PD1ryqLZp0QzGGQhsXYkchC7SuQ04DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898711; c=relaxed/simple;
	bh=kxH/AsGaVqlqFuIiAUoxDkQn6xSUcf+cVi5PCADk70g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz2xgxb/2C8cFkUMuHsnIRlWCSe5pN2aHPjyoXYbJJ+krPZHH21jaOuD95N/z+ySBk0qQg6U6RjCzxLP12lAF6BplYCpqzsTh5mzOBBdW3xvIEaWezvAkJPvVfLsZReau71EkHsYYFdbEAUSVY7v++o2MpNRx8GehdtvHKBB/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=k0XtUnMY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="k0XtUnMY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45fd464d51fso203077f8f.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782898707; x=1783503507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMpApZIevpB9KN3HZJ94htM/pMsk//HOnR9ilTJTRH0=;
        b=k0XtUnMYVgv+nQ5vfxxQ0I2/4KGjsAp5/Pjl9poCoJm8GZY9chQl0TXI3JtAOCBW70
         2MlMxg8gMunwdJbg0V5tR/qcjyY4+KzAQs0VaVsU7E9HnLUOytlbI8b+I9lSZdMRDDP4
         xC8alpBLx7rFOk4mV9mYzA0lSVksOFpCrD1K4lwhI5V5nZQr6C4vzn10UHOVXeUXufF9
         M4MmYZc1f453LHpSxX85GCUGnmuV3esh0bAlIcOTYWEFoh9PkXEFwu92lLJ7h+TaEJLq
         wFTA+6eRnfXww3P6r1Z5kvsMYBLcrrSNA5yw07u1nQRJ7Dq+pXQNBsFGSZwowK+Jt8u3
         x7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898707; x=1783503507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMpApZIevpB9KN3HZJ94htM/pMsk//HOnR9ilTJTRH0=;
        b=DSJByvYLF11T82eEeifjV33v2jah/zpqIA2J+uIOjkVIMpGFilq1CS8dVYxSauuRNK
         pItqHdel3Z88u+sDlgahU8JyyB4eJ3QyIUBWGbnFzqQvT88ExKT+KOllTmy+Dp2FfRP+
         QDGUyLcNYhNG6OgPNv5R4t9ACruoym/VmRBTMpWLCtxiRdcTb+uia4EjWb8vcq2+EOML
         KH8x0Lb09FsD6ANUZi0kk+K1S7k+hhfbTi+Afg5hUw5zwdGgsjG9KrtrzCac3b4uBUMY
         rFulMTUcff+z0c5EM5eSCP+iJnyIV8pD2P+DE1hcOsb0CHYoYSuaQVq+Jsi9m063z4Eq
         yi/g==
X-Gm-Message-State: AOJu0YwMgHQjjr1cMWUq8btb8C7vmXwzimUA24/kWm5D2MofrH8IlUZE
	0kfsLwtuo4qk2OTvPa/N5MWJtqG1h5hSZZOdrMxyie1tQVbStZat/IiOwpacNra1qhQ=
X-Gm-Gg: AfdE7cmUaCDr0cMMZyYD7bmGwz/Qspsw40ap0yeeOWJD1/GxhI7lbZtdyfORHlNKzYC
	xU+LVp1gMj1o4WXDlzcHLtvVktdEg8gIyJStKD8yuXc+q3+GuWJDMJSuFtncBk5DL9CA80hE8xQ
	hf+935OlwWZm0Sqjy+qwYTf39kZ9iBikFaGP8lMUrWEjmoHkOm5bD9u58oqaJxrksWhHERIOVu2
	EbgvQYGwVipjOCJTRxslknmNQPF7eDJCHlP290cfwMPg6OZXTfrLCSB9bxrUAuy+UA65X4gq/we
	faxuH4Fsyvt124Ua0+3C4yVoo2GgHIDxWm+EH5fZ7VcMszs9LNL0V7AkJPsGbW+HsBTkCnvPulG
	Y6w65Xw5eygUfSRdGN44Z+2BoRUPkSZ8NAex26ctuCmDoIbq6sWlK4VZl3oCk8sccOORcLhAi+W
	ht86Nj0tA6oOrU72qV/4sY+9lXjXX3YhvmbbR6JW/1ihYXlepo2LfNsQu8Dn584otpdnoSCeXK+
	3nnvP/QbTWYUwY=
X-Received: by 2002:a05:6000:2f88:b0:466:6ed8:1e1b with SMTP id ffacd0b85a97d-4775798c679mr1482654f8f.21.1782898707081;
        Wed, 01 Jul 2026 02:38:27 -0700 (PDT)
Received: from localhost (p200300f65f47db046ba1718111b88cfd.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6ba1:7181:11b8:8cfd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-475641e4cdesm16540744f8f.13.2026.07.01.02.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:38:26 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:38:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
Message-ID: <akSuP-IWiH2wPd6S@monoceros>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izutlaebnxcpe5pa"
Content-Disposition: inline
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>


--izutlaebnxcpe5pa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
MIME-Version: 1.0

Hello Phillip,

thanks a lot for addressing this, very appreciated!

On Tue, Jun 30, 2026 at 04:28:50PM +0100, Phillip Wood wrote:
> On 19/06/2026 11:13, Phillip Wood wrote:
> > I'm happy to take this forward and try and fix at least some of the
> > other bugs I've listed above. Uwe - if I don't cc you on some patches
> > within the next couple of weeks please feel free to send a reminder.
>=20
> Here is the first batch that fixes the same problem as Uwe's patch. I've
> taken a slightly different approach that uses the return value from
> do_pick_commit() to signal that a commit was dropped rather than
> adding another function argument. That involves a number of preparatory
> patches, but they are hopefully reasonably small and easy to follow.
>=20
> If a commit gets dropped because its changes are already upstream
> then we should not record it as rewritten. As well as confusing any
> post-rewrite hooks this means we end up copying the notes from the
> dropped commit to the commit that was picked immediately before the
> one that was dropped.
>=20
> This series is structured as follows:
>=20
> Patch 1 restores some test coverage that was lost when the default
> rebase backend was changed.
>=20
> Patch 2 moves a function so it can be called without a forward
> declaration in Patch 11.
>=20
> Patches 3 & 4 fix the return value of do_pick_commit() when an external
> command fails (this is in preparation for patch 10).
>=20
> Patches 5-9 try and simplify the control flow in pick_one_commit()
> in preparation for patch 10.
>=20
> Patch 10 changes the return type of do_pick_commit() to an enum.
>=20
> Patch 11 adds a new member to the enum from patch 10 for commits that
> are dropped when they become empty and uses that to stop them from
> being recorded as rewritten.

With my very little knowledge about git internals, this looks
reasonable, and it behaves as I expect in my test case. I installed a
local=20

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

> Base-Commit: 6c3d7b73556db708feb3b16232fab1efc4353428

BTW, b4 didn't pick this up, for me it says:

	Base: not specified

(and I applied it on top of 2.55.0).

Best regards
Uwe

--izutlaebnxcpe5pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpE4A4ACgkQj4D7WH0S
/k5QyAf+OfwoMFl3N8Ts+LYgxSzLeWaL33EOxbYM70obvAcKmODWeHlOGQg3VgUH
QfQZvasBz92To5DVmKf7K1yeYfB43emlJxIyBUkSFh2AGM5pDmeoZVAhlRFqBN7u
ofKWjR69BJ3LzH40GTRU6+aynl5HhGQ4NGK3vF3LX9/3MBFShW+splUAuuiqbJr/
DxMLiaSUya5ePKvCu3NYLqyD0LuMvTUOUnw3MHZxItk8sOBIbEllbwIIBiK220M/
+O2/aXm7ScrL0l6Jh38rC6e7F70H/LHkpXt6SbVPXrVl8wG9p43ieUpztf5lChAd
u1LcGX6y8+0GTeTPo++9WrPrhmTlFw==
=ResI
-----END PGP SIGNATURE-----

--izutlaebnxcpe5pa--
