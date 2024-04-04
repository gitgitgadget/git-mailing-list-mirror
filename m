Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976E1CD3C
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215976; cv=none; b=jqElcR8xrFTLofV1SG7fUHzwlx4Do6u1Nb3b0+yA1m8mnylCRrnWk7ZEgN3ClKduZETTKeIZbCqrBTUhJUCVXGm232EO54+sghCP63jer+ZEKB1uLz0BJcXev0BJDMibCrNTlDpIv9fjV8ifp/ObfbMZdmmx4Rurjazxu8ZYXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215976; c=relaxed/simple;
	bh=rVSXXaK5khbICr0CjeO7lxDEfMdSghZOcv29ravLdmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZzNqIU5JzOPD66FCEQXq/uOxEq0EYUI91P4FJZS10c18riHbtlu7082eFON+b9H4AAC2lhSBKJeiWyEFv5GMYKJo3WWQBP448Vf433sOdT/b3tapgl+U9ODld6KVD2Jqnz2fpQ+beZg3iEvtjGpPRvnR1sfUa9e+MT8VsXAFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ByYIO9Kg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=alNsAMqQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ByYIO9Kg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alNsAMqQ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B9CC811400E8;
	Thu,  4 Apr 2024 03:32:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 03:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712215973; x=1712302373; bh=HUcvxQ8ZoP
	hzn27u2d3QM7vXI2ed8kxkCQgfUPXUums=; b=ByYIO9KgS7pvpV92mIN0Nm3fBF
	uj+F0tPutbDec4nS6KEW3+w5sShPJy3DLoggeYui/3i4qCTapjXKqXhJGv8pv/XV
	XovHsCl3PF5IzzerAj38nsmWArXelAZf0IrXmr7MMqeQep59JwAzhwH1jIVRCLS3
	0yNxPTLw6n72qmwer1NQ0a4Mf/6R4RfbDZnAUT7kVAoC2l+5GtyS6cxoL1TJEjby
	wMqjZWsPBo+dRqnHaAudXlmiZ5/GZnWsmBCCBacqHuwRtMnfYe/kv0/IWFIgFn4d
	k6FvyY9K37C3VVJDnqNTQ4DWDGIOf89C6+6gLuhw5/SliYI1pu2+Xh4mDIxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712215973; x=1712302373; bh=HUcvxQ8ZoPhzn27u2d3QM7vXI2ed
	8kxkCQgfUPXUums=; b=alNsAMqQIH0jR14DONIapIadeBqOc6QGj+4sNPIHhV9x
	f/fbCm2nBCtVph75RjmqX44BjK2FQVGR+0nwZKB1QaFdtdoS+deNVyOWwSMGv4zy
	dziGaTg+ciaLrFsm64Kb1pwlqWAA+G6FF5zoJ5DTZaUlXvnkn77c3BBwpaH5jaJy
	MZMkilcaep6dT8ZDLhLx/zwmN2aHdK+kn7SNyhUvTvR9Wt/t+0CZCkZXH1eWHJEf
	sg8bgDUaPYaSLbzLcJiZAnqMEj7BoaIKVfFzbMRHZwDPYetlxXYaGTRSeyueFTz9
	LAa8e81fz9deWHmKFz47LJifNTbQL+pSk2tZVTKiuw==
X-ME-Sender: <xms:pVcOZgkOdMhdW13ieNZgWdDnj_vhYkLNjZgqpRaH2V7IkK1kYqqH3A>
    <xme:pVcOZv0rSKSGFWrWYvFoJcTlnvDAgC4vKcV-VI9q4tW-EdoYNNYYoFvAKhKbSz1nF
    QUz3T60xu1c2CUzRA>
X-ME-Received: <xmr:pVcOZupg3LRdxpeqWlsSs8XlJoRzpYiiaq08XYBohGuhAA6k--7J2vC2-emFr6jBxCdEnk6e4QI9G4h7wnoZnHcOw7K33zZN77k3AxrIdP3AW1J3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pVcOZsnrgonwx_Zgahh8e02C3AYa_Ggrd2_omX2xk5T9T165quEqNw>
    <xmx:pVcOZu2-JBT3IGXCwhvwenIkBVgp3z7Suv16-nt4jy_7Xq0c5A1GwA>
    <xmx:pVcOZjvVkKDlIPxbimx6JJpEG10Jnfht_LvWfWTaJanEciLB31ezpA>
    <xmx:pVcOZqVdP6xbL3FTd_Ycv98UQkd6BMzUm6zQPF4PcoAC9HLH4EG0Kg>
    <xmx:pVcOZhQcH-g9FEoZskUFC85jSDFvEnW-K6Vx_xNV6MmpqjHgwrnEvP7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 03:32:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5ee6e3f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 07:32:49 +0000 (UTC)
