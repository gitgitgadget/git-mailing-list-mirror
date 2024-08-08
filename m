Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E9126F1E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118452; cv=none; b=gmy9xfuJyOmwE55Bms0S8cX34H3jZKmRZcch0KeIMEkxyuzycCMLKq+eE9NpXXkK7jbUcEapW19V+cULpcC8sx1G1Nx8kn+YFc9w1C8xT3qBUOrWHXordNEdlAse1yMj/67reV3+rzxc3HDmqXjnNDuy6cRAr1gYXU9UB9dmRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118452; c=relaxed/simple;
	bh=H2AJVfzU54n2z31Z9lud8+LNy21M2bTbEYGGLwIzWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJVNdfCQM4AFeTJjGMCPPMF3AkNuZhMbeGf5zdmIY4BA776N1l0S/6WuteMNAmqFd1e54lpUyDRGTeZnpWV1p6NUkU3Ilz6aZoi1nJZxKxd0j8ag0BWgQX7qOr7FKS93LnEJSYCGeTjudouLYjlgmw0OYF1nmD7aOQw/kdD8AFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NWASE1fa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jy0aC0WW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NWASE1fa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jy0aC0WW"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5FECC1151B20;
	Thu,  8 Aug 2024 08:00:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 08:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723118449; x=1723204849; bh=vwB8ifvtAL
	za1wthNILJ2AE8ZwZFBAmKNh7cHAiiqBg=; b=NWASE1fa0x+H4k8utGse3HLEcI
	GYK00kfi/sYsZvTWOPYQSBTf/3ZxHoc+yGwAXntRy7cvHu29oUkP7P3qIVnAeBC9
	YSL92L1jizRbXg/eLcGqYkd6LbpEPjvO5PJhV7CrQ0ZvTCOKuX50e6C6F0BIsOBW
	3GP0iB+ae2VX1u9xpx9HPhYF9PvbUBQ63n81vSZXAGRMu7UkTkwcYjLSsS9nB6Ud
	ilOrelUcf1bL7Msmei/rKvTDpgJ+UtdUXliB4/9h3jZCdMKiLT3ujNPoe/PglIhw
	Rxcajru+CDVvwUxK0iyaVDqSoAKxl/B5xD/wG/EPBPAj1BCmAbo0KQnW9vHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723118449; x=1723204849; bh=vwB8ifvtALza1wthNILJ2AE8ZwZF
	BAmKNh7cHAiiqBg=; b=Jy0aC0WWGq1GvSpmd6QmtHh8Qv+oE2Zl81Em60SEOfH2
	QEVK+62iGSuOB4LUwElJEJtsj33MsR8DBRsHO7ADtZYu/yG/ctMha3Vsg5B0/m5X
	Pd25djzRtZoXrK3ZIcXKrDm/9itmIf4ShIj0Y0foRFiOTi43l2WWXC0V4oFYkfDR
	FBExHKiXkuZvOHm3rYjCOzbqUKmmdZQk1IosOvtLuh7BFGfqCc+21IJ1fDOU5+MD
	f5EXB8bC+08SP8BbzXLfVwX1xACRIXg6RcF0lZp3anqwTlNOVIXEI8hAHBRq78oM
	US1JgaRzik1YsAnvk1H7jc0PhP3gY4kkRG0W56x4/g==
X-ME-Sender: <xms:cbO0Zl2Y-9ICyGRg5QUhWiKwzMpXRrQX8-dqLA5DfPWdIGr2FLHQsw>
    <xme:cbO0ZsGJtUOg13RP8vY8T9yHI2UbBgNR1vdHirvt4icBQKFvMLUoYeKmFhc66ndxw
    SHDQG6GDxzCfncVzQ>
X-ME-Received: <xmr:cbO0Zl5lW0GNYOyjdecSmvh65ZvwA3EU6MV3I_d5n3n1cZ4s0cIZnhAsgGqNsaC1r1QIENlW7UtA0JO7UZTnot6HzNnk1hNqPU2HaN6vd0slSc-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevieeuteeljeefheffjefgkeelieejieelhfehffejteef
    leehjefgkeeljeekudenucffohhmrghinhepuhhpuggrthgvrdhnvgifpdhuphgurghtvg
    drnhgrmhgvpdhuphgurghtvgdrvghmrghilhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:cbO0Zi0JiCxOQf8FNpXORt3RpzNSjRhahyynb5PljBJGTw5aSxiVRQ>
    <xmx:cbO0ZoEa6uXurN2h6o5S0qaTvKslL520IxPnOIwKRSwtu7-hUrAwoQ>
    <xmx:cbO0Zj_LTwY4PWjZPKjndEYRNfqsU7O7aiCGDsFnQWEM7mulj8FcgQ>
    <xmx:cbO0Zlm1RdObLsudKVpgOmXY84Lk75yKkvvjtNBKHoXSE8UHhZ4I_w>
    <xmx:cbO0ZsC5SMYmDGNRCZCRwQjJh84KrG-o5o5WbbSJvX7gHppmTwYeYiXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 08:00:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 71cc1012 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 12:00:40 +0000 (UTC)
Date: Thu, 8 Aug 2024 14:00:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/5] t-reftable-readwrite: add tests for print functions
Message-ID: <ZrSzbdNkCS2LOXaL@tanuki>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240807141608.4524-6-chandrapratap3519@gmail.com>
 <ZrR91dR3G06L9dy7@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IcPu3a0+6SGUyA/L"
Content-Disposition: inline
In-Reply-To: <ZrR91dR3G06L9dy7@tanuki>


