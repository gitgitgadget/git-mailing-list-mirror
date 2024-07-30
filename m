Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9660195B18
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328289; cv=none; b=KordjsXrlTmvWiObj/tyGJHRRSkzTKh0mpdVpbP8N4tILixHkxmNxCJc5U8EPedwK0ovhPHRpsY6Lwzw3ZIh57rjjSJihRxC1ikZuilD9Ffjmipg1IP0DkBGKKpXvQKVVKRPcB4vKgwP142tttL9D/EHPmeRrmy0r4jZmU0tct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328289; c=relaxed/simple;
	bh=rmnxsXAdTYQxCh6Nh984hFNIX2orXm+gcqKJdHkqHkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INYhv+MRwXJwow4EiBqpvlW/Yh7vrzJ1zXb3ErzkHRxIq6eyaZlvr7WYUUk690LpdNP+N85dT9Hob9hWl/AVyHgBjvcLZxkmFHYd/mT1nA6+VEcZFghsBUaO3GsPZB6Q/sJ+0I6Ks0ik4WaXa7NT4fUpa6JIdKThOC1pL6WHomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GhxBZdB4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYHigwXY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GhxBZdB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYHigwXY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id A89D713807AF;
	Tue, 30 Jul 2024 04:31:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 30 Jul 2024 04:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328286; x=1722414686; bh=rmnxsXAdTY
	QxCh6Nh984hFNIX2orXm+gcqKJdHkqHkM=; b=GhxBZdB4/oD9JwiNhT50k8ybuK
	FhDJon3TsAZLpbFoLQHFrXOV5960OJvSqZ/HEQgnAyh8FQ76Ws4nGuBwv33pdIaS
	4Ilv7egmb9D07ArsKz/kyXFjIszEIunrkMkTJaEPMAXkApPT1hPy7U8aC9Z6lnxd
	qQlGvsrfRxJV7HEeW6LKO023C/XCHMPIz4iA1/FSIsf7FvsMHQahzovOFeDW8h6/
	cEyW46+p0NAwzl5qLWR6DDmdkjPOWyRQdLeWBCv08tqjq7diTM8AFsZCCHdTJwNQ
	DUC+hVTOEMU9lElGCmr5i2OeGZXYMyZ1Wy9Phz2A72R5e2+f0bfq2jmXyv1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328286; x=1722414686; bh=rmnxsXAdTYQxCh6Nh984hFNIX2or
	Xm+gcqKJdHkqHkM=; b=WYHigwXYcLPfMRfkZSC41tcmEwUcOIpBAlwyjS8UzM39
	Gy/FTntaqrXkd6Mp4ct97HQRxvC6EZ0YngwD2qzLXliUJvZPeGgFLzh5O76hDWIr
	BVhG+dhXLDeCR1Zl3baRlYP+e/CQveHCZHV+V1hFhOEk6kt+9r2QO7dO8/yYbjCa
	PxkukT7ijwcQ1s/Q5HRT6bW60ZT3E92AZC2OkWR2ozyEp4zNMxi7XKxZtjlFKYXh
	QNV1hPdHVGwelQRtNa5VKZ7zaBMfbngPUvH6Ji8lPqikLdFAkKXDGHU7QJdTzaaC
	sVW138friqagczMENxG53j8ZC2bakFEmBOyclDBEoQ==
X-ME-Sender: <xms:3qSoZmVXRj3Tgx0J2LajNWLdDZwcFbDQDNJcZIHeR4bj_vHPC28YIQ>
    <xme:3qSoZikQirjNt2dr-NVBT4KHKaj1EdqLmOTLHu2kUTtnL974ZBStKPGoLco1A2Maf
    dyy4prZx549fkGTDw>
X-ME-Received: <xmr:3qSoZqYPegjNCIBzomQRt2SYOiMoTUYAuGPGIb2DULmsMr6MciTALfonM_SD0-cGIxFu-CDMflVpmFx4sGsLikRTT30g5BAQ2SirRZenj87pr20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:3qSoZtU58-vnGXJ9ZAmSJqmr9JXD8_89iVO6iJ_DVgJxrilMOpffFQ>
    <xmx:3qSoZgnCJD-6t58ieSGeltEsc3Twlxp5WOgGntl2Eu2Ks23pkaVsUw>
    <xmx:3qSoZidQLRgiD0qF4oVaBJCPHE8Pdw23GvLN8Uy4F6HnOkTx4eN5Jg>
    <xmx:3qSoZiG83ynROWFt1N9BsS3JioxW3bqokH13CPK6jqt5a-gW1p0-EA>
    <xmx:3qSoZuZfvEBkL05K5QpRurFiMbcx2aoTdGEDs64GUNEFBQ2DyCY7Hy1h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c0add6b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:29:56 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 03/10] fsck: rename objects-related fsck error
 functions
Message-ID: <Zqik2RCfA6MAzzXx@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYkP5YiISbMrrN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gx0kDvM/thu7FGmC"
Content-Disposition: inline
In-Reply-To: <ZqeYkP5YiISbMrrN@ArchLinux>


--gx0kDvM/thu7FGmC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 09:26:40PM +0800, shejialuo wrote:
> The names of objects-related fsck error functions are general. It's OK

s/general/generic, I guess.

> when there is only object database check. However, we have introduced
> refs database check report function. To avoid ambiguity, rename
> object-related fsck error functions to explicitly indicate these
> functions are used to report objects-related messages.

I agree that it is sensible to rename the functions to make it more
explicit that they are only used by the object-checking infrastructure.

Patrick

--gx0kDvM/thu7FGmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopNgACgkQVbJhu7ck
PpRhixAAjeYrDDYJiCif7KJIIgOtKxHDHcXPQWxUGwy54QVLXWeAspWlGXa3ED3S
q1PgS/3dQeUyHGxAH4uoXEoy8Eov+3u2SkJeSsAD1a3mKAEw/yi6Y5VEddic+bFg
mw+DZjejyC6GbNnh283ZzkVHr5c0k0J4NLLNGpR245OR4fhuoeKlDhaltkpGET8n
DdDqPd1gUC7KADAwwpYxPkNGtFwdaLEUpNMVK2HsZF3a9Rz7lQAEwRKvREubFUm9
wqqGaawi03Lcyruxn+DbBmH1xNZ+d7P81WziL6pZlRCokmP721+YNmDAOwDhLmn+
3or3i4ZR9ootEBeYmg3ZAAuuYUbaI0G/Tf+Cngeo7DrUCIXSN5LtqjmEH70/wnED
aes66HloGG5wR19HhpJNnotyWTmPr4PmY0uhht2b6CqqN4uKYdVcqo4wiMk7GHLI
OBf0vFYZOAs+/K1sl/gPxs+cXhOmPxniwOsPiru6yHp378fXGrh7uIfw6dJqwmDR
28x4uwjGGnQJBFIirtr4AC4asWMAG0y+Y7SRRgOD0+RrvnwYBfeBAxI5Wt2H3wAJ
pkJyy2Koix3KmRDI1U7XHC63m7cF/slrUcKU3nkocKQLucWxVKj7QnfqdvMML7xW
szn4Y+lPFXY/+kyJ4ht0qq+G1tASnIdFkl7RKuRq7ITMVqVE0xk=
=D59Z
-----END PGP SIGNATURE-----

--gx0kDvM/thu7FGmC--
