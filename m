Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAA14F9EA
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316374; cv=none; b=GKHLb+LgOJhQBypADrhpsexij1jhlUU3CYw8a5IqDCo+zLPVzojxh4yhF+2vZNWfQWXcJ7/jHzn+v/Fjm63G2j7uC1/xIwQClBKLCH0zzEz08dv4KMfCPeY48E/hstq4w3jxiXa4o7i/+y1OS5HeFEDC311DjdwKg6pIwB3RBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316374; c=relaxed/simple;
	bh=vseN8vGX4t+EEbJf91PilnSD76f4npLeRHehPflsKOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoBhjniLpUEEFalpKVfVT48yE5YohdewNww/Zj97cmIjqPr+2KvJcbvk/AxXCTpKxzEabGgSIhj45z0hwufoyS1zVTnKebJELEkQSgIQVqQajKhpPHmHsTttNLoI41+8HXsZYC/PzAcW1EkYxzMJm35AcAr/FLZeNlvloJYZvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eMNl5UhY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dueGNvu0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eMNl5UhY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dueGNvu0"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 63020114041A;
	Tue, 30 Jul 2024 01:12:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 01:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316371; x=1722402771; bh=1HCz4ulhzj
	pmJtvMaRmCZjUO+FmcaWLom3wLTwWHkMc=; b=eMNl5UhYMyl4MsYXSNGAOiSQPc
	tJKWrCHnpzhjMl4gHfI0oyK18/3jVaPrYysa5JsGHIzgQahdh02tqQxwEXfmRQGL
	lc2u+cQeAMVPAebqwIq6dQYzins8jvS4JPiyc63E38FJKuEhkubl5y2tSdx55CAD
	lXw8MOhYQV6J1CDSp2qwxWU5U/rWDnuygaEDRs0kc1Miw7hz9K9cS8ufyjxhSQVI
	Itn623xc0Wso5b8yG9xpXhx9LzQ1MJgJUjyEJhr/c+dDAZ0b/FkwRPi3NXo86Kkq
	0GMiYCU6qxUolEWL8n0O2W1kOx1dHPB45zUVIqaVG19fMp2rdpjTyoJ2hNQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316371; x=1722402771; bh=1HCz4ulhzjpmJtvMaRmCZjUO+Fmc
	aWLom3wLTwWHkMc=; b=dueGNvu0512MlZBsepu5aNYDNl1+i+8gAgaw6jJitHFg
	boOa2xDTcakP22Ets0YYoRoSOGWfN511Y4fXfgNZTeEyGtFidQylPEjjJjEgRppz
	05Bgy6Ihx+tx3dBY3a3W0inLQxWA/Z63VCNy1/h+6qOBk7kfsOEpOYH5tjy9u9Qw
	9PMPW3dxDwkeDOozSx5/xYQEy+vq1x3OQicml59gcMJfmVHGB/Dd53kGI4q+WF5P
	eXRE8m7LOU+YL0Fk8wuYeBIgQXPJ4Kru2gVoqBVGiex1HSzaNWVnNTN16X64jPRr
	NlXf2knr32BFwz7szk/nkJKc2rY8uYFL5B8UJBl4uQ==
X-ME-Sender: <xms:U3aoZinTJtqmZgOQkQtEI9H6790iO8LEgXnvR3ddYGtGl40wB0e8Fg>
    <xme:U3aoZp3aAER3lIexSFUEyiDYM8Oyn9zw-8jS91cLUdJIxLsYgO9WV8eSnl_9xhBcm
    UeK57Vfmlxqu9pr7Q>
X-ME-Received: <xmr:U3aoZgp74l4sWzEEiL_SlUYb_60E2u3Hfu2oDjpfozVXu7Ph0rvuSPSucrkatI2vBnyUjCWBEz0uaf3tRYKOowjCG9J-cTJkLMEns1essiDN5gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:U3aoZmnLFD8rAu7B_r_KtVSH68E8bFSjEzrVqQOpu-aEtnX2_Dl_pA>
    <xmx:U3aoZg22qlmDOX4OgyioQ4yTSH8UtzFrqMtmQUyVR0H62MB_PurNYQ>
    <xmx:U3aoZtvNISjNLHmracUbdLQbAGSNGxG_uA3rIF4Exa1Zrx0iz0s5hw>
    <xmx:U3aoZsX52Jd3JwbZKTnI-UtlyR3-Pb9eH2qI28xEhSkIL3eHDnij7A>
    <xmx:U3aoZuCXv7VKFuXtPNDGgQCEX0i_6eC7xOtz4gmj6rTPpxvxhG0TUGeR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 01:12:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c974ec28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 05:11:23 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:12:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Tighten patch header parsing in patch-id
Message-ID: <Zqh2T_2RLt0SeKF7@tanuki>
References: <20240621231826.3280338-1-gitster@pobox.com>
 <20240730011738.4032377-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MquDXWkPgSGExHTA"
Content-Disposition: inline
In-Reply-To: <20240730011738.4032377-1-gitster@pobox.com>


--MquDXWkPgSGExHTA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 06:17:33PM -0700, Junio C Hamano wrote:
>     Updates from v1
>=20
>      - changed flag bits used internally from CPP macro to enum and
>        added a bit of comments.

The changes look like what I expected, so this series looks good to me
overall. Thanks!

Patrick

--MquDXWkPgSGExHTA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaodk4ACgkQVbJhu7ck
PpRq2RAAoBNGLIpLOa+t3HEAqUom2UbQDDNcoDZzZ4AR5JsZYVb37X2+Ceph5Low
C0eadp7XttS5kp9aI6MpEeKZiIApZH+b0m/DPd40jyImm0jd9At+jkWxNVTUlM0m
So5hwpJblhyceVW6uhaWZs+WjGqa5W7CtoYFNUyBDZyWBS7/6jeNQqNgTtF7XIke
4zqLRIkUquayUSL3Rwp3zCtrj8zvRJAiNLZpzRNSUIu/a1qXWZf4H4cauPjtjsay
ZWoCNochLheH1fFQcIbzmsgt9ysQ5QBmHIm4kTWQ1BRClDhp8ChyJbQZcHgX9rRX
fBGTxnZoqjdmH7bWinqIVfJbbRxe47YHttW3MB9+HVgjYTJNxKk9WkQJXEuIxbaP
qVfEKU3tQnFdVaILSj3bDur8+MQsu5C7BxmY25KcYUd4vZXEzvBJB/8Wgvu7GrsF
t0tnAm9NDaKt0u1OCE4FGgEbKGPYCaoI3LUuCldfjN0CRx2h/liBfw34EjcqqRPs
KBRKMuKfrOX2om+aE9l4EkXlmPBIWzOJiqkFlgkV03MOEewb94QOyEeMeXDVr1K5
4wAAoWdlGngzKfOjb0LqWRSWnpZMerm2rBcef79MMTvr4gCz2Vm3fXFgGhaoEhL4
Laigj8mlNfsXVpGVZ+eMV/RWrmnJR4Kum4BZVfkArpBuaDYQNuw=
=RBr1
-----END PGP SIGNATURE-----

--MquDXWkPgSGExHTA--
