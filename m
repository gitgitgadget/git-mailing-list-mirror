Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C1149C4F
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595677; cv=none; b=K8KCWkof30U34AGzQzRRGeL8vLRBjmduDQxcWxNA2wQd0FH5dQAPh5SCzCNmle4ePFS+6XaynUmBanzr4nMi8yymyj8+/fOnlHBgagVYvenAsrnkQbxZLaXXv0yRUN1J4FTBWy1NGz4TZe/xIZ3OgUFbjxM2ZoLP378YrcvVGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595677; c=relaxed/simple;
	bh=B/B7ZzPSG+KGH6KslA12R2tXAmoHlqCRRma9qXi3VTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QriBD90XhJ+rjOiKQolCD0tkC6y0pb5+LRi0nn9eDMD1Dj+OOaGcMPj4mLo0pmMyu3CXagDsVBLytqqWp5Ts8iBbsKKEZIAMOZfVE6qaYtiAhRkoQcTbPWVS7Vlw5FgPXlmKZ1LOic6GQP5yOgkGUlPj4SduQEQow+2Gq+84tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DZU/+m8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OL3zCDAa; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DZU/+m8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OL3zCDAa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id D6D111C000F3;
	Mon, 13 May 2024 06:21:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 13 May 2024 06:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595674; x=1715682074; bh=B/B7ZzPSG+
	KGH6KslA12R2tXAmoHlqCRRma9qXi3VTc=; b=DZU/+m8fuXLoYdrm3yXtH0G2uS
	SoJdDKYtmTMt6e54jiLp2JKw95BOGgNDsJnVmyusr2Yh7Prj9YTyYdVDui7g0zX+
	Dkz5VQmjN4FzHLTMqqRfrSqpPtTDL771PdktXHTOy10Wm5tOY1M7wAAO9TH9GbQA
	zGDP2dEyC+4IjHezq2KThW30gT3V5nm76us4mApWzsTFVkzXM4apVT4kF5UP8hvC
	hK3P5QfqDFWEhPiOzUZpwupno+T7+4Udz07OMnsmBvQn2kwSkAV2zncp7wziXYN+
	zjeCFZfEe0Fl6EIsdzDQR8EzDNPmnmMvokKIz2z/CGDuRAvg0LIlZLm45bsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595674; x=1715682074; bh=B/B7ZzPSG+KGH6KslA12R2tXAmoH
	lqCRRma9qXi3VTc=; b=OL3zCDAa4acekk0v1Mwod+HRTFi5h5zFjh9Za4oyO2bw
	qZbxQLhWFLl7vvNoP3q0kf/AmFW2RuaVBrZjqi2S1H6GFdOOJZD3a+vwtGJIvRwE
	7dT3iCv8XJVh86q0U9SMwUKVdkafXVz8k0Y3+k1TDvmk0/ledjWXbBJgo6juK8YN
	FIZFvnLxbO2zb7hxckhk2cxmw/OeEGhvMsSk3wME4khs0LdyThEitA9C7hqrLrA7
	5ORx7g7nsWmeNT7QiKu1cG0rRQcXAT8RskYEefR+Rdt2TTYkyj35Pt5wvmt+npjv
	OYv1fHW7IS8so4r4ghDby1jOKyJf/Pz1+4lxEYMd6Q==
X-ME-Sender: <xms:mulBZo9XwEhGL_OzCDrP4HsnRyGIMhXRDQok6U6yjKumtFlx0hGJiQ>
    <xme:mulBZgveWcraM2g10gJ8sC8S_cFf96MA49l_2Am-1RvTSleQQwOlD-lJ3gpE6yA_L
    4f_Sxc8n4-WkWX68A>
X-ME-Received: <xmr:mulBZuDERRlp2QXN1ru_6nlQ-zNBHr9ItXZiEcReMIlDYINsHrvO_MqKFpHf2YLJnWk6C-POUHz5KIXBiF8gjOuPb3uvIglUGNJT_9843tUA0rU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mulBZod_-XT9bEfGgcOTKE_z7CY3zDEroaLb3tSpnw3g1TT65DoQRQ>
    <xmx:mulBZtNahtWOb49hs3oryU1wHIlTjNVZXuYaT0Y26PQtGpTmLh-_3Q>
    <xmx:mulBZinaONU2oVW02d3A4R6g_nky2sZyL5ueSCxXizRqAjWbGdhm5A>
    <xmx:mulBZvtKn_vUm4WD5nxu2qTgqfzXnXstAAWCmPe2m-zOTU8VGO_6Rw>
    <xmx:mulBZmbPBOOTTEvu0b9puXK4KM6O0N6gCI2YsU8UJ2NpRHmLs87vyevf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:21:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9bbebb24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:20:54 +0000 (UTC)