--IcPu3a0+6SGUyA/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 10:12:07AM +0200, Patrick Steinhardt wrote:
> On Wed, Aug 07, 2024 at 07:42:01PM +0530, Chandra Pratap wrote:
> > +static void t_table_print(void)
> > +{
> > +	char name[100];
> > +	struct reftable_write_options opts =3D {
> > +		.block_size =3D 512,
> > +		.hash_id =3D GIT_SHA1_FORMAT_ID,
> > +	};
> > +	struct reftable_ref_record ref =3D { 0 };
> > +	struct reftable_log_record log =3D { 0 };
> > +	struct reftable_writer *w =3D NULL;
> > +	struct tempfile *tmp =3D NULL;
> > +	size_t i, N =3D 3;
> > +	int n, fd;
> > +
> > +	xsnprintf(name, sizeof(name), "t-reftable-readwrite-%d-XXXXXX", __LIN=
E__);
>=20
> Is it really required to include the line number in this file? This
> feels unnecessarily defensive to me as `mks_tempfile_t()` should already
> make sure that we get a unique filename. So if we drop that, we could
> skip this call to `xsnprintf()`.
>=20
> > +	tmp =3D mks_tempfile_t(name);
> > +	fd =3D get_tempfile_fd(tmp);
> > +	w =3D reftable_new_writer(&fd_write, &fd_flush, &fd, &opts);
> > +	reftable_writer_set_limits(w, 0, update_index);
> > +
> > +	for (i =3D 0; i < N; i++) {
> > +		xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintma=
x_t)i);
> > +		ref.refname =3D name;
> > +		ref.update_index =3D i;
> > +		ref.value_type =3D REFTABLE_REF_VAL1;
> > +		set_test_hash(ref.value.val1, i);
> > +
> > +		n =3D reftable_writer_add_ref(w, &ref);
> > +		check_int(n, =3D=3D, 0);
> > +	}
> > +
> > +	for (i =3D 0; i < N; i++) {
> > +		xsnprintf(name, sizeof(name), "refs/heads/branch%02"PRIuMAX, (uintma=
x_t)i);
> > +		log.refname =3D name;
> > +		log.update_index =3D i;
> > +		log.value_type =3D REFTABLE_LOG_UPDATE;
> > +		set_test_hash(log.value.update.new_hash, i);
> > +		log.value.update.name =3D (char *) "John Doe";
> > +		log.value.update.email =3D (char *) "johndoe@anon.org";
> > +		log.value.update.time =3D 0x6673e5b9;
> > +		log.value.update.message =3D (char *) "message";
> > +
> > +		n =3D reftable_writer_add_log(w, &log);
> > +		check_int(n, =3D=3D, 0);
> > +	}
> > +
> > +	n =3D reftable_writer_close(w);
> > +	check_int(n, =3D=3D, 0);
> > +
> > +	test_msg("testing printing functionality:");
>=20
> Is it intentionally that this line still exists? If so, I think it
> really only causes unnecessary noise and should rather be dropped.
>=20
> > +	n =3D reftable_reader_print_file(tmp->filename.buf);
> > +	check_int(n, =3D=3D, 0);
>=20
> Wait, doesn't this print to stdout? I don't think it is a good idea to
> exercise the function as-is. For one, it would pollute stdout with data
> that we shouldn't care about. Second, it doesn't verify that the result
> is actually what we expect.
>=20
> I can see two options:
>=20
>   1. Refactor these interfaces such that they take a file descriptor as
>      input that they are writing to. This would allow us to exercise
>      that the output is correct.
>=20
>   2. Rip out this function. I don't think this functionality should be
>      part of the library in the first place, and it really only exists
>      because of "reftable/dump.c".
>=20
> I think the latter is the better option. The functionality exists to
> drive `cmd__dump_reftable()` in our reftable test helper. We should
> likely make the whole implementation of this an internal implementation
> detail and not expose it.

For the record: I've got a bigger patch series in development that drops
the generic reftable interfaces. As part of this, I'll also rip out the
functionality provided by "reftabel/dump.c".

Patrick

--IcPu3a0+6SGUyA/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0s2wACgkQVbJhu7ck
PpStGA//XX/DGxlcgoHeCRL0NTLJguG8KvGuN2sEWlzG65oI8fxtYtBioa5MGJn+
LttyfHKCxhioLidJL41YOPAeUely41kUSzXFad5KFsKzzbgKWVuZtJ7CdkknL8cb
hJ78EzEPif/TvJhCRlgG97hmHTjEJaGzHldAulGIna8hxfbMtBqakJLj6OmKwCiH
NFm3rSmeazQFHfGsiMMuQMm4KSHP8JSwy+WnpRmxzYrUINMCcQbnssq8YY6max5c
qA9B6vHyvpspeVNL40LA+uqJu47dN/4mAnVFNkULICbNg7M0GM0QYrUetHZ/9ux6
RMxQbXyZRfZo2cRQpuBWlMJI/nBV18YGIXZQhUNXE+Yi8h3NZyq6aFj1wWE/GFsq
qdhKktlSH/OoHvGgmQ4muxD9KZC3uVZkZGVtzAmNiemQE90mS1D0VxzvhcWphTNX
3n92Dt+dk5T96UoSj1+dTYZQjmmPtxsAnFeHsJEaVnkzNahPf0IuaOZ4DZh7t/ot
xfzKbq+iEvFbeJjzOgQOILOQ3z1b7Q4ampfiqMJB/SHM4Kjq/zdwNxaiKPrxcXLo
d+/IRCOgwxfH4ZbF84M03VmJTz+mFZ1PUV2+UPJy0uR6PsZTyg161DiEJcpTSS/s
s7lLxrNYy1SyvUS77oGftr1ODClwFYvZAN4otmjwR49/pritzF8=
=Ozsn
-----END PGP SIGNATURE-----

--IcPu3a0+6SGUyA/L--