Date: Thu, 4 Apr 2024 09:32:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/11] reftable/writer: unify releasing memory
Message-ID: <Zg5Xorz75NMRqONI@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
 <41db7414e17201f85b476af5e0183e72de450310.1712209149.git.ps@pks.im>
 <CAOw_e7aBPF1vPvF7iYXCM5VBQu-Nw00dO2pRC_6DU3PtdDUsbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GfWZWrvgCPbFhJJH"
Content-Disposition: inline
In-Reply-To: <CAOw_e7aBPF1vPvF7iYXCM5VBQu-Nw00dO2pRC_6DU3PtdDUsbg@mail.gmail.com>


--GfWZWrvgCPbFhJJH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 09:08:46AM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > There are two code paths which release memory of the reftable writer:
> >
> >   - `reftable_writer_close()` releases internal state after it has
> >     written data.
> >
> >   - `reftable_writer_free()` releases the block that was written to and
> >     the writer itself.
>=20
> The bifurcation is there so you can read the stats after closing the
> writer. The new method makes it harder to misuse, but now you have two
> ways to end a writer. Suggestion: drop reftable_writer_{free,close}
> from reftable-writer.h (rename to remove the reftable_ prefix because
> they are no longer considered public) and find another way to read out
> the stats. Either pass an optional reftable_writer_stats into the
> construction of the writer, return the stats from the close function,
> or drop stats altogether.  IIRC They are only used in the unit tests.

But even with these refactorings the stats remain intact after calling
`reftable_writer_close()` or `reftable_writer_release()`, right? So it
basically continues to work as expected.

It might not be the cleanest way to handle this, but I think this patch
is an improvement over the previous state because we plug a memory leak
and deduplicate the cleanup logic. So I would suggest to defer your
proposed refactorings to a later point, if you're okay with that.

Thanks!

Patrick

--GfWZWrvgCPbFhJJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOV6EACgkQVbJhu7ck
PpTnaA//SPuo6Ehd/S3VnEz9R5N6SwGogXQR8D/4oRnif5RPsb+tLMtvXt+rcrEt
SAaWWOI/JJIUWEo7BXQ3BXPR0L8WVP32mT+60AFOKcDqfGJ86A2mgVFbGf4bvi4Q
A/RxzkS9WD9wglO3qly68fRAXVKzohnwLSPOMGXHcrWJWovPHkdfsvc619HZmfeM
5WBxigDxOi4rckGd6Kxc3nTHVDIaYofa79QhxWR4EuWivHDSnVRzIin4goDsT7jy
JFK8kPhXHKbRe5/DOD+9bj2QlcYt5bIPaL5YVcXmWhDvuXV2HqhwVl1qo+s6xnqM
mPWFHiyiZDQEjkqT0756UAs6xp004P7RYfDxJmioRDjcpW4AAdkfOUaJ7evINTYZ
JpDEnQqoFbgdSZb1epllW7aSu6oIbDGxo+7Uf2Yk2xwSV6B0GQJtY8q5To77GleW
oBwjDCfXjO7N4REM4ABadCkqZ4kCoI8Qj/P9DPMu5xb/9yk4Fg3fmoSFBJBfJ/+C
z3Hu4UNwkiSdrS0yfavINTmqvjfZ6VhNC6Og7E27wr53VUodqN0fM8ftSvwluOCc
PFs+TZ+3SxBx7X6S1GDMEm/iyd4BkdSMZAFMkDD7N3kNOb7mZYMRf5l/+qU9TVRt
xSJYK21J4CvTycWtfPJqRwRnPLxDBTgV4UxRTJSVST0K5/TeOSg=
=0F/N
-----END PGP SIGNATURE-----

--GfWZWrvgCPbFhJJH--