Date: Mon, 13 May 2024 12:21:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/21] builtin/config: check for writeability after
 source is set up
Message-ID: <ZkHplkpUfySw_hUn@tanuki>
References: <cover.1715339393.git.ps@pks.im>
 <edfd7caa39ab990faf5b49a6c572a612a35dbdd5.1715339393.git.ps@pks.im>
 <CAO_smVhahWTvH4ycDGoRd2WeUnbNs=8Ukq5L17gRYn9kdE-zjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eDwD2+uAtdcMRt7O"
Content-Disposition: inline
In-Reply-To: <CAO_smVhahWTvH4ycDGoRd2WeUnbNs=8Ukq5L17gRYn9kdE-zjA@mail.gmail.com>


--eDwD2+uAtdcMRt7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 01:46:43PM -0700, Kyle Lippincott wrote:
> On Fri, May 10, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > The `check_write()` function verifies that we do not try to write to a
> > config source that cannot be written to, like for example stdin. But
> > while the new subcommands do call this function, they do so before
> > calling `handle_config_location()`. Consequently, we only end up
> > checking the default config location for writeability, not the location
> > that was actually specified by the caller of git-config(1).
> >
> > Fix this by calling `check_write()` after `handle_config_location()`. We
> > will further clarify the relationship between those two functions in a
> > subsequent commit where we remove the global state that both implicitly
> > rely on.
>=20
> Minor nit/question since I'm still pretty inexperienced w/ the project no=
rms:
> Since this is a bug fix/behavior change, can we reorder the series so
> this comes before (or after) the rest of the cleanups? I'm assuming
> this fix would be something that could stand alone in its own series
> even if we weren't making the other changes.

Yeah, it can indeed stand on its own. The reason why I moved it into the
middle of the series is so that the subsequent patch will immediately
refactor the reason why this bug was able to sneak in, namely the
implicit dependency on a global variable. I thus lean towards keeping
the order as-is, also because the patch itself can be cleanly
cherry-picked on top of ps/config-subcommands regardless of the order.

Patrick

--eDwD2+uAtdcMRt7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6ZUACgkQVbJhu7ck
PpTCEBAAlmJXBUJ+GZa8XSlc8frQPnvgnpTeqI03nqO7nEk8IkxM5gtKlobopPHv
eiGZsdwSIA8d9T7sG6zER1NYYyUF4n/D3vXj/MEEZjn6WMak797/dwTOgDjRxJx0
p2JJs5H0O0WxGFLDA6XaXZE3qFs2Rp0OcM5WIrXY2JxBHGRttShY7VbnDnKn0LjH
uplgyhrove0uVSOc4h7Er/7lLmqHrgjXdJ/fxzGwwYbWgSdrwzr6NoZSKBTZmsU4
umHxGpmVrhBxr7IURAN2rLsvp5L8JJ76Jk6P1CoTXhUnqYdenejxMIXFpHuHDpY0
IU4RymVHIeYIhbvvI4Nde7zmyPFO6fpSw8YG0sCF63uB9l84p7qIoYm0frC0XuS2
aOIRmcTFbjn0lolkko3fdSqCMo3hlsWNcbt26ybzf8y7I5UmsV9opAPaW5opMeV6
pe1NpQByNsZmABQ9olybaj6+dLRWniaOPZOqo1PXVK+PI3Wnj22E3kWA3t7clGoz
z32+r0UtHycu4lRMSc7O1//ypiLw0fIMeNn+GtA3t4FBHNmfhRX3m2pG2dfKN5Q2
cE3P5rsQSobKp/Hw0fYDyJ2s++xheDdwsr52EXRoP/zwUWK+8ZmDZjOxJicpfFSl
ZYGk5oennlFTw0bhL4LxiVQzmzrFWA+YBztKxjml8HALAxh31FM=
=RQ6g
-----END PGP SIGNATURE-----

--eDwD2+uAtdcMRt7O--
