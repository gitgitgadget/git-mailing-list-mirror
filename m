Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038AD30E853
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061834; cv=none; b=CyLeUkGpXgjdydpH/nOR26kREBfsS0Cpl27UkcbcQMC5pQmaNwVGEgL80N+gNtXaO7ovFwRIwyod3UPZovm4Dtoe5R1njIujjJnH3CZNfGUJQOHJMn8Enw+WLjXXiU/dB6ZcIQEXgJeOk/wkBzeOpXUgfIg4PCcIV/bFgiXE7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061834; c=relaxed/simple;
	bh=APxcoZeh/k7garK03FlzxDvWwamkT7HYSwGqUcWGbHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0omMzRVtKW/exUN9woq+nL2XMYJ1xTALlMXoEfHRQnm537NmTEvj/OTA5wZ90pkR6j9onDpZUykScBVIjCR2SKOkhGvhLeOWFTQeAeXhCnW0gLu3qiMEWTILmZ/xKf7+rZZTYxWnqs04HCSttaFc5/Hj7EDXvqsMBUFidR1wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=epD6fqRv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="epD6fqRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777061831;
	bh=APxcoZeh/k7garK03FlzxDvWwamkT7HYSwGqUcWGbHg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=epD6fqRv/Vnaqsfwpu2wui4b/Nv45qHHpASYe228iaViyQfE+eVTzNcBIhcPSBQOp
	 83fCpa0E2MOvdXvyV5Km8P/VjhcJchRwvGRjEoY1XTgk2YnAvt3PV3Uz0di+JBsF1Y
	 2tSrCQS8WYaZaqQCVMWvU995XFp0FpGZuIvzqjTE0K/iGHSeeqRPgzuUAR7FA+Jk7k
	 mHDMMmf4KSsfPk8lv4u1Vr1teK4U3h1wbLMck0c7GUjeVxdUgSyZfc4C6KI3D9JMET
	 6S7yoH6OlQpuzTYCiV6nJro4se6qOtNF/9q60Xgs4DToa9BEJMbbIdfZZPa+R0Cl7o
	 JGSOCQrcRmGLmjxZG+uoJQGq5eZqX/Qy1N5+OVE7fNKJZLVckMriFAARggfzVQKsd7
	 pbeBoKqyfjuog0KZcSYIDUEumUwLxEK3xp7z/+O9qeV2mUvXLiEElsKqcb9ORdABcp
	 wmmOAxcgwNstpr4VrJs6KvUIfGIvDcoNadvsGgMh4KzLnsLAQxA
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:55cc:40d2:74ee:685e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EE5F62006D;
	Fri, 24 Apr 2026 20:17:11 +0000 (UTC)
Date: Fri, 24 Apr 2026 20:17:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kushal Das <kushal@sunet.se>
Subject: Re: [PATCH 2/2] commit: sign commit after mutating buffer
Message-ID: <aevPxrN3xWq8SP71@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Kushal Das <kushal@sunet.se>
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
 <20260420221425.2763661-1-sandals@crustytoothpaste.net>
 <20260420221425.2763661-2-sandals@crustytoothpaste.net>
 <CABPp-BEd9saiMWVdcSaZBHqGreshpA=fGZc4AvYkoU=swSSuxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpyDT7E1ZwOtF8df"
Content-Disposition: inline
In-Reply-To: <CABPp-BEd9saiMWVdcSaZBHqGreshpA=fGZc4AvYkoU=swSSuxA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--rpyDT7E1ZwOtF8df
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-22 at 15:10:29, Elijah Newren wrote:
> On Mon, Apr 20, 2026 at 3:14=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/commit.c b/commit.c
> > index 790dd2faed..bc41859be1 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -1747,6 +1747,11 @@ int commit_tree_extended(const char *msg, size_t=
 msg_len,
> >                 oidcpy(&parent_buf[i++], &p->item->object.oid);
> >
> >         write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, npar=
ents, author, committer, extra);
> > +
> > +       /* And check the encoding. */
> > +       if (encoding_is_utf8 && !ensure_utf8(&buffer))
> > +               fprintf(stderr, _(commit_utf8_warn));
> > +
> >         if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
> >                                        SIGN_BUFFER_USE_DEFAULT_KEY)) {
> >                 result =3D -1;
> > @@ -1780,6 +1785,9 @@ int commit_tree_extended(const char *msg, size_t =
msg_len,
> >                 free_commit_extra_headers(compat_extra);
> >                 free(mapped_parents);
> >
> > +               if (encoding_is_utf8 && !ensure_utf8(&compat_buffer))
> > +                       fprintf(stderr, _(commit_utf8_warn));
> > +
>=20
> So the users might see "commit message did not conform to UTF-8..."
> twice? (Isn't compat_buffer likely to have invalid UTF-8 whenever
> buffer does?)  Do we want to avoid that double printing?

Yeah, I'll fix that in v2.

> Did the change in this patch also fix a short-circuiting error?
> Previously, when both buffers had invalid UTF-8, we'd only call
> ensure_utf8() on the first one and fix it, and then short-circuit and
> not handle compat_buffer, right?

I believe it did, yes.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--rpyDT7E1ZwOtF8df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmnrz8YJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0QR1YMUPZPWUO8B/Qeo1laH5de+6qUy4kfvJAnOp8Bq
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADwhAP93QMFEcdf2h0vTM6C+JcP/+GaH
8dDv3rW8bq3ekT76ZAEAhuFujRgS2rYUKGBklLn+9LL3W8XjxHHq3fCDkfTmqwY=
=9VSy
-----END PGP SIGNATURE-----

--rpyDT7E1ZwOtF8df--
